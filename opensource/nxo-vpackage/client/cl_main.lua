local Config = require'shared.config'
local Objects = {}
local QBCore = exports['qb-core']:GetCoreObject()
local Seats = {
    'seat_pside_f',
    'seat_dside_r',
    'seat_pside_r'
}

local function GetValidSeats(entity)
    local count = 0
    for i = 1, #Seats do
        if GetEntityBoneIndexByName(entity, Seats[i]) ~= -1 then
            count += 1
        end
    end
    return count
end

lib.callback.register('aj-veh-package:client:ValidateVehicle', function(vNetID)
    local entity = lib.waitFor(function()
        if NetworkDoesEntityExistWithNetworkId(vNetID) then return NetworkGetEntityFromNetworkId(vNetID) end
    end, 'Failed to get vehicle NetworkID', 5000)
    if not entity then return false end
    local validSeats = GetValidSeats(entity)
    if validSeats == 0 then
        -- lib.print.error(string.format('Vehicle "%s" failed to generare any valid seats!', GetEntityArchetypeName(entity)))
        return false
    end
    local selectedSeat = Seats[math.random(1, validSeats)]
    local boneID = GetEntityBoneIndexByName(entity, selectedSeat)
    if boneID == 0 or not boneID then
        return false
    end
    return true, boneID
end)

AddStateBagChangeHandler('loadPackage', nil, function(bagName, key, value, reserved, replicated)
    if replicated then return end
    if not value then return end
    local vehicle = lib.waitFor(function()
        local e = GetEntityFromStateBagName(bagName)
        if e > 0 and DoesEntityExist(e) then
            return e
        end
    end)
    if not vehicle then return end

    lib.requestModel(value.model)
    local coords = GetEntityCoords(vehicle)
    local package = CreateObjectNoOffset(value.model, coords.x, coords.y, coords.z - 5, false, true, false)
    SetModelAsNoLongerNeeded(value.model)
    if Config.debug then
        SetEntityDrawOutline(package, true)
        SetEntityDrawOutlineShader(1)
    end
    SetDisableFragDamage(package, true)
    SetEntityCollision(package, false, false)
    SetEntityNoCollisionEntity(package, vehicle, false)
    ---@diagnostic disable-next-line: redundant-parameter
    AttachEntityToEntity(package, vehicle, value.boneID, 0.0, 0.0, 0.0, 0.0, 0.0, value.rotation, 0.0, false, false, false, false, 2, true, false)
    Objects[package] = true
    CreateThread(function()
        while DoesEntityExist(vehicle) do
            local state = Entity(vehicle).state
            if not state.hasPackage then
                break
            end
            Wait(1000)
        end
        DeleteEntity(package)
        Objects[package] = nil
    end)
end)
local playercooldown=0
lib.onCache('vehicle', function(veh)
    if not veh then return end
    if Entity(veh).state.hasPackage then
        Wait(0)
        exports['qb-core']:DrawText("Pickup Pakage", 'left', 'E') 
        while cache.vehicle do
            Wait(0)
            if IsControlJustPressed(0, 38) then --E
                if playercooldown>=4 then
                    QBCore.Functions.Notify('Not Allowed this time...!','error')
                    exports['qb-core']:HideText()
                    break  
                end
                playercooldown=playercooldown+1
                cooldown()
                if math.random(1,100)<70 then
                    exports['qb-dispatch']:vehpakage()
                end
                local success=exports['nxo-MiniGames']:alphabet(math.random(10,15),8000)
                if success then
                    TriggerServerEvent('aj-veh-package:server:SearchedPackage')
                    break
                end
            end
        end
        exports['qb-core']:HideText()
    end
end)

function cooldown()
 if playercooldown>=4 then
    CreateThread(function()
        Wait(60*30*1000) 
        playercooldown=0
    end)
 end
end
AddEventHandler('onResourceStop', function(r)
    if cache.resource ~= r then return end
    for object in pairs(Objects) do
        DeleteEntity(object)
    end
end)