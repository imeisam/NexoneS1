if GetResourceState('qbx_apartments') ~= 'started' then return end

---@class Property
---@field coords vector3
---@field name string
---@field label string

Property = {

  ---@param identifier string The player framework identifier
  ---@return table<Property>
  getPropertiesByIdentifier = function(identifier)
    local apartments = MySQL.query.await("SELECT * FROM `apartments` WHERE `citizenid` = ?", { identifier })
    local properties = {}

    for i, apartment in ipairs(apartments) do
      local location = Property.Locations[apartment.type]
      if location then
        properties[#properties + 1] = {
          coords = location,
          name = apartment.type,
          label = apartment.type
        }
      else
        Logger.error('No location found for apartment type: ' .. apartment.name)
      end
    end
    return properties
  end,

  Locations = {}
}

local file = LoadResourceFile('qbx_apartments', 'config.lua')
if file then
  load(file)()
  if next(Apartments.Locations) then
    for k, v in pairs(Apartments.Locations) do
      Property.Locations[k] = v.enter
    end
  end
end