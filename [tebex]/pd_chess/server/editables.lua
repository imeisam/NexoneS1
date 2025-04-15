function registerPlayer(identifier)
    

  local db_identifier = identifier:gsub(":", "")

  if not Config.useELORating then
      elos[identifier] = 0
      return
  end
  if Config.SQLDriver == "mysql" then
      local query = "SELECT * FROM pd_extra WHERE player='"..db_identifier.."' and tag='pd_chess_elo' LIMIT 1"
      local values =  {["tag"] = "pd_chess_elo"}
      MySQL.Async.fetchAll(query, values, function(results)
          if #results == 0 then
              local query_insert = "INSERT INTO pd_extra (player, tag, data) VALUES (@player, @tag, @data)"
              local data_insert = {
                  ["player"] = db_identifier,
                  ["tag"] = "pd_chess_elo",
                  ["data"] = Config.startingELO
              }
              MySQL.Async.insert(query_insert, data_insert, function(results2)
                  
              end)
              elos[identifier] = Config.startingELO
          else
              elos[identifier] = results[1].data

          end
      end)
  elseif Config.SQLDriver == "oxmysql" then
      local query = string.format("SELECT * from pd_extra HAVING player='%s' and tag='pd_chess_elo'", db_identifier)
      local results = exports[Config.SQLDriver]:query_async(query, {})
      if #results == 0 then
          elos[identifier] = Config.startingELO
          local query_insert = "INSERT INTO pd_extra (player, tag, data) VALUES ('".. db_identifier .."', 'pd_chess_elo', '".. Config.startingELO .."')"
          local data_insert = {
              ["player"] = db_identifier,
              ["tag"] = "pd_chess_elo",
              ["data"] = Config.startingELO
          }
          exports[Config.SQLDriver]:query_async(query_insert, data_insert)
      else
          elos[identifier] = results[1].data
      end
  end
end

function updateElo(identifier, elo)
  local db_identifier = identifier:gsub(":", "")
  if not Config.useELORating then
      elos[identifier] = 0
      return
  end
  if Config.SQLDriver == "mysql" then
      local query = 'UPDATE pd_extra SET data = @data WHERE player = @player AND tag = @tag'
      local values = {
          ["data"] = elo,
          ["player"] = db_identifier,
          ["tag"] = "pd_chess_elo"
      }
      MySQL.Async.fetchAll(query, values, function(results)
      end)
  elseif Config.SQLDriver == "oxmysql" then
      local query = "UPDATE pd_extra SET data='"..elo.."' WHERE player='".. db_identifier .."' AND tag='pd_chess_elo'"
      exports[Config.SQLDriver]:query_async(query, {})
  end
  elos[identifier] = elo
end 

if Config.useItemFramework == "ESX" then
  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

  ESX.RegisterUsableItem(Config.itemName, function(source)
      TriggerClientEvent("pd_chess:startChess", source)
  end)

elseif Config.useItemFramework == "QBCore" then
  QBCore = exports['qb-core']:GetCoreObject()

  QBCore.Functions.CreateUseableItem("pd_chess_board", function(source, item)
      local src = source
      TriggerClientEvent("pd_chess:startChess", src)
  end)
end