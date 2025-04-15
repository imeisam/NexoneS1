local QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent('QBCore:Client:UpdateObject', function() QBCore = exports['qb-core']:GetCoreObject() end)

local PlayerJob = {}
local Props = {}
local Targets = {}
local Peds = {}
local Blip = {}
local Log = {}
local PersProp = {}
local soundID = GetSoundId()
Blip={}
local singin=false;
RegisterNetEvent('jimlumberjack:client:singin', function()
	singin=not singin
	if (singin) then
		TriggerEvent("jimlumberjack:client:showblip")
		TriggerEvent('QBCore:Notify', "Now is SignIn", 'success')
	else
		TriggerEvent("jimlumberjack:client:hideblip")
		TriggerEvent('QBCore:Notify', "Now is SignOut", 'error')
	end
end)

RegisterNetEvent('jimlumberjack:client:showblip', function()

for k, v in pairs(Config.TreePositions) do
		Blip[#Blip+1] = AddBlipForCoord(v.xyz)
		SetBlipAsShortRange(Blip[#Blip], true)
		SetBlipSprite(Blip[#Blip], 686)
		SetBlipColour(Blip[#Blip],17)
		SetBlipScale(Blip[#Blip], 0.4)
		SetBlipDisplay(Blip[#Blip], 4)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString("Tree")
		EndTextCommandSetBlipName(Blip[#Blip])
end
for k, v in pairs(Config.Locations["Debark"]) do 
	Blip[#Blip+1] = AddBlipForCoord(v.coords.xyz)
		SetBlipAsShortRange(Blip[#Blip], true)
		SetBlipSprite(Blip[#Blip], 687)
		SetBlipColour(Blip[#Blip],17)
		SetBlipScale(Blip[#Blip], 0.4)
		SetBlipDisplay(Blip[#Blip], 4)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString("Wood shavings")
		EndTextCommandSetBlipName(Blip[#Blip])
end
for k, v in pairs(Config.Locations["Saws"]) do
	Blip[#Blip+1] = AddBlipForCoord(v.coords.xyz)
		SetBlipAsShortRange(Blip[#Blip], true)
		SetBlipSprite(Blip[#Blip], 689)
		SetBlipColour(Blip[#Blip],17)
		SetBlipScale(Blip[#Blip], 0.4)
		SetBlipDisplay(Blip[#Blip], 4)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString("Saw machine")
		EndTextCommandSetBlipName(Blip[#Blip])
end
for k, v in pairs(Config.Locations["Pulper"]) do 
	Blip[#Blip+1] = AddBlipForCoord(v.coords.xyz)
		SetBlipAsShortRange(Blip[#Blip], true)
		SetBlipSprite(Blip[#Blip], 688)
		SetBlipColour(Blip[#Blip],17)
		SetBlipScale(Blip[#Blip], 0.4)
		SetBlipDisplay(Blip[#Blip], 4)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString("Crusher")
		EndTextCommandSetBlipName(Blip[#Blip])
end

end)

RegisterNetEvent('jimlumberjack:client:hideblip', function()
	for k, v in pairs(Blip) do
		RemoveBlip(v)
	end
end)


CreateThread(function()
	JobLocation = PolyZone:Create({
		vector2(-472.15963745117, 5491.6743164062),
		vector2(-413.28948974609, 5466.4072265625),
		vector2(-409.59701538086, 5433.9560546875),
		vector2(-453.06015014648, 5343.3305664062),
		vector2(-484.22805786133, 5246.4096679688),
		vector2(-527.24548339844, 5138.7109375000),
		vector2(-605.85968017578, 5167.9365234375),
		vector2(-724.03887939453, 5184.3515625000),
		vector2(-767.96917724609, 5286.5795898438),
		vector2(-773.60748291016, 5338.3583984375),
		vector2(-680.50872802734, 5425.5415039062),
		vector2(-611.40000000000, 5531.5300000000),
	}, { name = "lumberyard", debugPoly = Config.Debug })
	JobLocation:onPlayerInOut(function(isPointInside)
		if isPointInside then makeJob()
		else stopJob() end
	end)
	--Spawn LumberYard/Clockin Blip
	-- local loc = Config.Locations["Lumberyard"][1]
	-- local blip = AddBlipForCoord(loc.coords)
	-- SetBlipAsShortRange(blip, true)
	-- SetBlipSprite(blip, loc.sprite)
	-- SetBlipColour(blip, loc.col)
	-- SetBlipScale(blip, 0.7)
	-- SetBlipDisplay(blip, 6)
	-- BeginTextCommandSetBlipName('STRING')
	-- AddTextComponentString(loc.name)
	-- EndTextCommandSetBlipName(blip)
	-- if Config.Debug then print("^5Debug^7: ^6Blip ^2created for location^7: '^6"..loc.name.."^7'") end

	-- for k, v in pairs(Config.Locations["Seller"]) do
	-- 	makePed(v.model, v.coords, 1, 1, v.scenario)
	-- 	Targets["Seller"..k] =
	-- 	exports['qb-target']:AddCircleZone("Seller"..k, v.coords.xyz, 1.0, { name="Seller"..k, debugPoly=Config.Debug, useZ=true, },
	-- 	{ options = { { event = "jim-lumberjack:openShop", icon = "fas fa-store", label = Loc[Config.Lan].info["browse_store"], job = Config.Job, ped = Peds[#Peds]}, },
	-- 		distance = 2.0 })
	-- end
	-- for k, v in pairs(Config.Locations["WoodCut"]) do
	-- 	if Config.Blips and v.blipTrue then
	-- 		local blip = AddBlipForCoord(v.coords)
	-- 		SetBlipAsShortRange(blip, true)
	-- 		SetBlipSprite(blip, v.sprite)
	-- 		SetBlipColour(blip, v.col)
	-- 		SetBlipScale(blip, 0.7)
	-- 		SetBlipDisplay(blip, 6)
	-- 		BeginTextCommandSetBlipName('STRING')
	-- 		AddTextComponentString(v.name)
	-- 		EndTextCommandSetBlipName(blip)
	-- 	if Config.Debug then print("^5Debug^7: ^6Blip ^2created for location^7: '^6"..loc.name.."^7'") end end
	-- 	loadModel(v.prop)
	-- 	PersProp[#PersProp+1] = CreateObject(v.prop, v.coords.x, v.coords.y, v.coords.z-1.03, 0, 0, 0)
	-- 	SetEntityHeading(PersProp[#PersProp], v.coords.w-180.0)
	-- 	FreezeEntityPosition(PersProp[#PersProp], 1)
	-- 	Targets["WoodCut"..k] =
	-- 		exports['qb-target']:AddCircleZone("WoodCut"..k, v.coords.xyz, 1.2, {name="WoodCut"..k, debugPoly=Config.Debug, useZ=true, },
	-- 		{ options = { { event = "jim-lumberjack:CraftMainMenu", icon = "fas fa-tree", job = Config.Job, label = Loc[Config.Lan].info["woodcut"], menu = "Wood", table = Crafting["Wood Crafting"], saw = PersProp[#PersProp] }, },
	-- 			distance = 2.0
	-- 		})
	-- end
	-- for k, v in pairs(Config.Locations["Illegal"]) do
	-- 	if Config.Blips and v.blipTrue then
	-- 		local blip = AddBlipForCoord(v.coords)
	-- 		SetBlipAsShortRange(blip, true)
	-- 		SetBlipSprite(blip, v.sprite)
	-- 		SetBlipColour(blip, v.col)
	-- 		SetBlipScale(blip, 0.7)
	-- 		SetBlipDisplay(blip, 6)
	-- 		BeginTextCommandSetBlipName('STRING')
	-- 		AddTextComponentString(v.name)
	-- 		EndTextCommandSetBlipName(blip)
	-- 		if Config.Debug then print("^5Debug^7: ^6Blip ^2created for location^7: '^6"..loc.name.."^7'") end
	-- 	end
	-- 	loadModel(v.prop)
	-- 	PersProp[#PersProp+1] = CreateObject(v.prop, v.coords.x, v.coords.y, v.coords.z-1.03, 0, 0, 0)
	-- 	SetEntityHeading(PersProp[#PersProp], v.coords.w-180.0)
	-- 	FreezeEntityPosition(PersProp[#PersProp], 1)
	-- 	Targets["IllegalCut"..k] =
	-- 		exports['qb-target']:AddCircleZone("IllegalCut"..k, v.coords.xyz, 1.2, {name="IllegalCut"..k, debugPoly=Config.Debug, useZ=true, },
	-- 		{ options = { { event = "jim-lumberjack:CraftMainMenu", icon = "fas fa-star", job = Config.Job, label = Loc[Config.Lan].info["illegalcraft"], menu = "Illegal", table = Crafting["Illegal"], saw = PersProp[#PersProp] }, },
	-- 			distance = 2.0
	-- 		})
	-- end
	for k, v in pairs(Config.Locations["Buyer"]) do
		if Config.Blips and v.blipTrue then
			local blip = AddBlipForCoord(v.coords)
			SetBlipAsShortRange(blip, true)
			SetBlipSprite(blip, v.sprite)
			SetBlipColour(blip, v.col)
			SetBlipScale(blip, 0.7)
			SetBlipDisplay(blip, 6)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString(v.name)
			EndTextCommandSetBlipName(blip)
		if Config.Debug then print("^5Debug^7: ^6Blip ^2created for location^7: '^6"..loc.name.."^7'") end end
		local name = "lumber_Buyer"..k

		exports['qb-interact']:AddInteraction({
			coords =vector3(v.coords.x, v.coords.y, v.coords.z),
			distance = 20.0,
			interactDst = 2.0, 
			name = name, 
			id =name,
			options = {
				{
					label = Loc[Config.Lan].info["sellstock"],
					event= "jim-lumberjack:SellStock",
					args={ped = makePed(v.model, v.coords, 1, 1, v.scenario) },
				},
			}
		})
		Targets[name] =name
			-- exports['qb-target']:AddCircleZone(name, v.coords.xyz, 0.9, { name=name, debugPoly=Config.Debug, useZ=true, },
			-- { options = { { event = "jim-lumberjack:SellStock", icon = "fas fa-sack-dollar", job = Config.Job, label = Loc[Config.Lan].info["sellstock"], job = Config.Job, ped = makePed(v.model, v.coords, 1, 1, v.scenario) }, },
			-- 	distance = 2.0
			-- })
	end
end)

function makeJob()
	for k, v in pairs(Config.TreePositions) do
		for _, tree in pairs(Config.Trees) do CreateModelHide(vector3(v.x, v.y, v.z), 2.0, tree, true) end
		FreezeEntityPosition(Props[#Props], true)
		if not Targets["Tree"..k] then

			-- exports['qb-interact']:AddInteraction({
			-- 	coords =vector3(v.x, v.y, v.z+2),
			-- 	distance = 4.0,
			-- 	interactDst = 2.0, 
			-- 	name = 'lumberjack_tree_'..k, 
			-- 	id ='lumberjack_tree_'..k, 
			-- 	options = {
			-- 		{
			-- 			canInteract = function(entity, coords, args)
			-- 				return QBCore.Functions.HasItem("powersaw")
			-- 			end,
			-- 			label = Loc[Config.Lan].info["cuttree"],
			-- 			event= "jim-lumberjack:client:CutTree",
			-- 			args={tree = makeProp({prop = `prop_tree_cedar_02`, coords = v}, 1, 0), id = k },
			-- 		},
			-- 	}
			-- })

			-- Targets["Tree"..k] ='lumberjack_tree_'..k

			exports['qb-target']:AddBoxZone("Tree"..k, vector3(v.x, v.y, v.z+2), 1.5, 1.5, { name="Tree"..k, heading = 0.0, debugPoly=Config.Debug, minZ = v.z, maxZ = v.z+25, },
			{ options = { { event = "jim-lumberjack:client:CutTree", icon = "fas fa-tree", job = Config.Job, item = "powersaw", label = Loc[Config.Lan].info["cuttree"], tree = makeProp({prop = `prop_tree_cedar_02`, coords = v}, 1, 0), id = k }, },
			distance = 2.0 })
		end
	end
	for k, v in pairs(Config.Locations["Saws"]) do
		-- if Config.Blips and v.blipTrue then makeBlip(v) end
		exports['qb-interact']:AddInteraction({
			coords =vector3(v.coords.x, v.coords.y, v.coords.z),
			distance = 4.0,
			interactDst = 2.0, 
			name = 'lumberjack_saw_'..k, 
			id ='lumberjack_saw_'..k, 
			options = {
				{
					canInteract = function()
						return QBCore.Functions.HasItem("paperlumber")
					end,
					label =Loc[Config.Lan].info["saw"],
					event= "jim-lumberjack:ProcessLog",
					args={  coords = v.coords, saw = makeProp(v, 1, 0) },
				},
			}
		})

		Targets["Saws"..k] ='lumberjack_saw_'..k
		-- exports['qb-target']:AddCircleZone("Saws"..k, v.coords.xyz, 1.2, {name="Saws"..k, debugPoly=Config.Debug, useZ=true, },
		-- { options = { { item = "debarkedlog", event = "jim-lumberjack:ProcessLog", icon = "fas fa-compact-disc", job = Config.Job, label = Loc[Config.Lan].info["saw"], coords = v.coords, saw = makeProp(v, 1, 0) }, },
		-- distance = 2.0
		-- 	})
		end
		for k, v in pairs(Config.Locations["Debark"]) do
			--  if Config.Blips and v.blipTrue then makeBlip(v) end

			 exports['qb-interact']:AddInteraction({
				coords =vector3(v.coords.x, v.coords.y, v.coords.z-1),
				distance = 4.0,
				interactDst = 2.0, 
				name = 'lumberjack_Debark_'..k, 
				id ='lumberjack_Debark_'..k, 
				options = {
					{
						canInteract = function()
							return QBCore.Functions.HasItem("log")
						end,
						label =Loc[Config.Lan].info["debark"],
						event= "jim-lumberjack:DebarkLog",
						args={ coords = v.coords, id = k},
					},
				}
			})

		Targets["Debark"..k] = 'lumberjack_Debark_'..k
		-- exports['qb-target']:AddBoxZone("Debark"..k, v.coords.xyz, 4.0, 1.5, { name="Debark"..k, heading = v.coords.w, debugPoly=Config.Debug, minZ = v.coords.z-1.06, maxZ = v.coords.z+0.6, },
		-- { options = { { item = "log", event = "jim-lumberjack:DebarkLog", icon = "fas fa-bacon", job = Config.Job, label = Loc[Config.Lan].info["debark"], coords = v.coords, id = k }, },
		-- distance = 2.0 })
	end
	for k, v in pairs(Config.Locations["Pulper"]) do 
		-- if Config.Blips and v.blipTrue then makeBlip(v) end
		exports['qb-interact']:AddInteraction({
			coords =vector3(v.coords.x, v.coords.y, v.coords.z-1),
			distance = 4.0,
			interactDst = 2.0, 
			name = 'lumberjack_Pulp_'..k, 
			id ='lumberjack_Pulp_'..k, 
			options = {
				{
					canInteract = function()
						return QBCore.Functions.HasItem("debarkedlog")
					end,
					label =Loc[Config.Lan].info["pulp"],
					event= "jim-lumberjack:PulpLog",
					args={coords = v.coords},
				},
			}
		})

	Targets["Pulp"..k] ='lumberjack_Pulp_'..k
		-- exports['qb-target']:AddBoxZone("Pulp"..k, v.coords.xyz, 4.8, 3.0, { name="Pulp"..k, heading = 69, debugPoly=Config.Debug, minZ = 70.99, maxZ = 78.79, },
		-- 	{ options = { { item = "debarkedlog", event = "jim-lumberjack:PulpLog", job = Config.Job, icon = "fas fa-compact-disc", label = Loc[Config.Lan].info["pulp"], coords = v.coords }, },
		-- 	distance = 2.0 })
	end
	loadModel(`prop_tool_consaw`)
end

function stopJob()
	for _, v in pairs(Config.TreePositions) do
		for _, tree in pairs(Config.Trees) do RemoveModelHide(vector3(v.x, v.y, v.z+2), 0.1, tree, true) end
	end
	for k in pairs(Targets) do
		if string.find(k, "Tree") or string.find(k, "Saws") or string.find(k, "Debark") or string.find(k, "Pulp") then
			exports['qb-interact']:RemoveInteraction(k)

			-- exports['qb-target']:RemoveZone(k) 
			Targets[k] = nil
		end
	end
	for i = 1, #Props do unloadModel(GetEntityModel(Props[i])) DeleteObject(Props[i]) TriggerEvent("fivem-appearance:client:ClearStuckProps", QBCore.Functions.GetPlayerData().source) end
	for k in pairs(Log) do unloadModel(GetEntityModel(Log[k])) DeleteObject(Log[k]) TriggerEvent("fivem-appearance:client:ClearStuckProps", QBCore.Functions.GetPlayerData().source) end
	for i = 1, #Blip do RemoveBlip(Blip[i]) end
end

function makeProp(data, freeze, synced)
	loadModel(data.prop)
	Props[#Props+1] = CreateObject(data.prop, data.coords.x, data.coords.y, data.coords.z-1.03, synced or 0, synced or 0, 0)
	SetEntityHeading(Props[#Props], data.coords.w-180.0)
	FreezeEntityPosition(Props[#Props], freeze or 0)
	if data.prop == `prop_tree_cedar_02` then
		local xRot, yRot, zRot = table.unpack({ math.random(-6,6)+.0, math.random(-6,6)+.0, math.random(-6,6)+.0,})
		SetEntityRotation(Props[#Props], yRot, rot2, zRot, 2, 0)
	end
	if Config.Debug then print("^5Debug^7: ^6Prop ^2Created ^7: '^6"..Props[#Props].."^7'") end
	return Props[#Props]
end
function makeBlip(data)
	Blip[#Blip+1] = AddBlipForCoord(data.coords)
	SetBlipAsShortRange(Blip[#Blip], true)
	SetBlipSprite(Blip[#Blip], data.sprite)
	SetBlipColour(Blip[#Blip], data.col)
	SetBlipScale(Blip[#Blip], 0.7)
	SetBlipDisplay(Blip[#Blip], (data.disp or 6))
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString(tostring(data.name))
	EndTextCommandSetBlipName(Blip[#Blip])
	if Config.Debug then print("^5Debug^7: ^6Blip ^2created for location^7: '^6"..data.name.."^7'") end
end
function makePed(model, coords, freeze, collision, scenario, anim)
	loadModel(model)
	Peds[#Peds+1] = CreatePed(0, model, coords.x, coords.y, coords.z-1.03, coords.w, false, false)
	SetEntityInvincible(Peds[#Peds], true)
	SetBlockingOfNonTemporaryEvents(Peds[#Peds], true)
	FreezeEntityPosition(Peds[#Peds], freeze or true)
    if collision then SetEntityNoCollisionEntity(Peds[#Peds], PlayerPedId(), false) end
    if scenario then TaskStartScenarioInPlace(Peds[#Peds], scenario, 0, true) end
    if anim then
        loadAnimDict(anim[1])
        TaskPlayAnim(Peds[#Peds], anim[1], anim[2], 1.0, 1.0, -1, 1, 0.2, 0, 0, 0)
    end
	if Config.Debug then print("^5Debug^7: ^6Ped ^2Created for location^7: '^6"..model.."^7'") end
    return Peds[#Peds]
end

RegisterNetEvent('jim-lumberjack:SellStock', function(data)
	data=data.args
	lookEnt(data.ped)
	local list = {"wood","paperlumber"}
	local sellMenu = {
		{ header = Loc[Config.Lan].info["headersell"], txt = Loc[Config.Lan].info["sell_txt"], isMenuHeader = true },
		{ icon = "fas fa-circle-xmark", header = "", txt = Loc[Config.Lan].info["close"], params = { event = "jim-mining:CraftMenu:Close" } } }
	for _, v in pairs(list) do
		local setheader = QBCore.Shared.Items[v].label
		local disable = true
		if HasItem(v, 1) then setheader = setheader.." 💰" disable = false end
			sellMenu[#sellMenu+1] = { disabled = disable, icon = v, header = setheader, txt = Loc[Config.Lan].info["sell_all"].." "..Config.SellItems[v].." "..Loc[Config.Lan].info["sell_each"], params = { event = "jim-lumberjack:SellAnim", args = { item = v, ped = data.ped } } }
		Wait(0)
	end
	exports['qb-menu']:openMenu(sellMenu)
end)

RegisterNetEvent('jim-lumberjack:SellAnim', function(data)
	if HasItem(data.item, 1) then
		loadAnimDict("mp_common")
		TriggerServerEvent('jim-lumberjack:Selling', data) -- Had to slip in the sell command during the animation command
		ppRot = GetEntityRotation(data.ped)
		loadAnimDict("mp_common")
		lookEnt(data.ped)
		TaskPlayAnim(PlayerPedId(), "mp_common", "givetake2_a", 100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)	--Start animations
		TaskPlayAnim(data.ped, "mp_common", "givetake2_b", 100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
		Wait(2000)
		StopAnimTask(PlayerPedId(), "mp_common", "givetake2_a", 1.0)
		StopAnimTask(data.ped, "mp_common", "givetake2_b", 1.0)
		SetEntityRotation(data.ped, 0, 0, ppRot.z ,0, 0, false) --Reset ped rotation
		unloadAnimDict("mp_common")
		TriggerEvent('jim-lumberjack:SellStock', data)
	end
end)

function breakSaw()
	if math.random(0, 100) >= 95 and Config.SawBreak then
		toggleItem(false, "powersaw", 1)
		local breakId = GetSoundId()
		PlaySoundFromEntity(breakId, "Drill_Pin_Break", PlayerPedId(), "DLC_HEIST_FLEECA_SOUNDSET", 1, 0)
	end
end

local Cutting = false
RegisterNetEvent("jim-lumberjack:client:CutTree", function(data)
	
	if not Cutting then
		LocalPlayer.state:set("inv_busy", true, true)
		Wait(1000)
		if not Cutting then Cutting = true else return end
		if #(GetEntityCoords(data.tree).xy - GetEntityCoords(PlayerPedId()).xy) >= 1.2 then
			TaskGoStraightToCoord(PlayerPedId(), GetEntityCoords(data.tree), 2.0, 1000, GetEntityHeading(PlayerPedId()), 0)
			Wait(1000)
		end
		local prop = makeProp({ prop = `prop_tool_consaw`, coords = vector4(0,0,0,0)}, 0, 1)
		DisableCamCollisionForEntity(prop)
		AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), 0.38, -0.1, 0.23, -91.0, -53.0, 2.0, true, true, false, false, 1, true)
		loadDrillSound()
		PlaySoundFromEntity(soundID, "Drill", prop, "DLC_HEIST_FLEECA_SOUNDSET", 1, 0)
		local dict = "weapons@heavy@minigun"
		local anim = "fire_high"
		loadAnimDict(tostring(dict))
		lookEnt(data.tree)
		TaskPlayAnim(PlayerPedId(), tostring(dict), tostring(anim), 3.0, 3.0, -1, 1, 0, false, false, false)
		CreateThread(function() -- Dust/Debris Animation
			Wait(200)
			loadPtfxDict("core")
			while Cutting do
				UseParticleFxAssetNextCall("core")
				local dust = StartNetworkedParticleFxNonLoopedAtCoord("ent_dst_wood_splinter", GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.235, 0.45, 0.5), 0.0, 0.0, GetEntityHeading(PlayerPedId())-180.0, 0.4, 0.0, 0.0, 0.0)
				UseParticleFxAssetNextCall("core")
				local leaves = StartNetworkedParticleFxNonLoopedAtCoord("ent_amb_falling_leaves_m", GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, GetEntityCoords(PlayerPedId()).z+2, 0.0, 0.0, GetEntityHeading(PlayerPedId())-180.0, 1.0, 0.0, 0.0, 0.0)
				Wait(100)
			end
		end)
		SetNuiFocus(true, false)
		QBCore.Functions.Progressbar('cut_tree', Loc[Config.Lan].info["cutdown"], Config.Timings["TreeCutting"], false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
		{ }, {}, {}, function()
			exports['qb-target']:RemoveZone("Tree"..data.id) Targets["Tree"..data.id] = nil
			destroyProp(prop)
			unloadDrillSound()
			StopSound(soundID)
			ClearPedTasks(PlayerPedId())
			SetEntityAlpha(data.tree, 0)
			LocalPlayer.state:set("inv_busy", false, true)
			CreateThread(function()
				Cutting = false
				breakSaw()
				Log[data.tree] = CreateObject(`prop_log_03`, vector3(GetEntityCoords(data.tree).x, GetEntityCoords(data.tree).y, GetEntityCoords(PlayerPedId()).z+2), 1, 0, 0)
				SetEntityDrawOutline(Log[data.tree], true)
				SetEntityDrawOutlineShader(1)
				SetEntityDrawOutlineColor(0,255,0,255)
				Wait(100)
				SetEntityRotation(Log[data.tree], 90.0, 90.0, 0.0, 2, 0)
				Wait(200)
				ApplyForceToEntity(Log[data.tree], 1, 0.5, 0.0, 0, 4.0, 0, 0, 0, 1, 1, 1, 0, 0)
				exports["qb-target"]:AddTargetEntity(Log[data.tree], { options = { { event = "jim-lumberjack:client:LogCut", icon = 'fas fa-hand-scissors', label = Loc[Config.Lan].info["cutlog"], item = "powersaw", tree = data.tree, id = data.id } }, distance = 2.5,	})
				Wait(5000)
				FreezeEntityPosition(Log[data.tree], true)
				SetNuiFocus(false, false)
				Wait(20000)
				destroyProp(Log[data.tree])
			end)
		end, function()
			Cutting = false
			destroyProp(prop)
			unloadDrillSound()
			StopSound(soundID)
			ClearPedTasks(PlayerPedId())
			LocalPlayer.state:set("inv_busy", false, true)
			SetNuiFocus(false, false)
		end, data.icon)
	end
end)
RegisterNetEvent("jim-lumberjack:client:LogCut", function(data)
	if not Cutting then
		LocalPlayer.state:set("inv_busy", true, true)
		if not Cutting then Cutting = true else return end
		if #(GetEntityCoords(Log[data.tree]) - GetEntityCoords(PlayerPedId())) > 1.2 then
			TaskGoStraightToCoord(PlayerPedId(), GetEntityCoords(Log[data.tree]), 2.0, 1000, GetEntityHeading(PlayerPedId()), 0)
			Wait(1000)
		end
		lookEnt(Log[data.tree])
		loadModel(`prop_tool_consaw`)
		local prop = CreateObject(`prop_tool_consaw`, GetEntityCoords(PlayerPedId()), true, true, true)
		DisableCamCollisionForEntity(prop)
		AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), 0.05, 0.14, 0.34, -76.0, -111.0, 29.0, true, true, false, false, 1, true)
		loadDrillSound()
		PlaySoundFromEntity(soundID, "Drill", prop, "DLC_HEIST_FLEECA_SOUNDSET", 1, 0)
		local dict = "weapons@heavy@minigun"
		local anim = "fire_low"
		loadAnimDict(tostring(dict))
		TaskPlayAnim(PlayerPedId(), tostring(dict), tostring(anim), 3.0, 3.0, -1, 1, 0, false, false, false)
		CreateThread(function() -- Dust/Debris Animation
			Wait(200)
			loadPtfxDict("core")
			while Cutting do
				UseParticleFxAssetNextCall("core")
				local dust = StartNetworkedParticleFxNonLoopedAtCoord("ent_dst_wood_splinter", GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.23, 0.5, -0.5), 0.0, 0.0, GetEntityHeading(PlayerPedId())-180.0, 0.4, 0.0, 0.0, 0.0)
				Wait(200)
			end
		end)
		QBCore.Functions.Progressbar('washing_hands', Loc[Config.Lan].info["logcutting"], Config.Timings["LogCutting"], false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
		{}, {}, {}, function()
			Cutting = false
			breakSaw()
			exports["qb-target"]:RemoveTargetEntity(Log[data.tree])
			destroyProp(prop)
			unloadDrillSound()
			StopSound(soundID)
			ClearPedTasks(PlayerPedId())
			destroyProp(Log[data.tree])
			LocalPlayer.state:set("inv_busy", false, true)
			CreateThread(function()
				Wait(Config.Timings["TreeSpawn"])
				SetEntityAlpha(data.tree, 255)
				Targets["Tree"..data.id] =
					exports['qb-target']:AddBoxZone("Tree"..data.id, vector3(GetEntityCoords(data.tree).x, GetEntityCoords(data.tree).y, GetEntityCoords(data.tree).z+2), 1.5, 1.5, { name="Tree"..data.id, heading = 0.0, debugPoly=Config.Debug, minZ = GetEntityCoords(data.tree).z, maxZ = GetEntityCoords(data.tree).z+25, },
					{ options = { { event = "jim-lumberjack:client:CutTree", icon = "fas fa-hand-scissors", job = Config.Job, item = "powersaw", label = "Cưa cây", tree = data.tree, id = data.id }, },
						distance = 2.0 })
			end)
			if math.random(0, 100) >= 95 then
				toggleItem(true, "loghiem", 1)
			else
				toggleItem(true, "log", 1)
			end
			if math.random(0, 100) >= 93 then
				toggleItem(true, "manhghepchiakhoa2", 1)
			end
			destroyProp(Log[data.tree])
		end, function()
			Cutting = false
			destroyProp(prop)
			unloadDrillSound()
			StopSound(soundID)
			ClearPedTasks(PlayerPedId())
			LocalPlayer.state:set("inv_busy", false, true)
			destroyProp(Log[data.tree])
		end, data.icon)
	end
end)
RegisterNetEvent("jim-lumberjack:DebarkLog", function(data)
	data=data.args
	if not Cutting then
		LocalPlayer.state:set("inv_busy", true, true)
		if not Cutting then Cutting = true else return end
		TaskStartScenarioInPlace(PlayerPedId(), "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 0, true)
		Wait(1000)
		local log = makeProp({prop = `prop_log_01`, coords = data.coords }, 1, 1)
		for _, prop in pairs(Props) do SetEntityNoCollisionEntity(log, prop, 0) end
		CreateThread(function()
			DisableCamCollisionForEntity(log)
			SetEntityNoCollisionEntity(log, PlayerPedId(), 0)
			SetEntityRotation(log, 15.0, 0.0, 250.0, 2, 0)
			Wait(2000)
			ClearPedTasks(PlayerPedId())
			while Cutting do
				local sawoff = GetOffsetFromEntityInWorldCoords(log, 0- tonumber( "0."..(math.random(0,3))), math.random(-1,1) + tonumber( "0."..(math.random(0,9))), 0)
				local yforce = 1.0
				FreezeEntityPosition(log, false)
				if data.id == 1 then yforce = -0.05 end
				ApplyForceToEntity(log, 1, -1.2, yforce, 0.1, 0.0, 0.0, 0.2, 0, 0, 0, 1, 0, 0)
				UseParticleFxAssetNextCall("core")
				StartNetworkedParticleFxNonLoopedAtCoord("ent_dst_wood_splinter", sawoff.x, sawoff.y, sawoff.z, 0.0, 0.0, math.random(0, 359)+.0, 0.4, 0.0, 0.0, 0.0)
				local sawoff = GetOffsetFromEntityInWorldCoords(log, 0- tonumber( "0."..(math.random(0,3))), math.random(-1,1) + tonumber( "0."..(math.random(0,9))), 0)
				UseParticleFxAssetNextCall("core")
				StartNetworkedParticleFxNonLoopedAtCoord("ent_dst_wood_splinter", sawoff.x, sawoff.y, sawoff.z, 0.0, 0.0, math.random(0, 359)+.0, 0.4, 0.0, 0.0, 0.0)
				Wait(100)
			end
		end)
		QBCore.Functions.Progressbar('washing_hands', Loc[Config.Lan].info["debarking"], Config.Timings["Debark"], false, true, { disableMovement = false, disableCarMovement = true, disableMouse = false, disableCombat = true, },
		{}, {}, {}, function()
			Cutting = false
			destroyProp(log)
			toggleItem(false, "log", 1)
			toggleItem(true, "debarkedlog", 1)
			unloadDrillSound()
			StopSound(soundID)
			ClearPedTasks(PlayerPedId())
			LocalPlayer.state:set("inv_busy", false, true)
		end, function()
			Cutting = false
			destroyProp(log)
			unloadDrillSound()
			StopSound(soundID)
			ClearPedTasks(PlayerPedId())
			LocalPlayer.state:set("inv_busy", false, true)
		end, data.icon)
	end
end)
RegisterNetEvent("jim-lumberjack:ProcessLog", function(data)
	data=data.args
	if not Cutting then
		LocalPlayer.state:set("inv_busy", true, true)
		if not Cutting then Cutting = true else return end
		lookEnt(data.saw)
		local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(data.saw, 0.1, -0.1, 1.445))
		local log = makeProp({prop = `prop_snow_fncwood_14a`, coords = vector4(x, y, z, GetEntityHeading(data.saw))}, 1, 1)
		local xRot, yRot, _ = table.unpack(GetEntityRotation(data.saw))
		SetEntityRotation(log, xRot + 270.0, yRot, GetEntityHeading(data.saw)+90, 2, 0)
		loadAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
		TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.5, 1.5, 0.3, 16, 0.2, 0, 0, 0)
		loadDrillSound()
		PlaySoundFromEntity(soundID, "Drill", log, "DLC_HEIST_FLEECA_SOUNDSET", 1, 0)
		CreateThread(function()
			local sawoff = GetOffsetFromEntityInWorldCoords(log, 0.0, 0.0, 0.1)
			while Cutting do
				loadPtfxDict("core")
				while Cutting do
					UseParticleFxAssetNextCall("core")
					local dust = StartNetworkedParticleFxNonLoopedAtCoord("ent_dst_wood_splinter", sawoff.x, sawoff.y, sawoff.z, 90.0, 0.0, GetEntityHeading(data.saw)+180, 0.4, 0.0, 0.0, 0.0)
					Wait(100)
				end
			end
		end)
		QBCore.Functions.Progressbar('washing_hands', Loc[Config.Lan].info["processing"], Config.Timings["Processing"], false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
		{}, {}, {}, function()
			Cutting = false
			destroyProp(log)
			toggleItem(false, "paperlumber", 1)
			toggleItem(true, "wood", 1)
			--toggleItem(true, "bark", math.random(1, 7))
			unloadDrillSound()
			StopSound(soundID)
			ClearPedTasks(PlayerPedId())
			LocalPlayer.state:set("inv_busy", false, true)
		end, function()
			Cutting = false
			destroyProp(log)
			unloadDrillSound()
			StopSound(soundID)
			ClearPedTasks(PlayerPedId())
			LocalPlayer.state:set("inv_busy", false, true)
		end, data.icon)
	end
end)
RegisterNetEvent("jim-lumberjack:PulpLog", function(data)
	data=data.args
	if not Cutting then
		LocalPlayer.state:set("inv_busy", true, true)
		if not Cutting then Cutting = true else return end
		TaskStartScenarioInPlace(PlayerPedId(), "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 0, true)
		Wait(1000)
		local log = makeProp({ prop = `prop_snow_fncwood_14a`, coords = data.coords }, 0, 0)
		CreateThread(function()
			local zcoord = data.coords.z - 0.5
			while Cutting do
				zcoord = zcoord - 0.003
				SetEntityCoords(log, vector3(data.coords.x, data.coords.y, zcoord))
				local xRot, yRot, zRot = table.unpack({ math.random(-6,6)+.0, math.random(-6,6)+.0, math.random(-6,6)+.0,})
				SetEntityRotation(log, yRot, rot2, zRot, 2, 0)
				Wait(10)
			end
		end)
		CreateThread(function()
			loadPtfxDict("core")
			while Cutting do
				UseParticleFxAssetNextCall("core")
				local dust = StartNetworkedParticleFxNonLoopedAtCoord("ent_dst_wood_splinter", data.coords.x, data.coords.y, data.coords.z-1.5, 0.0, 0.0, math.random(0,359)+.0, 0.7, 0.0, 0.0, 0.0)
				Wait(20)
			end
		end)
		QBCore.Functions.Progressbar('washing_hands', Loc[Config.Lan].info["pulping"], Config.Timings["PulpLog"], false, true, { disableMovement = false, disableCarMovement = true, disableMouse = false, disableCombat = true, },
		{}, {}, {}, function()
			Cutting = false
			destroyProp(log)
			toggleItem(false, "debarkedlog", 1)
			--toggleItem(true, "bark", math.random(1, 5))
			-- if math.random(0, 100) >= 95 then
			toggleItem(true, "paperlumber", 1)
			--end
			unloadDrillSound()
			StopSound(soundID)
			ClearPedTasks(PlayerPedId())
			LocalPlayer.state:set("inv_busy", false, true)
		end, function()
			Cutting = false
			destroyProp(log)
			unloadDrillSound()
			StopSound(soundID)
			ClearPedTasks(PlayerPedId())
			LocalPlayer.state:set("inv_busy", false, true)
		end, data.icon)
	end
end)

-- RegisterNetEvent("jim-lumberjack:CraftMainMenu", function(data)
-- 	local MenuSelect = {}
-- 	MenuSelect[#MenuSelect+1] = { isMenuHeader = true, icon = data.icon, header = data.label, txt = "" }
-- 	MenuSelect[#MenuSelect+1] = { icon = "fas fa-xmark", header = "", txt = Loc[Config.Lan].info["close"], params = { event = "" } }
-- 	if data.menu == "Wood" then
-- 		for k, v in pairsByKeys(data.table) do
-- 			MenuSelect[#MenuSelect+1] = { header = k, txt = Loc[Config.Lan].info["section"]..countTable(v), params = { event = "jim-lumberjack:SubMenu", args = { icon = data.icon, menu = data.menu, table = data.table, label = data.label, label2 = k, subtable = v, saw = data.saw }} }
-- 		end
-- 	end
-- 	if data.menu == "Illegal" then
-- 		for k, v in pairsByKeys(data.table) do
-- 			MenuSelect[#MenuSelect+1] = { header = k, txt = Loc[Config.Lan].info["section"]..countTable(v), params = { event = "jim-lumberjack:SubMenu", args = { icon = data.icon, menu = data.menu, table = data.table, label = data.label, label2 = k, subtable = v, saw = data.saw }} }
-- 		end
-- 	end
-- 	exports['qb-menu']:openMenu(MenuSelect)
-- end)

RegisterNetEvent('jim-lumberjack:openShop', function(data)
	lookEnt(data.ped)
	if Config.JimShops then event = "jim-shops:ShopOpen" else event = "inventory:server:OpenInventory" end
	TriggerServerEvent(event, "shop", "lumberyard", Config.Items)
end)

-- RegisterNetEvent("jim-lumberjack:SubMenu", function(data)
-- 	local MenuSelect = {}
-- 	MenuSelect[#MenuSelect+1] = { isMenuHeader = true, icon = data.icon, header = data.label, txt = data.label2 }
-- 	MenuSelect[#MenuSelect + 1] = { icon = "fas fa-arrow-left", header = "", txt = Loc[Config.Lan].info["return"], params = { event = "jim-lumberjack:CraftMainMenu", args = data } }
-- 	for k, v in pairsByKeys(data.subtable) do
-- 		MenuSelect[#MenuSelect+1] = { header = k, txt = "Recipes: "..countTable(v), params = {
-- 			event = "jim-lumberjack:CraftMenu", args = { icon = data.icon, menu = data.menu, table = data.table, label = data.label, label2 = data.label2, label3 = k, subtable = data.subtable, craftable = v } }
-- 		}
-- 	end
-- 	exports['qb-menu']:openMenu(MenuSelect)
-- end)

-- RegisterNetEvent('jim-lumberjack:CraftMenu', function(data)
-- 	--"Loading"
-- 	exports['qb-menu']:openMenu({
-- 		{ icon = data.icon, header = data.label3, txt = data.label.." - "..data.label2, isMenuHeader = true },
-- 		{ icon = "fas fa-bars-progress", header = "", txt = Loc[Config.Lan].info["finding"], isMenuHeader = true, isDisabled = true },
-- 		{ icon = "fas fa-arrow-left", header = "", txt = Loc[Config.Lan].info["return"], params = { event = "jim-lumberjack:CraftMainMenu", args = data } }
-- 	})
-- 	local CraftMenu = {}
-- 	CraftMenu[#CraftMenu + 1] = { icon = data.icon, header = data.label3, txt = data.label.." - "..data.label2, isMenuHeader = true }
-- 	CraftMenu[#CraftMenu + 1] = { icon = "fas fa-arrow-left", header = "", txt = Loc[Config.Lan].info["return"], params = { event = "jim-lumberjack:SubMenu", args = data } }
-- 	for i = 1, #data.craftable do
-- 		for k in pairsByKeys(data.craftable[i]) do
-- 			if k ~= "amount" and QBCore.Shared.Items[k] then
-- 				local amount, text, setheader, settext, disabled = table.unpack({ "", "", "", "", false })
-- 				if QBCore.Shared.Items[k] then setheader = QBCore.Shared.Items[k].label else setheader = k.."(?)" end
-- 				if data.craftable[i].amount and data.craftable[i].amount > 1 then setheader = setheader.." x"..data.craftable[i].amount end
-- 				local disable = false
-- 				local checktable = {}
-- 				for l, b in pairs(data.craftable[i][tostring(k)]) do
-- 					if b == 1 then number = "" else number = " x"..b end
-- 					text = text.."- "..QBCore.Shared.Items[l].label..number.."<br>"
-- 					settext = text
-- 					checktable[l] = HasItem(l, b)
-- 				end
-- 				for _, v in pairs(checktable) do if v == false then disable = true break end end
-- 				if not disable then setheader = setheader.." ✔️" end
-- 				CraftMenu[#CraftMenu + 1] = { icon = k, disabled = disable, header = setheader, txt = settext, params = { event = "jim-lumberjack:MakeItem", args = { item = k, tablenumber = i, craftable = data.craftable, menu = data.menu, table = data.table, subtable = data.subtable, saw = data.saw, label = data.label, label2 = data.label2, } } }
-- 			end
-- 		end
-- 	end
-- 	exports['qb-menu']:openMenu(CraftMenu)
-- end)

-- RegisterNetEvent('jim-lumberjack:MakeItem', function(data)
-- 	for k in pairs(data.craftable[data.tablenumber]) do
-- 		if data.item == k then
-- 			if not HasItem(data.craftable[data.tablenumber][data.item]) then
-- 				TriggerEvent('QBCore:Notify', Loc[Config.Lan].error["no_ingredients"], 'error')
-- 				TriggerEvent('jim-lumberjack:CraftMenu', data)
-- 			else
-- 				lookEnt(data.saw)
-- 				animDictNow = "amb@prop_human_parking_meter@male@idle_a"
-- 				animNow = "idle_a"
-- 				LocalPlayer.state:set("inv_busy", true, true)
-- 				QBCore.Functions.Progressbar('making_food', Loc[Config.Lan].info["craft"]..QBCore.Shared.Items[data.item].label, Config.Timings["Crafting"], false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
-- 				{ animDict = animDictNow, anim = animNow, flags = 8, }, {}, {}, function()
-- 					TriggerServerEvent('jim-lumberjack:GetItem', data)
-- 					LocalPlayer.state:set("inv_busy", false, true)
-- 				end, function() -- Cancel
-- 					TriggerEvent('QBCore:Notify', Loc[Config.Lan].error["cancelled"], 'error')
-- 					StopAnimTask(PlayerPedId(), animDictNow, animNow, 1.0)
-- 					LocalPlayer.state:set("inv_busy", false, true)
-- 				end, data.item)
-- 			end
-- 		end
-- 	end
-- end)


-- PROP FUN
local cardHat = nil
RegisterNetEvent("jim-mechanic:carboardHat", function()
	if DoesEntityExist(cardHat) then
		unloadModel(`v_ind_cfbox2`)
		loadAnimDict("missheist_agency2ahelmet")
		TaskPlayAnim(PlayerPedId(), "missheist_agency2ahelmet", "take_off_helmet_stand", 3.0, 3.0, 1200, 51, 0, 0, 0, 0)
		CreateThread(function()
			Wait(600)
			AttachEntityToEntity(cardHat, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), 0.08, 0.0, 0.13, 100.0, 18.0, -144.0, true, true, false, false, 1, true)
		end)
		Wait(1200)
		StopAnimTask(PlayerPedId(), "take_off_helmet_stand", "missheist_agency2ahelmet", 0)
		SetEntityAsMissionEntity(cardHat, true, true)
		Wait(10)
		destroyProp(cardHat)
		cardHat = nil
		return
	end
	if not DoesEntityExist(cardHat) then
		loadModel(`v_ind_cfbox2`)
		cardHat = CreateObject(`v_ind_cfbox2`, GetEntityCoords(PlayerPedId()), true, true, true)
		AttachEntityToEntity(cardHat, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), 0.03, -0.03, 0.0, 100.0, 10.0, -92.0, true, true, false, false, 1, true)
		loadAnimDict("mp_masks@standard_car@ds@")
		TaskPlayAnim(PlayerPedId(), "mp_masks@standard_car@ds@", "put_on_mask", 3.0, 3.0, 600, 51, 0, 0, 0, 0)
		Wait(600)
		StopAnimTask(PlayerPedId(), "put_on_mask", "mp_masks@standard_car@ds@", 0)
		AttachEntityToEntity(cardHat, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 12844), 0.03, -0.03, 0.0, 100.0, 10.0, -92.0, true, true, false, false, 1, true)
	end
end)

local walkingStick = nil
RegisterNetEvent('jim-lumberjack:walkstick', function()
	if not DoesEntityExist(walkingStick) then
		walkingStick = makeProp({ prop = `prop_cs_walking_stick`, coords = vector4(0, 0, 0, 0)}, 0, 1)
		AttachEntityToEntity(walkingStick, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.16, 0.06, 0.0, 335.0, 300.0, 120.0, true, true, false, true, 5, true)
		RequestAnimSet('move_heist_lester')	while not HasAnimSetLoaded('move_heist_lester') do Wait(1) end
		SetPedMovementClipset(PlayerPedId(), 'move_heist_lester', 1.0)
	else
		ResetPedMovementClipset(PlayerPedId(), 1.0)
		destroyProp(walkingStick)
	end
end)

local origami = nil
RegisterNetEvent('jim-lumberjack:origamiani', function()
	if not origami then origami = true else print("no") return end
	loadModel(`prop_paper_ball`)
	loadAnimDict("missheistfbisetup1")
	loadAnimDict("impexp_int-0")
	TaskPlayAnim(PlayerPedId(), "missheistfbisetup1", "hassle_intro_loop_f", 3.0, 1.0, -1, 1, 0, false, false, false)
	Wait(3000)
	StopAnimTask(PlayerPedId(), "hassle_intro_loop_f", "missheistfbisetup1")
	TaskPlayAnim(PlayerPedId(), "impexp_int-0", "mp_m_waremech_01_dual-0", 3.0, 1.0, -1, 16, 0, false, false, false)
	local prop = CreateObject(`prop_paper_ball`, GetEntityCoords(PlayerPedId()), true, true, true)
	AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), 0.16, 0.06, 0.07, 0.0, 0.0, 0.0, true, true, false, false, 1, true)
	Wait(8000)
	StopAnimTask(PlayerPedId(), "mp_m_waremech_01_dual-0", "impexp_int-0")
	destroyProp(prop)
	origami = nil
end)

AddEventHandler('onResourceStop', function(resource) if resource ~= GetCurrentResourceName() then return end
	for _, v in pairs(Config.TreePositions) do
		for _, tree in pairs(Config.Trees) do RemoveModelHide(vector3(v.x, v.y, v.z+2), 0.1, tree, true) end
	end
	for k in pairs(Targets) do exports['qb-target']:RemoveZone(k) end
	for _, v in pairs(Peds) do unloadModel(GetEntityModel(v)) DeletePed(v) end
	for i = 1, #Props do unloadModel(GetEntityModel(Props[i])) DeleteObject(Props[i]) end
	for i = 1, #PersProp do unloadModel(GetEntityModel(PersProp[i])) DeleteObject(PersProp[i]) end
	for k in pairs(Log) do unloadModel(GetEntityModel(Log[k])) DeleteObject(Log[k]) end
	for i = 1, #Blip do RemoveBlip(Blip[i]) end
	DeleteEntity(cardHat)
	StopSound(soundID)
end)