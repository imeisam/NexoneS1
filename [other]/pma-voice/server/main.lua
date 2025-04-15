local QBCore = exports['qb-core']:GetCoreObject()
voiceData = {}
radioData = {}
callData = {}
local jammerId = 0
local Jammers = {}

function defaultTable(source)
	handleStateBagInitilization(source)
	return {
		radio = 0,
		call = 0,
		lastRadio = 0,
		lastCall = 0
	}
end

function handleStateBagInitilization(source)
	local plyState = Player(source).state
	if not plyState.pmaVoiceInit then 
		plyState:set('radio', GetConvarInt('voice_defaultRadioVolume', 30), true)
		plyState:set('call', GetConvarInt('voice_defaultCallVolume', 60), true)
		plyState:set('proximity', {}, true)
		plyState:set('callChannel', 0, true)
		plyState:set('radioChannel', 0, true)
		plyState:set('voiceIntent', 'speech', true)
		-- We want to save voice inits because we'll automatically reinitalize calls and channels
		plyState:set('pmaVoiceInit', true, false)
	end
end

CreateThread(function()

	local plyTbl = GetPlayers()
	for i = 1, #plyTbl do
		local ply = tonumber(plyTbl[i])
		voiceData[ply] = defaultTable(plyTbl[i])
	end

	Wait(5000)

	local nativeAudio = GetConvar('voice_useNativeAudio', 'false')
	local _3dAudio = GetConvar('voice_use3dAudio', 'false')
	local _2dAudio = GetConvar('voice_use2dAudio', 'false')
	local sendingRangeOnly = GetConvar('voice_useSendingRangeOnly', 'false')
	local gameVersion = GetConvar('gamename', 'fivem')

	-- handle no convars being set (default drag n' drop)
	if
		nativeAudio == 'false'
		and _3dAudio == 'false'
		and _2dAudio == 'false'
	then
		if gameVersion == 'fivem' then
			SetConvarReplicated('voice_useNativeAudio', 'true')
			if sendingRangeOnly == 'false' then
				SetConvarReplicated('voice_useSendingRangeOnly', 'true')
			end
			logger.info('No convars detected for voice mode, defaulting to \'setr voice_useNativeAudio true\' and \'setr voice_useSendingRangeOnly true\'')
		else
			SetConvarReplicated('voice_use3dAudio', 'true')
			if sendingRangeOnly == 'false' then
				SetConvarReplicated('voice_useSendingRangeOnly', 'true')
			end
			logger.info('No convars detected for voice mode, defaulting to \'setr voice_use3dAudio true\' and \'setr voice_useSendingRangeOnly true\'')
		end
	elseif sendingRangeOnly == 'false' then
		logger.warn('It\'s recommended to have \'voice_useSendingRangeOnly\' set to true you can do that with \'setr voice_useSendingRangeOnly true\', this prevents players who directly join the mumble server from broadcasting to players.')
	end

	if GetConvar('gamename', 'fivem') == 'rdr3' then
		if nativeAudio == 'true' then
			logger.warn("RedM doesn't currently support native audio, automatically switching to 3d audio. This also means that submixes will not work.")
			SetConvarReplicated('voice_useNativeAudio', 'false')
			SetConvarReplicated('voice_use3dAudio', 'true')
		end
	end

	local radioVolume = GetConvarInt("voice_defaultRadioVolume", 30)
	local callVolume = GetConvarInt("voice_defaultCallVolume", 60)

	-- When casted to an integer these get set to 0 or 1, so warn on these values that they don't work
	if
		radioVolume == 0 or radioVolume == 1 or
		callVolume == 0 or callVolume == 1
	then
		SetConvarReplicated("voice_defaultRadioVolume", 30)
		SetConvarReplicated("voice_defaultCallVolume", 60)
		for i = 1, 5 do
			Wait(5000)
			logger.warn("`voice_defaultRadioVolume` or `voice_defaultCallVolume` have their value set as a float, this is going to automatically be fixed but please update your convars.")
		end
	end
end)

AddEventHandler('playerJoining', function()
	if not voiceData[source] then
		voiceData[source] = defaultTable(source)
	end
end)

AddEventHandler("playerDropped", function()
	local source = source
	if voiceData[source] then
		local plyData = voiceData[source]

		if plyData.radio ~= 0 then
			removePlayerFromRadio(source, plyData.radio)
		end

		if plyData.call ~= 0 then
			removePlayerFromCall(source, plyData.call)
		end

		voiceData[source] = nil
	end
end)

if GetConvarInt('voice_externalDisallowJoin', 0) == 1 then
	AddEventHandler('playerConnecting', function(_, _, deferral)
		deferral.defer()
		Wait(0)
		deferral.done('This server is not accepting connections.')
	end)
end

-- only meant for internal use so no documentation
function isValidPlayer(source)
	return voiceData[source]
end
exports('isValidPlayer', isValidPlayer)

function getPlayersInRadioChannel(channel)
	local returnChannel = radioData[channel]
	if returnChannel then
		return returnChannel
	end
	-- channel doesnt exist
	return {}
end
exports('getPlayersInRadioChannel', getPlayersInRadioChannel)
exports('GetPlayersInRadioChannel', getPlayersInRadioChannel)

local PlayersZones = {}
local PlayersCoords = {}
local PoliceVehicles = {}
local DispatchRooms = {}

RegisterNetEvent('pma-voice:server:SetRadioStation', function(which)
	local src = source
	PlayersZones[src] = which
	TriggerClientEvent('pma-voice:client:SetRadioStation', -1, PlayersZones)
end)

RegisterNetEvent('pma-voice:server:SetRadioCoords', function(coords)
	local src = source
	PlayersCoords[src] = coords
	TriggerClientEvent('pma-voice:client:SetRadioCoords', -1, src, coords)
end)

RegisterNetEvent('pma-voice:server:PoliceVehicleState', function(state)
	local src = source
	PoliceVehicles[src] = state
	TriggerClientEvent('pma-voice:client:PoliceVehicleState', -1, src, state)
end)

RegisterNetEvent('pma-voice:server:InDispatchRoom', function(state)
	local src = source
	DispatchRooms[src] = state
	TriggerClientEvent('pma-voice:client:InDispatchRoom', -1, src, state)
end)

AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
    TriggerClientEvent('pma-voice:client:SetRadioStation', Player.PlayerData.source, PlayersZones)
	TriggerClientEvent('pma-voice:client:SetRadioCoordsMelat', Player.PlayerData.source, PlayersCoords)
	TriggerClientEvent('pma-voice:client:PoliceVehicleStateMelat', Player.PlayerData.source, PoliceVehicles)
	TriggerClientEvent('pma-voice:client:InDispatchRoomMelat', Player.PlayerData.source, DispatchRooms)
	TriggerClientEvent('pma-voice:client:setupJammers', Player.PlayerData.source, Jammers)
end)

AddEventHandler("playerDropped", function()
	local src = source
	if PlayersZones[src] then
		PlayersZones[src] = nil
		TriggerClientEvent('pma-voice:client:SetRadioStation', -1, PlayersZones)
	end
	if PlayersCoords[src] then
		PlayersCoords[src] = nil
		TriggerClientEvent('pma-voice:client:SetRadioCoords', -1, src, nil)
	end
	if PoliceVehicles[src] then
		PoliceVehicles[src] = nil
		TriggerClientEvent('pma-voice:client:PoliceVehicleState', -1, src, nil)
	end
	if DispatchRooms[src] then
		DispatchRooms[src] = nil
		TriggerClientEvent('pma-voice:client:InDispatchRoom', -1, src, nil)
	end
end)

QBCore.Functions.CreateUseableItem("radiojammer", function(source, item)
    TriggerClientEvent("pma-voice:client:setupJammer", source, item.slot)
end)

RegisterNetEvent('pma-voice:server:setupJammer', function(data)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local slot = data.back
	if not slot then return end
    local coords = data.coords
	local heading = data.heading
    local item = Player.PlayerData.items[slot]
	if not item then return end
	if item.name ~= 'radiojammer' then return end
    if Player.Functions.RemoveItem(item.name, 1, slot) then
        TriggerClientEvent('qb-inventory:client:pickupAnim', src)
        SetTimeout(2000, function()
			local currentId = jammerId + 1
			jammerId = currentId
			Jammers[currentId] = {
				coords = coords,
				heading = heading,
				active = false
			}
			TriggerClientEvent('pma-voice:client:spawnJammer', -1, currentId, coords, heading, active)
        end)
    end
end)

RegisterNetEvent('pma-voice:server:pickUpJammer', function(id)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local jammer = Jammers[id]
	if jammer then
        if Player.Functions.AddItem('radiojammer', 1) then
			Jammers[id]	= nil
			TriggerClientEvent('qb-inventory:client:pickupAnim', src)
			TriggerClientEvent('pma-voice:client:removeJammer', -1, id)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['radiojammer'], 'add')
		else
			TriggerClientEvent('QBCore:Notify', src, 'You Do Not Have Enough Space!', 'error')
		end
	end
end)

RegisterNetEvent('pma-voice:server:ToggleJammer', function(id)
	local src = source
	local jammer = Jammers[id]
	if jammer then
		if #(GetEntityCoords(GetPlayerPed(src)) - jammer.coords) >= 10 then return end
		Jammers[id].active = not Jammers[id].active
		if Jammers[id].active then
			TriggerClientEvent('QBCore:Notify', src, 'You Active Jammer', 'success')
		else
			TriggerClientEvent('QBCore:Notify', src, 'You Deactive Jammer', 'error')
		end
		TriggerClientEvent('pma-voice:client:ToggleJammer', -1, id, Jammers[id].active)
	end
end)

QBCore.Functions.CreateUseableItem("antiradiojammer", function(source, item)
    TriggerClientEvent("pma-voice:client:antiJammer", source)
end)