local QBCore = exports["qb-core"]:GetCoreObject()
local LoadSQL = false
local whPlates = {}

local function GeneratePlate()
    local plate = 'RENT'..QBCore.Shared.RandomInt(2)..QBCore.Shared.RandomStr(2)
    local result = MySQL.scalar.await('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    if result then
        return GeneratePlate()
    else
        return plate:upper()
    end
end

RegisterNetEvent('qb-rental:sv:rentVehicle', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cid = Player.PlayerData.citizenid
    if data.payType == "cash" then
        if Player.Functions.GetMoney(data.payType) >= data.carPrice then
            Player.Functions.RemoveMoney('cash', data.carPrice, 'cash transfer')
            local plate = GeneratePlate()
            whPlates[src] = plate
            TriggerClientEvent('qb-rental:cl:spawnVehicle', src, data.carName, data.carDay, plate)
            TriggerClientEvent('QBCore:Notify', src,'Purchase transaction successful', 'success')
        else
            TriggerClientEvent('QBCore:Notify', src,'You dont have enough funds', 'error')

        end
    else     
        if Player.PlayerData.money.bank >= data.carPrice then
            Player.Functions.RemoveMoney('bank', data.carPrice,'Rent Car')
            local plate = GeneratePlate()
            whPlates[src] = plate
            TriggerClientEvent('qb-rental:cl:spawnVehicle', src, data.carName, data.carDay, plate)
            TriggerClientEvent('QBCore:Notify', src,'Purchase transaction successful', 'success')
        else
            TriggerClientEvent('QBCore:Notify', src,'You dont have enough funds', 'error')
        end
    end

end)

RegisterNetEvent('qb-rental:sv:updatesql', function(plate,vehicle,time)
    local src = source
    if whPlates[src] and whPlates[src] == plate then
        whPlates[src] = nil
        local Player = QBCore.Functions.GetPlayer(src)
        local timeinday = time * 86400
        local endtime = tonumber(os.time() + timeinday)
        local timeTable = os.date('*t', endtime)
        MySQL.insert('INSERT INTO player_vehicles ( citizenid, vehicle, hash, mods, plate, garage, state) VALUES ( ?, ?, ?, ?, ?, ?, ?)', {
            Player.PlayerData.citizenid,
            vehicle,
            GetHashKey(vehicle),
            '{}',
            plate,
            'pillboxgarage',
            0
        })
        TriggerEvent('qb-log:server:CreateLog', 'rentalveh', 'Rental Vehicle', 'green', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname..' ('..Player.PlayerData.citizenid..')\nVehicle: '..QBCore.Shared.Vehicles[vehicle].name..'\nTime: '..time..' Day')

        MySQL.insert('INSERT INTO rentvehs (citizenid, vehicle, plate, time) VALUES (?, ?, ?, ?)', {Player.PlayerData.citizenid, vehicle, plate, endtime})
        TriggerClientEvent('QBCore:Notify', src, "you successfly rent this car until "..timeTable['day'].." / "..timeTable['month'].." / "..timeTable['year'], "success")
    end
end)

MySQL.ready(function()
	LoadSQL = true
end)

CreateThread(function()
    while not LoadSQL do
        Wait(1000)
    end
    while true do
        local sqlresult = MySQL.Sync.fetchAll('SELECT citizenid, vehicle, plate, time FROM rentvehs', {})
        local currentTime = os.time()
        for _, row in pairs(sqlresult) do
            local citizenid = tonumber(row.citizenid)
            local timeInDB = tonumber(row.time)
            local timeTable = os.date('*t', timeInDB)
            if tonumber(currentTime) > tonumber(timeInDB) then
                MySQL.Sync.execute('DELETE FROM player_vehicles WHERE plate = ?', {row.plate})
                Wait(100)
                MySQL.Sync.execute('DELETE FROM rentvehs WHERE plate = ?', {row.plate})
                Wait(100)
                MySQL.Sync.execute('DELETE FROM trunkitems WHERE plate = ?', {row.plate})
                Wait(100)
                MySQL.Sync.execute('DELETE FROM gloveboxitems WHERE plate = ?', {row.plate})
            end
        end
        Wait(300000)
    end
end)

-- RegisterCommand('showtime', function(source, args)
--     local test=os.time()+args[1]
--     local timeTable = os.date('*t', os.time())
--     print(timeTable["year"].."/"..timeTable["month"].."/"..timeTable["day"].."  - "..timeTable["hour"]..":"..timeTable["min"]) 
--     timeTable = os.date('*t', test)
--     print(timeTable["year"].."/"..timeTable["month"].."/"..timeTable["day"].."  - "..timeTable["hour"]..":"..timeTable["min"]) 
-- end)