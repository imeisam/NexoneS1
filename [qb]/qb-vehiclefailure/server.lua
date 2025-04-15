local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("advancedrepairkit", function(source, item)
    TriggerClientEvent("qb-vehiclefailure:client:RepairVehicleFull", source, item.slot)
end)

QBCore.Functions.CreateUseableItem("cleaningkit", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("qb-vehiclefailure:client:CleanVehicle", source)
    end
end)

RegisterNetEvent('qb-vehiclefailure:server:removewashingkit', function(veh)
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)
    ply.Functions.RemoveItem("cleaningkit", 1)
    TriggerClientEvent('qb-vehiclefailure:client:SyncWash', -1, veh)
end)