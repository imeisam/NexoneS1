local QBCore = exports['qb-core']:GetCoreObject()
local DiggedPos = {}

QBCore.Functions.CreateUseableItem("miningprobe", function(source, item)
    TriggerClientEvent("mining:useProbe", source, item.slot)
end)

QBCore.Functions.CreateUseableItem("miningpickaxe", function(source, item)
    TriggerClientEvent("mining:usePickaxe", source, item.slot)
end)

Citizen.CreateThread(function()
    while true do
        Wait(30 * 60 * 1000)
        DiggedPos = {}
    end
end)

RegisterServerEvent('qb-mining:giveItems')
AddEventHandler('qb-mining:giveItems', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local amn = math.random(25, 50)
    Player.Functions.AddItem('stone', amn)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["stone"], "add", amn)
end)

RegisterServerEvent("qb-mining:server:SyncDiggedPos")
AddEventHandler("qb-mining:server:SyncDiggedPos", function(pos)
    if pos then
        DiggedPos[#DiggedPos + 1] = pos
    end
end)

QBCore.Functions.CreateCallback('qb-mining:Callback:CheckIfDigged', function(source, cb, pos)
    local retval = false
    for i = 1, #DiggedPos do
        if #(pos - vector3(DiggedPos[i].x, DiggedPos[i].y, DiggedPos[i].z)) <= 2 then
            retval = true
        end
    end
    cb(retval)
end)