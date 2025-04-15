CreateThread(function()
    if Config.Framework ~= 'qbox' then return end

    debugPrint("YBoomer:QBX:Loading Framework")

    Framework = {
        GetPlayerFromId = function(source)
            local xPlayer = {}
            local qbxPlayer = exports.qbx_core:GetPlayer(source)
            ---------
            if not qbxPlayer then return nil end
            ---------
            xPlayer.source = qbxPlayer.PlayerData.source
            ---------
            xPlayer.identifier = qbxPlayer.PlayerData.citizenid
            ---------
            xPlayer.playerData = qbxPlayer.PlayerData
            ---------
            return xPlayer
        end,
        GetPlayerFromIdentifier = function(citizenid)
            citizenid = cl_Imei(citizenid)

            local qbxPlayer = exports.qbx_core:GetPlayerByCitizenId(citizenid)

            if not qbxPlayer then return nil end

            return Framework.GetPlayerFromId(qbxPlayer.PlayerData.source)
        end,
    }

    -- * Send a notification to a player.
    function Notify(messageData)
        lib.notify(messageData)
    end
end)
