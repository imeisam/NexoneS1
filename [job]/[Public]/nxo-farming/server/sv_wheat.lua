local Wheat_Fields = {
    [1] = false,
    [2] = false,
    [3] = false,
    [4] = false,
    [5] = false,
    [6] = false,
    [7] = false,
    [8] = false
}

local DeleteTable = {}

local fields = {}

local function Entitydeleter(src)
    if DeleteTable[src] then
        for _,v in pairs(DeleteTable[src]) do 
            if DoesEntityExist(v) then 
                DeleteEntity(v)
            end
        end
        DeleteTable[src] = {}
    end
end

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    
    for i=1, 256 do
        if DeleteTable[i] then
            for _,v in pairs(DeleteTable[i]) do 
                if DoesEntityExist(v) then 
                    DeleteEntity(v)
                end
            end
            DeleteTable[i] = {}
        end
    end
  end)

local function IsWheatFieldFree(id)
    if not Wheat_Fields[id] then
        return true
    end
    return false
end

QBCore.Functions.CreateCallback('0r-farming-get-wheat-fields', function(source, cb)
    cb(Wheat_Fields)
end)

QBCore.Functions.CreateCallback('0r-farming-start-wheatfield', function(source, cb, FieldID)
    local src = source
    if IsWheatFieldFree(FieldID) then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('0r-farming-wheat-started', function(FieldID)
    Wheat_Fields[FieldID] = true
    fields[source] = FieldID
    DeleteTable[source] = {}
end)

RegisterServerEvent('0r-farming-insert', function(value)
    local src = source
    for i = 1, 10, 1 do 
        Wait(0)
        if NetworkGetEntityFromNetworkId(value) ~= 0 then
            table.insert(DeleteTable[src], NetworkGetEntityFromNetworkId(value))
            break 
        end
        Wait(100)
    end
end)

AddEventHandler('playerDropped', function()
    local src = source
    Entitydeleter(src)
    if fields[src] then
        Wheat_Fields[fields[src]] = false
    end
end)

RegisterServerEvent('0r-farming-wheat-finished', function(FieldID)
    local user = QBCore.Functions.GetPlayer(source)
    Wheat_Fields[FieldID] = false
end)

RegisterNetEvent('0r-farming-receive-wheat', function()
    local src = source
    local user = QBCore.Functions.GetPlayer(src)
    if MainShared.Inventory == 'qb' then
        user.Functions.AddItem('wheat',WheatShared.Wheat)
        user.Functions.RemoveItem('wheatseed', 1)
        -- exports['qb-inventory']:AddItem(src, 'wheat', WheatShared.Wheat)
        -- exports['qb-inventory']:RemoveItem(src, 'wheatseed', 1)
    elseif MainShared.Inventory == 'ox' then
        local ox_inventory = exports.ox_inventory
        ox_inventory:AddItem(src, 'wheat', WheatShared.Wheat)
        ox_inventory:RemoveItem(src, 'wheatseed', 1)
    end
end)