QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback("nyxradar:server:checkplate",function(source, cb,plate)
    local result = MySQL.query.await("select plate from drx_mdt_bolos where date>=?", {os.time()*1000})
    cb(result)
end)