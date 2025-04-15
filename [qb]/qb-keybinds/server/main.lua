local QBCore = exports['qb-core']:GetCoreObject()
local keyData = {
    ['F2'] ={command="",argument=""},
    ['F3'] = {command="",argument=""},
    ['F5'] = {command="",argument=""},
    ['F6'] = {command="",argument=""},
    ['F7'] = {command="",argument=""},
    ['F9'] = {command="",argument=""},
    ['F10'] = {command="",argument=""},
}


exports('setupBinds', function(Data)
    local newData = keyData
    if Data and Data.commandbinds then
        for k,v in pairs(keyData) do
            if Data.commandbinds[k] then
                newData[k] = Data.commandbinds[k]
            end
        end
    end
    return newData
end)

RegisterNetEvent('qb-commandbinding:server:setKeyMeta', function(keyMeta)
    local src = source
    local ply =QBCore.Functions.GetPlayer(src)
    ply.Functions.SetMetaData("commandbinds", keyMeta)
end)

QBCore.Commands.Add('binds', '', {}, true, function(source, args)
    TriggerClientEvent("qb-commandbinding:client:openUI", source)
end)