 local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("paper", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
		Player.Functions.AddItem('notedpaper', 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items["notedpaper"], "add")
    end
end)

QBCore.Functions.CreateUseableItem("notedpaper", function(source, item)
    TriggerClientEvent("qb-notes:client:openNote", source, item.info, item.slot)
end)

RegisterNetEvent('qb-notes:server:saveNote', function(text, slot)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if not Player then return end
	local Inventory = Player.PlayerData.items
	local item = Inventory[slot]
	if item and item.name == 'notedpaper' then
		Inventory[slot].info.text = text
		Player.Functions.SetInventory(Inventory)
	end
end)