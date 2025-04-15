-- Variables
local QBCore = exports['qb-core']:GetCoreObject()
local fuelSynced = false
local inBlacklisted = false
local inGasStation = false
local holdingnozzle = false
local Stations = {}
local props = {
	'prop_gas_pump_1d',
	'prop_gas_pump_1a',
	'prop_gas_pump_1b',
	'prop_gas_pump_1c',
	'prop_vintage_pump',
	'prop_gas_pump_old2',
	'prop_gas_pump_old3',
	'bzzz_pumps_stand_a',
}
local refueling = false
local Rope = nil

-- Functions
local function SendPhoneNotification(title, text, app, timeout)
    if exports.yseries then
        exports.yseries:SendNotification({
            app = app or 'qb-fuel',
            title = title or 'Notification',
            text = text or '',
            timeout = timeout or 3000,
            icon = 'fas fa-gas-pump',
            color = '#b3e0f2'
        })
    else
        QBCore.Functions.Notify(text or '', 'error')
    end
end

local function ManageFuelUsage(vehicle)
	if not DecorExistOn(vehicle, Config.FuelDecor) then
		SetFuel(vehicle, math.random(200, 800) / 10)
	elseif not fuelSynced then
		SetFuel(vehicle, GetFuel(vehicle))
		fuelSynced = true
	end
	if IsVehicleEngineOn(vehicle) then
		local currenFuel = GetVehicleFuelLevel(vehicle)
		local rpm = Round(GetVehicleCurrentRpm(vehicle), 1)
		local FuelClasses = Config.Classes[GetVehicleClass(vehicle)] or 1.0
		if currenFuel and rpm and FuelClasses then
			SetFuel(vehicle, currenFuel - rpm * FuelClasses / 10)
			SetVehicleEngineOn(veh, true, true, true)
		end
	else
		SetVehicleEngineOn(veh, true, true, true)
	end
end

local function SetBusy(state)
	if state then
		LocalPlayer.state:set("inv_busy", true, true) -- Busy
	elseif not state then
		LocalPlayer.state:set("inv_busy", false, false) -- Not Busy
	end
end

local function CanAfford(price, purchasetype)
	local purchasetype = purchasetype
	if purchasetype == "bank" then Money = QBCore.Functions.GetPlayerData().money['bank'] elseif purchasetype == 'cash' then Money = QBCore.Functions.GetCash() end
	print(Money,price)
	if Money < price then
		return false
	else
		return true
	end
end

local function GetClosestPump(coords)
	local pump = nil
	local pumpCoords
	for i = 1, #props, 1 do
		local currentPumpModel = props[i]
		pump = GetClosestObjectOfType(coords.x, coords.y, coords.z, 3.0, joaat(currentPumpModel), true, true, true)
		pumpCoords = GetEntityCoords(pump)
		if Config.FuelDebug then print("Gas Pump: ".. pump,  "Pump Coords: "..pumpCoords) end
		if pump ~= 0 then break end
	end
	return pumpCoords, pump
end

-- Thread Stuff --

CreateThread(function()
	for k = 1, #Config.GasStations do
		Stations[k] = PolyZone:Create(Config.GasStations[k].zones, {
			name = "GasStation" .. k,
			minZ = Config.GasStations[k].minz,
			maxZ = Config.GasStations[k].maxz,
			debugPoly = false
		})
		Stations[k]:onPlayerInOut(function(isPointInside)
			if isPointInside then
				inGasStation = true
			else
				inGasStation = false
			end
		end)
	end
end)

CreateThread(function()
	DecorRegister(Config.FuelDecor, 1)
	for index = 1, #Config.Blacklist do
		if type(Config.Blacklist[index]) == 'string' then
			Config.Blacklist[GetHashKey(Config.Blacklist[index])] = true
		else
			Config.Blacklist[Config.Blacklist[index]] = true
		end
	end
	for index = #Config.Blacklist, 1, -1 do
		Config.Blacklist[index] = nil
	end
	while true do
		Wait(1000)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped)
			
			if Config.Blacklist[GetEntityModel(vehicle)] then
				inBlacklisted = true
			else
				inBlacklisted = false
			end
			if GetPedInVehicleSeat(vehicle, -1) == ped then

				if iselectric(GetEntityModel(vehicle)) and  GetFuel(vehicle)<=2.0 and IsVehicleEngineOn(vehicle) then
					SetFuel(vehicle, 0)
					SetVehicleEngineOn(vehicle, false, false, false)
				end

				if GetFuel(vehicle) <= 0 and IsVehicleEngineOn(vehicle) then
					SetVehicleEngineOn(vehicle, false, false, false)
				end
				if not inBlacklisted then
					ManageFuelUsage(vehicle)
				end
			end
		else
			if fuelSynced then fuelSynced = false end
			if inBlacklisted then inBlacklisted = false end
		end
	end
end)

-- Client Events
AddEventHandler("baseevents:enteredVehicle", function(pCurrentVehicle, currentSeat)
	if currentSeat == -1 then
		if GetFuel(pCurrentVehicle) <= 0 and IsVehicleEngineOn(pCurrentVehicle) then
			SetVehicleEngineOn(pCurrentVehicle, false, false, false)
		end
	end
end)

AddEventHandler("baseevents:vehicleChangedSeat", function(pCurrentVehicle, pCurrentSeat, previousSeat)
    if pCurrentSeat == -1 then
		if GetFuel(pCurrentVehicle) <= 0 and IsVehicleEngineOn(pCurrentVehicle) then
			SetVehicleEngineOn(pCurrentVehicle, false, false, false)
		end
	end
end)

RegisterNetEvent('qb-fuel:client:grabnozzle', function()
	local ped = PlayerPedId()
	if holdingnozzle then return end
	LoadAnimDict("anim@am_hold_up@male")
    TaskPlayAnim(ped, "anim@am_hold_up@male", "shoplift_high", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
	TriggerServerEvent("InteractSound_SV:PlayOnSource", "pickupnozzle", 0.4)
    Wait(300)
	StopAnimTask(ped, "anim@am_hold_up@male", "shoplift_high", 1.0)
	fuelnozzle = CreateObject(GetHashKey('prop_cs_fuel_nozle'), 1.0, 1.0, 1.0, true, true, false)
	local lefthand = GetPedBoneIndex(ped, 18905)
	AttachEntityToEntity(fuelnozzle, ped, lefthand, 0.13, 0.04, 0.01, -42.0, -115.0, -63.42, 0, 1, 0, 1, 0, 1)
	local grabbednozzlecoords = GetEntityCoords(ped)
	local pumpCoords, pump = GetClosestPump(grabbednozzlecoords)
	RopeLoadTextures()
	while not RopeAreTexturesLoaded() do
		Wait(0)
		RopeLoadTextures()
	end
	while not pump do
		Wait(0)
	end
	Rope = AddRope(pumpCoords.x, pumpCoords.y, pumpCoords.z, 0.0, 0.0, 0.0, 3.0, 1,10.0, 0.0, 1.0, false, false, false, 1.0, true)

	while not Rope do
		Wait(0)
	end
	ActivatePhysics(Rope)
	Wait(100)
	local nozzlePos = GetEntityCoords(fuelnozzle)
	if Config.FuelDebug then print("NOZZLE POS ".. nozzlePos) end
	
	nozzlePos = GetOffsetFromEntityInWorldCoords(fuelnozzle, 0.0, -0.033, -0.195)
	local PumpHeightAdd = nil
	if Config.FuelDebug then
		print("Grabbing Hose @ Location: #"..CurrentLocation)
		if Config.GasStations[CurrentLocation].pumpheightadd ~= nil then
			PumpHeightAdd = Config.GasStations[CurrentLocation].pumpheightadd
			print("Pump Height Add: "..Config.GasStations[CurrentLocation].pumpheightadd)
		end
	end
	if PumpHeightAdd == nil then
		PumpHeightAdd = 2.1
		if Config.FuelDebug then
			print("PumpHeightAdd was not configured for location: #"..CurrentLocation.." so, we are defaulting to 2.0!")
		end
	end

	custompump={'prop_gas_pump_1d',
	'prop_gas_pump_1a',
	'prop_gas_pump_1b',
	'prop_gas_pump_1c',}
	addy=0
	for k,v in ipairs(custompump) do
		 if GetEntityModel(pump) == GetHashKey(v) then
			addy=0.5
		 end
	end
	AttachEntitiesToRope(Rope, pump, fuelnozzle, pumpCoords.x, pumpCoords.y+addy, pumpCoords.z + PumpHeightAdd - 1, nozzlePos.x, nozzlePos.y, nozzlePos.z, length, false, false, nil, nil)
	if Config.FuelDebug then
		print("Hose Properties:")
		print(Rope, pump, fuelnozzle, pumpCoords.x, pumpCoords.y, pumpCoords.z, nozzlePos.x, nozzlePos.y, nozzlePos.z, length)
		SetEntityDrawOutline(fuelnozzle --[[ Entity ]], true --[[ boolean ]])
	end
	holdingnozzle = true
	Citizen.CreateThread(function()
		while holdingnozzle do
			local currentcoords = GetEntityCoords(ped)
			local dist = #(grabbednozzlecoords - currentcoords)
			TargetCreated = true
			if dist > 7.5 then
				TargetCreated = true
				holdingnozzle = false
				DeleteObject(fuelnozzle)
				SendPhoneNotification('Nozzle Error', "The nozzle can't reach this far!", 'FUEL', 3000)
				RopeUnloadTextures()
				DeleteRope(Rope)
				if Config.FuelNozzleExplosion then
					AddExplosion(grabbednozzlecoords.x, grabbednozzlecoords.y, grabbednozzlecoords.z-1,9, 20.0, true,false, 30.0)
					AddExplosion(currentcoords.x, currentcoords.y, currentcoords.z-1,7, 20.0, true,false, 30.0)
					StartScriptFire(grabbednozzlecoords.x, grabbednozzlecoords.y, grabbednozzlecoords.z - 1,25,false)
					SetFireSpreadRate(10.0)
					Wait(10000)
					StopFireInRange(grabbednozzlecoords.x, grabbednozzlecoords.y, grabbednozzlecoords.z - 1, 3.0)
				end
			end
			Wait(2500)
		end
	end)
end)

RegisterNetEvent('qb-fuel:client:returnnozzle', function()
	holdingnozzle = false
	TargetCreated = false
	LoadAnimDict("pickup_object")
    TaskPlayAnim(ped, "pickup_object", "putdown_low", 2.0, 8.0, -1, 17, 0, 0, 0, 0)
	TriggerServerEvent("InteractSound_SV:PlayOnSource", "putbacknozzle", 0.4)
	StopAnimTask(ped, 'pickup_object', 'putdown_low', 1.0)
	Wait(250)
	DeleteObject(fuelnozzle)
	if Config.FuelDebug then print("Removing Hose.") end
	RopeUnloadTextures()
	DeleteRope(Rope)
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		RopeUnloadTextures()
		DeleteObject(Rope)
		DeleteObject(fuelnozzle)
	end
end)

RegisterNetEvent('qb-fuel:client:FinalMenu', function(purchasetype)
	local money = nil
	if purchasetype == "bank" then money = QBCore.Functions.GetPlayerData().money['bank'] elseif purchasetype == 'cash' then money = QBCore.Functions.GetCash() end
	local FuelPrice = (1 * Config.CostMultiplier)
	local vehicle = QBCore.Functions.GetClosestVehicle()
	local curfuel = GetFuel(vehicle)
	local finalfuel
	if curfuel < 10 then finalfuel = string.sub(curfuel, 1, 1) else finalfuel = string.sub(curfuel, 1, 2) end
	local maxfuel = (100 - finalfuel - 1)
	local wholetankcost = (FuelPrice * maxfuel)
	local wholetankcostwithtax = math.ceil(FuelPrice * maxfuel + GlobalTax(wholetankcost))
	local fuel = exports['qb-input']:ShowInput({
		header = "Select the Amount of Fuel<br>Current Price: $" ..
		FuelPrice .. " / Liter <br> Current Fuel: " .. finalfuel .. " Liters <br> Full Tank Cost: $" ..
		wholetankcostwithtax .. "",
		submitText = "Insert Nozzle",
		inputs = { {
			type = 'number',
			isRequired = true,
			name = 'amount',
			text = 'The Tank Can Hold ' .. maxfuel .. ' More Liters.'
		}}
	})
	if fuel then
		if not fuel.amount then return end
		if not holdingnozzle then return end
		if (fuel.amount + finalfuel) >= 100 then
			SendPhoneNotification('Fuel Error', "Your tank cannot fit this!")
		else
			if GlobalTax(fuel.amount * Config.CostMultiplier) + (fuel.amount * Config.CostMultiplier) <= money then
				local totalcost = (fuel.amount * Config.CostMultiplier)
				if totalcost < 1 then SendPhoneNotification('Fuel Error', "You can't refuel a negative amount!") return end
				local tax = GlobalTax(totalcost)
				local total = math.ceil(totalcost + tax)
				local fuelamounttotal = (totalcost / Config.CostMultiplier)
				TriggerEvent('qb-fuel:client:RefuelVehicle', purchasetype, fuelamounttotal)
			else
				SendPhoneNotification('Fuel Error', "You can't afford this!")
			end
		end
	end
end)

RegisterNetEvent('qb-fuel:client:OpenFuelMenu', function()
	local vehicle = QBCore.Functions.GetClosestVehicle()
	local CurFuel = GetVehicleFuelLevel(vehicle)
	local playercashamount = QBCore.Functions.GetCash()
	if not holdingnozzle then return end
	if CurFuel < 95 then
		exports['qb-menu']:openMenu({
			{
				header = "Gas Station",
				isMenuHeader = true,
				icon = "fas fa-gas-pump",
			},
			{
				header = "Cash",
				txt = "Pay with cash. <br> (You have: $" .. playercashamount .. ")",
				icon = "fas fa-usd",
				params = {
					event = "qb-fuel:client:FinalMenu",
					args = 'cash',
				}
			},
			{
				header = "Bank",
				txt = "Pay with card.",
				icon = "fas fa-credit-card",
				params = {
					event = "qb-fuel:client:FinalMenu",
					args = 'bank',
				}
			},
			{
				header = "Cancel",
				txt = "I actually don't want fuel anymore.",
				icon = "fas fa-times-circle",
			},
		})
	else
		QBCore.Functions.Notify('Your vehicle is already full!', 'error')
	end
end)

RegisterNetEvent('qb-fuel:client:RefuelVehicle', function(purchasetype, fuelamounttotal)
    if not purchasetype or not fuelamounttotal then
        SendPhoneNotification('Refuel Error', 'Invalid refuel data received')
        return
    end
    
    local purchasetype = purchasetype
    local amount = tonumber(fuelamounttotal)
    
    if not amount then
        SendPhoneNotification('Refuel Error', 'Invalid fuel amount')
        return
    end
    
    if not holdingnozzle then 
        SendPhoneNotification('Refuel Error', 'You need to grab the nozzle first')
        return 
    end
    
    if amount < 1 then 
        SendPhoneNotification('Refuel Error', 'Fuel amount must be greater than 0')
        return 
    end
    
    local fuelamount
    if amount < 10 then 
        fuelamount = string.sub(amount, 1, 1) 
    else 
        fuelamount = string.sub(amount, 1, 2) 
    end
    
    local refillCost = (amount * Config.CostMultiplier)
    local vehicle = QBCore.Functions.GetClosestVehicle()
    
    if not vehicle then
        SendPhoneNotification('Refuel Error', 'No vehicle found nearby')
        return
    end
    
    local ped = PlayerPedId()
    local time = amount * Config.RefuelTime
    if amount < 10 then time = 10 * Config.RefuelTime end
    local vehicleCoords = GetEntityCoords(vehicle)
    
    if not inGasStation then
        SendPhoneNotification('Refuel Error', 'You must be at a gas station')
        return
    end
    
    if not isCloseVeh() then
        SendPhoneNotification('Refuel Error', 'You must be closer to the vehicle')
        return
    end
    
    if GetIsVehicleEngineRunning(vehicle) and Config.VehicleBlowUp then
        local Chance = math.random(1, 100)
        if Chance <= Config.BlowUpChance then
            AddExplosion(vehicleCoords.x,vehicleCoords.y,vehicleCoords.z, 8, 50.0, true, false, true)
            return
        end
    end
    
    RequestAnimDict("timetable@gardener@filling_can")
    while not HasAnimDictLoaded('timetable@gardener@filling_can') do Wait(100) end
    TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 8.0, 1.0, -1, 1, 0, 0, 0, 0)
    refueling = true
    Refuelamount = 0
    
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "refuel", 0.3)
    
    QBCore.Functions.Progressbar("refuel-car", "Refueling", time, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {},
        function()
            refueling = false
            TriggerServerEvent('qb-fuel:server:PayForFuel', refillCost, purchasetype)
            local curfuel = GetFuel(vehicle)
            local finalfuel = (curfuel + fuelamount)
            if finalfuel > 99 and finalfuel < 100 then
                SetFuel(vehicle, 100)
            else
                SetFuel(vehicle, finalfuel)
            end
            StopAnimTask(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "fuelstop", 0.4)
            TriggerEvent('qb-fuel:client:returnnozzle')
        end,
        function()
            refueling = false
            StopAnimTask(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "fuelstop", 0.4)
            TriggerEvent('qb-fuel:client:returnnozzle')
        end)
end)

-- Target Export

exports['qb-target']:AddTargetModel(props, {
	options = {
		{
			type = "client",
			event = "qb-fuel:client:grabnozzle",
			icon = "fas fa-gas-pump",
			label = "Grab Nozzle",
			canInteract = function(entity)
				if not holdingnozzle and not IsPedInAnyVehicle(PlayerPedId()) and GetEntityHealth(entity) > 100 then
					return true
				end
				return false
			end
		},
		{
			type = "server",
			event = "qb-fuel:server:paypetrolcan",
			icon = "fas fa-gas-pump",
			label = "Buy JerryCan ("..Config.petrolcanbye.."$)",
			canInteract = function(entity)
				if not holdingnozzle and not IsPedInAnyVehicle(PlayerPedId()) and GetEntityHealth(entity) > 100 then
					return true
				end
				return false
			end
		},

		{
			type = "client",
			event = "qb-fuel:client:returnnozzle",
			icon = "fas fa-gas-pump",
			label = "Return Nozzle",
			canInteract = function()
				if holdingnozzle and not refueling then
					return true
				end
				return false
			end
		},
	},
	distance = 1.0
})

-- Threads
function iselectric(vehicle)

	for k, v in pairs(Config.ElectricVehicles) do
        if vehicle == GetHashKey(v) then
            return true
        end
    end
	return false
end
exports("iselectric",iselectric)
function IsHoldingElectricNozzle()
	return HoldingElectricNozzle
end exports('IsHoldingElectricNozzle', IsHoldingElectricNozzle)
CreateThread(function()
	local bones = {
		"petrolcap", "wheel_lr", "petroltank", "petroltank_l", "engine", "engine_l"
	}

	exports['qb-target']:AddTargetBone(bones, {
		options = {
			{
				type = "client",
				event = "qb-fuel:client:OpenFuelMenu",
				icon = "fas fa-gas-pump",
				label = "Insert Nozzle",
				canInteract = function()

					if not iselectric(GetEntityModel( GetClosestVehicle()))  and not refueling and holdingnozzle then
						return true
					end
			
				end
			},
			{
				                type = "client",
				                event = "cdn-fuel:client:electric:SendMenuToServer",
				                icon = "fas fa-gas-pump",
				                label = "Insert Charger Soket",
				                canInteract = function()
				                    if iselectric(GetEntityModel( GetClosestVehicle())) and HoldingElectricNozzle and not refuelingelectic then
				                        return true
				                    end
				                end
				            }
		},
		distance = 1.5,
	})
end)

-- Jerry Can --
RegisterNetEvent('qb-fuel:jerrycan:refuelmenu', function(itemData)
	if IsPedInAnyVehicle(PlayerPedId(), false) then QBCore.Functions.Notify('You cannot refuel from the inside of the vehicle!', 'error') return end
	if Config.FuelDebug then print("Item Data: " .. json.encode(itemData)) end
	local vehicle = QBCore.Functions.GetClosestVehicle()
	local vehiclecoords = GetEntityCoords(vehicle)
	local pedcoords = GetEntityCoords(PlayerPedId())
	if GetVehicleBodyHealth(vehicle) < 100 then QBCore.Functions.Notify("Vehicle is too damaged to refuel!", 'error') return end
	if holdingnozzle then
		local fulltank
		if itemData.info.gasamount == Config.JerryCanCap then fulltank = true
		GasString = "Your Jerry Can is full!"
		else fulltank = false
		GasString = "Refuel your Jerry Can!"
		end
		exports['qb-menu']:openMenu({
			{
				header = "Jerry Can",
				isMenuHeader = true,
			},
			{
				header = "Refuel Jerry Can",
				txt = GasString,
				icon = "fas fa-gas-pump",
				params = {
					event = "qb-fuel:jerrycan:refueljerrycan",
					args = {
						itemData = itemData,
					},
				},
				disabled = fulltank,
			},
			{
				header = "Cancel",
				txt = "I actually don't want to use this anymore.",
				icon = "fas fa-times-circle",
			},
		})
	else
		if #(vehiclecoords - pedcoords) > 2.5 then return end
		local nogas
		if itemData.info.gasamount < 1 then nogas = true
		GasString = "You have no gas in your Jerry Can!"
		else nogas = false
		GasString = "Put your gasoline to use and refuel the vehicle!"
		end
		exports['qb-menu']:openMenu({
			{
				header = "Jerry Can",
				isMenuHeader = true,
			},
			{
				header = "Refuel Vehicle",
				txt = GasString,
				icon = "fas fa-gas-pump",
				params = {
					event = "qb-fuel:jerrycan:refuelvehicle",
					args = {
						itemData = itemData,
					},
				},
				disabled = nogas,
			},
			{
				header = "Cancel",
				txt = "I actually don't want to use this anymore.",
				icon = "fas fa-times-circle",
			},
		})
	end
end)

RegisterNetEvent('qb-fuel:jerrycan:refuelvehicle', function(data)
	local vehicle = QBCore.Functions.GetClosestVehicle()
	local vehfuel = math.floor(GetFuel(vehicle))
	local maxvehrefuel = (100 - math.ceil(vehfuel))
	local itemData = data.itemData
	local jerrycanfuelamount = itemData.info.gasamount
	if maxvehrefuel < Config.JerryCanCap then
		maxvehrefuel = maxvehrefuel
	else
		maxvehrefuel = Config.JerryCanCap
	end
	if maxvehrefuel >= jerrycanfuelamount then maxvehrefuel = jerrycanfuelamount elseif maxvehrefuel < jerrycanfuelamount then maxvehrefuel = maxvehrefuel end
	local refuel = exports['qb-input']:ShowInput({
		header = "Select how much gas to refuel.",
		submitText = "Refuel Vehicle",
		inputs = {
			{
				type = 'number',
				isRequired = true,
				name = 'amount',
				text = 'You can insert ' .. maxvehrefuel .. 'L of Gas'
			}
		}
	})
	if refuel then
		if tonumber(refuel.amount) == 0 then QBCore.Functions.Notify("You have to fuel more than 0L!", 'error') return elseif tonumber(refuel.amount) < 0 then QBCore.Functions.Notify("You can't refuel a negative amount!", 'error') return end
		if tonumber(refuel.amount) > jerrycanfuelamount then QBCore.Functions.Notify("The Jerry Can doesn't have this much fuel!", 'error') return end
		local refueltimer = Config.RefuelTime * tonumber(refuel.amount)
		if tonumber(refuel.amount) < 10 then refueltimer = Config.RefuelTime * 10 end
		SetBusy(true)
        JerrycanProp = CreateObject(GetHashKey('w_am_jerrycan'), 1.0, 1.0, 1.0, true, true, false)
        local lefthand = GetPedBoneIndex(PlayerPedId(), 18905)
        AttachEntityToEntity(JerrycanProp, PlayerPedId(), lefthand, 0.11 --[[Left - Right (Kind of)]] , 0.05--[[Up - Down]], 0.27 --[[Forward - Backward]], -15.0, 170.0, 100.42, 0, 1, 0, 1, 0, 1)
		QBCore.Functions.Progressbar('refuel_gas', 'Refuelling ' .. tonumber(refuel.amount) .. 'L of Gas', refueltimer, false, true, { -- Name | Label | Time | useWhileDead | canCancel
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}, { animDict = Config.RefuelAnimDict, anim = Config.RefuelAnim, flags = 17, }, {}, {},
		function() -- Play When Done
			SetBusy(false)
			DeleteObject(JerrycanProp)
			StopAnimTask(PlayerPedId(), Config.RefuelAnimDict, Config.RefuelAnim, 1.0)
			QBCore.Functions.Notify('Successfully put ' .. tonumber(refuel.amount) .. 'L into the vehicle!', 'success')
			local syphonData = data.itemData
			local srcPlayerData = QBCore.Functions.GetPlayerData()
			TriggerServerEvent('qb-fuel:info', "remove", tonumber(refuel.amount), srcPlayerData, syphonData)
			SetFuel(vehicle, (vehfuel + refuel.amount))
		end, function() -- Play When Cancel
			SetBusy(false)
			DeleteObject(JerrycanProp)
			StopAnimTask(PlayerPedId(), Config.RefuelAnimDict, Config.RefuelAnim, 1.0)
			QBCore.Functions.Notify('Cancelled.', 'error')
		end)
	end
end)

RegisterNetEvent('qb-fuel:jerrycan:refueljerrycan', function(data)
	local itemData = data.itemData
	local JerryCanMaxRefuel = (Config.JerryCanCap - itemData.info.gasamount)
	local jerrycanfuelamount = itemData.info.gasamount
	local refuel = exports['qb-input']:ShowInput({
		header = "Select how much gas to refuel. (CASH)",
		submitText = "Refuel Jerry Can",
		inputs = { {
			type = 'number',
			isRequired = true,
			name = 'amount',
			text = 'Up to ' .. JerryCanMaxRefuel .. 'L of gas.'
		} }
	})
	if refuel then
		if tonumber(refuel.amount) == 0 then QBCore.Functions.Notify("You have to fuel more than 0L!", 'error') return elseif tonumber(refuel.amount) < 0 then QBCore.Functions.Notify("You can't refuel a negative amount!", 'error') return end
		if tonumber(refuel.amount) + tonumber(jerrycanfuelamount) > Config.JerryCanCap then QBCore.Functions.Notify("The Jerry Can cannot fit this much gasoline!", 'error') return end
		if tonumber(refuel.amount) > Config.JerryCanCap then QBCore.Functions.Notify('The Jerry Can cannot hold this much gasoline!', 'error') return end
		local refueltimer = Config.RefuelTime * tonumber(refuel.amount)
		if tonumber(refuel.amount) < 10 then refueltimer = Config.RefuelTime * 10 end
		local price = (tonumber(refuel.amount) * Config.CostMultiplier) + GlobalTax(tonumber(refuel.amount) * Config.CostMultiplier)
		if not CanAfford(price, "cash") then QBCore.Functions.Notify("You don't have enough cash for "..refuel.amount.."L!", 'error') return end
		if GetIsVehicleEngineRunning(vehicle) and Config.VehicleBlowUp then
			local Chance = math.random(1, 100)
			if Chance <= Config.BlowUpChance then
				AddExplosion(vehicleCoords.x,vehicleCoords.y,vehicleCoords.z, 8, 50.0, true, false, true)
				return
			end 
		end
		SetBusy(true)
        JerrycanProp = CreateObject(GetHashKey('w_am_jerrycan'), 1.0, 1.0, 1.0, true, true, false)
        local lefthand = GetPedBoneIndex(PlayerPedId(), 18905)
		

        AttachEntityToEntity(JerrycanProp, PlayerPedId(), lefthand, 0.11 --[[Left - Right (Kind of)]] , 0.05--[[Up - Down]], 0.27 --[[Forward - Backward]], -15.0, 170.0, 100.42, 0, 1, 0, 1, 0, 1)
		SetEntityVisible(fuelnozzle, false, 0)
		QBCore.Functions.Progressbar('refuel_gas', 'Refuelling Jerry Can', refueltimer, false,true, { -- Name | Label | Time | useWhileDead | canCancel
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}, { animDict = Config.RefuelAnimDict, anim = Config.RefuelAnim, flags = 17, }, {}, {},
		function() -- Play When Done
			SetEntityVisible(fuelnozzle, true, 0)
			SetBusy(false)
			DeleteObject(JerrycanProp)
			StopAnimTask(PlayerPedId(), Config.RefuelAnimDict, Config.RefuelAnim, 1.0)
			QBCore.Functions.Notify('Successfully put ' .. tonumber(refuel.amount) .. 'L into the Jerry Can!', 'success')
			local syphonData = data.itemData
			local srcPlayerData = QBCore.Functions.GetPlayerData()
			TriggerServerEvent('qb-fuel:info', "add", tonumber(refuel.amount), srcPlayerData, syphonData)
			TriggerServerEvent('qb-fuel:server:PayForFuel', tonumber(refuel.amount) * Config.CostMultiplier, "cash")
		end, function() -- Play When Cancel
			SetEntityVisible(fuelnozzle, true, 0)
			SetBusy(false)
			DeleteObject(JerrycanProp)
			StopAnimTask(PlayerPedId(), Config.RefuelAnimDict, Config.RefuelAnim, 1.0)
			QBCore.Functions.Notify('Cancelled.', 'error')
		end)
	end
end)