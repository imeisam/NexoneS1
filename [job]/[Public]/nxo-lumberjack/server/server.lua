local QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent('QBCore:Server:UpdateObject', function() if source ~= '' then return false end	QBCore = exports['qb-core']:GetCoreObject() end)

RegisterNetEvent('jim-lumberjack:server:toggleItem', function(give, item, amount)
	local src = source
	if give == 0 or give == false then
		if QBCore.Functions.GetPlayer(src).Functions.RemoveItem(item, amount or 1) then
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove", amount or 1)
		end
	else
		if QBCore.Functions.GetPlayer(src).Functions.AddItem(item, amount or 1) then
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add", amount or 1)
		end
	end
end)

---Crafting
RegisterServerEvent('jim-lumberjack:GetItem', function(data)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	--This grabs the table from client and removes the item requirements
	if Player.Functions.AddItem(data.item, data.craftable[data.tablenumber]["amount"] or 1) then
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[data.item], "add", data.craftable[data.tablenumber]["amount"] or 1)
		if Config.Debug then print("^5Debug^7: ^4Giving ^2Player^7(^2"..src.."^7) '^6"..QBCore.Shared.Items[data.item].label.."^7(^2x^6"..(data.craftable[data.tablenumber]["amount"] or 1).."^7)'") end
		for k, v in pairs(data.craftable[data.tablenumber][data.item]) do
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[tostring(k)], "remove", v)
			Player.Functions.RemoveItem(tostring(k), v)
			if Config.Debug then print("^5Debug^7: ^1Removing ^2from Player^7(^2"..src.."^7) '^6"..QBCore.Shared.Items[k].label.."^7(^2x^6"..v.."^7)'") end
		end
	end
	--Try to send back to craftmenu
	TriggerClientEvent("jim-lumberjack:CraftMenu", src, data)
end)

RegisterNetEvent("jim-lumberjack:Selling", function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName(data.item) ~= nil then
        local amount = Player.Functions.GetItemByName(data.item).amount
        local pay = (amount * Config.SellItems[data.item])
        Player.Functions.RemoveItem(data.item, amount)
        Player.Functions.AddMoney('cash', pay)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[data.item], 'remove', amount)
    else
        TriggerClientEvent("QBCore:Notify", src, Loc[Config.Lan].error["dont_have"].." "..QBCore.Shared.Items[data.item].label, "error")
    end
end)

function HasItem(source, items, amount)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return false end
    local isTable = type(items) == 'table'
    local isArray = isTable and table.type(items) == 'array' or false
    local totalItems = #items
    local count = 0
    local kvIndex = 2
    if isTable and not isArray then
        totalItems = 0
        for _ in pairs(items) do totalItems += 1 end
        kvIndex = 1
    end
    if isTable then
	if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Checking if player^7(^6"..source.."^7)^2 has items^7") end
        for k, v in pairs(items) do
            local itemKV = {k, v}
            local item = Player.Functions.GetItemByName(itemKV[kvIndex])
            if item and ((amount and item.amount >= amount) or (not isArray and item.amount >= v) or (not amount and isArray)) then
                count += 1
            end
        end
        if count == totalItems then
			if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Items FOUND^7") end
            return true
        end
    else -- Single item as stringHasItem(v, 1)
		if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Checking if player^7(^6"..source.."^7)^2 has items^7") end
		local item = Player.Functions.GetItemByName(items)
        if item and (not amount or (item and amount and item.amount >= amount)) then
            return true
        end
    end
	if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Items Not FOUND^7") end
    return false
end