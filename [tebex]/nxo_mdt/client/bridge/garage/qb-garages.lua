if GetResourceState('qb-garages') ~= 'started' then return end

QBCore = exports['qb-core']:GetCoreObject()

Garage = {

  ---@param model string The vehicle model
  getVehicleName = function(model)
    local v = QBCore.Shared.Vehicles[model]
    return v and v.name or model
  end
}