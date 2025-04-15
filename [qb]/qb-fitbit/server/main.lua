local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("fitbit", function(source)
    TriggerClientEvent('qb-fitbit:use', source)
end)