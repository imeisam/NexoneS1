local QBCore = exports['qb-core']:GetCoreObject()
local lit_1 = {
    {anim = "savecouch@",lib = "t_sleep_loop_couch",name = Config.Language.anim.lie_back, x = 0, y = 0.2, z = 1.1, r = 180.0},
	{anim = "amb@prop_human_seat_chair_food@male@base",lib = "base",name = Config.Language.anim.sit_right, x = 0.0, y = -0.2, z =0.55, r = -90.0},
	{anim = "amb@prop_human_seat_chair_food@male@base",lib = "base",name = Config.Language.anim.sit_left, x = 0.0, y = -0.2, z =0.55, r = 90.0},
	{anim = "amb@world_human_stupor@male_looking_left@base",lib = "base",name = Config.Language.anim.pls, x = 0.0, y = 0.3, z = 1.5, r = 180.0},
}
local lit = {
	{lit = "trump-stretcher", distance_stop = 2.4, name = lit_1, title = Config.Language.lit_1}
}
local sit=false
local bed=false
local grab=false

function getconfigstretcher()
	return Config.Hash
end
exports("getconfigstretcher",getconfigstretcher)
CreateThread(function()
	exports["qb-target"]:AddTargetModel(Config.stretcher, {
		options = {
			{
				action = function(entity)
					TriggerEvent('qb-stretcher:client:grab', entity)
				end,
				canInteract = function()
					local PlayerData = QBCore.Functions.GetPlayerData()
					return not PlayerData.metadata['isdead'] and not PlayerData.metadata['inlaststand'] and not PlayerData.metadata['ishandcuffed']
				end,
				icon = "fa fa-circle",
				label = "Stretcher Grab",
				job = "ambulance",
			},
			{
				action = function(entity)
					TriggerEvent('qb-stretcher:client:bed', entity,true)
				end,
				canInteract = function()
					local PlayerData = QBCore.Functions.GetPlayerData()
					return not PlayerData.metadata['isdead'] and not PlayerData.metadata['inlaststand'] and not PlayerData.metadata['ishandcuffed']
				end,
				icon = "fa fa-circle",
				label = "Self bed",
				job = "ambulance",
			},
			{
				action = function(entity)
					TriggerEvent('qb-stretcher:client:seat', entity,"left",true)
				end,
				canInteract = function()
					local PlayerData = QBCore.Functions.GetPlayerData()
					return not PlayerData.metadata['isdead'] and not PlayerData.metadata['inlaststand'] and not PlayerData.metadata['ishandcuffed']
				end,
				icon = "fa fa-circle",
				label = "Sit Self Right side",
				job = "ambulance",
			},
			{
				action = function(entity)
						TriggerEvent('qb-stretcher:client:seat', entity,"right",true)
				end,
				canInteract = function()
					local PlayerData = QBCore.Functions.GetPlayerData()
					return not PlayerData.metadata['isdead'] and not PlayerData.metadata['inlaststand'] and not PlayerData.metadata['ishandcuffed']
				end,
				icon = "fa fa-circle",
				label = "Sit Self Left side",
				job = "ambulance",
			},
			{
				action = function(entity)
						TriggerEvent('qb-stretcher:client:Raise', entity)
				end,
				canInteract = function()
					local PlayerData = QBCore.Functions.GetPlayerData()
					return not PlayerData.metadata['isdead'] and not PlayerData.metadata['inlaststand'] and not PlayerData.metadata['ishandcuffed']
				end,
				icon = "fa fa-circle",
				label = "Raise/Take down",
				job = "ambulance",
			},
			{
				action = function(entity)
					TriggerEvent('qb-stretcher:client:Backboard', entity,false)
				end,
				canInteract = function()
					local PlayerData = QBCore.Functions.GetPlayerData()
					return not PlayerData.metadata['isdead'] and not PlayerData.metadata['inlaststand'] and not PlayerData.metadata['ishandcuffed']
				end,
				icon = "fa fa-circle",
				label = "Toggle Backboard",
				job = "ambulance",
			},

			{
				action = function(entity)
					local player, distance = QBCore.Functions.GetClosestPlayer()
					if player ~= -1 and distance < 2.0 then
						local playerId = GetPlayerServerId(player)
						TriggerServerEvent('qb-stretcher:server:Patientbed',playerId,GetEntityCoords(GetPlayerPed(-1)) )
					end
				end,
				canInteract = function()
					local player, distance = QBCore.Functions.GetClosestPlayer()
					local part=false
					if player ~= -1 and distance < 2.0 then
						part=true
					end
					
					local PlayerData = QBCore.Functions.GetPlayerData()
					return part and not PlayerData.metadata['isdead'] and not PlayerData.metadata['inlaststand'] and not PlayerData.metadata['ishandcuffed']
				end,
				icon = "fa fa-circle",
				label = "Patient bed",
				job = "ambulance",
			},
			{
				action = function(entity)
					local player, distance = QBCore.Functions.GetClosestPlayer()
					if player ~= -1 and distance < 2.0 then
						local playerId = GetPlayerServerId(player)
						TriggerServerEvent('qb-stretcher:server:PatientSit', playerId,"right",GetEntityCoords(GetPlayerPed(-1)) )
					end
				end,
				canInteract = function()
					local player, distance = QBCore.Functions.GetClosestPlayer()
					local part=false
					if player ~= -1 and distance < 2.0 then
						part=true
					end
					local PlayerData = QBCore.Functions.GetPlayerData()
					return part and not PlayerData.metadata['isdead'] and not PlayerData.metadata['inlaststand'] and not PlayerData.metadata['ishandcuffed']
				end,
				icon = "fa fa-circle",
				label = "Sit Patient Right side",
				job = "ambulance",
			},
			{
				action = function(entity)
					local player, distance = QBCore.Functions.GetClosestPlayer()
					if player ~= -1 and distance < 2.0 then
						local playerId = GetPlayerServerId(player)
						TriggerServerEvent('qb-stretcher:server:PatientSit', playerId,"left",GetEntityCoords(GetPlayerPed(-1)) )
					end
				end,
				canInteract = function()
					local player, distance = QBCore.Functions.GetClosestPlayer()
					local part=false
					if player ~= -1 and distance < 2.0 then
						part=true
					end
					local PlayerData = QBCore.Functions.GetPlayerData()
					return part and not PlayerData.metadata['isdead'] and not PlayerData.metadata['inlaststand'] and not PlayerData.metadata['ishandcuffed']
				end,
				icon = "fa fa-circle",
				label = "Sit Patient Left side",
				job = "ambulance",
			},
			{
				action = function()
					local player, distance = QBCore.Functions.GetClosestPlayer()
					if player ~= -1 and distance < 2.0 then
						playerId = GetPlayerServerId(player)
					
					TriggerServerEvent('qb-stretcher:server:TakeOutPatient', playerId)
					end
				end,
				canInteract = function()
					local PlayerData = QBCore.Functions.GetPlayerData()
					return not PlayerData.metadata['isdead'] and not PlayerData.metadata['inlaststand'] and not PlayerData.metadata['ishandcuffed']
				end,
				icon = "fa fa-circle",
				label = "Take Out Patient",
				job = "ambulance",
			},
		},
		distance = 1.2
	})

	exports['qb-target']:AddTargetBone({"boot","seat_pside_r","seat_pside_l"}, {
		options = {
			{
				action = function(entity)
					TriggerEvent('qb-stretcher:client:sendtoveh',entity)
				end,
				canInteract = function(entity)
					local found=false
					for _,g in pairs(Config.Hash) do
						if GetEntityModel(entity)== GetHashKey(g.hash) then
							found=true
						end
					end
					local PlayerData = QBCore.Functions.GetPlayerData()
					local pedCoords = GetEntityCoords(GetPlayerPed(-1))
					local prop = GetClosestVehicle(pedCoords, 2.0, GetHashKey(Config.stretcher), 70)
					return not grab and prop and prop~=0 and  not IsEntityAttached(prop) and found and  not PlayerData.metadata['isdead'] and not PlayerData.metadata['inlaststand'] and not PlayerData.metadata['ishandcuffed']
				end,
				icon = "fa fa-circle",
				label = "Pick in Ambulance",
				job = "ambulance",
			},
			{
				action = function(entity)
					TriggerEvent('qb-stretcher:client:detachfromveh',entity)
				end,
				canInteract = function(entity)
					local found=false
					for _,g in pairs(Config.Hash) do
						if GetEntityModel(entity)== GetHashKey(g.hash) then
							found=true
						end
					end
					local PlayerData = QBCore.Functions.GetPlayerData()
					local pedCoords = GetEntityCoords(GetPlayerPed(-1))
					local prop = GetClosestVehicle(pedCoords,4.0, GetHashKey(Config.stretcher), 70)
					return not grab and prop and prop~=0 and IsEntityAttached(prop) and found and  not PlayerData.metadata['isdead'] and not PlayerData.metadata['inlaststand'] and not PlayerData.metadata['ishandcuffed']
				end,
				icon = "fa fa-circle",
				label = "Pickup Stretcher",
				job = "ambulance",
			},
		},
		distance = 1.2
	})
end)
RegisterCommand('strclear', function()
	local pedCoords = GetEntityCoords(GetPlayerPed(-1))
	local entity = GetClosestVehicle(pedCoords, 3.0, GetHashKey(Config.stretcher), 70)
	SetVehicleExtra(entity, 7,1)
	SetVehicleExtra(entity, 6, 1)
	SetVehicleExtra(entity, 5,1)
	SetVehicleExtra(entity, 3,1)
	SetVehicleExtra(entity, 12,1)
end)

RegisterNetEvent('qb-stretcher:client:grab', function(entity)
	if DoesEntityExist(entity) then
		if not IsVehicleExtraTurnedOn(entity,1)  then
			QBCore.Functions.Notify("First Raise a Stretcher", 'error') 
			return
		 end
		SetVehicleExtra(entity, 1, 0)
		SetVehicleExtra(entity, 2, 1)
		grab=true
			prendre(entity)
	end
end)

RegisterNetEvent('qb-stretcher:client:bed', function(entity,self,coord)
	local pedCoords = GetEntityCoords(GetPlayerPed(-1))
	if not self then 
		entity = GetClosestVehicle(pedCoords, 3.0, GetHashKey(Config.stretcher), 70)
		 pedCoords=coord
	end

	if DoesEntityExist(entity) then
		local k
		if IsVehicleExtraTurnedOn(entity,11)  then
			k =lit_1[1]				
		else
			k =lit_1[4]			
		end
		NetworkRequestControlOfEntity(entity)
		LoadAnim(k.anim)
		-- if (k.name == Config.Language.anim.pls) then
		-- 	SetVehicleDoorOpen(entity, 4, false)
		-- -- end
		local PlayerData = QBCore.Functions.GetPlayerData()

			if PlayerData.metadata['isdead'] and not PlayerData.metadata['inlaststand'] then
				AttachEntityToEntity(GetPlayerPed(-1), entity, GetPlayerPed(-1), k.x, k.y, k.z+0.4, 0.0, 0.0, k.r, 0.0, false, false, true, false, 2, true)
			else
				AttachEntityToEntity(GetPlayerPed(-1), entity, GetPlayerPed(-1), k.x, k.y, k.z, 0.0, 0.0, k.r, 0.0, false, false, true, false, 2, true)
			end
	
		if not IsEntityPlayingAnim(PlayerPedId(-1),  k.anim, k.lib, 3) then
			TaskPlayAnim(GetPlayerPed(-1), k.anim, k.lib, 8.0, 8.0, -1, 1, 0, false, false, false)	
		end
		
		gotobed(entity)
		bed=true
	end
end)

RegisterNetEvent('qb-stretcher:client:changebed', function(self,coord)
	local pedCoords = GetEntityCoords(GetPlayerPed(-1))
	Wait(2000)
	if not bed then return end
	if not self then 
		entity = GetClosestVehicle(pedCoords, 3.0, GetHashKey(Config.stretcher), 70)
		 pedCoords=coord
	end

	if DoesEntityExist(entity) then

		DetachEntity(GetPlayerPed(-1), true, true)
				
				ClearPedTasks(GetPlayerPed(-1))
				ClearPedTasksImmediately(GetPlayerPed(-1))
				
		local k
		if IsVehicleExtraTurnedOn(entity,11)  then
			k =lit_1[1]				
		else
			k =lit_1[4]			
		end
		LoadAnim(k.anim)
		-- if (k.name == Config.Language.anim.pls) then
		-- 	SetVehicleDoorOpen(entity, 4, false)
		-- end
		local PlayerData = QBCore.Functions.GetPlayerData()
		if PlayerData.metadata['isdead'] and not PlayerData.metadata['inlaststand'] then
			AttachEntityToEntity(GetPlayerPed(-1), entity, GetPlayerPed(-1), k.x, k.y, k.z+0.4, 0.0, 0.0, k.r, 0.0, false, false, false, false, 2, true)
		else
			AttachEntityToEntity(GetPlayerPed(-1), entity, GetPlayerPed(-1), k.x, k.y, k.z, 0.0, 0.0, k.r, 0.0, false, false, false, false, 2, true)
		end
	
		TaskPlayAnim(GetPlayerPed(-1), k.anim, k.lib, 8.0, 8.0, -1, 1, 0, false, false, false)	
		gotobed(entity)
		bed=true
	
	end
end)

RegisterNetEvent('qb-stretcher:client:seat', function(entity,side,self,coord)
	if not self then entity = GetClosestVehicle(pedCoords, 3.0, GetHashKey(Config.stretcher), 70)  pedCoords=coord end
	if DoesEntityExist(entity) then
		local k
		if side=="left" then
			k =lit_1[2]	
		else
			k =lit_1[3]	
		end
			LoadAnim(k.anim)
			if (k.name == Config.Language.anim.pls) then
				SetVehicleDoorOpen(entity, 4, false)
			end
			AttachEntityToEntity(GetPlayerPed(-1), entity, GetPlayerPed(-1), k.x, k.y, k.z, 0.0, 0.0, k.r, 0.0, false, false, false, false, 2, true)
			TaskPlayAnim(GetPlayerPed(-1), k.anim, k.lib, 8.0, 8.0, -1, 1, 0, false, false, false)						
			seat=true
			gotobed(entity)
	end
end)

RegisterNetEvent('qb-stretcher:client:Raise', function(entity)
	if DoesEntityExist(entity) then
		local objectcoord = GetEntityCoords(entity)
		if IsVehicleExtraTurnedOn(entity,2)  then
			SetVehicleExtra(entity, 1, 0)
			SetVehicleExtra(entity, 2, 1)
			SetEntityCoordsNoOffset(entity, objectcoord.x, objectcoord.y, objectcoord.z+0.65, false, false, false)
			
		else
			SetVehicleExtra(entity, 1,1)
			SetVehicleExtra(entity, 2, 0)
			SetEntityCoordsNoOffset(entity, objectcoord.x, objectcoord.y, objectcoord.z-0.65, false, false, false)
		
		end
	end
end)

RegisterNetEvent('qb-stretcher:client:Backboard', function(entity)
	if DoesEntityExist(entity) then
		if IsVehicleExtraTurnedOn(entity,11)  then
			SetVehicleExtra(entity,11, 1)
			SetVehicleExtra(entity, 12, 0)
		else
			SetVehicleExtra(entity,11, 0)
			SetVehicleExtra(entity, 12, 1)
		end

					local player, distance = QBCore.Functions.GetClosestPlayer()
					if player ~= -1 and distance < 2.0 then
						local playerId = GetPlayerServerId(player)
						TriggerServerEvent('qb-stretcher:server:Backboard',playerId,GetEntityCoords(GetPlayerPed(-1)))
					end
	end
end)

RegisterNetEvent('qb-stretcher:client:togglelifepak3', function()
	local pedCoords = GetEntityCoords(GetPlayerPed(-1))
	local closestObject = GetClosestVehicle(pedCoords, 3.0, GetHashKey(Config.stretcher), 70)
	if DoesEntityExist(closestObject) then
		k =lit_1[2]				
			LoadAnim(k.anim)
			if (k.name == Config.Language.anim.pls) then
				SetVehicleDoorOpen(closestObject, 4, false)
			end
			AttachEntityToEntity(GetPlayerPed(-1), closestObject, GetPlayerPed(-1), k.x, k.y, k.z, 0.0, 0.0, k.r, 0.0, false, false, false, false, 2, true)
			TaskPlayAnim(GetPlayerPed(-1), k.anim, k.lib, 8.0, 8.0, -1, 1, 0, false, false, false)						
	end
end)

RegisterNetEvent('qb-stretcher:client:unbed', function()
	local pedCoords = GetEntityCoords(GetPlayerPed(-1))
	local closestObject = GetClosestVehicle(pedCoords, 3.0, GetHashKey(Config.stretcher), 70)
	if DoesEntityExist(closestObject) then
		exports['qb-core']:HideText()
			bed=false
					DetachEntity(GetPlayerPed(-1), true, true)
					local x, y, z = table.unpack(GetEntityCoords(closestObject) )
					SetEntityCoords(GetPlayerPed(-1), x+0.5, y+0.7, z)
				ClearPedTasks(GetPlayerPed(-1))
				ClearPedTasksImmediately(GetPlayerPed(-1))	
	end
end)
--------------------------------------------------------------------------------fix---------------------------------------------









-- RegisterNetEvent('qb-stretcher:client:togglelifepak', function()
-- 	local pedCoords = GetEntityCoords(GetPlayerPed(-1))
-- 	local closestObject = GetClosestVehicle(pedCoords, 3.0, GetHashKey(Config.stretcher), 70)
-- 	if DoesEntityExist(closestObject) then
-- 		k =lit_1[1]				
-- 			LoadAnim(k.anim)
-- 			if (k.name == Config.Language.anim.pls) then
-- 				SetVehicleDoorOpen(closestObject, 4, false)
-- 			end
-- 			AttachEntityToEntity(GetPlayerPed(-1), closestObject, GetPlayerPed(-1), k.x, k.y, k.z, 0.0, 0.0, k.r, 0.0, false, false, false, false, 2, true)
-- 			TaskPlayAnim(GetPlayerPed(-1), k.anim, k.lib, 8.0, 8.0, -1, 1, 0, false, false, false)						
	
-- 	end
-- end)





-- RegisterNetEvent('qb-stretcher:client:togglelifepak3', function()
-- 	local pedCoords = GetEntityCoords(GetPlayerPed(-1))
-- 	local closestObject = GetClosestVehicle(pedCoords, 3.0, GetHashKey(Config.stretcher), 70)
-- 	if DoesEntityExist(closestObject) then
-- 		k =lit_1[2]				
-- 			LoadAnim(k.anim)
-- 			if (k.name == Config.Language.anim.pls) then
-- 				SetVehicleDoorOpen(closestObject, 4, false)
-- 			end
-- 			AttachEntityToEntity(GetPlayerPed(-1), closestObject, GetPlayerPed(-1), k.x, k.y, k.z, 0.0, 0.0, k.r, 0.0, false, false, false, false, 2, true)
-- 			TaskPlayAnim(GetPlayerPed(-1), k.anim, k.lib, 8.0, 8.0, -1, 1, 0, false, false, false)						
	
-- 	end
-- end)




-- Citizen.CreateThread(function()
-- 	WarMenu.CreateMenu('hopital', Config.Language.name_hospital)
-- 	while true do
-- 		local sleep = 2000	
-- 		local pedCoords = GetEntityCoords(GetPlayerPed(-1))
-- 		for _,i in pairs(lit) do
-- 			local closestObject = GetClosestVehicle(pedCoords, 3.0, GetHashKey(Config.stretcher), 70)
		
-- 			if DoesEntityExist(closestObject) then
-- 				sleep = 5
-- 				local propCoords = GetEntityCoords(closestObject)
-- 				local propForward = GetEntityForwardVector(closestObject)
-- 				local litCoords = (propCoords + propForward)
-- 				local sitCoords = (propCoords + propForward * 0.1)
-- 				local pickupCoords = (propCoords + propForward * 1.2)
-- 				local pickupCoords2 = (propCoords + propForward * - 1.2)

-- 				if GetDistanceBetweenCoords(pedCoords, litCoords, true) <= 5.0 then
-- 					if GetDistanceBetweenCoords(pedCoords, sitCoords, true) <= 2.0 then
-- 						hintToDisplay(Config.Language.do_action)
-- 						if IsControlJustPressed(0, Config.Press.do_action) then
-- 							WarMenu.OpenMenu('hopital')
-- 						end
-- 					elseif IsEntityAttachedToEntity(closestObject, GetPlayerPed(-1)) == false and not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3) then
-- 						if GetDistanceBetweenCoords(pedCoords, pickupCoords, true) <= 0.5 then
-- 							hintToDisplay(Config.Language.take_bed)
-- 							if IsControlJustPressed(0, Config.Press.take_bed) then
-- 								SetVehicleExtra(closestObject, 1, 0)
-- 								SetVehicleExtra(closestObject, 2, 1)
-- 								prop_exist = 0
-- 								prendre(closestObject)
-- 							end
-- 						end

-- 						if GetDistanceBetweenCoords(pedCoords, pickupCoords2, true) <= 1.5 then
-- 							hintToDisplay(Config.Language.take_bed)
-- 							if IsControlJustPressed(0, Config.Press.take_bed) then
-- 								SetVehicleExtra(closestObject, 1, 0)
-- 								SetVehicleExtra(closestObject, 2, 1)
-- 							prop_exist = 0
-- 								prendre(closestObject)
-- 							end
-- 						end
-- 					end
-- 				end

-- 				if WarMenu.IsMenuOpened('hopital') then
-- 					for _,k in pairs(i.name) do
-- 						if WarMenu.Button(k.name) then
-- 							LoadAnim(k.anim)
-- 							if (k.name == Config.Language.anim.pls) then
-- 								SetVehicleDoorOpen(closestObject, 4, false)
-- 							end
-- 							AttachEntityToEntity(GetPlayerPed(-1), closestObject, GetPlayerPed(-1), k.x, k.y, k.z, 0.0, 0.0, k.r, 0.0, false, false, false, false, 2, true)
-- 							WarMenu.CloseMenu('hopital')
-- 							TaskPlayAnim(GetPlayerPed(-1), k.anim, k.lib, 8.0, 8.0, -1, 1, 0, false, false, false)
-- 						end
-- 					end
					
-- 					if WarMenu.Button(Config.Language.toggle_backboard) then
-- 						if IsVehicleExtraTurnedOn(closestObject, 3) == false then
-- 							SetVehicleExtra(closestObject, 3, 0)
-- 						else
-- 							SetVehicleExtra(closestObject, 3, 1)
-- 						end
-- 					end
					
-- 					if WarMenu.Button(Config.Language.toggle_lifepak) then
-- 						if IsVehicleExtraTurnedOn(closestObject, 5) == false then
-- 							SetVehicleExtra(closestObject, 5, 0)
-- 						else
-- 							SetVehicleExtra(closestObject, 5, 1)
-- 						end
-- 					end
					
-- 					if WarMenu.Button(Config.Language.toggle_bag) then
-- 						if IsVehicleExtraTurnedOn(closestObject, 6) == false then
-- 							SetVehicleExtra(closestObject, 6, 0)
-- 						else
-- 							SetVehicleExtra(closestObject, 6, 1)
-- 						end
-- 					end
					
-- 					if WarMenu.Button(Config.Language.toggle_backpack) then
-- 						if IsVehicleExtraTurnedOn(closestObject, 7) == false then
-- 							SetVehicleExtra(closestObject, 7, 0)
-- 						else
-- 							SetVehicleExtra(closestObject, 7, 1)
-- 						end
-- 					end
					
-- 					if WarMenu.Button(Config.Language.toggle_seat) then
-- 						if IsVehicleExtraTurnedOn(closestObject, 11) == false then
-- 							SetVehicleExtra(closestObject, 11, 0)
-- 							SetVehicleExtra(closestObject, 12, 1)
-- 						else
-- 							SetVehicleExtra(closestObject, 11, 1)
-- 							SetVehicleExtra(closestObject, 12, 0)
-- 						end
-- 					end
					
-- 					if WarMenu.Button(Config.Language.go_out_bed) then
-- 						DetachEntity(GetPlayerPed(-1), true, true)
-- 						local x, y, z = table.unpack(GetEntityCoords(closestObject) + GetEntityForwardVector(closestObject) * - i.distance_stop)
-- 						SetEntityCoords(GetPlayerPed(-1), x, y, z)
-- 						WarMenu.CloseMenu('hopital')
-- 					end
-- 					WarMenu.Display()
-- 				end
-- 			end
-- 		end
-- 		Citizen.Wait(sleep)
-- 	end
-- end)

RegisterNetEvent('qb-stretcher:client:sendtoveh', function(veh)
	local veh_detect=0
	local prop_depth=0
	local prop_height=0
	local veh_detection=0
	local prop_width=0
	for _,g in pairs(Config.Hash) do
		if GetEntityModel(veh)== GetHashKey(g.hash) then
			veh_detect = veh
			veh_detection = g.detection
			prop_depth = g.depth
			prop_height = g.height
			prop_width=g.width
		end
	end
	local prop =  GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), 3.0, GetHashKey(Config.stretcher), 70)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	SetVehicleExtra(prop, 1, 1)
	SetVehicleExtra(prop, 2, 0)
	DetachEntity(prop, true, true)
	grab=false
	exports['qb-core']:HideText()
	AttachEntityToEntity(prop, veh_detect, 0.0, prop_width, prop_depth, prop_height, 0.0, 0.0, 0.0, 0.0, false, false, true, false, 2, true)
end)

RegisterNetEvent('qb-stretcher:client:detachfromveh', function(veh)
	local prop =  GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), 4.0, GetHashKey(Config.stretcher), 70)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	SetVehicleExtra(prop, 1, 0)
	SetVehicleExtra(prop, 2, 1)
	DetachEntity(prop, true, true)
	outputz=0
	for _,g in pairs(Config.Hash) do
		if GetEntityModel(veh)== GetHashKey(g.hash) then
			outputz=g.outputz
		end
	end
	local coords = GetEntityCoords(veh)
	local heading = GetEntityHeading(veh)
	local forward = GetEntityForwardVector(veh)
	local x, y, z = table.unpack(coords + forward * -6.0)

	SetEntityCoordsNoOffset(prop,vector3(x, y,z+outputz))
	headingveh=GetEntityHeading(veh)
	SetEntityHeading(prop, headingveh - 180.0)
end)


function prendre(propObject, hash)
	NetworkRequestControlOfEntity(propObject)

	LoadAnim("anim@heists@box_carry@")
	exports['qb-core']:DrawText("Drop Stretcher",'',"E")
	AttachEntityToEntity(propObject, GetPlayerPed(-1), GetPlayerPed(-1), -0.05, 1.3, -0.345 , 180.0, 180.0, 180.0, 0.0, false, false, true, false, 2, true)
		---
	while IsEntityAttachedToEntity(propObject, GetPlayerPed(-1)) do

		Citizen.Wait(5)

		if not IsEntityPlayingAnim(PlayerPedId(-1), 'anim@heists@box_carry@', 'idle', 3) then
			TaskPlayAnim(PlayerPedId(-1), 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
		end

		if IsPedDeadOrDying(GetPlayerPed(-1)) then
			ClearPedTasksImmediately(GetPlayerPed(-1))
			DetachEntity(propObject, true, true)
			grab=false
			exports['qb-core']:HideText()
		end
		if IsControlJustPressed(0, Config.Press.release_bed) then
			grab=false
			ClearPedTasksImmediately(GetPlayerPed(-1))
			DetachEntity(propObject, true, true)
			exports['qb-core']:HideText()
		end
		
	end
end

function gotobed(entity)
	exports['qb-core']:DrawText("Stand Up",'',"E")
	local ped=GetPlayerPed(-1)
	while IsEntityAttachedToEntity(entity, ped) do
		Wait(5)
		if IsControlJustPressed(0, Config.Press.out_vehicle_bed) then
			local PlayerData = QBCore.Functions.GetPlayerData()
			if not PlayerData.metadata['isdead'] and not PlayerData.metadata['inlaststand'] then
					bed=false
					ClearPedTasksImmediately(GetPlayerPed(-1))
					DetachEntity(ped, true, true)
					local x, y, z = table.unpack(GetEntityCoords(entity) )
					SetEntityCoords(GetPlayerPed(-1), x+0.5, y+0.7, z)
				exports['qb-core']:HideText()
			end
		end
	end

end

function LoadAnim(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(1)
	end
end