local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("huntingbait", function(source, item)
  TriggerClientEvent('qb-hunting:usedBait', source, item.slot)
end)

QBCore.Functions.CreateUseableItem("huntingknife", function(source, item)
  TriggerClientEvent('qb-hunting:skinAnimal', source)
end)

RegisterServerEvent('qb-hunting:skinReward', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local randomAmount = math.random(1,30)
  if randomAmount > 1 and randomAmount < 12 then
    Player.Functions.AddItem("huntingcarcass1", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["huntingcarcass1"], "add")
  elseif randomAmount > 12 and randomAmount < 20 then
    Player.Functions.AddItem("huntingcarcass2", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["huntingcarcass2"], "add")
  elseif randomAmount > 20 and randomAmount < 27 then
    Player.Functions.AddItem("huntingcarcass3", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["huntingcarcass3"], "add")
  else 
    Player.Functions.AddItem("huntingcarcass4", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["huntingcarcass4"], "add")
  end
end)

-- local carcasses = {
--   huntingcarcass1 = 1425,
--   huntingcarcass2 = 1600,
--   huntingcarcass3 = 1900,
--   huntingcarcass4 = 2400
-- }

RegisterServerEvent('qb-hunting:server:sell', function(carcasses)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  for k, v in pairs(carcasses) do
      local item = Player.Functions.GetItemByName(k)
      if item ~= nil then
          if Player.Functions.RemoveItem(k, item.amount) then
              Player.Functions.AddMoney('cash', v * item.amount)
              --Player.Functions.AddMoney('paycheck', v * item.amount, 'sell hunt ' .. QBCore.Shared.Items[k].label)
              TriggerClientEvent('QBCore:Notify', src, 'You sold ' .. item.amount .. ' skins for $' .. v * item.amount, 'success')
              TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[k], "remove", item.amount)
          end
      end
  end
end)
