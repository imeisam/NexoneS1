Utils = {}

local ver = '1.5.0'

CreateThread(function()
    if GetResourceState(GetCurrentResourceName()) == 'started' then
        print('DRC_ELECTRICIAN STARTED ON VERSION: ' .. ver)
    end
end)

local function AutoDetectFramework()
    if GetResourceState("es_extended") == "started" then
        return "esx"
    elseif GetResourceState("qb-core") == "started" then
        return "qbcore"
    else
        return "standalone"
    end
end

if Config.Framework == "auto-detect" then
    Config.Framework = AutoDetectFramework()
end

if Config.Framework == "esx" then
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

function GetPlayerFromId(source)
    if Config.Framework == 'esx' then
        return ESX.GetPlayerFromId(source)
    elseif Config.Framework == 'qbcore' then
        QBCore = exports['qb-core']:GetCoreObject()
        return QBCore.Functions.GetPlayer(source)
    end
    -- and so on for each framework
end

function GetIdent(source)
    if Config.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(source)
        return xPlayer.getIdentifier()
    elseif Config.Framework == "qbcore" then
        QBCore = exports['qb-core']:GetCoreObject()
        return QBCore.Functions.GetIdentifier(source, 'license')
    end
end


function AddMoney(count, source)
    if Config.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addMoney(count)
    elseif Config.Framework == "qbcore" then
            local xPlayer = QBCore.Functions.GetPlayer(source)
            if xPlayer then
                --xPlayer.Functions.AddItem('cash', count)
                xPlayer.Functions.AddMoney('cash', count)
            end
    elseif Config.Framework == "standalone" then
        -- ADD YOUR FRAMEWORK
    end
end