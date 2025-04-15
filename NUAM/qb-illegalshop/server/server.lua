local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('qb-illegalshop:server:HasMoney', function(source, cb, data)
    local Player = QBCore.Functions.GetPlayer(source)
    local Price = Config.Shop[data.k].items[data.i] * data.amount
    if Player.Functions.GetMoney('cash') >= Price then
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent('qb-illegalshop:server:buyItem', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Price = Config.Shop[data.k].items[data.i] * data.amount
    if Player.Functions.GetMoney('cash') >= Price then
        Player.Functions.RemoveMoney('cash', Price)
        Player.Functions.AddItem(data.i, data.amount)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[data.i], "add", data.amount)
    else
        TriggerClientEvent('QBCore:Notify', src, "Where is your Cash? Go fuck off!", "error")
    end
end)