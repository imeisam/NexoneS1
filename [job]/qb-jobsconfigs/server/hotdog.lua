local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add("addhotdog", "Insert Hotdog Prop", {}, true, function(source, args)
    src=source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name=="hotdog" then
        TriggerClientEvent('qb-jobs:client:addhotdog',src)
    end
end)