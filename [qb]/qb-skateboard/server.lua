local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent("shareImOnSkate")
AddEventHandler("shareImOnSkate", function()
    local _source = source
    TriggerClientEvent("shareHeIsOnSkate", -1, _source)
end)

QBCore.Functions.CreateUseableItem("skateboard", function(source, item)
	local Player = QBCore.Functions.GetPlayer(source)
	Player.Functions.RemoveItem("skateboard", 1, item.slot) 
	TriggerClientEvent('skateboard:Spawn', source, item.info.quality)
	TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["skateboard"], "remove")
end)

RegisterServerEvent('skateboard:pick')
AddEventHandler('skateboard:pick', function(qul)
	local newQ = 100
	if qul then
		if qul - 5 > 0 then
			newQ = qul - 5
		else
			newQ = 0
		end
	end
	local Player = QBCore.Functions.GetPlayer(source)
	Player.Functions.AddItem("skateboard", 1, nil, {quality = newQ})
	TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["skateboard"], "add")
end)