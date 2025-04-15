local QBCore = exports['qb-core']:GetCoreObject()
QBCore.Functions.CreateCallback('nxo-handeling:server:getdata', function(source, cb)
    cb(config.handeling)
end)