if GetResourceState('esx_garage') ~= 'started' then return end

Garage = {

  table = "owned_vehicles",
  columns = {
    owner = "owner",
    plate = "plate",
    model = "JSON_UNQUOTE(JSON_EXTRACT(vehicle, '$.model'))",
    mods = "vehicle"
  },

  ---@param identifier string The players framework identifier
  getVehiclesByIdentifer = function(identifier)
    return MySQL.query.await(("SELECT %s as vehicle, %s as plate FROM %s v WHERE v.%s = ?"):format(Garage.columns.model, Garage.columns.plate, Garage.table, Garage.columns.owner),
      { identifier })
  end,

  ---@param term string The search term
  searchVehicleByTerm = function(term)
    local query = [[
      SELECT
        player_link.`stateid` as identifier,
        %s as plate,
        %s as mods,
        %s as vehicle,
        vehicle_link.`image`,
        vehicle_link.`notes`,
        vehicle_link.`tags`,
        vehicle_link.`gallery`
      FROM
        %s v
      JOIN
        `drx_mdt_vehicle_link` vehicle_link ON vehicle_link.`identifier` = v.%s
      JOIN
        `drx_mdt_player_link` player_link ON v.%s = player_link.`identifier`
      WHERE
        v.%s LIKE ?
      LIMIT 20
    ]]

    query = query:format(Garage.columns.plate, Garage.columns.mods, Garage.columns.model, Garage.table, Garage.columns.plate, Garage.columns.owner, Garage.columns.plate)

    return MySQL.query.await(query, { '%' .. term .. '%' })
  end,

  ---@param plate string The plate of the vehicle
  getVehicleByPlate = function(plate)
    local query = [[
      SELECT
        player_link.`stateid` as identifier,
        %s as name,
        %s as plate,
        %s as mods
      FROM
        %s v
      JOIN
        `drx_mdt_player_link` player_link ON v.%s = player_link.`identifier`
      WHERE
        v.%s = ?
    ]]

    query = query:format(Garage.columns.model, Garage.columns.plate, Garage.columns.mods, Garage.table, Garage.columns.owner, Garage.columns.plate)
    return MySQL.single.await(query, { plate })
  end,

  ---@param model string|number The vehicle model or vehicle hash
  getVehicleName = function(model)
    return model
  end
}
