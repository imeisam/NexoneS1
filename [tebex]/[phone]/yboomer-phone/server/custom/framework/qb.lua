CreateThread(function()
    if Config.Framework ~= 'qb' then return end

    debugPrint("YBoomer:QB:Loading Framework")

    local QBCore = exports["qb-core"]:GetCoreObject()

    Framework = {
        GetPlayerFromId = function(source)
            local xPlayer = {}
            local qbPlayer = QBCore.Functions.GetPlayer(source)
            ---------
            if not qbPlayer then return nil end
            ---------
            xPlayer.source = qbPlayer.PlayerData.source
            ---------
            xPlayer.identifier = qbPlayer.PlayerData.citizenid
            ---------
            xPlayer.playerData = qbPlayer.PlayerData
            ---------
            return xPlayer
        end,
        GetPlayerFromIdentifier = function(citizenid)
            citizenid = cl_Imei(citizenid)

            local qbPlayer = QBCore.Functions.GetPlayerByCitizenId(citizenid)
            if not qbPlayer then return nil end
            return Framework.GetPlayerFromId(qbPlayer.PlayerData.source)
        end,
    }

    -- * Send a notification to a player.
    function Notify(messageData)
        lib.notify(messageData)
    end
end)
