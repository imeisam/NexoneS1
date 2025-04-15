Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports[Config.FrameworkPseudo]:GetCoreObject()
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

function TransferCrypto(src, amount)
    if Config.Framework == "qb" then
        local Player = QBCore.Functions.GetPlayer(src)
        if Config.EnableQbCrypto then
            Player.Functions.AddMoney('crypto', amount)
        else
            Player.Functions.AddMoney('bank', amount)
        end
    elseif Config.Framework == "esx" then
        local Player = ESX.GetPlayerFromId(src)
        Player.addAccountMoney('bank', amount, "Wally")
    end
end

RegisterNetEvent("zat-debug:server:giveitems", function()
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src)
    local info = {
        type = "XTR-4090",
        performance = 100,
        hz = 2.4,
    }
    if Config.Inventory == 'qb' then
        Player.Functions.AddItem("zatgpu", 10, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['zatgpu'], "add")
    elseif Config.Inventory == 'ox' then
        exports.ox_inventory:AddItem(src, "zatgpu", 10, info)
    elseif Config.Inventory == 'qs' then
        exports['qs-inventory']:AddItem(src, "zatgpu", 10, nil, info)
    end
    local info = {
        type = "NEZYR7-7950",
        performance = 100
    }
    if Config.Inventory == 'qb' then
        Player.Functions.AddItem("zatcpu", 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['zatcpu'], "add")
    elseif Config.Inventory == 'ox' then
        exports.ox_inventory:AddItem(src, "zatcpu", 1, info)
    elseif Config.Inventory == 'qs' then
        exports['qs-inventory']:AddItem(src, "zatcpu", 1, nil, info)
    end

    local info = {
        type = "ETYBAGIG-B650E",
        performance = 100
    }
    if Config.Inventory == 'qb' then
        Player.Functions.AddItem("zatmb", 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['zatmb'], "add")
    elseif Config.Inventory == 'ox' then
        exports.ox_inventory:AddItem(src, "zatmb", 1, info)
    elseif Config.Inventory == 'qs' then
        exports['qs-inventory']:AddItem(src, "zatmb", 1, nil, info)
    end

    local info = {
        type = "RIASROC-RM750X",
        performance = 100
    }
    if Config.Inventory == 'qb' then
        Player.Functions.AddItem("zatps", 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['zatps'], "add")
    elseif Config.Inventory == 'ox' then
        exports.ox_inventory:AddItem(src, "zatps", 1, info)
    elseif Config.Inventory == 'qs' then
        exports['qs-inventory']:AddItem(src, "zatps", 1, nil, info)
    end

    if Config.Inventory == 'qb' then
        Player.Functions.AddItem("zatmodem", 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['zatmodem'], "add")
    elseif Config.Inventory == 'ox' then
        exports.ox_inventory:AddItem(src, "zatmodem", 1)
    elseif Config.Inventory == 'qs' then
        exports['qs-inventory']:AddItem(src, "zatmodem", 1, nil)
    end
end)