if GetResourceState('qbx_core') ~= 'started' then return end

function getPlayer(source)
    return exports.qbx_core:GetPlayer(source)
end

function getPlayerMoney(player)
    return {
        cash = player.PlayerData.money.cash,
        bank = player.PlayerData.money.bank
    }
end