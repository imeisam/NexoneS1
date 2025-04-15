RegisterNetEvent("izzy-healthsystem:server:sendPlayerData", function(target)
    if not target then return end
    TriggerClientEvent("izzy-healthsystem:client:getPlayerData", tonumber(target), source)
end)

RegisterNetEvent("izzy-healthsystem:server:setPlayerData", function(doctor, current)
    TriggerClientEvent("izzy-healthsystem:client:setPlayerData", tonumber(doctor), current)
end)

RegisterNetEvent("izzy-healthsystem:server:removeItem", function(item, amount)
    removeItem(source, item, amount)
end)

RegisterNetEvent("izzy-healthsystem:server:revivePlayer", function(target)
    if not target then return end
    target = tonumber(target)
    TriggerClientEvent("izzy-healthsystem:client:revive", target)
    TriggerClientEvent("hospital:client:Revive", target)
    TriggerClientEvent("esx_ambulancejob:revive", target)
end)

RegisterNetEvent("izzy-healthsystem:server:savePlayer", function(target, data)
    if not target then return end
    TriggerClientEvent("izzy-healthsystem:client:savePlayer", tonumber(target), data)
end)

RegisterNetEvent("izzy-healthsystem:server:setmetadata", function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        Player.Functions.SetMetaData('healthsystem',data)
    end
end)

izzy.registerCallback("izzy-healthsystem:getInventoryItems", function(_, cb, target)
    local items = getInventoryItems(tonumber(target))
    if not items then cb({}) return end
    local formattedItems = {}
    for k, v in pairs(items) do
        if cfg.items[v.name] then
            formattedItems[v.name] = v.amount or v.count
        end
    end

    cb(formattedItems)
end)
