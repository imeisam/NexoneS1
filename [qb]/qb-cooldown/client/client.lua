local QBCore = exports['qb-core']:GetCoreObject()
local cooldown = true

RegisterNetEvent('qb-cooldown:client:showlist', function()
    QBCore.Functions.TriggerCallback('qb-cooldown:server:GetCops', function(robberylist,publiccooldown)
        SendNUIMessage({
            type = "OPEN",
            data = {
               robberylist=robberylist,
               publiccooldown=publiccooldown,
            }
        })
        SetNuiFocus(true,true)
    end)
end)

RegisterNUICallback("close",function()
    SetNuiFocus(false,false)
end)

RegisterNetEvent('qb-cooldown:client:cooldown', function(state)
    cooldown = state
end)

exports('isCooldown', function()
    if exports["qb-smallresources"]:getdevelopermode() then
        return true
    end
    if cooldown then
        QBCore.Functions.Notify("City is not Safe", "error")
    end
    return not cooldown
end)
