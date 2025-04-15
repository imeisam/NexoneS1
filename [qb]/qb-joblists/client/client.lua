QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-joblist:client:show')
AddEventHandler('qb-joblist:client:show', function(players,jobname,playerjobname)
        SendNUIMessage({
            type = "OPEN",
           players=players,
           jobname=jobname,
           playerjobname=playerjobname,
        })
        SetNuiFocus(true,true)
end)
RegisterNetEvent('qb-joblist:client:showmenu')
AddEventHandler('qb-joblist:client:showmenu', function()
    TriggerServerEvent('qb-joblist:server:showmenu')
end)

RegisterNUICallback("close",function()
    SetNuiFocus(false,false)
end)
