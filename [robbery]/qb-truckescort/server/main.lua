local QBCore = exports['qb-core']:GetCoreObject()
local Started = false

QBCore.Functions.CreateUseableItem("cardg", function(source)
    if Started then TriggerClientEvent('QBCore:Notify', source, 'There is an Active Truck Robbery', 'error') return end
    TriggerClientEvent("qb-truckescort:UseCard", source)
end)

RegisterNetEvent('qb-truckescort:server:checkForStart', function()
    local src = source
    Started = true
    SetTimeout(3 * 60 * 1000 * 60, function()
        Started = false
        TriggerClientEvent('qb-truckescort:timeover', src)
    end)
end)

RegisterNetEvent('qb-truckescort:server:BlipofSerfanJahatOff', function(state, coords)
    TriggerClientEvent('qb-truckescort:SendBlips', -1, state, coords)
end)

RegisterNetEvent('qb-truckescort:server:GetReward', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local amount = math.random(12000, 18000)
    if not Started then return end
    Player.Functions.AddItem('banded_cash', amount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['banded_cash'], "add", amount)
    TriggerEvent('qb-log:server:CreateLog', 'truckrob', 'Truck Escort', 'green', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.citizenid .. ') Successfully Robbed a Truck and got $'..amount..' dirty money')
	TriggerEvent('qb-log:server:CreateLog', 'robberylost', 'Truck Escort', 'red', 'Lost: $'..amount)
    local chance = math.random(1,100)
    if chance<=40 then
        Player.Functions.AddItem('security_card', amount)
        TriggerClientEvent('inventory:client:ItemBox', PlayerId,  QBCore.Shared.Items['security_card'], 'add')
        disc= QBCore.Shared.Items['security_card'].label
    elseif chance<=60 then
        Player.Functions.AddItem('grinder', amount)
        TriggerClientEvent('inventory:client:ItemBox', PlayerId,  QBCore.Shared.Items['grinder'], 'add')
        disc= QBCore.Shared.Items['grinder'].label
    end
end)