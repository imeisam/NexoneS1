if GetResourceState('qbx_core') ~= 'started' then return end

Licence = {

  Licences = { -- These are the standard licences, if you've got more on your server, then simply add them here, for them to show in the MDT
    -- Don't know what licences you have? You can check at (qb-core>server>player.lua>line:121)
    { value = "driver",   label = "Driver Licence",   enabled = true, grant = false, revoke = true },
    { value = "weapon",   label = "Weapon Licence",   enabled = true, grant = true,  revoke = true },
    { value = "business", label = "Business Licence", enabled = true, grant = false, revoke = false }
  },

  ---Get all licences for a player
  ---@param stateid string The player state id
  getLicences = function(stateid)
    local query = [[
      SELECT
        JSON_UNQUOTE(JSON_EXTRACT(p.`metadata`, '$.licences')) as licences
      FROM
        `drx_mdt_player_link` player_link
      JOIN
        %s p ON p.%s = player_link.`identifier`
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
    local Player = Framework.getPlayerByIdentifier(identifier)
    local l = true
    if type == 'revoke' then
      l = false
    end

    if Player then
      Player.PlayerData.metadata.licences[licence] = l

      Player.Functions.SetMetaData('licences', Player.PlayerData.metadata.licences)
      Player.Functions.Save()
      return
    end

    MySQL.update.await(("UPDATE %s SET metadata = JSON_SET(metadata, '$.licences.%s', %s) WHERE %s = ?"):format(Framework.tables.players, licence, l,
      Framework.columns.players.identifier), { identifier })
  end,
}
