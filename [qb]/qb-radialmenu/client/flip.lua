local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-vehicle:client:flip', function()
    if IsPedInAnyVehicle(PlayerPedId(), false) then return end
    local Vehicle = QBCore.Functions.GetClosestVehicle()
    if Vehicle ~= 0 then
        if #(GetEntityCoords(Vehicle) - GetEntityCoords(PlayerPedId())) < 5.0 then
            if IsVehicleOnAllWheels(Vehicle) then QBCore.Functions.Notify("The vehicle is already up", "error") return end
            QBCore.Functions.Progressbar("flip-vehicle", "Flippin the freaking car..", math.random(10000, 15000), false, true, {
                disableMovement = true,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "random@mugging4",
                anim = "struggle_loop_b_thief",
                flags = 49,
            }, {}, {}, function()
                local carCoords = GetEntityRotation(Vehicle, 2)
                SetEntityRotation(Vehicle, carCoords[1], 0, carCoords[3], 2, true)
                SetVehicleOnGroundProperly(Vehicle)
            end, function()
                QBCore.Functions.Notify("Cancelled..", "error")
            end)
        else
            QBCore.Functions.Notify("You Are Far..", "error")
        end
    else
        QBCore.Functions.Notify("No vehicle found..", "error")
    end
end)