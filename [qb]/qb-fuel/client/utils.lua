function GetFuel(vehicle)
	return DecorGetFloat(vehicle, Config.FuelDecor)
end

function SetFuel(vehicle, fuel)
	if type(fuel) == 'number' and fuel >= 0 and fuel <= 100 then
		SetVehicleFuelLevel(vehicle, fuel + 0.0)
		DecorSetFloat(vehicle, Config.FuelDecor, GetVehicleFuelLevel(vehicle))
	end
end

function LoadAnimDict(dict)
	if not HasAnimDictLoaded(dict) then
		RequestAnimDict(dict)

		while not HasAnimDictLoaded(dict) do
			Wait(1)
		end
	end
end

function Round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end


function isCloseVeh()
    local ped = PlayerPedId()
    coordA = GetEntityCoords(ped, 1)
    coordB = GetOffsetFromEntityInWorldCoords(ped, 0.0, 200.0, 0.0)
    vehicle = getVehicleInDirection(coordA, coordB)
    if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
        return true
    end
    return false
end

function getVehicleInDirection(coordFrom, coordTo)
	local offset = 0
	local rayHandle
	local vehicle
	for i = 0, 100 do
		rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)	
		a, b, c, d, vehicle = GetRaycastResult(rayHandle)
		offset = offset - 1
		if vehicle ~= 0 then break end
	end
	local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
	if distance > 25 then vehicle = nil end
    return vehicle ~= nil and vehicle or 0
end
 function GlobalTax(value)
	local tax = (value / 100 * Config.GlobalTax)
	return tax
end
function GetClosestVehicle(coords)
	local ped = PlayerPedId()
	local vehicles = GetGamePool('CVehicle')
	local closestDistance = -1
	local closestVehicle = -1
	if coords then
		coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
	else
		coords = GetEntityCoords(ped)
	end
	for i = 1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance = #(vehicleCoords - coords)
		if closestDistance == -1 or closestDistance > distance then
			closestVehicle = vehicles[i]
			closestDistance = distance
		end
	end
	return closestVehicle, closestDistance
end