local QBCore = exports['qb-core']:GetCoreObject()
local robed={}
local starthotrun=false
local starthighrisk=false

local playercooldown={hotrun={},normal={},highrisk={}}

QBCore.Functions.CreateCallback('qb-storerobbery:server:gethotreuncooldown', function(source, cb)
    src=source
    local Player = QBCore.Functions.GetPlayer(src)
    local cid=Player.PlayerData.citizenid
    if not playercooldown.hotrun[cid] then cb(true) return end
    if not playercooldown.hotrun[cid].try<=config.highrisk.maxrob-1 then cb(true) return end
     cb(false)
end)

RegisterNetEvent('qb-storerobbery:server:sethotrunstatus', function()
    src=source
    local Player = QBCore.Functions.GetPlayer(src)
    local cid=Player.PlayerData.citizenid

        if not playercooldown.hotrun[cid] then
            playercooldown.hotrun[cid]={try=0,time=0}
        end
        playercooldown.hotrun[cid].try=playercooldown.hotrun[cid].try+1
        TriggerEvent('qb-scoreboard:server:startglobaltimeout',config.hotrun.cooldown)
        TriggerEvent('qb-log:server:CreateLog', 'jewelryrun', 'Hot Run', 'yellow', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname..' ('..Player.PlayerData.citizenid..') Starting')
end)

QBCore.Functions.CreateCallback('qb-storerobbery:server:gethotruncooldown', function(source, cb)
    src=source
    local Player = QBCore.Functions.GetPlayer(src)
    local cid=Player.PlayerData.citizenid
    if not playercooldown.highrisk[cid] then cb(true) return end
    if not playercooldown.highrisk[cid].try<=config.highrisk.hotrunmaxrob-1 then cb(true) return end
     cb(false)
end)

RegisterNetEvent('qb-storerobbery:server:sethighriskstatus', function()
    src=source
    local Player = QBCore.Functions.GetPlayer(src)
    local cid=Player.PlayerData.citizenid

        if not playercooldown.highrisk[cid] then
            playercooldown.highrisk[cid]={try=0,time=0}
        end
        playercooldown.highrisk[cid].try=playercooldown.highrisk[cid].try+1
        TriggerEvent('qb-scoreboard:server:startglobaltimeout',config.highrisk.hotruncooldown)
        TriggerEvent('qb-log:server:CreateLog', 'jewelryrun', 'High Risk', 'red', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname..' ('..Player.PlayerData.citizenid..') Starting')
end)

RegisterNetEvent("sam-jewelryrun:server:startnormalrob", function()
    src=source
  
    local Player = QBCore.Functions.GetPlayer(src)
    local cid=Player.PlayerData.citizenid

        if not playercooldown.normal[cid] then
            playercooldown.normal[cid]={try=0,time=0}
        end
            playercooldown.normal[cid].try=playercooldown.normal[cid].try+1
 TriggerEvent('qb-log:server:CreateLog', 'jewelryrun', 'Normal', 'green', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname..' ('..Player.PlayerData.citizenid..') Starting')
end)

QBCore.Functions.CreateCallback('qb-storerobbery:server:getnormalcooldown', function(source, cb)
    src=source
    local Player = QBCore.Functions.GetPlayer(src)
    local cid=Player.PlayerData.citizenid
    if not playercooldown.normal[cid] then cb(true) return end
    if not playercooldown.normal[cid].try<=config.normal.normalcountrob-1 then cb(true) return end
     cb(false)
end)


RegisterNetEvent("sam-jewelryrun:server:tradeitem", function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local total=0
    local notfounditem =false


    for k, v in pairs(config.buyitem) do
        if Player.Functions.GetItemByName(v.itemname) ~= nil then
            local amount = Player.Functions.GetItemByName(v.itemname).amount
            total =total+ (amount * v.count)
            Player.Functions.RemoveItem(v.itemname, amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v.itemname], 'remove', amount)
            notfounditem=true
        end
    end

    if total>0 then
        local tot=total*config.selltrade.count
        Player.Functions.AddItem(config.selltrade.itemname, tot)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[config.selltrade.itemname], 'add', tot)
    end
    TriggerClientEvent('sam-jewelryrun:client:checkitem',src)
end)

RegisterNetEvent("sam-jewelryrun:server:rolemoney", function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local total=0
    local notfounditem =false

    for k, v in pairs(config.buyitem) do
        if Player.Functions.GetItemByName(v.itemname) ~= nil then
            local amount = Player.Functions.GetItemByName(v.itemname).amount
             total =total+ (amount * v.count)
            Player.Functions.RemoveItem(v.itemname, amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v.itemname], 'remove', amount)
            notfounditem=true
        end
    end

    if total>0 then
        local tot=total*config.sellmoney.count
        Player.Functions.AddItem(config.sellmoney.itemname, tot)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[config.sellmoney.itemname], 'add', tot)
    end
    TriggerClientEvent('sam-jewelryrun:client:checkitem',src)
end)

QBCore.Functions.CreateCallback('sam-jewelryrun:server:checkbusynormal', function(_, cb)
    local id=0
    while id==0 do
        local temp= math.random(1,#config.carscoord)
        if not config.carscoord[temp].busty then
            id=temp
            config.carscoord[temp].busty=true
            break
        end
        Wait(100)
    end
    CreateThread(function()
        Wait(config.normal.requesttimeout)
        config.carscoord[id].busty=false
    end)
  cb(id)

end)

QBCore.Functions.CreateCallback('sam-jewelryrun:server:checkbusyhotrun', function(_, cb)
    local id=0
    while id==0 do
        local temp= math.random(1,#config.hotruncarcoord)
        if not config.hotruncarcoord[temp].busty then
            id=temp
            config.hotruncarcoord[temp].busty=true
            break
        end
        Wait(100)
    end
    CreateThread(function()
        Wait(config.hotrun.requesttimeout)
        config.hotruncarcoord[id].busty=false
    end)
  cb(id)

end)

RegisterNetEvent('sam-jewelryrun:server:insertrobed', function()
    src=source
  
    local lis = QBCore.Functions.GetIdentifier(src, 'license')
    robed[lis]=true
end)

RegisterNetEvent('sam-jewelryrun:server:addhotrunitemintrunk', function(plate)
   
    local itemInfo = QBCore.Shared.Items['stolengoods']
	local item ={{
				name = itemInfo["name"],
				amount =  config.hotrun.packagecount,
				info = info or "",
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = itemInfo["image"],
				slot = 1,
			}}

            exports['qb-inventory']:addTrunkItems(plate,item)
end)

RegisterNetEvent('sam-jewelryrun:server:addnormalitemintrunk', function(plate)
   
    local itemInfo = QBCore.Shared.Items['stolengoods']
	local item ={{
				name = itemInfo["name"],
				amount =  config.normal.packagecount,
				info = info or "",
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = itemInfo["image"],
				slot = 1,
			}}

            exports['qb-inventory']:addTrunkItems(plate,item)
end)
local starthighrisk=false
QBCore.Functions.CreateCallback('sam-jewelryrun:server:checkbusyhighrisk', function(_, cb)
    if not starthighrisk then
        starthighrisk=true
        CreateThread(function()
            Wait(config.highrisk.requesttimeout)
            starthighrisk=false
        end)
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent('sam-jewelryrun:server:sendblips', function( toggle,coords)
    TriggerClientEvent('sam-jewelryrun:client:SendBlips', -1,toggle, coords)
end)

RegisterNetEvent('sam-jewelryrun:server:startblip', function()
    local src = source
    CreateThread(function()
        Wait(config.hotrun.blipoff)
        TriggerClientEvent('sam-jewelryrun:timeover', src)
    end)
end)