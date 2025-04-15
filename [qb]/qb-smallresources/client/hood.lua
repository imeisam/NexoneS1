RegisterCommand("hood", function()
	if IsPedSittingInAnyVehicle(PlayerPedId()) then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
            if GetVehicleDoorAngleRatio(vehicle, 4) > 0.0 then
                SetVehicleDoorShut(vehicle, 4, false)
            else
                SetVehicleDoorOpen(vehicle, 4, false)
            end
        end
	end
end)
TriggerEvent('chat:addSuggestion', '/hood', 'Open/Close Hood')