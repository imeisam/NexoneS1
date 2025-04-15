
local ver = '1.0.0'

CreateThread(function()
    if GetResourceState(GetCurrentResourceName()) == 'started' then
        print('DRC_GARDENER STARTED ON VERSION: ' .. ver)
    end
end)

local function AutoDetectFramework()
    if GetResourceState("es_extended") == "started" then
        return "ESX"
    elseif GetResourceState("qb-core") == "started" then
        return "qbcore"
    else
        return "standalone"
    end
end

if Config.Framework == "auto-detect" then
    Config.Framework = AutoDetectFramework()
end

 if Config.Framework == "ESX" then
    if Config.NewESX then
        ESX = exports["es_extended"]:getSharedObject()
    else
        ESX = nil
        CreateThread(function()
            while ESX == nil do
                TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
                Wait(100)
            end
        end)
    end
elseif Config.Framework == "qbcore" then
    QBCore = nil
    QBCore = exports["qb-core"]:GetCoreObject()

elseif Config.Framework == "standalone" then
    -- ADD YOU FRAMEWORK
end 


function AddMoney(count, source)
    if Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addMoney(count)
    elseif Config.Framework == "qbcore" then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        xPlayer.Functions.AddMoney('cash', count)
    elseif Config.Framework == "standalone" then
        -- ADD YOUR FRAMEWORK
    end
end

function GetPlayerFromId(source)
    if Config.Framework == 'ESX' then
        return ESX.GetPlayerFromId(source)
    elseif Config.Framework == 'qbcore' then
        QBCore = exports['qb-core']:GetCoreObject()
        return QBCore.Functions.GetPlayer(source)
    end
    -- and so on for each framework
end

function GetIdent(source)
    if Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(source)
        return xPlayer.getIdentifier()
    elseif Config.Framework == "qbcore" then
        QBCore = exports['qb-core']:GetCoreObject()
        return QBCore.Functions.GetIdentifier(source, 'license')
    end
end
