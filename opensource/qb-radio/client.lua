local QBCore = exports['qb-core']:GetCoreObject()
local radioProp = 0
local radioMenu = false
local onRadio = false
local RadioChannel = 0
local RadioVolume = 50

local function round(number, decimals)
    local power = 10^decimals
    return math.floor(number * power) / power
end

local function isDead()
	return Player(GetPlayerServerId(PlayerId())).state['isDead'] or Player(GetPlayerServerId(PlayerId())).state['isCuffed']
end

local function LoadAnimDic(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(0)
        end
    end
end

local function leaveradio()
    TriggerEvent("InteractSound_CL:PlayOnOne","click",0.6)
    RadioChannel = 0
    onRadio = false
    exports["pma-voice"]:setRadioChannel(0)
    exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
    QBCore.Functions.Notify(Config.messages['you_leave'] , 'error')
    SendNUIMessage({type="radiostate",radiostate = onRadio})
end

local function connecttoradio(channel)
    if channel == 0 then
        leaveradio()
        return
    end
    local allowed = false
    if channel <= 10 then
        if QBCore.Functions.HasItem('pdradio', 1) then
            allowed = true
        end
    else
        if QBCore.Functions.HasItem('radio', 1) or QBCore.Functions.HasItem('pdradio', 1) then
            allowed = true
        end
    end
    if allowed then
        RadioChannel =channel
        if not onRadio then
            onRadio = true
            exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
        end
        exports["pma-voice"]:setRadioChannel(RadioChannel)
        QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..RadioChannel.. ' MHz', 'success')
        SendNUIMessage({type = "changefreq", freq =tostring(RadioChannel)})
    else
        QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
    end
end

local function toggleRadioAnimation(pState)
	LoadAnimDic("cellphone@")
	if pState then
		TriggerEvent("attachItemRadio","radio01")
		TaskPlayAnim(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 2.0, 3.0, -1, 49, 0, 0, 0, 0)
		radioProp = CreateObject(`prop_cs_hand_radio`, 1.0, 1.0, 1.0, 1, 1, 0)
		AttachEntityToEntity(radioProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.14, 0.01, -0.02, 110.0, 120.0, -15.0, 1, 0, 0, 0, 2, 1)
	else
		StopAnimTask(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 1.0)
		ClearPedTasks(PlayerPedId())
		if radioProp ~= 0 then
			DeleteObject(radioProp)
			radioProp = 0
		end
	end
end

local function toggleRadio(toggle)
    radioMenu = toggle
    SetNuiFocus(radioMenu, radioMenu)
    if radioMenu then
        toggleRadioAnimation(true)
        SendNUIMessage({type = "open", radiostate = onRadio, radiochannel = RadioChannel})
    else
        toggleRadioAnimation(false)
        SendNUIMessage({type = "close"})
    end
end

local function IsRadioOn()
    return onRadio
end exports("IsRadioOn", IsRadioOn)

RegisterCommand('rjoin', function(sorce, args)
    if args[1] then
        if tonumber(args[1]) then
            if not isDead() then
                connecttoradio(tonumber(args[1]))
            end
        end
    else
        QBCore.Functions.Notify("Enter Frequency!", "error")
    end
end)

RegisterCommand('rleave', function(sorce, args)
    if RadioChannel ~= 0 then
        if not isDead() then
            leaveradio()
        end
    else
        QBCore.Functions.Notify("Your Radio Already is Off", "error")
    end
end)

AddEventHandler('onKeyUP', function(key)
    if key == 'pageup' and onRadio then
        local newChannel = RadioChannel + 0.1
        if not isDead() then
            connecttoradio(newChannel)
        end
    end
end)

AddEventHandler('onKeyUP', function(key)
    if key == 'pagedown' and onRadio then
        local newChannel = RadioChannel - 0.1
        if newChannel > 0 then
            if not isDead() then
                connecttoradio(newChannel)
            end
        end
    end
end)


RegisterNetEvent('qb-radio:client:checkradio', function()
    if RadioChannel ~= 0 then
        if RadioChannel <= 10 then
            if not QBCore.Functions.HasItem('pdradio') then
                leaveradio()
            end
        else
            if not QBCore.Functions.HasItem('radio') and not QBCore.Functions.HasItem('pdradio') then
                leaveradio()
            end
        end
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    if RadioChannel ~= 0 then
        leaveradio()
    end
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    TriggerEvent('qb-radio:client:checkradio')
end)

RegisterNetEvent('qb-radio:use', function()
    toggleRadio(not radioMenu)
end)


RegisterNUICallback('joinRadio', function(data, cb)
    local rchannel = tonumber(data.channel)
    if rchannel ~= nil then
        if rchannel ~= RadioChannel then
            if not isDead() then
                connecttoradio(rchannel)
            end
        else
            QBCore.Functions.Notify(Config.messages['you_on_radio'] , 'error')
        end
    else
        QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
    end
end)

RegisterNUICallback('leaveRadio', function(data, cb)
    if RadioChannel == 0 then
        QBCore.Functions.Notify(Config.messages['not_on_radio'], 'error')
    else
        if not isDead() then
            leaveradio()
        end
    end
end)

RegisterNUICallback("volumeUp", function()
	if RadioVolume <= 95 then
		RadioVolume = RadioVolume + 5
		QBCore.Functions.Notify(Config.messages["volume_radio"] .. RadioVolume, "success")
		exports["pma-voice"]:setRadioVolume(RadioVolume)
	else
		QBCore.Functions.Notify(Config.messages["decrease_radio_volume"], "error")
	end
end)

RegisterNUICallback("volumeDown", function()
	if RadioVolume >= 10 then
		RadioVolume = RadioVolume - 5
		QBCore.Functions.Notify(Config.messages["volume_radio"] .. RadioVolume, "success")
		exports["pma-voice"]:setRadioVolume(RadioVolume)
	else
		QBCore.Functions.Notify(Config.messages["increase_radio_volume"], "error")
	end
end)

RegisterNUICallback("increaseradiochannel", function(data, cb)
    local newChannel = RadioChannel + 1
    if not isDead() then
        connecttoradio(newChannel)
    end
end)

RegisterNUICallback("decreaseradiochannel", function(data, cb)
    if not onRadio then return end
    local newChannel = RadioChannel - 1
    if newChannel >= 1 then
        if not isDead() then
            connecttoradio(newChannel)
        end
    end
end)

RegisterNUICallback('poweredOff', function(data, cb)
    if not isDead() then
        leaveradio()
    end
end)

RegisterNUICallback('escape', function(data, cb)
    toggleRadio(false)
end)