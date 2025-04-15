local QBCore = exports['qb-core']:GetCoreObject()
local KeysList = {}
local GiveKeyRadial = nil
local Lockpicking = false
local openingDoor = false
local NoLockVehicles = {}
local BlackListLockPick = {
    [GetHashKey('lp770r')] = true,
    [GetHashKey('gsx1000')] = true,
}

CreateThread(function()
    DecorRegister('VEHICLE_LOCKPIECKED_ENGINE', 2)
    while true do
        if LocalPlayer.state.isLoggedIn then
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped, true) then
                local veh = GetVehiclePedIsIn(ped)
                if GetPedInVehicleSeat(veh, -1) == ped then
                    local plate = GetVehicleNumberPlateText(veh)
                    if not HasKeys(plate) and not HasLockpicked(veh) then
                        if not GetIsVehicleEngineRunning(veh) or GetVehicleAlarmTimeLeft(veh) > 0 then
                            SetVehicleEngineOn(veh, false, false, true)
                        end
                    else
                        Wait(1000)
                    end
                end
            else
                Wait(500)
            end
        end
        Wait(0)
    end
end)

function DeadOrCuffed()
    local playerId = GetPlayerServerId(PlayerId())
    if Player(playerId).state['isDead'] or Player(playerId).state['isCuffed'] then
        return true
    else
        return false
    end
end

function HasLockpicked(veh)
    return DecorGetBool(veh, 'VEHICLE_LOCKPIECKED_ENGINE')
end

function isBlacklistedVehicle(vehicle)
    local isBlacklisted = false
    for _,v in ipairs(NoLockVehicles) do
        if GetHashKey(v) == GetEntityModel(vehicle) then
            isBlacklisted = true
            break
        end
    end
    if GetVehicleClass(vehicle) == 13 then isBlacklisted = true end
    return isBlacklisted
end

AddEventHandler('onKeyDown', function(key)
    if key == 'l' then
        ToggleVehicleLocks(GetVehicle())
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    GetKeys()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    KeysList = {}
end)

RegisterNetEvent('qb-vehiclekeys:client:AddKeys', function(plate)
    KeysList[plate] = true
end)

RegisterNetEvent('qb-vehiclekeys:client:RemoveKeys', function(plate)
    KeysList[plate] = nil
end)

AddEventHandler('onKeyDown', function(key)
    if key == 'iom_wheel_up' then
        if exports['yseries']:IsOpen() then return end
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if vehicle == 0 or GetPedInVehicleSeat(vehicle, -1) ~= PlayerPedId() then return end
        if exports["qb-fuel"]:GetFuel(vehicle) <= 0 then return end
        SetVehicleEngineOn(vehicle, true, false, true)
    elseif key == 'iom_wheel_down' then
        if exports['yseries']:IsOpen() then return end
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if vehicle == 0 or GetPedInVehicleSeat(vehicle, -1) ~= PlayerPedId() then return end
        SetVehicleEngineOn(vehicle, false, false, true)
    end
end)

AddEventHandler('qb-vehiclekeys:client:setLastPickedVehicle', function(vehicle)
    lastPickedVehicle = vehicle
end)

AddEventHandler('onKeyDown', function(key)
    if key == 'f' then
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, true)
        if IsPedInAnyVehicle(ped, false) and GetPedInVehicleSeat(veh, -1) == ped and not DeadOrCuffed() and not IsPauseMenuActive() then
            local engineWasRunning = GetIsVehicleEngineRunning(veh)
            Wait(1000)
            if engineWasRunning then
                SetVehicleEngineOn(veh, true, true, true)
            end
        end
    end
end)

RegisterNetEvent('qb-vehiclekeys:client:GiveKeys', function(id)
    if DeadOrCuffed() then QBCore.Functions.Notify("You Can't do right now", 'error') return end
    local targetVehicle = GetVehicle()
    if targetVehicle then
        local targetPlate = QBCore.Functions.GetPlate(targetVehicle)
        if HasKeys(targetPlate) then
            if id ~= nil then
                GiveKeys(id, targetPlate)
            else
                if IsPedSittingInVehicle(PlayerPedId(), targetVehicle) then
                    local pedInSeat = GetPedInVehicleSeat(targetVehicle, -1)
                    if IsPedAPlayer(pedInSeat) and pedInSeat ~= PlayerPedId() then
                        TriggerServerEvent('qb-vehiclekeys:server:GiveVehicleKeys', GetPlayerServerId(NetworkGetPlayerIndexFromPed(pedInSeat)), targetPlate)
                    end
                else
                    local player, distance = QBCore.Functions.GetClosestPlayer()
                    if player ~= -1 and distance < 3.5 then
                        GiveKeys(GetPlayerServerId(player), targetPlate)
                    end
                end
            end
        else
            QBCore.Functions.Notify("You don't have keys to this vehicle.", 'error')
        end
    end
end)


RegisterNetEvent('vehiclekeys:client:SetOwner', function(plate)
    TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
end)

RegisterNetEvent('lockpicks:UseLockpick', function(isAdvanced, slot)
    print("Run Lockpick")
    if (IsPedInAnyVehicle(PlayerPedId())) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId() then
        veh=QBCore.Functions.GetClosestVehicle()
        if veh and not isAdvanced then
             local model = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
             if GetVehicleType(veh) ~= 'boat' then 
             if QBCore.Shared.Vehicles[string.lower(model)] then
                  vehclass=QBCore.Shared.Vehicles[string.lower(model)].class
                 if ((vehclass=='s' or vehclass=='x') and not isAdvanced) then
                       QBCore.Functions.Notify("this item is not suitable for this car class", 'error')
                      return      
                  end

                else
                    QBCore.Functions.Notify("this item is not suitable for this car class", 'error')
                    return 
            end
          end
        end
        LockpickIgnition(isAdvanced, slot)
    else
        if not HasKeys(QBCore.Functions.GetPlate(QBCore.Functions.GetClosestVehicle())) then
            LockpickDoor(isAdvanced, slot)
        end
    end
end)

RegisterNetEvent('hack:UseHackingDevice', function(slot)
    if (IsPedInAnyVehicle(PlayerPedId())) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId() then
        HackIgnition(slot)
    end
end)

RegisterNetEvent('qb-radialmenu:client:onRadialmenuOpen', function()
    local ped = PlayerPedId()
    local veh, dist =  QBCore.Functions.GetClosestVehicle()
    if (veh and dist <= 2.5) or IsPedInAnyVehicle(ped) then
        if not GiveKeyRadial then
            GiveKeyRadial = exports['qb-radialmenu']:AddOption({
                id = 'givekey',
                title = 'Give Key',
                icon = '#givekey',
                functiontype = 'command',
                functionName = 'givekeys',
                shouldClose = false
            }, GiveKeyRadial)
        end
    else
        if GiveKeyRadial then
            exports['qb-radialmenu']:RemoveOption(GiveKeyRadial)
            GiveKeyRadial = nil
        end
    end
end)

function GiveKeys(id, plate)
    local distance = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(id))))
    if distance < 1.5 and distance > 0.0 then
        TriggerServerEvent('qb-vehiclekeys:server:GiveVehicleKeys', id, plate)
    else
        QBCore.Functions.Notify('There is nobody nearby to hand keys to.','error')
    end
end

function GetKeys()
    QBCore.Functions.TriggerCallback('qb-vehiclekeys:server:GetVehicleKeys', function(keysList)
        KeysList = keysList
    end)
end

function HasKeys(plate)
    return KeysList[plate]
end exports('HasKeys', HasKeys)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(0)
    end
end

function GetVehicleInDirection(coordFromOffset, coordToOffset)
    local ped = PlayerPedId()
    local coordFrom = GetOffsetFromEntityInWorldCoords(ped, coordFromOffset.x, coordFromOffset.y, coordFromOffset.z)
    local coordTo = GetOffsetFromEntityInWorldCoords(ped, coordToOffset.x, coordToOffset.y, coordToOffset.z)

    local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
    local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
    return vehicle
end

function GetVehicle()
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        return GetVehiclePedIsIn(PlayerPedId())
    else
        local vehicle, dist =  QBCore.Functions.GetClosestVehicle()
        if DoesEntityExist(vehicle) and dist <= 3.5 then
            return vehicle
        end
    end
end

function ToggleVehicleLocks(veh)
    if veh then
        if not isBlacklistedVehicle(veh) then
            if HasKeys(QBCore.Functions.GetPlate(veh)) then
                local ped = PlayerPedId()
                local vehLockStatus = GetVehicleDoorLockStatus(veh)

                loadAnimDict("anim@mp_player_intmenu@key_fob@")
                TaskPlayAnim(ped, 'anim@mp_player_intmenu@key_fob@', 'fob_click', 3.0, 3.0, -1, 49, 0, false, false, false)

                TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "lock", 0.4)

                NetworkRequestControlOfEntity(veh)
                if vehLockStatus == 1 then
                    TriggerServerEvent('qb-vehiclekeys:server:setVehLockState', NetworkGetNetworkIdFromEntity(veh), 2)
                    QBCore.Functions.Notify("Vehicle locked!")
                else
                    TriggerServerEvent('qb-vehiclekeys:server:setVehLockState', NetworkGetNetworkIdFromEntity(veh), 1)
                    QBCore.Functions.Notify("Vehicle unlocked!", "success")
                end

                SetVehicleLights(veh, 2)
                Wait(250)
                SetVehicleLights(veh, 1)
                Wait(200)
                SetVehicleLights(veh, 0)
                Wait(300)
                ClearPedTasks(ped)
            else
                QBCore.Functions.Notify("You don't have keys to this vehicle.", 'error')
            end
        else
            TriggerServerEvent('qb-vehiclekeys:server:setVehLockState', NetworkGetNetworkIdFromEntity(veh), 1)
        end
    end
end

function LockpickDoor(isAdvanced, slot)
    local vehicle = QBCore.Functions.GetClosestVehicle()
    if vehicle ~= nil and vehicle ~= 0 then
        local vehpos = GetEntityCoords(vehicle)
        local pos = GetEntityCoords(PlayerPedId())
        if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, vehpos.x, vehpos.y, vehpos.z, true) < 1.5 then
            local vehLockStatus = GetVehicleDoorLockStatus(vehicle)
            if (vehLockStatus > 1) then
                local state = Entity(vehicle).state
                if state.boosting and state.class and not state.lockpick then
                    TriggerEvent("QBCore:Notify", 'You need a professional system to lockpick this vehicle!', 'error')
                    return
                end

                if BlackListLockPick[GetEntityModel(vehicle)] then return end
                local lockpickTime = math.random(10000, 20000)
                if isAdvanced then
                    lockpickTime = math.ceil(lockpickTime*0.5)
                end
                if math.random(1, 100) > 40 then
                    SetVehicleAlarm(vehicle, true)
                    SetVehicleAlarmTimeLeft(vehicle, lockpickTime)
                end
                LockpickDoorAnim()
                QBCore.Functions.Progressbar("lockpick_vehicledoor", "breaking the door open.", lockpickTime, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function()
                    local success = exports['nxo-MiniGames']:lockpicking(12,4,20000)
                    if success then
                        TriggerServerEvent("qb-log:server:CreateLog", "lockpick", "Lockpick Door", "red", "**".. QBCore.Functions.GetPlayerData().charinfo.firstname..' '..QBCore.Functions.GetPlayerData().charinfo.lastname .. " (citizenid: *"..QBCore.Functions.GetPlayerData().citizenid.."* ) \n Car: **"..  GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
                        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "unlock", 0.3)
                        TriggerServerEvent('qb-vehiclekeys:server:setVehLockState', NetworkGetNetworkIdFromEntity(vehicle), 1)
                        if not isAdvanced then
                            TriggerServerEvent("inventory:server:breakItem", "lockpick", 4, slot)
                        else
                            TriggerServerEvent("inventory:server:breakItem", "advancedlockpick", 3, slot)
                        end
                    else
                        if isAdvanced then
                            TriggerServerEvent("inventory:server:breakItem", "advancedlockpick", 3, slot)
                        else
                            TriggerServerEvent("inventory:server:breakItem", "lockpick", 3, slot)
                        end
                    end
                    openingDoor = false
                end, function()
                    openingDoor = false
                end)
            end
        end
    end
end

function LockpickDoorAnim()
    loadAnimDict("veh@break_in@0h@p_m_one@")
    TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds" ,3.0, 3.0, -1, 16, 0, false, false, false)
    openingDoor = true
    CreateThread(function()
        while openingDoor do
            TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Wait(1000)
        end
        StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
    end)
end

function LockpickIgnition(isAdvanced, slot)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
    for k,v in pairs(QBCore.Shared.Vehicles) do
        if v.hash == GetEntityModel(vehicle) then
            if v.category == 'police' or v.category == 'ambulance' or v.category == 'jobsheli' or v.category == 'special' then
                return
            end
        end
    end
    if not HasKeys(QBCore.Functions.GetPlate(vehicle)) and not HasLockpicked(vehicle) and not Lockpicking then
        if BlackListLockPick[GetEntityModel(vehicle)] then return end
        Lockpicking = true
        LockpickAnim()
        
        local success = exports['nxo-MiniGames']:lockpicking(12,4,20000)
        
        if success then
            TriggerServerEvent("qb-log:server:CreateLog", "lockpick", "Lockpick Car", "blue", "**".. QBCore.Functions.GetPlayerData().charinfo.firstname..' '..QBCore.Functions.GetPlayerData().charinfo.lastname .. " (citizenid: *"..QBCore.Functions.GetPlayerData().citizenid.."* ) \n Car: **"..  GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
            TriggerEvent('qb-vehiclekeys:client:AddKeys', QBCore.Functions.GetPlate(vehicle))
            if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
                DecorSetBool(vehicle, 'VEHICLE_LOCKPIECKED_ENGINE', true)
            end
            if isAdvanced then
                TriggerServerEvent("inventory:server:breakItem", "advancedlockpick", 4, slot)
            else
                TriggerServerEvent("inventory:server:breakItem", "lockpick", 4, slot)
                TriggerServerEvent('hud:server:GainStress', math.random(1, 3))
            end
        else
            if isAdvanced then
                TriggerServerEvent("inventory:server:breakItem", "advancedlockpick", 6, slot)
            else
                TriggerServerEvent("inventory:server:breakItem", "lockpick", 6, slot)
            end
            TriggerServerEvent('hud:server:GainStress', math.random(3, 6))
        end
        Lockpicking = false
    end
end

function HackIgnition(slot)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
    local canHack = false
    for k,v in pairs(QBCore.Shared.Vehicles) do
        if v.hash == GetEntityModel(vehicle) then
            if v.category == 'police' or v.category == 'ambulance' or v.category == 'jobsheli' or v.category == 'special' then
                canHack = true
                break
            end
        end
    end
    if canHack and not HasKeys(QBCore.Functions.GetPlate(vehicle)) and not HasLockpicked(vehicle) and not Lockpicking then
        if BlackListLockPick[GetEntityModel(vehicle)] then return end
        Lockpicking = true
        LockpickAnim()
        exports['qb-dispatch']:VehicleTheft(vehicle)
        local types = {'alphabet', 'numeric', 'alphanumeric'}
        exports['ps-ui']:Scrambler(function(success)
            if success then
                TriggerServerEvent("inventory:server:breakItem", "hacking_device", 50, slot)
                if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
                    DecorSetBool(vehicle, 'VEHICLE_LOCKPIECKED_ENGINE', true)
                end
                TriggerServerEvent('hud:server:GainStress', math.random(1, 2))
            else
                TriggerServerEvent("inventory:server:breakItem", "hacking_device", 100, slot)
                TriggerServerEvent('hud:server:GainStress', math.random(3, 6))
            end
            Lockpicking = false
        end, types[math.random(1, #types)], 10, 0)
    end
end

function LockpickAnim()
    loadAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
    TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, -8.0, -1, 16, 0, false, false, false)
    CreateThread(function()
        while Lockpicking do
            if not IsEntityPlayingAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 0) then
                TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, -8.0, -1, 16, 0, false, false, false)
            end
            Wait(500)
        end
        StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
    end)
end