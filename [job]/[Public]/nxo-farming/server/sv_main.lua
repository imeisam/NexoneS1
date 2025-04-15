QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback("0r-farming-buy", function(src, cb, data)
    local user = QBCore.Functions.GetPlayer(src)
    if user.Functions.RemoveMoney(data.type, data.money) then
        local it = data.itemTable
        for i=1, #it do
            if MainShared.Inventory == 'qb' then
                user.Functions.AddItem( it[i].itemCode, it[i].amount)
                -- exports['qb-inventory']:AddItem(src, it[i].itemCode, it[i].amount)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[it[i].itemCode], 'add', it[i].amount)
            elseif MainShared.Inventory == 'ox' then
                local ox_inventory = exports.ox_inventory
                ox_inventory:AddItem(src, it[i].itemCode, it[i].amount)
            end
        end
        cb(true)
    else
        cb(false)
    end
end)

local function SellFunction(data)
    local src = source
    local user = QBCore.Functions.GetPlayer(src)

    if MainShared.Inventory == 'qb' then
        local item =user.Functions.GetItemByName(data.item)
        if item ~= nil then
            
            -- if exports['qb-inventory']:RemoveItem(src, data.item, tonumber(item.amount)) then
            if user.Functions.RemoveItem(data.item, tonumber(item.amount), false) then
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[data.item], 'remove', item.amount)
                user.Functions.AddMoney("bank", tonumber(data.price)*tonumber(item.amount))
            end
        else
            TriggerClientEvent('0r-farming-notify', src, Lan.YouDontHaveItem, 'error')
        end
    elseif MainShared.Inventory == 'ox' then
        local items = ox_inventory:Search(source, 'count', data.item)
        if items > 0 then
            ox_inventory:RemoveItem(src, 'data.item', data.item, tonumber(item.amount))
            user.Functions.AddMoney("bank", tonumber(data.price)*tonumber(item.amount))
        else
            TriggerClientEvent('0r-farming-notify', src, Lan.YouDontHaveItem, 'error')
        end
    end
end RegisterServerEvent('0r-farming-sell', SellFunction)

local function GetItem(src, cb, itemname)
    local user = QBCore.Functions.GetPlayer(src)
    if user then
        if MainShared.Inventory == 'qb' then
            local item =user.Functions.GetItemByName(itemname) 
            if item ~= nil then
                cb(true)
            else
                cb(false)
            end
        elseif MainShared.Inventory == 'ox' then
            local ox_inventory = exports.ox_inventory
            local count = ox_inventory:Search('count', itemname)
            if count > 0 then
                cb(true)
            else
                cb(false)
            end
        end
    else
        cb(false)
    end
end QBCore.Functions.CreateCallback('0r-farming-check-item', GetItem)

local function GetItem2(src, cb, itemname)
    local user = QBCore.Functions.GetPlayer(src)
    if user then
        if MainShared.Inventory == 'qb' then
            -- local item = exports['qb-inventory']:GetItemByName(src, itemname)
            local item =user.Functions.GetItemByName(itemname)
            if item ~= nil then
                cb(true)
            else
                cb(false)
            end
        elseif MainShared.Inventory == 'ox' then
            local ox_inventory = exports.ox_inventory
            local count = ox_inventory:Search('count', itemname)
            if count > 0 then
                cb(true)
            else
                cb(false)
            end
        end
    else
        cb(false)
    end
end QBCore.Functions.CreateCallback('0r-farming-check-item2', GetItem2)