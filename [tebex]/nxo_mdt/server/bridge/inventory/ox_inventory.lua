if GetResourceState('ox_inventory') ~= 'started' then return end

local ox_inventory = exports.ox_inventory

Inventory = {
  name = 'drx_evidence_',

  ---@param id number The inventory identifier
  GetStashItems = function(id)
    return ox_inventory:GetInventoryItems(id)
  end,

  ---@param id number The inventory identifier
  ---@param label string The inventory label
  RegisterStash = function(id, label)
    ox_inventory:RegisterStash(id, label, 50, 50000, nil)
  end,

  ---@param src number The player server id
  ---@param id number The inventory identifier
  OpenInventory = function(src, id)
    ox_inventory:forceOpenInventory(src, 'stash', Inventory.name .. id)
  end,
}