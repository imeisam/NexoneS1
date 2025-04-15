local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-paycheck:server:takepaycheck', function(amount)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddMoney('bank', amount,"Paycheck")
    Player.Functions.RemoveMoney('paycheck', amount)
    TriggerClientEvent("QBCore:Notify", source, "Take Paycheck Successfully...", "success")
end)