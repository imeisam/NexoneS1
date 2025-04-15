local QBCore = exports['qb-core']:GetCoreObject()
local startmis={}
QBCore.Functions.CreateUseableItem(Config.ItemName, function(source, item)
    local src = source
    if not startmis[src] then
        TriggerClientEvent("qb-atmrobbery:client:UseTowingRope", src)
    else
        TriggerClientEvent('QBCore:Notify', source, "Not allow in this time.",'error')
    end
end)

QBCore.Functions.CreateUseableItem(Config.ATMItemName, function(source, item)
    local src = source
    TriggerClientEvent("qb-atmrobbery:client:UseATMObject", src)
end)


RegisterNetEvent('qb-atmrobbery:cooldown', function()
    local src = source
    Citizen.CreateThread(function()
        startmis[src]=true
        Citizen.Wait(Config.cooldown*60*1000)
        startmis[src]=false
    end)
end)


RegisterNetEvent('qb-atmrobbery:createRopeForAll', function(VehCoord, ATMCoord)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local BSN = Player.PlayerData.citizenid
	TriggerClientEvent("qb-atmrobbery:client:Sync", -1, src, VehCoord, ATMCoord, BSN)
end)

RegisterNetEvent('qb-atmrobbery:DeleteRopeDelete', function(coord)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local BSN = Player.PlayerData.citizenid
	TriggerClientEvent("qb-atmrobbery:client:DeleteRopeDelete", -1, coord, BSN)
end)

-- RegisterNetEvent('inventory:server:SaveInventory', function()
--     local src = source
--     TriggerClientEvent("qb-atmrobbery:client:UpdateEmote", src)
-- end)
RegisterNetEvent('inventory:server:closedinv', function()
    local src = source
    TriggerClientEvent("qb-atmrobbery:client:UpdateEmote", src)
end)

RegisterNetEvent('qb-atmrobbery:server:DeleteObj', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local BSN = Player.PlayerData.citizenid
    TriggerClientEvent("qb-atmrobbery:client:DeleteObject", -1, BSN)
end)

RegisterNetEvent('qb-atmrobbery:server:AddRewardForATMObj', function(typee)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Reward
    if typee=="search" then
        Reward = math.random(Config.SearchRewardCash["min"], Config.SearchRewardCash["max"])
    else
        Player.Functions.RemoveItem(Config.ATMItemName, 1)
        TriggerClientEvent('inventory:client:ItemBox',source, QBCore.Shared.Items[Config.ATMItemName], "remove")
        Reward = math.random(Config.ATMRewardCash["min"], Config.ATMRewardCash["max"])
        Wait(100)
        TriggerClientEvent("qb-atmrobbery:client:UpdateEmote", src)
        local chance= math.random(1, 100)
        if Config.itemchance>=chance then
            Player.Functions.AddItem(Config.itemdropname, 1)
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.itemdropname], "add")
        end
    end
	
    Player.Functions.AddMoney('cash', tonumber(Reward), "ATM")
    TriggerClientEvent('QBCore:Notify', source, "You Give ".. tonumber(Reward)..'$ Cash','success')
end)