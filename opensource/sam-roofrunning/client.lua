QBCore = exports['qb-core']:GetCoreObject()
local zoneid
local robstart=false
local count=0
local max=0
local carryPackage=nil
local hasitems=false
local blip=nil
RegisterNetEvent('sam-Roofrunning:client:removesync', function(coord,model)
	entity=GetClosestObjectOfType(coord, 2.5 ,GetHashKey(model), 0, 0, 0)
	SetEntityAsMissionEntity(entity, false, false)
	DeleteEntity(entity)
end)
RegisterNetEvent('sam-Roofrunning:removeobject', function(entity)
	
	local hasItem = QBCore.Functions.HasItem(config.itemneed)
	if not hasItem then
		QBCore.Functions.Notify("You Don't have a item", "error")
		return
	end
	
		if IsEntityAnObject(entity) then
			GetCheckItem()
			if hasitems then
				QBCore.Functions.Notify("You Have AC to inventory....", "error")
				return
			end
			if math.random(1,100)<60 then
				exports['qb-dispatch']:roofruning()
			end
			local reshack=exports['nxo-MiniGames']:samehack(7,7,30000)
			if not reshack then
				QBCore.Functions.Notify("Faild...", "error")
				return
			end
			
			TriggerEvent('animations:client:EmoteCommandStart', {'mechanic4'})
			QBCore.Functions.Progressbar("do_chakosh", "Robing AC", 10000, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {
			}, {}, {}, function() -- Done
				TriggerServerEvent("inventory:server:breakItem", config.itemneed, 3)
				TriggerEvent('animations:client:EmoteCommandStart', {'c'})
				SetEntityAsMissionEntity(entity, false, false)
			DeleteEntity(entity)
			Wait(500)
		   if not DoesEntityExist(entity) then
			count=count+1
			exports["nxo-oui"]:Show('Task', 'Search Assigned Area<br/>collected '..count..'/'..config.multi)
			TriggerServerEvent('sam-Roofrunning:server:additem')
			TriggerServerEvent('sam-Roofrunning:server:removesync',GetEntityCoords(entity),GetEntityModel(entity))
			QBCore.Functions.Notify("Rob Complete", "success")
			GetCheckItem()
			if count==config.multi then
				leave()
		  	 end
		   end
			end, function() -- Cancel
				TriggerEvent('animations:client:EmoteCommandStart', {'c'})
				QBCore.Functions.Notify("Canceled...!", "error")
				
			end)
			
			
   
		end
end)
RegisterNetEvent('sam-Roofrunning:client:checkitem', function()
	GetCheckItem()
end)

RegisterNetEvent('inventory:client:CreateNewDrop', function()
	GetCheckItem()
end)


function PickupPackage()
	if not carryPackage then
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped, true)
		RequestAnimDict("anim@heists@box_carry@")
		while (not HasAnimDictLoaded("anim@heists@box_carry@")) do
			Wait(7)
		end
		TaskPlayAnim(ped, "anim@heists@box_carry@" ,"idle", 5.0, -1, -1, 50, 0, false, false, false)
		local model = GetHashKey("prop_aircon_m_08")
		RequestModel(model)
		while not HasModelLoaded(model) do Wait(0) end
		local object = CreateObject(model, pos.x, pos.y, pos.z-10.0, true, true, true)
		AttachEntityToEntity(object, ped, GetPedBoneIndex(ped, 57005), 0.2, -0.3, 0, 300.0, 250.0, 20.0, true, true, false, true, 1, true)
		carryPackage = object
	else
		local ped = PlayerPedId()
		RequestAnimDict("anim@heists@box_carry@")
		while (not HasAnimDictLoaded("anim@heists@box_carry@")) do
			Wait(7)
		end
		TaskPlayAnim(ped, "anim@heists@box_carry@" ,"idle", 5.0, -1, -1, 50, 0, false, false, false)
	end
end

function DropPackage()
	if carryPackage then
		ClearPedTasks(PlayerPedId())
		DetachEntity(carryPackage, true, true)
		DeleteObject(carryPackage)
		DeleteEntity(carryPackage)
		carryPackage = nil
	end
end

-- CreateThread(function()
-- 	local model = GetHashKey(config.pedmodel)
--     RequestModel(model)
--     while not HasModelLoaded(model) do
--         Wait(1)
--     end
--     local ped = CreatePed(4, model,config.pedcoord.x,config.pedcoord.y,config.pedcoord.z, false, false)
--     SetEntityInvincible(ped, true)
--     FreezeEntityPosition(ped, true)
--     SetBlockingOfNonTemporaryEvents(ped, true)
-- 	TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_GUARD_STAND', 0, true)
--     SetEntityHeading(ped,config.pedcoord.w)

--     exports['qb-target']:AddTargetEntity(ped, {
--         options = {
--             {
--                 event = "sam-Roofrunning:client:startrob",
--                 icon = "fas fa-cash-register",
--                 label = "Sign In",
--             },
--         },
--         distance = 1.5
--     })
-- end)
RegisterNetEvent('inventory:client:Close', function()
	GetCheckItem()
end)

function GetCheckItem()
	local hasitem=false
	for k, v in pairs(config.giveitemlist) do
		local hitem = QBCore.Functions.HasItem(v)
		if hitem then
			hasitem=true
		end
	end

		if hasitem then
			hasitems=true
			PickupPackage()
		else
			hasitems=false
			DropPackage()
		end
	
end
exports("GetCheckItem",GetCheckItem)
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
	DropPackage()
end)
RegisterNetEvent('QBCore:Client:SetPlayerData', function(val)
	GetCheckItem()
end)
RegisterNetEvent('qb-atmrobbery:client:UpdateEmote', function(val)
	GetCheckItem()
end)
local CurrentCops=0
RegisterNetEvent('police:SetCopCount', function(amount,amounthigh)
    CurrentCops = amount
end)
RegisterNetEvent('sam-Roofrunning:client:startrob', function()

	if robstart then
		QBCore.Functions.Notify("You Already Start Rob...!", "error")
		return
	end
	
	if not exports["qb-smallresources"]:getdevelopermode() and config.policerequire>CurrentCops then
		QBCore.Functions.Notify("Not Enough Police", "error")
		return
	end

	local hasItem = QBCore.Functions.HasItem(config.itemneed)
	if not hasItem then
		QBCore.Functions.Notify("You Don't have a item", "error")
		return
	end

	QBCore.Functions.TriggerCallback('sam-Roofrunning:server:getregistercooldown', function(result,idzone)
		if not result then
			QBCore.Functions.Notify("Not Allowed This time!", "error")
			return 
		end
	zoneid=idzone
	exports["nxo-oui"]:Show('Task', 'Wait For Give Email...')
	max=0
	robstart=true
	timeoutrob()
	TriggerServerEvent('sam-Roofrunning:server:startrob',zoneid)

	TriggerServerEvent('qb-phone:server:sendNewMail', {
		sender = 'Boss',
		subject = "Search Location Roof Runing",
		message ='Please Wait for search best location for AC Rob</br>Please Wait...',
		button = {}
	})
	
	-- Wait(config.accepttime)

	-- local success = exports['qb-phone']:PhoneNotification("ACrob", 'Do You Accept AC Robbery?', 'fa fa-home', '#b3e0f2', "NONE", 'fas fa-check-circle', 'fas fa-times-circle')
	-- if not success then
	-- 	QBCore.Functions.Notify("You Canceled AC Rob...!", "error")
	-- 	return
	-- end
	exports["nxo-oui"]:Show('Task', '<b>Head to Location On GPS</b>')
	 blip = AddBlipForRadius(config.zone[zoneid].coord.x,config.zone[zoneid].coord.y,config.zone[zoneid].coord.z, config.zone[zoneid].radius) 
	SetBlipColour(blip,1)
	SetBlipAlpha (blip, 128)

	dist=config.zone[zoneid].radius+1
	while dist>config.zone[zoneid].radius do
		cord=GetEntityCoords(PlayerPedId())
		dist=#(vector2(cord.x,cord.y)-vector2(config.zone[zoneid].coord.x,config.zone[zoneid].coord.y))
		Wait(100)
	end
	exports["nxo-oui"]:Show('Task', 'Search Assigned Area<br/>collected 0/'..config.multi)
	GetCheckItem()

	max=config.multi
	count=0
	exports['qb-target']:AddTargetModel(config.model, {
		options = {
			{
				type = "client",
				icon = 'fa-solid fa-screwdriver',
				label = 'Rob AC',
				action = function(entity)
					TriggerEvent("sam-Roofrunning:removeobject", entity)
				end,
				canInteract = function()
                    return robstart and #(config.zone[zoneid].coord.xyz-GetEntityCoords(PlayerPedId()).xyz)<config.zone[zoneid].radius and count<max 
                end
			},
		},
		distance = 1.5
	})

end)

end)
function leave()
	robstart=false
	exports["nxo-oui"]:Show('Task', 'leave the area <br/> make Sure you arenot followed')
	dist=1
	while dist<100 do 
		cord=GetEntityCoords(PlayerPedId())
		dist=#(vector2(cord.x,cord.y)-vector2(config.zone[zoneid].coord.x,config.zone[zoneid].coord.y))
		Wait(100)
	end
	if blip then
		RemoveBlip(blip)
	end
	blip=nil
	exports["nxo-oui"]:Close()
end


function timeoutrob()
CreateThread(function()
	Wait((config.robtimeout*60)*1000)
	if blip then
		RemoveBlip(blip)
	end
	blip=nil
	QBCore.Functions.Notify("AC Rob Time out!", "error")
	robstart=false
	max=0
	zoneid=0
	exports["nxo-oui"]:Close()
end)

end