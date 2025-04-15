if GetResourceState('es_extended') ~= 'started' then return end

Licence = {

  Licences = { -- These are the standard licences, if you've got more on your server, then simply add them here, for them to show in the MDT
    { value = "drive_truck", label = "Commercial Drivers License", enabled = true, grant = true, revoke = true },
    { value = "drive",       label = "Drivers License",            enabled = true, grant = true, revoke = true },
    { value = "drive_bike",  label = "Motorcycle License",         enabled = true, grant = true, revoke = true },
    { value = "weapon",      label = "Weapon Licence",             enabled = true, grant = true, revoke = true },
    { value = "dmv",         label = "Driving Permit",             enabled = true, grant = true, revoke = false }
  },

  ---Get all licences for a player
  ---@param stateid string The stateid of the player
  getLicences = function(stateid)
    local query = [[
      SELECT
        CONCAT('{', GROUP_CONCAT(
          JSON_QUOTE(l.type), ': ',
          CASE WHEN ul.type IS NOT NULL THEN 'true' ELSE 'false' END
          SEPARATOR ', '
        ), '}') AS licences
      FROM
        `drx_mdt_player_link` player_link
      JOIN
        %s p ON player_link.`identifier` = p.%s
      CROSS JOIN
        licenses l
      LEFT JOIN
        user_licenses ul ON p.identifier = ul.owner AND l.type = ul.type
      WHERE
        player_link.`stateid` = ?
    ]]

    query = query:format(Framework.tables.players, Framework.columns.players.identifier)

    return MySQL.single.await(query, { stateid })
  end,

  ---@param identifier string The player framework identifier
  ---@param type string The licence type
  ---@param licence string The licence to manage
  ---@param executor number The player id who executed the action
  manageLicence = function(identifier, type, licence, executor)
    if type == 'revoke' then
      MySQL.update.await('DELETE FROM user_licenses WHERE type = ? AND owner = ?', { licence, identifier })
    else
      MySQL.insert.await('INSERT INTO user_licenses (type, owner) VALUES (?, ?)', { licence, identifier })
    end
  end,

}
