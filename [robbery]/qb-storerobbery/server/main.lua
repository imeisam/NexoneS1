local QBCore = exports['qb-core']:GetCoreObject()
local playercooldown={register={},safe={}}
CreateThread(function()
    while true do
        local toSend = {}
        for k, v in ipairs(Config.Registers) do
            if Config.Registers[k].time > 0 and (Config.Registers[k].time - 1000) >= 0 then
                Config.Registers[k].time = Config.Registers[k].time - 1000
            else
                if Config.Registers[k].robbed then
                    Config.Registers[k].time = 0
                    Config.Registers[k].robbed = false
                    TriggerClientEvent('qb-storerobbery:client:setRegisterStatus', -1, k, false)
                end
            end
        end
        Wait(1000)
    end
end)

QBCore.Functions.CreateCallback('qb-storerobbery:server:getRegisterStatus', function(source, cb)
    cb(Config.Registers)
end)
-- GetGameTimer() + (config.cooldownAfterSuccessfulHack * 1000)

QBCore.Functions.CreateCallback('qb-storerobbery:server:getSafeStatus', function(source, cb)
    cb(Config.Safes)
end)

QBCore.Functions.CreateCallback('qb-storerobbery:server:getregistercooldown', function(source, cb)
    src=source
    local Player = QBCore.Functions.GetPlayer(src)
    local cid=Player.PlayerData.citizenid
    if not playercooldown.register[cid] then cb(true) return end
    if playercooldown.register[cid].time>0 then
        if  GetGameTimer()>=playercooldown.register[cid].time then
             playercooldown.register[cid]=nil
             cb(true)
             return
         else
             cb(false)
             return
         end
    else
        cb(true)
        return
    end

end)

RegisterNetEvent('qb-storerobbery:server:setRegisterStatus', function(register)
    src=source
    Config.Registers[register].robbed = true
    Config.Registers[register].time = (60 * 1000) * 30
    local Player = QBCore.Functions.GetPlayer(src)
    local cid=Player.PlayerData.citizenid

        if not playercooldown.register[cid] then
            playercooldown.register[cid]={try=0,time=0}
        end
        if  playercooldown.register[cid].try<Config.playerregistercount-1 then
            playercooldown.register[cid].try=playercooldown.register[cid].try+1
        else
            if playercooldown.register[cid].time==0 then
                playercooldown.register[cid].time= GetGameTimer() + ((Config.playerregistercooldown*60) * 1000)
            end
        end
    TriggerClientEvent('qb-storerobbery:client:setRegisterStatus', -1, register, true)
end)

RegisterNetEvent('qb-storerobbery:server:setSafeStatus', function(safe)
    TriggerClientEvent('qb-storerobbery:client:setSafeStatus', -1, safe, true)
    Config.Safes[safe].robbed = true
    SetTimeout(math.random(60, 90) * (60 * 1000), function()
        TriggerClientEvent('qb-storerobbery:client:setSafeStatus', -1, safe, false)
        Config.Safes[safe].robbed = false
    end)
end)

-- RegisterNetEvent('qb-storerobbery:server:takeMoney', function()
--     local src = source
-- 	local Player = QBCore.Functions.GetPlayer(src)
--     local amount = math.random(500, 700)

--     Player.Functions.AddItem('banded_cash', amount)
--     TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['banded_cash'], "add", amount)
--     TriggerEvent('qb-log:server:CreateLog', 'storerob', 'Store Robbery', 'blue', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.citizenid .. ') is Robbing a Store and got $'..amount..' dirty money')
-- end)

RegisterNetEvent('qb-storerobbery:server:finishLockpick', function()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local amount = math.random(700, 1200)
    Player.Functions.AddItem('banded_cash', amount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['banded_cash'], "add", amount)
    local chance =math.random(1,100)
    local givesafe=""
    if chance<=10 then
        Wait(100)
        Player.Functions.AddItem('safe_cracker', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['safe_cracker'], "add", 1)
        givesafe="And 1 Safe Cracker"
    end
    TriggerEvent('qb-log:server:CreateLog', 'storerob', 'Store Robbery', 'green', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.citizenid .. ') Successfully Robbed a Store and got $'.. amount..' banded cash '..givesafe)

end)

RegisterNetEvent('qb-storerobbery:server:SafeReward', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local amount = math.random(10000, 15000)
    Player.Functions.AddItem('banded_cash', amount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['banded_cash'], "add", amount)
    TriggerEvent('qb-log:server:CreateLog', 'saferob', 'Safe Store Robbery', 'green', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.citizenid .. ') Successfully Robbed a Safe Store and got $'..amount..' dirty money')
    -- TriggerEvent('qb-log:server:CreateLog', 'robberylost', 'Safe Store Robbery', 'red', 'Lost: $'..amount)
    local itemsrrr = {'laundro_gen_usb','cardg'}
    local rewarditem = itemsrrr[math.random(1, #itemsrrr)]
    local chance=math.random(1,100)
   if chance <= 25 then
    local info = {
        type = 'heavypistol'
      }
        Player.Functions.AddItem("blueprint", 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["blueprint"], "add")
		TriggerEvent('qb-log:server:CreateLog', 'saferob', 'Safe Store Robbery', 'green', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.citizenid .. ') Successfully Robbed a Safe Store and got a '.. QBCore.Shared.Items[rewarditem].label)
   elseif chance <50 and chance >25 then
        Player.Functions.AddItem(rewarditem, 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[rewarditem], "add", 1)
		TriggerEvent('qb-log:server:CreateLog', 'saferob', 'Safe Store Robbery', 'green', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.citizenid .. ') Successfully Robbed a Safe Store and got a '.. QBCore.Shared.Items['towingrope'].label)
    elseif chance >=50 then
        Player.Functions.AddItem('towingrope', 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['towingrope'], "add", 1)
		TriggerEvent('qb-log:server:CreateLog', 'saferob', 'Safe Store Robbery', 'green', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.citizenid .. ') Successfully Robbed a Safe Store and got a '.. QBCore.Shared.Items['towingrope'].label)

    end
    -- if math.random(1,100) <= 30 then
    --     Player.Functions.AddItem('gangtoken', 1)
    --     TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['gangtoken'], "add", 1)
    --     TriggerEvent('qb-log:server:CreateLog', 'saferob', 'Safe Store Robbery', 'red', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.citizenid .. ') Got Gang Token')
    -- end
    if Player.PlayerData.gang.name ~= 'none' then
        Player.Functions.AddItem('gangpoint', 200)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['gangpoint'], 'add', 200)
        if QBCore.Shared.Gangs[Player.PlayerData.gang.name].isfamily then
            Player.Functions.AddItem('gangpoint', 100)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['gangpoint'], 'add', 100)
        end
    end
end)