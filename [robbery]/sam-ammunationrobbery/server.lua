local QBCore = exports['qb-core']:GetCoreObject()
local robstart=false
local lootcount=0
local startsource=0
RegisterServerEvent('sam-amorob:server:containerSync')
AddEventHandler('sam-amorob:server:containerSync', function(coords, rotation,contcoord)
    TriggerClientEvent('sam-amorob:client:containerSync', -1, coords, rotation,contcoord)
end)

RegisterServerEvent('sam-amorob:server:addopencontainer')
AddEventHandler('sam-amorob:server:addopencontainer', function()
    lootcount=lootcount+1
    TriggerClientEvent('sam-amorob:client:addopencontainer',startsource,lootcount)
end)
RegisterServerEvent('sam-amrob:server:patext')
AddEventHandler('sam-amrob:server:patext', function(data,boxammocontainer,pass)
    TriggerClientEvent('sam-amrob:client:patext', -1,data,boxammocontainer,pass)
end)
RegisterServerEvent('sam-amrob:server:removeammorack')
AddEventHandler('sam-amrob:server:removeammorack', function(cont,index)
    TriggerClientEvent('sam-amrob:client:removeammorack', -1,cont,index)
end)
RegisterServerEvent('sam-amrob:server:removepatext')
AddEventHandler('sam-amrob:server:removepatext', function(cont,index)
    TriggerClientEvent('sam-amrob:client:removepatext', -1,cont,index)
end)

RegisterServerEvent('sam-amorob:server:startrob')
AddEventHandler('sam-amorob:server:startrob', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerEvent('qb-scoreboard:server:startglobaltimeout',config.globalcooldown)
    TriggerEvent('qb-log:server:CreateLog', 'ammunation', 'Ammunation Robbery', 'red', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname..' ('..Player.PlayerData.citizenid..') Starting')
    startsource=source
robstart=true
Wait(config.timeout)
robstart=false
TriggerClientEvent('sam-amorob:client:removeallobject', -1)

end)

QBCore.Functions.CreateCallback('sam-amorob:server:checkrobstart', function(source, cb)
    if robstart then
        cb(true)
    else
        cb(false)
    end
end)
freeloot={}
QBCore.Functions.CreateCallback('sam-amorob:server:checkfreeloot', function(source, cb,cont,ind)
    if not freeloot[cont..ind] then
        freeloot[cont..ind] =true
        cb(true)
    else
        cb(false)
    end
end)
RegisterServerEvent('sam-amrob:server:freeloot')
AddEventHandler('sam-amrob:server:freeloot', function(cont,ind)
    freeloot[cont..ind] =false
end)

RegisterServerEvent('sam-amorob:server:objectSync')
AddEventHandler('sam-amorob:server:objectSync', function(e)
    TriggerClientEvent('sam-amorob:client:objectSync', -1, e)
end)

RegisterServerEvent('sam-amorob:server:addtostash')
AddEventHandler('sam-amorob:server:addtostash', function()
    local idreward=math.random(1,#config.reward)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local info ={}
    if config.reward[idreward].info then
        info=config.reward[idreward].info
    end
    if config.reward[idreward].count>0 then
        Player.Functions.AddItem(config.reward[idreward].name, config.reward[idreward].count,false,info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[config.reward[idreward].name], "add", config.reward[idreward].count)
    end
end)

