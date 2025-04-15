local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
	for _, v in pairs(QBCore.Shared.Vehicles) do
		local text
		if v["brand"] then
			text = v["brand"] .. " " .. v["name"]
		else
			text = v["name"]
		end
		if v['hash'] ~= 0 and v['hash'] ~= nil then
			AddTextEntryByHash(v["hash"],text)
		end
	end
end)


RegisterNetEvent('baseevents:enteringVehicle', function( vehicleIsTryingToEnter, seat, class, model)
	local driver = GetPedInVehicleSeat(vehicleIsTryingToEnter, -1)
	if  not IsPedAPlayer(driver) and driver~=0  and GetVehicleDoorLockStatus(vehicleIsTryingToEnter)==1 then
		if math.random(1,100)<50 then
			TriggerServerEvent('qb-vehiclekeys:server:setVehLockState', NetworkGetNetworkIdFromEntity(vehicleIsTryingToEnter), 2)
		else
			TriggerServerEvent('qb-vehiclekeys:server:setVehLockState', NetworkGetNetworkIdFromEntity(vehicleIsTryingToEnter), 1)
		end
	end

end)

Citizen.CreateThread(function()
	while true do
		if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId())) then  --is player entering a vehicle
			if math.random(1,100)<80 then
				SetVehicleNeedsToBeHotwired(GetVehiclePedIsTryingToEnter(PlayerPedId()), false) -- disable native hotwire
			end
		end
		Citizen.Wait(300) -- requires minimum of 1. larger number saves some performance if necessary
	end
	
end)