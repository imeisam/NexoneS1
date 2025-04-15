local QBCore = exports['qb-core']:GetCoreObject()
local OutsideVehicles = {}
local Searching = {}

local function GetEntities()
	local Entities = {}
	for _, entity in pairs(GetAllVehicles()) do
        Entities[#Entities+1] = NetworkGetNetworkIdFromEntity(entity)
	end
	return Entities
end

local function IsVehicleOut(plate)
    local fakeplates = exports['qb-smallresources']:GetFakePlates()
    for k,v in pairs(fakeplates) do
        if v.plate == string.upper(plate) then
            plate = k
            break
        end
    end
    local Vehicles = GetEntities()
    for i=1, #Vehicles do
        local Vehicle = NetworkGetEntityFromNetworkId(Vehicles[i])
        if DoesEntityExist(Vehicle) then
            if GetVehicleNumberPlateText(Vehicle) == string.upper(plate) then
                return true
            end
        end
    end
    return false
end

MySQL.ready(function()
	for k,v in ipairs(Config.BacktoGarage) do
        MySQL.update('UPDATE player_vehicles SET state = 1 WHERE state = 0 AND garage = ?', {v})
    end
end)

local function TableContains (tab, val)
    if type(val) == "table" then
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

QBCore.Functions.CreateCallback("qb-garage:server:GetOutsideVehicle", function(source, cb, plate)
    if plate and OutsideVehicles[plate] then
        cb(true)
    else
        if IsVehicleOut(plate) then
            cb(true)
        else
            cb(false)
        end
    end
end)

local function GetVehicles(citizenid, garageName, state, cb)
    local result = nil
    result = MySQL.Sync.fetchAll('SELECT * FROM player_vehicles WHERE citizenid = @citizenid AND garage = @garage AND state = @state', {
        ['@citizenid'] = citizenid,
        ['@garage'] = garageName,
        ['@state'] = state
    })
    cb(result)
end

local function GetVehicleByPlate(plate)
    local vehicles = GetAllVehicles() -- Get all vehicles known to the server
    for _, vehicle in pairs(vehicles) do
        local pl = GetVehicleNumberPlateText(vehicle)
        if pl == plate then
            return vehicle
        end
    end
end

QBCore.Functions.CreateCallback("qb-garage:server:GetGarageVehicles", function(source, cb, garage, garageType)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    if garageType == "public" then        --Public garages give player cars in the garage only
        GetVehicles(pData.PlayerData.citizenid, garage, 1, function(result)
            local vehs = {}
            if result[1] then
                for _, vehicle in pairs(result) do
                    if vehicle.parkingspot then
                        local spot = json.decode(vehicle.parkingspot)
                        if spot and spot.x then
                            vehicle.parkingspot = vector3(spot.x, spot.y, spot.z)
                        end
                    end
                    vehs[#vehs + 1] = vehicle
                end
                cb(vehs)
            else
                cb(nil)
            end
        end)
    else                            --House give all cars in the garage, Job and Gang depend of config
        local shared = ''
        if not TableContains(Config.SharedJobGarages, garage) and garageType ~= "house" then
            shared = " AND citizenid = '"..pData.PlayerData.citizenid.."'"
        end
         MySQL.query('SELECT * FROM player_vehicles WHERE garage = ? AND state = ?'..shared, {garage, 1}, function(result)
            if result[1] then
                local vehs = {}
                for _, vehicle in pairs(result) do
                    local spot = json.decode(vehicle.parkingspot)
                    if vehicle.parkingspot then
                        vehicle.parkingspot = vector3(spot.x, spot.y, spot.z)
                    end
                    vehs[#vehs + 1] = vehicle
                end
                cb(vehs)
            else
                cb(nil)
            end
        end)
    end
end)
local function Trim(value)
	if not value then return nil end
    return (string.gsub(value, '^%s*(.-)%s*$', '%1'))
end
local function GetPlate(vehicle)
    if vehicle == 0 then return end
    return Trim(GetVehicleNumberPlateText(vehicle))
end

local function isVehicleExistInRealLife(plate) 
	local loadedVehicles = GetAllVehicles()
	local check = false
	for k, v in pairs(loadedVehicles) do
		if plate == GetPlate(v) and DoesEntityExist(v) then
			check = true
		end
	end
	return check
end


QBCore.Functions.CreateCallback('qb-garage:server:GetVehicle', function(source, cb, plate)
    MySQL.query('SELECT * FROM player_vehicles WHERE plate = ?', {plate}, function(result)
        if result[1] then
            cb(result[1])
        else
            cb(nil)
        end
    end)
end)

function isImpoundedworld(plate)
		if (isVehicleExistInRealLife(plate)) then
            return false
        else
            return true
		end
end

QBCore.Commands.Add("depot", 'Depot Vehicle', {{name = "price", help = 'Release fee'}, {name = "time", help = 'Release Time by Hour (-1 is permanet)'}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Config.ImpoundAccess[Player.PlayerData.job.name] ~= nil and (Config.ImpoundAccess[Player.PlayerData.job.name] and Player.PlayerData.job.onduty or true) then
        local price = tonumber(args[1])
        local time = tonumber(args[2])
        if price < 0 then TriggerClientEvent('QBCore:Notify', src, 'Price Should be More than or Equal to 0', 'error') return end
        if price and time then
            TriggerClientEvent("qb-garages:client:ImpoundVehicle", src, price, time)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'No Access', 'error')
    end
end)

QBCore.Functions.CreateCallback('qb-garages:server:impoundFindbyPlate', function(source, cb, plate)
    MySQL.query('SELECT * FROM player_vehicles WHERE plate = ? AND state = ?', {plate, 0}, function(result)
        local res
        if result and result[1] then
                if isImpoundedworld(result[1].plate) then
                    res=result[1]
                end
            cb(res, os.time())
        else
            cb(res)
        end
    end)
end)

QBCore.Functions.CreateCallback('qb-garages:server:impoundFindbyStateID', function(source, cb, bsn)
    MySQL.query('SELECT * FROM player_vehicles WHERE citizenid = ? AND state = ?', {bsn, 0}, function(result)
        local res={}
        if result and result[1] then
            for k,v in ipairs(result) do
                if isImpoundedworld(v.plate) then
                    res[#res+1]=v
                end
            end
            cb(res, os.time())
        else
            cb(res)
        end
    end)
end)

RegisterNetEvent('qb-garages:server:ImpoundVehicle', function(price, time, plate, damages, body, engine, fuel)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local fakeplate = exports['qb-smallresources']:HasFakePlate(plate)
    if fakeplate.bool then plate = fakeplate.plate end
    if Config.ImpoundAccess[Player.PlayerData.job.name] ~= nil and (Config.ImpoundAccess[Player.PlayerData.job.name] and Player.PlayerData.job.onduty or true) then
        OutsideVehicles[plate] = nil
        MySQL.query('SELECT * FROM player_vehicles WHERE plate = ? AND vinscratch = ?', {plate, 1}, function(result)
            if result[1] then
                MySQL.query('DELETE FROM player_vehicles WHERE plate = ?', {plate})
            else
                MySQL.query('UPDATE player_vehicles SET damage = ?, body = ?, engine = ?, fuel = ?, depotprice = ?, depotby = ?, depottime = ? WHERE plate = ?', {json.encode(damages), body, engine, fuel, price, Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname, time == -1 and time or os.time() + time * 3600, plate})
            end
        end)
        TriggerEvent('qb-log:server:CreateLog', 'depot', 'Depot', 'white', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname..' Depot '..plate..' for '..time..' hour and $'..price)
    end
end)

QBCore.Functions.CreateCallback('qb-garages:server:getFromImpound', function(source, cb, money)
    local Player = QBCore.Functions.GetPlayer(source)
    if money<=0 then  cb(true) return end
    if Player.Functions.RemoveMoney('bank', money) then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback("qb-garage:server:checkOwnership", function(source, cb, plate, garageType, garage, gang)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    if garageType == "public" then        --Public garages only for player cars
         MySQL.query("SELECT * FROM player_vehicles WHERE plate = ? AND citizenid = '"..pData.PlayerData.citizenid.."' ",{plate}, function(result)
            if result[1] then
                cb(true, result[1].vehicle)
            else
                cb(false)
            end
        end)
    elseif garageType == "house" then     --House garages only for player cars that have keys of the house
         MySQL.query('SELECT * FROM player_vehicles WHERE plate = ? AND garage = ?', {plate, garage}, function(result)
            if result[1] then
                cb(true, result[1].vehicle)
            else
                local isOwner = MySQL.query.await('SELECT * FROM player_vehicles WHERE plate = ? AND citizenid = ?', {plate, pData.PlayerData.citizenid})
                if isOwner[1] then
                    cb(true, isOwner[1].vehicle)
                else
                    cb(false)
                end
            end
        end)
    elseif garageType == "gang" then        --Gang garages only for gang members cars (for sharing)
         MySQL.query('SELECT * FROM player_vehicles WHERE plate = ?', {plate}, function(result)
            if result[1] then
                --Check if found owner is part of the gang
                local Player = QBCore.Functions.GetPlayer(source)
                local playerGang = Player.PlayerData.gang.name
                cb(playerGang == gang, result[1].vehicle)
            else
                cb(false)
            end
        end)
    else
        if TableContains(Config.SharedJobGarages, garage) then
            local shared = " AND garage = '"..garage.."'"
            MySQL.query('SELECT * FROM player_vehicles WHERE plate = ?'..shared, {plate}, function(result)
                if result[1] then
                    cb(true, result[1].vehicle)
                else
                    local isOwner = MySQL.query.await('SELECT * FROM player_vehicles WHERE plate = ? AND citizenid = ?', {plate, pData.PlayerData.citizenid})
                    if isOwner[1] then
                        cb(true, isOwner[1].vehicle)
                    else
                        cb(false)
                    end
                end
            end)
        else
            local shared = " AND citizenid = '"..pData.PlayerData.citizenid.."'"
            MySQL.query('SELECT * FROM player_vehicles WHERE plate = ?'..shared, {plate}, function(result)
                if result[1] then
                    cb(true, result[1].vehicle)
                else
                    cb(false)
                end
            end)
        end
    end
end)

RegisterNetEvent('qb-garage:server:updateVehicle', function(state, plate, fuel, engine, body, properties, garage, location, damage)
    if state then
        OutsideVehicles[plate] = nil
        if location and type(location) == 'vector3' then
            MySQL.update('UPDATE player_vehicles SET state = ?, garage = ?, fuel = ?, engine = ?, body = ?, mods = ?, parkingspot = ?, damage = ? WHERE plate = ?',{1, garage, fuel, engine, body, json.encode(properties), json.encode(location), json.encode(damage), plate})
        else
            MySQL.update('UPDATE player_vehicles SET state = ?, garage = ?, fuel = ?, engine = ?, body = ?, mods = ?, damage = ? WHERE plate = ?',{1, garage, fuel, engine, body, json.encode(properties), json.encode(damage), plate})
        end
    else
        OutsideVehicles[plate] = true
        MySQL.update('UPDATE player_vehicles SET state = ?, depotprice = ?, depotby = ?, depottime = ? WHERE plate = ?',{0, 0, 'Tow', 0, plate})
    end
end)

QBCore.Functions.CreateCallback("qb-garages:server:removeFromCooldwon", function(source, cb, plate)
    local back = false
    local Player = QBCore.Functions.GetPlayer(source)
    if plate and OutsideVehicles[plate] then
        if not Searching[plate] then
            if not IsVehicleOut(plate) then
                if Player.Functions.RemoveMoney('bank', 50, 'remove from impound') then
                    Searching[plate] = true
                    SetTimeout(10 * 60 * 1000, function()
                        Searching[plate] = nil
                        OutsideVehicles[plate] = nil
                        TriggerClientEvent('QBCore:Notify', source, 'Your vehicle has been found', 'success')
                    end)
                    cb('Ok! We will find your vehicle', 'success')
                else
                    cb('You do not have 50$', 'error')
                end
            else
                cb('Your vehicle is in city', 'error')
            end
        else
            cb('we are already finding your vehicle', 'error')
        end
    else
        cb('an error happend', 'error')
    end
end)