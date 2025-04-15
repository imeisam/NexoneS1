if GetResourceState('qb-inventory') ~= 'started' then return end

Inventory = {
  name = 'drx_evidence_',

  ---@param id number The inventory identifier
  GetStashItems = function(id)
    return exports['qb-inventory']:GetStashItems(id)
  end,

  ---@param id number The inventory identifier
  ---@param label string The inventory label
  RegisterStash = function(id, label)
    MySQL.insert.await('INSERT IGNORE INTO stashitems (`stash`, items) VALUES (?, ?)', {
      id, json.encode({})
    })
  end,

  ---@param src number The player server id
  ---@param id number The inventory identifier
  OpenInventory = function(src, id)
    TriggerClientEvent("inventory:client:OpenFromMDT", src, Inventory.name .. id)
  end,
}