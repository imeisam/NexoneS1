local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem('policebadge', function(source, item)
    TriggerClientEvent('qb-policebadge:client:openBadge', source, item.info, true)
    local PlayerPed = GetPlayerPed(source)
    local PlayerCoords = GetEntityCoords(PlayerPed)
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local TargetPed = GetPlayerPed(v)
        local dist = #(PlayerCoords - GetEntityCoords(TargetPed))
        if dist < 3.0 and PlayerPed ~= TargetPed then
            TriggerClientEvent('qb-policebadge:client:openBadge', v, item.info, false)
        end
    end
end)

RegisterNetEvent('qb-policebadge:server:add', function(info)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.AddItem('policebadge', 1, nil, info)
end)