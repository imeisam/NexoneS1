local Pumpkin_Fields = {
    [1] = false,
    [2] = false,
    [3] = false,
    [4] = false,
    [5] = false,
    [6] = false
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

local function IsPumpkinFieldFree(id)
    if not Pumpkin_Fields[id] then
        return true
    end
    return false
end

QBCore.Functions.CreateCallback('0r-farming-get-pumpkin-fields', function(source, cb)
    cb(Pumpkin_Fields)
end)

QBCore.Functions.CreateCallback('0r-farming-start-pumpkinfield', function(source, cb, FieldID)
    local src = source
    if IsPumpkinFieldFree(FieldID) then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('0r-farming-pumpkin-started', function(FieldID)
    Pumpkin_Fields[FieldID] = true
    fields[source] = FieldID
    DeleteTable[source] = {}
end)

RegisterServerEvent('0r-farming-insert-pumpkin', function(value)
    local src = source
    for i = 1, 10, 1 do 
        Wait(0)
        if NetworkGetEntityFromNetworkId(value) ~= 0 then
            if DeleteTable[src] == nil then DeleteTable[src] = {} end
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
        Pumpkin_Fields[fields[src]] = false
    end
end)

RegisterServerEvent('0r-farming-pumpkinjob-finished', function(FieldID)
    local src = source
    Entitydeleter(src)
    Pumpkin_Fields[FieldID] = false
end)

RegisterNetEvent('0r-farming-receive-pumpkin', function()
    local src = source
    local user = QBCore.Functions.GetPlayer(src)
    if MainShared.Inventory == 'qb' then
        user.Functions.AddItem('pumpkin', PumpkinShared.CuttedPumpkin)
        user.Functions.RemoveItem('pumpkinseed', 1)
        -- exports['qb-inventory']:AddItem(src, 'pumpkin', PumpkinShared.CuttedPumpkin)
        -- exports['qb-inventory']:RemoveItem(src, 'pumpkinseed', 1)
    elseif MainShared.Inventory == 'ox' then
        local ox_inventory = exports.ox_inventory
        ox_inventory:AddItem(src, 'pumpkin', PumpkinShared.CuttedPumpkin)
        ox_inventory:RemoveItem(src, 'pumpkinseed', 1)
    end
end)