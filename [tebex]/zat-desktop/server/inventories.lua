local QBCore = nil
Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports[Config.FrameworkPseudo]:GetCoreObject()
    end
end)

function GetStashItems(stashId)
    local items = {}
    if Config.Inventory == 'qb' or Config.Inventory == 'ps' or Config.Inventory == 'origen' then
        if Config.Inventory == 'origen' then
            stashId = 'stash_'..stashId
        end
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
    elseif Config.Inventory == 'codem' then
        local temp = exports['codem-inventory']:GetStashItems(stashId)
        for k, v in pairs (temp) do
            table.insert(items, v)
        end
    end
	return items
end

function UpdateStashes(stashId, items)
    if Config.Inventory == 'qb' or Config.Inventory == 'ps' or Config.Inventory == 'origen' then
        if Config.Inventory == 'origen' then
            stashId = 'stash_'..stashId
        end
        if Config.QBInventory == "old" then
            MySQL.Async.insert('INSERT INTO stashitems (stash, items) VALUES (:stash, :items) ON DUPLICATE KEY UPDATE items = :items'
                , {
                ['stash'] = stashId,
                ['items'] = json.encode(items)
            })
        else
            MySQL.Async.insert('INSERT INTO inventories (identifier, items) VALUES (:identifier, :items) ON DUPLICATE KEY UPDATE items = :items'
                , {
                ['identifier'] = stashId,
                ['items'] = json.encode(items)
            })
            -- It was working fine ! just we need to add them into the temp inv in the qb-inv by doing this :

            -- if the inventory does not exist we need to create it here otherwise it will not be able to add items into it . 
            -- stupid but true
            
            -----------------------------------------------------------------------------------------------------------------
            -----------------------------------------------------------------------------------------------------------------
            local oldItems = GetStashItems(stashId)
            for k, v in pairs(oldItems) do
                exports['qb-inventory']:RemoveItem(stashId, v.name,  v.amount, v.slot)
                Citizen.Wait(200)
            end

            for k, v in pairs(items) do
                exports['qb-inventory']:AddItem(stashId, v.name,  v.amount, false, v.info)
                Citizen.Wait(200)
            end
        end
    elseif Config.Inventory == 'ox' then
        for _, v in pairs(items) do
            exports.ox_inventory:SetMetadata(stashId, v.slot, v.metadata)
        end
    elseif Config.Inventory == 'qs' then
        MySQL.Async.insert('INSERT INTO inventory_stash (stash, items) VALUES (:stash, :items) ON DUPLICATE KEY UPDATE items = :items'
            , {
            ['stash'] = 'Stash_'..stashId,
            ['items'] = json.encode(items)
        })
    elseif Config.Inventory == 'codem' then
        exports['codem-inventory']:UpdateStash(stashId, items)
    end
end

function AddDroneItem(src, stashId, reward)
    if Config.Inventory == 'qb' or Config.Inventory == 'ps' or Config.Inventory == 'origen' then
        if Config.Inventory == 'origen' then
            stashId = 'stash_'..stashId
        end
        local itemInfo = QBCore.Shared.Items[(reward.name):lower()]
        local temp = {}
        temp[1] = {
            name = itemInfo["name"],
            amount = 1,
            info = reward.info,
            label = itemInfo["label"],
            description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
            weight = itemInfo["weight"],
            type = itemInfo["type"],
            unique = itemInfo["unique"],
            useable = itemInfo["useable"],
            image = itemInfo["image"],
            slot = 1,
        }
        if Config.QBInventory == "old" then
            MySQL.Async.insert('INSERT INTO stashitems (stash, items) VALUES (:stash, :items) ON DUPLICATE KEY UPDATE items = :items'
                , {
                ['stash'] = stashId,
                ['items'] = json.encode(temp)
            })
        else
            MySQL.Async.insert('INSERT INTO inventories (identifier, items) VALUES (:identifier, :items) ON DUPLICATE KEY UPDATE items = :items'
                , {
                ['identifier'] = stashId,
                ['items'] = json.encode(temp)
            })
            -- It was working fine ! just we need to add them into the temp inv in the qb-inv by doing this :

            -- if the inventory does not exist we need to create it here otherwise it will not be able to add items into it . 
            -- stupid but true
            
            -----------------------------------------------------------------------------------------------------------------
            -----------------------------------------------------------------------------------------------------------------
            local oldItems = GetStashItems(stashId)
            if #oldItems <= 0 then
                local data = { label = stashId, maxweight = weight, slots = slots }
                exports['qb-inventory']:OpenInventory(src, stashId, data)
                exports['qb-inventory']:CloseInventory(src, stashId)
            end
            for k, v in pairs(oldItems) do
                exports['qb-inventory']:RemoveItem(stashId, v.name,  v.amount, v.slot)
                Citizen.Wait(200)
            end

            for k, v in pairs(temp) do
                exports['qb-inventory']:AddItem(stashId, v.name,  v.amount, false, v.info)
                Citizen.Wait(200)
            end
        end
    elseif Config.Inventory == 'ox' then
        exports.ox_inventory:RegisterStash(stashId, stashId, 1, 4000000)
        exports.ox_inventory:AddItem(stashId, reward.name, 1, reward.info, 1)
    elseif Config.Inventory == 'qs' then
        exports['qs-inventory']:AddItemIntoStash('Stash_'..stashId, reward.name, 1, 1, reward.info, 1, 4000000)
    elseif Config.Inventory == 'codem' then
        local itemInfo = QBCore.Shared.Items[(reward.name):lower()]
        local temp = {}
        temp[1] = {
            name = itemInfo["name"],
            amount = 1,
            info = reward.info,
            label = itemInfo["label"],
            description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
            weight = itemInfo["weight"],
            type = itemInfo["type"],
            unique = itemInfo["unique"],
            useable = itemInfo["useable"],
            image = itemInfo["image"],
            slot = 1,
        }
        exports['codem-inventory']:UpdateStash(stashId, temp)
    end
end

function GiveItem(src, item, amount, info)
    if Config.Inventory == 'qb' or Config.Inventory == 'ps' or Config.Inventory == 'origen' then
        local Player = QBCore.Functions.GetPlayer(src)
        Player.Functions.AddItem(item, amount, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
    elseif Config.Inventory == 'ox' then
        exports.ox_inventory:AddItem(src, item, amount, info)
    elseif Config.Inventory == 'qs' then
        exports['qs-inventory']:AddItem(src, item, amount, nil, info)
    elseif Config.Inventory == 'codem' then
        exports['codem-inventory']:AddItem(src, item, amount, nil, info)
    end
end

RegisterNetEvent("zat-desktop:server:RemoveItemOx", function(data, metadata)
    local src = source
    exports.ox_inventory:RemoveItem(src, data.name, 1, metadata, data.slot)
end)

RegisterNetEvent('zat-desktop:server:OpenNewQbInventory', function(stashId, weight, slots)
    local src = source
    local data = { label = stashId, maxweight = weight, slots = slots }
    exports['qb-inventory']:OpenInventory(src, stashId, data)
end)