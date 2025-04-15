if GetResourceState('qb-core') ~= 'started' then return end

QBCore = exports["qb-core"]:GetCoreObject()
Framework = {

  tables = {
    players = 'players'
  },

  columns = {
    players = {
      identifier = 'citizenid',
      fullname = "CONCAT(JSON_UNQUOTE(JSON_EXTRACT(p.`charinfo`, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(p.`charinfo`, '$.lastname')))",
      job = "JSON_ARRAY(CONCAT(JSON_VALUE(p.`job`, '$.label'),' (',JSON_VALUE(p.`job`, '$.name'),')'))"
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
      table = "players",
      column = "charinfo",
      identifier = "citizenid",
      value = { "nationality", "birthdate", "phone", "gender" },
      label = { "Nationality: {nationality}", "Birthdate: {birthdate}", "Phone: {phone}", "Gender: {gender}" },
      enabled = true
    },
    -- {
    --   table = "players",
    --   column = "metadata",
    --   identifier = "citizenid",
    --   value = { "fingerprint", "walletid", "bloodtype" },
    --   label = { "Fingerprint: {fingerprint}", "Wallet ID: {walletid}", "Bloodtype: {bloodtype}" },
    --   enabled = true
    -- },
    {
      table = "drx_mdt_player_link",
      column = "points",
      identifier = "identifier",
      value = nil,
      label = "Points",
      enabled = true
    }
    
    -- Example of pulling all columns from a table
    -- {
    --   table = "player_vehicles",
    --   column = "*",
    --   identifier="citizenid",
    --   value={"vehicle", "hash", "plate"},
    --   label = {"Vehicle: {vehicle}", "Hash: {hash}", "Plate: {plate}"},
    --   enabled = true
    -- }
  },

  VehicleStats = {
    {
      table = "player_vehicles",
      column = "*",
      identifier = "plate",
      value = {"depotby", "depotprice"},
      label = {"Depot By: {depotby}", "Depot price: {depotprice}"},
      enabled = true
    },
  },

  ---@param src number The player server id
  getPlayerBySource = function(src)
    local player = {}
    local qb = QBCore.Functions.GetPlayer(src)

    if not qb then
      return nil
    end

    player.source = qb.PlayerData.source
    player.identifier = qb.PlayerData.citizenid
    player.fullname = qb.PlayerData.charinfo.firstname .. ' ' .. qb.PlayerData.charinfo.lastname

    return player
  end,

  ---@param identifier string The player framework identifier
  getPlayerByIdentifier = function(identifier)
    local player = {}
    local qb = QBCore.Functions.GetPlayerByCitizenId(identifier)

    if not qb then
      return nil
    end

    player.PlayerData = qb.PlayerData
    player.Functions = qb.Functions
    player.source = qb.PlayerData.source
    player.identifier = qb.PlayerData.citizenid
    player.fullname = qb.PlayerData.charinfo.firstname .. ' ' .. qb.PlayerData.charinfo.lastname

    return player
  end,

  ---@param src number The player server id
  getPlayerIdentifier = function(src)
    local qb = QBCore.Functions.GetPlayer(src)
    if not qb then return nil end
    return qb.PlayerData.citizenid
  end,

  ---@param src number The player server id (officer)
  ---@param identifier string The player framework identifier (criminal)
  ---@param fine number The fine amount
  finePlayer = function(source, identifier, fine)
    local biller = QBCore.Functions.GetPlayer(source)
    if not biller then return end
    local xTarget = Framework.getPlayerByIdentifier(identifier)
    if xTarget then
      local stMoney = math.ceil(xTarget.PlayerData.money.bank - fine)
      xTarget.Functions.SetMoney("bank", stMoney, "Fine")
      exports["snipe-banking"]:AddMoneyToAccount(biller.PlayerData.job.name,fine,"Fine "..xTarget.PlayerData.charinfo.firstname.." "..xTarget.PlayerData.charinfo.lastname..' by '..biller.PlayerData.charinfo.firstname.." "..biller.PlayerData.charinfo.lastname)
      if biller.PlayerData.job.name == "police" then
        TriggerEvent('qb-log:server:CreateLog', 'pdfine', 'Fine', 'red',"Officer: ".. biller.PlayerData.charinfo.firstname..' '..biller.PlayerData.charinfo.lastname .. ' (' .. biller.PlayerData.metadata.callsign .. ') \n fine '..fine..'$ \n for '..xTarget.PlayerData.charinfo.firstname..' '..xTarget.PlayerData.charinfo.lastname .. ' (' .. xTarget.PlayerData.citizenid .. ')')
      else
      TriggerEvent('qb-log:server:CreateLog', 'fine', 'Fine', 'red',"Officer: ".. biller.PlayerData.charinfo.firstname..' '..biller.PlayerData.charinfo.lastname .. ' (' .. biller.PlayerData.citizenid .. ') \n fine '..fine..'$ \n for '..xTarget.PlayerData.charinfo.firstname..' '..xTarget.PlayerData.charinfo.lastname .. ' (' .. xTarget.PlayerData.citizenid .. ')')
      end

    else
      exports["snipe-banking"]:AddMoneyToAccount(biller.PlayerData.job.name,fine,"Fine "..identifier..' by '..biller.PlayerData.charinfo.firstname.." "..biller.PlayerData.charinfo.lastname)

      -- exports['qb-management']:AddMoney(biller.PlayerData.job.name, fine)
      if biller.PlayerData.job.name == "police" then
        TriggerEvent('qb-log:server:CreateLog', 'pdfine', 'Police Fine', 'red',"Officer:".. biller.PlayerData.charinfo.firstname..' '..biller.PlayerData.charinfo.lastname .. ' (' .. biller.PlayerData.metadata.callsign .. ') \n fine '..fine..'$ for '..identifier)
      end
        TriggerEvent('qb-log:server:CreateLog', 'fine', 'Fine', 'red',"Officer: ".. biller.PlayerData.charinfo.firstname..' '..biller.PlayerData.charinfo.lastname .. ' (' .. biller.PlayerData.citizenid .. ') \n fine '..fine..'$ for '..identifier)
  
      MySQL.update.await(
        ("UPDATE %s SET money = JSON_SET(`money`, '$.bank', JSON_UNQUOTE(JSON_EXTRACT(`money`, '$.bank')) - ?) WHERE %s = ?"):format(Framework.tables.players,
          fine, Framework.columns.players.identifier), { fine, identifier })

    end
   
  end,

  ---@param src number The player server id (officer)
  ---@param identifier string The player framework identifier (criminal)
  ---@param jailtime number The jailtime in minutes
  jailPlayer = function(source, identifier, jailtime)
    local Player = QBCore.Functions.GetPlayer(source)
    local xTarget = Framework.getPlayerByIdentifier(identifier)
    if xTarget then
      if jailtime > 0 then
        exports['qb-jail']:jailPlayer(xTarget.PlayerData.source, true, jailtime)
        TriggerEvent("newspaper:jail",xTarget.PlayerData.charinfo.firstname,xTarget.PlayerData.charinfo.lastname, jailtime)
        TriggerClientEvent("police:client:SendToJail", xTarget.PlayerData.source, jailtime)
        if Player.PlayerData.job.name == "police" then
          TriggerEvent('qb-log:server:CreateLog', 'pdjail', 'Police Jail', 'red',"Officer:".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.metadata.callsign .. ') \n send: '..xTarget.PlayerData.charinfo.firstname..' '..xTarget.PlayerData.charinfo.lastname .. ' (' .. xTarget.PlayerData.citizenid .. ') \n jail for '..jailtime..' month')
        end
        TriggerEvent('qb-log:server:CreateLog', 'jail', 'Jail', 'red', "officer:".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.citizenid .. ') \n send: '..xTarget.PlayerData.charinfo.firstname..' '..xTarget.PlayerData.charinfo.lastname .. ' (' .. xTarget.PlayerData.citizenid .. ') \n jail for '..jailtime..' month')
      end
      return
    end
  end,

  ---@param identifier string The player framework identifier
  ---@param job string The job name
  ---@param grade number The job grade level
  setJob = function(identifier, job, grade)
    -- local Player = QBCore.Functions.GetPlayerByCitizenId(identifier)
    -- if not Player then
    --   local shared = QBCore.Shared.Jobs[job]
    --   local j = {
    --     name = job,
    --     label = shared.label,
    --     onduty = true,
    --     grade = {
    --       name = shared.grades[tostring(grade)].name,
    --       level = grade
    --     },
    --   }
    --   return MySQL.update.await(('UPDATE %s p SET p.`job` = ? WHERE %s = ?'):format(Framework.tables.players, Framework.columns.players.identifier), {
    --     json.encode(j), identifier
    --   })
    -- end
    -- Player.Functions.SetJob(job, tostring(grade))
    return 1
  end,

  ---Returns a list of all job names
  ---@return table<number, string>
  getJobs = function()
    local jobs = QBCore.Shared.Jobs
    local jobNames = {}

    for job, _ in pairs(jobs) do
      jobNames[job] = true
    end

    -- Logger.debug('Jobs: %s', json.encode(jobNames))

    return jobNames
  end,

  ---@param stateid string The players state identifier
  getCitizen = function(stateid)
    local query = [[
      SELECT
        link.`stateid` as identifier,
        link.`image`,
        link.`gallery`,
        link.`tags`,
        link.`points`,
        link.`wanted`,
        link.`notes`,
        p.%s as framework_identifier,
        %s as fullname,
        %s as job
      FROM
        `drx_mdt_player_link` link
      INNER JOIN
        %s p ON p.%s = link.`identifier`
      WHERE
        link.`stateid` = ?
      GROUP BY link.`stateid`
    ]]

    query = query:format(Framework.columns.players.identifier, Framework.columns.players.fullname, Framework.columns.players.job,
      Framework.tables.players,
      Framework.columns.players.identifier)

    local result = MySQL.single.await(query, { stateid })
    return result
  end,

  ---@param term string The search term
  ---@param excludeStaff boolean Whether to exclude staff or not
  searchPlayers = function(term, excludeStaff)
    local query = [[
      SELECT
        link.`stateid` as identifier,
        p.%s as framework_identifier,
        link.`image`,
        link.`tags`,
        %s as fullname
      FROM
        `drx_mdt_player_link` link
      JOIN
        %s p ON p.%s = link.`identifier`
      WHERE
        (%s LIKE ?
        OR link.`stateid` = ?)
        %s
      LIMIT 20
    ]]

    local excludedWhere = excludeStaff and "AND NOT EXISTS (SELECT 1 FROM `drx_mdt_officers` o WHERE o.identifier = link.`stateid`)" or ""

    query = query:format(Framework.columns.players.identifier, Framework.columns.players.fullname, Framework.tables.players, Framework.columns.players.identifier,
      Framework.columns.players.fullname, excludedWhere)

    return MySQL.query.await(query, { '%' .. term .. '%', term })
  end,
}

RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function()
  local src = source
  local identifier = Framework.getPlayerIdentifier(src)
  if not identifier then return Logger.error('Failed to get player identifier for ', src) end

  LoadOfficer(src, identifier)
end)

AddEventHandler('QBCore:Server:OnPlayerUnload', function()
  local src = source

  UnloadOfficer(src)

  local clockStatus = exports.nxo_mdt:GetOfficerClockedIn(src)
  if clockStatus then
    exports.nxo_mdt:ToggleClock(src)
  end
end)

AddEventHandler('onResourceStart', function(resource)
  if resource ~= GetCurrentResourceName() then return end

  local Players = QBCore.Functions.GetQBPlayers()
  for key, value in pairs(Players) do
    LoadOfficer(value.PlayerData.source, value.PlayerData.citizenid)
  end
end)