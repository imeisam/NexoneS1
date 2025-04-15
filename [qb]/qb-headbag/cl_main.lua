local QBCore = exports['qb-core']:GetCoreObject()
local HeadBag = false;
local Object = nil

local function hasGooni()
    CreateThread(function()
        while HeadBag do
            Wait(5)
            DisableControlAction(0, 199, true)
            DisableControlAction(0, 200, true)
        end
    end)
end

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    local player = QBCore.Functions.GetPlayerData()
    if player.metadata["gooni"] then
        TriggerEvent('qb-headbag:client:getBag')
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    TriggerEvent("qb-headbag:client:removeBag")
end)

RegisterNetEvent('qb-headbag:client:removeBag', function()
    if Object then
        DeleteEntity(Object)
        Object = nil
    end
    SendNUIMessage({action = "remove"})
    HeadBag = false
end)

RegisterNetEvent("qb-headbag:client:getBag", function()
    Object = CreateObject(GetHashKey("prop_money_bag_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(Object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 12844), 0.2, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
    SetEntityCompletelyDisableCollision(Object, false, true)
    SendNUIMessage({action = "open"})
    HeadBag = true
    hasGooni()
end)

RegisterNetEvent("qb-headbag:client:useBag", function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerPed = GetPlayerPed(player)
        local playerId = GetPlayerServerId(player)
        if not IsPedInAnyVehicle(playerPed) and not IsPedInAnyVehicle(PlayerPedId()) then
            TriggerServerEvent("qb-headbag:server:useBag", playerId)
        end
    end
end)