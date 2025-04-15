local QBCore = exports['qb-core']:GetCoreObject()
logwebhook={
    ['police']="policeveh",
    ['doj']="dojveh",
    ['medic']="ambulanceveh",
}
local testplate={}
RegisterNetEvent('qb-vehicle:server:addtestplate', function(plate,netid)
    print(os.time())
    testplate[#testplate+1]={plate=plate,netid=netid,time=tonumber(os.time()+(((Config.TestDriveTime/1000))+10))}
end)

RegisterNetEvent('hospital:server:SetDeathStatus', function(isDead)
    if isDead then
        TriggerClientEvent('qb-dealership:close:client', source)
    end
end)

RegisterNetEvent('hospital:server:SetLaststandStatus', function(isDead)
    if isDead then
        TriggerClientEvent('qb-dealership:close:client', source)
    end
end)

RegisterNetEvent('qb-vehicle:server:sellusedvehicle', function(plate,price,vehicle,model)
    src=source
    local Player = QBCore.Functions.GetPlayer(src)
    local result = MySQL.query.await('SELECT citizenid FROM player_vehicles WHERE plate = ?', {plate})
    local resultrent = MySQL.query.await('SELECT plate FROM rentvehs WHERE plate = ?', {plate})
    if resultrent and resultrent[1] then 
        TriggerClientEvent("QBCore:Notify", src, 'Vehicle is Rent', "error")
         return 
     end

    if result and result[1] and result[1].citizenid==Player.PlayerData.citizenid then
        Player.Functions.AddMoney('bank', price, "Sell Used Car ("..plate..")")
        MySQL.query.await('delete from player_vehicles WHERE plate = ?', {plate})
        TriggerClientEvent("qb-vehicle:server:dvusedcar",src,vehicle)
        TriggerClientEvent("QBCore:Notify", src, 'Vehicle Sell Success', "success")
        TriggerEvent("qb-log:server:CreateLog", "sellusedcar", "Sell Usedcar", "red", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid..") \n Model: "..model.."\n Plate: "..plate.."\n Price:"..price)
    else
        TriggerClientEvent("QBCore:Notify", src, 'Vehicle Must be Own', "error")
    end
end)


local StringCharset = {}
local NumberCharset = {}
local W8ForAdd = {}
RegisterNetEvent('qb-vehicleshop:buyVehicle:server', function(type, vehicle, price, dealershipId, sender, job)
    local src = source
    local player = GetPlayer(src)
    local sender = tonumber(sender)
    local target = GetPlayer(sender)
    local playerMoney = GetPlayerMoney(src, type)
    local inshared = QBCore.Shared.Vehicles[vehicle]
    -- local count=exports['qb-tax']:getcarcounttax(player.PlayerData.citizenid)
    -- if count>=player.PlayerData.metadata['carslot'] then
    --     TriggerClientEvent("QBCore:Notify", src, 'You are Not Allowed Buy New Car </br> Call a Goverment for Help...!', "error")
    --     return
    -- end
    if not inshared then return end
    if playerMoney < price then
        return Notify(src, "You don't have enough money.", 7500, "error")
    end
    if Config.VehicleShops[dealershipId].Management.Enable and Config.EnableSocietyAccount then
        Config.AddManagementMoney(job, price)
    end
    if target then
        local targetMoney = price * Config.SalesShare / 100
        AddMoney(sender, "bank", targetMoney, "Vehicle sales share")
        Notify(sender, "You earned $" .. targetMoney .. " - " .. vehicle .. ".", 7500, "success")
    end
    local plate = GeneratePlate()
    W8ForAdd[src] = plate
    RemoveMoney(src, type, price, "vehicle-bought-in-showroom")
    TriggerClientEvent('qb-vehicleshop:buyVehicle:client', src, vehicle, plate, dealershipId)
    TriggerEvent('qb-log:server:CreateLog', 'buyvehicle', 'Buy Vehicle', 'white', player.PlayerData.charinfo.firstname..' '..player.PlayerData.charinfo.lastname..' ('..player.PlayerData.citizenid..')\n'..inshared.brand..' '..inshared.name..'\n'..plate..'\n$'..price..' ('..type..')')
   if logwebhook[Config.VehicleShops[dealershipId].shopname] then
    TriggerEvent('qb-log:server:CreateLog', logwebhook[Config.VehicleShops[dealershipId].shopname], 'Buy Vehicle', 'white', player.PlayerData.charinfo.firstname..' '..player.PlayerData.charinfo.lastname..' ('..player.PlayerData.citizenid..')\n'..inshared.brand..' '..inshared.name..'\n'..plate..'\n$'..price..' ('..type..')')
   end
   
    if Config.VehicleShops[dealershipId].EnableStocks then
        local dealershipData = MySQL.query.await('SELECT * FROM pa_vehicleshop_stocks WHERE dealershipId = ?', {dealershipId})
        local anusVal = {}
        for k, v in pairs(dealershipData) do
            for a, b in pairs(v) do
                anusVal[a] = b
            end
        end
        local stocksData = json.decode(anusVal["data"])
        if stocksData and next(stocksData) and next(stocksData) ~= nil then
            for k, v in pairs(stocksData) do
                if v.model == vehicle then
                    v.stock = v.stock - 1
                end
            end
        end
        MySQL.update('UPDATE pa_vehicleshop_stocks SET data = ? WHERE dealershipId = ?', {json.encode(stocksData), dealershipId})
    end
end)

RegisterNetEvent('qb-vehicleshop:server:saveVehicle', function(plate, model, props)
    local src = source
    if W8ForAdd[src] and W8ForAdd[src] == plate then
        W8ForAdd[src] = nil
        local inShare = QBCore.Shared.Vehicles[model]
        if not inShare then return end
        local Player = QBCore.Functions.GetPlayer(src)
        MySQL.insert('INSERT INTO player_vehicles (citizenid, vehicle, hash, mods, plate, garage, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
            Player.PlayerData.citizenid,
            model,
            GetHashKey(model),
            json.encode(props),
            plate,
            'pillboxgarage',
            0
        })
    end
end)

function Round(value, numDecimalPlaces)
    if not numDecimalPlaces then return math.floor(value + 0.5) end
    local power = 10 ^ numDecimalPlaces
    return math.floor((value * power) + 0.5) / (power)
end

CreateCallback('qb-vehicleshop:generatePlate:server', function(source, cb)
    local plate = GeneratePlate()
    cb(plate)
end)

function GeneratePlate()
    local plate = RandomInt(1) .. RandomStr(2) .. RandomInt(3) .. RandomStr(2)
    local result = MySQL.scalar.await('SELECT plate FROM ' .. Table .. ' WHERE plate = ?', {plate})
    if result then
        return GeneratePlate()
    else
        return plate:upper()
    end
end

for i = 48, 57 do NumberCharset[#NumberCharset + 1] = string.char(i) end
for i = 65, 90 do StringCharset[#StringCharset + 1] = string.char(i) end
for i = 97, 122 do StringCharset[#StringCharset + 1] = string.char(i) end

function RandomStr(length)
    if length <= 0 then return '' end
    return RandomStr(length - 1) .. StringCharset[math.random(1, #StringCharset)]
end

function RandomInt(length)
    if length <= 0 then return '' end
    return RandomInt(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
end

if Config.AutoDatabaseCreator then
    Citizen.CreateThread(function()
        while CoreReady == false do Citizen.Wait(0) end
        MySQL.query.await([[CREATE TABLE IF NOT EXISTS `pa_vehicleshop_stocks` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `dealershipId` int(11) DEFAULT NULL,
            `data` longtext DEFAULT NULL,
            PRIMARY KEY (`id`)
            ) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;]], {}, function(rowsChanged)
        end)
        MySQL.query.await([[CREATE TABLE IF NOT EXISTS `pa_vehicleshop_showroom_vehicles` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `dealershipId` int(11) DEFAULT NULL,
            `data` longtext NOT NULL,
            PRIMARY KEY (`id`)
            ) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;]], {}, function(rowsChanged)
        end)
    end)
end

-- Stocks
RegisterNetEvent('qb-vehicleshop:updateDealershipStockData:server', function(dealershipId, stocksData)
    local dealershipData = MySQL.query.await('SELECT * FROM pa_vehicleshop_stocks WHERE dealershipId = ?', {dealershipId})
    if dealershipData[1] then
        MySQL.update('UPDATE pa_vehicleshop_stocks SET data = ? WHERE dealershipId = ?', {json.encode(stocksData), dealershipId})
    else
        MySQL.insert('INSERT INTO pa_vehicleshop_stocks (dealershipId, data) VALUES (:dealershipId, :data)', {
            dealershipId = dealershipId,
            data = json.encode(stocksData)
        })
    end
end)

CreateCallback('qb-vehicleshop:getVehStock:server', function(source, cb, dealershipId)
    local dealershipData = MySQL.query.await('SELECT * FROM pa_vehicleshop_stocks WHERE dealershipId = ?', {dealershipId})
    local anusVal = {}
    for k, v in pairs(dealershipData) do
        for a, b in pairs(v) do
            anusVal[a] = b
        end
    end
    local stocksData = json.decode(anusVal["data"])
    if stocksData and next(stocksData) and next(stocksData) ~= nil then
        local stocks = {}
        for k, v in pairs(stocksData) do
            table.insert(stocks, {
                model = v.model,
                stock = v.stock
            })
        end
        cb(stocks)
    else
        cb(0)
    end
end)

local testVehicles = {}
RegisterNetEvent('qb-vehicleshop:startTest:server')
AddEventHandler('qb-vehicleshop:startTest:server', function(netId)
    testVehicles[netId] = {
        playerId = source
    }
end)

RegisterNetEvent('qb-vehicleshop:finishTest:server')
AddEventHandler('qb-vehicleshop:finishTest:server', function(netId)
    if testVehicles[netId] then
        testVehicles[netId] = nil
    end
end)

AddEventHandler('entityRemoved', function(entity)
    local netId = NetworkGetNetworkIdFromEntity(entity)
    if testVehicles[netId] then
        TriggerClientEvent('qb-vehicleshop:finishTest:client', testVehicles[netId].playerId)
        testVehicles[netId] = nil
    end
end)

RegisterNetEvent('qb-vehicleshop:updateShowroomVehicles:server', function(dealershipId, data)
    local src = source
    local showroomData = MySQL.query.await('SELECT * FROM pa_vehicleshop_showroom_vehicles WHERE dealershipId = ?', {dealershipId})
    if showroomData[1] then
        MySQL.update('UPDATE pa_vehicleshop_showroom_vehicles SET data = ? WHERE dealershipId = ?', {json.encode(data), dealershipId})
    else
        MySQL.insert('INSERT INTO pa_vehicleshop_showroom_vehicles (dealershipId, data) VALUES (?, ?)', {dealershipId, json.encode(data)})
    end
end)

CreateCallback('qb-vehicleshop:getShowroomData:server', function(source, cb, dealershipId)
    local showroomTable = {}
    local showroomDatas = MySQL.query.await('SELECT * FROM pa_vehicleshop_showroom_vehicles WHERE dealershipId = ?', {dealershipId})
    if showroomDatas[1] then
        if next(showroomDatas) and next(showroomDatas) ~= nil then
            for k, v in pairs(showroomDatas) do
                for a, b in pairs(json.decode(v.data)) do
                    table.insert(showroomTable, {
                        dealershipId = dealershipId,
                        coords = vector4(b.coords.x, b.coords.y, b.coords.z, b.coords.w),
                        vehicleModel = b.vehicleModel,
                        spotId = b.spotId
                    })
                end
            end
        end
    end
    cb(showroomTable)
end)

RegisterNetEvent('qb-vehicleshop:sendRequestText:server', function(sender, target, price, model, dealershipId)
    TriggerClientEvent('qb-vehicleshop:sendRequestText:client', target, sender, price, model, dealershipId)
end)

RegisterNetEvent('qb-vehicleshop:declinePayment:server', function(sender)
    Notify(sender, "Request declined.", 7500, "error")
end)

AddEventHandler('playerDropped', function()
    for k, v in pairs(testVehicles) do
        if v.playerId == source then
            TriggerClientEvent('qb-vehicleshop:deleteVehicle:client', -1, k)
        end
    end
end)

--RegisterNetEvent('qb-vehicleshop:deleteVehicleShowroom:server', function(dealershipId, spotId, newModel, props)
RegisterNetEvent('qb-vehicleshop:deleteVehicleShowroom:server', function(dealershipId, spotId, newModel)
    for _, playerId in ipairs(GetPlayers()) do
        local numPlayerId = tonumber(playerId)
        if numPlayerId ~= source then
            local myPed = GetPlayerPed(numPlayerId)
            local myPedCoords = GetEntityCoords(myPed)
            local dealershipCoords = vector3(Config.VehicleShops[dealershipId].ShowroomVehicles[1].coords.x, Config.VehicleShops[dealershipId].ShowroomVehicles[1].coords.y, Config.VehicleShops[dealershipId].ShowroomVehicles[1].coords.z)
            local dist = #(myPedCoords - dealershipCoords)
            if dist <= 40 then
                --TriggerClientEvent('qb-vehicleshop:deleteVehicleShowroom:client', numPlayerId, dealershipId, spotId, newModel, props)
                TriggerClientEvent('qb-vehicleshop:deleteVehicleShowroom:client', numPlayerId, dealershipId, spotId, newModel, true)
            else
                TriggerClientEvent('qb-vehicleshop:deleteVehicleShowroom:client', numPlayerId, dealershipId, spotId, newModel, false)
            end
        end
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
            veh=v
		end
	end
	return check,veh
end


CreateThread(function()
    local currentTime
    local has,veh
    while true do
        currentTime=os.time()
        for k, v in pairs(testplate) do
            if v and tonumber(currentTime) > tonumber(v.time) then
                has,veh=isVehicleExistInRealLife(v.plate)
                if has then
                    DeleteEntity(veh)
                end
                testplate[k]=nil
            end
        end
        Wait(10000)
    end
end)