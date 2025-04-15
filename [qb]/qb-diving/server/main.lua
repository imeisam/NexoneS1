local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-diving:server:RemoveGear', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.RemoveItem("diving_gear", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["diving_gear"], "remove")
end)

RegisterNetEvent('qb-diving:server:GiveBackGear', function(oxygen)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if oxygen > 0 then
        Player.Functions.AddItem("diving_gear", 1, false, {['oxygen']=oxygen})
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["diving_gear"], "add")
    end
end)

QBCore.Functions.CreateCallback('qb-diving:server:RemoveGear', function(src, cb)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then
        cb(false)
        return
    end
    local divingGear = Player.Functions.GetItemByName("diving_gear")
    if divingGear.amount > 0 then
        local oxygen = 1000
        if divingGear.info.oxygen ~= nil then
            oxygen = divingGear.info.oxygen
        end
        Player.Functions.RemoveItem("diving_gear", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["diving_gear"], "remove")
        cb(true, oxygen)
        return
    end
    cb(false, 0)
end)

-- Items

QBCore.Functions.CreateUseableItem("diving_gear", function(source)
    TriggerClientEvent("qb-diving:client:UseGear", source, true)
end)

-- Commands

QBCore.Commands.Add("divingsuit", Lang:t("info.command_diving"), {}, false, function(source)
    TriggerClientEvent("qb-diving:client:UseGear", source, false)
end)
