local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('qb-grandma:server:checkfunds', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local balance
    if (Config.MoneyType=='cash') then
            balance= Player.Functions.GetCash()
    else
        balance = Player.Functions.GetMoney('bank')
    end
    if CheckBalance then
        if balance >= Config.Cost then
            TriggerClientEvent('qb-grandma:reviveplayer', source)
        else
            if Config.MoneyType == 'bank' then
                TriggerClientEvent('QBCore:Notify', source, "You don't have enough money in your bank to pay Grandma!", "error")
            elseif Config.MoneyType == 'cash' then
                TriggerClientEvent('QBCore:Notify', source, "You don't have enough cash to pay Grandma!", "error")
            end
        end
    else
        TriggerClientEvent('qb-grandma:reviveplayer', source)
    end
end)

QBCore.Functions.CreateCallback('qb-grandma:attemptGrandmaPayment', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Config.CheckBalance then
        if Player.Functions.RemoveMoney(Config.MoneyType, Config.Cost) then
            cb(true)
        else
            cb(false)
        end
    else
        cb(true)
    end
end)