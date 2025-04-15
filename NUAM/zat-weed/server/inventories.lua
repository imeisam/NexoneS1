local QBCore = nil

Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports['qb-core']:GetCoreObject()
    end
end)

local function GetStashItems(stashId)
	local items = {}
    local result = nil 
    if Config.UseNew then 
        result = MySQL.scalar.await('SELECT items FROM inventories WHERE identifier = ?', { stashId })
    else
        result = MySQL.scalar.await('SELECT items FROM stashitems WHERE stash = ?', { stashId })
    end

	if not result then return items end

	local stashItems = json.decode(result)
	if not stashItems then return items end

	for _, item in pairs(stashItems) do
		local itemInfo = QBCore.Shared.Items[item.name:lower()]
		if itemInfo then
			items[item.slot] = {
				name = itemInfo['name'],
				amount = tonumber(item.amount),
				info = item.info or '',
				label = itemInfo['label'],
				description = itemInfo['description'] or '',
				weight = itemInfo['weight'],
				type = itemInfo['type'],
				unique = itemInfo['unique'],
				useable = itemInfo['useable'],
				image = itemInfo['image'],
				slot = item.slot,
			}
		end
	end
	return items
end


function AddItem(src, item, amount, info)
    if info ~= nil then
        if Config.Inventory == "qb" or  Config.Inventory == "origen" or  Config.Inventory == "ps" then
            if item=="zatweedbranch" then
                amount=1
            end
            local Player = QBCore.Functions.GetPlayer(src)
            Player.Functions.AddItem(item, amount, false, info)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add', amount)
        elseif Config.Inventory == "ox" then
            exports.ox_inventory:AddItem(src, item, amount, info)
        elseif Config.Inventory == "qs" then 
            exports['qs-inventory']:AddItem(src, item, amount, nil, info)
        end
    else
        if Config.Inventory == "qb" or  Config.Inventory == "origen" or  Config.Inventory == "ps" then
            if item=="zatweedbranch" then
                amount=1
            end
            local Player = QBCore.Functions.GetPlayer(src)
            Player.Functions.AddItem(item, amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add', amount)
        elseif Config.Inventory == "ox" then
            exports.ox_inventory:AddItem(src, item, amount)
        elseif Config.Inventory == "qs" then 
            exports['qs-inventory']:AddItem(src, item, amount)
        end
    end
end

function UpdateDryLevel(Models)
    for k, v in pairs(Models) do
        if v.model == Config.PlanterProps[2] or v.model == Config.PlanterProps[3] then
            if Config.Framework == "qb" then
                if Config.Inventory == "qb" or  Config.Inventory == "origen" or  Config.Inventory == "ps" then
                    local items = GetStashItems("RackDryer_"..v.id)
                    for i, j in pairs(items) do
                        if j.info.drylevel ~= nil then
                            local increaseBy = 0
                            for x, y in pairs(Models) do
                                if y.link == v.id then
                                    increaseBy = increaseBy + 3
                                end
                            end
                            j.info.drylevel = j.info.drylevel + Config.DryIncrease + increaseBy
                            if j.info.drylevel >= 100 then
                                j.info.drylevel = 100
                            end
                        end
                    end
                    if Config.Inventory == "qb" or  Config.Inventory == "ps" then
                        if Config.UseNew then
                            MySQL.insert('INSERT INTO inventories (identifier, items) VALUES (:identifier, :items) ON DUPLICATE KEY UPDATE items = :items', {
                                ['identifier'] = "RackDryer_"..v.id,
                                ['items'] = json.encode(items)
                            })
                        else
                            MySQL.insert('INSERT INTO stashitems (stash, items) VALUES (:stash, :items) ON DUPLICATE KEY UPDATE items = :items', {
                                ['stash'] = "RackDryer_"..v.id,
                                ['items'] = json.encode(items)
                            })
                        end
                    elseif Config.Inventory == "origen" then
                        TriggerEvent('origen_inventory:server:SaveStashItems', stash, items)
                    end
                elseif Config.Inventory == "ox" then
                    local items = exports.ox_inventory:GetInventoryItems("RackDryer_"..v.id, false)
                    if items then
                        for i, j in pairs(items) do
                            if j.metadata.drylevel ~= nil then
                                local increaseBy = 0
                                for x, y in pairs(Models) do
                                    if y.link == v.id then
                                        increaseBy = increaseBy + 3
                                    end
                                end
                                j.metadata.drylevel = j.metadata.drylevel + Config.DryIncrease + increaseBy
                                if j.metadata.drylevel >= 100 then
                                    j.metadata.drylevel = 100
                                end
                                exports.ox_inventory:SetMetadata("RackDryer_"..v.id, j.slot, j.metadata)
                            end
                        end
                    end
                elseif Config.Inventory == "qs" then
                    local items = exports['qs-inventory']:GetStashItems("Stash_RackDryer_"..v.id)
                    if items then
                        for i, j in pairs(items) do
                            if j.info.drylevel ~= nil then
                                local increaseBy = 0
                                for x, y in pairs(Models) do
                                    if y.link == v.id then
                                        increaseBy = increaseBy + 3
                                    end
                                end
                                j.info.drylevel = j.info.drylevel + Config.DryIncrease + increaseBy
                                if j.info.drylevel >= 100 then
                                    j.info.drylevel = 100
                                end
                                MySQL.Async.insert('INSERT INTO inventory_stash (stash, items) VALUES (:stash, :items) ON DUPLICATE KEY UPDATE items = :items'
                                    , {
                                    ['stash'] = 'Stash_RackDryer_'..v.id,
                                    ['items'] = json.encode(items)
                                })
                            end
                        end
                    end
                end
            elseif Config.Framework == "esx" then
                if Config.Inventory == "ox" then
                    local items = exports.ox_inventory:GetInventoryItems("RackDryer_"..v.id, false)
                    if items then
                        for i, j in pairs(items) do
                            print (j.metadata.drylevel)
                            if j.metadata.drylevel ~= nil then
                                local increaseBy = 0
                                for x, y in pairs(Models) do
                                    if y.link == v.id then
                                        increaseBy = increaseBy + 3
                                    end
                                end
                                j.metadata.drylevel = j.metadata.drylevel + Config.DryIncrease + increaseBy
                                if j.metadata.drylevel >= 100 then
                                    j.metadata.drylevel = 100
                                end
                                exports.ox_inventory:SetMetadata("RackDryer_"..v.id, j.slot, j.metadata)
                            end
                        end
                    end
                elseif Config.Inventory == "qs" then
                    local items = exports['qs-inventory']:GetStashItems("Stash_RackDryer_"..v.id)
                    if items then
                        for i, j in pairs(items) do
                            if j.info.drylevel ~= nil then
                                local increaseBy = 0
                                for x, y in pairs(Models) do
                                    if y.link == v.id then
                                        increaseBy = increaseBy + 3
                                    end
                                end
                                j.info.drylevel = j.info.drylevel + Config.DryIncrease + increaseBy
                                if j.info.drylevel >= 100 then
                                    j.info.drylevel = 100
                                end
                                MySQL.Async.insert('INSERT INTO inventory_stash (stash, items) VALUES (:stash, :items) ON DUPLICATE KEY UPDATE items = :items'
                                    , {
                                    ['stash'] = 'Stash_RackDryer_'..v.id,
                                    ['items'] = json.encode(items)
                                })
                            end
                        end
                    end
                end
            end
        end
    end
end

function GiveFertilizer(src, entity, Models, WeedPlants)
    if #(GetEntityCoords(GetPlayerPed(src)) - Models[entity].coords) > 10 then return end
    if Config.Framework == "qb" then
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        if Config.Inventory == "qb" or  Config.Inventory == "origen" or  Config.Inventory == "ps" then
            if Player.Functions.RemoveItem("zatweednutrition", 1, false) then
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["zatweednutrition"], 'remove', 1)
                for k, v in pairs(WeedPlants) do
                    if v.planter == Models[entity].id then
                        v.fertilizer[#v.fertilizer + 1] = os.time()
                        MySQL.update('UPDATE weedplants SET fertilizer = (:fertilizer) WHERE id = (:id)', {
                            ['fertilizer'] = json.encode(v.fertilizer),
                            ['id'] = v.id,
                        })
                    end
                end
            end
        elseif Config.Inventory == "ox" then
            exports.ox_inventory:RemoveItem(src, "zatweednutrition", 1)
            for k, v in pairs(WeedPlants) do
                if v.planter == Models[entity].id then
                    v.fertilizer[#v.fertilizer + 1] = os.time()
                    MySQL.update('UPDATE weedplants SET fertilizer = (:fertilizer) WHERE id = (:id)', {
                        ['fertilizer'] = json.encode(v.fertilizer),
                        ['id'] = v.id,
                    })
                end
            end
        elseif Config.Inventory == "qs" then
            exports['qs-inventory']:RemoveItem(src, "zatweednutrition", 1)
            for k, v in pairs(WeedPlants) do
                if v.planter == Models[entity].id then
                    v.fertilizer[#v.fertilizer + 1] = os.time()
                    MySQL.update('UPDATE weedplants SET fertilizer = (:fertilizer) WHERE id = (:id)', {
                        ['fertilizer'] = json.encode(v.fertilizer),
                        ['id'] = v.id,
                    })
                end
            end
        end
    elseif Config.Framework == "esx" then
        if Config.Inventory == "ox" then
            exports.ox_inventory:RemoveItem(src, "zatweednutrition", 1)
            for k, v in pairs(WeedPlants) do
                if v.planter == Models[entity].id then
                    v.fertilizer[#v.fertilizer + 1] = os.time()
                    MySQL.update('UPDATE weedplants SET fertilizer = (:fertilizer) WHERE id = (:id)', {
                        ['fertilizer'] = json.encode(v.fertilizer),
                        ['id'] = v.id,
                    })
                end
            end
        elseif Config.Inventory == "qs" then
            exports['qs-inventory']:RemoveItem(src, "zatweednutrition", 1)
            for k, v in pairs(WeedPlants) do
                if v.planter == Models[entity].id then
                    v.fertilizer[#v.fertilizer + 1] = os.time()
                    MySQL.update('UPDATE weedplants SET fertilizer = (:fertilizer) WHERE id = (:id)', {
                        ['fertilizer'] = json.encode(v.fertilizer),
                        ['id'] = v.id,
                    })
                end
            end
        end
    end
end

function GiveWater(src, entity, Models, WeedPlants)
    if #(GetEntityCoords(GetPlayerPed(src)) - Models[entity].coords) > 10 then return end
    if Config.Framework == "qb" then
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        if Config.Inventory == "qb" or  Config.Inventory == "origen" or  Config.Inventory == "ps" then
            if Player.Functions.RemoveItem("zatwaterbottlefull", 1, false) then
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["zatwaterbottlefull"], 'remove', 1)
                Player.Functions.AddItem("zatwaterbottleempty", 1, false)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["zatwaterbottleempty"], 'add', 1)
                for k, v in pairs(WeedPlants) do
                    if tonumber(v.watersetup) == tonumber(Models[entity].id) then
                        v.water[#v.water + 1] = os.time()
                        MySQL.update('UPDATE weedplants SET water = (:water) WHERE id = (:id)', {
                            ['water'] = json.encode(v.water),
                            ['id'] = v.id,
                        })
                        Wait(100)
                    end
                end
            end
        elseif Config.Inventory == "ox" then
            exports.ox_inventory:RemoveItem(src, "zatwaterbottlefull", 1)
            exports.ox_inventory:AddItem(src, "zatwaterbottleempty", 1)
            for k, v in pairs(WeedPlants) do
                if tonumber(v.watersetup) == tonumber(Models[entity].id) then
                    v.water[#v.water + 1] = os.time()
                    MySQL.update('UPDATE weedplants SET water = (:water) WHERE id = (:id)', {
                        ['water'] = json.encode(v.water),
                        ['id'] = v.id,
                    })
                    Wait(100)
                end
            end
        elseif Config.Inventory == "qs" then
            exports['qs-inventory']:RemoveItem(src, "zatwaterbottlefull", 1)
            exports['qs-inventory']:AddItem(src, "zatwaterbottleempty", 1)
            for k, v in pairs(WeedPlants) do
                print (Models[entity].id)
                print (v.watersetup)
                if tonumber(v.watersetup) == tonumber(Models[entity].id) then
                    v.water[#v.water + 1] = os.time()
                    MySQL.update('UPDATE weedplants SET water = (:water) WHERE id = (:id)', {
                        ['water'] = json.encode(v.water),
                        ['id'] = v.id,
                    })
                    Wait(100)
                end
            end
        end
    elseif Config.Framework == "esx" then
        if Config.Inventory == "ox" then
            exports.ox_inventory:RemoveItem(src, "zatwaterbottlefull", 1)
            exports.ox_inventory:AddItem(src, "zatwaterbottleempty", 1)
            for k, v in pairs(WeedPlants) do
                if tonumber(v.watersetup) == tonumber(Models[entity].id) then
                    v.water[#v.water + 1] = os.time()
                    MySQL.update('UPDATE weedplants SET water = (:water) WHERE id = (:id)', {
                        ['water'] = json.encode(v.water),
                        ['id'] = v.id,
                    })
                    Wait(100)
                end
            end
        elseif Config.Inventory == "qs" then
            exports['qs-inventory']:RemoveItem(src, "zatwaterbottlefull", 1)
            exports['qs-inventory']:AddItem(src, "zatwaterbottleempty", 1)
            for k, v in pairs(WeedPlants) do
                if tonumber(v.watersetup) == tonumber(Models[entity].id) then
                    v.water[#v.water + 1] = os.time()
                    MySQL.update('UPDATE weedplants SET water = (:water) WHERE id = (:id)', {
                        ['water'] = json.encode(v.water),
                        ['id'] = v.id,
                    })
                    Wait(100)
                end
            end
        end
    end
end

function IsStashFull(stashId)
    local retval = false
    if Config.Inventory == "qb" or  Config.Inventory == "origen" or  Config.Inventory == "ps" then
        print (#GetStashItems(stashId))
        if #GetStashItems(stashId) > 0 then
            retval = true
        end
    elseif Config.Inventory == "ox" then
        if exports.ox_inventory:GetInventoryItems(stashId, false) then
            if #exports.ox_inventory:GetInventoryItems(stashId, false) > 0 then
                retval = true
            end
        end
    elseif Config.Inventory == "qs" then
        if exports['qs-inventory']:GetStashItems('Stash_'..stashId, false) then
            if #exports['qs-inventory']:GetStashItems('Stash_'..stashId, false) > 0 then
                retval = true
            end
        end
    end

    return retval
end

function CreateWeedBrick(src)
    if Config.Framework == "qb" then
        local Player = QBCore.Functions.GetPlayer(src)
        if Config.Inventory == "qb" or  Config.Inventory == "origen" or  Config.Inventory == "ps" then
            local item = Player.Functions.GetItemByName("zatweedbranch")
            if item ~= nil then
                -- if item.info.drylevel >= 100 then
                    TriggerClientEvent("zat-weed:client:brickIt", src, item.info)
                    Player.Functions.RemoveItem(item.name, 1, item.slot)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove")
                -- else
                    -- TriggerClientEvent('QBCore:Notify', src, _U("not_dry"), 'error')
                -- end
            else
                TriggerClientEvent('QBCore:Notify', src, _U("no_bran"), 'error')
            end
        elseif Config.Inventory == "ox" then
            local slot = exports.ox_inventory:GetSlotWithItem(src, 'zatweedbranch', false)
            if slot.count > 0 then
                if slot.metadata.drylevel >= 100 then
                    TriggerClientEvent("zat-weed:client:brickIt", src, slot.metadata)
                    exports.ox_inventory:RemoveItem(src, slot, 1)
                else
                    TriggerClientEvent("esx:showNotification", src, _U("not_dry"), 'error')
                end
            else
                TriggerClientEvent("esx:showNotification", src, _U("no_bran"), 'error')
            end
        elseif Config.Inventory == "qs" then
            local items = exports['qs-inventory']:GetInventory(src)
            local hasit = false
            for k, v in pairs(items) do
                if v.name == "zatweedbranch" then
                    if v.info.drylevel >= 100 then
                        TriggerClientEvent("zat-weed:client:brickIt", src, v.info)
                        exports['qs-inventory']:RemoveItem(src, v.name, 1, v.slot)
                    else
                        TriggerClientEvent('QBCore:Notify', src, _U("not_dry"), 'error')
                    end
                    hasit = true
                end
            end
            if not hasit then
                TriggerClientEvent('QBCore:Notify', src, _U("no_bran"), 'error')
            end
        end
    elseif Config.Framework == "esx" then
        if Config.Inventory == "ox" then
            local slot = exports.ox_inventory:GetSlotWithItem(src, 'zatweedbranch', false)
            if slot.count > 0 then
                if slot.metadata.drylevel >= 100 then
                    TriggerClientEvent("zat-weed:client:brickIt", src, slot.metadata)
                    exports.ox_inventory:RemoveItem(src, slot, 1)
                else
                    TriggerClientEvent("esx:showNotification", src, _U("not_dry"), 'error')
                end
            else
                TriggerClientEvent("esx:showNotification", src, _U("no_bran"), 'error')
            end
        elseif Config.Inventory == "qs" then
            local items = exports['qs-inventory']:GetInventory(src)
            local hasit = false
            for k, v in pairs(items) do
                if v.name == "zatweedbranch" then
                    if v.info.drylevel >= 100 then
                        TriggerClientEvent("zat-weed:client:brickIt", src, v.info)
                        exports['qs-inventory']:RemoveItem(src, v.name, 1, v.slot)
                    else
                        TriggerClientEvent('QBCore:Notify', src, _U("not_dry"), 'error')
                    end
                    hasit = true
                end
            end
            if not hasit then
                TriggerClientEvent('QBCore:Notify', src, _U("no_bran"), 'error')
            end
        end
    end
end

function GiveWaterBottleFull(src)
    if Config.Framework == "qb" then
        local Player = QBCore.Functions.GetPlayer(src)
        if Config.Inventory == "qb" or  Config.Inventory == "origen" or  Config.Inventory == "ps" then
            if Player.Functions.GetItemByName("zatwaterbottleempty") ~= nil then
                Player.Functions.AddItem("zatwaterbottlefull", 1, false)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["zatwaterbottlefull"], 'add', 1)
                Player.Functions.RemoveItem("zatwaterbottleempty", 1, false)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["zatwaterbottleempty"], 'remove', 1)
            end
        elseif Config.Inventory == "ox" then 
            exports.ox_inventory:AddItem(src, "zatwaterbottlefull", 1)
            exports.ox_inventory:RemoveItem(src, "zatwaterbottleempty", 1)
        elseif Config.Inventory == "qs" then 
            exports['qs-inventory']:AddItem(src, "zatwaterbottlefull", 1)
            exports['qs-inventory']:RemoveItem(src, "zatwaterbottleempty", 1)
        end
    elseif Config.Framework == "esx" then
        if Config.Inventory == "ox" then 
            exports.ox_inventory:AddItem(src, "zatwaterbottlefull", 1)
            exports.ox_inventory:RemoveItem(src, "zatwaterbottleempty", 1)
        elseif Config.Inventory == "qs" then 
            exports['qs-inventory']:AddItem(src, "zatwaterbottlefull", 1)
            exports['qs-inventory']:RemoveItem(src, "zatwaterbottleempty", 1)
        end
    end
end

RegisterNetEvent("zat-weed:server:CreateStash", function(id, label, slots, maxWeight, owner, groups, coords)
    exports.ox_inventory:RegisterStash(id, label, slots, maxWeight, owner, groups, coords)
end)

RegisterNetEvent("zat-weed:server:RemoveItemOx", function(data, metadata)
    local src = source
    exports.ox_inventory:RemoveItem(src, data.name, 1, metadata, data.slot)
end)

RegisterNetEvent('zat-weed:server:openinventory', function(stashId, weight, slots)
    local src = source
    local data = { label = stashId, maxweight = weight, slots = slots }
    exports['qb-inventory']:OpenInventory(src, stashId, data)
end)

RegisterNetEvent('zat-weed:server:RegisterStashOrigen', function(id, slots, weight)
    local src = source
    if exports.origen_inventory:GetStash(id) == nil then    
        exports.origen_inventory:RegisterStash(id, {
            label = id,
            slots = slots,
            weight = weight
        })
    else
        exports.origen_inventory:OpenInventory(src, 'stash', id)
    end
end)