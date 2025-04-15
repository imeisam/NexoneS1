local QBCore = exports['qb-core']:GetCoreObject()
local isintimeout = true
local SiktirOn = false
local currenCops = 0

AddEventHandler('police:SetCopCount', function(num,numhigh)
    currenCops = num
end)

AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
    TriggerClientEvent('qb-cooldown:client:cooldown', Player.PlayerData.source, isintimeout)
end)

RegisterNetEvent('qb-cooldown:server:startglobaltimeout', function(min)
    if not isintimeout then
        isintimeout = true
        TriggerClientEvent('qb-cooldown:client:cooldown', -1, true)
        SetTimeout(min*60*1000, function()
            if not SiktirOn then
                isintimeout = false
                TriggerClientEvent('qb-cooldown:client:cooldown', -1, false)
            end
        end)
    end
end)

QBCore.Functions.CreateCallback('qb-cooldown:server:GetCops', function(_, cb)
    local players = QBCore.Functions.GetQBPlayers()
    robberylist= config.robberylist 
    for k,v in pairs(config.robberylist) do
        if v.policeneed<currenCops then
           robberylist[k].cooldown=false
        else
            robberylist[k].cooldown=true
        end
    end
    cb(robberylist,isintimeout)
end)
QBCore.Commands.Add("robberystate", "Check Police need for robbery", {}, true, function(source, args)
    local src = source
    TriggerClientEvent('qb-cooldown:client:showlist',src)
end,'god')

QBCore.Commands.Add("cooldownstate", "Change State of Robberies Cooldown", {{name="state", help="true/false"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    if ((Player.PlayerData.job.name == 'police' or Player.PlayerData.job.name == 'justice') and (Player.PlayerData.job.isboss or QBCore.Functions.HasDivision(src, 'hc'))) or QBCore.Functions.HasPermission(src, 'dev') then
        local state = string.lower(args[1])
        if state == 'true' then
            isintimeout = true
            SiktirOn = true
            TriggerClientEvent('qb-cooldown:client:cooldown', -1, true)
        elseif state == 'false' then
            isintimeout = false
            SiktirOn = false
            TriggerClientEvent('qb-cooldown:client:cooldown', -1, false)
        else
            TriggerClientEvent("QBCore:Notify", source, 'Enter true/false', 'error')
        end
    else
        TriggerClientEvent("QBCore:Notify", source, 'No Access', 'error')
    end
end)

CreateThread(function()
    SetTimeout(1*60*1000, function()
        if not SiktirOn then
            isintimeout = false
            TriggerClientEvent('qb-cooldown:client:cooldown', -1, false)
        end
    end)
end)

function getneedpolice(name)
    for k,v in pairs(config.robberylist) do
        if v.identify and v.identify==name then
            return v.policeneed
        end
    end
    return 50
end
exports("getneedpolice",getneedpolice)

exports('isCooldown', function()
    if exports["qb-smallresources"]:getdevelopermode() then
        return true
    end
    if isintimeout then
        QBCore.Functions.Notify("City is not Safe", "error")
    end
    return not isintimeout
end)
