if GetResourceState('esx_property') ~= 'started' then return end

local owned = {}

---@class Property
---@field coords vector3
---@field name string
---@field label string

Property = {

  ---@param identifier string The player framework identifier
  ---@return table<Property>
  getPropertiesByIdentifier = function(identifier)
    local properties = {}
    for _, value in pairs(owned) do
      if value.Owner == identifier then
        properties[#properties + 1] = {
          coords = { x = value.Entrance.x, y = value.Entrance.y },
          name = value.Name,
          label = value.Name
        }
      end
    end

    return properties
  end,

  Locations = {}
}

CreateThread(function()
  while true do
    local success, response = pcall(LoadResourceFile, 'esx_property', 'properties.json')
    if not success then return Logger.error('esx_property is unable to be loaded\nResponse: %s', tostring(response)) end
    response = json.decode(response)

    owned = response

    Wait(5 * 60 * 1000)
  end
end)