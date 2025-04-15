local BannedAccounts = {}

function ReloadBans()
    CreateThread(function()
        BannedAccounts = {}
        -- MySQL.Async.fetchAll('SELECT * FROM bans', {}, function(info)
        --     for i = 1, #info do
        --         if info[i].isBanned == 1 then
        --             Wait(2)
        --             table.insert(BannedAccounts, {info[i]})
        --         end
        --     end
        -- end)
    end)
end

function InitiateDatabase(source, State, Reason, Time)
    local source = source
    local ST = "None"
    local LC = "None"
    local LV = "None"
    local XB = "None"
    local DS = "None"
    local IiP = "None"
    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1,string.len("steam:")) == "steam:" then
            ST  = v
        elseif string.sub(v, 1,string.len("license:")) == "license:" then
            LC  = v
        elseif string.sub(v, 1,string.len("live:")) == "live:" then
            LV  = v
        elseif string.sub(v, 1,string.len("xbl:")) == "xbl:" then
            Xbox = v
        elseif string.sub(v,1,string.len("discord:")) == "discord:" then
            DS = v
        elseif string.sub(v, 1,string.len("ip:")) == "ip:" then
            IiP = v
        end
    end
    if DS == "None" then return end
    local Tokens = {}
    for i = 0, GetNumPlayerTokens(source) - 1 do 
        table.insert(Tokens, GetPlayerToken(source, i))
    end
    MySQL.Async.fetchAll('SELECT * FROM bans WHERE Discord = @Discord',
    {
        ['@Discord'] = DS

    }, function(data) 
        if not data[1] then
            MySQL.Async.execute('INSERT INTO bans (Steam, License, Tokens, Discord, IP, Xbox, Live, Reason, Expire, isBanned) VALUES (@Steam, @License, @Tokens, @Discord, @IP, @Xbox, @Live, @Reason, @Expire, @isBanned)',
            {
                ['@Steam'] = ST,
                ['@License'] = LC,
                ['@Discord'] = DS,
                ['@Xbox'] = XB,
                ['@IP'] = IiP,
                ['@Live'] = LV,
                ['@Reason'] = Reason or "",
                ['@Tokens'] = json.encode(Tokens),
                ['@Expire'] = Time or 0,
                ['@isBanned'] = State
            })
            SetTimeout(5000, function()
                ReloadBans()
            end)
        end 
    end)
end

function CreateUnbanThread(Discord)
    MySQL.Async.fetchAll('SELECT Discord FROM bans WHERE Discord = @Discord',
    {
        ['@Discord'] = Discord

    }, function(data)
        if data[1] then
            MySQL.Async.execute('UPDATE bans SET Reason = @Reason, isBanned = @isBanned, Expire = @Expire WHERE Discord = @Discord',
            {
                ['@isBanned'] = 0,
                ['@Reason'] = "",
                ['@Discord'] = Discord,
                ['@Expire'] = 0
            })
            SetTimeout(5000, function()
                ReloadBans()
            end)
        end
    end)
end

function IsPlayerBanned(source)
    local BannedAlready = false
    local Reason = nil
    local Expire = nil
    local isBypassing = false
    local byPassDis = "NONE"
    local Steam = "NONE"
    local Lice = "NONE"
    local Live = "NONE"
    local Xbox = "NONE"
    local Discord = "NONE"
    local IP = "NONE"
    local strban=""
    local isres=false
    local reasontxt = ''
    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1,string.len("steam:")) == "steam:" then
            Steam = v
            strban=strban.."or Steam like '%"..Steam.."%'"
        elseif string.sub(v, 1,string.len("license:")) == "license:" then
            Lice = v
        elseif string.sub(v, 1,string.len("live:")) == "live:" then
            Live = v
            strban=strban.."or Live like '%"..Live.."%'"
        elseif string.sub(v, 1,string.len("xbl:")) == "xbl:" then
            Xbox = v
            strban=strban.."or Xbox like '%"..Xbox.."%'"
        elseif string.sub(v,1,string.len("discord:")) == "discord:" then
            Discord = v
        elseif string.sub(v, 1,string.len("ip:")) == "ip:" then
            IP = v
        end
    end
    local strtoken=""
        for g = 0, GetNumPlayerTokens(source) - 1 do
            strtoken=strtoken.." or Tokens like '%"..GetPlayerToken(source, g) .."%'"
        end
    MySQL.Async.fetchAll("SELECT * FROM bans where  isBanned=1 and (Discord like '%"..Discord.."%' or License like '%@"..Lice.."%' "..strban..") ", {}, function(result)
    if result and result[1] then
        if os.time() < tonumber(result[1].Expire) then
           BannedAlready = true
           Reason = result[1].Reason
            Expire = result[1].Expire
            if result[1].Discord ~= tostring(Discord) then
                 isBypassing = true
                  byPassDis = result[1].Discord
            end
        else
            if not isBypassing then
                CreateUnbanThread(tostring(result[1].Discord))
           end
     end
    end

    if not BannedAlready and not isBypassing then
        InitiateDatabase(source, false, false, false)
    end
    if isBypassing then
        InitiateDatabase(source, true, "Tried To Bypass Ban System, Your Main Discord Account is "..byPassDis, os.time() + (2147483647 * 86400))
        local newdis = string.gsub(Discord, 'discord:', '')
        local olddis = string.gsub(byPassDis, 'discord:', '')
        TriggerEvent('qb-log:server:CreateLog', 'bans', 'Tried To Bypass Ban System', 'red', 'New Account: '..newdis..' | <@'..newdis..'> \n Old Account: '..olddis..' | <@'..olddis..'>')
    end
   
    if BannedAlready then
        local bantime = math.floor((Expire - os.time()) / 86400) + 1
        if bantime > 365 then
            reasontxt = '\n You are permanently  banned for '..Reason..'.'
        else
            reasontxt = '\n You have been banned for '..Reason..'. \n Your ban will be expire in '.. bantime ..' days.'
        end
    end
    isres=true
        end)
while not isres do 
    Wait(100)
end

return BannedAlready, reasontxt
    -- for a, b in pairs(result) do
    --     for c, d in pairs(b) do
    --         for e, f in pairs(json.decode(d.Tokens)) do
    --             for g = 0, GetNumPlayerTokens(source) - 1 do
    --                 if GetPlayerToken(source, g) == f or d.License == tostring(Lice) or d.Live == tostring(Live) or d.Xbox == tostring(Xbox) or d.Discord == tostring(Discord) or d.Steam == tostring(Steam) then
    --                     if os.time() < tonumber(d.Expire) then
    --                         BannedAlready = true
    --                         Reason = d.Reason
    --                         Expire = d.Expire
    --                         if d.Discord ~= tostring(Discord) then
    --                             isBypassing = true
    --                             byPassDis = d.Discord
    --                         end
    --                         break
    --                     else
    --                         if not isBypassing then
    --                             CreateUnbanThread(tostring(d.Discord))
    --                             break
    --                         end
    --                     end
    --                 end
    --             end
    --         end
    --     end
    -- end
   
end

function Ban(Discord, id, reason, day, admin, name)
    local time = day
    if time == 0 then
	    time = 2147483647
    end
    local AdminName = admin and GetPlayerName(admin) or 'System'
    MySQL.Async.execute('UPDATE bans SET Reason = @Reason, isBanned = @isBanned,bannedby=@bannedby, Expire = @Expire WHERE Discord = @Discord', 
    {
        ['@isBanned'] = 1,
        ['@Reason'] = reason,
        ['@Discord'] = Discord,
        ['@bannedby'] = AdminName,
        ['@Expire'] = os.time() + (time * 86400)
    })
    SetTimeout(5000, function()
        ReloadBans()
    end)

    for _, v in pairs(QBCore.Functions.GetPlayers()) do
        if QBCore.Functions.HasPermission(v, 'admin')  then
            TriggerClientEvent('chatMessage', v, 'PUNISHMENT', 'error', name..' has been banned: '..reason)
        end
    end

    if id > 0 then
        TriggerClientEvent('QBCore:client:advanced', id, true)
    end
    local disaccount = string.gsub(Discord, 'discord:', '')
    TriggerEvent('qb-log:server:CreateLog', 'bans', 'New Ban', 'red', 'Name: '..name..' \nDiscord: '..disaccount..' | <@'..disaccount..'> \nTime: '..tostring(time)..' days \nAdmin: '..AdminName..' \nReason: '..reason)
end exports('Ban', Ban)

-- RegisterCommand('banreload', function(source)
--     if source == 0 or QBCore.Functions.HasPermission(source, 'admin') then
--         ReloadBans()
--         if source > 0 then
--             TriggerClientEvent('QBCore:Notify', source, 'Ban List Reloaded', 'success')
--         end
--     end
-- end)

QBCore.Commands.Add('ban', 'Ban Player', {{name = 'id/Discord', help = 'For Online Player use Id else use Discord ID'}, {name = 'Time', help = 'Ban Duration as Day / 0 is permanet'}, {name = 'Name', help = 'Dani_Hernandez'}, {name = 'Reason', help = 'Ban Reason'}}, true, function(source, args)
    local time = tonumber(args[2])
    local Name = args[3]
    local Reason = table.concat(args, " ", 4)
    if time then
        if tonumber(args[1]) then
            local target = tonumber(args[1])
            if GetPlayerName(target) then
                local Discord = QBCore.Functions.GetIdentifier(target, 'discord')
                Ban(Discord, target, Reason, time, source, Name)
            else
                TriggerClientEvent('QBCore:Notify', source, 'Player is Not Online', 'error')
            end
        else
            if string.find(args[1], "discord:") then
                MySQL.Async.fetchAll('SELECT Discord FROM bans WHERE Discord = @Discord',
                {
                    ['@Discord'] = args[1]
            
                }, function(data)
                    if data[1] then
                        Ban(args[1], 0, Reason, time, source, Name)
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
end, 'admin')

QBCore.Commands.Add('unban', 'Unban Player', {{name = 'discord', help = 'Discord ID'}}, true, function(source, args)
    CreateUnbanThread(args[1])
    TriggerClientEvent('QBCore:Notify', source, args[1]..' Unbaned', 'success')
    local discord = string.gsub(args[1], 'discord:', '')
    TriggerEvent('qb-log:server:CreateLog', 'bans', 'Unban', 'green', 'Discord: '..discord..' | <@'..discord..'> \nAdmin: '..GetPlayerName(source))
end, 'admin')

QBCore.Commands.Add('ban2', 'New Ban System', {{ name = 'bsn', help = 'State ID' },{ name = 'state', help = 'true/false' }}, true, function(source, args)
    local bsn = string.upper(args[1])
    local state = string.lower(args[2])
    local target = QBCore.Functions.GetPlayerByCitizenId(bsn)
    local stttate = false
    if state ~= 'true' and state ~= 'false' then TriggerClientEvent('QBCore:Notify', source, 'Enter Correct State', 'error') return end
    if state == 'true' then
        stttate = true
    end
    if target then
        target.Functions.SetMetaData('ban2', stttate)
        TriggerEvent('qb-log:server:CreateLog', 'ban2', 'New Ban', stttate and 'green' or 'red', 'BSN: '..bsn..'\nState: '..state..'\nAdmin: '..GetPlayerName(source), false)
    else
        local result = MySQL.scalar.await('SELECT metadata FROM players WHERE citizenid = ?', {bsn})
        if result then
            local mdata = json.decode(result)
            mdata.ban2 = stttate
            local updated = json.encode(mdata)
            MySQL.update('UPDATE players SET metadata = ? WHERE citizenid = ?', {updated, bsn})
            TriggerClientEvent('QBCore:Notify', source, 'Ban State of '..bsn..' has been changed', stttate and 'success' or 'error')
            TriggerEvent('qb-log:server:CreateLog', 'ban2', 'New Ban', stttate and 'green' or 'red', 'BSN: '..bsn..'\nState: '..state..'\nAdmin: '..GetPlayerName(source), false)
        else
            TriggerClientEvent('QBCore:Notify', source, 'BSN does not exist', 'error')
        end
    end
end, 'admin')

QBCore.Commands.Add('ban3', 'New New Ban System', {{ name = 'bsn', help = 'State ID' },{ name = 'state', help = 'true/false' }}, true, function(source, args)
    local bsn = string.upper(args[1])
    local state = string.lower(args[2])
    local target = QBCore.Functions.GetPlayerByCitizenId(bsn)
    local stttate = false
    if state ~= 'true' and state ~= 'false' then TriggerClientEvent('QBCore:Notify', source, 'Enter Correct State', 'error') return end
    if state == 'true' then
        stttate = true
    end
    if target then
        target.Functions.SetMetaData('ban3', stttate)
        TriggerEvent('qb-log:server:CreateLog', 'ban3', 'New Ban', stttate and 'green' or 'red', 'BSN: '..bsn..'\nState: '..state..'\nAdmin: '..GetPlayerName(source), false)
    else
        local result = MySQL.scalar.await('SELECT metadata FROM players WHERE citizenid = ?', {bsn})
        if result then
            local mdata = json.decode(result)
            mdata.ban3 = stttate
            local updated = json.encode(mdata)
            MySQL.update('UPDATE players SET metadata = ? WHERE citizenid = ?', {updated, bsn})
            TriggerClientEvent('QBCore:Notify', source, 'Ban State of '..bsn..' has been changed', stttate and 'success' or 'error')
            TriggerEvent('qb-log:server:CreateLog', 'ban3', 'New Ban', stttate and 'green' or 'red', 'BSN: '..bsn..'\nState: '..state..'\nAdmin: '..GetPlayerName(source), false)
        else
            TriggerClientEvent('QBCore:Notify', source, 'BSN does not exist', 'error')
        end
    end
end, 'god')

RegisterNetEvent('QBCore:server:advanced', function()
    local src = source
    local isBan, Reason = IsPlayerBanned(src)
  
    if isBan then
        local Discord = nil
        for k, v in ipairs(GetPlayerIdentifiers(src)) do
            if string.sub(v,1,string.len("discord:")) == "discord:" then
                Discord = v
                break
            end
        end
        DropPlayer(src, 'You Are Ban')
        if Discord then
            local discordacc = string.gsub(Discord, 'discord:', '')
            TriggerEvent('qb-log:server:CreateLog', 'bans', 'Tried To Bypass Ban System', 'red', 'Discord: '..discordacc..' | <@'..discordacc..'>')
        end
    else
        TriggerClientEvent('QBCore:client:advanced', src, false)
    end
end)

-- MySQL.ready(function()
-- 	ReloadBans()
-- end)