-- Variables
QBCore = exports['qb-core']:GetCoreObject()
isHandcuffed = false
isEscorted = false
PlayerJob = QBCore.Functions.GetPlayerData().job
onDuty = false
local currenCops = 0
local DutyBlips = {}
local blipsColor = {
    ['police'] = 3,
    ['ambulance'] = 1,
    ['justice'] = 9,
    ['marshal'] = 31,
}

function getpolicestation()
	return Config.policestation,0.032
end
exports("getpolicestation",getpolicestation)

-- Functions
local function CreateDutyBlips(playerSource, playerLabel, playerJob, playerGrade, playerLocation, playerBlip)
    local playerId = GetPlayerFromServerId(playerSource)
    local ped = GetPlayerPed(playerId)
    local blip = GetBlipFromEntity(ped)
    if not DoesBlipExist(blip) then
        if NetworkIsPlayerActive(playerId) then
            blip = AddBlipForEntity(ped)
        else
            blip = AddBlipForCoord(playerLocation.x, playerLocation.y, playerLocation.z)
        end
        SetBlipSprite(blip, playerBlip)
        SetBlipFlashes(blip, false)
        ShowHeightOnBlip(blip, false)
        ShowHeadingIndicatorOnBlip(blip, true)
        SetBlipRotation(blip, math.ceil(playerLocation.w))
        if playerBlip == 164 then
            SetBlipScale(blip, 0.85)
        else
            SetBlipScale(blip, 0.7)
        end
        SetBlipCategory(blip, 7)
        if blipsColor[playerJob] then
            SetBlipColour(blip, blipsColor[playerJob])
        elseif playerBlip == 164 then
            SetBlipColour(blip, 66)
        else
            SetBlipColour(blip, 0)
        end
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(playerLabel)
        EndTextCommandSetBlipName(blip)
        DutyBlips[#DutyBlips+1] = blip
    end
    if GetBlipFromEntity(PlayerPedId()) == blip then
        RemoveBlip(blip)
    end
end


RegisterNetEvent('police:checkplate', function(model,tex)
  local vehclass=""
  local model = GetDisplayNameFromVehicleModel(model)
        if QBCore.Shared.Vehicles[string.lower(model)] then
             vehclass=QBCore.Shared.Vehicles[string.lower(model)].model..' ( '..string.upper(QBCore.Shared.Vehicles[string.lower(model)].class).." )"
        end
    TriggerEvent('chatMessage','Check Plate', 'police', 'Model(Class):'..vehclass..tex, 'DISPATCH')
end)

-- Events

RegisterNetEvent('police:SetCopCount', function(num,numhigh)
    currenCops = num
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    local player = QBCore.Functions.GetPlayerData()
    PlayerJob = player.job
    onDuty = player.job.onduty
    isHandcuffed = player.metadata["ishandcuffed"]
    Player(GetPlayerServerId(PlayerId())).state:set("isCuffed", isHandcuffed, true)
    if isHandcuffed then
        DoCuffWhile()
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    isHandcuffed = false
    Player(GetPlayerServerId(PlayerId())).state:set("isCuffed", false, true)
    isEscorted = false
    onDuty = false
    ClearPedTasks(PlayerPedId())
    DetachEntity(PlayerPedId(), true, false)
    if DutyBlips then
        for _, v in pairs(DutyBlips) do
            RemoveBlip(v)
        end
        DutyBlips = {}
    end
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = JobInfo.onduty
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

RegisterNetEvent('police:client:sendBillingMail', function(amount)
    SetTimeout(math.random(2500, 4000), function()
        local gender = Lang:t('info.mr')
        if QBCore.Functions.GetPlayerData().charinfo.gender == 1 then
            gender = Lang:t('info.mrs')
        end
        local charinfo = QBCore.Functions.GetPlayerData().charinfo
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = Lang:t('email.sender'),
            subject = Lang:t('email.subject'),
            message = Lang:t('email.message', {value = gender, value2 = charinfo.lastname, value3 = amount}),
            button = {}
        })
    end)
end)

RegisterNetEvent('police:client:UpdateBlips', function(players)
    if PlayerJob and (PlayerJob.name == 'police' or PlayerJob.name == 'ambulance' or PlayerJob.name == 'justice') and onDuty then
        if DutyBlips then
            for _, v in pairs(DutyBlips) do
                RemoveBlip(v)
            end
        end
        DutyBlips = {}
        if players then
            for _, data in pairs(players) do
                CreateDutyBlips(data.source, data.label, data.job, data.grade, data.location, data.blip)
            end
        end
    else
        if DutyBlips then
            for _, v in pairs(DutyBlips) do
                RemoveBlip(v)
            end
        end
        DutyBlips = {}
    end
end)

-- Threads
CreateThread(function()
    for _, station in pairs(Config.Locations["stations"]) do
        local blip = AddBlipForCoord(station.coords.x, station.coords.y, station.coords.z)
        SetBlipSprite(blip, 60)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, station.color)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(station.label)
        EndTextCommandSetBlipName(blip)
    end
    for k, v in pairs(Config.Locations["boat"]) do
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, 410)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 0.6)
        SetBlipColour(blip, 3)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Police Boat Station')
        EndTextCommandSetBlipName(blip)
    end
end)

RegisterNetEvent('police:client:openstashSafe', function()
    local ped = PlayerPedId()
    if IsPedSittingInAnyVehicle(ped) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        if GetVehicleClass(vehicle) == 18 then
            TriggerServerEvent("inventory:server:OpenInventory", "stash", "gunrack_"..QBCore.Functions.GetPlate(vehicle), {maxweight = 50000, slots = 8})
        else
            QBCore.Functions.Notify('This Vehicle Is Not Police Vehicle!', 'error')
        end
    else
        QBCore.Functions.Notify('You Are Not in vehicle!', 'error')
    end
end)

RegisterNetEvent('qb-policejob:client:dispatchEffect', function()
    PlaySoundFrontend(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
end)

RegisterNetEvent('qb-policejob:client:cdispatch', function(coords)
    PlaySoundFrontend(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    CreateThread(function()
        local alpha = 255
        local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(blip, 409)
        SetBlipDisplay(blip, 2)
        SetBlipScale(blip, 1.0)
        SetBlipColour(blip, 51)
        SetBlipAsShortRange(blip, false)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('CentralDispatch')
        EndTextCommandSetBlipName(blip)
        Wait(50000)
        while alpha ~= 0 do
            Citizen.Wait(20 * 6)
            alpha = alpha - 1
            SetBlipAlpha(blip, alpha)
            if alpha == 0 then
                RemoveBlip(blip)
                break
            end
        end
    end)
end)



RegisterNetEvent('qb-police:client:checkvin', function ()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    if vehicle ~= 0 then
        local vehPos = GetEntityCoords(vehicle)
        local PlayerPos = GetEntityCoords(PlayerPedId())
        if #(PlayerPos - vehPos) <= 5.0 then
            local networkID = NetworkGetNetworkIdFromEntity(vehicle)
            if GetVehicleDoorLockStatus(vehicle) == 1 then
                QBCore.Functions.Progressbar('check_vin', 'Checking VIN Number', 6000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = '"anim@amb@clubhouse@tutorial@bkr_tut_ig3@"@',
                    anim = 'machinic_loop_mechandplayer',
                    flags = 16,
                }, {}, {}, function() 
                    QBCore.Functions.TriggerCallback('qb-police:server:checkvin', function(isVin)
                        if isVin then
                            QBCore.Functions.Notify("Seems like the VIN got scratched!", "success")
                        else
                            QBCore.Functions.Notify("Hmm you can't found the VIN", "error")
                        end
                    end, networkID)
                    ClearPedTasks(PlayerPedId())
                end, function()
                    ClearPedTasks(PlayerPedId())
                end)
            else
                QBCore.Functions.Notify("The vehicle is locked", "error")
            end
        else
            QBCore.Functions.Notify("No vehicle nearby", "error")
        end
    end
end)

RegisterNetEvent('police:client:getkey', function()
    local ped = PlayerPedId()
    if IsPedSittingInAnyVehicle(ped) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        if GetVehicleClass(vehicle) == 18 then
            TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', QBCore.Functions.GetPlate(vehicle))
        else
            QBCore.Functions.Notify('This Vehicle Is Not Police Vehicle!', 'error')
        end
    else
        QBCore.Functions.Notify('You Are Not in vehicle!', 'error')
    end
end)

RegisterCommand('outfits', function()
    local job = QBCore.Functions.GetPlayerData().job.name
    if job == 'police' or job == 'justice' or job == 'ambulance' then
        local vehicle, vDist = QBCore.Functions.GetClosestVehicle()
        if vehicle ~= 0 and vehicle ~= nil and GetVehicleClass(vehicle) == 18 then
            local trunk = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "boot"))
            local trunkExist = not ((trunk == vector3(0, 0, 0)) or IsVehicleDoorDamaged(vehicle, 5))
            if #(GetEntityCoords(PlayerPedId()) - trunk) <= 2.0 then
                if GetVehicleDoorLockStatus(vehicle) < 2 then
                    local ratio = GetVehicleDoorAngleRatio(vehicle, 5)
                    if trunkExist and ratio > 0 then
                        TriggerEvent('lvs_clothing:client:openOutfit')
                        return
                    end
                end
            end
        end
    end
end)
TriggerEvent('chat:addSuggestion', '/outfits', 'Open Outfits Menu')