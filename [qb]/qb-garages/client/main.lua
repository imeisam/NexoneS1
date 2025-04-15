local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local PlayerGang = {}
local PlayerJob = {}
local CurrentHouseGarage = nil
local CurrentGarage = nil
local GaragePoly = {}
local MenuItemId1 = nil
local MenuItemId2 = nil
local VehicleClassMap = {}
local GarageZones = {}
local inImpound = false

-- helper functions

local function TableContains (tab, val)
    if type(val) == "table" then -- checks if atleast one the values in val is contained in tab
        for _, value in ipairs(tab) do
            if TableContains(val, value) then
                return true
            end
        end
        return false
    else
        for _, value in ipairs(tab) do
            if value == val then
                return true
            end
        end
    end
    return false
end

local function IsStringNilOrEmpty(s)
    return s == nil or s == ''
end

local function IsTrueCategory(vehicle, category)
    if type(category) == 'table' then
        if TableContains(category, {'car'}) then
            category = 'car'
        elseif TableContains(category, {'plane', 'helicopter'}) then
            category = 'plane'
        elseif TableContains(category, {'helicopter'}) then
            category = 'helicopter'
        elseif TableContains(category, 'boat') then
            category = 'boat'
        end
    end
    if category == "plane" and vehicle == "planes" then
        return true
    elseif category == "helicopter" and vehicle == "helicopters" then
        return true
    elseif category == "boat" and vehicle == "boat" then
        return true
    elseif category == "car" and vehicle ~= "helicopters" and vehicle ~= "planes" and vehicle ~= "boat" then
        return true
    end
    return false
end

local function GetSuperCategoryFromCategories(categories)
    local superCategory = 'car'
    if TableContains(categories, {'car'}) then
        superCategory = 'car'
    elseif TableContains(categories, {'plane', 'helicopter'}) then
        superCategory = 'air'
    elseif TableContains(categories, 'boat') then
        superCategory = 'sea'
    end
    return superCategory
end

local function GetClosestLocation(locations, loc)
    local closestDistance = -1
    local closestIndex = -1
    local closestLocation = nil
    local plyCoords = loc or GetEntityCoords(PlayerPedId(), 0)
    for i,v in ipairs(locations) do
        local location = vector3(v.x, v.y, v.z)
        local distance = #(plyCoords - location)
        if(closestDistance == -1 or closestDistance > distance) then
            closestDistance = distance
            closestIndex = i
            closestLocation = v
        end
    end
    return closestIndex, closestDistance, closestLocation
end

function SetAsMissionEntity(vehicle)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleIsStolen(vehicle, false)
    SetVehicleIsWanted(vehicle, false)
    SetVehRadioStation(vehicle, 'OFF')
    local id = NetworkGetNetworkIdFromEntity(vehicle)
    SetNetworkIdCanMigrate(id, true)
end

function RemoveRadialOptions()
    if MenuItemId1 ~= nil then
        exports['qb-radialmenu']:RemoveOption(MenuItemId1)
        MenuItemId1 = nil
    end
    if MenuItemId2 ~= nil then
        exports['qb-radialmenu']:RemoveOption(MenuItemId2)
        MenuItemId2 = nil
    end
end

-- Functions

local function Round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

local function ApplyVehicleDamage(currentVehicle, veh)
	local engine = veh.engine + 0.0
	local body = veh.body + 0.0
    local damage = veh.damage and json.decode(veh.damage)
    if damage then
        if damage.entity then
            SetEntityHealth(currentVehicle, damage.entity)
        end
        if damage.tank then
            SetVehiclePetrolTankHealth(currentVehicle, damage.tank + 0.0)
        end
        if damage.dirty then
            SetVehicleDirtLevel(currentVehicle, damage.dirty + 0.0)
        end
        if damage.tyres then
            for k, tyre in pairs(damage.tyres) do
                if tyre.onRim then
                    SetVehicleTyreBurst(currentVehicle, tonumber(k), tyre.onRim, 1000.0)
                elseif tyre.burst then
                    SetVehicleTyreBurst(currentVehicle, tonumber(k), tyre.onRim, 990.0)
                end
            end
        end
        if damage.windows then
            for k, window in pairs(damage.windows) do
                if window.smashed then
                    SmashVehicleWindow(currentVehicle, tonumber(k))
                end
            end
        end

        if damage.doors then
            for k, door in pairs(damage.doors) do
                if door.damaged then
                    SetVehicleDoorBroken(currentVehicle, tonumber(k), true)
                end
            end
        end
    end

    SetVehicleEngineHealth(currentVehicle, engine)
    SetVehicleBodyHealth(currentVehicle, body)
end exports('ApplyVehicleDamage', ApplyVehicleDamage)

local function GetCarDamage(vehicle)
    local damage = {entity = math.ceil(GetEntityHealth(vehicle)), tank = math.ceil(GetVehiclePetrolTankHealth(vehicle)), dirty = math.ceil(GetVehicleDirtLevel(vehicle)), windows = {}, tyres = {}, doors = {}}
    local tyreIndexes = {0,1,2,3,4,5,45,47}
    
    for _,i in pairs(tyreIndexes) do
        damage.tyres[i] = {burst = IsVehicleTyreBurst(vehicle, i, false) == 1, onRim = IsVehicleTyreBurst(vehicle, i, true) == 1, health = GetTyreHealth(vehicle, i)}
    end
    for i=0,7 do
        damage.windows[i] = {smashed = not IsVehicleWindowIntact(vehicle, i)}
    end
    for i=0,5 do
        damage.doors[i] = {damaged = IsVehicleDoorDamaged(vehicle, i)}
    end

    return damage
end exports('GetCarDamage', GetCarDamage)

local function ExitAndDeleteVehicle(vehicle)
    local wait = 0
    if IsPedInAnyVehicle(PlayerPedId()) then
        wait = 1500
    end
    local garage = Config.Garages[CurrentGarage]
    local exitLocation = nil
    if garage and garage.ExitWarpLocations and next(garage.ExitWarpLocations) then
        _, _, exitLocation = GetClosestLocation(garage.ExitWarpLocations)
    end
    for i = -1, 5, 1 do
        local ped = GetPedInVehicleSeat(vehicle, i)
        if ped then
            TaskLeaveVehicle(ped, vehicle, 0)
            if exitLocation then
                SetEntityCoords(ped, exitLocation.x, exitLocation.y, exitLocation.z)
            end
        end
    end
    SetVehicleDoorsLocked(vehicle)
    Wait(wait)
    QBCore.Functions.DeleteVehicle(vehicle)
    RemoveRadialOptions()
end

local function GetVehicleCategoriesFromClass(class)
    return VehicleClassMap[class]
end

local function IsAuthorizedToAccessGarage(garageName)
    local garage = Config.Garages[garageName]
    if not garage then return false end
    if garage.type == 'job' then
        if type(garage.job) == "string" and not IsStringNilOrEmpty(garage.job) then
            local hasAccess = false
            if PlayerJob.name == garage.job then
                if garage.division then
                    if QBCore.Functions.HasDivision(garage.division) then
                        hasAccess = true
                    end
                else
                    hasAccess = true
                end
            end
            return hasAccess
        elseif type(garage.job) == "table" then
            return TableContains(garage.job, PlayerJob.name)
        else
            QBCore.Functions.Notify('job not defined on garage', 'error', 7500)
            return false
        end
    elseif garage.type == 'gang' then 
        if type(garage.gang) == "string" and  not IsStringNilOrEmpty(garage.gang) then
            return garage.gang == PlayerGang.name
        elseif type(garage.gang) =="table" then
            return TableContains(garage.gang, PlayerGang.name)
        else
            QBCore.Functions.Notify('gang not defined on garage', 'error', 7500)
            return false
        end
    end
    return true
end

local function CanParkVehicle(veh, garageName, vehLocation)
    local garage = garageName and Config.Garages[garageName] or (CurrentGarage and Config.Garages[CurrentGarage]  or Config.HouseGarages[CurrentHouseGarage])
    if not garage then return false end
    local parkingDistance =  garage.ParkingDistance and  garage.ParkingDistance or Config.ParkingDistance
    local vehClass = GetVehicleClass(veh)
    local vehCategories = GetVehicleCategoriesFromClass(vehClass)

    if garage and garage.vehicleCategories and not TableContains(garage.vehicleCategories, vehCategories) then
        QBCore.Functions.Notify(Lang:t("error.not_correct_type"), "error", 4500)
        return false
    end

    local parkingSpots = garage.ParkingSpots and garage.ParkingSpots or {}
    if next(parkingSpots) ~= nil then
        local _, closestDistance, closestLocation = GetClosestLocation(parkingSpots, vehLocation)
        if closestDistance >= parkingDistance then
            QBCore.Functions.Notify(Lang:t("error.too_far_away"), "error", 4500)
            return false
        else
            return true, closestLocation
        end
    else
        return true
    end
end

local function ParkOwnedVehicle(veh, garageName, vehLocation, plate)
    local bodyDamage = math.ceil(GetVehicleBodyHealth(veh))
    local engineDamage = math.ceil(GetVehicleEngineHealth(veh))

    local totalFuel = 0

    totalFuel = exports[Config.FuelScript]:GetFuel(veh)

    local canPark, closestLocation = CanParkVehicle(veh, garageName, vehLocation)
    local closestVec3 = closestLocation and vector3(closestLocation.x,closestLocation.y, closestLocation.z) or nil
    if not canPark then return end
    local properties = QBCore.Functions.GetVehicleProperties(veh)
    TriggerServerEvent('qb-garage:server:updateVehicle', true, plate, totalFuel, engineDamage, bodyDamage, properties, garageName, closestVec3, GetCarDamage(veh))
    ExitAndDeleteVehicle(veh)
    QBCore.Functions.Notify(Lang:t("success.vehicle_parked"), "success", 4500)
end

local function ParkVehicle(veh, garageName, vehLocation)
    local plate = QBCore.Functions.GetPlate(veh)
    local garageName = garageName or (CurrentGarage or CurrentHouseGarage)
    local garage = Config.Garages[garageName]
    local type = garage and garage.type or 'house'
    local gang = PlayerGang.name
    QBCore.Functions.TriggerCallback('qb-garage:server:checkOwnership', function(owned, vehicle)
        if owned then
            if not Config.Garages[garageName] or IsTrueCategory(QBCore.Shared.Vehicles[vehicle].category, Config.Garages[garageName].vehicleCategories) then
                ParkOwnedVehicle(veh, garageName, vehLocation, plate)
            else
                QBCore.Functions.Notify('Can not Park Vehicle here', "error", 3500)
            end
        else
            QBCore.Functions.Notify(Lang:t("error.not_owned"), "error", 3500)
        end
    end, plate, type, garageName, gang)
end

local function AddRadialParkingOption()
    local ped = PlayerPedId()
    local veh, dist =  QBCore.Functions.GetClosestVehicle()
    if (veh and dist <= Config.VehicleParkDistance and Config.AllowParkingFromOutsideVehicle) or IsPedInAnyVehicle(ped) then
        MenuItemId1 = exports['qb-radialmenu']:AddOption({
            id = 'put_up_vehicle',
            title = 'Park Vehicle',
            icon = '#parkvehicle',
            functiontype = 'client',
            functionName = 'qb-garages:client:ParkVehicle',
            shouldClose = true
        }, MenuItemId1)
    else
        if MenuItemId1 then
            exports['qb-radialmenu']:RemoveOption(MenuItemId1)
            MenuItemId1 = nil
        end
    end
    MenuItemId2 = exports['qb-radialmenu']:AddOption({
        id = 'open_garage_menu',
        title = 'Open Garage',
        icon = '#garage',
        functiontype = 'client',
        functionName = 'qb-garages:client:OpenMenu',
        shouldClose = true
    }, MenuItemId2)
end

local function CreateGarageZone()
    local combo = ComboZone:Create(GarageZones, {name = 'garages', debugPoly=false})
    combo:onPlayerInOut(function(isPointInside, l, zone)
        if isPointInside and IsAuthorizedToAccessGarage(zone.name) then
            CurrentGarage = zone.name
            if Config.Garages[CurrentGarage].type == 'depot' then
                inImpound = true
            end
            exports['qb-core']:DrawText(Config.Garages[CurrentGarage]['drawText'], 'left', inImpound and 'E' or 'F1')
        else
            CurrentGarage = nil
            inImpound = false
            RemoveRadialOptions()
            exports['qb-core']:HideText()
        end
    end)
end

local function CreateGaragePolyZone(garage)
    local zone = PolyZone:Create(Config.Garages[garage].Zone.Shape, {
        name = garage,
        minZ = Config.Garages[garage].Zone.minZ,
        maxZ = Config.Garages[garage].Zone.maxZ,
        debugPoly = Config.Garages[garage].debug
    })
    GarageZones[#GarageZones+1] = zone
end

local function CreateGarageBoxZone(house, coords, debugPoly)
    local pos = vector3(coords.x, coords.y, coords.z)
    return BoxZone:Create(pos,5,3.5, {
        name = house,
        offset = {0.0, 0.0, 0.0},
        debugPoly = debugPoly,
        heading = coords.h,
        minZ = pos.z - 1.0,
        maxZ = pos.z + 1.0,
    })
end

local function RegisterHousePoly(house)
    if GaragePoly[house] then return end
    local coords = Config.HouseGarages[house].takeVehicle
    if not coords or not coords.x then return end
    local zone = CreateGarageBoxZone(house, coords, false)
    GaragePoly[house] = {
        Polyzone = zone,
        coords = coords,
    }
    zone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            CurrentHouseGarage = house
            exports['qb-core']:DrawText(Config.HouseParkingDrawText, 'left', 'F1') 
        else
            exports['qb-core']:HideText()
            RemoveRadialOptions()
            CurrentHouseGarage = nil
        end
    end)
end

local function RemoveHousePoly(house)
    if not GaragePoly[house] then return end
    GaragePoly[house].Polyzone:destroy()
    GaragePoly[house] = nil
end

function GetFreeParkingSpots(parkingSpots)
    local freeParkingSpots = {}
    for _, parkingSpot in ipairs(parkingSpots) do
        local veh, distance = QBCore.Functions.GetClosestVehicle(vector3(parkingSpot.x,parkingSpot.y, parkingSpot.z))
        if veh == -1 or distance >= 1.5 then
            freeParkingSpots[#freeParkingSpots+1] = parkingSpot
        end
    end
    return freeParkingSpots
end

function GetFreeSingleParkingSpot(freeParkingSpots, vehicle)
    local checkAt = nil
    if vehicle and vehicle.parkingspot then
        checkAt = vector3(vehicle.parkingspot.x, vehicle.parkingspot.y, vehicle.parkingspot.z) or nil
    end
    local _, _, location = GetClosestLocation(freeParkingSpots, checkAt)
    return location
end

function GetSpawnLocationAndHeading(garage, garageType, parkingSpots, vehicle, spawnDistance)
    local location
    local heading
    local closestDistance = -1

    if garageType == "house" then
        location = garage.takeVehicle
        heading = garage.takeVehicle.h
        if not location or not location.x then
            QBCore.Functions.Notify(Lang:t("error.no_garage"), "error", 4500)
            return false
        end
        return location, heading
    else
        if next(parkingSpots) ~= nil then
            local freeParkingSpots = GetFreeParkingSpots(parkingSpots)
            if Config.AllowSpawningFromAnywhere then
                location = GetFreeSingleParkingSpot(freeParkingSpots, vehicle)
                if location == nil then
                    QBCore.Functions.Notify(Lang:t("error.all_occupied"), "error", 4500)
                    return 
                end
                heading = location.w
            else
                _, closestDistance, location = GetClosestLocation(Config.SpawnAtFreeParkingSpot and freeParkingSpots or parkingSpots)
                local plyCoords = GetEntityCoords(PlayerPedId(), 0)
                if closestDistance >= spawnDistance then
                    QBCore.Functions.Notify(Lang:t("error.too_far_away"), "error", 4500)
                    return false
                else
                    local veh, distance = QBCore.Functions.GetClosestVehicle(vector3(location.x,location.y, location.z))
                    if veh ~= -1 and distance <= 1.5 then
                        QBCore.Functions.Notify(Lang:t("error.occupied"), "error", 4500)
                    return end
                    heading = location.w
                end
            end
        else
            local ped = GetEntityCoords(PlayerPedId())
            local pedheadin = GetEntityHeading(PlayerPedId())
            local forward = GetEntityForwardVector(PlayerPedId())
            local x, y, z = table.unpack(ped + forward * 3)
            location = vector3(x, y, z)
            if Config.VehicleHeading == 'forward' then
                heading = pedheadin
            elseif Config.VehicleHeading == 'driverside' then
                heading = pedheadin + 90
            elseif Config.VehicleHeading == 'hood' then
                heading = pedheadin + 180
            elseif Config.VehicleHeading == 'passengerside' then
                heading = pedheadin + 270
            end
        end
    end
    return location, heading
end

function UpdateSpawnedVehicle(spawnedVehicle, vehicleInfo, heading)
    SetEntityHeading(spawnedVehicle, heading)
    local properties = json.decode(vehicleInfo.mods)
    local status = json.decode(vehicleInfo.status)
    if status ~= nil and next(status) ~= nil then
        TriggerServerEvent('qb-vehicletuning:server:LoadStatus', status, vehicleInfo.plate)
    end
    exports[Config.FuelScript]:SetFuel(spawnedVehicle, vehicleInfo.fuel)
    QBCore.Functions.SetVehicleProperties(spawnedVehicle, properties)
    SetVehicleNumberPlateText(spawnedVehicle, vehicleInfo.plate)
    SetAsMissionEntity(spawnedVehicle)
    ApplyVehicleDamage(spawnedVehicle, vehicleInfo)
    TriggerServerEvent('qb-garage:server:updateVehicle', false, vehicleInfo.plate)
    TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', vehicleInfo.plate)
end

function UpdateSpawnedVehicleimpound(spawnedVehicle, vehicleInfo)

    -- SetEntityHeading(spawnedVehicle, heading)
    local properties = json.decode(vehicleInfo.mods)
    local status = json.decode(vehicleInfo.status)
    if status ~= nil and next(status) ~= nil then
        TriggerServerEvent('qb-vehicletuning:server:LoadStatus', status, vehicleInfo.plate)
    end
    exports[Config.FuelScript]:SetFuel(spawnedVehicle, vehicleInfo.fuel)
    QBCore.Functions.SetVehicleProperties(spawnedVehicle, properties)
    SetVehicleNumberPlateText(spawnedVehicle, vehicleInfo.plate)
    SetAsMissionEntity(spawnedVehicle)
    ApplyVehicleDamage(spawnedVehicle, vehicleInfo)
    SetVehicleDoorsLocked(spawnedVehicle, 2)
    TriggerServerEvent('qb-garage:server:updateVehicle', false, vehicleInfo.plate)
    TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', vehicleInfo.plate)
end

function ImpoundInfo(data, time)
    if data then
        local rtime = data.depottime and (data.depottime == -1 and data.depottime or math.floor(((data.depottime - time) / 3600)) + 1) or 0
        local rtext = rtime..' hour'
        if rtime <= 0 then
            if data.depottime and data.depottime == -1 then
                rtext = 'Permanet'
            else
                rtext = 'Now'
            end
        end
        local takeMenu = {
            {
                header = QBCore.Shared.Vehicles[data.vehicle].name,
                txt = plate,
                isMenuHeader = true
            },
            {
                header = 'Release fee: $'..(data.depotprice or 0),
                isMenuHeader = true
            },
            {
                header = 'Release time: '..rtext,
                isMenuHeader = true
            },
            {
                header = 'Depot by: '..(data.depotby or 'Tow'),
                isMenuHeader = true
            },
        }
        local PlayerData = QBCore.Functions.GetPlayerData()
        if ((rtime <= 0 and rtext ~= 'Permanet') and data.citizenid == PlayerData.citizenid) or (Config.ImpoundAccess[PlayerData.job.name] ~= nil and (Config.ImpoundAccess[PlayerData.job.name] and PlayerData.job.onduty or true)) then
            takeMenu[#takeMenu + 1] = {
                header = 'Take Out',
                params = {
                    isAction = true,
                    event = function()
                        QBCore.Functions.TriggerCallback('qb-garage:server:GetOutsideVehicle', function(Outside)
                            if Outside then
                                QBCore.Functions.TriggerCallback('qb-garages:server:removeFromCooldwon', function(cbtext, cbtype)
                                    QBCore.Functions.Notify(cbtext, cbtype)
                                end, data.plate)
                            else
                                local garage = Config.Garages[CurrentGarage]
                                if garage then
                                    -- local location, heading = GetSpawnLocationAndHeading(garage, garage.type, garage.ParkingSpots or {}, data.vehicle, garage.SpawnDistance and garage.SpawnDistance or Config.SpawnDistance)
                                    -- if location then
                                        QBCore.Functions.TriggerCallback('qb-garages:server:getFromImpound', function(done)
                                            if done then
                                                for k, v in pairs(Config.Garages[CurrentGarage].ParkingSpots) do
                                                    local closestVeh = GetClosestVehicle(v.x, v.y, v.z, 2.5, 0, 70)
                                                    local plate = QBCore.Functions.GetPlate(closestVeh)
                                                    if plate ==nil then
                                                        QBCore.Functions.SpawnVehicle(data.vehicle, function(veh)
                                                            UpdateSpawnedVehicleimpound(veh, data, v.w)
                                                            if Config.stretcherveh[GetEntityModel(veh)] then
                                                                stretcherspawn(veh,GetEntityCoords(veh))
                                                            end
                                                        end, v, true)
                                                        break
                                                    end
                                                end
                                                


                                              
                                            else
                                                QBCore.Functions.Notify('You dont Have Enough Money in Bank', 'error')
                                            end
                                        end, data.depotprice or 0)
                                    -- end
                                end
                            end
                        end, data.plate)
                    end
                }
            }
        end
        takeMenu[#takeMenu + 1] = {
            header = 'Close',
            params = {
                event = "qb-menu:closeMenu",
            }
        }
        exports['qb-menu']:openMenu(takeMenu)
    else
        QBCore.Functions.Notify('There is not any vehicle with this plate in depot.', 'error')
    end
end

-- NUI Callback

RegisterNUICallback('callback', function(data)
    if data.action == "nuiFocus" then
        SetNuiFocus(false, false)
    elseif data.action == "takeOutVehicle" then
        TriggerEvent('qb-garages:client:TakeOutGarage', data.data)
    elseif data.action == "takeOutDepo" then
    end
end)

-- Events

function stretcherspawn(veh,coord)
    local stretcherconfig=exports['qb-stretcher']:getconfigstretcher()
    local vehconfig={}
    for k,v in pairs(stretcherconfig) do
		if GetEntityModel(veh)== GetHashKey(v.hash) then
			vehconfig=v
		end
	end

    model =GetHashKey("trump-stretcher")
    RequestModel(model)
    while not HasModelLoaded(model) do Citizen.Wait(0) end
    local vehicle = CreateVehicle(model,0,0,0, true, true)
    SetVehicleExtra(vehicle, 7,1)
    SetVehicleExtra(vehicle, 6,1)
    SetVehicleExtra(vehicle, 5,1)
    SetVehicleExtra(vehicle, 3,1)
    SetVehicleExtra(vehicle, 12,1)
    SetVehicleExtra(vehicle, 1,1)
    SetVehicleExtra(vehicle, 2,0)
    SetModelAsNoLongerNeeded(model)
    SetVehicleOnGroundProperly(vehicle)
    TriggerServerEvent('qb-vehiclekeys:server:setVehLockState', NetworkGetNetworkIdFromEntity(vehicle), 2)
	AttachEntityToEntity(vehicle, veh, 0.0, vehconfig.width, vehconfig.depth, vehconfig.height, 0.0, 0.0, 0.0, 0.0, false, false, true, false, 2, true)

end
RegisterNetEvent("qb-garages:client:GarageMenu", function(data)
    local type = data.type
    local garageId = data.garageId
    local garage = data.garage
    local header = data.header
    local superCategory = data.superCategory
    QBCore.Functions.TriggerCallback("qb-garage:server:GetGarageVehicles", function(result)
        if result == nil then
            QBCore.Functions.Notify(Lang:t("error.no_vehicles"), "error")
        else
            result = result or {}
            local formattedVehicles = {}
            for k, v in pairs(result) do
                local vehData = QBCore.Shared.Vehicles[v.vehicle]
                local vname = 'Vehicle does not exist'
                if vehData then
                    local vehCategories = GetVehicleCategoriesFromClass(GetVehicleClassFromName(v.vehicle))
                    if garage and garage.vehicleCategories and not TableContains(garage.vehicleCategories, vehCategories) then
                        goto continue
                    end
                    vname = vehData.name
                end
                if v.mods and v.mods=="null" then v.mods="{}" end
                local mods = json.decode(v.mods)
                formattedVehicles[#formattedVehicles + 1] = {
                    vehicle = v.vehicle,
                    vehClass = GetVehicleClassFromName(v.vehicle),
                    vehicleLabel = vname,
                    plate = v.plate,
                    plateIndex = mods.plateIndex or 0,
                    state = 1,
                    fuel = v.fuel,
                    engine = Round(v.engine, 0),
                    body = Round(v.body, 0),
                    distance = 0,
                    garage = garage,
                    type = type,
                    index = garageId,
                    depotPrice = 0,
                    balance = 0,
                    logs = {},
                    shared = false
                }
                ::continue::
            end
            SetNuiFocus(true, true)
            SendNUIMessage({
                action = 'VehicleList',
                garageLabel = data.header,
                vehicles = formattedVehicles,
                vehNum = #formattedVehicles,
                garageType = type,
                useCarImg = true,
                useCustomCarImg = true
            })
        end
    end, garageId, type, superCategory)
end)

RegisterNetEvent('qb-garages:client:TakeOutGarage', function(data, cb)
    local garage = Config.Garages[CurrentGarage] or Config.HouseGarages[CurrentHouseGarage]
    if not garage then return end
    QBCore.Functions.TriggerCallback("qb-garage:server:GetVehicle", function(vehicle)
        if not vehicle then return end
        local garageType = garage.type or 'house'
        local spawnDistance = garage.SpawnDistance and garage.SpawnDistance or Config.SpawnDistance
        local parkingSpots = garage.ParkingSpots or {}
        local location, heading = GetSpawnLocationAndHeading(garage, garageType, parkingSpots, vehicle, spawnDistance)
        if location then
            QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
                UpdateSpawnedVehicle(veh, vehicle, heading)
                if Config.stretcherveh[GetEntityModel(veh)] then
                    stretcherspawn(veh,GetEntityCoords(veh))
                end
            end, location, true)
        end
    end, data.plate)
end)

RegisterNetEvent('qb-radialmenu:client:onRadialmenuOpen', function()
    local garage = Config.Garages[CurrentGarage]
    if CurrentGarage ~= nil and garage ~= nil then
        if garage.type == 'job' and not IsStringNilOrEmpty(garage.job) then
            if IsAuthorizedToAccessGarage(CurrentGarage) then
                AddRadialParkingOption()
            end
        elseif garage.type == 'gang' and not IsStringNilOrEmpty(garage.gang) then
            if PlayerGang.name == garage.gang then
                AddRadialParkingOption()
            end
        elseif IsAuthorizedToAccessGarage(CurrentGarage) and garage.type ~= 'depot' then
           AddRadialParkingOption()
        end
    elseif CurrentHouseGarage ~= nil then
       AddRadialParkingOption()
    else
        RemoveRadialOptions()
    end
end)

RegisterNetEvent('qb-garages:client:OpenMenu', function()
    if CurrentGarage then
        local garage = Config.Garages[CurrentGarage]
        local type = garage.type
        local categories = garage.vehicleCategories
        local superCategory = GetSuperCategoryFromCategories(categories)
        local args = {
            garageId = CurrentGarage,
            garage = garage,
            categories = categories,
            header =  Lang:t("menu.header."..garage.type.."_"..superCategory, {value = garage.label}),
            superCategory = superCategory,
            type = type
        }
        TriggerEvent('qb-garages:client:GarageMenu', args)
    elseif CurrentHouseGarage then
        TriggerEvent('qb-garages:client:OpenHouseGarage')
    end
end)

RegisterNetEvent('qb-garages:client:ParkVehicle', function()
    local ped = PlayerPedId()
    local curVeh = GetVehiclePedIsIn(ped)
    if Config.AllowParkingFromOutsideVehicle and curVeh == 0 then
        local closestVeh, dist = QBCore.Functions.GetClosestVehicle()
        if dist <= Config.VehicleParkDistance then
            curVeh = closestVeh
        end
    end
    ParkVehicle(curVeh)
end)

RegisterNetEvent('qb-garages:client:ParkLastVehicle', function(parkingName)
    local ped = PlayerPedId()
    local curVeh = GetLastDrivenVehicle(ped)
    if curVeh then
        local coords = GetEntityCoords(curVeh)
        ParkVehicle(curVeh, parkingName or CurrentGarage, coords)
    else
        QBCore.Functions.Notify(Lang:t('error.no_vehicle'), "error", 4500)
    end
end)

RegisterNetEvent('qb-garages:client:ImpoundVehicle', function(price, time)
    local vehicle = QBCore.Functions.GetClosestVehicle()
    if vehicle ~= 0 and vehicle then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local vehpos = GetEntityCoords(vehicle)
        if #(pos - vehpos) < 5.0 and not IsPedInAnyVehicle(ped) then
            QBCore.Functions.Progressbar("impond_vehicle", "Impound Vehicle..", 5000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "amb@code_human_police_investigate@idle_a",
                anim = "idle_b",
                flags = 16,
            }, {}, {}, function() -- Done
                StopAnimTask(PlayerPedId(), "amb@code_human_police_investigate@idle_a", "idle_b", 1.0)
                local damages = exports['qb-garages']:GetCarDamage(vehicle)
                local bodyDamage = math.ceil(GetVehicleBodyHealth(vehicle))
                local engineDamage = math.ceil(GetVehicleEngineHealth(vehicle))
                local totalFuel = exports[Config.FuelScript]:GetFuel(vehicle)
                local plate = QBCore.Functions.GetPlate(vehicle)
                TriggerServerEvent("qb-garages:server:ImpoundVehicle", price, time, plate, damages, bodyDamage, engineDamage, totalFuel)
                QBCore.Functions.DeleteVehicle(vehicle)
            end, function() -- Cancel
                StopAnimTask(PlayerPedId(), "amb@code_human_police_investigate@idle_a", "idle_b", 1.0)
                QBCore.Functions.Notify("Canceled..", "error")
            end)
        end
    end
end)

CreateThread(function()
  exports['qb-interact']:AddInteraction({
    coords =vector3(-236.19, -1366.04, 31.82),
    distance = 4.0, 
    interactDst = 1.2, 
    id = "impoundlot-1",
    name = "impoundlot-1", 
    options = {
         {
            id = "impoundlot-1", 
            label = 'Impound Vehicle',
            event =  "qb-garages:client:impoundmenu",
            args = {type="veh",garage="impoundlot"}
        },
    }
})
local model = GetHashKey('a_m_y_stbla_01')
RequestModel(model)
while not HasModelLoaded(model) do 
    Citizen.Wait(10)
end
local npcboat={}
for k,v in pairs(Config.boatped) do
    npcboat[k] = CreatePed(0,model, v.x,v.y,v.z,v.w, false, false)
    TaskStartScenarioInPlace(npcboat[k],"WORLD_HUMAN_SMOKING_POT", 0, true)
    FreezeEntityPosition(npcboat[k], true)
    SetEntityInvincible(npcboat[k], true)
    SetBlockingOfNonTemporaryEvents(npcboat[k], true)
    exports['qb-interact']:AddEntityInteraction({
        netId =  npcboat[k],
        distance = 4.0, 
        interactDst = 1.2, 
        offset = vec3(0.0, 0.0, 0.0),
        id = "impoundlott_"..k,
        name = "impoundlott_"..k, 
        options = {
             {
                label = 'Impound',
                event =  "qb-garages:client:impoundmenu",
                args = {garage="impoundlotboat"}
            },
            
        }
    })

  
end


end)

RegisterNetEvent('qb-garages:client:impoundmenu', function(data)
    CurrentGarage=data.args.garage
local ImpoundMenu = {
    {
        header = 'Los Santos Impound',
        isMenuHeader = true
    },
    {
        header = 'Find vehicle by Plate',
        icon = "fa fa-car",
        params = {
            isAction = true,
            event = function()
                local keyboard = exports['qb-input']:ShowInput({
                    header = "Enter Plate",
                    submitText = "Confirm",
                    inputs = {
                        {
                            type = 'text',
                            isRequired = true,
                            text = "Plate",
                            name = 'plate',
                        },
                    }
                })
                if keyboard and keyboard.plate then
                    local plate = string.upper(keyboard.plate)
                    QBCore.Functions.TriggerCallback('qb-garages:server:impoundFindbyPlate', function(data, time)
                        if data and data.vehicle and QBCore.Shared.Vehicles[data.vehicle] and CurrentGarage and Config.Garages[CurrentGarage] then
                            if IsTrueCategory(QBCore.Shared.Vehicles[data.vehicle].category, Config.Garages[CurrentGarage].vehicleCategories) then
                                ImpoundInfo(data, time)
                            end
                        end
                    end, plate)
                end
            end
        }
    },
    {
        header = 'Show All Impounded vehicles',
        icon = 'fa fa-info-circle',
        params = {
            isAction = true,
            event = function()
                -- local keyboard = exports['qb-input']:ShowInput({
                --     header = "Enter State ID",
                --     submitText = "Confirm",
                --     inputs = {
                --         {
                --             type = 'text',
                --             isRequired = true,
                --             text = "State ID",
                --             name = 'bsn',
                --         },
                --     }
                -- })

               if true then-- if keyboard and keyboard.bsn then
                local PlayerData = QBCore.Functions.GetPlayerData()
                    QBCore.Functions.TriggerCallback('qb-garages:server:impoundFindbyStateID', function(vehs, time)
                        if vehs then
                            local VehsMenu = {
                                {
                                    header = PlayerData.charinfo.firstname..' '..PlayerData.charinfo.lastname.." Vehicles",
                                    isMenuHeader = true
                                },
                            }
                            for k,v in pairs(vehs) do
                                if v.vehicle and QBCore.Shared.Vehicles[v.vehicle] then
                                    if IsTrueCategory(QBCore.Shared.Vehicles[v.vehicle].category, Config.Garages[CurrentGarage].vehicleCategories) then
                                        VehsMenu[#VehsMenu + 1] = {
                                            header = QBCore.Shared.Vehicles[v.vehicle].name,
                                            txt ='<img src="https://assets.nopixel.net/dev/images/showroom/' .. v.vehicle .. '.webp" width=80px>   '.. v.plate,
                                            params = {
                                                isAction = true,
                                                event = function()
                                                    ImpoundInfo(v, time)
                                                end
                                            }
                                        }
                                    end
                                end
                            end
                            VehsMenu[#VehsMenu + 1] = {
                                header = 'Close',
                                icon = "fa-solid fa-angle-left",
                                params = {
                                    event = "qb-menu:closeMenu",
                                }
                            }
                            exports['qb-menu']:openMenu(VehsMenu)
                        else
                            QBCore.Functions.Notify('There is not any vehicle for this State ID in depot', 'error')
                        end
                    end, PlayerData.citizenid)
                end
            end
        }
    },
    {
        header = 'Close',
        icon = "fa-solid fa-angle-left",
        params = {
            event = "qb-menu:closeMenu",
        }
    },
}
exports['qb-menu']:openMenu(ImpoundMenu)

end)
AddEventHandler('onKeyDown', function(key)
    if key == 'e' then
        if inImpound then
            
        end
    end
end)

RegisterNetEvent('qb-garages:client:OpenHouseGarage', function()
    local superCategory = GetSuperCategoryFromCategories(Config.HouseGarageCategories)
    local args = {
        garageId = CurrentHouseGarage,
        categories = Config.HouseGarageCategories,
        header =  Config.HouseGarages[CurrentHouseGarage].label,
        garage = Config.HouseGarages[CurrentHouseGarage],
        superCategory = superCategory,
        type = 'house'
    }
    TriggerEvent('qb-garages:client:GarageMenu', args)
end)

RegisterNetEvent('qb-garages:client:setHouseGarage', function(house, hasKey)
    if hasKey then
        if Config.HouseGarages[house] and Config.HouseGarages[house].takeVehicle.x then
            RegisterHousePoly(house)
        end
    else
        RemoveHousePoly(house)
    end
end)

RegisterNetEvent('qb-garages:client:houseGarageConfig', function(garageConfig)
    for _,v in pairs(garageConfig) do
        v.vehicleCategories = Config.HouseGarageCategories
    end
    Config.HouseGarages = garageConfig
    HouseGarages = garageConfig
end)

RegisterNetEvent('qb-garages:client:addHouseGarage', function(house, garageInfo)
    garageInfo.vehicleCategories = Config.HouseGarageCategories
    Config.HouseGarages[house] = garageInfo
    HouseGarages[house] = garageInfo
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    if not PlayerData then return end
    PlayerGang = PlayerData.gang
    PlayerJob = PlayerData.job
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() and QBCore.Functions.GetPlayerData() ~= {} then
        PlayerData = QBCore.Functions.GetPlayerData()
        if not PlayerData then return end
        PlayerGang = PlayerData.gang
        PlayerJob = PlayerData.job
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        RemoveRadialOptions()
        for _,v in pairs(GarageZones) do
            exports['qb-target']:RemoveZone(v.name)
        end
    end
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate', function(gang)
    PlayerGang = gang
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    PlayerJob = job
end)

-- Threads

CreateThread(function()
    for _, garage in pairs(Config.Garages) do
        if garage.showBlip then
            local Garage = AddBlipForCoord(garage.blipcoords.x, garage.blipcoords.y, garage.blipcoords.z)
            local blipColor = garage.blipColor ~= nil and garage.blipColor or 3
            SetBlipSprite(Garage, garage.blipNumber)
            SetBlipDisplay(Garage, 4)
            SetBlipScale(Garage, 0.60)
            SetBlipAsShortRange(Garage, true)
            SetBlipColour(Garage, blipColor)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Config.GarageNameAsBlipName and garage.label or garage.blipName)
            EndTextCommandSetBlipName(Garage)
        end
    end
end)

CreateThread(function()
    for garageName, garage in pairs(Config.Garages) do
        if(garage.type == 'public' or garage.type == 'depot' or garage.type == 'job' or garage.type == 'gang') then
            CreateGaragePolyZone(garageName)
        end
    end
    CreateGarageZone()
end)

CreateThread(function()
    local debug = false
    for _, garage in pairs(Config.Garages) do
        if garage.debug then
            debug = true
            break
        end
    end
    while debug do
        for _, garage in pairs(Config.Garages) do
            local parkingSpots = garage.ParkingSpots and garage.ParkingSpots or {}
            if next(parkingSpots) ~= nil and garage.debug then
                for _, location in pairs(parkingSpots) do
                    DrawMarker(2, location.x, location.y, location.z + 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
                end
            end
        end
        Wait(0)
    end
end)

CreateThread(function()
    for category, classes  in pairs(Config.VehicleCategories) do
        for _, class  in pairs(classes) do
            VehicleClassMap[class] = VehicleClassMap[class] or {}
            VehicleClassMap[class][#VehicleClassMap[class]+1] = category
        end
    end
end)
