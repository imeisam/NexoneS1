local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("rccar", function(source, item)
	local Player = QBCore.Functions.GetPlayer(source)
	Player.Functions.RemoveItem("rccar", 1, item.slot) 
	TriggerClientEvent('qb-rccars:start', source, item.info.quality)
	TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["rccar"], "remove")
end)

RegisterServerEvent('rccar:pick', function(qul)
	local newQ = 100
	if qul then
		if qul - 5 > 0 then
			newQ = qul - 5
		else
			newQ = 0
		end
	end
	local Player = QBCore.Functions.GetPlayer(source)
	Player.Functions.AddItem("rccar", 1, nil, {quality = newQ})
	TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["rccar"], "add")
end)