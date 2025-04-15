local QBCore = nil

Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports[Config.FrameworkPseudo]:GetCoreObject()
    end
end)

function OpenCraftingStash(stashId)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", stashId, {
        maxweight = 4000000,
        slots = Config.Slots,
    })
end