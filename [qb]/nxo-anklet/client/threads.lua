QBCore = exports['qb-core']:GetCoreObject()
Citizen.CreateThread(function()
	RequestAnimDict("anim@move_m@prisoner_cuffed") 
    RequestAnimDict("mp_arresting") 
	RequestAnimDict("anim@apt_trans@garage") 
	RequestModel(GetHashKey("p_cs_cuffs_02_s"))
	
end)

CreateThread(function()
	-- firstload()
	-- while true do 
	-- 	if not cuffed then
	-- 		if IsControlJustPressed(1, Config.OpenMenuKey) then 
	-- 			OpenGeneralMenu()
				
	-- 			Wait(1000)
	-- 		end
	-- 	end
		
	-- 	Citizen.Wait(0)
	-- end

	
end)

local carry_status = false
local zoneanklet={}
local hasanklet=false
function createzone(electroCuffedPlayers)
	if  #zoneanklet==0 then
		for k,v in pairs(Config.zone) do
			zoneanklet[k] = PolyZone:Create(v.zone, {
				name = 'ankletzone_'..k,
				debugPoly = false
			})
			zoneanklet[k]:onPlayerInOut(function(isPointInside, point)
					if isPointInside and hasanklet then
						if not electroCuffedPlayers.zone[k] then
							exports['qb-dispatch']:anklet()
						end
					end
			end)
		end
	end
end
RegisterNetEvent('cuff:client:removeanklet', function()
	hasanklet=false
	QBCore.Functions.Notify("The anklet came off your leg", "success")
	Wait(100)
	spawnankletobject()
end)

RegisterNetEvent('cuff:client:startanklet', function()
	QBCore.Functions.Notify("An anklet is installed on your foot", "success")
	firstload()
end)
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	Wait(1000)
	firstload()
end)
local blip={}
 local ankletobject=nil
local ankletmodel

function spawnankletobject()
	if ankletobject then
		DeleteEntity(ankletobject)
	end
	if hasanklet then  
	local ped=PlayerPedId()
	local coords = GetEntityCoords(ped)
	local boneIndex = GetPedBoneIndex(ped, 24806)
	while not HasModelLoaded(ankletmodel) do
		Wait(0)
	end
	ankletobject=nil
	ankletobject = CreateObject(ankletmodel, coords, true, true, true)
	AttachEntityToEntity(ankletobject, ped,boneIndex,0.16, 0.00,-0.70,0.0, 180.0, 0.0 , 1, 1, 0, 1, 0, 1)   
	end
end

 function firstload()
	ankletmodel=GetHashKey("sam_anclet")
	RequestModel(ankletmodel)
	CreateThread(function()
	local player = QBCore.Functions.GetPlayerData()
	if player.citizenid then
	QBCore.Functions.TriggerCallback("cuff:server:getElectroCuffedPlayers", function(electroCuffedPlayers)
		if electroCuffedPlayers and electroCuffedPlayers[1] and electroCuffedPlayers[1].identifier==player.citizenid then
			hasanklet=true
			createzone(electroCuffedPlayers[1])
			ped=PlayerPedId()
			CreateThread(function()
				while  hasanklet do 
					  if not ankletobject then
						spawnankletobject()
					  elseif ankletobject and not DoesEntityExist(ankletobject) then
						spawnankletobject()
					  elseif not IsEntityAttached((ankletobject)) then
						spawnankletobject()
					  end
					Wait(4000)
				end
			end)
		end
	end,player.citizenid)
	end
	Wait(1000)
end)
end


CreateThread(function()

if Config.RealtimeGPS then 
	Citizen.CreateThread(function() 
		while true do 
			local playerData = QBCore.Functions.GetPlayerData()
			local found=false
		if playerData.job.name == 'police' or playerData.job.name == 'justice' then
			for k,v in ipairs(trackedPlayers) do 
				if v then
					found=true
				end
			end

			if found then
			QBCore.Functions.TriggerCallback("cuff:server:getElectroCuffedPlayers", function(electroCuffedPlayers)
				for k,v in ipairs(blip) do 
					RemoveBlip(v)
				end
				blip={}
				for k,v in ipairs(electroCuffedPlayers) do 
				   if trackedPlayers[v.identifier] and v.coords then
					blip[#blip+1] = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
					SetBlipSprite(blip[#blip] , 303)
					SetBlipDisplay(blip[#blip] , 4)
					SetBlipScale(blip[#blip] , 0.7)
					SetBlipColour(blip[#blip] , 1)
					SetBlipAsShortRange(blip[#blip] , true)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString("GPS: " .. v.name)
					EndTextCommandSetBlipName(blip[#blip])
				   end
				end
			end)
			end
		end
			Citizen.Wait(Config.RealtimeGPSRefreshMS)
		end

	end)
end
end)

-- Citizen.CreateThread(function() 
-- 	while true do 
-- 		if not bagliyim then 
-- 			ClearPedProp(GetPlayerPed(-1), "prop_trevor_rope_01")
-- 		end

-- 		Citizen.Wait(500)
-- 	end
-- end)