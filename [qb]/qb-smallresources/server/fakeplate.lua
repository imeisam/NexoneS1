local QBCore = exports['qb-core']:GetCoreObject()
local FakePlates = {}

local function GeneratePlate()
    local plate = QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(2)
    local result = MySQL.scalar.await('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    if result then
        return GeneratePlate()
    else
        return plate:upper()
    end
end

local function HasFakePlate(plate)
    if FakePlates[plate] then
        return{bool = true, plate = FakePlates[plate].plate}
    else
        return{bool = false, plate = nil}
    end
end exports('HasFakePlate', HasFakePlate)

local function GetFakePlates()
    return FakePlates
end exports('GetFakePlates', GetFakePlates)

QBCore.Commands.Add("removefakeplate", "Remove Fake Plate From Vehicle", {}, false, function(source)
    TriggerClientEvent('qb-fakeplate:client:remove', source)
end)

QBCore.Functions.CreateUseableItem('fake_plate', function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    local plate = nil
    if item.info == nil or item.info.plate == nil then
        plate = GeneratePlate()
        Player.PlayerData.items[item.slot].info = {}
        Player.PlayerData.items[item.slot].info.plate = GeneratePlate()
        Player.Functions.SetInventory(Player.PlayerData.items)
    else
        plate = item.info.plate
    end
    TriggerClientEvent('qb-fakeplate:client:use', source, plate, item.slot)
end)

QBCore.Functions.CreateCallback('qb-fakeplate:cb:remove', function(source, cb, plate)
    cb(HasFakePlate(plate))
end)

RegisterNetEvent('qb-fakeplate:server:done', function(plate, oldPlate, slot)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Player.PlayerData.items[slot]
    if item and item.name == 'fake_plate' then
        local quality = ((item.info and item.info.quality) and item.info.quality or 100) - 34
        if quality < 0 then quality = 0 end
        FakePlates[plate] = {quality = quality, plate = oldPlate}
        Player.Functions.RemoveItem('fake_plate', 1, slot)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fake_plate'], 'remove', 1)
    else
        TriggerClientEvent('QBCore:Notify', src, 'Something went wrong, report sends to admins for check your action', 'error')
        TriggerEvent('qb-log:server:CreateLog', 'fakeplate', 'Glitch', 'red', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname..' ('..Player.PlayerData.citizenid..') Does not have Fake Plate Item', true)
    end
end)

RegisterNetEvent('qb-fakeplate:server:remove', function(plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if FakePlates[plate] then
        Player.Functions.AddItem('fake_plate', 1, nil, {quality = FakePlates[plate].quality, plate = plate})
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fake_plate'], 'add', 1)
        FakePlates[plate] = nil
    end
end)