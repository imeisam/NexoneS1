local QBCore = nil

Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports[Config.FrameworkPseudo]:GetCoreObject()
    end
end)

Citizen.CreateThread(function()
    if Config.UseInteract then
        exports.interact:AddModelInteraction({
            model = Config.Items["zatpc"].model,
            offset = vec3(0.0, 0.0, 0.5), -- optional
            name = 'MINING_PC', -- optional
            id = 'MINING_PC', -- needed for removing interactions
            distance = 3.0, -- optional
            interactDst = 3.0, -- optional
            options = {
                {
                    icon        =  'fas fa-desktop',
                    label       =  _U("open_pc"),
                    action = function(entity)
                        local data = {
                            entity = entity
                        }
                        TriggerEvent('zat-desktop:client:OpenPc', data)
                    end,
                    canInteract = function(entity)
                        local retval = nil
                        TriggerServerCallback('zat-desktop:server:HasPcAllComponents', function(result)
                            retval = result
                        end, GetPcIdFromEntity(entity))
                        while retval == nil do
                            Citizen.Wait(10)
                        end
                        return retval
                    end,
                },
                {
                    icon    =  'fas fa-sim-card',
                    label   =  _U("chec_gp"),
                    action = function(entity)
                        local data = {
                            entity = entity,
                            inv    = 'pc-gpu'
                        }
                        TriggerEvent('zat-desktop:client:OpenStash', data)
                    end,
                },
                {
                    icon    =  'fas fa-sim-card',
                    label   =  _U("chec_cp"),
                    action = function(entity)
                        local data = {
                            entity = entity,
                            inv    = 'pc-cpu'
                        }
                        TriggerEvent('zat-desktop:client:OpenStash', data)
                    end,
                },
                {
                    icon    =  'fas fa-sim-card',
                    label   =  _U("chec_ps"),
                    action = function(entity)
                        local data = {
                            entity = entity,
                            inv    = 'pc-ps'
                        }
                        TriggerEvent('zat-desktop:client:OpenStash', data)
                    end,
                },
                {
                    icon    =  'fas fa-sim-card',
                    label   =  _U("chec_mb"),
                    action = function(entity)
                        local data = {
                            entity = entity,
                            inv    = 'pc-mb'
                        }
                        TriggerEvent('zat-desktop:client:OpenStash', data)
                    end,
                },
                {
                    icon    =  'fas fa-wifi',
                    label   =  _U("chec_mm"),
                    action = function(entity)
                        local data = {
                            entity = entity,
                            inv    = 'pc-modem'
                        }
                        TriggerEvent('zat-desktop:client:OpenStash', data)
                    end,
                },
                {
                    icon    =  'fas fa-up-down-left-right',
                    label   =  _U("trg_mov"),
                    action = function(entity)
                        local data = {
                            entity  = entity,
                            id      = GetPcIdFromEntity(entity),
                            what    = 'pc'
                        }
                        TriggerEvent('zat-desktop:client:Move', data)
                    end,
                },
                {
                    icon    =  'fas fa-xmark',
                    label   =  _U("trg_str"),
                    what    =  'pc',
                    action = function(entity)
                        local data = {
                            entity = entity,
                            id      = GetPcIdFromEntity(entity),
                            what   = 'pc'
                        }
                        TriggerEvent('zat-desktop:client:Destroy', data)
                    end,
                    canInteract = function(entity)
                        local retval = nil
                        TriggerServerCallback('zat-desktop:server:CanIStorePC', function(result)
                            retval = result
                        end, GetPcIdFromEntity(entity))
                        while retval == nil do
                            Citizen.Wait(10)
                        end
                        return retval
                    end,
                },
            }
        })
        exports.interact:AddModelInteraction({
            model = Config.Items["zatminingrack"].model,
            offset = vec3(0.0, 0.0, 0.5), -- optional
            name = 'MINING_RACK', -- optional
            id = 'MINING_RACK', -- needed for removing interactions
            distance = 3.0, -- optional
            interactDst = 3.0, -- optional
            options = {
                {
                    icon    =  'fas fa-sim-card',
                    label   =  _U("chec_gp"),
                    action = function(entity)
                        local data = {
                            entity = entity,
                            inv    = 'rk-gpu'
                        }
                        TriggerEvent('zat-desktop:client:OpenStash', data)
                    end,
                },
                {
                    icon    =  'fas fa-sim-card',
                    label   =  _U("chec_ps"),
                    action = function(entity)
                        local data = {
                            entity = entity,
                            inv    = 'rk-ps'
                        }
                        TriggerEvent('zat-desktop:client:OpenStash', data)
                    end,
                },
                {
                    icon    =  'fas fa-sim-card',
                    label   =  _U("chec_mb"),
                    action = function(entity)
                        local data = {
                            entity = entity,
                            inv    = 'rk-mb'
                        }
                        TriggerEvent('zat-desktop:client:OpenStash', data)
                    end,
                },
                {
                    icon    =  'fas fa-up-down-left-right',
                    label   =  _U("trg_mov"),
                    action = function(entity)
                        local data = {
                            entity  = entity,
                            id      = GetRackIdFromEntity(entity),
                            what    = 'rack'
                        }
                        TriggerEvent('zat-desktop:client:Move', data)
                    end,
                },
                {
                    icon    =  'fas fa-xmark',
                    label   =  _U("trg_str"),
                    action = function(entity)
                        local data = {
                            entity = entity,
                            id      = GetRackIdFromEntity(entity),
                            what   = 'rack'
                        }
                        TriggerEvent('zat-desktop:client:Destroy', data)
                    end,
                    canInteract = function(entity)
                        local retval = nil
                        TriggerServerCallback('zat-desktop:server:CanIStoreRack', function(result)
                            retval = result
                        end, GetRackIdFromEntity(entity))
                        while retval == nil do
                            Citizen.Wait(10)
                        end
                        return retval
                    end,
                },
            }
        })
        exports.interact:AddModelInteraction({
            model = Config.DroneProp,
            offset = vec3(0.0, 0.0, 0.5), -- optional
            name = 'MINING_DRONE', -- optional
            id = 'MINING_DRONE', -- needed for removing interactions
            distance = 3.0, -- optional
            interactDst = 3.0, -- optional
            options = {
                {
                    icon    =  'fas fa-fly',
                    label   =  _U("trg_ope"),
                    action = function(entity)
                        local data = {
                            entity = entity,
                            inv    = 'drone'
                        }
                        TriggerEvent('zat-desktop:client:OpenStash', data)
                    end,
                },
            }
        })
        exports.interact:AddModelInteraction({
            model = Config.Items["zatbaskets"].model,
            offset = vec3(0.0, 0.0, 0.5), -- optional
            name = 'MINING_BASKETS', -- optional
            id = 'MINING_BASKETS', -- needed for removing interactions
            distance = 3.0, -- optional
            interactDst = 3.0, -- optional
            options = {
                {
                    icon    =  'fas fa-box-archive',
                    label   =  _U("trg_ope"),
                    action = function(entity)
                        local data = {
                            entity = entity,
                            inv    = 'baskets'
                        }
                        TriggerEvent('zat-desktop:client:OpenStash', data)
                    end,
                },
                {
                    icon    =  'fas fa-up-down-left-right',
                    label   =  _U("trg_mov"),
                    action = function(entity)
                        local data = {
                            entity  = entity,
                            id      = GetBasketIdFromEntity(entity),
                            what    = 'baskets'
                        }
                        TriggerEvent('zat-desktop:client:Move', data)
                    end,
                },
                {
                    icon    =  'fas fa-xmark',
                    label   =  _U("trg_str"),
                    action = function(entity)
                        local data = {
                            entity = entity,
                            id      = GetBasketIdFromEntity(entity),
                            what   = 'baskets'
                        }
                        TriggerEvent('zat-desktop:client:Destroy', data)
                    end,
                    canInteract = function(entity)
                        local retval = nil
                        TriggerServerCallback('zat-desktop:server:CanIStoreBasket', function(result)
                            retval = result
                        end, GetBasketIdFromEntity(entity))
                        while retval == nil do
                            Citizen.Wait(50)
                        end
                        return retval
                    end,
                },
            }
        })
        exports.interact:AddModelInteraction({
            model = Config.Items["zatbasketm"].model,
            offset = vec3(0.0, 0.0, 0.5), -- optional
            name = 'MINING_BASKETM', -- optional
            id = 'MINING_BASKETM', -- needed for removing interactions
            distance = 3.0, -- optional
            interactDst = 3.0, -- optional
            options = {
                {
                    icon    =  'fas fa-box-archive',
                    label   =  _U("trg_ope"),
                    action = function(entity)
                        local data = {
                            entity = entity,
                            inv    = 'basketm'
                        }
                        TriggerEvent('zat-desktop:client:OpenStash', data)
                    end,
                },
                {
                    icon    =  'fas fa-up-down-left-right',
                    label   =  _U("trg_mov"),
                    action = function(entity)
                        local data = {
                            entity  = entity,
                            id      = GetBasketIdFromEntity(entity),
                            what    = 'basketm'
                        }
                        TriggerEvent('zat-desktop:client:Move', data)
                    end,
                },
                {
                    icon    =  'fas fa-xmark',
                    label   =  _U("trg_str"),
                    action = function(entity)
                        local data = {
                            entity = entity,
                            id      = GetBasketIdFromEntity(entity),
                            what   = 'basketm'
                        }
                        TriggerEvent('zat-desktop:client:Destroy', data)
                    end,
                    canInteract = function(entity)
                        local retval = nil
                        TriggerServerCallback('zat-desktop:server:CanIStoreBasket', function(result)
                            retval = result
                        end, GetBasketIdFromEntity(entity))
                        while retval == nil do
                            Citizen.Wait(50)
                        end
                        return retval
                    end,
                },
            }
        })
        exports.interact:AddModelInteraction({
            model = Config.Items["zatminingfan"].model,
            offset = vec3(0.0, 0.0, 0.5), -- optional
            name = 'MINING_FAN', -- optional
            id = 'MINING_FAN', -- needed for removing interactions
            distance = 3.0, -- optional
            interactDst = 3.0, -- optional
            options = {
                {
                    icon    =  'fas fa-up-down-left-right',
                    label   =  _U("trg_mov"),
                    action = function(entity)
                        local data = {
                            entity  = entity,
                            id      = GetFanIdFromEntity(entity),
                            what    = 'fan'
                        }
                        TriggerEvent('zat-desktop:client:Move', data)
                    end,
                },
                {
                    icon    =  'fas fa-xmark',
                    label   =  _U("trg_str"),
                    action = function(entity)
                        local data = {
                            entity = entity,
                            id      = GetFanIdFromEntity(entity),
                            what   = 'fan'
                        }
                        TriggerEvent('zat-desktop:client:Destroy', data)
                    end,
                    
                },
            }
        })
    else
        if Config.Target == 'qb' then
            exports['qb-target']:AddTargetModel(Config.Items["zatpc"].model, {
                options = {
                    {
                        icon        =  'fas fa-desktop',
                        label       =  _U("open_pc"),
                        action = function(entity)
                            local data = {
                                entity = entity
                            }
                            TriggerEvent('zat-desktop:client:OpenPc', data)
                        end,
                        canInteract = function(entity)
                            local retval = nil
                            TriggerServerCallback('zat-desktop:server:HasPcAllComponents', function(result)
                                retval = result
                            end, GetPcIdFromEntity(entity))
                            while retval == nil do
                                Citizen.Wait(10)
                            end
                            return retval
                        end,
                    },
                    {
                        icon    =  'fas fa-sim-card',
                        label   =  _U("chec_gp"),
                        action = function(entity)
                            local data = {
                                entity = entity,
                                inv    = 'pc-gpu'
                            }
                            TriggerEvent('zat-desktop:client:OpenStash', data)
                        end,
                    },
                    {
                        icon    =  'fas fa-sim-card',
                        label   =  _U("chec_cp"),
                        action = function(entity)
                            local data = {
                                entity = entity,
                                inv    = 'pc-cpu'
                            }
                            TriggerEvent('zat-desktop:client:OpenStash', data)
                        end,
                    },
                    {
                        icon    =  'fas fa-sim-card',
                        label   =  _U("chec_ps"),
                        action = function(entity)
                            local data = {
                                entity = entity,
                                inv    = 'pc-ps'
                            }
                            TriggerEvent('zat-desktop:client:OpenStash', data)
                        end,
                    },
                    {
                        icon    =  'fas fa-sim-card',
                        label   =  _U("chec_mb"),
                        action = function(entity)
                            local data = {
                                entity = entity,
                                inv    = 'pc-mb'
                            }
                            TriggerEvent('zat-desktop:client:OpenStash', data)
                        end,
                    },
                    {
                        icon    =  'fas fa-wifi',
                        label   =  _U("chec_mm"),
                        action = function(entity)
                            local data = {
                                entity = entity,
                                inv    = 'pc-modem'
                            }
                            TriggerEvent('zat-desktop:client:OpenStash', data)
                        end,
                    },
                    {
                        icon    =  'fas fa-up-down-left-right',
                        label   =  _U("trg_mov"),
                        action = function(entity)
                            local data = {
                                entity  = entity,
                                id      = GetPcIdFromEntity(entity),
                                what    = 'pc'
                            }
                            TriggerEvent('zat-desktop:client:Move', data)
                        end,
                    },
                    {
                        icon    =  'fas fa-xmark',
                        label   =  _U("trg_str"),
                        what    =  'pc',
                        action = function(entity)
                            local data = {
                                entity = entity,
                                id      = GetPcIdFromEntity(entity),
                                what   = 'pc'
                            }
                            TriggerEvent('zat-desktop:client:Destroy', data)
                        end,
                        canInteract = function(entity)
                            local retval = nil
                            TriggerServerCallback('zat-desktop:server:CanIStorePC', function(result)
                                retval = result
                            end, GetPcIdFromEntity(entity))
                            while retval == nil do
                                Citizen.Wait(10)
                            end
                            return retval
                        end,
                    },
                },
                distance = 1.5, 
            })
            exports['qb-target']:AddTargetModel(Config.Items["zatminingrack"].model, {
                options = {
                    {
                        icon    =  'fas fa-sim-card',
                        label   =  _U("chec_gp"),
                        action = function(entity)
                            local data = {
                                entity = entity,
                                inv    = 'rk-gpu'
                            }
                            TriggerEvent('zat-desktop:client:OpenStash', data)
                        end,
                    },
                    {
                        icon    =  'fas fa-sim-card',
                        label   =  _U("chec_ps"),
                        action = function(entity)
                            local data = {
                                entity = entity,
                                inv    = 'rk-ps'
                            }
                            TriggerEvent('zat-desktop:client:OpenStash', data)
                        end,
                    },
                    {
                        icon    =  'fas fa-sim-card',
                        label   =  _U("chec_mb"),
                        action = function(entity)
                            local data = {
                                entity = entity,
                                inv    = 'rk-mb'
                            }
                            TriggerEvent('zat-desktop:client:OpenStash', data)
                        end,
                    },
                    {
                        icon    =  'fas fa-up-down-left-right',
                        label   =  _U("trg_mov"),
                        action = function(entity)
                            local data = {
                                entity  = entity,
                                id      = GetRackIdFromEntity(entity),
                                what    = 'rack'
                            }
                            TriggerEvent('zat-desktop:client:Move', data)
                        end,
                    },
                    {
                        icon    =  'fas fa-xmark',
                        label   =  _U("trg_str"),
                        action = function(entity)
                            local data = {
                                entity = entity,
                                id      = GetRackIdFromEntity(entity),
                                what   = 'rack'
                            }
                            TriggerEvent('zat-desktop:client:Destroy', data)
                        end,
                        canInteract = function(entity)
                            local retval = nil
                            TriggerServerCallback('zat-desktop:server:CanIStoreRack', function(result)
                                retval = result
                            end, GetRackIdFromEntity(entity))
                            while retval == nil do
                                Citizen.Wait(10)
                            end
                            return retval
                        end,
                    },
                },
                distance = 1.5, 
            })
            exports['qb-target']:AddTargetModel(Config.DroneProp, {
                options = {
                    {
                        icon    =  'fas fa-fly',
                        label   =  _U("trg_ope"),
                        action = function(entity)
                            local data = {
                                entity = entity,
                                inv    = 'drone'
                            }
                            TriggerEvent('zat-desktop:client:OpenStash', data)
                        end,
                    },
                },
                distance = 1.5, 
            })
            exports['qb-target']:AddTargetModel(Config.Items["zatbaskets"].model, {
                options = {
                    {
                        icon    =  'fas fa-box-archive',
                        label   =  _U("trg_ope"),
                        action = function(entity)
                            local data = {
                                entity = entity,
                                inv    = 'baskets'
                            }
                            TriggerEvent('zat-desktop:client:OpenStash', data)
                        end,
                    },
                    {
                        icon    =  'fas fa-up-down-left-right',
                        label   =  _U("trg_mov"),
                        action = function(entity)
                            local data = {
                                entity  = entity,
                                id      = GetBasketIdFromEntity(entity),
                                what    = 'baskets'
                            }
                            TriggerEvent('zat-desktop:client:Move', data)
                        end,
                    },
                    {
                        icon    =  'fas fa-xmark',
                        label   =  _U("trg_str"),
                        action = function(entity)
                            local data = {
                                entity = entity,
                                id      = GetBasketIdFromEntity(entity),
                                what   = 'baskets'
                            }
                            TriggerEvent('zat-desktop:client:Destroy', data)
                        end,
                        canInteract = function(entity)
                            local retval = nil
                            TriggerServerCallback('zat-desktop:server:CanIStoreBasket', function(result)
                                retval = result
                            end, GetBasketIdFromEntity(entity))
                            while retval == nil do
                                Citizen.Wait(50)
                            end
                            return retval
                        end,
                    },
                },
                distance = 1.5, 
            })
            exports['qb-target']:AddTargetModel(Config.Items["zatbasketm"].model, {
                options = {
                    {
                        icon    =  'fas fa-box-archive',
                        label   =  _U("trg_ope"),
                        action = function(entity)
                            local data = {
                                entity = entity,
                                inv    = 'basketm'
                            }
                            TriggerEvent('zat-desktop:client:OpenStash', data)
                        end,
                    },
                    {
                        icon    =  'fas fa-up-down-left-right',
                        label   =  _U("trg_mov"),
                        action = function(entity)
                            local data = {
                                entity  = entity,
                                id      = GetBasketIdFromEntity(entity),
                                what    = 'basketm'
                            }
                            TriggerEvent('zat-desktop:client:Move', data)
                        end,
                    },
                    {
                        icon    =  'fas fa-xmark',
                        label   =  _U("trg_str"),
                        action = function(entity)
                            local data = {
                                entity = entity,
                                id      = GetBasketIdFromEntity(entity),
                                what   = 'basketm'
                            }
                            TriggerEvent('zat-desktop:client:Destroy', data)
                        end,
                        canInteract = function(entity)
                            local retval = nil
                            TriggerServerCallback('zat-desktop:server:CanIStoreBasket', function(result)
                                retval = result
                            end, GetBasketIdFromEntity(entity))
                            while retval == nil do
                                Citizen.Wait(50)
                            end
                            return retval
                        end,
                    },
                },
                distance = 1.5, 
            })
            exports['qb-target']:AddTargetModel(Config.Items["zatminingfan"].model, {
                options = {
                    {
                        icon    =  'fas fa-up-down-left-right',
                        label   =  _U("trg_mov"),
                        action = function(entity)
                            local data = {
                                entity  = entity,
                                id      = GetFanIdFromEntity(entity),
                                what    = 'fan'
                            }
                            TriggerEvent('zat-desktop:client:Move', data)
                        end,
                    },
                    {
                        icon    =  'fas fa-xmark',
                        label   =  _U("trg_str"),
                        action = function(entity)
                            local data = {
                                entity = entity,
                                id      = GetFanIdFromEntity(entity),
                                what   = 'fan'
                            }
                            TriggerEvent('zat-desktop:client:Destroy', data)
                        end,
                        
                    },
                },
                distance = 1.5, 
            })
        elseif Config.Target == 'ox' then
            exports.ox_target:addModel(Config.Items["zatpc"].model, {
                {
                    icon        =  'fas fa-desktop',
                    label       =  _U("open_pc"),
                    onSelect = function(data)
                        local Data = {
                            entity = data.entity
                        }
                        TriggerEvent('zat-desktop:client:OpenPc', Data)
                    end,
                    canInteract = function(entity)
                        local retval = nil
                        TriggerServerCallback('zat-desktop:server:HasPcAllComponents', function(result)
                            retval = result
                        end, GetPcIdFromEntity(entity))
                        while retval == nil do
                            Citizen.Wait(10)
                        end
                        return retval
                    end,
                },
                {
                    icon    =  'fas fa-sim-card',
                    label   =  _U("chec_gp"),
                    onSelect = function(data)
                        local Data = {
                            entity = data.entity,
                            inv    = 'pc-gpu'
                        }
                        TriggerEvent('zat-desktop:client:OpenStash', Data)
                    end,
                },
                {
                    icon    =  'fas fa-sim-card',
                    label   =  _U("chec_cp"),
                    onSelect = function(data)
                        local Data = {
                            entity = data.entity,
                            inv    = 'pc-cpu'
                        }
                        TriggerEvent('zat-desktop:client:OpenStash', Data)
                    end,
                },
                {
                    icon    =  'fas fa-sim-card',
                    label   =  _U("chec_ps"),
                    onSelect = function(data)
                        local Data = {
                            entity = data.entity,
                            inv    = 'pc-ps'
                        }
                        TriggerEvent('zat-desktop:client:OpenStash', Data)
                    end,
                },
                {
                    icon    =  'fas fa-sim-card',
                    label   =  _U("chec_mb"),
                    onSelect = function(data)
                        local Data = {
                            entity = data.entity,
                            inv    = 'pc-mb'
                        }
                        TriggerEvent('zat-desktop:client:OpenStash', Data)
                    end,
                },
                {
                    icon    =  'fas fa-wifi',
                    label   =  _U("chec_mm"),
                    onSelect = function(data)
                        local Data = {
                            entity = data.entity,
                            inv    = 'pc-modem'
                        }
                        TriggerEvent('zat-desktop:client:OpenStash', Data)
                    end,
                },
                {
                    icon    =  'fas fa-up-down-left-right',
                    label   =  _U("trg_mov"),
                    onSelect = function(data)
                        local Data = {
                            entity  = data.entity,
                            id      = GetPcIdFromEntity(data.entity),
                            what    = 'pc'
                        }
                        TriggerEvent('zat-desktop:client:Move', Data)
                    end,
                },
                {
                    icon    =  'fas fa-xmark',
                    label   =  _U("trg_str"),
                    what    =  'pc',
                    onSelect = function(data)
                        local Data = {
                            entity = data.entity,
                            id     = GetPcIdFromEntity(data.entity),
                            what   = 'pc'
                        }
                        TriggerEvent('zat-desktop:client:Destroy', Data)
                    end,
                    canInteract = function(entity)
                        local retval = nil
                        TriggerServerCallback('zat-desktop:server:CanIStorePC', function(result)
                            retval = result
                        end, GetPcIdFromEntity(entity))
                        while retval == nil do
                            Citizen.Wait(10)
                        end
                        return retval
                    end,
                },
            })
            exports.ox_target:addModel(Config.Items["zatminingrack"].model, {
                {
                    icon    =  'fas fa-sim-card',
                    label   =  _U("chec_gp"),
                    onSelect = function(data)
                        local Data = {
                            entity = data.entity,
                            inv    = 'rk-gpu'
                        }
                        TriggerEvent('zat-desktop:client:OpenStash', Data)
                    end,
                },
                {
                    icon    =  'fas fa-sim-card',
                    label   =  _U("chec_ps"),
                    onSelect = function(data)
                        local Data = {
                            entity = data.entity,
                            inv    = 'rk-ps'
                        }
                        TriggerEvent('zat-desktop:client:OpenStash', Data)
                    end,
                },
                {
                    icon    =  'fas fa-sim-card',
                    label   =  _U("chec_mb"),
                    onSelect = function(data)
                        local Data = {
                            entity = data.entity,
                            inv    = 'rk-mb'
                        }
                        TriggerEvent('zat-desktop:client:OpenStash', Data)
                    end,
                },
                {
                    icon    =  'fas fa-up-down-left-right',
                    label   =  _U("trg_mov"),
                    onSelect = function(data)
                        local Data = {
                            entity  = data.entity,
                            id      = GetRackIdFromEntity(data.entity),
                            what    = 'rack'
                        }
                        TriggerEvent('zat-desktop:client:Move', Data)
                    end,
                },
                {
                    icon    =  'fas fa-xmark',
                    label   =  _U("trg_str"),
                    onSelect = function(data)
                        local Data = {
                            entity = data.entity,
                            id     = GetRackIdFromEntity(data.entity),
                            what   = 'rack'
                        }
                        TriggerEvent('zat-desktop:client:Destroy', Data)
                    end,
                    canInteract = function(entity)
                        local retval = nil
                        TriggerServerCallback('zat-desktop:server:CanIStoreRack', function(result)
                            retval = result
                        end, GetRackIdFromEntity(entity))
                        while retval == nil do
                            Citizen.Wait(10)
                        end
                        return retval
                    end,
                },
            })
            exports.ox_target:addModel(Config.DroneProp, {
                {
                    icon    =  'fas fa-fly',
                    label   =  _U("trg_ope"),
                    onSelect = function(data)
                        local Data = {
                            entity = data.entity,
                            inv    = 'drone'
                        }
                        TriggerEvent('zat-desktop:client:OpenStash', Data)
                    end,
                },
            })
            exports.ox_target:addModel(Config.Items["zatbaskets"].model, {
                {
                    icon    =  'fas fa-box-archive',
                    label   =  _U("trg_ope"),
                    onSelect = function(data)
                        local Data = {
                            entity = data.entity,
                            inv    = 'baskets'
                        }
                        TriggerEvent('zat-desktop:client:OpenStash', Data)
                    end,
                },
                {
                    icon    =  'fas fa-up-down-left-right',
                    label   =  _U("trg_mov"),
                    onSelect = function(data)
                        local Data = {
                            entity  = data.entity,
                            id      = GetBasketIdFromEntity(data.entity),
                            what    = 'baskets'
                        }
                        TriggerEvent('zat-desktop:client:Move', Data)
                    end,
                },
                {
                    icon    =  'fas fa-xmark',
                    label   =  _U("trg_str"),
                    onSelect = function(data)
                        local Data = {
                            entity = data.entity,
                            id      = GetBasketIdFromEntity(data.entity),
                            what   = 'baskets'
                        }
                        TriggerEvent('zat-desktop:client:Destroy', Data)
                    end,
                    canInteract = function(entity)
                        local retval = nil
                        TriggerServerCallback('zat-desktop:server:CanIStoreBasket', function(result)
                            retval = result
                        end, GetBasketIdFromEntity(entity))
                        while retval == nil do
                            Citizen.Wait(50)
                        end
                        return retval
                    end,
                },
            })
            exports.ox_target:addModel(Config.Items["zatbasketm"].model, {
                {
                    icon    =  'fas fa-box-archive',
                    label   =  _U("trg_ope"),
                    onSelect = function(data)
                        local Data = {
                            entity = data.entity,
                            inv    = 'basketm'
                        }
                        TriggerEvent('zat-desktop:client:OpenStash', Data)
                    end,
                },
                {
                    icon    =  'fas fa-up-down-left-right',
                    label   =  _U("trg_mov"),
                    onSelect = function(data)
                        local Data = {
                            entity  = data.entity,
                            id      = GetBasketIdFromEntity(data.entity),
                            what    = 'basketm'
                        }
                        TriggerEvent('zat-desktop:client:Move', Data)
                    end,
                },
                {
                    icon    =  'fas fa-xmark',
                    label   =  _U("trg_str"),
                    onSelect = function(data)
                        local Data = {
                            entity = data.entity,
                            id      = GetBasketIdFromEntity(data.entity),
                            what   = 'basketm'
                        }
                        TriggerEvent('zat-desktop:client:Destroy', Data)
                    end,
                    canInteract = function(entity)
                        local retval = nil
                        TriggerServerCallback('zat-desktop:server:CanIStoreBasket', function(result)
                            retval = result
                        end, GetBasketIdFromEntity(entity))
                        while retval == nil do
                            Citizen.Wait(50)
                        end
                        return retval
                    end,
                },
            })
            exports.ox_target:addModel(Config.Items["zatminingfan"].model, {
                {
                    icon    =  'fas fa-up-down-left-right',
                    label   =  _U("trg_mov"),
                    onSelect = function(data)
                        local Data = {
                            entity  = data.entity,
                            id      = GetFanIdFromEntity(data.entity),
                            what    = 'fan'
                        }
                        TriggerEvent('zat-desktop:client:Move', Data)
                    end,
                },
                {
                    icon    =  'fas fa-xmark',
                    label   =  _U("trg_str"),
                    onSelect = function(data)
                        local Data = {
                            entity = data.entity,
                            id     = GetFanIdFromEntity(data.entity),
                            what   = 'fan'
                        }
                        TriggerEvent('zat-desktop:client:Destroy', Data)
                    end,
                    
                },
            })   
        end
    end
end)