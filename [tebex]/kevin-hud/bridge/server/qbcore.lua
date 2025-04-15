if GetResourceState('qb-core') ~= 'started' then return end

local QBCore = exports['qb-core']:GetCoreObject()

function getPlayer(source)
    return QBCore.Functions.GetPlayer(source)
end

function getPlayerMoney(player)
    return {
        cash = player.Functions.GetCash(),
        bank = player.PlayerData.money.bank
    }
end
RegisterNetEvent('QBCore:Server:OnMoneyChange', function(source,typee, amount, changeType, reason,notlog)
   
  end)