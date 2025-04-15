local QBCore = exports['qb-core']:GetCoreObject()
local VehicleSpawn1 = vector4(768.7522, 1280.348, 359.90, 179.7)
local VehicleSpawn2 = vector4(15.90565, 6279.126, 30.853, 298.7)
local VehicleSpawn3 = vector4(1903.700, 4921.541, 48.413, 158.3)
local VehicleSpawn4 = vector4(-2353.44, 268.9400, 165.27, 23.40)
local VehicleSpawn5 = vector4(190.2997, 304.6820, 105.03, 4.573)
local VehicleSpawn6 = vector4(431.4668, 6467.442, 28.372, 229.5)
local VehicleSpawn7 = vector4(519.0736, 168.9908, 98.976, 252.4)
local VehicleSpawn8 = vector4(-2173.57, 4271.536, 48.574, 330.3)
local VehicleSpawn9 = vector4(2491.183, 4964.211, 44.295, 315.5)
local DeliverBlip = nil
local TruckBlip = nil
local TruckRobBlip = nil
local transport = nil
local VehicleCoords = nil
local DeliverCoords = nil
local CurrentCops = 0
local BlipStart = false
local satate = false
local showHelp = false
local PlayerJob = {}

AddEventHandler("onResourceStart", function(resourceName)
	if ("qb-truckescort" == resourceName) then
        Wait(1000)
		QBCore.Functions.GetPlayerData(function(PlayerData)
			PlayerJob = PlayerData.job
		end)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    PlayerJob.onduty = duty
end)

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

RegisterNetEvent('qb-truckescort:UseCard', function()
	if CurrentCops >= 8 then
		if exports['qb-cooldown']:isCooldown() then
			exports["glow_minigames"]:StartMinigame(function(success)
				if exports['qb-cooldown']:isCooldown() then
					TriggerServerEvent("QBCore:Server:RemoveItem", "cardg", 1)
					TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["cardg"], "remove")
					if success then
						TriggerServerEvent('qb-cooldown:server:startglobaltimeout', 60)
						startRob()
					end
				end
			end, "path", {gridSize = 15, lives = 2, timeLimit = 10000})
		end
	else
		QBCore.Functions.Notify('Police is not enough in City', 'error')
	end
end)

function startRob()
	local DrawCoord = math.random(1,9)
	local chanci = math.random(1,5)
	if DrawCoord == 1 then
		VehicleCoords = VehicleSpawn1
		if chanci == 1 then
			DeliverCoords = VehicleSpawn2
		elseif chanci == 2 then
			DeliverCoords = VehicleSpawn3
		elseif chanci == 3 then
			DeliverCoords = VehicleSpawn4
		elseif chanci == 4 then
			DeliverCoords = VehicleSpawn8
		elseif chanci == 5 then
			DeliverCoords = VehicleSpawn9
		else
			DeliverCoords = VehicleSpawn9
		end
	elseif DrawCoord == 2 then
		VehicleCoords = VehicleSpawn2
		if chanci == 1 then
			DeliverCoords = VehicleSpawn1
		elseif chanci == 2 then
			DeliverCoords = VehicleSpawn3
		elseif chanci == 3 then
			DeliverCoords = VehicleSpawn4
		elseif chanci == 4 then
			DeliverCoords = VehicleSpawn5
		elseif chanci == 5 then
			DeliverCoords = VehicleSpawn7
		else
			DeliverCoords = VehicleSpawn7
		end
	elseif DrawCoord == 3 then
		VehicleCoords = VehicleSpawn3
		if chanci == 1 then
			DeliverCoords = VehicleSpawn1
		elseif chanci == 2 then
			DeliverCoords = VehicleSpawn4
		elseif chanci == 3 then
			DeliverCoords = VehicleSpawn5
		elseif chanci == 4 then
			DeliverCoords = VehicleSpawn7
		elseif chanci == 5 then
			DeliverCoords = VehicleSpawn8
		else
			DeliverCoords = VehicleSpawn8
		end
	elseif DrawCoord == 4 then
		VehicleCoords = VehicleSpawn4
		if chanci == 1 then
			DeliverCoords = VehicleSpawn1
		elseif chanci == 2 then
			DeliverCoords = VehicleSpawn2
		elseif chanci == 3 then
			DeliverCoords = VehicleSpawn3
		elseif chanci == 4 then
			DeliverCoords = VehicleSpawn6
		elseif chanci == 5 then
			DeliverCoords = VehicleSpawn8
		else
			DeliverCoords = VehicleSpawn8
		end
	elseif DrawCoord == 5 then
		VehicleCoords = VehicleSpawn5
		if chanci == 1 then
			DeliverCoords = VehicleSpawn2
		elseif chanci == 2 then
			DeliverCoords = VehicleSpawn3
		elseif chanci == 3 then
			DeliverCoords = VehicleSpawn6
		elseif chanci == 4 then
			DeliverCoords = VehicleSpawn8
		elseif chanci == 5 then
			DeliverCoords = VehicleSpawn9
		else
			DeliverCoords = VehicleSpawn9
		end
	elseif DrawCoord == 6 then
		VehicleCoords = VehicleSpawn6
		if chanci == 1 then
			DeliverCoords = VehicleSpawn1
		elseif chanci == 2 then
			DeliverCoords = VehicleSpawn3
		elseif chanci == 3 then
			DeliverCoords = VehicleSpawn4
		elseif chanci == 4 then
			DeliverCoords = VehicleSpawn5
		elseif chanci == 5 then
			DeliverCoords = VehicleSpawn7
		else
			DeliverCoords = VehicleSpawn7
		end
	elseif DrawCoord == 7 then
		VehicleCoords = VehicleSpawn7
		if chanci == 1 then
			DeliverCoords = VehicleSpawn3
		elseif chanci == 2 then
			DeliverCoords = VehicleSpawn4
		elseif chanci == 3 then
			DeliverCoords = VehicleSpawn6
		elseif chanci == 4 then
			DeliverCoords = VehicleSpawn8
		elseif chanci == 5 then
			DeliverCoords = VehicleSpawn9
		else
			DeliverCoords = VehicleSpawn9
		end
	elseif DrawCoord == 8 then
		VehicleCoords = VehicleSpawn8
		if chanci == 1 then
			DeliverCoords = VehicleSpawn1
		elseif chanci == 2 then
			DeliverCoords = VehicleSpawn3
		elseif chanci == 3 then
			DeliverCoords = VehicleSpawn5
		elseif chanci == 4 then
			DeliverCoords = VehicleSpawn7
		elseif chanci == 5 then
			DeliverCoords = VehicleSpawn9
		else
			DeliverCoords = VehicleSpawn9
		end
	elseif DrawCoord == 9 then
		VehicleCoords = VehicleSpawn9
		if chanci == 1 then
			DeliverCoords = VehicleSpawn1
		elseif chanci == 2 then
			DeliverCoords = VehicleSpawn4
		elseif chanci == 3 then
			DeliverCoords = VehicleSpawn5
		elseif chanci == 4 then
			DeliverCoords = VehicleSpawn7
		elseif chanci == 5 then
			DeliverCoords = VehicleSpawn8
		else
			DeliverCoords = VehicleSpawn8
		end
	end

	SetNewWaypoint(VehicleCoords.x, VehicleCoords.y)
	TruckBlip = AddBlipForCoord(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z)
	SetBlipSprite(TruckBlip, 67)
	SetBlipColour(TruckBlip, 1)
	SetBlipFlashes(TruckBlip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Money Truck')
	EndTextCommandSetBlipName(TruckBlip)
	TriggerEvent("qb-truckescort:WaitforCar")
	TriggerServerEvent('qb-phone:server:sendNewMail', {
		sender = "Mamad Mamadi",
		subject = "#BC-1801",
		message = "A truck blip has been added to your GPS , Go and Deliver the truck to Marked GPS in truck! Stay In the Drivers Seat! ",
		button = {}
	})
	satate = true
	Mani()
end

RegisterNetEvent('qb-truckescort:WaitforCar', function()
	while true do
        Wait(5)
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		if #(pos - vector3(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z)) < 50 then
			if not transport then
				ClearAreaOfVehicles(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, 15.0, false, false, false, false, false)
				RequestModel(GetHashKey('stockade'))
				while not HasModelLoaded(GetHashKey('stockade')) do
					Wait(0)
				end
				transport = CreateVehicle(GetHashKey('stockade'), VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, VehicleCoords.w, true, true)
				SetVehicleEngineOn(transport, false, false)
				SetEntityAsMissionEntity(transport)
			end
			if vehicle == transport then
				RemoveBlip(TruckBlip)
				if GetIsVehicleEngineRunning(transport) then
					DeliveryPoint()
					BlipStart = true
					TriggerServerEvent('qb-truckescort:server:checkForStart')
					exports['qb-dispatch']:TruckRobbery()
					BlipStartPD()
					break
				end
			end
		end
	end
end)

function DeliveryPoint()
	DeliverBlip = AddBlipForCoord(DeliverCoords.x, DeliverCoords.y, DeliverCoords.z)
	SetBlipSprite(DeliverBlip, 440)
	SetBlipColour(DeliverBlip, 5)
	SetBlipFlashes(DeliverBlip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Deliver Point')
	EndTextCommandSetBlipName(DeliverBlip)
end

function Mani()
	CreateThread(function()
		while satate do
			Wait(500)
			local ped = PlayerPedId()
			if IsPedInAnyVehicle and GetVehiclePedIsIn(ped, false) == transport then
				local distance = #(GetEntityCoords(ped) - vector3(DeliverCoords.x, DeliverCoords.y, DeliverCoords.z))
				if distance < 6 then
					if not showHelp then
						showHelp = true
						exports['qb-core']:DrawText('Deliver', 'left', 'E')
					end
				else
					RemoveHelp()
				end
			else
				RemoveHelp()
			end
		end
		RemoveHelp()
	end)
end

function RemoveHelp()
	if showHelp then
		showHelp = false
		exports['qb-core']:HideText()			
	end
end

RegisterNetEvent('qb-truckescort:timeover', function()
	if satate then
		satate = false
		BlipStart = false
		RemoveHelp()
		RemoveBlip(DeliverBlip)
		TriggerServerEvent("qb-truckescort:server:BlipofSerfanJahatOff", false)
		QBCore.Functions.Notify('Time Over for Truck Robbery', 'error')
	end
end)

AddEventHandler('onKeyDown', function(key)
	if key == 'e' and showHelp then
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) and GetVehiclePedIsIn(ped, false) == transport and satate then
			satate = false
			BlipStart = false
			RemoveHelp()
			RemoveBlip(DeliverBlip)
			TaskLeaveVehicle(ped, transport, 0)
			TriggerServerEvent("qb-truckescort:server:BlipofSerfanJahatOff", false)
			TriggerServerEvent("qb-truckescort:server:GetReward")
		end
	end
end)

function BlipStartPD()
	CreateThread(function()
		while BlipStart do
			local vehCoords = GetEntityCoords(transport)
			TriggerServerEvent("qb-truckescort:server:BlipofSerfanJahatOff", true, vehCoords)
			Wait(5000)
		end
	end)
end

RegisterNetEvent('qb-truckescort:SendBlips', function(toggle, mashin)
	if toggle then
		if LocalPlayer.state.isLoggedIn and (PlayerJob.name == "police" or PlayerJob.name == "justice") and PlayerJob.onduty then
			if TruckRobBlip ~= nil then
				RemoveBlip(TruckRobBlip)
			end
			TruckRobBlip = AddBlipForCoord(mashin.x, mashin.y, mashin.z)
			SetBlipSprite(TruckRobBlip, 67)
			SetBlipColour(TruckRobBlip, 1)
			SetBlipFlashes(TruckRobBlip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Truck Escort')
			EndTextCommandSetBlipName(TruckRobBlip)
		else
			if TruckRobBlip ~= nil then
				RemoveBlip(TruckRobBlip)
			end
		end
	else
		if TruckRobBlip ~= nil then
			RemoveBlip(TruckRobBlip)
		end
	end
end)