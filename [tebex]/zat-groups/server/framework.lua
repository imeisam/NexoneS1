local QBCore = nil
local ESX = nil
Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports[Config.FrameworkPseudo]:GetCoreObject()
    elseif Config.Framework == "esx" then
        ESX = exports['es_extended']:getSharedObject()
    end
end)

function RegisterServerCallback(name, cb)
    if Config.Framework == "qb" then
         QBCore.Functions.CreateCallback(name, cb)
    elseif Config.Framework == "esx" then
        ESX.RegisterServerCallback(name, cb)
    end
end

function NotifyServerFramework(src, text, type)
    if Config.Framework == "qb" then
        TriggerClientEvent('QBCore:Notify', src, text, type) 
    elseif Config.Framework == "esx" then
        TriggerClientEvent("esx:showNotification", src, text, type) 
    end
end

function GetMyData(src)
    local done = false
    local retval = {
        cid = nil,
        lastname = nil,
        firstname = nil
    }
    if Config.Framework == "qb" then
        local Player = QBCore.Functions.GetPlayer(src)
        retval.cid  = Player.PlayerData.citizenid
        retval.firstname = Player.PlayerData.charinfo.firstname
        retval.lastname = Player.PlayerData.charinfo.lastname
        done = true
    elseif Config.Framework == "esx" then
        local Player = ESX.GetPlayerFromId(src)
        local identifier = Player.identifier
        MySQL.single("SELECT firstname, lastname, dateofbirth, id FROM users WHERE identifier = ?", { identifier }, function(result)
            retval.cid  = result.id
            retval.firstname  = result.firstname
            retval.lastname = result.lastname  
            done = true      
        end) 
    end    
    while not done do
        Citizen.Wait(200)
    end
    return (retval)
end