local QBCore = exports['qb-core']:GetCoreObject()
local SubmixS = {}

QBCore.Functions.CreateUseableItem("megaphone", function(source, item)
    TriggerClientEvent("qb-megaphone:client:Toggle",source)
end)

QBCore.Functions.CreateCallback('qb-megaphone:server:getSubmixs', function(source, cb)
    cb(SubmixS)
end)

AddEventHandler("playerDropped", function()
	local src = source
    if SubmixS[src] then
        SubmixS[src] = nil
        TriggerClientEvent('qb-megaphone:client:updateSubmix', -1, false, src)
    end
end)

RegisterNetEvent('qb-megaphone:server:addSubmix', function()
    local src = source
    SubmixS[src] = true
    TriggerClientEvent('qb-megaphone:client:updateSubmix', -1, true, src)
end)

RegisterNetEvent('qb-megaphone:server:removeSubmix', function()
    local src = source
    SubmixS[src] = nil
    TriggerClientEvent('qb-megaphone:client:updateSubmix', -1, false, src)
end)