if GetResourceState('es_extended') ~= 'started' then return end

ESX = exports.es_extended:getSharedObject()
Framework = {

  tables = {
    players = 'users',
    licences = 'licenses',
    user_licences = 'user_licenses',
  },

  columns = {
    players = {
      identifier = 'identifier',
      fullname = "CONCAT(p.`firstname`, ' ', p.`lastname`)",
      licences = "CONCAT('{', GROUP_CONCAT(JSON_QUOTE(licences.`type`), ': ',CASE WHEN user_licences.`type` IS NOT NULL THEN 'true' ELSE 'false' ENDSEPARATOR ', '), '}')"
    }
  },

  --[[
  IdentityStats Configuration:

  `IdentityStats` is an array that defines how certain identity information is retrieved from the database.
  Each entry in the array represents a different identity category and contains:

  - `table`: The database table where the identity data is found.
  - `column`: Specifies which column to fetch. Use '*' for all columns.
  - `identifier`: The column used to match a specific row (e.g., fetching data for a particular user).
  - `value`: Specifies the keys or columns you want to retrieve. This is especially useful when fetching from JSON columns.
  - `label`: Defines how the data is presented. Placeholders (like {nationality}) get replaced by the corresponding values from the database.
  - `enabled`: Determines if this category is active or not.

  Example:
    For the configuration:
    table = "players",
    column = "charinfo",
    identifier = "citizenid",
    value = { "nationality", "birthdate" },
    label = { "Nationality: {nationality}", "Birthdate: {birthdate}" },

    This would fetch the `nationality` and `birthdate` from the `charinfo` column in the `players` table where `citizenid` matches the given identifier.
    It then labels them as "Nationality: <value>" and "Birthdate: <value>".
  ]]
  IdentityStats = {
    {
      table = "users",
      column = "*",
      identifier = "identifier",
      value = { "dateofbirth", "sex", "height", "phone_number" },
      label = { "Date of birth: {dateofbirth}", "Gender: {sex}", "Height: {height}", "Phonenumber: {phone_number}" },
      enabled = true
    },
    {
      table = "drx_mdt_player_link",
      column = "points",
      identifier = "identifier",
      value = nil,
      label = "Points",
      enabled = true
    },
  },

  VehicleStats = {
    {
      table = "owned_vehicles",
      column = "type",
      identifier = "plate",
      value = nil,
      label = "Type: {type}",
      enabled = true
    },
    {
      table = "owned_vehicles",
      column = "vehicle",
      identifier = "plate",
      value = { "modTurbo", "modXenon", "modExhaust" },
      label = { "Turbo: {modTurbo}", "Xenon: {modXenon}", "Aftermarket exhaust: {modExhaust}" },
      enabled = true
    }
  },

  ---@param src number The player server id
  getPlayerBySource = function(src)
    local player = {}
    local xPlayer = ESX.GetPlayerFromId(src)

    if not xPlayer then return nil end

    player.source = xPlayer.source
    player.identifier = xPlayer.identifier
    player.fullname = xPlayer.name

    return player
  end,

  ---@param identifier string The player framework identifier
  getPlayerByIdentifier = function(identifier)
    local player = {}
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)

    if not xPlayer then return nil end

    player.source = xPlayer.source
    player.identifier = xPlayer.identifier
    player.fullname = xPlayer.name

    return player
  end,

  ---@param src number The player server id
  getPlayerIdentifier = function(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return nil end

    return xPlayer.identifier
  end,

  ---@param src number The player server id (officer)
  ---@param identifier string The player framework identifier (criminal)
  ---@param fine number The fine amount
  finePlayer = function(source, identifier, fine)
    local xTarget = ESX.GetPlayerFromIdentifier(identifier)
    if not xTarget then return end

    fine = ESX.Math.Round(fine)
    MySQL.insert('INSERT INTO billing (`identifier`, `sender`, `target_type`, `target`, `label`, `amount`) VALUES (?, ?, ?, ?, ?, ?)',
      { xTarget.identifier, 'MDT', 'society', 'society_police', 'Issued fine', fine }, function(insertId)
        xTarget.showNotification('You have just ~r~received a fine')
      end)
  end,

  ---@param src number The player server id (officer)
  ---@param identifier string The player framework identifier (criminal)
  ---@param jailtime number The jailtime in minutes
  jailPlayer = function(source, identifier, jailtime)
    if GetResourceState('esx_jail') ~= 'started' then return end

    local xTarget = ESX.GetPlayerFromIdentifier(identifier)
    if not xTarget then return end

    exports.esx_jail:sendToJail(xTarget.source, jailtime)
  end,

  ---@param identifier string The player framework identifier
  ---@param job string The job name
  ---@param grade number The job grade level
  setJob = function(identifier, job, grade)
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    if not xPlayer then
      return MySQL.update.await('UPDATE `users` u SET u.`job` = ?, u.`job_grade` = ? WHERE identifier = ?', { job, grade, identifier })
    end
    xPlayer.setJob(job, grade)

    return 1
  end,

  ---Returns a list of all job names
  ---@return table<number, string>
  getJobs = function()
    local jobs = ESX.GetJobs()
    local jobNames = {}

    for job, _ in pairs(jobs) do
      jobNames[job] = true
    end

    Logger.debug('Jobs: %s', json.encode(jobNames))

    return jobNames
  end,

  ---@param stateid string The players state identifier
  getCitizen = function(stateid)
    local query = [[
      SELECT
        player_link.stateid as identifier,
        p.%s as framework_identifier,
        %s as fullname,
        CONCAT(j.label, ' (', j.name, ')') as job
      FROM
        `drx_mdt_player_link` player_link
      JOIN
        `users` p ON player_link.`identifier` = p.identifier
      JOIN
        jobs j ON p.job = j.name
      WHERE
        player_link.stateid = ?
    ]]

    query = query:format(Framework.columns.players.identifier, Framework.columns.players.fullname)

    local result = MySQL.single.await(query, { stateid })

    if not result then return {} end

    return {
      identifier = result.identifier,
      framework_identifier = result.framework_identifier,
      fullname = result.fullname,
      job = { result.job }
    }
  end,

  ---@param term string The search term
  ---@param excludeStaff boolean Whether to exclude staff or not
  searchPlayers = function(term, excludeStaff)
    local query = [[
      SELECT
        link.`stateid` as identifier,
        p.%s as framework_identifier,
        %s as fullname,
        CONCAT(j.label, ' (', j.name, ')') as job,
        link.`image`,
        link.`tags`
      FROM
        `drx_mdt_player_link` link
      JOIN
        %s p ON p.%s = link.`identifier`
      JOIN
        jobs j ON p.job = j.name
      WHERE
        (%s LIKE ?
        OR link.`stateid` = ?)
        %s
      GROUP BY
        link.`stateid`, p.identifier
      LIMIT 20
    ]]

    local excludedWhere = excludeStaff and "AND NOT EXISTS (SELECT 1 FROM `drx_mdt_officers` o WHERE o.identifier = link.`stateid`)" or ""

    query = query:format(
      Framework.columns.players.identifier,
      Framework.columns.players.fullname,
      Framework.tables.players,
      Framework.columns.players.identifier,
      Framework.columns.players.fullname,
      excludedWhere,
      "")

    return MySQL.query.await(query, { '%' .. term .. '%', term })
  end,
}

RegisterNetEvent('esx:playerLoaded', function(player, xPlayer, isNew)
  LoadOfficer(player, xPlayer.identifier)
end)

RegisterNetEvent('esx:playerDropped', function(playerId, reason)
  UnloadOfficer(playerId)

  local clockStatus = exports.nxo_mdt:GetOfficerClockedIn(playerId)
  if clockStatus then
    exports.nxo_mdt:ToggleClock(playerId)
  end
end)

AddEventHandler('onResourceStart', function(resource)
  if resource ~= GetCurrentResourceName() then return end

  local xPlayers = ESX.GetExtendedPlayers()
  for _, xPlayer in pairs(xPlayers) do
    LoadOfficer(xPlayer.source, xPlayer.identifier)
  end
end)