
local QBCore = nil
local Queue     =  {}
local itemNames = {}
local Washmachines = {}

Citizen.CreateThread(function() 
    Queue = json.decode(LoadResourceFile(GetCurrentResourceName(), "db.json"))
    if Config.Framework == "qb" then
        QBCore = exports['qb-core']:GetCoreObject()
    end
end)

local setupModels = function()
    local result = MySQL.Sync.fetchAll('SELECT * FROM washmachines')
    for k, v in pairs(result) do
        local coords = json.decode(v.coords)
        local rot    = json.decode(v.rot)
        local model  = v.model
        local prop   = CreateObjectNoOffset(GetHashKey(model), coords.x, coords.y, coords.z, true, true, false)
        SetEntityRoutingBucket(prop, v.bucket)
        SetEntityRotation(prop, vector3(rot.x, rot.y, rot.z))
        FreezeEntityPosition(prop, true)
        Washmachines[prop] = {
            id     = v.id,
            coords = vector3(coords.x, coords.y, coords.z),
            rot    = vector3(rot.x, rot.y, rot.z),
            model  = model,
            bucket = v.bucket
        }
    end
end

AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    setupModels()
end)

RegisterNetEvent('zat-washmoney:server:PlaceTable', function(model, coords, rot, id) 
    local src = source
    local bucket = GetPlayerRoutingBucket(src)
    local prop = CreateObjectNoOffset(GetHashKey(model), vector3(coords.x,coords.y,coords.z-0.05) , true, true, false)
    SetEntityRoutingBucket(prop, bucket)
    SetEntityRotation(prop, rot)
    FreezeEntityPosition(prop, true)
    local time = os.time()
    MySQL.insert('INSERT into washmachines (`id`, `coords`, `rot`, `model`, `bucket`) VALUES (:id, :coords, :rot, :model, :bucket)', {
        ['id'] = id,
        ['coords'] = json.encode(coords),
        ['rot'] = json.encode(rot),
        ['model'] = model,
        ['bucket'] = bucket
    }, function(data)
        Washmachines[prop] = {
            id = id,
            coords = coords,
            rot = rot,
            model = model,
            bucket = bucket
        }
    end)

    if Config.Framework == "qb" then
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if Config.Inventory == "qb" or  Config.Inventory == "origen" or  Config.Inventory == "ps" then
            Player.Functions.RemoveItem("washmachine", 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['washmachine'], "remove")
        elseif Config.Inventory == "ox" then
            exports.ox_inventory:RemoveItem(src, "washmachine", 1)
        elseif Config.Inventory == "qs" then
            exports['qs-inventory']:RemoveItem(src, "washmachine", 1)
        end
    elseif Config.Framework == "esx" then
        local src = source
        if Config.Inventory == "ox" then
            exports.ox_inventory:RemoveItem(src, "washmachine", 1)
        elseif Config.Inventory == "qs" then
            exports['qs-inventory']:RemoveItem(src, "washmachine", 1)
        end
    end 
end)

local function HasAttachment(component, attachments)
    local retval = false
    local key = nil
    for k, v in pairs(attachments) do
        if v.component == component then
            key = k
            retval = true
        end
    end
    return retval, key
end

local function AddItems(stash, Items, worth)
    if Config.Framework == "qb" then
        if Config.Inventory == "qb" or  Config.Inventory == "origen" or  Config.Inventory == "ps" then
            local items = GetStashItems(stash)
            local firstfreeslot = 0
            local added = false
            local MarkedBillsSlot = nil
            local ActualAmount = 0
            local ActualSlot = 0
            for k, v in pairs(Items) do
                local itemInfo = QBCore.Shared.Items[k:lower()]
                if (#items>0) then
                    for i, j in pairs(items) do
                        if j.name == Config.ItemsToWash then
                            MarkedBillsSlot = i
                            j.amount = 0
                        elseif  j.name == Config.RewardItem then
                            ActualAmount = j.amount
                            ActualSlot = i
                        end
                        
                    end
                end
                if MarkedBillsSlot ~= nil then
                    if Config.GetWorth then
                        items[MarkedBillsSlot] = {
                            name = itemInfo["name"],
                            amount = tonumber(v) * tonumber(worth),
                            info = {},
                            label = itemInfo["label"],
                            description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
                            weight = itemInfo["weight"],
                            type = itemInfo["type"],
                            unique = itemInfo["unique"],
                            useable = itemInfo["useable"],
                            image = itemInfo["image"],
                            slot = MarkedBillsSlot,
                        }
                    else
                        items[MarkedBillsSlot] = {
                            name = itemInfo["name"],
                            amount = tonumber(v),
                            info = {
                                worth = worth
                            },
                            label = itemInfo["label"],
                            description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
                            weight = itemInfo["weight"],
                            type = itemInfo["type"],
                            unique = itemInfo["unique"],
                            useable = itemInfo["useable"],
                            image = itemInfo["image"],
                            slot = MarkedBillsSlot,
                        }
                    end
                elseif ActualAmount > 0 then 
                    if Config.GetWorth then
                        items[ActualSlot] = {
                            name = itemInfo["name"],
                            amount = ActualAmount + (tonumber(v)* tonumber(worth)),
                            info = {},
                            label = itemInfo["label"],
                            description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
                            weight = itemInfo["weight"],
                            type = itemInfo["type"],
                            unique = itemInfo["unique"],
                            useable = itemInfo["useable"],
                            image = itemInfo["image"],
                            slot = ActualSlot,
                        }
                    else
                        items[ActualSlot] = {
                            name = itemInfo["name"],
                            amount = ActualAmount + tonumber(v),
                            info = {
                                worth = worth
                            },
                            label = itemInfo["label"],
                            description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
                            weight = itemInfo["weight"],
                            type = itemInfo["type"],
                            unique = itemInfo["unique"],
                            useable = itemInfo["useable"],
                            image = itemInfo["image"],
                            slot = ActualSlot,
                        }
                    end
                else
                    if Config.GetWorth then
                        items[#items + 1] = {
                            name = itemInfo["name"],
                            amount = tonumber(v)*tonumber(worth),
                            info = {},
                            label = itemInfo["label"],
                            description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
                            weight = itemInfo["weight"],
                            type = itemInfo["type"],
                            unique = itemInfo["unique"],
                            useable = itemInfo["useable"],
                            image = itemInfo["image"],
                            slot = #items + 1,
                        }
                    else
                        items[#items + 1] = {
                            name = itemInfo["name"],
                            amount = tonumber(v),
                            info = {
                                worth = worth
                            },
                            label = itemInfo["label"],
                            description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
                            weight = itemInfo["weight"],
                            type = itemInfo["type"],
                            unique = itemInfo["unique"],
                            useable = itemInfo["useable"],
                            image = itemInfo["image"],
                            slot = #items + 1,
                        }
                    end
                end
            end
            Citizen.Wait(500)
            if Config.Inventory == "qb" or  Config.Inventory == "ps" then
                if Config.QBInventory == "old" then
                    MySQL.Async.insert('INSERT INTO stashitems (stash, items) VALUES (:stash, :items) ON DUPLICATE KEY UPDATE items = :items'
                        , {
                        ['stash'] = stash,
                        ['items'] = json.encode(items)
                    })
                else
                    local oldItems = GetStashItems(stash)
                    for k, v in pairs(oldItems) do
                        exports['qb-inventory']:RemoveItem(stash, v.name,  v.amount, v.slot)
                    end
                    MySQL.Async.insert('INSERT INTO inventories (identifier, items) VALUES (:identifier, :items) ON DUPLICATE KEY UPDATE items = :items'
                        , {
                        ['identifier'] = stash,
                        ['items'] = json.encode(items)
                    })
                    for k, v in pairs(items) do
                        exports['qb-inventory']:AddItem(stash, v.name,  v.amount, false, v.info)
                    end
                end
            elseif Config.Inventory == "origen" then
                TriggerEvent('origen_inventory:server:SaveStashItems', stash, items)
            end

        elseif Config.Inventory == "ox" then
            for k, v in pairs(Items) do
                exports.ox_inventory:RemoveItem(stash, Config.ItemsToWash, v, nil, 1)
            end
            if Config.GetWorth then
                for k, v in pairs(Items) do
                    exports.ox_inventory:AddItem(stash, k, v*worth, {}, 1)
                end
            else
                for k, v in pairs(Items) do
                    exports.ox_inventory:AddItem(stash, k, v, worth, 1)
                end
            end
        elseif Config.Inventory == "qs" then
            for k, v in pairs(Items) do
                exports['qs-inventory']:RemoveItemIntoStash(stash, Config.ItemsToWash, v, 1)
            end
            if Config.GetWorth then
                for k, v in pairs(Items) do
                    local info = {
                        worth = worth,
                    }
                    exports['qs-inventory']:AddItemIntoStash(stash, k, v*worth, 1, {})
                end
            else
                for k, v in pairs(Items) do
                    local info = {
                        worth = worth,
                    }
                    exports['qs-inventory']:AddItemIntoStash(stash, k, v, 1, info)
                end
            end
        end
    elseif Config.Framework == "esx" then
        if Config.Inventory == "ox" then
            for k, v in pairs(Items) do
                exports.ox_inventory:RemoveItem(stash, Config.ItemsToWash, v, nil, 1)
            end
            if Config.GetWorth then
                for k, v in pairs(Items) do
                    exports.ox_inventory:AddItem(stash, k, v*worth, {}, 1)
                end
            else
                for k, v in pairs(Items) do
                    exports.ox_inventory:AddItem(stash, k, v, worth, 1)
                end
            end
        elseif Config.Inventory == "qs" then
            for k, v in pairs(Items) do
                exports['qs-inventory']:RemoveItemIntoStash(stash, Config.ItemsToWash, v, 1)
            end
            if Config.GetWorth then
                for k, v in pairs(Items) do
                    exports['qs-inventory']:AddItemIntoStash(stash, k, v*worth, 1, {})
                end
            else
                for k, v in pairs(Items) do
                    local info = {
                        worth = worth,
                    }
                    exports['qs-inventory']:AddItemIntoStash(stash, k, v, 1, info)
                end
            end
        end
    end
end

Citizen.CreateThread(function()   
    if Config.Framework == "qb" then
        RegisterServerCallback("zat-washmoney:server:GetCurrentWashmachineData", function(source, cb, netId)
            local entity = NetworkGetEntityFromNetworkId(netId)
            cb(Washmachines[entity])
        end)

        RegisterServerCallback('zat-washmoney:server:CanOpenThisInventory', function(source, cb, netId)
            local entity = NetworkGetEntityFromNetworkId(netId)
            local id = Washmachines[entity].id
            local canOpen = true
            if Queue[id] ~= nil then
                if (#Queue[id] > 0) then
                    canOpen = false
                end
            end
            cb(canOpen)
        end)

        
        RegisterServerCallback('zat-washmoney:server:GetStashItems', function(source, cb, stashid)
            if Config.Inventory == "ox" then
                cb(exports.ox_inventory:GetInventoryItems(stashid, false))
            elseif Config.Inventory == "qs" then
                cb(exports['qs-inventory']:GetStashItems(stashid))
            elseif Config.Inventory == "qb" then
                cb(GetStashItems(stashid))
            end
        end)

        RegisterServerCallback('zat-washmoney:server:GetwashmoneyQueue', function(source, cb, tableid)
            cb(Queue[tableid])
        end)
        
        RegisterServerCallback('zat-washmoney:server:CheckTime', function(source, cb, netId) 
            local entity = NetworkGetEntityFromNetworkId(netId)
            local id = Washmachines[entity].id
            if Queue[id] ~= nil then
                for k, v in pairs(Queue[id]) do
                    if v.itemData.count ~= nil then
                        cb((v.itemData.count / Config.WashedPerSecond), id)
                    end
                end
                cb(0, id)
            else
                cb(0, id)
            end
        end)
        RegisterServerCallback('zat-washmoney:server:CheckTimeFromId', function(source, cb, id) 
            if Queue[id] ~= nil then
                for k, v in pairs(Queue[id]) do
                    if v.itemData.count ~= nil then
                        cb(v.itemData.count / Config.WashedPerSecond)
                    end
                end
                cb(0)
            else
                cb(0)
            end
        end)

        
        RegisterServerCallback('zat-washmoney:server:CheckTaxes', function(source, cb, count) 
            local src = source
            local Player = QBCore.Functions.GetPlayer(src)
            local cashBalance = Player.Functions.GetCash()
            local bankBalance = Player.PlayerData.money["bank"]
            if cashBalance >= count*Config.TaxperItemToWash then
                Player.Functions.RemoveMoney("cash", count*Config.TaxperItemToWash, "WashMachine")
                cb(true)
            elseif bankBalance >= count*Config.TaxperItemToWash then
                Player.Functions.RemoveMoney("bank", count*Config.TaxperItemToWash, "WashMachine")
                cb(true)
            else
                cb(false)
            end
        end)
    elseif Config.Framework == "esx" then
        RegisterServerCallback("zat-washmoney:server:GetCurrentWashmachineData", function(source, cb, netId)
            local entity = NetworkGetEntityFromNetworkId(netId)
            cb(Washmachines[entity])
        end)

        RegisterServerCallback('zat-washmoney:server:CanOpenThisInventory', function(source, cb, netId)
            local entity = NetworkGetEntityFromNetworkId(netId)
            local id = Washmachines[entity].id
            local canOpen = true
            if Queue[id] ~= nil then
                if (#Queue[id] > 0) then
                    canOpen = false
                end
            end
            cb(canOpen)
        end)
        
        RegisterServerCallback('zat-washmoney:server:GetStashItems', function(source, cb, stashid)
            if Config.Inventory == "ox" then
                cb(exports.ox_inventory:GetInventoryItems(stashid, false))
            elseif Config.Inventory == "qs" then
                cb(exports['qs-inventory']:GetStashItems(stashid))
            elseif Config.Inventory == "qb" then
                cb(GetStashItems(stashid))
            end
        end)

        RegisterServerCallback('zat-washmoney:server:GetwashmoneyQueue', function(source, cb, tableid)
            cb(Queue[tableid])
        end)
        
        RegisterServerCallback("washmachine", function(source)
            local src = source
            local Player = QBCore.Functions.GetPlayer(src)
            local model = "bkr_prop_prtmachine_dryer_op"
            if not Player or not Player.Functions.GetItemByName('washmachine') then return end
            if Player.Functions.GetItemByName('washmachine') then
                local id = ""..Player.PlayerData.citizenid..""..math.random(111111,999999)
                TriggerClientEvent("zat-washmoney:client:PlaceTable", src, id, model)
            else
                TriggerClientEvent('QBCore:Notify', "Missing Item...", "error")
            end
        end)

        RegisterServerCallback('zat-washmoney:server:CheckTime', function(source, cb, netId) 
            local entity = NetworkGetEntityFromNetworkId(netId)
            local id = Washmachines[entity].id
            if Queue[id] ~= nil then
                for k, v in pairs(Queue[id]) do
                    if v.itemData.count ~= nil then
                        cb((v.itemData.count / Config.WashedPerSecond), id)
                    end
                end
                cb(0, id)
            else
                cb(0, id)
            end
        end)
        RegisterServerCallback('zat-washmoney:server:CheckTimeFromId', function(source, cb, id) 
            if Queue[id] ~= nil then
                for k, v in pairs(Queue[id]) do
                    if v.itemData.count ~= nil then
                        cb(v.itemData.count / Config.WashedPerSecond)
                    end
                end
                cb(0)
            else
                cb(0)
            end
        end)
        RegisterServerCallback('zat-washmoney:server:CheckTaxes', function(source, cb, count) 
            local src = source
            local Player = ESX.GetPlayerFromId(src)
            local cashBalance = Player.getAccount('money').money
            local bankBalance = Player.getAccount('bank').money
            if cashBalance >= count*Config.TaxperItemToWash then
                Player.removeAccountMoney('money', count*Config.TaxperItemToWash, "WashMachine")
                cb(true)
            elseif bankBalance >= count*Config.TaxperItemToWash then
                Player.removeAccountMoney('bank', count*Config.TaxperItemToWash, "WashMachine")
                cb(true)
            else
                cb(false)
            end
        end)
    end
end)

RegisterNetEvent("zat-washmoney:server:StartWashing", function(itemData, tableid, model)
    local src = source
    if(Queue[tableid] == nil)then
        Queue[tableid] = {}
    end
    table.insert(Queue[tableid],{itemData = itemData })
    TriggerClientEvent("zat-washmoney:client:UpdateTimeFirstUsage", src, tableid)
    
    for k, v in pairs(Washmachines) do
        if v.id == tableid then
            if DoesEntityExist(k) then
                DeleteEntity(k)
            end
            local prop = CreateObjectNoOffset(GetHashKey(model), vector3(v.coords.x, v.coords.y, v.coords.z) , true, true, false)
            SetEntityRoutingBucket(prop, v.bucket)
            SetEntityRotation(prop, v.rot)
            FreezeEntityPosition(prop, true)
            local temp = v
            Washmachines[k] = nil
            MySQL.insert('UPDATE washmachines SET model = ? WHERE id = ?', { model, temp.id}, function(data)
                Washmachines[prop] = {
                    id = tableid,
                    coords = temp.coords,
                    rot = temp.rot,
                    model = model,
                    bucket = temp.bucket
                }
            end)
            
        end
    end        
end)

RegisterNetEvent("zat-washmoney:server:SaveStashItems", function(stashId, items)
    MySQL.insert('INSERT INTO stashitems (stash, items) VALUES (:stash, :items) ON DUPLICATE KEY UPDATE items = :items', {
        ['stash'] = stashId,
        ['items'] = json.encode(items)
    })
end)

function UpdateWahMachinePropAfterWash(id, model)
    for k, v in pairs(Washmachines) do
        if v.id == id then
            if DoesEntityExist(k) then
                DeleteEntity(k)
            end
            local prop = CreateObjectNoOffset(GetHashKey(model), vector3(v.coords.x, v.coords.y, v.coords.z) , true, true, false)
            SetEntityRoutingBucket(prop, v.bucket)
            SetEntityRotation(prop, v.rot)
            FreezeEntityPosition(prop, true)
            local temp = v
            Washmachines[k] = nil
            MySQL.insert('UPDATE washmachines SET model = ? WHERE id = ?', { model, temp.id}, function(data)
                Washmachines[prop] = {
                    id = temp.id,
                    coords = temp.coords,
                    rot = temp.rot,
                    model = model,
                    bucket = temp.bucket
                }
            end)
        end
    end  
end

CreateThread(function()
    while true do
        Wait(1000)
    if Queue then
        for k, v in pairs(Queue) do
            if v[1] ~= nil then
                v[1].itemData.count = v[1].itemData.count - Config.WashedPerSecond 
                if v[1].itemData.count <= 0 then
                    local items = {}
                    items [Config.RewardItem] = v[1].itemData.total
                    AddItems("WashMoney_"..k,items, v[1].itemData.worth)
                    UpdateWahMachinePropAfterWash(k, Config.MachineProp)
                    table.remove(Queue[k],1)
                end
            end
        end
    end
       
    end
end)

CreateThread(function()
    while true do
        Wait(3000)
        SaveResourceFile(GetCurrentResourceName(), "./db.json", json.encode(Queue), -1)
    end
end)


RegisterNetEvent("zat-washmoney:server:CreateStash", function(id, label, slots, maxWeight, owner, groups, coords)
    exports.ox_inventory:RegisterStash(id, label, slots, maxWeight, owner, groups, coords)
end)

RegisterNetEvent("zat-washmoney:server:RemoveStashItems", function(stash, item, count)
    exports.ox_inventory:RemoveItem(stash, item, count)
end)

RegisterNetEvent('zat-washmoney:server:Destroy', function(netId, what)
    local src = source
    local entity = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(entity) then
        DeleteEntity(entity)
        MySQL.query('DELETE FROM washmachines WHERE id = ?', {Washmachines[entity].id})
        GiveItem(src, 'washmachine', 1, nil)
    end
end)

RegisterNetEvent('zat-washmoney:server:UpdateAfterMove', function(coords, rot, netId)
    local entity = NetworkGetEntityFromNetworkId(netId)
    Washmachines[entity].coords = coords
    Washmachines[entity].rot = rot
    MySQL.update('UPDATE washmachines SET coords = ?, rot = ? WHERE id = ?', {json.encode(Washmachines[entity].coords), json.encode(Washmachines[entity].rot), Washmachines[entity].id})
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    for k in pairs(Washmachines) do
        if DoesEntityExist(k) then
            DeleteEntity(k)
        end
    end
end)
