local QBCore = exports['qb-core']:GetCoreObject()
local open = false
local anim = false

RegisterNUICallback("escape", function()
	if open then
		open = false
		SetNuiFocus(false)
		if anim then
			anim = false
			ExecuteCommand('e c')
		end
	end
end)

RegisterNetEvent('qb-policebadge:client:openBadge', function(data, isself)
	if open then return end
	if isself then
		ExecuteCommand('e idcardb')
		anim = true
	end
	open = true
	SetNuiFocusKeepInput(true)
	SetNuiFocus(true,false)
	SendNUIMessage({
		action = "openbadge",
		name = data.name,
		job = data.job,
		callsign = data.callsign,
		photolink = data.photolink
	})
end)

RegisterNetEvent('qb-policebadge:client:badge', function()
	local Player = QBCore.Functions.GetPlayerData()
	local keyboard = exports['qb-input']:ShowInput({
		header = "Photo link (Take a selfie and paste the link here)",
		submitText = "Confirm",
		inputs = {
			{
				type = 'text',
				isRequired = true,
				text = "Photo link",
				name = 'input',
			}
		}
	})
	if not keyboard then return end
	local photolink = keyboard.input
	local data = {
		name = Player.charinfo.firstname.." "..Player.charinfo.lastname,
		job = Player.job,
		callsign = Player.metadata.callsign,
		photolink = photolink
	}
	TriggerServerEvent('qb-policebadge:server:add', data)
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["policebadge"], "add")
end)