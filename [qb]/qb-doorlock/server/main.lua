-- Functions

local function showWarning(msg)
	print(('^3%s: %s^0'):format(Lang:t("general.warning"), msg))
end

local function removeItem(Player, item)
	if Config.Consumables[item.name] then
		Player.Functions.RemoveItem(item.name, item.amount >= Config.Consumables[item.name] and Config.Consumables[item.name] or 1)
	end
end

local function checkAndRemoveItem(Player, item, shouldRemove)
	if not item then return false end
	if shouldRemove then
		removeItem(Player, item)
	end
	return true
end

local function checkItems(Player, items, needsAll, shouldRemove)
	if needsAll == nil then needsAll = true end
	local isTable = type(items) == 'table'
	local isArray = isTable and table.type(items) == 'array' or false
	local totalItems = 0
	local count = 0
	if isTable then for _ in pairs(items) do totalItems += 1 end else totalItems = #items end
	local kvIndex
	if isArray then kvIndex = 2 else kvIndex = 1 end
	if isTable then
		for k, v in pairs(items) do
			local itemKV = {k, v}
			local item = Player.Functions.GetItemByName(itemKV[kvIndex])
			if needsAll then
				if checkAndRemoveItem(Player, item, false) then
					count += 1
				end
			else
				if checkAndRemoveItem(Player, item, shouldRemove) then
					return true
				end
			end
		end
		if count == totalItems then
			for k, v in pairs(items) do
				local itemKV = {k, v}
				local item = Player.Functions.GetItemByName(itemKV[kvIndex])
				checkAndRemoveItem(Player, item, shouldRemove)
			end
			return true
		end
	else -- Single item as string
		local item = Player.Functions.GetItemByName(items)
		return checkAndRemoveItem(Player, item, shouldRemove)
	end
	return false
end

local function isAuthorized(Player, door, usedLockpick, id)
	if door.allAuthorized then return true end
	if CoreName == "qb-core" or CoreName == "qbx_core" then
		if Config.AdminAccess and Core.Functions.HasPermission(Player.PlayerData.source, Config.AdminPermission) then
			if Config.Warnings then
				showWarning(Lang:t("general.warn_admin_privilege_used", {player = Player.PlayerData.name, license = Player.PlayerData.license}))
			end
			return true
		end
	elseif CoreName == "es_extended" then
		local pData = GetPlayer(Player.source)
		local pGroup = pData.getGroup()
		if Config.AdminAccess and pGroup == Config.CommandPermission then
			return true
		end
	end
	if (door.pickable or door.lockpick) and usedLockpick then return true end
	local acJob = GetPlayerJob(id)
	local acGrade = GetPlayerGrade(id)
	if door.authorizedJobs then
		if door.authorizedJobs[acJob.name] and acGrade >= door.authorizedJobs[acJob.name] then
			return true
		elseif type(door.authorizedJobs[1]) == 'string' then
			for _, job in pairs(door.authorizedJobs) do -- Support for old format
				if job == acJob.name then return true end
			end
		end
	-- else
	-- 	return true
	end

	if door.authorizedGangs then
		if door.authorizedGangs[Player.PlayerData.gang.name] and acGrade >= door.authorizedGangs[Player.PlayerData.gang.name] then
			return true
		elseif type(door.authorizedGangs[1]) == 'string' then
			for _, gang in pairs(door.authorizedGangs) do -- Support for old format
				if gang == Player.PlayerData.gang.name then return true end
			end
		end
	end

	if door.authorizedCitizenIDs then
		if door.authorizedCitizenIDs[Player.PlayerData.citizenid] then
			return true
		elseif type(door.authorizedCitizenIDs[1]) == 'string' then
			for _, id in pairs(door.authorizedCitizenIDs) do -- Support for old format
				if id == Player.PlayerData.citizenid then return true end
			end
		end
	end
	if door.items then return checkItems(Player, door.items, door.needsAllItems, true) end

	return false
end

-- Callbacks
CreateCallback('qb-doorlock:server:setupDoors', function(_, cb)
	cb(Config.DoorList)
end)

CreateCallback('qb-doorlock:server:checkItems', function(source, cb, items, needsAll)
	local Player = GetPlayer(source)
	cb(checkItems(Player, items, needsAll, false))
end)

-- Events
RegisterNetEvent('qb-doorlock:server:updateState', function(doorID, locked, src, usedLockpick, unlockAnyway, enableSounds, enableAnimation, sentSource)
	local playerId = sentSource or source
	local Player = GetPlayer(playerId)
	local name = nil
	if CoreName == "qb-core" or CoreName == "qbx_core" then
		name = Player.PlayerData.name
    elseif CoreName == "es_extended" then
		name = GetPlayerName(playerId)
	end
	local license = nil
	if CoreName == "qb-core" or CoreName == "qbx_core" then
		license = Player.PlayerData.license
    elseif CoreName == "es_extended" then
		license = Player.identifier
	end
	if not Player then return end
	if type(doorID) ~= 'number' and type(doorID) ~= 'string' then
		if Config.Warnings then
			showWarning((Lang:t("general.warn_wrong_doorid_type", {player = name, license = license, doorID = doorID})))
		end
		return
	end

	if type(locked) ~= 'boolean' then
		if Config.Warnings then
			showWarning((Lang:t("general.warn_wrong_state", {player = name, license = license, state = locked})))
		end
		return
	end

	if not Config.DoorList[doorID] then
		if Config.Warnings then
			showWarning(Lang:t("general.warn_wrong_doorid", {player = ame, license = license, doorID = doorID}))
		end
		return
	end

	if not unlockAnyway and not isAuthorized(Player, Config.DoorList[doorID], usedLockpick, playerId) then
		if Config.Warnings then
			showWarning(Lang:t("general.warn_no_authorisation", {player = name, license = license, doorID = doorID}))
		end
		return
	end

	Config.DoorList[doorID].locked = locked
	if Config.DoorStates[doorID] == nil then Config.DoorStates[doorID] = locked elseif Config.DoorStates[doorID] ~= locked then Config.DoorStates[doorID] = nil end
	TriggerClientEvent('qb-doorlock:client:setState', -1, playerId, doorID, locked, src or false, enableSounds, enableAnimation)

	if not Config.DoorList[doorID].autoLock then return end
	SetTimeout(Config.DoorList[doorID].autoLock, function()
		if Config.DoorList[doorID].locked then return end
		Config.DoorList[doorID].locked = true
		if Config.DoorStates[doorID] == nil then Config.DoorStates[doorID] = locked elseif Config.DoorStates[doorID] ~= locked then Config.DoorStates[doorID] = nil end
		TriggerClientEvent('qb-doorlock:client:setState', -1, playerId, doorID, true, src or false, enableSounds, enableAnimation)
	end)
end)

RegisterNetEvent('qb-doorlock:server:saveNewDoor', function(data, doubleDoor)
	local src = source
	if CoreName == "qb-core" or CoreName == "qbx_core" then
		if not Core.Functions.HasPermission(src, Config.CommandPermission) and not IsPlayerAceAllowed(src, 'command') then
			if Config.Warnings then
				showWarning(Lang:t("general.warn_no_permission_newdoor", {player = GetPlayerName(src), license = Core.Functions.GetIdentifier(src, 'license'), source = src}))
			end
			return
		end
	elseif CoreName == "es_extended" then
		local pData = GetPlayer(src)
		local pGroup = pData.getGroup()
		if not pGroup == Config.CommandPermission then
			if Config.Warnings then
				showWarning(Lang:t("general.warn_no_permission_newdoor", {player = GetPlayerName(src), license = Core.Functions.GetIdentifier(src, 'license'), source = src}))
			end
			return
		end
	end
	local Player = GetPlayer(src)
	if not Player then return end
	local configData = {}
	local jobs, gangs, cids, items, doorType, identifier
	if data.job then configData.authorizedJobs = { [data.job] = 0 } jobs = "['"..data.job.."'] = 0" end
	if data.gang then configData.authorizedGangs = { [data.gang] = 0 } gangs = "['"..data.gang.."'] = 0" end
	if data.cid then configData.authorizedCitizenIDs = { [data.cid] = true } cids = "['"..data.cid.."'] = true" end
	if data.item then configData.items = { [data.item] = 1 } items = "['"..data.item.."'] = 1" end
	configData.locked = data.locked
	configData.pickable = data.pickable
	configData.cantUnlock = data.cantunlock
	configData.svgDistance = data.svgDistance
	configData.interactDistance = data.interactDistance
	configData.doorType = data.doortype
	if data.allAuthorized then
		configData.allAuthorized = true
	end
	if data.passCode == '' then 
		configData.passCode = nil 
	else 
		configData.passCode = "'"..data.passCode.."'"
	end
	configData.doorRate = 1.0
	doorType = "'"..data.doortype.."'"
	identifier = data.configfile..'-'..data.dooridentifier
	if doubleDoor then
		configData.doors = {
			{objName = data.model[1], objYaw = data.heading[1], objCoords = data.coords[1]},
			{objName = data.model[2], objYaw = data.heading[2], objCoords = data.coords[2]}
		}
	else
		configData.objName = data.model
		configData.objYaw = data.heading
		configData.objCoords = data.coords
		configData.fixText =data.fixText-- data.fixText
		configData.hiddentext= data.hiddentext

	end

	local path = GetResourcePath(GetCurrentResourceName())
	if data.configfile then
		local tempfile, err = io.open(path:gsub('//', '/')..'/doors/'..string.gsub(data.configfile, ".lua", "")..'.lua', 'a+')
		if tempfile then
			tempfile:close()
			path = path:gsub('//', '/')..'/doors/'..string.gsub(data.configfile, ".lua", "")..'.lua'
		else
			return error(err)
		end
	else
		path = path:gsub('//', '/')..'/config.lua'
	end
	local name = nil
	if CoreName == "qb-core" or CoreName == "qbx_core" then
		name = Player.PlayerData.name
    elseif CoreName == "es_extended" then
		name = GetPlayerName(src)
	end
	local file = io.open(path, 'a+')
	local label = "\n\n-- "..data.dooridentifier.." ".. Lang:t("general.created_by") .." "..name.."\nConfig.DoorList['"..identifier.."'] = {"
	file:write(label)
	for k, v in pairs(configData) do
		if k == 'authorizedJobs' or k == 'authorizedGangs' or k == 'authorizedCitizenIDs' or k == 'items' then
			local auth = jobs
			if k == 'authorizedGangs' then
				auth = gangs
			elseif k == 'authorizedCitizenIDs' then
				auth = cids
			elseif k == 'items' then
				auth = items
			end
			local str = ("\n    %s = { %s },"):format(k, auth)
			file:write(str)
		elseif k == 'doors' then
			local doors = {}
			for i = 1, 2 do
				doors[i] = ("    {objName = %s, objYaw = %s, objCoords = %s}"):format(configData.doors[i].objName, configData.doors[i].objYaw, configData.doors[i].objCoords)
			end
			local str = ("\n    %s = {\n    %s,\n    %s\n    },"):format(k, doors[1], doors[2])
			file:write(str)
		elseif k == 'doorType' then
			local str = ("\n    %s = %s,"):format(k, doorType)
			file:write(str)
		else
			local str = ("\n    %s = %s,"):format(k, v)
			file:write(str)
		end
	end
	file:write("\n}")
	file:close()
	Config.DoorList[identifier] = configData
	TriggerClientEvent('qb-doorlock:client:newDoorAdded', -1, configData, identifier, src)
end)

-- Commands
Citizen.CreateThread(function()
	while CoreReady == false do Citizen.Wait(0) end
	if CoreName == "qb-core" or CoreName == "qbx_core" then
		Core.Commands.Add('createsingledoor', Lang:t("general.newdoor_command_description"), {}, false, function(source)
			TriggerClientEvent('qb-doorlock:client:createNewSingleDoor', source)
		end, Config.CommandPermission)
		Core.Commands.Add('createdoubledoor', Lang:t("general.newdoor_command_description"), {}, false, function(source)
			TriggerClientEvent('qb-doorlock:client:createNewDoubleDoor', source)
		end, Config.CommandPermission)
		Core.Commands.Add('doordebug', Lang:t("general.doordebug_command_description"), {}, false, function(source)
			TriggerClientEvent('qb-doorlock:client:ToggleDoorDebug', source)
		end, Config.CommandPermission)
	elseif CoreName == "es_extended" then
		Core.RegisterCommand('createsingledoor', Config.CommandPermission, function(xPlayer, args, showError)
			xPlayer.triggerEvent('qb-doorlock:client:createNewSingleDoor')
		end, false, {help = Lang:t("general.newdoor_command_description")})
		Core.RegisterCommand('createdoubledoor', Config.CommandPermission, function(xPlayer, args, showError)
			xPlayer.triggerEvent('qb-doorlock:client:createNewDoubleDoor')
		end, false, {help = Lang:t("general.newdoor_command_description")})
		Core.RegisterCommand('doordebug', Config.CommandPermission, function(xPlayer, args, showError)
			xPlayer.triggerEvent('qb-doorlock:client:ToggleDoorDebug')
		end, false, {help = Lang:t("general.doordebug_command_description")})
	end
end)