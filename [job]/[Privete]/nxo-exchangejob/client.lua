QBCore = exports['qb-core']:GetCoreObject()
CreateThread(function()
    exports['qb-interact']:AddInteraction({
        coords = vector3(132.68, -1342.64, 29.71),
        distance = 1.5,
        interactDst = 1.0,
        id = 'exchange_money',
        groups = {
            ['cashexchange'] = 0,
        },
        options = {
            {
                label = 'Exchange Money',
                action = function(entity, coords, args)
                    TriggerEvent("nxo-exchange:client:exchange")
                end,
               
            },
            {
                label = 'Trade Menu',
                action = function(entity, coords, args)
                    TriggerEvent("nyx-exchange:openMenu")
                end,
               
            },
        }
    })
	
    exports['qb-interact']:AddInteraction({
        coords =vector3(129.77, -1346.14, 29.71),
        distance = 1.5,
        interactDst = 1.5,
        id = 'exchange_money_cunter',
        options = {
            {
                label = 'Counter',
                action = function(entity, coords, args)
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'cashexchangecounter1', {
                        maxweight = 70000,
                        slots =5,
                    })
                    TriggerEvent("inventory:client:SetCurrentStash", 'cashexchangecounter1')
                end,
               
            },
        }
    })
	
    exports['qb-interact']:AddInteraction({
        coords =vector3(128.41, -1345.13, 29.71),
        distance = 1.5,
        interactDst = 1.5,
        id = 'exchange_money_cunter1',
        options = {
            {
                label = 'Counter',
                action = function(entity, coords, args)
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'cashexchangecounter2', {
                        maxweight = 70000,
                        slots =5,
                    })
                    TriggerEvent("inventory:client:SetCurrentStash", 'cashexchangecounter2')
                end,
               
            },
        }
    })
    exports['qb-interact']:AddInteraction({
        coords = vector3(130.79499816895, -1347.2561035156, 29.710422515869),
        distance = 1.5,
        interactDst = 1.5,
        id = 'exchange_money_cunter1',
     
        options = {
            {
                label = 'Counter',
                action = function(entity, coords, args)
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'cashexchangecounter3', {
                        maxweight = 70000,
                        slots =5,
                    })
                    TriggerEvent("inventory:client:SetCurrentStash", 'cashexchangecounter3')
                end,
               
            },
        }
    })
    -- exports['qb-interact']:AddInteraction({
    --     coords = vector3(128.34150695801, -1344.3264160156, 29.710403442383),
    --     distance = 1.0,
    --     interactDst = 1.0,
    --     id = 'exchangescorboardmanagment',
    --     groups = {
    --         ['cashexchange'] =3,
    --     },
    --     options = {
    --         {
    --             label = 'Scoreboard Freeze',
    --             action = function(entity, coords, args)
    --                 TriggerServerEvent("nxo-exchange:server:scorboardstatus","freeze")
    --             end,
    --         },
    --         {
    --             label = 'Scoreboard UnFreeze',
    --             action = function(entity, coords, args)
    --                 TriggerServerEvent("nxo-exchange:server:scorboardstatus","neutral")
    --             end,
    --         },
    --         {
    --             label = 'Price Up',
    --             action = function(entity, coords, args)
    --                 TriggerServerEvent("nxo-exchange:server:scorboardstatus","up")
    --             end,
    --         },
    --         {
    --             label = 'Price Down',
    --             action = function(entity, coords, args)
    --                 TriggerServerEvent("nxo-exchange:server:scorboardstatus","down")
    --             end,
    --         },
    --         {
    --             label = 'Price Normal',
    --             action = function(entity, coords, args)
    --                 TriggerServerEvent("nxo-exchange:server:scorboardstatus","neutral")
    --             end,
    --         },
    --     }
    -- })
    exports['qb-interact']:AddInteraction({
        coords = vector3(128.34150695801, -1344.3264160156, 29.710403442383),
        distance = 1.0,
        interactDst = 1.0,
        id = 'exchangescorboardmanagment',
        groups = {
            ['goverment'] =3,
        },
        options = {
            {
                label = 'Scoreboard Freeze',
                action = function(entity, coords, args)
                    TriggerServerEvent("nxo-exchange:server:scorboardstatus","freeze")
                end,
            },
            {
                label = 'Scoreboard UnFreeze',
                action = function(entity, coords, args)
                    TriggerServerEvent("nxo-exchange:server:scorboardstatus","neutral")
                end,
            },
            {
                label = 'Price Up',
                action = function(entity, coords, args)
                    TriggerServerEvent("nxo-exchange:server:scorboardstatus","up")
                end,
            },
            {
                label = 'Price Down',
                action = function(entity, coords, args)
                    TriggerServerEvent("nxo-exchange:server:scorboardstatus","down")
                end,
            },
            {
                label = 'Price Normal',
                action = function(entity, coords, args)
                    TriggerServerEvent("nxo-exchange:server:scorboardstatus","neutral")
                end,
            },
            {
               
                label = 'Scoreboard ON',
                action = function(entity, coords, args)
                    TriggerServerEvent("nxo-exchange:server:scorboardonoff","on")
                end,
            },
            {
               
                label = 'Scoreboard OFF',
                action = function(entity, coords, args)
                    TriggerServerEvent("nxo-exchange:server:scorboardonoff","off")
                end,
            },
            
        }
    })

    exports['qb-interact']:AddInteraction({
        coords = vector3(130.98, -1340.85, 29.71),
        distance = 2.0,
        interactDst =1.0,
        groups = {
            ['cashexchange'] =0,
        },
        id = 'exchange_money',
        options = {
            {
                groups = {
                    ['cashexchange'] = 2,
                },
                label = 'Safe Stash',
                action = function(entity, coords, args)
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'cashexchange_safestash', {
                        maxweight = 70000,
                        slots =20,
                    })
                    TriggerEvent("inventory:client:SetCurrentStash", 'cashexchange_safestash')
                end,
               
            },
            {
                groups = {
                    ['cashexchange'] = 0,
                },
                label = 'Share Stash',
                action = function(entity, coords, args)
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'cashexchange_sharestash', {
                        maxweight = 70000,
                        slots =20,
                    })
                    TriggerEvent("inventory:client:SetCurrentStash", 'cashexchange_sharestash')
                end,
               
            },
            {
                groups = {
                    ['cashexchange'] = 0,
                },
                label = 'Personal Stash',
                action = function(entity, coords, args)
                    
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'cashexchange_personal_'..QBCore.Functions.GetPlayerData().citizenid, {
                        maxweight = 70000,
                        slots =20,
                    })
                    TriggerEvent("inventory:client:SetCurrentStash", 'cashexchange_personal_'..QBCore.Functions.GetPlayerData().citizenid)
                end,
               
            },
        }
    })
    

end)

RegisterNetEvent('nxo-exchange:client:exchange', function()
    local dialog = exports['qb-input']:ShowInput({
        header = "Enter quantity to trade",
        submitText = "Trade",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'quantity',
                text = 'Quantity'
            }
        }
    })

    if dialog then
        local quantity = tonumber(dialog.quantity)
        if quantity and quantity > 0 then
            TriggerServerEvent('nxo-exchange:server:exchange', quantity)
        end
    end
end)


