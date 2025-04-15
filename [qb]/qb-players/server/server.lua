QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add("players", "", {}, true, function(source, args)
    TriggerClientEvent("qb-players:client:showmenu", source)
end, 'admin')

QBCore.Commands.Add("crashplayer", "Crash Player", {{name = "playerid", help = "Playerid"}}, true, function(source, args)
    if not args[1] then return end
    TriggerClientEvent("qb-players:client:cplayer", args[1])
end, 'admin')

QBCore.Commands.Add('bancrash', 'Ban Crash', {{ name = 'bsn', help = 'State ID' },{ name = 'state', help = 'true/false' }}, true, function(source, args)
    local bsn = string.upper(args[1])
    local state = string.lower(args[2])
    local target = QBCore.Functions.GetPlayerByCitizenId(bsn)
    local stttate = false
    if state ~= 'true' and state ~= 'false' then TriggerClientEvent('QBCore:Notify', source, 'Enter Correct State', 'error') return end
    if state == 'true' then
        stttate = true
    end
    if target then
        target.Functions.SetMetaData('bancrash', stttate)
        TriggerEvent('qb-log:server:CreateLog', 'ban2', 'New Ban Crash', stttate and 'green' or 'red', 'BSN: '..bsn..'\nState: '..state..'\nAdmin: '..GetPlayerName(source), false)
    else
        local result = MySQL.scalar.await('SELECT metadata FROM players WHERE citizenid = ?', {bsn})
        if result then
            local mdata = json.decode(result)
            mdata.bancrash = stttate
            local updated = json.encode(mdata)
            MySQL.update('UPDATE players SET metadata = ? WHERE citizenid = ?', {updated, bsn})
            TriggerClientEvent('QBCore:Notify', source, 'Ban State of '..bsn..' has been changed', stttate and 'success' or 'error')
            TriggerEvent('qb-log:server:CreateLog', 'ban2', 'New Ban Crash', stttate and 'green' or 'red', 'BSN: '..bsn..'\nState: '..state..'\nAdmin: '..GetPlayerName(source), false)
        else
            TriggerClientEvent('QBCore:Notify', source, 'BSN does not exist', 'error')
        end
    end
end, 'admin')

local function GetPlayerIdentifiersList(source, type)
    local identifiers = GetPlayerIdentifiers(source)
    for _, identifier in pairs(identifiers) do
        if string.find(identifier, type) then
            return identifier
        end
    end
    return nil
end

RegisterNetEvent('qb-players:server:removewarn', function(data)
    local src = source
    exports.oxmysql:execute('delete from players_warn where id=?',{data.warnid})
    TriggerClientEvent('QBCore:Notify', src, 'Warn Removed...', 'success')
end)

RegisterNetEvent('qb-players:server:banplayer', function(data)
    local src = source
    local time = tonumber(data.time)
    local Name = ""
    local Reason = data.reson
    if time then
        if tonumber(data.playerid) then
            local target = tonumber(data.playerid)
            if GetPlayerName(target) then
                Name=GetPlayerName(target)
                local Discord = QBCore.Functions.GetIdentifier(target, 'discord')
                exports['qb-core']:Ban(Discord, target, Reason, time, source, Name)
            else
                TriggerClientEvent('QBCore:Notify', source, 'Player is Not Online', 'error')
            end
        else
            if string.find(data.discord, "discord:") then
                MySQL.Async.fetchAll('SELECT Discord FROM bans WHERE Discord = @Discord',
                {
                    ['@Discord'] =data.discord
            
                }, function(data)
                    if data[1] then
                        exports['qb-core']:Ban(data.discord, 0, Reason, time, source, Name)
                    else
                        TriggerClientEvent('QBCore:Notify', source, 'Can not find this Discord in Database', 'error')
                    end
                end)
            else
                TriggerClientEvent('QBCore:Notify', source, 'Incorrect Discord ID Syntax', 'error')
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'Enter Ban Duration as Number', 'error')
    end

end)

RegisterNetEvent('qb-players:server:insertwarn', function(data)
    local src = source
    local targetPlayer = QBCore.Functions.GetPlayer(data.playerid)
    if not targetPlayer then return TriggerClientEvent('QBCore:Notify', src, 'Player is not online', 'error') end
    local license = GetPlayerIdentifiersList(data.playerid, "license")or ""
    local discord = GetPlayerIdentifiersList(data.playerid, "discord")or ""
    local steam = GetPlayerIdentifiersList(data.playerid, "steam") or ""
    local ip = GetPlayerIdentifiersList(data.playerid, "ip")or ""
    exports.oxmysql:execute('insert players_warn(Steam,License,IP,Discord,Reason,warnby,name,time)values(?,?,?,?,?,?,?,?)',
    {steam, license,ip,discord,data.reson,GetPlayerName(src),GetPlayerName(tonumber(data.playerid)),os.time()})
    TriggerClientEvent('chatMessage',tonumber(data.playerid), 'You Received a Warn', 'warning', data.reson, 'STAFF')
    for _, v in pairs(QBCore.Functions.GetPlayers()) do
        if QBCore.Functions.HasPermission(v, 'dev') and not exports['snipe-menu']:IsToggleAdmin(v) then
            TriggerClientEvent('chatMessage', v, 'Player Warn', 'warning',GetPlayerName(tonumber(data.playerid))..' ('..data.playerid..') Reson: '..  data.reson, 'STAFF')
        end
    end
end)

QBCore.Functions.CreateCallback('qb-players:server:allwarn', function(source, cb,playerid)
    local resutl={}
    if playerid then
         local discord = GetPlayerIdentifiersList(playerid, "discord")or ""
        result = MySQL.query.await('Select * from players_warn where Discord=? order by id desc', {discord})
    else
        result = MySQL.query.await('Select * from players_warn order by id desc', {})
    end
   cb(result)
end)



QBCore.Functions.CreateCallback('qb-players:server:loadplayers', function(source, cb)
    local Players = QBCore.Functions.GetPlayers()
    local playerdata={}
    for k,v in pairs(Players) do
        playerdata[#playerdata+1]=QBCore.Functions.GetPlayer(v)
    end
    local totalwarn ={}
    local totalbans ={}
    totalwarn = MySQL.query.await('Select * from players_warn', {})
    totalbans = MySQL.query.await('Select * from bans where isBanned=1', {})
    for k, v in pairs(totalbans) do
        local timeTable = os.date('*t', tonumber(v.expire))
        if timeTable.day>365 then
            totalbans[k].expiretime='Permanent'
        else
            totalbans[k].expiretime=timeTable.day .. '/' .. timeTable.month .. '/' .. timeTable.year .. ' ' .. timeTable.hour .. ':' .. timeTable.min
        end
    end
  

    cb(playerdata,totalwarn,totalbans)
end)


