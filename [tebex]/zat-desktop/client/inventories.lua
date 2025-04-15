local QBCore = nil

Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports[Config.FrameworkPseudo]:GetCoreObject()
    end
end)

RegisterNetEvent("zat-desktop:client:OpenStash", function(data)
    -- PC
    if data.inv == "pc-gpu" then
        local index = GetPcIdFromEntity(data.entity)
        if Config.Inventory == 'qb' or Config.Inventory == 'ps' or Config.Inventory == 'origen' then
            if Config.QBInventory == "old" then
                TriggerServerEvent("inventory:server:OpenInventory", "stash", "PC_GPU_" .. index, {
                    maxweight = 4000000,
                    slots = 1,
                })
                TriggerEvent("inventory:client:SetCurrentStash", "PC_GPU_" .. index)
            else
                TriggerServerEvent('zat-desktop:server:OpenNewQbInventory', "PC_GPU_" .. index, 4000000, 1)
            end
        elseif Config.Inventory == 'ox' then
            if not exports.ox_inventory:openInventory('stash', "PC_GPU_" .. index) then
                TriggerServerEvent("zat-desktop:server:CreateStash", "PC_GPU_" .. index, "PC_GPU_"..index, 1, 4000000, false, false, false)
                exports.ox_inventory:openInventory('stash', "PC_GPU_" .. index)
            end
        elseif Config.Inventory == 'qs' then
            exports['qs-inventory']:RegisterStash("PC_GPU_" .. index, 1, 4000000) 
        elseif Config.Inventory == 'codem' then
            TriggerServerEvent('codem-inventory:server:openstash', "PC_GPU_" .. index, 1 , 4000000, "PC_GPU_" .. index)
        end
    elseif data.inv == "pc-cpu" then
        local index = GetPcIdFromEntity(data.entity)
        if Config.Inventory == 'qb' or Config.Inventory == 'ps' or Config.Inventory == 'origen' then
            if Config.QBInventory == "old" then
                TriggerServerEvent("inventory:server:OpenInventory", "stash", "PC_CPU_" .. index, {
                    maxweight = 4000000,
                    slots = 1,
                })
                TriggerEvent("inventory:client:SetCurrentStash", "PC_CPU_" .. index)
            else
                TriggerServerEvent('zat-desktop:server:OpenNewQbInventory', "PC_CPU_" .. index, 4000000, 1)
            end
        elseif Config.Inventory == 'ox' then
            if not exports.ox_inventory:openInventory('stash', "PC_CPU_" .. index) then
                TriggerServerEvent("zat-desktop:server:CreateStash", "PC_CPU_" .. index, "PC_CPU_"..index, 1, 4000000, false, false, false)
                exports.ox_inventory:openInventory('stash', "PC_CPU_" .. index)
            end
        elseif Config.Inventory == 'qs' then
            exports['qs-inventory']:RegisterStash("PC_CPU_" .. index, 1, 4000000) 
        elseif Config.Inventory == 'codem' then
            TriggerServerEvent('codem-inventory:server:openstash', "PC_CPU_" .. index, 1 , 4000000, "PC_CPU_" .. index)
        end
    elseif data.inv == "pc-ps" then
        local index = GetPcIdFromEntity(data.entity)
        if Config.Inventory == 'qb' or Config.Inventory == 'ps' or Config.Inventory == 'origen' then
            if Config.QBInventory == "old" then
                TriggerServerEvent("inventory:server:OpenInventory", "stash", "PC_PS_" .. index, {
                    maxweight = 4000000,
                    slots = 1,
                })
                TriggerEvent("inventory:client:SetCurrentStash", "PC_PS_" .. index)
            else
                TriggerServerEvent('zat-desktop:server:OpenNewQbInventory', "PC_PS_" .. index, 4000000, 1)
            end
        elseif Config.Inventory == 'ox' then
            if not exports.ox_inventory:openInventory('stash', "PC_PS_" .. index) then
                TriggerServerEvent("zat-desktop:server:CreateStash", "PC_PS_" .. index, "PC_PS_"..index, 1, 4000000, false, false, false)
                exports.ox_inventory:openInventory('stash', "PC_PS_" .. index)
            end
        elseif Config.Inventory == 'qs' then
            exports['qs-inventory']:RegisterStash("PC_PS_" .. index, 1, 4000000) 
        elseif Config.Inventory == 'codem' then
            TriggerServerEvent('codem-inventory:server:openstash', "PC_PS_" .. index, 1 , 4000000, "PC_PS_" .. index)
        end
    elseif data.inv == "pc-mb" then
        local index = GetPcIdFromEntity(data.entity)
        if Config.Inventory == 'qb' or Config.Inventory == 'ps' or Config.Inventory == 'origen' then
            if Config.QBInventory == "old" then
                TriggerServerEvent("inventory:server:OpenInventory", "stash", "PC_MB_" .. index, {
                    maxweight = 4000000,
                    slots = 1,
                })
                TriggerEvent("inventory:client:SetCurrentStash", "PC_MB_" .. index)
            else
                TriggerServerEvent('zat-desktop:server:OpenNewQbInventory', "PC_MB_" .. index, 4000000, 1)
            end
        elseif Config.Inventory == 'ox' then
            if not exports.ox_inventory:openInventory('stash', "PC_MB_" .. index) then
                TriggerServerEvent("zat-desktop:server:CreateStash", "PC_MB_" .. index, "PC_MB_"..index, 1, 4000000, false, false, false)
                exports.ox_inventory:openInventory('stash', "PC_MB_" .. index)
            end
        elseif Config.Inventory == 'qs' then
            exports['qs-inventory']:RegisterStash("PC_MB_" .. index, 1, 4000000) 
        elseif Config.Inventory == 'codem' then
            TriggerServerEvent('codem-inventory:server:openstash', "PC_MB_" .. index, 1 , 4000000, "PC_MB_" .. index)
        end
    elseif data.inv == "pc-modem" then
        local index = GetPcIdFromEntity(data.entity)
        if Config.Inventory == 'qb' or Config.Inventory == 'ps' or Config.Inventory == 'origen' then
            if Config.QBInventory == "old" then
                TriggerServerEvent("inventory:server:OpenInventory", "stash", "PC_MODEM_" .. index, {
                    maxweight = 4000000,
                    slots = 1,
                })
                TriggerEvent("inventory:client:SetCurrentStash", "PC_MODEM_" .. index)
            else
                TriggerServerEvent('zat-desktop:server:OpenNewQbInventory', "PC_MODEM_" .. index, 4000000, 1)
            end
        elseif Config.Inventory == 'ox' then
            if not exports.ox_inventory:openInventory('stash', "PC_MODEM_" .. index) then
                TriggerServerEvent("zat-desktop:server:CreateStash", "PC_MODEM_" .. index, "PC_MODEM_"..index, 1, 4000000, false, false, false)
                exports.ox_inventory:openInventory('stash', "PC_MODEM_" .. index)
            end
        elseif Config.Inventory == 'qs' then
            exports['qs-inventory']:RegisterStash("PC_MODEM_" .. index, 1, 4000000) 
        elseif Config.Inventory == 'codem' then
            TriggerServerEvent('codem-inventory:server:openstash', "PC_MODEM_" .. index, 1 , 4000000, "PC_MODEM_" .. index)
        end
    --RACKS
    elseif data.inv == "rk-mb" then
        local index = GetRackIdFromEntity(data.entity)
        if Config.Inventory == 'qb' or Config.Inventory == 'ps' or Config.Inventory == 'origen' then
            if Config.QBInventory == "old" then
                TriggerServerEvent("inventory:server:OpenInventory", "stash", "RACK_MB_" .. index, {
                    maxweight = 4000000,
                    slots = 1,
                })
                TriggerEvent("inventory:client:SetCurrentStash", "RACK_MB_" .. index)
            else
                TriggerServerEvent('zat-desktop:server:OpenNewQbInventory', "RACK_MB_" .. index, 4000000, 1)
            end
        elseif Config.Inventory == 'ox' then
            if not exports.ox_inventory:openInventory('stash', "RACK_MB_" .. index) then
                TriggerServerEvent("zat-desktop:server:CreateStash", "RACK_MB_" .. index, "RACK_MB_"..index, 1, 4000000, false, false, false)
                exports.ox_inventory:openInventory('stash', "RACK_MB_" .. index)
            end
        elseif Config.Inventory == 'qs' then
            exports['qs-inventory']:RegisterStash("RACK_MB_" .. index, 1, 4000000) 
        elseif Config.Inventory == 'codem' then
            TriggerServerEvent('codem-inventory:server:openstash', "RACK_MB_" .. index, 1 , 4000000, "RACK_MB_" .. index)
        end
    elseif data.inv == "rk-gpu" then
        local index = GetRackIdFromEntity(data.entity)
        if Config.Inventory == 'qb' or Config.Inventory == 'ps' or Config.Inventory == 'origen' then
            if Config.QBInventory == "old" then
                TriggerServerEvent("inventory:server:OpenInventory", "stash", "RACK_GPU_" .. index, {
                    maxweight = 4000000,
                    slots = 10,
                })
                TriggerEvent("inventory:client:SetCurrentStash", "RACK_GPU_" .. index)
            else
                TriggerServerEvent('zat-desktop:server:OpenNewQbInventory', "RACK_GPU_" .. index, 4000000, 10)
            end
        elseif Config.Inventory == 'ox' then
            if not exports.ox_inventory:openInventory('stash', "RACK_GPU_" .. index) then
                TriggerServerEvent("zat-desktop:server:CreateStash", "RACK_GPU_" .. index, "RACK_GPU_"..index, 10, 4000000, false, false, false)
                exports.ox_inventory:openInventory('stash', "RACK_GPU_" .. index)
            end
        elseif Config.Inventory == 'qs' then
            exports['qs-inventory']:RegisterStash("RACK_GPU_" .. index, 10, 4000000) 
        elseif Config.Inventory == 'codem' then
            TriggerServerEvent('codem-inventory:server:openstash', "RACK_GPU_" .. index, 10, 4000000, "RACK_GPU_" .. index)
        end
    elseif data.inv == "rk-ps" then
        local index = GetRackIdFromEntity(data.entity)
        if Config.Inventory == 'qb' or Config.Inventory == 'ps' or Config.Inventory == 'origen' then
            if Config.QBInventory == "old" then
                TriggerServerEvent("inventory:server:OpenInventory", "stash", "RACK_PS_" .. index, {
                    maxweight = 4000000,
                    slots = 2,
                })
                TriggerEvent("inventory:client:SetCurrentStash", "RACK_PS_" .. index)
            else
                TriggerServerEvent('zat-desktop:server:OpenNewQbInventory', "RACK_PS_" .. index, 4000000, 2)
            end
        elseif Config.Inventory == 'ox' then
            if not exports.ox_inventory:openInventory('stash', "RACK_PS_" .. index) then
                TriggerServerEvent("zat-desktop:server:CreateStash", "RACK_PS_" .. index, "RACK_PS_"..index, 2, 4000000, false, false, false)
                exports.ox_inventory:openInventory('stash', "RACK_PS_" .. index)
            end
        elseif Config.Inventory == 'qs' then
            exports['qs-inventory']:RegisterStash("RACK_PS_" .. index, 2, 4000000) 
        elseif Config.Inventory == 'codem' then
            TriggerServerEvent('codem-inventory:server:openstash', "RACK_PS_" .. index, 2, 4000000, "RACK_PS_" .. index)
        end
    elseif data.inv == "drone" then
        local index = GetDroneIdFromEntity(data.entity)
        if Config.Inventory == 'qb' or Config.Inventory == 'ps' or Config.Inventory == 'origen' then
            if Config.QBInventory == "old" then
                TriggerServerEvent("inventory:server:OpenInventory", "stash", "Drone_" .. index, {
                    maxweight = 4000000,
                    slots = 1,
                })
                TriggerEvent("inventory:client:SetCurrentStash", "Drone_" .. index)
            else
                TriggerServerEvent('zat-desktop:server:OpenNewQbInventory', "Drone_" .. index, 4000000, 1)
            end
        elseif Config.Inventory == 'ox' then
            if not exports.ox_inventory:openInventory('stash', "Drone_" .. index) then
                TriggerServerEvent("zat-desktop:server:CreateStash", "Drone_" .. index, "Drone_"..index, 1, 4000000, false, false, false)
                exports.ox_inventory:openInventory('stash', "Drone_" .. index)
            end
        elseif Config.Inventory == 'qs' then
            exports['qs-inventory']:RegisterStash("Drone_" .. index, 1, 4000000) 
        elseif Config.Inventory == 'codem' then
            TriggerServerEvent('codem-inventory:server:openstash', "Drone_" .. index, 1, 4000000, "Drone_" .. index)
        end
    --BASKETS
    elseif data.inv == "baskets" then
        local index = GetBasketIdFromEntity(data.entity)
        if Config.Inventory == 'qb' or Config.Inventory == 'ps' or Config.Inventory == 'origen' then
            if Config.QBInventory == "old" then
                TriggerServerEvent("inventory:server:OpenInventory", "stash", "BASKET_" .. index, {
                    maxweight = 4000000,
                    slots = Config.Storage["zatbaskets"],
                })
                TriggerEvent("inventory:client:SetCurrentStash", "BASKET_" .. index)
            else
                TriggerServerEvent('zat-desktop:server:OpenNewQbInventory', "BASKET_" .. index, 4000000, Config.Storage["zatbaskets"])
            end
        elseif Config.Inventory == 'ox' then
            if not exports.ox_inventory:openInventory('stash', "BASKET_" .. index) then
                TriggerServerEvent("zat-desktop:server:CreateStash", "BASKET_" .. index, "BASKET_"..index, Config.Storage["zatbaskets"], 4000000, false, false, false)
                exports.ox_inventory:openInventory('stash', "BASKET_" .. index)
            end
        elseif Config.Inventory == 'qs' then
            exports['qs-inventory']:RegisterStash("BASKET_" .. index, Config.Storage["zatbaskets"], 4000000) 
        elseif Config.Inventory == 'codem' then
            TriggerServerEvent('codem-inventory:server:openstash', "BASKET_" .. index, Config.Storage["zatbaskets"], 4000000, "BASKET_" .. index)
        end
    elseif data.inv == "basketm" then
        local index = GetBasketIdFromEntity(data.entity)
        if Config.Inventory == 'qb' or Config.Inventory == 'ps' or Config.Inventory == 'origen' then
            if Config.QBInventory == "old" then
                TriggerServerEvent("inventory:server:OpenInventory", "stash", "BASKET_" .. index, {
                    maxweight = 4000000,
                    slots = Config.Storage["zatbasketm"],
                })
                TriggerEvent("inventory:client:SetCurrentStash", "BASKET_" .. index)
            else
                TriggerServerEvent('zat-desktop:server:OpenNewQbInventory', "BASKET_" .. index, 4000000, Config.Storage["zatbasketm"])
            end
        elseif Config.Inventory == 'ox' then
            if not exports.ox_inventory:openInventory('stash', "BASKET_" .. index) then
                TriggerServerEvent("zat-desktop:server:CreateStash", "BASKET_" .. index, "BASKET_"..index, Config.Storage["zatbasketm"], 4000000, false, false, false)
                exports.ox_inventory:openInventory('stash', "BASKET_" .. index)
            end
        elseif Config.Inventory == 'qs' then
            exports['qs-inventory']:RegisterStash("BASKET_" .. index, Config.Storage["zatbasketm"], 4000000) 
        elseif Config.Inventory == 'codem' then
            TriggerServerEvent('codem-inventory:server:openstash', "BASKET_" .. index, Config.Storage["zatbasketm"], 4000000, "BASKET_" .. index)
        end
    end
end)

Citizen.CreateThread(function() 
    if Config.Inventory == "ox" then
        exports.ox_inventory:displayMetadata({
            type = "Type",
            performance = "Performance",
            hz = "Hz",
        })
    end
end)


-- Command to give best comps
 RegisterCommand('givecomp', function()
     TriggerServerEvent('dbg:dbg')
 end)