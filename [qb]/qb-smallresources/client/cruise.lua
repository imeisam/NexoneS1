local IsLock = false

AddEventHandler('onKeyDown', function(key)
  if key == 'y' then
    if IsPedInAnyVehicle(PlayerPedId(), false) then
      local veh = GetVehiclePedIsIn(PlayerPedId(), false)
      local fuel = exports['qb-fuel']:GetFuel(veh)
      if fuel > 10 and GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
        if GetVehicleClass(veh) ~= 8 and GetVehicleClass(veh) ~= 13 and GetVehicleClass(veh) ~= 14 and GetVehicleClass(veh) ~= 15 and GetVehicleClass(veh) ~= 16 then
          TriggerCruiseControl()
        end
      end
    end
  end
end)

function TriggerCruiseControl()
  local speed = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false))
  if not IsLock then
    IsLock = true
    SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), speed)
    QBCore.Functions.Notify('Max Speed Limited on '..math.ceil(speed * 2.2369), 'error')
  elseif IsLock then
    IsLock = false
    SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 0.0)
    QBCore.Functions.Notify('Max Speed is now unlimited', 'success')
  end
end