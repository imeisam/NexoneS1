QBCore = exports['qb-core']:GetCoreObject()
local playercooldown={}

RegisterNetEvent('sam-Roofrunning:server:startrob', function(jobid)
    src=source
    local Player = QBCore.Functions.GetPlayer(src)
    local cid=Player.PlayerData.citizenid
        if not playercooldown[cid] then
            playercooldown[cid]={try=0,time=0}
        end
        if  playercooldown[cid].try<config.countrob-1 then
            playercooldown[cid].try=playercooldown[cid].try+1
        else
            if playercooldown[cid].time==0 then
                playercooldown[cid].time= GetGameTimer() + ((config.cooldownrob*60) * 1000)
            end
        end

    TriggerEvent('qb-log:server:CreateLog', 'roofruning', 'Roof Runing', 'red', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname..' ('..Player.PlayerData.citizenid..') Starting',true)
end)
function freezone ()
    local loc={}
	for k, v in pairs(config.zone) do
		if not v.busy then
			loc[#loc+1]=config.zone[k]
            loc[#loc].id=k
		end
	end

    local zoneid=math.random(1,#loc)
    print(zoneid)
    config.zone[loc[zoneid].id].busy=true
    return config.zone[zoneid].id 
end

QBCore.Functions.CreateCallback('sam-Roofrunning:server:getregistercooldown', function(source, cb)
    src=source
    local Player = QBCore.Functions.GetPlayer(src)
    local cid=Player.PlayerData.citizenid
    if not playercooldown[cid] then cb(true,freezone()) return end
    if playercooldown[cid].time>0 then
        if  GetGameTimer()>=playercooldown[cid].time then
             playercooldown[cid]=nil
             cb(true,freezone())
             return
         else
             cb(false,nil)
             return
         end
    else
        cb(true,freezone())
        return
    end

end)

RegisterServerEvent('sam-Roofrunning:server:additem')
AddEventHandler('sam-Roofrunning:server:additem', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item =config.giveitemlist[math.random(1,#config.giveitemlist)]

    Player.Functions.AddItem(item, 1)               
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add", 1)
end)

RegisterNetEvent('inventory:server:closedinv', function()
    TriggerClientEvent('sam-Roofrunning:client:checkitem', source)
end)

RegisterNetEvent('sam-Roofrunning:server:removesync', function(coord,model)
    TriggerClientEvent('sam-Roofrunning:client:removesync', -1,coord,model)
end)

QBCore.Functions.CreateCallback('sam-Roofrunning:server:getlocation', function(_, cb)
    cb(config.zone)
end)


