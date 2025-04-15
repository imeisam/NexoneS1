if GetResourceState('qb-apartments') ~= 'started' then return end

---@class Property
---@field coords vector3
---@field name string
---@field label string

Property = {

  ---@param identifier string The player framework identifier
  ---@return table<Property>
  getPropertiesByIdentifier = function(identifier)
    local properties = {}
    local apartments = MySQL.query.await("SELECT * FROM `appartments` WHERE `citizenid` = ?", { identifier })
    if apartments[1] and Property.Locations[apartments[1].id] then
      properties[#properties + 1] = {
        coords = Property.Locations[apartments[1].id].enterCoords,
        name = apartments[1].id,
        label = Property.Locations[apartments[1].id].label
      }
    end
    return properties
  end,
  Locations = {}
}

local apts = exports["qb-apartments"]:GetApartments()
for k,v in ipairs(apts) do
  Property.Locations[k] = v
end