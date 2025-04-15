local QBCore = exports['qb-core']:GetCoreObject()
local Code = nil
local LoadConfig = {}

local function GetGangCrafts()
    return Config.Gang.Craft
end exports('GetGangCrafts', GetGangCrafts)

CreateThread(function()
    local path = GetResourcePath(GetCurrentResourceName())
    local file = io.open(path.."/config.lua", "r")
    if file then
        Code = file:read("*a")
        file:close()
    end
end)

AddEventHandler('playerDropped', function()
    local src = source
    if LoadConfig[src] then
        LoadConfig[src] = nil
    end
end)

RegisterNetEvent("qb-jobs:server:getConfig", function()
    local src = source
    if not LoadConfig[src] then
        LoadConfig[src] = true
        TriggerClientEvent("qb-jobs:client:loadConfig", src, Code)
    end
end)

RegisterNetEvent('qb-jobs:server:sellItem', function(item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local price = Config.Jobs.Sell[Player.PlayerData.job.name].items[item]
    if price then
        if Player.Functions.RemoveItem(item, amount) then
            local toBoss = Config.Jobs.Sell[Player.PlayerData.job.name].boss
            local bossPrcent = 0
            local agentPrecent = 1
            if toBoss then
                bossPrcent = toBoss/100
                agentPrecent = (100-toBoss)/100
            end
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove", amount)
            if bossPrcent > 0 then
                    exports["snipe-banking"]:AddMoneyToAccount(Player.PlayerData.job.name,amount * bossPrcent * price,"Pay From "..Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname)
                -- exports['qb-management']:AddMoney(Player.PlayerData.job.name, amount * bossPrcent * price)
            end
            if agentPrecent > 0 then
                Player.Functions.AddMoney('bank', amount * agentPrecent * price, "Sell "..amount.."x "..QBCore.Shared.Items[item].label)
            end
            TriggerClientEvent('QBCore:Notify', src, 'You have sold items', 'success')
            if Player.PlayerData.job.name == 'hyper' then
                TriggerEvent('qb-log:server:CreateLog', 'hyper', 'Sell Food', "white", Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname.." Sell "..amount.."x of "..QBCore.Shared.Items[item].label..' for $'..amount*price, false)
            end
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have enough Item', 'error')
        end
    end
end)

RegisterNetEvent('qb-jobs:server:SeparateGetItem', function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local items = Config.Jobs.Separate[Player.PlayerData.job.name].items[item]
    if items then
        if Player.Functions.GetItemByName(item) ~= nil then
            Player.Functions.RemoveItem(item, 1)
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[item], "remove")
            for k, v in pairs(items) do
                Player.Functions.AddItem(k, v)
                TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[k], "add", v)
            end
        else
            TriggerClientEvent('QBCore:Notify', src, 'You Dont Have '..QBCore.Shared.Items[item].label, 'error')
        end
    end
end)

RegisterNetEvent('qb-jobs:server:craftItem', function(cTable, cItem, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not cTable or not cItem then return end
    local itemsTable = Config.Jobs.Craft[cTable]
    if not itemsTable then return end
    if itemsTable.jobname and itemsTable.jobname ~= Player.PlayerData.job.name then return end
    local item = itemsTable.items[cItem]
    if not item then return end
    local MyOldInventory = Player.PlayerData.items
    local removed = true
    local requiredItems = {}
    for k, v in pairs(item) do
        requiredItems[k] = v * amount
    end
    for k, v in pairs(requiredItems) do
        if not Player.Functions.RemoveItem(k, v) then
            removed = false
            break
        end
    end
    if removed then
        if Player.Functions.AddItem(cItem, amount) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[cItem], "add", amount)
            TriggerEvent('qb-log:server:CreateLog', 'jcraft', 'Jobs Craft', "white", Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname.." Craft "..amount.."x of "..QBCore.Shared.Items[cItem].label)
        else
            Player.Functions.SetInventory(MyOldInventory)
        end
    else
        Player.Functions.SetInventory(MyOldInventory)
        TriggerClientEvent('QBCore:Notify', src, "Looks like you dropped some items", "error")
    end
end)

RegisterNetEvent('qb-jobs:server:repairItem', function(cTable, cItem)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not cTable or not cItem then return end
    local itemsTable = Config.Jobs.Repair[cTable]
    if not itemsTable then return end
    if itemsTable.jobname and itemsTable.jobname ~= Player.PlayerData.job.name then return end
    local item = itemsTable.items[cItem]
    if not item then return end
    local MyOldInventory = Player.PlayerData.items
    local removed = true
    local requiredItems = {}
    local inSlots = 0
    for i=1,5,1 do
        local itemPlayerSlot = Player.PlayerData.items[i]
        if itemPlayerSlot and itemPlayerSlot.name == cItem and itemPlayerSlot.amount == 1 then
            inSlots = i
            break
        end
    end
    if inSlots == 0 then TriggerClientEvent('QBCore:Notify', src, "Item is not in your hotbar", "error") return end
    for k, v in pairs(item) do
        requiredItems[k] = v
    end
    for k, v in pairs(requiredItems) do
        if not Player.Functions.RemoveItem(k, v) then
            removed = false
            break
        end
    end
    if removed then
        QBCore.Player.RepairItem(src, cItem, inSlots)
        TriggerEvent('qb-log:server:CreateLog', 'jrepair', 'Jobs Repair Item', "white", Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname.." Repair "..QBCore.Shared.Items[cItem].label)
    else
        Player.Functions.SetInventory(MyOldInventory)
        TriggerClientEvent('QBCore:Notify', src, "Looks like you dropped some items", "error")
    end
end)

RegisterNetEvent('qb-jobs:server:changebanner', function(bannername,url,h,w)
    TriggerClientEvent('qb-jobs:client:setbanner',-1,bannername,url,h,w)
end)