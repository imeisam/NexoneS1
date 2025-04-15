local QBCore = nil

Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports[Config.FrameworkPseudo]:GetCoreObject()
    end
end)

function GetStashItems(stashId)
    return exports['qb-inventory']:GetStashItems(stashId)
end

function AddItemsIntoStash(stash, Items)
    local items = GetStashItems(stash)
    local index = 1
    for k, v in pairs(Items) do
        while items[index] do
            index = index + 1
            Wait(1)
        end
        local itemInfo = QBCore.Shared.Items[v.name:lower()]
        items[index] = {
            name = itemInfo["name"],
            amount = v.amount,
            info = v.info,
            label = itemInfo["label"],
            description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
            weight = itemInfo["weight"],
            type = itemInfo["type"],
            unique = itemInfo["unique"],
            useable = itemInfo["useable"],
            image = itemInfo["image"],
            slot = index,
        }
    end
    Wait(1000)
    MySQL.Async.insert('INSERT INTO stashitems (stash, items) VALUES (:stash, :items) ON DUPLICATE KEY UPDATE items = :items', {
        ['stash'] = stash,
        ['items'] = json.encode(items)
    })
end

function GiveItem(src, item, amount, info)
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(item, amount, false, info)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add', amount)
end