local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-fakeplate:client:use', function(plate, slot)
    local vehicle, dist =  QBCore.Functions.GetClosestVehicle()
    if DoesEntityExist(vehicle) and dist <= 3.5 and not IsPedInAnyVehicle(PlayerPedId(), false) then
        QBCore.Functions.Progressbar("installFakePlate", "Installing Fake Plate..", math.random(5000, 10000), false, true,
            {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
            anim = 'machinic_loop_mechandplayer',
            flags = 1,
        }, {}, {}, function()
            StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
            local oldPlate = GetVehicleNumberPlateText(vehicle)
            Wait(200)
            SetVehicleNumberPlateText(vehicle, plate)
            TriggerServerEvent("qb-fakeplate:server:done", plate, oldPlate, slot)
            if exports['qb-vehiclekeys']:HasKeys(oldPlate) then
                TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
            end
        end, function()
            StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
            QBCore.Functions.Notify("Canceled", 'error')
        end)
    end
end)

RegisterNetEvent('qb-fakeplate:client:remove', function()
    local vehicle, dist =  QBCore.Functions.GetClosestVehicle()
    if DoesEntityExist(vehicle) and dist <= 3.5 and not IsPedInAnyVehicle(PlayerPedId(), false) then
        QBCore.Functions.TriggerCallback('qb-fakeplate:cb:remove', function(data)
            if data.bool then
                QBCore.Functions.Progressbar("removeFakePlate", "Removing Fake Plate..", math.random(5000, 10000), false, true,
                    {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                    anim = 'machinic_loop_mechandplayer',
                    flags = 1,
                }, {}, {}, function()
                    StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                    local oldPlate = GetVehicleNumberPlateText(vehicle)
                    Wait(200)
                    SetVehicleNumberPlateText(vehicle, data.plate)
                    TriggerServerEvent("qb-fakeplate:server:remove", oldPlate)
                    if exports['qb-vehiclekeys']:HasKeys(oldPlate) then
                        TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', data.plate)
                    end
                end, function()
                    StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                    QBCore.Functions.Notify("Canceled", 'error')
                end)
            end
        end, GetVehicleNumberPlateText(vehicle))
    end
end)