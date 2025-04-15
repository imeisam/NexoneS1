local QBCore = exports['qb-core']:GetCoreObject()
local mutedPlayers = {}

-- we can't use GetConvarInt because its not a integer, and theres no way to get a float... so use a hacky way it is!
local volumes = {
	-- people are setting this to 1 instead of 1.0 and expecting it to work.
	['radio'] = GetConvarInt('voice_defaultRadioVolume', 30) / 100,
	['call'] = GetConvarInt('voice_defaultCallVolume', 60) / 100,
}

radioEnabled, radioPressed, mode = true, false, GetConvarInt('voice_defaultVoiceMode', 2)
radioData = {}
radioChannel = 0
callData = {}
local Jammers = {}
local jammerSetuped = false
local AvtiveTask = false

--- function setVolume
--- Toggles the players volume
---@param volume number between 0 and 100
---@param volumeType string the volume type (currently radio & call) to set the volume of (opt)
function setVolume(volume, volumeType)
	type_check({volume, "number"})
	local volume = volume / 100
	
	if volumeType then
		local volumeTbl = volumes[volumeType]
		if volumeTbl then
			LocalPlayer.state:set(volumeType, volume, true)
			volumes[volumeType] = volume
		else
			error(('setVolume got a invalid volume type %s'):format(volumeType))
		end
	else
		-- _ is here to not mess with global 'type' function
		for _type, vol in pairs(volumes) do
			volumes[_type] = volume
			LocalPlayer.state:set(_type, volume, true)
		end
	end
end

exports('setRadioVolume', function(vol)
	setVolume(vol, 'radio')
end)
exports('getRadioVolume', function()
	return volumes['radio']
end)
exports("setCallVolume", function(vol)
	setVolume(vol, 'call')
end)
exports('getCallVolume', function()
	return volumes['call']
end)

if gameVersion == 'fivem' then
	radioEffectId = CreateAudioSubmix('Radio')
	SetAudioSubmixEffectRadioFx(radioEffectId, 1)
	SetAudioSubmixEffectParamInt(radioEffectId, 1, `default`, 1)
	SetAudioSubmixEffectParamFloat(radioEffectId, 1, `freq_low`, 100.0)
	SetAudioSubmixEffectParamFloat(radioEffectId, 1, `freq_hi`, 5000.0)
	SetAudioSubmixEffectParamFloat(radioEffectId, 1, `rm_mod_freq`, 300.0)
	SetAudioSubmixEffectParamFloat(radioEffectId, 1, `rm_mix`, 0.1)
	SetAudioSubmixEffectParamFloat(radioEffectId, 1, `fudge`, 4.0)
	SetAudioSubmixEffectParamFloat(radioEffectId, 1, `o_freq_lo`, 300.0)
	SetAudioSubmixEffectParamFloat(radioEffectId, 1, `o_freq_hi`, 5000.0)
	AddAudioSubmixOutput(radioEffectId, 1)

	radioMEffectId = CreateAudioSubmix('RadioM')
	SetAudioSubmixEffectRadioFx(radioMEffectId, 1)
	SetAudioSubmixEffectParamInt(radioMEffectId, 1, `default`, 1)
	SetAudioSubmixEffectParamFloat(radioMEffectId, 1, `freq_low`, 100.0)
	SetAudioSubmixEffectParamFloat(radioMEffectId, 1, `freq_hi`, 5000.0)
	SetAudioSubmixEffectParamFloat(radioMEffectId, 1, `rm_mod_freq`, 300.0)
	SetAudioSubmixEffectParamFloat(radioMEffectId, 1, `rm_mix`, 0.35)
	SetAudioSubmixEffectParamFloat(radioMEffectId, 1, `fudge`, 8.0)
	SetAudioSubmixEffectParamFloat(radioMEffectId, 1, `o_freq_lo`, 300.0)
	SetAudioSubmixEffectParamFloat(radioMEffectId, 1, `o_freq_hi`, 5000.0)
	AddAudioSubmixOutput(radioMEffectId, 1)

	radioFEffectId = CreateAudioSubmix('RadioF')
	SetAudioSubmixEffectRadioFx(radioFEffectId, 1)
	SetAudioSubmixEffectParamInt(radioFEffectId, 1, `default`, 1)
	SetAudioSubmixEffectParamFloat(radioFEffectId, 1, `freq_low`, 100.0)
	SetAudioSubmixEffectParamFloat(radioFEffectId, 1, `freq_hi`, 5000.0)
	SetAudioSubmixEffectParamFloat(radioFEffectId, 1, `rm_mod_freq`, 300.0)
	SetAudioSubmixEffectParamFloat(radioFEffectId, 1, `rm_mix`, 0.5)
	SetAudioSubmixEffectParamFloat(radioFEffectId, 1, `fudge`, 10.0)
	SetAudioSubmixEffectParamFloat(radioFEffectId, 1, `o_freq_lo`, 300.0)
	SetAudioSubmixEffectParamFloat(radioFEffectId, 1, `o_freq_hi`, 5000.0)
	AddAudioSubmixOutput(radioFEffectId, 1)

	radioJEffectId = CreateAudioSubmix('RadioJ')
	SetAudioSubmixEffectRadioFx(radioJEffectId, 1)
	SetAudioSubmixEffectParamInt(radioJEffectId, 1, `default`, 1)
	SetAudioSubmixEffectParamFloat(radioJEffectId, 1, `freq_low`, 100.0)
	SetAudioSubmixEffectParamFloat(radioJEffectId, 1, `freq_hi`, 5000.0)
	SetAudioSubmixEffectParamFloat(radioJEffectId, 1, `rm_mod_freq`, 300.0)
	SetAudioSubmixEffectParamFloat(radioJEffectId, 1, `rm_mix`, 0.95)
	SetAudioSubmixEffectParamFloat(radioJEffectId, 1, `fudge`, 17.0)
	SetAudioSubmixEffectParamFloat(radioJEffectId, 1, `o_freq_lo`, 300.0)
	SetAudioSubmixEffectParamFloat(radioJEffectId, 1, `o_freq_hi`, 5000.0)
	AddAudioSubmixOutput(radioJEffectId, 1)

	callEffectId = CreateAudioSubmix('Call')
	SetAudioSubmixEffectRadioFx(callEffectId, 1)
	SetAudioSubmixEffectParamInt(callEffectId, 1, `default`, 1)
	SetAudioSubmixEffectParamFloat(callEffectId, 1, `freq_low`, 300.0)
	SetAudioSubmixEffectParamFloat(callEffectId, 1, `freq_hi`, 6000.0)
	AddAudioSubmixOutput(callEffectId, 1)
end

local submixFunctions = {
	['radio'] = function(plySource)
		MumbleSetSubmixForServerId(plySource, radioEffectId)
	end,
	['radioM'] = function(plySource)
		MumbleSetSubmixForServerId(plySource, radioMEffectId)
	end,
	['radioF'] = function(plySource)
		MumbleSetSubmixForServerId(plySource, radioFEffectId)
	end,
	['radioJ'] = function(plySource)
		MumbleSetSubmixForServerId(plySource, radioJEffectId)
	end,
	['call'] = function(plySource)
		MumbleSetSubmixForServerId(plySource, callEffectId)
	end
}

local ZonesRadio = {
    {
        name = 'radioLS',
        zone = {
            vector2(-2222.833984375, -3125.5891113281),
            vector2(-1523.2595214844, -1796.3289794922),
            vector2(-2577.6662597656, -457.16879272461),
            vector2(-1469.8596191406, 671.29284667969),
			vector2(264.12432861328, 820.60729980469),
			vector2(1422.2370605469, 282.95626831055),
			vector2(1352.0386962891, -1116.1527099609),
			vector2(1557.9276123047, -1876.2985839844),
			vector2(1513.5300292969, -3327.4077148438),
			vector2(374.34265136719, -3599.7133789062)
        },
    },
	{
        name = 'radioSandy',
        zone = {
			vector2(-56.74715423584, 2589.1435546875),
			vector2(700.078125, 2084.6154785156),
			vector2(1785.369140625, 2200.56640625),
			vector2(2841.4836425781, 3181.1945800781),
			vector2(2970.6110839844, 4630.2534179688),
			vector2(1917.4936523438, 5294.3447265625),
			vector2(1678.6223144531, 4546.1787109375),
			vector2(2270.7272949219, 4416.9448242188),
			vector2(1757.1066894531, 4062.5490722656),
			vector2(463.6428527832, 3767.3542480469),
			vector2(-27.85391998291, 3318.9631347656)
        },
    },
	{
        name = 'radioPaleto',
        zone = {
			vector2(-491.15490722656, 5214.4868164062),
			vector2(-1016.01171875, 5718.7607421875),
			vector2(-400.01586914062, 6552.1044921875),
			vector2(393.08218383789, 7030.943359375),
			vector2(671.61450195312, 6378.7631835938),
			vector2(158.47109985352, 6026.6596679688),
			vector2(-270.87448120117, 5492.3564453125)
        },
    },
}

CreateThread(function()
	local whichZone = ''
    for k,v in ipairs(ZonesRadio) do
        local zone = PolyZone:Create(v.zone, {
            name = v.name,
            minZ = -1000,
            maxZ = 1000,
            debugPoly = false
        })
		zone:onPlayerInOut(function(isPointInside)
			if isPointInside then
				whichZone = v.name
				TriggerServerEvent('pma-voice:server:SetRadioStation', whichZone)
			else
				if whichZone == v.name then
					whichZone = ''
					TriggerServerEvent('pma-voice:server:SetRadioStation', whichZone)
				end
			end
		end)
    end
end)

local pdatas = {}
RegisterNetEvent('pma-voice:client:SetRadioStation', function(ddd)
	pdatas = ddd
end)

local function GetPlayerZone(serverID)
	local me = pdatas[GetPlayerServerId(PlayerId())]
    local zone = pdatas[serverID]
    if me and zone then
		if me ~= '' and zone ~= '' and me == zone then
			return true
		end
    end
	return false
end

CreateThread(function()
	while true do
		Wait(10000)
		TriggerServerEvent('pma-voice:server:SetRadioCoords', GetEntityCoords(PlayerPedId()))
	end
end)

local pdatacoords = {}
RegisterNetEvent('pma-voice:client:SetRadioCoordsMelat', function(mlt)
	pdatacoords = mlt
end)
RegisterNetEvent('pma-voice:client:SetRadioCoords', function(k,v)
	pdatacoords[k] = v
end)

local function GetPlayerDistance(serverID)
    local coords = pdatacoords[serverID]
    if coords then
		return #(GetEntityCoords(PlayerPedId()) - coords)
    else
        return 1000
    end
end

local inPoliceVehicle = false
local inPoliceVehicles = {}
AddEventHandler("baseevents:enteredVehicle", function(pCurrentVehicle)
    if GetVehicleClass(pCurrentVehicle) == 18 or IsPedInAnyHeli(PlayerPedId()) or IsPedInAnyPlane(PlayerPedId()) then
        if not inPoliceVehicle then
			inPoliceVehicle = true
            TriggerServerEvent('pma-voice:server:PoliceVehicleState', true)
        end
    end
end)
AddEventHandler("baseevents:leftVehicle", function()
    if inPoliceVehicle then
		inPoliceVehicle = false
		TriggerServerEvent('pma-voice:server:PoliceVehicleState', false)
    end
end)
RegisterNetEvent('pma-voice:client:PoliceVehicleState', function(who, state)
	inPoliceVehicles[who] = state
end)
RegisterNetEvent('pma-voice:client:PoliceVehicleStateMelat', function(mlt)
	inPoliceVehicles = mlt
end)

local DispatchRooms = {
    {
        name = 'MRPDDispatchRoom',
        zone = {
            vector2(461.85375976562, -990.55712890625),
            vector2(461.62692260742, -984.10919189453),
            vector2(454.25085449219, -984.07989501953),
            vector2(454.19354248047, -986.00274658203),
			vector2(451.40908813477, -986.19445800781),
			vector2(451.62902832031, -990.42926025391),
        },
		minZ = 29.0,
		maxZ = 32.0,
    },
	{
        name = 'VespucciDispatchRoom',
        zone = {
            vector2(-1084.8005371094, -827.73608398438),
            vector2(-1078.4488525391, -822.53570556641),
			vector2(-1081.9816894531, -818.65209960938),
			vector2(-1087.5024414062, -824.26116943359),
        },
		minZ = 28.6,
		maxZ = 25.5,
    },
	{
        name = 'LSMedicalcenterDispatchRoom',
        zone = {
			vector2(348.42010498047, -1429.5202636719),
            vector2(351.05285644531, -1431.9577636719),
			vector2(353.37268066406, -1428.9224853516),
			vector2(350.63073730469, -1426.5810546875),
        },
		minZ = 31.0,
		maxZ = 33.0,
    },
}

local InDsipatchRoom = false
local InDispatchRooms = {}
CreateThread(function()
	local wichRoom = ''
    for k,v in ipairs(DispatchRooms) do
        local zone = PolyZone:Create(v.zone, {
            name = v.name,
            minZ = v.minZ,
            maxZ = v.maxZ,
            debugPoly = false
        })
		zone:onPlayerInOut(function(isPointInside)
			if isPointInside then
				wichRoom = v.name
				InDsipatchRoom = true
				TriggerServerEvent('pma-voice:server:InDispatchRoom', true)
			else
				if wichRoom == v.name then
					whichZone = ''
					InDsipatchRoom = false
					TriggerServerEvent('pma-voice:server:InDispatchRoom', false)
				end
			end
		end)
    end
end)
RegisterNetEvent('pma-voice:client:InDispatchRoom', function(who, state)
	InDispatchRooms[who] = state
end)
RegisterNetEvent('pma-voice:client:InDispatchRoomMelat', function(mlt)
	InDispatchRooms = mlt
end)

local function inJammerZone(coords)
	for k,v in pairs(Jammers) do
		if v.active and #(coords - v.coords) <= 200 then
			return k
		end
	end
	return false
end

local function RotationToDirection(rotation)
	local adjustedRotation =
	{
		x = (math.pi / 180) * rotation.x,
		y = (math.pi / 180) * rotation.y,
		z = (math.pi / 180) * rotation.z
	}
	local direction =
	{
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

local function RayCastGamePlayCamera(distance)
    local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)
	local destination =
	{
		x = cameraCoord.x + direction.x * distance,
		y = cameraCoord.y + direction.y * distance,
		z = cameraCoord.z + direction.z * distance
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestSweptSphere(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, 0.2, 339, PlayerPedId(), 4))
	return b, c, e
end

local function CreateJammer(id, coords, heading, active)
	local x, y, z = table.unpack(coords)
    local model = GetHashKey('ch_prop_ch_mobile_jammer_01x')
	RequestModel(model) while not HasModelLoaded(model) do Wait(2) end
    local obj = CreateObject(model,x,y,z,false,false,false)
    SetEntityHeading(obj, heading)
    FreezeEntityPosition(obj, true)
    SetEntityCollision(obj, false)
    Jammers[id] = {obj=obj,coords=coords,active=active}
    exports['qb-interact']:AddInteraction({
        coords =vector3(x, y, z+0.2),
        distance = 5.0,
        interactDst = 1.2, 
        id = "voice-jammer-"..id,
        options = {
			{
                label = 'Toggle Active',
				action = function()
					Wait(math.random(100, 300))
					TriggerServerEvent("pma-voice:server:ToggleJammer", id)
				end,
            },
            {
                label = 'Pick Up',
				action = function()
					if not AvtiveTask and not Player(GetPlayerServerId(PlayerId())).state['isDead'] and not Player(GetPlayerServerId(PlayerId())).state['isCuffed'] and not IsPauseMenuActive() then
						Wait(math.random(100, 300))
						TriggerServerEvent("pma-voice:server:pickUpJammer", id)
					end
				end,
            },
        }
    })

end

RegisterNetEvent('pma-voice:client:setupJammer', function(data)
	if IsPedInAnyVehicle(PlayerPedId(), false) then return end
    if not AvtiveTask then
        AvtiveTask = true
        local ModelHash = GetHashKey('ch_prop_ch_mobile_jammer_01x')
        RequestModel(ModelHash)
        while not HasModelLoaded(ModelHash) do Wait(0) end
        exports['qb-core']:DrawText('Place', 'left', 'E')
        local plant = CreateObject(ModelHash, 1.0, 1.0, 1.0, 0.0, false, false)
        SetEntityCollision(plant, false, false)
        SetEntityAlpha(plant, 150, true)
        FreezeEntityPosition(plant, true)
        local ycoords = GetEntityCoords(PlayerPedId())
        ycoords=vector3(ycoords.x,ycoords.y,ycoords.z-1)
        local heading = 0.0
        while true do
            Wait(3)
            local hit, coords, entity = RayCastGamePlayCamera(10.0)
            if hit then
                if #(coords - GetEntityCoords(PlayerPedId())) < 3 then
                    ycoords = coords
                end
                SetEntityCoords(plant, ycoords.x, ycoords.y, ycoords.z)
                SetEntityHeading(plant, heading)
                if IsControlJustPressed(0, 174) then
                    heading = heading - 3.0
                end
                if IsControlJustPressed(0, 175) then
                    heading = heading + 3.0
                end
                if heading == 360.0 or heading == -360.0 then
                    heading = 0.0
                end
                if IsControlJustPressed(0, 38) then
                    exports['qb-core']:KeyPressed(38)
                    DeleteObject(plant)
                    TriggerServerEvent("pma-voice:server:setupJammer", {back = data, coords = ycoords, heading = heading})
                    AvtiveTask = false
                    return
                end
                if IsControlJustPressed(0, 202) then
                    exports['qb-core']:KeyPressed(202)
                    DeleteObject(plant)
                    AvtiveTask = false
                    return
                end
            end
        end
    end
end)

RegisterNetEvent('pma-voice:client:setupJammers', function(data)
	if jammerSetuped then return end
	jammerSetuped = true
	for k,v in pairs(data) do
		CreateJammer(k, v.coords, v.heading, v.active)
	end
end)

RegisterNetEvent('pma-voice:client:spawnJammer', function(id, coords, heading, active)
	CreateJammer(id, coords, heading, active)
end)

RegisterNetEvent('pma-voice:client:removeJammer', function(id)
	if Jammers[id] then
        exports['qb-interact']:RemoveInteraction("voice-jammer-"..id)
		DeleteObject(Jammers[id].obj)
		Jammers[id] = nil
	end
end)

RegisterNetEvent('pma-voice:client:ToggleJammer', function(id, toggle)
	if Jammers[id] then
        Jammers[id].active = toggle
	end
end)

RegisterNetEvent('pma-voice:client:antiJammer', function()
	ExecuteCommand('e tablet2')
	QBCore.Functions.Progressbar("check_radio", 'Scanning Signals ...', 10000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		local jmK = inJammerZone(GetEntityCoords(PlayerPedId()))
		if jmK then
			TriggerEvent('chatMessage', 'JAMMER', 'system', 'X: '..(Jammers[jmK].coords.x)..' | Y: '..(Jammers[jmK].coords.y))
		else
			QBCore.Functions.Notify('No Jammer..', "error")
		end
	end, function()
		QBCore.Functions.Notify('Scan failed...', "error")
	end)
end)

-- used to prevent a race condition if they talk again afterwards, which would lead to their voice going to default.
local disableSubmixReset = {}
--- function toggleVoice
--- Toggles the players voice
---@param plySource number the players server id to override the volume for
---@param enabled boolean if the players voice is getting activated or deactivated
---@param moduleType string the volume & submix to use for the voice.
function toggleVoice(plySource, enabled, moduleType)
	if mutedPlayers[plySource] then return end
	logger.verbose('[main] Updating %s to talking: %s with submix %s', plySource, enabled, moduleType)
	if enabled then
		MumbleSetVolumeOverrideByServerId(plySource, enabled and volumes[moduleType])
		if GetConvarInt('voice_enableSubmix', 1) == 1 and gameVersion == 'fivem' then
			if moduleType then
				disableSubmixReset[plySource] = true
				if moduleType == 'radio' then
					if inJammerZone(GetEntityCoords(PlayerPedId())) or (pdatacoords[plySource] and inJammerZone(pdatacoords[plySource]) or false) then
						submixFunctions['radioJ'](plySource)
					else
						local NoNoise = false
						if radioChannel <= 10 then
							if inPoliceVehicles[plySource] or InDsipatchRoom or InDispatchRooms[plySource] then
								NoNoise = true
							end
						end
						if NoNoise or GetPlayerZone(plySource) then
							submixFunctions['radio'](plySource)
						else
							local distance = GetPlayerDistance(plySource)
							if distance < 400 then
								submixFunctions['radio'](plySource)
							elseif distance < 800 then
								submixFunctions['radioM'](plySource)
							else
								submixFunctions['radioF'](plySource)
							end
						end
					end
				else
					submixFunctions[moduleType](plySource)
				end
			else
				MumbleSetSubmixForServerId(plySource, -1)
			end
		end
	else
		if GetConvarInt('voice_enableSubmix', 1) == 1 and gameVersion == 'fivem' then
			disableSubmixReset[plySource] = nil
			SetTimeout(250, function()
				if not disableSubmixReset[plySource] then
					MumbleSetSubmixForServerId(plySource, -1)
				end
			end)
		end
		MumbleSetVolumeOverrideByServerId(plySource, -1.0)
	end
end

--- function playerTargets
---Adds players voices to the local players listen channels allowing
---Them to communicate at long range, ignoring proximity range.
---@diagnostic disable-next-line: undefined-doc-param
---@param targets table expects multiple tables to be sent over
function playerTargets(...)
	local targets = {...}
	local addedPlayers = {
		[playerServerId] = true
	}

	for i = 1, #targets do
		for id, _ in pairs(targets[i]) do
			-- we don't want to log ourself, or listen to ourself
			if addedPlayers[id] and id ~= playerServerId then
				logger.verbose('[main] %s is already target don\'t re-add', id)
				goto skip_loop
			end
			if not addedPlayers[id] then
				logger.verbose('[main] Adding %s as a voice target', id)
				addedPlayers[id] = true
				MumbleAddVoiceTargetPlayerByServerId(voiceTarget, id)
			end
			::skip_loop::
		end
	end
end

--- function playMicClicks
---plays the mic click if the player has them enabled.
---@param clickType boolean whether to play the 'on' or 'off' click. 
function playMicClicks(clickType)
	-- if micClicks ~= 'true' then return logger.verbose("Not playing mic clicks because client has them disabled") end
	sendUIMessage({
		sound = (clickType and "audio_on" or "audio_off"),
		volume = (clickType and volumes["radio"] or 0.05)
	})
end

--- toggles the targeted player muted
---@param source number the player to mute
function toggleMutePlayer(source)
	if mutedPlayers[source] then
		mutedPlayers[source] = nil
		MumbleSetVolumeOverrideByServerId(source, -1.0)
	else
		mutedPlayers[source] = true
		MumbleSetVolumeOverrideByServerId(source, 0.0)
	end
end
exports('toggleMutePlayer', toggleMutePlayer)

--- function setVoiceProperty
--- sets the specified voice property
---@param type string what voice property you want to change (only takes 'radioEnabled' and 'micClicks')
---@param value any the value to set the type to.
function setVoiceProperty(type, value)
	if type == "radioEnabled" then
		radioEnabled = value
		sendUIMessage({
			radioEnabled = value
		})
	elseif type == "micClicks" then
		local val = tostring(value)
		micClicks = val
		SetResourceKvp('pma-voice_enableMicClicks', val)
	end
end
exports('setVoiceProperty', setVoiceProperty)
-- compatibility
exports('SetMumbleProperty', setVoiceProperty)
exports('SetTokoProperty', setVoiceProperty)


-- cache their external servers so if it changes in runtime we can reconnect the client.
local externalAddress = ''
local externalPort = 0
CreateThread(function()
	while true do
		Wait(500)
		-- only change if what we have doesn't match the cache
		if GetConvar('voice_externalAddress', '') ~= externalAddress or GetConvarInt('voice_externalPort', 0) ~= externalPort then
			externalAddress = GetConvar('voice_externalAddress', '')
			externalPort = GetConvarInt('voice_externalPort', 0)
			MumbleSetServerAddress(GetConvar('voice_externalAddress', ''), GetConvarInt('voice_externalPort', 0))
		end
	end
end)


if gameVersion == 'redm' then
	CreateThread(function()
		while true do
			if IsControlJustPressed(0, 0xA5BDCD3C --[[ Right Bracket ]]) then
				ExecuteCommand('cycleproximity')
			end
			if IsControlJustPressed(0, 0x430593AA --[[ Left Bracket ]]) then
				ExecuteCommand('+radiotalk')
			elseif IsControlJustReleased(0, 0x430593AA --[[ Left Bracket ]]) then
				ExecuteCommand('-radiotalk')
			end

			Wait(0)
		end
	end)
end