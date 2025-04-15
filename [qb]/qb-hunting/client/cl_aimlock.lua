local hasHuntingRifle = false
local isFreeAiming = false
local blockShotActive = false

local sniperRifles = {
    "WEAPON_SNIPERRIFLE",
    "WEAPON_HEAVYSNIPER",
    "WEAPON_MARKSMANRIFLE"
}

local huntingCoords = vector3(-973.44, 4424.14, 18.16)
local huntingRadius = 4000.0

local function processScope(freeAiming)
    isFreeAiming = freeAiming
end

local function blockShooting()
    if blockShotActive then return end
    blockShotActive = true
    Citizen.CreateThread(function()
        while hasHuntingRifle do
            local ply = PlayerId()
            local ped = PlayerPedId()
            local aiming, ent = GetEntityPlayerIsFreeAimingAt(ply)
            local freeAiming = IsPlayerFreeAiming(ply)
            processScope(freeAiming)
            local et = GetEntityType(ent)
            
            if freeAiming and IsPedAPlayer(ent) then
                SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
                DisablePlayerFiring(ped, true)
            elseif not freeAiming or et == 2 or (et == 1 and IsPedInAnyVehicle(ent)) then
                DisableControlAction(0, 24, true)
                DisableControlAction(0, 47, true)
                DisableControlAction(0, 58, true)
                DisablePlayerFiring(ped, true)
            end
            
            Citizen.Wait(0)
        end
        blockShotActive = false
        processScope(false)
    end)
end

local function restrictWeaponUsage()
    Citizen.CreateThread(function()
        while true do
            local ped = PlayerPedId()
            local pedCoords = GetEntityCoords(ped)
            local bolgede = #(pedCoords - huntingCoords) < huntingRadius
            local currentWeapon = GetSelectedPedWeapon(ped)

            for _, weapon in pairs(sniperRifles) do
                if currentWeapon == GetHashKey(weapon) then
                    if not bolgede then
                        SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
                        NOTIFY(Config.Languages["cant_equip_out_of_zone"])
                    else
                        hasHuntingRifle = true
                        blockShooting()
                    end
                    break
                end
            end

            Citizen.Wait(100)
        end
    end)
end

CreateThread(function()
    local zoneblip = AddBlipForRadius(huntingCoords.x, huntingCoords.y, huntingCoords.z, huntingRadius)
    SetBlipSprite(zoneblip, 1)
    SetBlipColour(zoneblip, 62)
    SetBlipAlpha(zoneblip, 75)
    
    local blip = AddBlipForCoord(huntingCoords.x, huntingCoords.y, huntingCoords.z)
    SetBlipSprite(blip, 141)
    SetBlipScale(blip, 0.7)
    SetBlipDisplay(blip, 4)
    SetBlipColour(blip, 3)
    SetBlipAsShortRange(blip, true)
    
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Hunting Area')
    EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
    restrictWeaponUsage()
end)

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        
        local bolgede = #(pedCoords - huntingCoords) < huntingRadius

        if IsPedArmed(ped, 4) then
            if not bolgede then
                for _, weapon in pairs(sniperRifles) do
                    local currentWeapon = GetSelectedPedWeapon(ped)
                    if currentWeapon == GetHashKey(weapon) then
                        DisablePlayerFiring(ped, true)
                        if IsControlJustReleased(0, 329) then
                            if GetAmmoInPedWeapon(ped, currentWeapon) > 0 then
                                NOTIFY(Config.Languages["cant_shoot_out_of_zone"])
                            else
                                NOTIFY(Config.Languages["refill_ammo_in_zone"])
                            end
                        end
                    end
                end
            end
        end
        
        Citizen.Wait(100)
    end
end)
