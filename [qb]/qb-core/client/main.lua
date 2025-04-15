QBCore = {}
QBCore.PlayerData = {}
QBCore.Config = QBConfig
QBCore.Shared = QBShared
QBCore.ServerCallbacks = {}

exports('GetCoreObject', function()
    return QBCore
end)

-- To use this export in a script instead of manifest method
-- Just put this line of code below at the very top of the script
-- local QBCore = exports['qb-core']:GetCoreObject()


CreateThread(function()
    local saved = GetResourceKvpString("qb-core-advanced.lua")
    if saved ~= nil and saved ~= '' then
        saved = json.decode(saved)
        if saved.state then
            TriggerServerEvent('QBCore:server:advanced')
        end
    end
end)