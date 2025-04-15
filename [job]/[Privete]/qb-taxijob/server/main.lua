local QBCore = exports['qb-core']:GetCoreObject()

function NearTaxi(src)
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    for _, v in pairs(Config.NPCLocations.DeliverLocations) do
        local dist = #(coords - vector3(v.x,v.y,v.z))
        if dist < 20 then
            return true
        end
    end
end

RegisterNetEvent('qb-taxi:server:NpcPay', function(Payment)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == 'taxi' and NearTaxi(src) then
        Player.Functions.AddMoney('paycheck', Payment, 'taxi uber')
        TriggerClientEvent('QBCore:Notify', src, 'You Got $'..Payment, 'success')
    else
        DropPlayer(src, 'Attempting To Exploit')
    end
end)

RegisterNetEvent('qb-taxi:server:opentaximeter', function(plate)
    TriggerClientEvent('qb-taxi:client:opentaximeter', -1,plate)
end)