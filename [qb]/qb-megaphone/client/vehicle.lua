local EnableMegaPhone = false

AddEventHandler('onKeyDown', function(key)
    if key == 'grave' then
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            local vehModel = GetEntityModel(veh)
            if Config.EnableMegaphoneVehicles[vehModel] then
                local driver = GetPedInVehicleSeat(veh, -1)
                local passenger = GetPedInVehicleSeat(veh, 0)
                if driver == PlayerPedId() or passenger == PlayerPedId() then
                    EnableMegaPhone = true
                    TriggerServerEvent("qb-megaphone:server:addSubmix")
                    exports["pma-voice"]:overrideProximityRange(15.0, true)
                    TriggerEvent('qb-megaphone:client:statevoice', true)
                    CreateThread(function()
                        while EnableMegaPhone and IsPedInAnyVehicle(PlayerPedId(), false) do
                            Wait(4)
                            SetControlNormal(0, 249, 1.0)
                            SetControlNormal(1, 249, 1.0)
                            SetControlNormal(2, 249, 1.0)
                        end
                        exports["pma-voice"]:clearProximityOverride()
                        TriggerServerEvent("qb-megaphone:server:removeSubmix")
                        TriggerEvent('qb-megaphone:client:statevoice', false)
                    end)
                end
            end
        end
    end
end)

AddEventHandler('onKeyUP', function(key)
    if key == 'grave' and EnableMegaPhone then
        EnableMegaPhone = false
    end
end)