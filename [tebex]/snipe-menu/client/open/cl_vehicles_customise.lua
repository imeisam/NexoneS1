function BennyOpen()
    if Config.Core == "QBCore" then
        TriggerServerEvent("snipe-menu:server:toggleBennys")
    elseif Config.Core == "ESX" then
        exports["esx_lscustom"]:GetAction({value = 'main'})
    end
end


function GiveKeys(plate)
    if Config.Keys == "qb" then
        TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
    elseif Config.Keys == "cd" then
        TriggerEvent('cd_garage:AddKeys', plate)
    else
        print("Snipe-Menu: You have selected other key system. Configure the event properly")
    end
end


function MaxModVehicle(vehicle)
    SetVehicleModKit(vehicle, 0)
    SetVehicleMod(vehicle, 11, 3, false)--engine
    SetVehicleMod(vehicle, 12, 2, false)--brakes
    SetVehicleMod(vehicle, 13, 2, false)--transmission
    SetVehicleMod(vehicle, 15, 2, false)--suspension
    SetVehicleMod(vehicle, 16, 4, false)--armor
    ToggleVehicleMod(vehicle,  18, true)--turbo
    SetVehicleFixed(vehicle)
end

function SpawnCar(carName, maxMods, seatVehicle)
    if IsModelInCdimage(carName) then
        QBCore.Functions.SpawnVehicle(carName, function(vehicle)
            if seatVehicle then
                TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                SendNUIMessage({
                    action = "forceClose"
                })
            end
            GiveKeys(QBCore.Functions.GetPlate(vehicle))
            TriggerServerEvent("snipe-menu:server:sendLogs", "triggered", "Spawned a " .. carName)
            if maxMods then
                Wait(100)
                MaxModVehicle(vehicle)
            end
        end, GetEntityCoords(PlayerPedId()), true, false)
    else
        print("Invalid model name")
    end
end

RegisterNetEvent("snipe-menu:client:FixVehicle", function()
    if hasAdminPerms then
        TriggerEvent('iens:repaira')
    else
        TriggerServerEvent("snipe-menu:server:sendLogs", "exploit", Config.Locales["fix_vehicle_exploit_event"])
    end
end)

RegisterNetEvent("snipe-menu:client:changePlate", function(newPlate)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    SetVehicleNumberPlateText(vehicle, newPlate)
    GiveKeys(newPlate)
end)

RegisterNetEvent("snipe-menu:client:refuelVehicle", function()
    if hasAdminPerms then 
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)
        if vehicle ~= 0 then
            -- exports["LegacyFuel"]:SetFuel(vehicle, 100.0)
            if Config.Fuel == "legacy" then
                exports["LegacyFuel"]:SetFuel(vehicle, 100.0)
            elseif Config.Fuel == "ps" then
                exports["qb-fuel"]:SetFuel(vehicle, 100.0)
            elseif Config.Fuel == "ox" then
                Entity(vehicle).state.fuel = 100.0
            elseif Config.Fuel == "cdn" then
                exports["cdn-fuel"]:SetFuel(vehicle, 100.0)
            elseif Config.Fuel == "other" then
                -- change it to your fuel script if you have one
                SetVehicleFuelLevel(vehicle, 100.0)
            else
                print("Invalid fuel script")
            end
            -- change it to your fuel script if you have one
        end
    end
end)