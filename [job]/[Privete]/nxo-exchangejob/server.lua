local QBCore = exports['qb-core']:GetCoreObject()
local com=0.05
RegisterNetEvent('nxo-exchange:server:exchange', function(quantity)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player then
        local item = Player.Functions.GetItemByName('wet_money')
        if item and item.amount >= quantity then
            Player.Functions.RemoveItem('wet_money', quantity)
            local rewardAmount =math.round(quantity-(quantity*com))
            exports["snipe-banking"]:AddMoneyToAccount(Player.PlayerData.job.name, math.round(quantity*com),"Change With "..Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname)
            Player.Functions.AddItem('cash', rewardAmount)
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['cash'], "add",rewardAmount)
            TriggerClientEvent('QBCore:Notify', src, 'Trade successful! You received ' .. rewardAmount .. ' ' ..  QBCore.Shared.Items['cash'].label, 'success')
        else
            TriggerClientEvent('QBCore:Notify', src, 'Not enough items for trade', 'error')
        end
    end
end)


RegisterNetEvent('nxo-exchange:server:scorboardstatus', function(status)
    src=source
    PerformHttpRequest('https://nxone.ir/currency/set-direction?direction='..status..'&token=FlZkB4kYbtbHwc1qlgQHMOaRF3LpUcRaw0BLltV1sarpJrmWkVZwvqGhIHyl9C77', function(stt) 
    end, "GET", "", {})
    local typ="Freeze"
    if status=="neutral" then
        typ="Unfreeze"
    end
    TriggerClientEvent('QBCore:Notify', src, 'Scoreboard '..typ.." Success", 'success')
end)
RegisterNetEvent('nxo-exchange:server:scorboardonoff', function(status)
    src=source
    PerformHttpRequest('https://nxone.ir/currency/toggle-api?status='..status..'&token=FlZkB4kYbtbHwc1qlgQHMOaRF3LpUcRaw0BLltV1sarpJrmWkVZwvqGhIHyl9C77', function(stt) 
    end, "GET", "", {})
    
    TriggerClientEvent('QBCore:Notify', src, 'Scoreboard '..status.." Success", 'success')
end)

QBCore.Commands.Add("marketchange", "Change Exchange Market Direction", {{name="type", help='up/down/neutral'}}, true, function(source, args)
    src=source
    PerformHttpRequest('https://nxone.ir/currency/set-direction?direction='..args[1]..'&token=FlZkB4kYbtbHwc1qlgQHMOaRF3LpUcRaw0BLltV1sarpJrmWkVZwvqGhIHyl9C77', function(stt) 
    end, "GET", "", {})
    TriggerClientEvent('QBCore:Notify', src, 'Exchange Market Direction status: '..args[1], 'success')
end, "god")
