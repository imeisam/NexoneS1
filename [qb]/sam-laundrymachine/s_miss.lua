local QBCore = exports['qb-core']:GetCoreObject()
local deliverystarted={}
RegisterNetEvent('sam-laundrymachine:server:purchesmoney', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(Config.giveitem, Config.washedmoneydelivery)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.giveitem], "remove",Config.washedmoneydelivery)
    Player.Functions.AddItem(Config.additemdelivery, Config.additemdeliverycount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.additemdelivery], "add",Config.additemdeliverycount)
end)

QBCore.Functions.CreateCallback('sam-laundrymachine:server:startdelivery', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    cid=Player.PlayerData.citizenid
    if deliverystarted[cid] then
        deliverystarted[cid]=deliverystarted[cid]+1
    else
        deliverystarted[cid]=1
    end
    if deliverystarted[cid]<=2 then
        cb(true)
    else
        cb(false)
    end
end)


RegisterNetEvent('sam-laundrymachine:server:turninmoney', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(Config.additemdelivery, #Config.delivery*Config.additemdeliverycount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.additemdelivery], "remove",#Config.delivery*Config.additemdeliverycount)
    Player.Functions.AddMoney('cash', Config.moneyformoneyorder*(#Config.delivery*Config.additemdeliverycount))
end)
