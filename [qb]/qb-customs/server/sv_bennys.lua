-----------------------
----   Variables   ----
-----------------------
local QBCore = exports['qb-core']:GetCoreObject()
local RepairCosts = {}

-----------------------
----   Functions   ----
-----------------------

local function IsVehicleOwned(plate)
    local result = MySQL.scalar.await('SELECT 1 from player_vehicles WHERE plate = ?', {plate})
    if result then
        return true
    else
        return false
    end
end

-----------------------
---- Server Events ----
-----------------------

AddEventHandler("playerDropped", function()
	local source = source
    RepairCosts[source] = nil
end)

RegisterNetEvent('qb-customs:server:attemptPurchase', function(type, upgradeLevel)
    TriggerClientEvent('qb-customs:client:purchaseSuccessful', source)
end)

RegisterNetEvent('qb-customs:server:updateRepairCost', function(cost)
    local source = source
    RepairCosts[source] = cost
end)

RegisterNetEvent("qb-customs:server:updateVehicle", function(vehicleProps)
    if IsVehicleOwned(vehicleProps.plate) then
        MySQL.update('UPDATE player_vehicles SET mods = ? WHERE plate = ?', {json.encode(vehicleProps), vehicleProps.plate})
    end
end)