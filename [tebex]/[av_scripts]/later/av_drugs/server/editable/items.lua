Config = Config or {}
Inventory, Core, Framework = nil, nil, nil
CreateThread(function()
    if not Inventory then Inventory = exports['av_laptop']:getInventory() end
    if not Framework then Framework = exports['av_laptop']:getFramework() end
    if not Core then Core = exports['av_laptop']:getCore() end
    if Config.Tables and next(Config.Tables) then
        for k, v in pairs(Config.Tables) do
            if Inventory == "origen_inventory" and Framework == "qb" then
                Core.Functions.CreateUseableItem(k, function(source,item)
                    useTable(source,item)
                end)
            else
                exports['av_laptop']:registerItem(k,useTable)
            end
        end
    end
    if Config.Packaging and next(Config.Packaging) then
        for k, v in pairs(Config.Packaging) do
            if Inventory == "origen_inventory" and Framework == "qb" then
                Core.Functions.CreateUseableItem(k, function(source,item)
                    useBatch(source,item)
                end)
            else
                exports['av_laptop']:registerItem(k,useBatch)
            end
        end
    end
    if Config.LabKeys and next(Config.LabKeys) then
        for k, v in pairs(Config.LabKeys) do
            if Inventory == "origen_inventory" and Framework == "qb" then
                Core.Functions.CreateUseableItem(k, function(source,item)
                    useLabKey(source,item)
                end)
            else
                exports['av_laptop']:registerItem(k,useLabKey)
            end
        end
    end
    if Config.DrugItems and next(Config.DrugItems) then
        for k, v in pairs(Config.DrugItems) do
            if Inventory == "origen_inventory" and Framework == "qb" then
                Core.Functions.CreateUseableItem(k, function(source,item)
                    onDrugUse(source,item)
                end)
            else
                exports['av_laptop']:registerItem(k,onDrugUse)
            end
        end
    end
end)

function useTable(source,item,info)
    dbug('useTable')
--    dbug('useTable', json.encode(item), json.encode(info))
    if not source or not item then return end
    local metadata, slot = exports['av_laptop']:getMetadata(item,info)
    local itemName = item and item['name'] or info and info['name']
    dbug("Table: "..itemName..", identifier?: ", metadata['identifier'])
    if metadata and not metadata['identifier'] then
        dbug("Generate identifier for table...")
        metadata['identifier'] = lib.string.random('...............')
        exports['av_laptop']:setItemMetadata(source, itemName, slot, metadata)
        dbug("setItemMetadata complete...", source, itemName, slot, json.encode(metadata))
    end
    if metadata and metadata['identifier'] then
        local identifier = metadata['identifier']
        if allTables and not allTables[identifier] then
            dbug("placing table on client side...")
            local model = Config.Tables[itemName] and Config.Tables[itemName]['model'] or false
            if model then
                TriggerClientEvent('av_drugs:placeTable', source, itemName, identifier, model, slot)
            else
                print("^1[ERROR]^7 Table "..itemName.." doesn't have a prop name in Config.Tables, this is NOT a script problem!")
                print("^1[ERROR]^7 Table "..itemName.." doesn't have a prop name in Config.Tables, this is NOT a script problem!")
                print("^1[ERROR]^7 Table "..itemName.." doesn't have a prop name in Config.Tables, this is NOT a script problem!")
            end
        else
            dbug("table already placed...")
            TriggerClientEvent('av_laptop:notification',source,Lang['table_title'], Lang['already_placed'], 'error')
        end
    end
end

function useLabKey(source,item,info)
    dbug('useLabKey')
    if not source or not item then return end
    local metadata, slot = exports['av_laptop']:getMetadata(item,info)
    local itemName = item and item['name'] or info and info['name']
    dbug("Item: "..itemName..", lab type?: ", metadata['labType'], "key owner? ", metadata['owner'])
    if not metadata['labType'] or not metadata['owner'] then
        print("This key doesn't have any lab info, please don't use a /giveitem command to give this item.")
        return
    end
    local owner = exports['av_laptop']:getIdentifier(source)
    if not metadata['owner'] or metadata['owner'] ~= owner then
        TriggerClientEvent('av_laptop:notification',source, Lang['app_title'], Lang['not_key_owner'], 'error')
        return
    end
    local labInfo = Config.LabTypes and Config.LabTypes[metadata['labType']] or false
    if labInfo then
        TriggerClientEvent('av_drugs:setLabEntrance',source,itemName,metadata['labType'],slot)
    else
        print("^3[WARNING]^7 Lab type ^1"..metadata['labType'].."^7 doesn't match an index key in Config.LabTypes")
        print("^3[WARNING]^7 Lab type ^1"..metadata['labType'].."^7 doesn't match an index key in Config.LabTypes")
        print("^3[WARNING]^7 Lab type ^1"..metadata['labType'].."^7 doesn't match an index key in Config.LabTypes")
    end
end