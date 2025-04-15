local QBCore = exports['qb-core']:GetCoreObject()
local carMenuOpen = false
local RnableRadial = nil

local function HasKey()
    if exports['qb-vehiclekeys']:HasKeys(QBCore.Functions.GetPlate(GetVehiclePedIsIn(PlayerPedId(), false))) then
        return true
    else
        return false
    end
end

RegisterNetEvent('qb-carcontrol:client:openmenu', function()
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        carMenuOpen = not carMenuOpen
        SetNuiFocus(carMenuOpen, carMenuOpen)
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        local doorData = {}
        local doorNum = GetVehicleModelNumberOfSeats(GetEntityModel(veh)) - 1
        for i = 0, doorNum do
            local opened = false
            if GetVehicleDoorAngleRatio(veh, i) > 0.0 then
                opened = true
            end
            table.insert(doorData, {
                doorNum = tostring(i),
                opened = opened
            })
        end
        local mySeat = nil
        if doorNum > 10 then
            for i = -1, doorNum do
                if GetPedInVehicleSeat(veh, i) == 0 then
                else
                    mySeat = i
                end
            end
        elseif doorNum == 1 then
            for i = -1, doorNum - 1 do
                if GetPedInVehicleSeat(veh, i) == 0 then
                else
                    mySeat = i
                end
            end
        elseif doorNum == 0 then
            for i = -1, doorNum + 1 do
                if GetPedInVehicleSeat(veh, i) == 0 then
                else
                    mySeat = i
                end
            end
        else
            for i = -1, doorNum - 2 do
                if GetPedInVehicleSeat(veh, i) == 0 then
                else
                    mySeat = i
                end
            end
        end
        local retval, lights, highbeams = GetVehicleLightsState(veh)
        local hoodOpen = false
        if GetVehicleDoorAngleRatio(veh, 4) > 0.0 then
            hoodOpen = true
        end
        local trunkOpen = false
        if GetVehicleDoorAngleRatio(veh, 5) > 0.0 then
            trunkOpen = true
        end
        local indicatorState = GetVehicleIndicatorLights(veh)
        while mySeat == nil do Citizen.Wait(0) end
        SendNUIMessage({
            action = "openCarMenu", resourceName = GetCurrentResourceName(), state = carMenuOpen, align = 'bottom-center', styleType = 'default', carData = {
                doorNum = GetVehicleModelNumberOfSeats(GetEntityModel(veh)),
                doorData = doorData,
                vehConvertible = IsVehicleAConvertible(veh, false),
                vehConvertibleState = GetConvertibleRoofState(veh),
                engineState = GetIsVehicleEngineRunning(veh),
                playerSeat = mySeat,
                intLightState = IsVehicleInteriorLightOn(veh),
                lightsOn = lights,
                highbeamsOn = highbeams,
                trunk = trunkOpen,
                hood = hoodOpen,
                indicatorState = indicatorState
            }
        })
    end
end)

RegisterCommand('ui-r', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('callback', function(data)
    if data.action == "nuiFocus" then
        carMenuOpen = false
        SetNuiFocus(false, false)
    elseif data.action == "convertVeh" then
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        if data.state == false then
            RaiseConvertibleRoof(veh, false)
        else
            LowerConvertibleRoof(veh, false)
        end
    elseif data.action == "window" then
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        local num = data.num - 1
        if data.state == true then
            RollDownWindow(veh, num)
        else
            RollUpWindow(veh, num)
        end
    elseif data.action == "changeSeat" then
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        if data.num == "driver" then
            if IsVehicleSeatFree(veh, -1) then
                SetPedIntoVehicle(PlayerPedId(), veh, -1)
            end
        else
            local num = tonumber(data.num)
            if IsVehicleSeatFree(veh, num) then
                SetPedIntoVehicle(PlayerPedId(), veh, num)
            end
        end
    elseif data.action == "engine" then
        if HasKey() then
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            if GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
                SetVehicleEngineOn(veh, data.state, false, true)
            end
        else
            TriggerEvent('QBCore:Notify', 'You do not have Key', 'error')
        end
    elseif data.action == "alarm" then
        if HasKey() then
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            SetVehicleAlarm(veh, data.state)
            if data.state == true then
                StartVehicleAlarm(veh)
                SetVehicleAlarmTimeLeft(veh, 30000)
                Citizen.Wait(30000)
                SendNUIMessage({action = "closeAlarm"})
            end
        else
            TriggerEvent('QBCore:Notify', 'Reporting your Abuse..', 'error')
        end
    elseif data.action == "intLight" then
        if HasKey() then
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            SetVehicleInteriorlight(veh, data.state)
        else
            TriggerEvent('QBCore:Notify', 'Reporting your Abuse..', 'error')
        end
    elseif data.action == "lights" then
        if HasKey() then
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            if data.name == "normal" then
                SetVehicleLights(veh, 1)
                Citizen.Wait(500)
                SetVehicleLights(veh, 3)
            elseif data.name == "highbeams" then
                SetVehicleLights(veh, 1)
                Citizen.Wait(500)
                SetVehicleLights(veh, 3)
                SetVehicleFullbeam(veh, true)
            end
        else
            TriggerEvent('QBCore:Notify', 'Reporting your Abuse..', 'error')
        end
    elseif data.action == "door" then
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        if data.state == true then
            -- print(data.number)
            if data.number == "trunk" then
                SetVehicleDoorOpen(veh, 5, false, false)
            elseif data.number == "hood" then
                SetVehicleDoorOpen(veh, 4, false, false)
            else
                SetVehicleDoorOpen(veh, tonumber(data.number), false, false)
            end
        else
            if data.number == "trunk" then
                SetVehicleDoorShut(veh, 5, false)
            elseif data.number == "hood" then
                SetVehicleDoorShut(veh, 4, false)
            else
                SetVehicleDoorShut(veh, tonumber(data.number), false)
            end
        end
    elseif data.action == "indicator" then
        if HasKey() then
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            SetVehicleIndicatorLights(veh, data.name, data.state)
        else
            TriggerEvent('QBCore:Notify', 'Reporting your Abuse..', 'error')
        end
    end
end)
local extra

local VehicleExtras = {
    id = 'vehicleextras',
    title = 'Vehicle Extras',
    icon = '#wrench',
    items = {
        {
            id = 'extra1',
            title = 'Extra 1',
            icon = '#wrench',
            functiontype = 'client',
            functionName = 'qb-radialmenu:client:setExtra',
            shouldClose = false,
            parameters={id=1}
        }, {
            id = 'extra2',
            title = 'Extra 2',
            icon = '#wrench',
            functiontype = 'client',
            functionName = 'qb-radialmenu:client:setExtra',
            shouldClose = false,
            parameters={id=2}
        }, {
            id = 'extra3',
            title = 'Extra 3',
            icon = '#wrench',
            functiontype = 'client',
            functionName = 'qb-radialmenu:client:setExtra',
            shouldClose = false,
            parameters={id=3}
        }, {
            id = 'extra4',
            title = 'Extra 4',
            icon = '#wrench',
            functiontype = 'client',
            functionName = 'qb-radialmenu:client:setExtra',
            shouldClose = false,
            parameters={id=4}
        }, {
            id = 'extra5',
            title = 'Extra 5',
            icon = '#wrench',
            functiontype = 'client',
            functionName = 'qb-radialmenu:client:setExtra',
            shouldClose = false,
            parameters={id=5}
        }, {
            id = 'extra6',
            title = 'Extra 6',
            icon = '#wrench',
            functiontype = 'client',
            functionName = 'qb-radialmenu:client:setExtra',
            shouldClose = false,
            parameters={id=6}
        }, {
            id = 'extra7',
            title = 'Extra 7',
            icon = '#wrench',
            functiontype = 'client',
            functionName = 'qb-radialmenu:client:setExtra',
            shouldClose = false,
            parameters={id=7}
        }, {
            id = 'extra8',
            title = 'Extra 8',
            icon = '#wrench',
            functiontype = 'client',
            functionName = 'qb-radialmenu:client:setExtra',
            shouldClose = false,
            parameters={id=8}
        }, {
            id = 'extra9',
            title = 'Extra 9',
            icon = '#wrench',
            functiontype = 'client',
            functionName = 'qb-radialmenu:client:setExtra',
            shouldClose = false,
            parameters={id=9}
        }, {
            id = 'extra10',
            title = 'Extra 10',
            icon = '#wrench',
            functiontype = 'client',
            functionName = 'qb-radialmenu:client:setExtra',
            shouldClose = false,
            parameters={id=10}
        }, {
            id = 'extra11',
            title = 'Extra 11',
            icon = '#wrench',
            functiontype = 'client',
            functionName = 'qb-radialmenu:client:setExtra',
            shouldClose = false,
            parameters={id=11}
        }, {
            id = 'extra12',
            title = 'Extra 12',
            icon = '#wrench',
            functiontype = 'client',
            functionName = 'qb-radialmenu:client:setExtra',
            shouldClose = false,
            parameters={id=12}
        }, {
            id = 'extra13',
            title = 'Extra 13',
            icon = '#wrench',
            functiontype = 'client',
            functionName = 'qb-radialmenu:client:setExtra',
            shouldClose = false,
            parameters={id=13}
        }
    }
}

RegisterNetEvent('qb-radialmenu:client:setExtra', function(data)
    local extra = data.id
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)
    if veh ~= nil then
        if GetPedInVehicleSeat(veh, -1) == ped then
            SetVehicleAutoRepairDisabled(veh, true) -- Forces Auto Repair off when Toggling Extra [GTA 5 Niche Issue]
            if DoesExtraExist(veh, extra) then
                if IsVehicleExtraTurnedOn(veh, extra) then
                    SetVehicleExtra(veh, extra, 1)
                    QBCore.Functions.Notify("Extra "..extra.." has been deactivated", 'error', 2500)
                else
                    SetVehicleExtra(veh, extra, 0)
                    QBCore.Functions.Notify("Extra"..extra.." has been activated", 'success', 2500)
                end
            else
                QBCore.Functions.Notify("Extra "..extra.." is not present on this vehicle", 'error', 2500)
            end
        else
            QBCore.Functions.Notify("You're not the driver of the vehicle", 'error', 2500)
        end
    end
end)

RegisterNetEvent('qb-radialmenu:client:onRadialmenuOpen', function()
    if  IsPedInAnyVehicle(PlayerPedId(), false) then
        if not RnableRadial then
            RnableRadial = exports['qb-radialmenu']:AddOption({
                id = 'control',
                title = 'Vehicle Menu',
                icon = '#vehicle',
                functiontype = 'client',
                functionName = 'qb-carcontrol:client:openmenu',
                shouldClose = true,
            }, RnableRadial)
        end
        PlayerData = QBCore.Functions.GetPlayerData()
        if not extra and   (PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'justice') and  PlayerData.job.onduty then
            if not extr then
                extra = exports['qb-radialmenu']:AddOption(VehicleExtras, extra)
            end
           
        else
            if  extr then
                exports['qb-radialmenu']:RemoveOption(extra)
                extra = nil
            end
               
        end
    else
        if RnableRadial then
            exports['qb-radialmenu']:RemoveOption(RnableRadial)
            RnableRadial = nil
        end
        if extra then
            exports['qb-radialmenu']:RemoveOption(extra)
            extra = nil
        end
    end
end)


