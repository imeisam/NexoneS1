Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports[Config.FrameworkPseudo]:GetCoreObject()
    end
end)

Citizen.CreateThread(function() 
    if Config.UseInteract then
        exports.interact:AddModelInteraction({
            model = Config.TableProp,
            offset = vec3(0.0, 0.0, 1.0), -- optional
            name = 'CRAFTING_TBL', -- optional
            id = 'CRAFTING_TBL', -- needed for removing interactions
            distance = 3.0, -- optional
            interactDst = 3.0, -- optional
            options = {
                {
                    label   = 'Craft',
                    action = function(entity)
                        TriggerEvent('zat-crafting:client:OpenCraftMenu', entity)
                    end,
                },
                {
                    label   = 'Blueprints',
                    action = function(entity)
                        TriggerEvent('zat-crafting:client:OpenBpInventory', GetTableIdFromEntity(entity))
                    end,
                    canInteract = function(entity)
                        local CanOpen = nil
                        TriggerServerCallback('zat-crafting:server:CanOpenThisInventory', function(result)
                            CanOpen = result 
                        end, GetTableIdFromEntity(entity))     
                        while CanOpen == nil do
                            Citizen.Wait(20)
                        end
                        return CanOpen
                    end,
                },
                {
                    label   = 'Storage',
                    action = function(entity)
                        TriggerEvent('zat-crafting:client:OpenCraftingInventory', GetTableIdFromEntity(entity))
                    end,
                    canInteract = function(entity)
                        local CanOpen = nil
                        TriggerServerCallback('zat-crafting:server:CanOpenThisInventory', function(result)
                            CanOpen = result 
                        end, GetTableIdFromEntity(entity))     
                        while CanOpen == nil do
                            Citizen.Wait(20)
                        end
                        return CanOpen
                    end,
                },
                {
                    label   = 'Store the Table',
                    action = function(entity)
                        TriggerEvent('zat-crafting:client:TakeBackTable', entity)
                    end,
                    canInteract = function(entity)
                        local CanOpen = nil
                        TriggerServerCallback('zat-crafting:server:CanStoreTable', function(result)
                            CanOpen = result 
                        end, GetTableIdFromEntity(entity))    
                        while CanOpen == nil do
                            Citizen.Wait(20)
                        end
                        return CanOpen
                    end,
                },
                {
                    label   = 'Move the Table',
                    action = function(entity)
                        TriggerEvent('zat-crafting:client:MoveTable', entity)
                    end,
                    canInteract = function(entity)
                        local CanOpen = nil
                        TriggerServerCallback('zat-crafting:server:CanStoreTable', function(result)
                            CanOpen = result 
                        end, GetTableIdFromEntity(entity))   
                        while CanOpen == nil do
                            Citizen.Wait(20)
                        end
                        return CanOpen
                    end,
                },
            }
        })
    else
        if Config.Target == "qb" then
            exports['qb-target']:AddTargetModel(Config.TableProp, {
                options = {
                    {
                        label   = 'Craft',
                        icon    = 'fas fa-screwdriver-wrench',
                        action = function(entity)
                            TriggerEvent('zat-crafting:client:OpenCraftMenu', entity)
                        end,
                    },
                    {
                        icon    = 'fas fa-newspaper',
                        label   = 'Blueprints',
                        action = function(entity)
                            TriggerEvent('zat-crafting:client:OpenBpInventory', GetTableIdFromEntity(entity))
                        end,
                        canInteract = function(entity)
                            local CanOpen = nil
                            TriggerServerCallback('zat-crafting:server:CanOpenThisInventory', function(result)
                                CanOpen = result 
                            end, GetTableIdFromEntity(entity))     
                            while CanOpen == nil do
                                Citizen.Wait(20)
                            end
                            return CanOpen
                        end,
                    },
                    {
                        icon    = 'fas fa-box',
                        label   = 'Storage',
                        action = function(entity)
                            TriggerEvent('zat-crafting:client:OpenCraftingInventory', GetTableIdFromEntity(entity))
                        end,
                        canInteract = function(entity)
                            local CanOpen = nil
                            TriggerServerCallback('zat-crafting:server:CanOpenThisInventory', function(result)
                                CanOpen = result 
                            end, GetTableIdFromEntity(entity))     
                            while CanOpen == nil do
                                Citizen.Wait(20)
                            end
                            return CanOpen
                        end,
                    },
                    {
                        icon    = 'fas fa-hammer',
                        label   = 'Store the Table',
                        action = function(entity)
                            TriggerEvent('zat-crafting:client:TakeBackTable', entity)
                        end,
                        canInteract = function(entity)
                            local CanOpen = nil
                            TriggerServerCallback('zat-crafting:server:CanStoreTable', function(result)
                                CanOpen = result 
                            end, GetTableIdFromEntity(entity))    
                            while CanOpen == nil do
                                Citizen.Wait(20)
                            end
                            return CanOpen
                        end,
                    },
                    {
                        icon    = 'fas fa-up-down-left-right',
                        label   = 'Move the Table',
                        action = function(entity)
                            TriggerEvent('zat-crafting:client:MoveTable', entity)
                        end,
                        canInteract = function(entity)
                            local CanOpen = nil
                            TriggerServerCallback('zat-crafting:server:CanStoreTable', function(result)
                                CanOpen = result 
                            end, GetTableIdFromEntity(entity))   
                            while CanOpen == nil do
                                Citizen.Wait(20)
                            end
                            return CanOpen
                        end,
                    },
                },
                distance = 1.5, 
            })
        elseif Config.Target == "ox" then
            exports.ox_target:addModel(Config.TableProp,{
                {
                    label   = 'Craft',
                    icon    = 'fas fa-screwdriver-wrench',
                    onSelect = function(data)
                        TriggerEvent('zat-crafting:client:OpenCraftMenu', data.entity)
                    end,
                },
                {
                    icon    = 'fas fa-newspaper',
                    label   = 'Blueprints',
                    onSelect = function(data)
                        TriggerEvent('zat-crafting:client:OpenBpInventory', GetTableIdFromEntity(data.entity))
                    end,
                    canInteract = function(entity)
                        local CanOpen = nil
                        TriggerServerCallback('zat-crafting:server:CanOpenThisInventory', function(result)
                            CanOpen = result 
                        end, GetTableIdFromEntity(entity))     
                        while CanOpen == nil do
                            Citizen.Wait(20)
                        end
                        return CanOpen
                    end,
                },
                {
                    icon    = 'fas fa-box',
                    label   = 'Storage',
                    onSelect = function(data)
                        TriggerEvent('zat-crafting:client:OpenCraftingInventory', GetTableIdFromEntity(data.entity))
                    end,
                    canInteract = function(entity)
                        local CanOpen = nil
                        TriggerServerCallback('zat-crafting:server:CanOpenThisInventory', function(result)
                            CanOpen = result 
                        end, GetTableIdFromEntity(entity))     
                        while CanOpen == nil do
                            Citizen.Wait(20)
                        end
                        return CanOpen
                    end,
                },
                {
                    icon    = 'fas fa-hammer',
                    label   = 'Store the Table',
                    onSelect = function(data)
                        TriggerEvent('zat-crafting:client:TakeBackTable', data.entity)
                    end,
                    canInteract = function(entity)
                        local CanOpen = nil
                        TriggerServerCallback('zat-crafting:server:CanStoreTable', function(result)
                            CanOpen = result 
                        end, GetTableIdFromEntity(entity))    
                        while CanOpen == nil do
                            Citizen.Wait(20)
                        end
                        return CanOpen
                    end,
                },
                {
                    icon    = 'fas fa-up-down-left-right',
                    label   = 'Move the Table',
                    onSelect = function(data)
                        TriggerEvent('zat-crafting:client:MoveTable', data.entity)
                    end,
                    canInteract = function(entity)
                        local CanOpen = nil
                        TriggerServerCallback('zat-crafting:server:CanStoreTable', function(result)
                            CanOpen = result 
                        end, GetTableIdFromEntity(entity))   
                        while CanOpen == nil do
                            Citizen.Wait(20)
                        end
                        return CanOpen
                    end,
                },         
            })
        end
    end
end)