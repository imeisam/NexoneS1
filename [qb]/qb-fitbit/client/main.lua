local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local isLoggedIn = LocalPlayer.state.isLoggedIn
local hasFitbit = false
local cooldown = false
local falert = 0
local talert = 0

-- Functions

local function openWatch()
    SendNUIMessage({
        action = "openWatch",
        watchData = {}
    })
    SetNuiFocus(true, true)
end

local function closeWatch()
    SetNuiFocus(false, false)
end

local function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

local function activateCooldown()
    cooldown = true
    Wait(2*60*1000)
    cooldown = false
end
-- Events

AddStateBagChangeHandler('isLoggedIn', nil, function(_, _, value)
    isLoggedIn = value
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    if not hasFitbit then return end
    local hasFB = false
    for _, item in pairs(val.items) do
        if item.name == "fitbit" then
            hasFB = true
            break
        end
    end
    if not hasFB then
        hasFitbit = false
    end
end)

RegisterNetEvent('hud:client:UpdateNeeds', function(newHunger, newThirst)
    if not hasFitbit or cooldown then return end
    if falert and falert > 0 then
        if newHunger < falert then
            TriggerEvent("chatMessage", Lang:t('info.fitbit'), "error", Lang:t('warning.hunger_warning', {hunger = round(newHunger, 2)}))
            PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
        end
    end
    if talert and talert > 0 then
        if newThirst < talert then
            TriggerEvent("chatMessage", Lang:t('info.fitbit'), "error", Lang:t('warning.thirst_warning', {thirst = round(newThirst, 2)}))
            PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
        end
    end
    activateCooldown()
end)

RegisterNetEvent('qb-fitbit:use', function()
    hasFitbit = true
    openWatch()
end)

-- NUI Callbacks

RegisterNUICallback('close', function(_, cb)
    closeWatch()
    cb('ok')
end)

RegisterNUICallback('setFoodWarning', function(data, cb)
    local foodValue = tonumber(data.value)
    falert = foodValue
    QBCore.Functions.Notify(Lang:t('success.hunger_set', {hungervalue = foodValue}), 'success')
    cb('ok')
end)

RegisterNUICallback('setThirstWarning', function(data, cb)
    local thirstValue = tonumber(data.value)
    talert = thirstValue
    QBCore.Functions.Notify(Lang:t('success.thirst_set', {thirstvalue = thirstValue}), 'success')
    cb('ok')
end)