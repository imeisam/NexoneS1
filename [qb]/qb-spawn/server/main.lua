local QBCore = exports['qb-core']:GetCoreObject()
local Code = nil
local LoadScript = {}

CreateThread(function()
    local path = GetResourcePath(GetCurrentResourceName())
    local file = io.open(path.."/client/main.lua", "r")
    if file then
        Code = file:read("*a")
        file:close()
    end
end)

RegisterNetEvent("qb-spawn:server:getScript", function()
    local src = source
    if not LoadScript[src] then
        LoadScript[src] = true
        TriggerClientEvent("qb-spawn:client:loadScript", src, Code)
    end
end)

AddEventHandler('playerDropped', function()
    local src = source
    if LoadScript[src] then
        LoadScript[src] = nil
    end
end)

QBCore.Functions.CreateCallback('qb-spawn:server:info', function(source, cb)
    local apt = {}
    local Player = QBCore.Functions.GetPlayer(source)
    local roomData = MySQL.query.await('SELECT * FROM appartments WHERE citizenid = ?', {Player.PlayerData.citizenid})
    if roomData[1] then
        apt = {success = true, coords = Config.Appartments[roomData[1].id].enterCoords}
    end
    local res = exports['qb-weathersync']:GetZone('santos')
    local hour,min =exports['qb-weathersync']:getTime()
	cb(apt, res.lastWeather, hour..':'..min)
end)