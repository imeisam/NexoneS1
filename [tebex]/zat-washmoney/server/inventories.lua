local QBCore = nil

Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports['qb-core']:GetCoreObject()
    end
end)

function GetStashItems(stashId)
    local items = {}
    if Config.Inventory == 'qb' or Config.Inventory == 'ps' then
        local result = nil 
        if Config.QBInventory == "old" then
            result = MySQL.scalar.await('SELECT items FROM stashitems WHERE stash = ?', {stashId})
        else
            result = MySQL.scalar.await('SELECT items FROM inventories WHERE identifier = ?', {stashId})
        end

        if not result then return items end

        local stashItems = json.decode(result)
        if not stashItems then return items end

        for _, item in pairs(stashItems) do
            local itemInfo = QBCore.Shared.Items[item.name:lower()]
            if itemInfo then
                items[item.slot] = {
                    name = itemInfo["name"],
                    amount = tonumber(item.amount),
                    info = item.info or "",
                    label = itemInfo["label"],
                    description = itemInfo["description"] or "",
                    weight = itemInfo["weight"],
                    type = itemInfo["type"],
                    unique = itemInfo["unique"],
                    useable = itemInfo["useable"],
                    image = itemInfo["image"],
                    created = item.created,
                    slot = item.slot,
                }
            end
        end
    elseif Config.Inventory == 'ox' then
        items = exports.ox_inventory:GetInventoryItems(stashId)
        if not items then
            items = {}
            local result = MySQL.scalar.await('SELECT data FROM ox_inventory WHERE name = ?', {stashId})
            if not result then return items end
            local stashItems = json.decode(result)
            if not stashItems then return items end
            for _, item in pairs(stashItems) do
                items[item.slot] = {
                    name        = item.name,
                    amount      = item.count,
                    metadata    = item.metadata,
                    slot        = item.slot,
                }
            end
        end
    elseif Config.Inventory == 'qs' then
        items = exports['qs-inventory']:GetStashItems('Stash_'..stashId)
    end
	return items
end

function GiveItem(src, item, amount, info)
    if Config.Inventory == 'qb' or Config.Inventory == 'ps' then
        local Player = QBCore.Functions.GetPlayer(src)
        Player.Functions.AddItem(item, amount, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
    elseif Config.Inventory == 'ox' then
        exports.ox_inventory:AddItem(src, item, amount, info)
    elseif Config.Inventory == 'qs' then
        exports['qs-inventory']:AddItem(src, item, amount, nil, info)
    end
end

RegisterNetEvent('zat-washmoney:server:OpenNewQbInventory', function(stashId, weight, slots)
    local src = source
    local data = { label = stashId, maxweight = weight, slots = slots }
    exports['qb-inventory']:OpenInventory(src, stashId, data)
end)
