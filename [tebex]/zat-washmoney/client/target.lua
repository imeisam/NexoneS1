Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports['qb-core']:GetCoreObject()
    end
end)

Citizen.CreateThread(function() 
    exports['qb-target']:AddTargetModel(Config.MachineProp, {
        options = {
            {
                type    = 'client',
                event   = 'zat-washmoney:client:OpenControlPanel',
                icon    = 'fas fa-tablet',
                label   = 'Control Panel',
            },
            {
                type    = 'client',
                event   = 'zat-washmoney:client:OpenWashmachineStash',
                icon    = 'fas fa-money-bill',
                label   = 'Open Wash Machine',
                canInteract = function(entity)
                    local CanOpen = false
                    local res=false
                    if Config.Framework == "qb" then
                        QBCore.Functions.TriggerCallback('zat-washmoney:server:CanOpenThisInventory', function(result)
                            CanOpen = result 
                            res=true
                        end, NetworkGetNetworkIdFromEntity(entity))   
                    elseif Config.Framework == "esx" then
                        ESX.TriggerServerCallback('zat-washmoney:server:CanOpenThisInventory', function(result)
                            CanOpen = result 
                        end, NetworkGetNetworkIdFromEntity(entity))   
                    end
                   while not res do 
                    Citizen.Wait(100)
                   end
                   
                    return CanOpen
                end,
            },
            {
                type    = 'client',
                event   = 'zat-washmoney:client:TakeBackTable',
                icon    = 'fas fa-hammer',
                label   = 'Store the Wash Machine',
                canInteract = function(entity)
                    local CanOpen = true
                    local res=false
                    if Config.Framework == "qb" then
                        QBCore.Functions.TriggerCallback('zat-washmoney:server:CanOpenThisInventory', function(result)
                            CanOpen = result 
                            res=true
                        end, NetworkGetNetworkIdFromEntity(entity))   
                    elseif Config.Framework == "esx" then
                        ESX.TriggerServerCallback('zat-washmoney:server:CanOpenThisInventory', function(result)
                            CanOpen = result 
                        end, NetworkGetNetworkIdFromEntity(entity))   
                    end
                    while not res do 
                        Citizen.Wait(100)
                       end
                    return CanOpen
                end,
            },
            {
                type    = 'client',
                event   = 'zat-washmoney:client:MoveTable',
                icon    = 'fas fa-up-down-left-right',
                label   = 'Move the Table',
            },
        },
        distance = 1.5
    })
    exports['qb-target']:AddTargetModel(Config.MachinePropOpen, {
        options = {
            {
                type    = 'client',
                event   = 'zat-washmoney:client:OpenControlPanel',
                icon    = 'fas fa-tablet',
                label   = 'Control Panel',
            },
            {
                type    = 'client',
                event   = 'zat-washmoney:client:OpenWashmachineStash',
                icon    = 'fas fa-money-bill',
                label   = 'Open Wash Machine',
                canInteract = function(entity)
                    local CanOpen = true
                    local res=false
                    if Config.Framework == "qb" then
                        QBCore.Functions.TriggerCallback('zat-washmoney:server:CanOpenThisInventory', function(result)
                            CanOpen = result
                            res=true 
                        end, NetworkGetNetworkIdFromEntity(entity))   
                    elseif Config.Framework == "esx" then
                        ESX.TriggerServerCallback('zat-washmoney:server:CanOpenThisInventory', function(result)
                            CanOpen = result 
                        end, NetworkGetNetworkIdFromEntity(entity))   
                    end
                    while not res do 
                        Citizen.Wait(100)
                       end
                    return CanOpen
                end,
            },
            {
                type    = 'client',
                event   = 'zat-washmoney:client:TakeBackTable',
                icon    = 'fas fa-hammer',
                label   = 'Store the Wash Machine',
                canInteract = function(entity)
                    local CanOpen = true
                    local res=false
                    if Config.Framework == "qb" then
                        QBCore.Functions.TriggerCallback('zat-washmoney:server:CanOpenThisInventory', function(result)
                            CanOpen = result 
                            res=true 
                        end, NetworkGetNetworkIdFromEntity(entity))   
                    elseif Config.Framework == "esx" then
                        ESX.TriggerServerCallback('zat-washmoney:server:CanOpenThisInventory', function(result)
                            CanOpen = result 
                        end, NetworkGetNetworkIdFromEntity(entity))   
                    end
                    while not res do 
                        Citizen.Wait(100)
                       end
                    return CanOpen
                end,
            },
            {
                type    = 'client',
                event   = 'zat-washmoney:client:MoveTable',
                icon    = 'fas fa-up-down-left-right',
                label   = 'Move the Table',
                canInteract = function(entity)
                    local retval = false
                    TriggerServerCallback('zat-washmoney:server:CheckTime', function(Time)
                        if Time <= 0 then
                            retval = true
                        end
                    end, NetworkGetNetworkIdFromEntity(entity))
                    Citizen.Wait(100)
                    return retval
                end
            },
        },
        distance = 1.5
    })
end)

RegisterNetEvent("zat-washmoney:server:RemoveTargetForAll", function(id)
  exports['qb-target']:RemoveZone(id)
end)