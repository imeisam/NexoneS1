local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-trading:processTrade', function(trade, quantity)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player then
        local item = Player.Functions.GetItemByName(trade.item)
        if item and item.amount >= quantity then
            Player.Functions.RemoveItem(trade.item, quantity)

            local rewardAmount = quantity

            Player.Functions.AddItem(trade.reward, rewardAmount)
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[trade.reward], "add",rewardAmount)
            TriggerClientEvent('QBCore:Notify', src, 'Trade successful! You received ' .. rewardAmount .. ' ' ..  QBCore.Shared.Items[trade.reward].label, 'success')
        else
            TriggerClientEvent('QBCore:Notify', src, 'Not enough items for trade', 'error')
        end
    end
end)
