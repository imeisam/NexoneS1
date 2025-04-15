local QBCore = exports['qb-core']:GetCoreObject()
local calls = {}
local callCount = 0

-- Functions
exports('GetDispatchCalls', function()
    return calls
end)

-- Events
RegisterNetEvent('qb-dispatch:server:log', function(name, message)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        TriggerEvent('qb-log:server:CreateLog', name, Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname.." ("..Player.PlayerData.citizenid..")", 'white', message, false)
    end
end)
isexplosive=false
RegisterServerEvent('qb-dispatch:server:notify', function(data)
    callCount = callCount + 1
    data.id = callCount
    data.time = os.time() * 1000
    data.units = {}
    data.responses = {}
    if data.codeName=="explosion" and isexplosive then
        return
    end

    if data.codeName=="explosion" then
        CreateThread(function()
            isexplosive=true
            Wait(2000)
            isexplosive=false
          end)
    end
    if #calls >= Config.MaxCallList then
        table.remove(calls, 1)
    end

    calls[#calls + 1] = data

    TriggerClientEvent('qb-dispatch:client:notify', -1, data)
end)

RegisterServerEvent('qb-dispatch:server:attach', function(id, player)
    for i=1, #calls do
        if calls[i]['id'] == id then
            for j = 1, #calls[i]['units'] do
                if calls[i]['units'][j]['citizenid'] == player.citizenid then
                    return
                end
            end
            calls[i]['units'][#calls[i]['units'] + 1] = player
            return
        end
    end
end)

RegisterServerEvent('qb-dispatch:server:detach', function(id, player)
    for i = #calls, 1, -1 do
        if calls[i]['id'] == id then
            if calls[i]['units'] and (#calls[i]['units'] or 0) > 0 then
                for j = #calls[i]['units'], 1, -1 do
                    if calls[i]['units'][j]['citizenid'] == player.citizenid then
                        table.remove(calls[i]['units'], j)
                    end
                end
            end
            return
        end
    end
end)

-- Callbacks
lib.callback.register('qb-dispatch:callback:getLatestDispatch', function(source)
    return calls[#calls]
end)

lib.callback.register('qb-dispatch:callback:getCalls', function(source)
    return calls
end)

-- Commands
QBCore.Commands.Add("dispatchmenu", locale('open_dispatch'), {}, false, function(source, args)
    TriggerClientEvent("qb-dispatch:client:openMenu", source, calls)
end)

QBCore.Commands.Add("911", "Send a message to 911", {{name = 'message', help = "911 Message"}}, true, function(source, args)
    local message = table.concat(args, ' ')
    TriggerClientEvent('qb-dispatch:client:sendEmergencyMsg', source, message, "911", false,false)
end)

QBCore.Commands.Add("311", "Send a message to 311", {{name = 'message', help = "311 Message"}}, true, function(source, args)
    local message = table.concat(args, ' ')
    TriggerClientEvent('qb-dispatch:client:sendEmergencyMsg', source, message, "311", false,false)
end)