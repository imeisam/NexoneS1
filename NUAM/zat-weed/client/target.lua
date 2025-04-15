local QBCore = nil

Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports[Config.FrameworkPseudo]:GetCoreObject()
    end
end)

CreateThread(function()
    exports['qb-target']:AddTargetModel({GetHashKey(Config.FanProps[1])}, {
        options = {
            {
                type    =  'client',
                event   =  'zat-weed:client:StoreItem',
                icon    =  'fas fa-fan',
                label   =  _U("str_fan"),
                name    =  'zatfan01'
            },
            {
                type    =  'client',
                event   =  'zat-weed:client:Move',
                icon    =  'fas fa-up-down-left-right',
                label   =  _U("mv_obje")
            }
        },
        distance = 1.5, 
    })

    exports['qb-target']:AddTargetModel({GetHashKey(Config.FanProps[2])}, {
        options = {
            {
                type    =  'client',
                event   =  'zat-weed:client:StoreItem',
                icon    =  'fas fa-fan',
                label   =  _U("str_fan"),
                name    =  'zatresfan'
            },
            {
                type    =  'client',
                event   =  'zat-weed:client:Move',
                icon    =  'fas fa-up-down-left-right',
                label   =  _U("mv_obje")
            }
        },
        distance = 1.5, 
    })

    exports['qb-target']:AddTargetModel({GetHashKey(Config.FanProps[3])}, {
        options = {
            {
                type    =  'client',
                event   =  'zat-weed:client:StoreItem',
                icon    =  'fas fa-fan',
                label   =  _U("str_fan"),
                name    =  'zatwallfan'
            },
            {
                type    =  'client',
                event   =  'zat-weed:client:Move',
                icon    =  'fas fa-up-down-left-right',
                label   =  _U("mv_obje")
            }
        },
        distance = 1.5, 
    })

    exports['qb-target']:AddTargetModel({GetHashKey(Config.HeaterProps[1])}, {
        options = {
            {
                type    =  'client',
                event   =  'zat-weed:client:StoreItem',
                icon    =  'fas fa-temperature-empty',
                label   =  _U("str_hea"),
                name    =  'zatheater'
            },
            {
                type    =  'client',
                event   =  'zat-weed:client:Move',
                icon    =  'fas fa-up-down-left-right',
                label   =  _U("mv_obje")
            }
        },
        distance = 1.5, 
    })

    exports['qb-target']:AddTargetModel({GetHashKey(Config.HeaterProps[2])}, {
        options = {
            {
                type    =  'client',
                event   =  'zat-weed:client:StoreItem',
                icon    =  'fas fa-temperature-empty',
                label   =  _U("str_hea"),
                name    =  'zatpatioheater'
            },
            {
                type    =  'client',
                event   =  'zat-weed:client:Move',
                icon    =  'fas fa-up-down-left-right',
                label   =  _U("mv_obje")
            }
        },
        distance = 1.5, 
    })

    exports['qb-target']:AddTargetModel({GetHashKey(Config.LightProps[1])}, {
        options = {
            {
                type    =  'client',
                event   =  'zat-weed:client:StoreItem',
                icon    =  'fas fa-lightbulb',
                label   =  _U("str_lig"),
                name    =  'zatwalllight'
            },
            {
                type    =  'client',
                event   =  'zat-weed:client:Move',
                icon    =  'fas fa-up-down-left-right',
                label   =  _U("mv_obje")
            }
        },
        distance = 3.0, 
    })

    exports['qb-target']:AddTargetModel({GetHashKey(Config.LightProps[2])}, {
        options = {
            {
                type    =  'client',
                event   =  'zat-weed:client:StoreItem',
                icon    =  'fas fa-lightbulb',
                label   =  _U("str_lig"),
                name    =  'zatceilinglight'
            },
            {
                type    =  'client',
                event   =  'zat-weed:client:Move',
                icon    =  'fas fa-up-down-left-right',
                label   =  _U("mv_obje")
            }
        },
        distance = 3.0, 
    })

    exports['qb-target']:AddTargetModel({GetHashKey(Config.LightProps[3])}, {
        options = {
            {
                type    =  'client',
                event   =  'zat-weed:client:StoreItem',
                icon    =  'fas fa-lightbulb',
                label   =  _U("str_lig"),
                name    =  'zatbluelight'
            },
            {
                type    =  'client',
                event   =  'zat-weed:client:Move',
                icon    =  'fas fa-up-down-left-right',
                label   =  _U("mv_obje")
            }
        },
        distance = 3.0, 
    })
    if Config.Inventory == "qs" then
        exports['qb-target']:AddTargetModel(Config.PlanterProps[1], {
            options = {
                {
                    type    =  'client',
                    event   =  'zat-weed:client:StoreItem',
                    icon    =  'fas fa-box',
                    label   =  _U("str_pla"),
                    name    =  'zatplanter',
                    canInteract = function(entity)
                        local retval = true
                        if Config.Framework == "qb" then
                            QBCore.Functions.TriggerCallback('zat-weed:server:CheckIfEntityIsLinked', function(linked)
                                retval = not linked
                            end, NetworkGetNetworkIdFromEntity(entity), 'planter')
                        elseif Config.Framework == "esx" then
                            ESX.TriggerServerCallback('zat-weed:server:CheckIfEntityIsLinked', function(linked)
                                retval = not linked
                            end, NetworkGetNetworkIdFromEntity(entity), 'planter')
                        end
                        Citizen.Wait(100)
                        return retval
                    end,
                },
                {
                    type    =  'client',
                    event   =  'zat-weed:client:Move',
                    icon    =  'fas fa-up-down-left-right',
                    label   =  _U("mv_obje"),
                    canInteract = function(entity)
                        local retval = true
                        if Config.Framework == "qb" then
                            QBCore.Functions.TriggerCallback('zat-weed:server:CheckIfEntityIsLinked', function(linked)
                                retval = not linked
                            end, NetworkGetNetworkIdFromEntity(entity), 'planter')
                        elseif Config.Framework == "esx" then
                            ESX.TriggerServerCallback('zat-weed:server:CheckIfEntityIsLinked', function(linked)
                                retval = not linked
                            end, NetworkGetNetworkIdFromEntity(entity), 'planter')
                        end
                        Citizen.Wait(100)
                        return retval
                    end,
                },
                {
                    type    =  'client',
                    icon    =  'fas fa-plant-wilt',
                    label   =  _U("pro_nut"),
                    canInteract = function(entity)
                        local retval = true
                        local hasitem = false
                        if Config.Framework == "qb" then
                            QBCore.Functions.TriggerCallback('zat-weed:server:CheckIfEntityIsLinked', function(linked)
                                retval = linked
                                local items = exports['qs-inventory']:getUserInventory()
                                for k, v in pairs(items) do
                                    print (v.name)
                                    if v.name == 'zatweednutrition' then
                                        hasitem = true
                                        return
                                    end
                                end
                            end, NetworkGetNetworkIdFromEntity(entity), 'planter')
                        elseif Config.Framework == "esx" then
                            ESX.TriggerServerCallback('zat-weed:server:CheckIfEntityIsLinked', function(linked)
                                retval = linked
                                local items = exports['qs-inventory']:getUserInventory()
                                for k, v in pairs(items) do
                                    if v.name == 'zatweednutrition' then
                                        hasitem = true
                                        return
                                    end
                                end
                            end, NetworkGetNetworkIdFromEntity(entity), 'planter')
                        end
                        Citizen.Wait(100)
                        return (retval and hasitem)
                    end,
                    action = function(entity)
                        FertilizingProgressBar(entity)
                    end
                }
            },
            distance = 1.5, 
        })
    else
        exports['qb-target']:AddTargetModel({GetHashKey(Config.PlanterProps[1])}, {
            options = {
                {
                    type    =  'client',
                    event   =  'zat-weed:client:StoreItem',
                    icon    =  'fas fa-box',
                    label   =  _U("str_pla"),
                    name    =  'zatplanter',
                    canInteract = function(entity)
                        local retval = true
                        if Config.Framework == "qb" then
                            QBCore.Functions.TriggerCallback('zat-weed:server:CheckIfEntityIsLinked', function(linked)
                                retval = not linked
                            end, NetworkGetNetworkIdFromEntity(entity), 'planter')
                        elseif Config.Framework == "esx" then
                            ESX.TriggerServerCallback('zat-weed:server:CheckIfEntityIsLinked', function(linked)
                                retval = not linked
                            end, NetworkGetNetworkIdFromEntity(entity), 'planter')
                        end
                        Citizen.Wait(100)
                        return retval
                    end,
                },
                {
                    type    =  'client',
                    event   =  'zat-weed:client:Move',
                    icon    =  'fas fa-up-down-left-right',
                    label   =  _U("mv_obje"),
                    canInteract = function(entity)
                        local retval = true
                        if Config.Framework == "qb" then
                            QBCore.Functions.TriggerCallback('zat-weed:server:CheckIfEntityIsLinked', function(linked)
                                retval = not linked
                            end, NetworkGetNetworkIdFromEntity(entity), 'planter')
                        elseif Config.Framework == "esx" then
                            ESX.TriggerServerCallback('zat-weed:server:CheckIfEntityIsLinked', function(linked)
                                retval = not linked
                            end, NetworkGetNetworkIdFromEntity(entity), 'planter')
                        end
                        Citizen.Wait(100)
                        return retval
                    end,
                },
                {
                    type    =  'client',
                    icon    =  'fas fa-plant-wilt',
                    label   =  _U("pro_nut"),
                    item    =  'zatweednutrition',
                    canInteract = function(entity)
                        local retval = true
                        if Config.Framework == "qb" then
                            QBCore.Functions.TriggerCallback('zat-weed:server:CheckIfEntityIsLinked', function(linked)
                                retval = linked
                            end, NetworkGetNetworkIdFromEntity(entity), 'planter')
                        elseif Config.Framework == "esx" then
                            ESX.TriggerServerCallback('zat-weed:server:CheckIfEntityIsLinked', function(linked)
                                retval = linked
                            end, NetworkGetNetworkIdFromEntity(entity), 'planter')
                        end
                        Citizen.Wait(100)
                        return retval
                    end,
                    action = function(entity)
                        FertilizingProgressBar(entity)
                    end
                }
            },
            distance = 1.5, 
        })
    end
    if Config.Inventory == "qs" then
        exports['qb-target']:AddTargetModel(Config.PlanterProps[5], {
            options = {
                {
                    type    =  'client',
                    event   =  'zat-weed:client:StoreItem',
                    icon    =  'fas fa-bottle-water',
                    label   =  _U("str_fiw"),
                    name    =  'zatwatersetup',
                    canInteract = function(entity)
                        local retval = true
                        if Config.Framework == "qb" then
                            QBCore.Functions.TriggerCallback('zat-weed:server:CheckIfEntityIsLinked', function(linked)
                                retval = not linked
                            end, NetworkGetNetworkIdFromEntity(entity), 'watersetup')
                        elseif Config.Framework == "esx" then
                            ESX.TriggerServerCallback('zat-weed:server:CheckIfEntityIsLinked', function(linked)
                                retval = not linked
                            end, NetworkGetNetworkIdFromEntity(entity), 'watersetup')
                        end
                        Citizen.Wait(100)
                        return retval
                    end,
                },
                {
                    type    =  'client',
                    icon    =  'fas fa-plant-wilt',
                    label   =  _U("fil_wtr"),
                    canInteract = function(entity)
                        local retval = true
                        local hasitem = false
                        if Config.Framework == "qb" then
                            QBCore.Functions.TriggerCallback('zat-weed:server:CheckIfEntityIsLinked', function(linked)
                                retval = linked
                                local items = exports['qs-inventory']:getUserInventory()
                                for k, v in pairs(items) do
                                    if v.name == 'zatwaterbottlefull' then
                                        hasitem = true
                                        return
                                    end
                                end
                                print  (hasitem)
                            end, NetworkGetNetworkIdFromEntity(entity), 'watersetup')
                        elseif Config.Framework == "esx" then
                            ESX.TriggerServerCallback('zat-weed:server:CheckIfEntityIsLinked', function(linked)
                                retval = linked
                                local items = exports['qs-inventory']:getUserInventory()
                                for k, v in pairs(items) do
                                    if v.name == 'zatwaterbottlefull' then
                                        hasitem = true
                                        return
                                    end
                                end
                            end, NetworkGetNetworkIdFromEntity(entity), 'watersetup')
                        end
                        Citizen.Wait(100)
                        return (retval and hasitem)
                    end,
                    action = function(entity)
                        FillingWaterSetupProgressBar(entity)
                    end
                }
            },
            distance = 1.5, 
        })
    else
        exports['qb-target']:AddTargetModel({GetHashKey(Config.PlanterProps[5])}, {
            options = {
                {
                    type    =  'client',
                    event   =  'zat-weed:client:StoreItem',
                    icon    =  'fas fa-bottle-water',
                    label   =  _U("str_fiw"),
                    name    =  'zatwatersetup',
                    canInteract = function(entity)
                        local retval = true
                        if Config.Framework == "qb" then
                            QBCore.Functions.TriggerCallback('zat-weed:server:CheckIfEntityIsLinked', function(linked)
                                retval = not linked
                            end, NetworkGetNetworkIdFromEntity(entity), 'watersetup')
                        elseif Config.Framework == "esx" then
                            ESX.TriggerServerCallback('zat-weed:server:CheckIfEntityIsLinked', function(linked)
                                retval = not linked
                            end, NetworkGetNetworkIdFromEntity(entity), 'watersetup')
                        end
                        Citizen.Wait(100)
                        return retval
                    end,
                },
                {
                    type    =  'client',
                    icon    =  'fas fa-plant-wilt',
                    label   =  _U("fil_wtr"),
                    item    =  'zatwaterbottlefull',
                    canInteract = function(entity)
                        local retval = true
                        if Config.Framework == "qb" then
                            QBCore.Functions.TriggerCallback('zat-weed:server:CheckIfEntityIsLinked', function(linked)
                                retval = linked
                            end, NetworkGetNetworkIdFromEntity(entity), 'watersetup')
                        elseif Config.Framework == "esx" then
                            ESX.TriggerServerCallback('zat-weed:server:CheckIfEntityIsLinked', function(linked)
                                retval = linked
                            end, NetworkGetNetworkIdFromEntity(entity), 'watersetup')
                        end
                        Citizen.Wait(100)
                        return retval
                    end,
                    action = function(entity)
                        FillingWaterSetupProgressBar(entity)
                    end
                }
            },
            distance = 1.5, 
        })
    end

    exports['qb-target']:AddTargetModel({GetHashKey(Config.PlanterProps[2])}, {
        options = {
            {
                type    =  'client',
                event   =  'zat-weed:client:StoreItem',
                icon    =  'fas fa-box',
                label   =  _U("str_wrc"),
                name    =  'zatweedrackxs',
                canInteract = function(entity)
                    local retval = true
                    if Config.Framework == "qb" then
                        QBCore.Functions.TriggerCallback('zat-weed:server:IsStashFull', function(result)
                            retval = not result
                        end, NetworkGetNetworkIdFromEntity(entity), "RackDryer_")
                    elseif Config.Framework == "esx" then
                        ESX.TriggerServerCallback('zat-weed:server:IsStashFull', function(result)
                            retval = not result
                        end, NetworkGetNetworkIdFromEntity(entity), "RackDryer_")
                    end
                    Citizen.Wait(100)
                    return retval
                end,
            },
            {
                type    =  'client',
                event   =  'zat-weed:client:Move',
                icon    =  'fas fa-up-down-left-right',
                label   =  _U("mv_obje"),
                canInteract = function(entity)
                    local retval = true
                    if Config.Framework == "qb" then
                        QBCore.Functions.TriggerCallback('zat-weed:server:IsStashFull', function(result)
                            retval = not result
                        end, NetworkGetNetworkIdFromEntity(entity), "RackDryer_")
                    elseif Config.Framework == "esx" then
                        ESX.TriggerServerCallback('zat-weed:server:IsStashFull', function(result)
                            retval = not result
                        end, NetworkGetNetworkIdFromEntity(entity), "RackDryer_")
                    end
                    Citizen.Wait(100)
                    return retval
                end,
            },
            {
                type    =  'client',
                event   =  'zat-weed:client:OpenStash',
                icon    =  'fas fa-store',
                label   =  _U("ope_rac"),
                slots   = 3
            }

            
        },
        distance = 1.5, 
    })

    exports['qb-target']:AddTargetModel({GetHashKey(Config.PlanterProps[3])}, {
        options = {
            {
                type    =  'client',
                event   =  'zat-weed:client:StoreItem',
                icon    =  'fas fa-box',
                label   =  _U("str_wrc"),
                name    =  'zatweedracks',
                canInteract = function(entity)
                    local retval = true
                    if Config.Framework == "qb" then
                        QBCore.Functions.TriggerCallback('zat-weed:server:IsStashFull', function(result)
                            retval = not result
                        end, NetworkGetNetworkIdFromEntity(entity), "RackDryer_")
                    elseif Config.Framework == "esx" then
                        ESX.TriggerServerCallback('zat-weed:server:IsStashFull', function(result)
                            retval = not result
                        end, NetworkGetNetworkIdFromEntity(entity), "RackDryer_")
                    end
                    Citizen.Wait(100)
                    return retval
                end,
            },
            {
                type    =  'client',
                event   =  'zat-weed:client:Move',
                icon    =  'fas fa-up-down-left-right',
                label   =  _U("mv_obje"),
                canInteract = function(entity)
                    local retval = true
                    if Config.Framework == "qb" then
                        QBCore.Functions.TriggerCallback('zat-weed:server:IsStashFull', function(result)
                            retval = not result
                        end, NetworkGetNetworkIdFromEntity(entity), "RackDryer_")
                    elseif Config.Framework == "esx" then
                        ESX.TriggerServerCallback('zat-weed:server:IsStashFull', function(result)
                            retval = not result
                        end, NetworkGetNetworkIdFromEntity(entity), "RackDryer_")
                    end
                    Citizen.Wait(100)
                    return retval
                end,
            },
            {
                type    =  'client',
                event   =  'zat-weed:client:OpenStash',
                icon    =  'fas fa-store',
                label   =  _U("ope_rac"),
                slots   = 5
            }
        },
        distance = 1.5, 
    })

    -- Plants

    exports['qb-target']:AddTargetModel({GetHashKey(Config.WeedProps[1])}, {
        options = {
            {
                type    =  'client',
                event   =  'zat-weed:client:CheckPlant',
                icon    =  'fas fa-cannabis',
                label   =  _U("che_pla"),
            },
        },
        distance = 1.5, 
    })

    exports['qb-target']:AddTargetModel({GetHashKey(Config.WeedProps[2])}, {
        options = {
            {
                type    =  'client',
                event   =  'zat-weed:client:CheckPlant',
                icon    =  'fas fa-cannabis',
                label   =  _U("che_pla"),
            },
            {
                type    =  'client',
                event   =  'zat-weed:client:ClonePlant',
                icon    =  'fas fa-cannabis',
                label   =  _U("clo_pla"),
            },
        },
        distance = 1.5, 
    })

    exports['qb-target']:AddTargetModel({GetHashKey(Config.WeedProps[3])}, {
        options = {
            {
                type    =  'client',
                event   =  'zat-weed:client:CheckPlant',
                icon    =  'fas fa-cannabis',
                label   =  _U("che_pla"),
            },
        },
        distance = 1.5, 
    })

    exports['qb-target']:AddTargetModel({GetHashKey(Config.WeedProps[4])}, {
        options = {
            {
                type    =  'client',
                event   =  'zat-weed:client:CheckPlant',
                icon    =  'fas fa-cannabis',
                label   =  _U("che_pla"),
            },
        },
        distance = 1.5, 
    })

    exports['qb-target']:AddTargetModel({GetHashKey(Config.WeedProps[5])}, {
        options = {
            {
                type    =  'client',
                event   =  'zat-weed:client:CheckPlant',
                icon    =  'fas fa-cannabis',
                label   =  _U("che_pla"),
            },
            {
                type    =  'client',
                event   =  'zat-weed:client:Harvest',
                icon    =  'fas fa-cannabis',
                label   =  _U("harv_pl"),
                -- canInteract = function(entity)
                --     local retval = false
                --     if Config.Framework == "qb" then
                --         QBCore.Functions.TriggerCallback('zat-weed:server:GetPlantData', function(result)
                --             if (result.growth >= 100) then
                --                 retval = true
                --             end
                --         end, NetworkGetNetworkIdFromEntity(entity))
                --     elseif Config.Framework == "esx" then
                --         ESX.TriggerServerCallback('zat-weed:server:GetPlantData', function(result)
                --             if (result.growth >= 100) then
                --                 retval = true
                --             end
                --         end, NetworkGetNetworkIdFromEntity(entity))
                --     end
                --     Citizen.Wait(100)
                --     return retval
                -- end,
            },  
        },
        distance = 1.5, 
    })

    exports['qb-target']:AddTargetModel({GetHashKey(Config.PlanterProps[4])}, {
        options = {
            {
                type    =  'client',
                event   =  'zat-weed:client:CreateWeedBrick',
                icon    =  'fas fa-box',
                label   =  _U("mk_weeb"),
            }, 
            {
                type    =  'client',
                event   =  'zat-weed:client:OpenWeedTable',
                icon    =  'fas fa-box',
                label   =  _U("wee_sto"),
                slots   =  10
            }, 
            {
                type    =  'client',
                event   =  'zat-weed:client:StoreItem',
                icon    =  'fas fa-box',
                label   =  _U("str_wta"),
                name    =  'zatweedtable',
                canInteract = function(entity)
                    local retval = true
                    if Config.Framework == "qb" then
                        QBCore.Functions.TriggerCallback('zat-weed:server:IsStashFull', function(result)
                            retval = not result
                        end, NetworkGetNetworkIdFromEntity(entity), "WeedStorage_")
                    elseif Config.Framework == "esx" then
                        ESX.TriggerServerCallback('zat-weed:server:IsStashFull', function(result)
                            retval = not result
                        end, NetworkGetNetworkIdFromEntity(entity), "WeedStorage_")
                    end
                    Citizen.Wait(100)
                    return retval
                end,
            },
            {
                type    =  'client',
                event   =  'zat-weed:client:Move',
                icon    =  'fas fa-up-down-left-right',
                label   =  _U("mv_obje"),
                canInteract = function(entity)
                    local retval = true
                    if Config.Framework == "qb" then
                        QBCore.Functions.TriggerCallback('zat-weed:server:IsStashFull', function(result)
                            retval = not result
                        end, NetworkGetNetworkIdFromEntity(entity), "WeedStorage_")
                    elseif Config.Framework == "esx" then
                        ESX.TriggerServerCallback('zat-weed:server:IsStashFull', function(result)
                            retval = not result
                        end, NetworkGetNetworkIdFromEntity(entity), "WeedStorage_")
                    end
                    Citizen.Wait(100)
                    return retval
                end,
            },
        },
        distance = 1.5, 
    })
end)