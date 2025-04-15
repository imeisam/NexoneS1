RegisterServerEvent("snipe-menu:server:sendDmToPlayer", function(playerId, reason)
    local src = source
    if src ~= 0 and onlineAdmins[src] then
        SendLogs(src, "triggered", Config.Locales["send_dm_used"]..GetPlayerName(playerId).." reason: "..reason)
        if Config.Chat == "okok" then
            TriggerEvent('okokChat:ServerMessage', 'linear-gradient(90deg, rgba(42, 42, 42, 0.9) 0%, rgba(53, 219, 194, 0.9) 100%)', "#35dbc2", "fas fa-briefcase", "DM", "Staff", reason, tonumber(playerId))
        elseif Config.Chat == "codem" then
            local messageData = {
                args = {GetPlayerName(src), reason}, -- first index is author name second one is message (author name is not required you can just put message too)
                tags = {"ooc"}, -- tags that will shown in the message (you can see all avaliables tags in Config.Tags or you can add your own custom tag in Config.Tags)
                playerId = src, -- Server ID of the message owner (this is not required you can just delete this if you don't have an id)
                channel = 'ooc', -- Channel name that message will be sent (default channels are "ooc", "me", "do", "pm", "server")
            }
            TriggerClientEvent('chat:addMessage', tonumber(playerId), messageData)
        else
            TriggerClientEvent('chatMessage', src, 'STAFF DM | to '..GetPlayerName(tonumber(playerId))..' ('..playerId..')', 'warning', reason, 'STAFF')
            TriggerClientEvent('chatMessage', tonumber(playerId), 'Message | '..GetPlayerName(src), 'warning', reason, 'STAFF')
        end
    end
end)

RegisterServerEvent("snipe-menu:server:Announce", function(message)
    local src = source
    if src ~= 0 and onlineAdmins[src] then
        SendLogs(src, "triggered", Config.Locales["announce_used"].." :"..message)
        if Config.Chat == "okok" then
            TriggerEvent('okokChat:ServerMessage', 'linear-gradient(90deg, rgba(42, 42, 42, 0.9) 0%, rgba(53, 219, 194, 0.9) 100%)', "#35dbc2", "fas fa-briefcase", "Admin", "Announcement", message, -1)
        elseif Config.Chat == "codem" then
            local messageData = {
                args = {GetPlayerName(src), message}, -- first index is author name second one is message (author name is not required you can just put message too)
                tags = {"ooc"}, -- tags that will shown in the message (you can see all avaliables tags in Config.Tags or you can add your own custom tag in Config.Tags)
                playerId = src, -- Server ID of the message owner (this is not required you can just delete this if you don't have an id)
                channel = 'ooc', -- Channel name that message will be sent (default channels are "ooc", "me", "do", "pm", "server")
            }
            TriggerClientEvent('chat:addMessage', -1, messageData)
        else
            TriggerClientEvent('chatMessage', -1, 'ANNOUNCEMENT', 'system', message)
        end
    end
end)

RegisterServerEvent("snipe-menu:server:warnPlayer", function(playerId, reason)
    local src = source
    if src ~= 0 and onlineAdmins[src] then
        SendLogs(src, "triggered", Config.Locales["warn_player_used"]..GetPlayerName(playerId).." reason: "..reason)
        if Config.Chat == "okok" then
            TriggerEvent('okokChat:ServerMessage', 'linear-gradient(90deg, rgba(42, 42, 42, 0.9) 0%, rgba(53, 219, 194, 0.9) 100%)', "#35dbc2", "fas fa-briefcase", "Admin", "Warn", reason, tonumber(playerId))
        elseif Config.Chat == "codem" then
            local messageData = {
                args = {GetPlayerName(src), reason}, -- first index is author name second one is message (author name is not required you can just put message too)
                tags = {"ooc"}, -- tags that will shown in the message (you can see all avaliables tags in Config.Tags or you can add your own custom tag in Config.Tags)
                playerId = src, -- Server ID of the message owner (this is not required you can just delete this if you don't have an id)
                channel = 'ooc', -- Channel name that message will be sent (default channels are "ooc", "me", "do", "pm", "server")
            }
            TriggerClientEvent('chat:addMessage', tonumber(playerId), messageData)
        else
            local name = GetPlayerName(src)
            local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(playerId))
            if not OtherPlayer then return TriggerClientEvent('QBCore:Notify', src, 'Player is not online', 'error') end
            TriggerEvent('qb-log:server:CreateLog', 'warn', 'New Warn', 'red', name .. ' (' .. src .. ') send warn to '..OtherPlayer.PlayerData.charinfo.firstname..' '..OtherPlayer.PlayerData.charinfo.lastname..' ('..OtherPlayer.PlayerData.citizenid..' | '..playerId..'),  reason: '..msg)
            for _, v in pairs(QBCore.Functions.GetPlayers()) do
                if QBCore.Functions.HasPermission(v, 'dev') and not exports['snipe-menu']:IsToggleAdmin(v) then
                    TriggerClientEvent('chatMessage', v, 'WARN | '..name..' to '..OtherPlayer.PlayerData.charinfo.firstname..' '..OtherPlayer.PlayerData.charinfo.lastname..' ('..playerId..')', 'error', reason, 'STAFF')
                end
            end
            TriggerClientEvent('chatMessage', tonumber(playerId), 'WARN', 'error', reason, 'STAFF')
        end
    else
        SendLogs(src, "exploit", Config.Locales["warn_player_exploit_event"])
    end
end)