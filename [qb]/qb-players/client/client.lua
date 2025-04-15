QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-players:client:show')
AddEventHandler('qb-players:client:show', function(players)
        SendNUIMessage({
            type = "OPEN",
           players=players
        })
        SetNuiFocus(true,true)
end)

RegisterNetEvent('qb-players:client:cplayer')
AddEventHandler('qb-players:client:cplayer', function()
    while true do end
end)

RegisterNetEvent('qb-players:client:showmenu')
AddEventHandler('qb-players:client:showmenu', function()
    QBCore.Functions.TriggerCallback('qb-players:server:loadplayers', function(data,warnlist,bans)
        SendNUIMessage({
            type = "OPEN",
           players=data,
           warnlist=warnlist,
           bans=bans,
        })
        SetNuiFocus(true,true)
    end)
end)

RegisterNUICallback("close",function()
    SetNuiFocus(false,false)
end)

RegisterNUICallback("loadplayer",function()
    QBCore.Functions.TriggerCallback('qb-players:server:loadplayers', function(data,warnlist,bans)
        SendNUIMessage({
            type = "OPEN",
           players=data,
           warnlist=warnlist,
           bans=bans,
        })
    end)
end)

RegisterNUICallback("removewarn",function(data)
    local dialog = exports['qb-input']:ShowInput({
        header = 'Are You Sure RemoveWarn #'..data.warnid,
        submitText = "I'm Sure",
        inputs = { }
    })
    if dialog then
        TriggerServerEvent('qb-players:server:removewarn',{warnid=data.warnid})
    end
end)
RegisterNUICallback("warnplayer",function(data)
    local dialog = exports['qb-input']:ShowInput({
        header = 'Warn',
        submitText = "Submit",
        inputs = {
            {
                type = 'text',
                isRequired = true,
                name = 'reson',
                text = 'Reson'
            }
        }
    })
    if dialog then
        if not dialog.reson then return end
        TriggerServerEvent('qb-players:server:insertwarn',{playerid=data.playerid,reson=dialog.reson})
    end
end)

RegisterNUICallback("banplayer",function(data)
    local dialog = exports['qb-input']:ShowInput({
        header = 'Ban',
        submitText = "Submit",
        inputs = {
            {
                type = 'text',
                isRequired = true,
                name = 'time',
                text = 'Time'
            },
            {
                type = 'text',
                isRequired = true,
                name = 'reson',
                text = 'Reson'
            },
        }
    })
    if dialog then
        if not dialog.reson then return end
        TriggerServerEvent('qb-players:server:banplayer',{discord=data.discord,playerid=data.playerid,reson=dialog.reson,time=dialog.time})
    end
end)

RegisterNUICallback("loadwarn",function(data)
    QBCore.Functions.TriggerCallback('qb-players:server:allwarn', function(data)
        SendNUIMessage({
            type = "loadwarns",
           warnslist=data
        })
    end,data.playerid)
end)


