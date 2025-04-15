Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports[Config.FrameworkPseudo]:GetCoreObject()
    end
end)

exports['qb-interact']:AddModelInteraction({
    model = Config.TableProp,
    offset = vec3(0.0, 0.0, 1.0), -- optional
    name = 'craftingtable_', -- optional
    id = 'craftingtable_', -- needed for removing interactions
    distance = 5.0, -- optional
    interactDst = 2.0, -- optional
    options = {
        {
            type    = 'client',
            event   = 'zat-crafting:client:OpenCraftMenu',
            label   = 'Craft',
            icon    = 'fas fa-screwdriver-wrench',
            action = function(entity, coords, args)
                local data = {
                    entity = entity,
                }
                TriggerEvent('zat-crafting:client:OpenCraftMenu', data)
            end,
        },
        {
            type    = 'client',
            event   = 'zat-crafting:client:OpenBpInventory',
            icon    = 'fas fa-newspaper',
            label   = 'Blueprints',
            canInteract = function(entity)
                local CanOpen = true
                local stop=true
                TriggerServerCallback('zat-crafting:server:CanOpenThisInventory', function(result)
                    CanOpen = result 
                    stop=false
                end, NetworkGetNetworkIdFromEntity(entity))     
                while stop do 
                    Citizen.Wait(100)
                end
                return CanOpen
            end,
            action = function(entity, coords, args)
                local data = {
                    entity = entity,
                }
                TriggerEvent('zat-crafting:client:OpenBpInventory', data)
            end,
        },
        {
            type    = 'client',
            event   = 'zat-crafting:client:OpenCraftingInventory',
            icon    = 'fas fa-box',
            label   = 'Storage',
            canInteract = function(entity)
                local CanOpen = true
                local stop=true
                TriggerServerCallback('zat-crafting:server:CanOpenThisInventory', function(result)
                    CanOpen = result 
                    stop=false
                end, NetworkGetNetworkIdFromEntity(entity))     
                while stop do 
                    Citizen.Wait(100)
                end
                return CanOpen
            end,
            action = function(entity, coords, args)
                local data = {
                    entity = entity,
                }
                TriggerEvent('zat-crafting:client:OpenCraftingInventory', data)
            end,
        },
        {
            type    = 'client',
            event   = 'zat-crafting:client:TakeBackTable',
            icon    = 'fas fa-hammer',
            label   = 'Store the Table',
            canInteract = function(entity)
                local CanOpen = true
                local stop=false
                TriggerServerCallback('zat-crafting:server:CanStoreTable', function(result)
                    CanOpen = result
                    stop=false 
                end, NetworkGetNetworkIdFromEntity(entity))    
                while stop do 
                    Citizen.Wait(100)
                end
                return CanOpen
            end,
            action = function(entity, coords, args)
                local data = {
                    entity = entity,
                }
                TriggerEvent('zat-crafting:client:TakeBackTable', data)
            end,
        },
        {
            type    = 'client',
            event   = 'zat-crafting:client:MoveTable',
            icon    = 'fas fa-up-down-left-right',
            label   = 'Move the Table',
            canInteract = function(entity)
                local CanOpen = true
                local stop=false
                TriggerServerCallback('zat-crafting:server:CanStoreTable', function(result)
                    CanOpen = result 
                    stop=false 
                end, NetworkGetNetworkIdFromEntity(entity))   
                while stop do 
                    Citizen.Wait(100)
                end
                return CanOpen
            end,
            action = function(entity, coords, args)
                local data = {
                    entity = entity,
                }
                TriggerEvent('zat-crafting:client:MoveTable', data)
            end,
        },
    }
})
