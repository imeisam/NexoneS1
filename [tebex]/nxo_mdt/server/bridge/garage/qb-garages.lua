if GetResourceState('qb-garages') ~= 'started' then return end

Garage = {

  table = "player_vehicles",
  columns = {
    owner = "citizenid",
    plate = "plate",
    model = "vehicle",
    mods = "mods"
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
        %s as vehicle,
        %s as plate,
        %s as mods,
        vehicle_link.`image`,
        vehicle_link.`notes`,
        vehicle_link.`tags`,
        vehicle_link.`gallery`
      FROM
        %s v
      JOIN
        `drx_mdt_vehicle_link` vehicle_link ON vehicle_link.`identifier` = v.%s
      JOIN
        `drx_mdt_player_link` player_link ON player_link.`identifier` = v.`%s`
      WHERE
        v.%s LIKE ?
      LIMIT 20
    ]]

    query = query:format(Garage.columns.model, Garage.columns.plate, Garage.columns.mods, Garage.table, Garage.columns.plate, Garage.columns.owner, Garage.columns.plate)

    return MySQL.query.await(query, { '%' .. term .. '%' })
  end,

  ---@param plate string The plate of the vehicle
  getVehicleByPlate = function(plate)
    local query = [[
      SELECT
        player_link.stateid as identifier,
        %s as name,
        %s as plate,
        %s as mods
      FROM
        %s v
      JOIN
        `drx_mdt_player_link` player_link ON player_link.`identifier` = v.`%s`
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
