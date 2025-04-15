local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("radio", function(source, item)
  TriggerClientEvent('qb-radio:use', source)
end)


QBCore.Functions.CreateUseableItem("pdradio", function(source, item)
  TriggerClientEvent('qb-radio:use', source)
end)

RegisterNetEvent('inventory:server:closedinv', function()
    local src = source
    TriggerClientEvent('qb-radio:client:checkradio', src)
end)