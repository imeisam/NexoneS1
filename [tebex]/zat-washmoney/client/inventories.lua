Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports['qb-core']:GetCoreObject()
    end
end)

function OpenWashMachineStash(stashId)
    if Config.Framework == "qb" then 
        if Config.Inventory == "qb" or  Config.Inventory == "origen" or  Config.Inventory == "ps" then
            if Config.QBInventory == "old" then
                TriggerServerEvent("inventory:server:OpenInventory", "stash", stashId, {
                    maxweight = Config.WashMachinehWeight,
                    slots = 1,
                })
                TriggerEvent("inventory:client:SetCurrentStash", stashId)
            else
                TriggerServerEvent('zat-washmoney:server:OpenNewQbInventory', stashId, 4000000, 1)
            end
        elseif Config.Inventory == "ox" then
            if exports.ox_inventory:openInventory('stash', stashId) == false then
                TriggerServerEvent("zat-washmoney:server:CreateStash", stashId, "Storage", 1, 4000000, false, false, false)
                exports.ox_inventory:openInventory('stash', stashId)
            end
        elseif Config.Inventory == "qs" then
            local other = {}
            other.maxweight = 4000000 -- Custom weight statsh
            other.slots = 1 -- Custom slots spaces
            TriggerServerEvent("inventory:server:OpenInventory", "stash", stashId, other)
            TriggerEvent("inventory:client:SetCurrentStash", stashId)
        end
    elseif Config.Framework == "esx" then
        if Config.Inventory == "ox" then
            if exports.ox_inventory:openInventory('stash', stashId) == false then
                TriggerServerEvent("zat-washmoney:server:CreateStash", stashId, "Storage", 1, 4000000, false, false, false)
                exports.ox_inventory:openInventory('stash', stashId)
            end
        elseif Config.Inventory == "qs" then
            local other = {}
            other.maxweight = 4000000 -- Custom weight statsh
            other.slots = 1 -- Custom slots spaces
            TriggerServerEvent("inventory:server:OpenInventory", "stash", stashId, other)
            TriggerEvent("inventory:client:SetCurrentStash", stashId)
        end
    end
end