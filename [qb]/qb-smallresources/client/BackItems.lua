local BackItems = {
    --default weapon
    ["weapon_smg"] = {
        model="w_sb_smg",
        back_bone = 24818,
        x = 0.115,
        y = -0.167,
        z = 0.1,
        x_rotation = 0.0,
        y_rotation = 0.0,
        z_rotation = 0.0,
    },
    ["weapon_assaultsmg"] = {
        model="w_sb_assaultsmg",
        back_bone = 24818,
        x = 0.115,
        y = -0.167,
        z = 0.1,
        x_rotation = 0.0,
        y_rotation = 0.0,
        z_rotation = 0.0,
    },
    ["weapon_combatpdw"] = {
        model="w_sb_pdw",
        back_bone = 24818,
        x = 0.115,
        y = -0.167,
        z = 0.1,
        x_rotation = 0.0,
        y_rotation = 0.0,
        z_rotation = 0.0,
    },
    ["weapon_pumpshotgun_mk2"] = {
        model="w_sg_pumpshotgunmk2",
        back_bone = 24818,
        x = 0.115,
        y = -0.167,
        z = 0.1,
        x_rotation = 0.0,
        y_rotation = 0.0,
        z_rotation = 0.0,
    },
    ["weapon_pumpshotgun"] = {
        model="w_sg_pumpshotgun",
        back_bone = 24818,
        x = 0.115,
        y = -0.167,
        z = 0.1,
        x_rotation = 0.0,
        y_rotation = 0.0,
        z_rotation = 0.0,
    },
    ["weapon_carbinerifle"] = {
        model="w_ar_carbinerifle",
        back_bone = 24818,
        x = 0.115,
        y = -0.167,
        z = 0.1,
        x_rotation = 0.0,
        y_rotation = 0.0,
        z_rotation = 0.0,
    },
    ["weapon_assaultshotgun"] = {
        model="w_sg_assaultshotgun",
        back_bone = 24818,
        x = 0.115,
        y = -0.167,
        z = 0.1,
        x_rotation = 0.0,
        y_rotation = 0.0,
        z_rotation = 0.0,
    },
    ["weapon_carbinerifle_mk2"] = {
        model="w_ar_carbineriflemk2",
        back_bone = 24818,
        x = 0.115,
        y = -0.167,
        z = 0.1,
        x_rotation = 0.0,
        y_rotation = 0.0,
        z_rotation = 0.0,
    },
    ["weapon_specialcarbine_mk2"] = {
        model="w_ar_specialcarbinemk2",
        back_bone = 24818,
        x = 0.115,
        y = -0.167,
        z = 0.1,
        x_rotation = 0.0,
        y_rotation = 0.0,
        z_rotation = 0.0,
    },
    ["weapon_marksmanrifle_mk2"] = {
        model="w_sr_marksmanriflemk2",
        back_bone = 24818,
        x = 0.115,
        y = -0.167,
        z = 0.1,
        x_rotation = 0.0,
        y_rotation = 0.0,
        z_rotation = 0.0,
    },
    ["weapon_heavysniper_mk2"] = {
        model="w_sr_heavysnipermk2",
        back_bone = 24818,
        x = 0.115,
        y = -0.167,
        z = 0.1,
        x_rotation = 0.0,
        y_rotation = 0.0,
        z_rotation = 0.0,
    },
}

local QBCore = exports['qb-core']:GetCoreObject()
local CurrentBackItems = {}
local TempBackItems = {}
local checking = false
local currentWeapon = nil
local slots = QBCore.Config.Player.MaxInvSlots + QBCore.Config.Player.BackPackSlot
local s = {}

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then return end
    resetItems()
end)

RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
    resetItems()
end)

RegisterNetEvent("backitems:displayItems", function(toggle)
    if toggle then
        SetTimeout(2000, function()
            for k,v in pairs(TempBackItems) do
                createBackItem(k)
            end
            BackLoop()
        end)
    else
        TempBackItems = CurrentBackItems
        checking = false
        for k,v in pairs(CurrentBackItems) do
            removeBackItem(k)
        end
        CurrentBackItems = {}
    end
end)

function resetItems()
    removeAllBackItems()
    CurrentBackItems = {}
    TempBackItems = {}
    currentWeapon = nil
    s = {}
    checking = false
end

function BackLoop()
    if checking then return end
    checking = true
    CreateThread(function()
        while checking do
            local player = QBCore.Functions.GetPlayerData()
            while player == nil do
                player = QBCore.Functions.GetPlayerData()
                Wait(500)
            end
            for i = 1, slots do
                s[i] = player.items[i]
            end
            check()
            Wait(1000)
        end
    end)
end

function check()
    for i = 1, slots do
        if s[i] ~= nil then
            local name = s[i].name
            if BackItems[name] then
                if name ~= currentWeapon then
                    createBackItem(name)
                end
            end
        end
    end
    for k,v in pairs(CurrentBackItems) do 
        local hasItem = false
        for j = 1, slots do
            if s[j] ~= nil then
                local name = s[j].name
                if name == k then 
                    hasItem = true
                end
            end
        end
        if not hasItem then 
            removeBackItem(k)
        end
    end
end

function createBackItem(item)
    if not CurrentBackItems[item] then
        if BackItems[item] then
            local i = BackItems[item]
            local model = GetHashKey(i["model"])
            local ped = PlayerPedId()
            local bone = GetPedBoneIndex(ped, i["back_bone"])
            RequestModel(model)
            while not HasModelLoaded(model) do
                RequestModel(model)
                Wait(10)
            end
            CurrentBackItems[item] = CreateObject(model, 1.0, 1.0, 1.0, true, true, false)
            local y = i["y"]
            if QBCore.Functions.GetPlayerData().charinfo.gender == 1 then y = y + 0.035 end
            AttachEntityToEntity(CurrentBackItems[item], ped, bone, i["x"] - 0.1, y, i["z"], i["x_rotation"], i["y_rotation"], i["z_rotation"], 0, 1, 0, 1, 0, 1)
            SetEntityCompletelyDisableCollision(CurrentBackItems[item], false, true)	
            SetEntityNoCollisionEntity(CurrentBackItems[item], true, false)
            SetModelAsNoLongerNeeded(model)
	    end
    end
end

function removeBackItem(item)
    if CurrentBackItems[item] then
        DeleteEntity(CurrentBackItems[item])
        CurrentBackItems[item] = nil
    end
end

function removeAllBackItems()
    for k,v in pairs(CurrentBackItems) do 
        removeBackItem(k)
    end
end

RegisterNetEvent('weapons:client:SetCurrentWeapon', function(weap)
    if weap == nil then
        createBackItem(currentWeapon)
        currentWeapon = nil
    else
        if currentWeapon ~= nil then
            createBackItem(currentWeapon)
            currentWeapon = nil
        end
        currentWeapon = tostring(weap.name)
        removeBackItem(currentWeapon)
    end
end)