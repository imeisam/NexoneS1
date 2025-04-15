local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('qb-farmnpc:server:GetConfig', function(source, cb)
    cb(Config)
end)

RegisterNetEvent('qb-farmnpc:server:buyItem', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Price = Config.Shop[data.k].items[data.i].price * data.amount
    if not Config.Shop[data.k].items[data.i].limit[Player.PlayerData.job.name] then
        Config.Shop[data.k].items[data.i].limit[Player.PlayerData.job.name] = Config.Limit
    end
    if Config.Shop[data.k].items[data.i].limit[Player.PlayerData.job.name] - data.amount >= 0 then
        if Player.PlayerData.money.bank >= Price then
            if Player.Functions.AddItem(data.i, data.amount) then
                Config.Shop[data.k].items[data.i].limit[Player.PlayerData.job.name] = Config.Shop[data.k].items[data.i].limit[Player.PlayerData.job.name] - data.amount
                TriggerClientEvent('qb-farmnpc:client:setConfig', src, Config)
                Player.Functions.RemoveMoney('bank', Price, 'Buy x'..data.amount..' '..QBCore.Shared.Items[data.i].label..' For Job '..QBCore.Shared.Jobs[Player.PlayerData.job.name].label)
                TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[data.i], "add", data.amount)
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "You dont have enough money in bank!", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Item is out of stock", "error")
    end
end)