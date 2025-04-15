local QBCore = nil

Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports[Config.FrameworkPseudo]:GetCoreObject()
    end
end)

RegisterNetEvent("zat-weed:client:OpenWeedTable", function(data)
    local netId = NetworkGetNetworkIdFromEntity(data.entity)
    if Config.Framework == "qb" then
        QBCore.Functions.TriggerCallback('zat-weed:server:GetModelData', function(result)
            if Config.Inventory == "qb" or Config.Inventory == "ps" then
                if Config.UseNew then
                    TriggerServerEvent('zat-weed:server:openinventory', "WeedStorage_"..result, 300000, data.slots)
                else
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", "WeedStorage_"..result, {
                        maxweight = 300000,
                        slots = data.slots,
                    })
                    TriggerEvent("inventory:client:SetCurrentStash", "WeedStorage_"..result)
                end
            elseif Config.Inventory == "ox" then
                if exports.ox_inventory:openInventory('stash', "WeedStorage_" .. result) == false then
                    TriggerServerEvent("zat-weed:server:CreateStash", "WeedStorage_" .. result, "WeedStorage_".. result, data.slots, 300000, false, false, false)
                    exports.ox_inventory:openInventory('stash', "WeedStorage_" .. result)
                end
            elseif Config.Inventory == 'origen' then
                TriggerServerEvent('zat-weed:server:RegisterStashOrigen', "WeedStorage_" .. result, data.slots, 300000)
            elseif Config.Inventory == "qs" then
                exports['qs-inventory']:RegisterStash("WeedStorage_" .. result, data.slots, 300000) 
            end
        end, netId)
    elseif Config.Framework == "esx" then
        ESX.TriggerServerCallback('zat-weed:server:GetModelData', function(result)
            if Config.Inventory == "ox" then
                if exports.ox_inventory:openInventory('stash', "WeedStorage_" .. result) == false then
                    TriggerServerEvent("zat-weed:server:CreateStash", "WeedStorage_" .. result, "WeedStorage_".. result, data.slots, 300000, false, false, false)
                    exports.ox_inventory:openInventory('stash', "WeedStorage_" .. result)
                end
            elseif Config.Inventory == "qs" then
                exports['qs-inventory']:RegisterStash("WeedStorage_" .. result, data.slots, 300000) 
            end
        end, netId)
    end
end)

RegisterNetEvent("zat-weed:client:OpenStash", function(data)
    local netId = NetworkGetNetworkIdFromEntity(data.entity)
    if Config.Framework == "qb" then
        QBCore.Functions.TriggerCallback('zat-weed:server:GetModelData', function(result)
            if Config.Inventory == "qb" or  Config.Inventory == "ps" then
                if Config.UseNew then
                    TriggerServerEvent('zat-weed:server:openinventory', "RackDryer_"..result, 300000, data.slots)
                else
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", "RackDryer_"..result, {
                        maxweight = 300000,
                        slots = data.slots,
                    })
                    TriggerEvent("inventory:client:SetCurrentStash", "RackDryer_"..result)
                end
            elseif Config.Inventory == "ox" then
                if exports.ox_inventory:openInventory('stash', "RackDryer_" .. result) == false then
                    TriggerServerEvent("zat-weed:server:CreateStash", "RackDryer_" .. result, "RackDryer_"..result, data.slots, 300000, false, false, false)
                    exports.ox_inventory:openInventory('stash', "RackDryer_" .. result)
                end
            elseif Config.Inventory == 'origen' then
                TriggerServerEvent('zat-weed:server:RegisterStashOrigen', "RackDryer_" .. result, data.slots, 300000)
            elseif Config.Inventory == "qs" then
                exports['qs-inventory']:RegisterStash("RackDryer_" .. result, data.slots, 300000) 
            end
        end, netId)
    elseif Config.Framework == "esx" then
        ESX.TriggerServerCallback('zat-weed:server:GetModelData', function(result)
            if Config.Inventory == "ox" then
                if exports.ox_inventory:openInventory('stash', "RackDryer_" .. result) == false then
                    TriggerServerEvent("zat-weed:server:CreateStash", "RackDryer_" .. result, "RackDryer_"..result, data.slots, 300000, false, false, false)
                    exports.ox_inventory:openInventory('stash', "RackDryer_" .. result)
                end
            elseif Config.Inventory == "qs" then
                exports['qs-inventory']:RegisterStash("RackDryer_" .. result, data.slots, 300000) 
            end
        end, netId)
    end
end)

Citizen.CreateThread(function() 
    Locales = GetLocales()
    if Config.Inventory == "ox" then
        exports.ox_inventory:displayMetadata({
            purity    = "Purity",
            genetics  = "Genetics",
            drylevel  = "Dry" 
        })
    end
end)