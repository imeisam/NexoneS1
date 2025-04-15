local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("chair", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('chair', 1)
    TriggerClientEvent("qb-sit:client:AddChair", source)
end)

RegisterNetEvent('qb-sit:server:AddChair', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.AddItem('chair', 1)
end)

RegisterNetEvent('qb-sit:server:sitchairplayer', function(playerid,coord)
    TriggerClientEvent("qb-sit:client:sitchair", playerid,nil,coord)
end)


