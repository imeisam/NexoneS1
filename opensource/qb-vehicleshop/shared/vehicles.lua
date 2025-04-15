Vehicles = {}
Vehicles2 = {}
Categories = {}
VehiclesData = {}

local QBCore = exports['qb-core']:GetCoreObject()

for k, v in pairs(QBCore.Shared.Vehicles) do
    local vehType = 'automobile'
    if v.category == 'cycles' or v.category == 'motorcycles' then
        vehType = 'bike'
    elseif v.category == 'boats' then
        vehType = 'boat'
    elseif v.category == 'helicopters' then
        vehType = 'heli'
    elseif v.category == 'planes' then
        vehType = 'plane'
    end
    
    table.insert(VehiclesData, {
        model = v.model,
        name = v.name,
        brand = v.brand,
        price = v.price,
        category = v.category,
        categoryLabel = v.category,
        hash = joaat(v.model),
        shop = v.shop,
        type = vehType
    })
    table.insert(Vehicles, {
        spawncode =v.model,
        name = v.name,
        brand = v.brand,
        model = v.model,
        price = v.price,
        category = v.category,
        categoryLabel = v.category,
        hash = joaat(v.model),
        shop = v.shop,
        type = vehType
    })
    Vehicles2[v.model] = {
        spawncode = v.model,
        name = v.name,
        brand = v.brand,
        model = v.model,
        price = v.price,
        category = v.category,
        categoryLabel = v.category,
        hash = joaat(v.model),
        shop = v.shop,
        type = vehType
    }
    if not Categories[v.category] then
        Categories[v.category] = {
            name = v.category
        }
    end
end