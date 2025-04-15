local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-apartments:server:EnterHouse', function(notSpawn)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        MySQL.query('SELECT * FROM appartments WHERE `citizenid` = @citizenid;', {['citizenid'] = Player.PlayerData.citizenid}, function(resault)
            if resault[1] then
                TriggerClientEvent('qb-apartments:client:EnterHouse', src, resault[1].id, notSpawn)
            else
                local count = 1
                local aparts = MySQL.query.await("SELECT * FROM `appartments`", {})
                if aparts[1] ~= nil then
                    for _, value in pairs(aparts) do
                        count = count + 1
                    end
                end
                if not Config.Appartments[count] then
                    local max = #Config.Appartments
                    while count > max do
                        count = count - max
                        Wait(1)
                    end
                end
                MySQL.Async.insert('INSERT INTO appartments (citizenid, id) VALUES (:citizenid, :id)', {
                    ['citizenid'] = Player.PlayerData.citizenid,
                    ['id'] = count
                })
                TriggerClientEvent('qb-apartments:client:EnterHouse', src, count)
            end
        end)
    end
end)

RegisterNetEvent('qb-apartments:server:SetInsideMeta', function(insideId, bool)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if bool then
        Player.Functions.SetMetaData("inapartment", true)
        QBCore.Functions.SetPlayerBucket(src, src)
    else
        Player.Functions.SetMetaData("inapartment", false)
        QBCore.Functions.SetPlayerBucket(src, 0)
    end
end)