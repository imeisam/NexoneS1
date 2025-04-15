if GetResourceState('qb-core') ~= 'started' then return end
local QBCore = exports['qb-core']:GetCoreObject()

local corelic = {}
for k,v in pairs(QBCore.Config.Server.Licenses) do
    corelic[#corelic+1] = { value = k, label = k, enabled = true, grant = true, revoke = true }
end

Licence = {

  ---Get all licences for a player
  ---@param stateid string The player state id
  getLicences = function(stateid)
    local Player = QBCore.Functions.GetPlayerByCitizenId(tostring(stateid))
    if Player then
        local licenseTable = {["licenses"] = {}}
        for k, v in pairs(Player.PlayerData.metadata.licences) do
            licenseTable["licenses"][k] = v
          end
          licenseTable = {['licences'] = json.encode(licenseTable['licenses'])}
          return licenseTable
          
    else
        local result = MySQL.scalar.await('SELECT metadata FROM players WHERE citizenid = @identifier', {['@identifier'] = tostring(stateid)})
        if result ~= nil then
            local metadata = json.decode(result)
            local licenseTable = {["licenses"] = {}}
            if metadata["licences"] ~= nil and metadata["licences"] then
                local plicenses = metadata["licences"]
                for k,v in pairs(plicenses) do
                    if v == 'revoked' then
                        plicenses[k] = false
                    end
                end
                licenseTable = {['licences'] = json.encode(plicenses)}
                return licenseTable 
                 
            else
                return QBCore.Config.Server.Licenses
            end
        end
    end
  end,

  ---@param identifier string The player framework identifier
  ---@param type string The licence type
  ---@param licence string The licence to manage
  ---@param executor number The player id who executed the action
  manageLicence = function(identifier, type, licence, executor)

    local Player = QBCore.Functions.GetPlayerByCitizenId(tostring(identifier))
    local licenseStatus = true
    local colortype="green"
    local playername=""
    if type == "revoke" then licenseStatus=false colortype="red" end
    if Player ~= nil then
        local licences = Player.PlayerData.metadata["licences"]
        licences[licence] = licenseStatus
        Player.Functions.SetMetaData("licences", licences)
        playername= Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname
    else
        local licenseType = '$.licences.'..licence
        local result = MySQL.query.await('UPDATE `players` SET `metadata` = JSON_REPLACE(`metadata`, ?, ?) WHERE `citizenid` = ?', {licenseType, licenseStatus, identifier}) --seems to not work on older MYSQL versions, think about alternative
    end
    TriggerEvent('qb-log:server:CreateLog', "licence", type,colortype,'Identifier: '..playername..''..identifier..'\nlicences: '..licence..'\nExecutor: '..executor )
  end,

  Licences =corelic
}