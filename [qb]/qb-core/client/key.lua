local registeredKeys = {}
local keysHolding = {}
local currentKeysHolding = {}
local isControlsDisabled = false

function registerKey(key, type)
	local command = key .. "nxo"

	if not registeredKeys[key] then
		registeredKeys[key] = true
		RegisterKeyMapping('+' .. command, "NXO Keys - "..key, type, key)
	end

	RegisterCommand('+' .. command, function()
		if not IsPauseMenuActive() and not isControlsDisabled then
			TriggerEvent("onKeyDown", key)
			table.insert(keysHolding, key)
			currentKeysHolding[key] = true
			if #keysHolding > 1 then
				TriggerEvent("onMultiplePress", currentKeysHolding)
			end
		end
	end)

	RegisterCommand('-' .. command, function()
		if not IsPauseMenuActive() then
			TriggerEvent("onKeyUP", key)
		end
		if currentKeysHolding[key] then
			removeKey(key)
			currentKeysHolding[key] = nil
		end
	end)
end

function removeKey(key)
	for index, currentKey in ipairs(keysHolding) do
		if currentKey == key then
			table.remove(keysHolding, index)
		end
	end
end

local haveToRegister = {
	["e"] = "keyboard",
	["h"] = "keyboard",
	["k"] = "keyboard",
	["tab"] = "keyboard",
	["numpad1"] = "keyboard",
	["numpad2"] = "keyboard",
	["numpad3"] = "keyboard",
	["numpad4"] = "keyboard",
	["numpad5"] = "keyboard",
	["numpad6"] = "keyboard",
	["numpad7"] = "keyboard",
	["numpad8"] = "keyboard",
	["numpad9"] = "keyboard",
	["u"] = "keyboard",
	["x"] = "keyboard",
	["l"] = "keyboard",
	["i"] = "keyboard",
	["f"] = "keyboard",
	["r"] = "keyboard",
	["v"] = "keyboard",
	["j"] = "keyboard",
	["lmenu"] = "keyboard",
	["f1"] = "keyboard",
	["f2"] = "keyboard",
	["f3"] = "keyboard",
	["f4"] = "keyboard",
	["f5"] = "keyboard",
	["f6"] = "keyboard",
	["f7"] = "keyboard",
	['f9'] = "keyboard",
	["f10"] = "keyboard",
	["f11"] = "keyboard",
	["escape"] = "keyboard",
	["t"] = "keyboard",
	["y"] = "keyboard",
	["g"] = "keyboard",
	["q"] = "keyboard",
	["comma"] = "keyboard",
	["period"] = "keyboard",
	["minus"] = "keyboard",
	["plus"] = "keyboard",
	["b"] = "keyboard",
	['oem_3'] = "keyboard",
	["lcontrol"] = "keyboard",
	["lshift"] = "keyboard",
	["1"] = "keyboard",
	["2"] = "keyboard",
	["3"] = "keyboard",
	["4"] = "keyboard",
	["5"] = "keyboard",
	["6"] = "keyboard",
	["7"] = "keyboard",
	["8"] = "keyboard",
	["9"] = "keyboard",
	["back"] = "keyboard",
	["right"] = "keyboard",
	["left" ] = "keyboard",
	["m"] = "keyboard",
	["n"] = "keyboard",
	["p"] = "keyboard",
	["z"] = "keyboard",
	["o"] = "keyboard",
	["mouse_left"] = "mouse_button",
	["mouse_right"] = "mouse_button",
	["iom_wheel_down"] = "mouse_wheel",
	["iom_wheel_up"] = "mouse_wheel",
	["up"] = "keyboard",
	["down"] = "keyboard",
	["return"] = "keyboard",
	["delete"] = "keyboard",
	["home"] = "keyboard",
	["capital"] = "keyboard",
	["grave"] = "keyboard",
	["pageup"] = "keyboard",
	["pagedown"] = "keyboard",
}

for key, type in pairs(haveToRegister) do
	registerKey(key, type)
end

exports("disableControl", function(status)
	isControlsDisabled = status
end)