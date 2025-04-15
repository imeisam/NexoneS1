local QBCore = exports['qb-core']:GetCoreObject()

function isMarshal()
    if LocalPlayer.state.isLoggedIn and QBCore.Functions.GetPlayerData().job.dep == 'marshal' then
        return true
    end
    return false
end

CreateThread(function()
    exports['qb-interact']:AddInteraction({
        coords = vector3(359.74612426758, -1594.1760253906, 29.294551849365),
        distance = 2.0,
        interactDst = 1.5, 
        id = "marshal-badge",
        groups = {
            ['justice'] = 0, 
        },
        options = {
             {
                id =  "marshal-badge",
                label = 'Take Badge',
                event =  "qb-policebadge:client:badge",
                args = {},
            },
        }
    })

    exports['qb-interact']:AddInteraction({
        coords = vector3(356.94833374023, -1597.0197753906, 29.294563293457),
        distance = 2.0,
        interactDst = 1.5, 
        id = "marshal-trackphone",
        groups = {
            ['justice'] = 0, 
        },
        options = {
             {
                id =  "marshal-trackphone",
                label = 'Track Phone',
                action = function(entity, coords, args)
                    local keyboard = exports['qb-input']:ShowInput({
                        header = "Phone Number",
                        submitText = "Confirm",
                        inputs = {
                            {
                                type = 'text',
                                isRequired = true,
                                text = "Enter Citizen Phone Number",
                                name = 'input',
                            }
                        }
                    })
                    if keyboard and keyboard.input then
                        QBCore.Functions.TriggerCallback('qb-phone:server:trackPhone', function(done, x, y)
                            if done then
                                SetNewWaypoint(x, y)
                                QBCore.Functions.Notify("Tracked", 'success')
                            else
                                QBCore.Functions.Notify("Can't Track", 'error')
                            end
                        end, keyboard.input)
                    end
                end,
                args = {},
                canInteract = function(entity, coords, args)
                    return isMarshal()
                end,
            },
        }
    })

    exports['qb-interact']:AddInteraction({
        coords = vector3(355.39282226562, -1593.0706787109, 29.294551849365),
        distance = 1.5,
        interactDst = 1.5, 
        id = "marshal-stash",
        groups = {
            ['justice'] = 0, 
        },
        options = {
            {
                id =  "marshal-sharedstash",
                label = 'Shared Stash',
                action = function(entity, coords, args)
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", "usmsharestash", {maxweight = 100000, slots = 50})
                end,
                args = {},
                canInteract = function(entity, coords, args)
                    return isMarshal()
                end,
            },
            {
                id =  "marshal-personalstash",
                label = 'Personal Stash',
                action = function(entity, coords, args)
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", "usmpersonalstash_"..QBCore.Functions.GetPlayerData().citizenid, {maxweight = 100000, slots = 50})
                end,
                args = {},
                canInteract = function(entity, coords, args)
                    return isMarshal()
                end,
            },
            {
                id =  "marshal-armory",
                label = "Armory",
                action = function(entity, coords, args)
                    TriggerEvent("nxo-shop:client:openshopname", "marshalarmory")
                end,
                args = {},
                canInteract = function(entity, coords, args)
                    return isMarshal()
                end,
            },
        }
    })

    exports['qb-interact']:AddInteraction({
        coords = vector3(369.00366210938, -1599.5317382812, 29.294569015503),
        distance = 2.5,
        interactDst = 1.5,
        id = "marshal-clothing",
        groups = {
            ['justice'] = 0, 
        },
        options = {
            {
                id ="marshal-outfit",
                label = "Outfit",
                event = "lvs_clothing:client:openOutfit",
                args = {}
            },
          
            {
                id = "marshal-clothingmenu",
                label = "Change Clothes",
                event = "lvs_clothing:client:OpenClothingShop",
                args = {}
            },
        }
    })

    exports['qb-interact']:AddInteraction({
        coords = vector3(370.45449829102, -1592.3850097656, 29.294549942017),
        distance = 2.5,
        interactDst = 1.5, 
        id = "marshal-printer",
        groups = {
            ['justice'] = 0, 
        },
        options = {
            {
                id = "marshal-printermenu", 
                label = "Use Printer",
                event = "qb-printer:client:openInteraction",
                args = {}
            },
           
        }
    })
end)