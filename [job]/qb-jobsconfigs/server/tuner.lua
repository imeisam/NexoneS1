QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("qb-jobs:server:rentvehicle", function(veh,stateid)
    local src = source
    local OtherPly = QBCore.Functions.GetPlayerByCitizenId(tostring(stateid))
    if OtherPly then
        local timeinday = 3 * 3600 
        local endtime = tonumber(os.time() + timeinday)
        local plate="RACE"..math.random(1111,9999)
        MySQL.insert('INSERT INTO player_vehicles ( citizenid, vehicle, hash, mods, plate, garage, state) VALUES ( ?, ?, ?, ?, ?, ?, ?)', {
            OtherPly.PlayerData.citizenid,
            veh,
            GetHashKey(veh),
            '{}',
            plate,
            'pillboxgarage',
            0
        })

        -- TriggerEvent('qb-log:server:CreateLog', 'rentalveh', 'Rental Vehicle', 'green', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname..' ('..Player.PlayerData.citizenid..')\nVehicle: '..QBCore.Shared.Vehicles[vehicle].name..'\nTime: '..time..' Day')

        MySQL.insert('INSERT INTO rentvehs (citizenid, vehicle, plate, time) VALUES (?, ?, ?, ?)', {OtherPly.PlayerData.citizenid, veh, plate, endtime})

        TriggerClientEvent('qb-jobs:client:rentvehicle', src,veh,stateid,plate)
    else
        TriggerClientEvent('QBCore:Notify', src, "Stateid Not Valid", "error")
    end
end)

QBCore.Commands.Add("getostime", "", {}, true, function(source, args)
   print(os.time())
end)