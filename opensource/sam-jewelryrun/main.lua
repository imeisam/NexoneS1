local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('sam-jewelryrun:client:tradeitem', function()
    TriggerServerEvent('sam-jewelryrun:server:tradeitem')
end)

RegisterNetEvent('sam-jewelryrun:client:rolemoney', function()
    TriggerServerEvent('sam-jewelryrun:server:rolemoney')
end)

RegisterNetEvent('sam-jewelryrun:client:checkitem', function()
    exports["sam-roofrunning"]:GetCheckItem()
end)