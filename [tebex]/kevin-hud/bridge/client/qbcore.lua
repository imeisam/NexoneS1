if GetResourceState('qb-core') ~= 'started' then return end

local QBCore = exports['qb-core']:GetCoreObject()
local nitroLevel = 0
local seatbeltOn = false

function showNotify(text, type)
    QBCore.Functions.Notify(text, type)
end

function getPlayerMetadata()
    hud.hunger = QBCore.Functions.GetPlayerData().metadata.hunger
    hud.thirst = QBCore.Functions.GetPlayerData().metadata.thirst
    hud.stress = QBCore.Functions.GetPlayerData().metadata.stress
end

function getPlayerRadio()
    return LocalPlayer.state.radioChannel or 0
end

function getSeatBeltState()
    return seatbeltOn
end

function getVehicleNitrosLevel(vehicle)
    return nitroLevel
end

function getVehicleFuelLevel(vehicle)
    return exports["qb-fuel"]:GetFuel(vehicle)
end

function getPlayerJob()
    return QBCore.Functions.GetPlayerData().job.name
end

function getPlayerMoney()
    local money = lib.callback.await('kevin-hud:server:getPlayerMoney', false)
    return money
end

RegisterNetEvent('seatbelt:client:ToggleSeatbelt', function() -- Triggered in smallresources
    seatbeltOn = not seatbeltOn
end)

RegisterNetEvent('hud:client:UpdateStress', function(newStress) -- Add this event with adding stress elsewhere
    hud.stress = newStress
end)

RegisterNetEvent('hud:client:UpdateNeeds', function(newHunger, newThirst)
    hud.hunger = newHunger
    hud.thirst = newThirst
end)

RegisterNetEvent('hud:client:UpdateStress', function(newStress)
    hud.stress = newStress
end)

RegisterNetEvent('hud:client:UpdateNitrous', function(nitroLevel, bool)
    nitroLevel = nitroLevel
end)

RegisterNetEvent('qb-admin:client:ToggleDevmode', function()
    hud.devMode = not hud.devMode
end)

AddEventHandler("pma-voice:radioActive", function(radioTalking) usingRadio = radioTalking 
    hud.usingRadio = radioTalking
end)