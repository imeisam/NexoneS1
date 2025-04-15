local QBCore = exports['qb-core']:GetCoreObject()
local Do = {}

QBCore.Commands.Add('resetbobcat', 'Reset Bobcat Robbery', {}, false, function(source)
    Do = {}
    for k,v in ipairs(Config.loot) do
        Config.loot = true
    end
    Do['boom'] = nil
    TriggerClientEvent('qb-bobcat:client:resetBobcat', source, true)
    TriggerClientEvent('qb-bobcat:client:resetBobcat', -1, false)
end, 'god')

QBCore.Functions.CreateUseableItem("security_card", function(source, item)
    if Do['Thermitetwo'] then
        TriggerClientEvent("qb-bobcat:client:firstCard", source)
    end
end)

QBCore.Functions.CreateCallback('qb-bobcat:server:checkState', function(source, cb, which)
	cb(Do[which])
end)

QBCore.Functions.CreateCallback('qb-bobcat:client:getLoots', function(source, cb)
	cb(Config.loot)
end)

RegisterNetEvent("qb-bobcat:server:state", function(which, state)
    Do[which] = state
end)

RegisterNetEvent("qb-bobcat:server:particle", function(coords, slot)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem('thermite', 1, slot)
    TriggerClientEvent("qb-bobcat:client:particle", -1, coords)
end)

RegisterNetEvent("qb-bobcat:server:boom", function()
    if not Do['FirstCard'] then return end
    if not Do['boom'] then
        Do['FirstCard'] = nil
        Do['boom'] = true
        TriggerClientEvent("qb-bobcat:client:boom", -1)
    end
end)

local max = math.random(2, 3)
local ItemTable = {
    "weapon_heavypistol",
    "weapon_pistol50",
    "heavyarmor",
}

RegisterNetEvent("qb-bobcat:server:collectWeapon", function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local k = data.location
    if not Do['boom'] then return end
    if not Config.loot[k] then TriggerClientEvent('QBCore:Notify', src, "This Table Has Been Looted.", "error") return end
    Config.loot[k] = false
    TriggerClientEvent('qb-bobcat:client:removeLoot', -1, k)
    for i=1, max, 1 do
        local randItem = ItemTable[math.random(1, #ItemTable)]
        Player.Functions.AddItem(randItem, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randItem], 'add', 1)
        TriggerEvent('qb-log:server:CreateLog', 'bobcat', 'Bobcat Robbery', 'green', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.citizenid .. ') Successfully Robbed Table Num '..k..' and got '..QBCore.Shared.Items[randItem].label..' - Reward Random Amount: '..i..'/'..max)
        TriggerEvent('qb-log:server:CreateLog', 'robberylost', 'Bobcat Robbery', 'red', 'Lost: '..QBCore.Shared.Items[randItem].label..' on Table '..k)
        Wait(500)
    end
end)