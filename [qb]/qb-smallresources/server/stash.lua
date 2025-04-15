local QBCore = exports['qb-core']:GetCoreObject()
local Stash = {}

MySQL.ready(function()
	MySQL.Async.fetchAll('SELECT * FROM hiddenstash', {}, function(result)
        if result[1] then
            for k,v in pairs(result) do
                Stash[v.id] = json.decode(v.data)
            end
        end
    end)
end)

QBCore.Functions.CreateCallback('qb-hiddenstash:server:GetStash', function(source, cb)
    cb(Stash, QBCore.Functions.HasPermission(source, 'admin'))
end)
CreateThread(function()
    MySQL.query.await("DELETE FROM stashitems WHERE stash LIKE 'Dumpsters%'", {})
end)
RegisterNetEvent('qb-hiddenstash:server:createStash', function(Data)
    local src = source
    if not QBCore.Functions.HasPermission(src, 'admin') then return end
    MySQL.Async.insert('INSERT INTO hiddenstash (creator, data) VALUES (?, ?)', {
        GetPlayerName(src), json.encode(Data)
    }, function(id)
        Stash[id] = Data
        TriggerClientEvent('qb-hiddenstash:client:addStash', -1, id, Data)
        TriggerClientEvent('QBCore:Notify', src, "Stash Created", "success")
        TriggerEvent('qb-log:server:CreateLog', 'hiddenstash', 'New Stash', 'green', GetPlayerName(src)..'\nStash ID: '..id..'\nData: '..json.encode(Data))
    end)
end)

RegisterNetEvent('qb-hiddenstash:server:deleteStash', function(id)
    local src = source
    if not QBCore.Functions.HasPermission(src, 'admin') then return end
    MySQL.Async.execute('DELETE FROM hiddenstash WHERE id = ?', {id}, function()
        Stash[id] = nil
        MySQL.Sync.execute('DELETE FROM stashitems WHERE stash = ?', {id..'_stashhidden'})
        TriggerClientEvent('qb-hiddenstash:client:removeStash', -1, id)
        TriggerClientEvent('QBCore:Notify', src, "Stash Deleted", "success")
        TriggerEvent('qb-log:server:CreateLog', 'hiddenstash', 'Delete Stash', 'red', GetPlayerName(src)..'\nStash ID: '..id)
    end)
end)

QBCore.Commands.Add('createstash', 'Create New Stash', {}, false, function(source)
    TriggerClientEvent('qb-hiddenstash:client:createStash', source)
end, 'admin')

CreateThread(function()
    local data = MySQL.query.await("DELETE FROM stashitems WHERE stash LIKE 'dumpster-%'", {})
end)