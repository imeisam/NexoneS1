local ToggleOn = {}
local screenwebhook = 'https://discord.com/api/webhooks/1227203250546151494/AYCzeQrG5pQyWcb8loNn5bXgvDzVyXhAcciqu9hTsM-e77KLugVNjVdnQp_lFgXWrVCv'

AddEventHandler('playerDropped', function(reason)
    local src = source
    if ToggleOn[src] then
        ToggleOn[src] = nil
    end
end)

exports('IsToggleAdmin', function(src)
    return ToggleOn[src]
end)

RegisterNetEvent('admin:clearallChat', function()
    local src = source
    if src ~= 0 and onlineAdmins[src] then
        TriggerClientEvent('chat:clear', -1)
    end
end)

CreateCallback("snipe-menu:server:fetchPlayerListCustom", function(source, cb)
    local players = {}
    for _, v in pairs(QBCore.Functions.GetPlayers()) do
        local playerv = QBCore.Functions.GetPlayer(v)
        table.insert(players, {
            id = v,
            name = (playerv.PlayerData.charinfo.firstname or '') .. ' ' .. (playerv.PlayerData.charinfo.lastname or '')
        })
    end
    cb(players)
end)

RegisterNetEvent('admin:setwaypoint', function(id)
    local src = source
    if src ~= 0 and onlineAdmins[src] then
        TriggerClientEvent('admin:setwaypoint', src, GetEntityCoords(GetPlayerPed(id)))
    end
end)

RegisterNetEvent('admin:scrennshot', function(id)
    local src = source
    if src ~= 0 and onlineAdmins[src] then
        TriggerClientEvent('admin:scrennshot', id, screenwebhook)
    end
end)

RegisterNetEvent('snipe-menu:server:PutPlayerInVehicle', function(playerId)
    local src = source
    if playerId == 0 then
        playerId = src
    end
    if onlineAdmins[src] then
        local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
        if EscortPlayer then
            TriggerClientEvent("snipe-menu:client:PutInVehicle", EscortPlayer.PlayerData.source)
        end
    end
end)

RegisterNetEvent('admin:killPlayer', function(id)
    local src = source
    if src ~= 0 and onlineAdmins[src] then
        TriggerClientEvent('hospital:client:KillPlayer', id)
    end
end)

QBCore.Commands.Add("hidestaff", "Hide Staff Messages", {{name="state", help="true/false"}}, true, function(source, args)
    local state = string.lower(args[1])
    if state == 'true' then
        ToggleOn[source] = true
    elseif state == 'false' then
        ToggleOn[source] = nil
    else
        TriggerClientEvent("QBCore:Notify", source, 'Enter true/false', 'error')
    end
end, 'admin')

QBCore.Commands.Add('report', 'Report', {{name='message', help='Message'}}, true, function(source, args)
    local src = source
    local msg = table.concat(args, ' ')
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        local name = Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname
        TriggerEvent('qb-log:server:CreateLog', 'report', 'New Report', 'green', name .. ' (' .. Player.PlayerData.citizenid..' | '..source .. ') send new report,  message: '..msg)
        TriggerClientEvent('chatMessage', src, 'REPORT', 'report', msg, 'REPORT')
        for _, v in pairs(QBCore.Functions.GetPlayers()) do
            if QBCore.Functions.HasPermission(v, 'admin') and not ToggleOn[v] then
                TriggerClientEvent('chatMessage', v, 'NEW REPORT | '..name..'('..src..')', 'report', msg, 'REPORT')
            end
        end
    end
end)

QBCore.Commands.Add('reportr', 'Reply to Report', {{name='id', help='Player'}, {name = 'message', help = 'Message to respond with'}}, true, function(source, args)
    local src = source
    local playerId = tonumber(args[1])
    if not playerId then return end
    table.remove(args, 1)
    local msg = table.concat(args, ' ')
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if msg == '' then return end
    if not OtherPlayer then return TriggerClientEvent('QBCore:Notify', src, 'Player is not online', 'error') end
    local name = GetPlayerName(src)
    TriggerClientEvent('chatMessage', playerId, 'RESPONSE', 'reportr', msg, 'REPORT')
    TriggerEvent('qb-log:server:CreateLog', 'reportr', 'Admin Response', 'green', name .. ' (' .. source .. ') send reply to '..OtherPlayer.PlayerData.charinfo.firstname..' '..OtherPlayer.PlayerData.charinfo.lastname..' ('..OtherPlayer.PlayerData.citizenid..' | '..playerId..'),  message: '..msg)
    for _, v in pairs(QBCore.Functions.GetPlayers()) do
        if QBCore.Functions.HasPermission(v, 'admin') and not ToggleOn[v] then
            TriggerClientEvent('chatMessage', v, 'RESPONSE | '..name..' to '..OtherPlayer.PlayerData.charinfo.firstname..' '..OtherPlayer.PlayerData.charinfo.lastname..' ('..playerId..')', 'reportradmin', msg, 'REPORT')
        end
    end
end, 'admin')

QBCore.Commands.Add('s', 'Staff Chat', {{name='message', help='Message'}}, true, function(source, args)
    local msg = table.concat(args, ' ')
    local src = source
    local name = GetPlayerName(src)
    TriggerEvent('qb-log:server:CreateLog', 'staffchat', '**'.. name..'**', 'white', msg, false)
    for _, v in pairs(QBCore.Functions.GetPlayers()) do
        if QBCore.Functions.HasPermission(v, 'admin') and not ToggleOn[v] then
            TriggerClientEvent('chatMessage', v, 'STAFF | '..name, 'staff', msg, 'STAFF')
        end
    end
end, 'admin')

QBCore.Commands.Add('setmodel', 'Set Ped Model', {{name='model', help='Name of the model'}, {name='id', help='Id of the Player (empty for yourself)'}}, false, function(source, args)
    local model = args[1]
    local target = tonumber(args[2])
    if model ~= nil or model ~= '' then
        if target == nil then
            TriggerClientEvent('admin:client:SetModel', source, tostring(model))
        else
            local Trgt = QBCore.Functions.GetPlayer(target)
            if Trgt ~= nil then
                TriggerClientEvent('admin:client:SetModel', target, tostring(model))
            else
                TriggerClientEvent('QBCore:Notify', source, 'Player is Not Online', 'error')
            end
        end
    end
end, 'dev')