Custom.GetOwnerIdentifierByPlate = function(plate)
    plate = plate:gsub("%s+", "")
    local column = Config.Columns[Config.Framework] 
    local data = MySQL.query.await('SELECT '..column.owner..' AS identifier FROM '..column.vehicles..' WHERE REPLACE(plate, " ", "") = @plate', {['@plate'] = plate})
    if data and data[1] then
        return data[1].identifier
    end
    return false
end

Custom.UpdateGarageVehicle = function(plate, keep, garage, mods, cb)
    local query
    local state = keep and 1 or 0
    local updateMods = mods and true or false

    local column = Config.Columns[Config.Framework]

    if updateMods then 
        query = 'UPDATE '..column.vehicles..' SET '..column.mods..' = @mods, '..column.state..' = @state, '..column.garage..' = @garage WHERE REPLACE(plate, " ", "") = @plate'
    else
        query = 'UPDATE '..column.vehicles..' SET '..column.state..' = @state, '..column.garage..' = @garage WHERE REPLACE(plate, " ", "") = @plate'
    end

    local params = {
        ['@state'] = state,
        ['@garage'] = garage,
        ['@plate'] = plate:gsub("%s+", ""),
    }

    if updateMods then 
        params['@mods'] = mods
    end

    MySQL.update(query, params, function(affectedRows)
        if affectedRows > 0 then
            cb(true)
        else
            cb(false)
        end
    end)
end

Custom.GetVehiclesFromGarage = function(garage_id)
    local column = Config.Columns[Config.Framework]
    local resp = MySQL.query.await('SELECT '..column.mods..' AS mods, '..column.garage..' AS garage, '..column.owner..' AS identifier FROM '..column.vehicles..' WHERE '..column.garage..' LIKE @garage AND '..column.state..' = 1', {['@garage'] = garage_id .. "_%"})

    return resp
end