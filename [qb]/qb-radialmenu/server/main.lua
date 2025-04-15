local QBCore = exports['qb-core']:GetCoreObject()

local trunkBusy = {}

RegisterNetEvent('qb-radialmenu:trunk:server:Door', function(open, plate, door)
    TriggerClientEvent('qb-radialmenu:trunk:client:Door', -1, plate, door, open)
end)

RegisterNetEvent('qb-trunk:server:setTrunkBusy', function(plate, busy)
    trunkBusy[plate] = busy
end)

RegisterNetEvent('qb-trunk:server:KidnapTrunk', function(targetId, closestVehicle)
    TriggerClientEvent('qb-trunk:client:KidnapGetIn', targetId, closestVehicle)
end)

QBCore.Functions.CreateCallback('qb-trunk:server:getTrunkBusy', function(_, cb, plate)
    if trunkBusy[plate] then cb(true) return end
    cb(false)
end)

QBCore.Commands.Add("getintrunk", Lang:t("general.getintrunk_command_desc"), {}, false, function(source)
    TriggerClientEvent('qb-trunk:client:GetIn', source)
end)

QBCore.Functions.CreateCallback('qb-radialmenu:server:hasadminperm', function(source, cb)
    if QBCore.Functions.HasPermission(source, 'admin') then
        cb(true)
    else
        cb(false)
    end
end)