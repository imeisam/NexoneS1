local QBCore = exports['qb-core']:GetCoreObject()
local highriskdeliveryped
local highriskblip
RegisterNetEvent('sam-jewelryrun:server:highriskprestart', function()
    if exports['qb-cooldown']:isCooldown() then
             QBCore.Functions.TriggerCallback('qb-storerobbery:server:gethighriskcooldown', function(res)
                        if res then
                            if not exports["qb-smallresources"]:getdevelopermode() and config.highrisk.policerequire>CurrentCops then
                                QBCore.Functions.Notify("Not Enough Police", "error")
                                return
                            end
                            TriggerEvent('sam-jewelryrun:client:starthighrisk')
                        else
                            QBCore.Functions.Notify('Not Allow this time...', 'error')
                            return
                        end
             end)
    end
end)
CurrentCops=0
RegisterNetEvent('police:SetCopCount', function(amount,amounthigh)
    CurrentCops = amount
end)
RegisterNetEvent('sam-jewelryrun:client:starthighrisk', function()
    if robstart then
        QBCore.Functions.Notify('Rob Already started...', 'error')
        return
    end
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasitem)
        if not hasitem then
            QBCore.Functions.Notify('Not Enough Assorted Jewelry...!', 'error')
            return 
        end
        QBCore.Functions.TriggerCallback('sam-jewelryrun:server:checkbusyhighrisk', function(result)
            if not result then
                QBCore.Functions.Notify('Not Allowed this time...!', 'error')
                return 
            end

            TriggerServerEvent("QBCore:Server:RemoveItem", 'assortedjewelry',config.highrisk.itemneed)
            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['assortedjewelry'], "remove", config.highrisk.itemneed)

            robstart=true
            CreateThread(function()
                Wait(config.highrisk.requesttimeout)
                robstart=false
                if not finished then
                    if highriskdeliveryped then
                        DeletePed(highriskdeliveryped)
                    end
                    exports["nxo-oui"]:Close()
                end
            end)
            
            highrisknpc={}
            highriskobject={}

            RequestModel('csb_car3guy1')
            while not HasModelLoaded(GetHashKey('csb_car3guy1')) do
                Wait(1)
            end
            RequestModel('prop_boxpile_01a')
            while not HasModelLoaded(GetHashKey('prop_boxpile_01a')) do
                Wait(1)
            end
            
            AddRelationshipGroup('GuardPedsjewl')
            for i = 1, #config.highrisklocation do
                exports["nxo-oui"]:Show('Task', '<b>Mission 0/2</b> <br/>Go to a Danger Point')
                highriskblip= AddBlipForCoord(config.highrisklocation[i].npccoord1.x, config.highrisklocation[i].npccoord1.y,config.highrisklocation[i].npccoord1.z-1)
             SetBlipColour(highriskblip, 3)
             SetBlipRoute(highriskblip, true)
             SetBlipRouteColour(highriskblip, 3)
            
             highrisknpc[#highrisknpc+1] = CreatePed(26, GetHashKey('csb_car3guy1'), vector3(config.highrisklocation[i].npccoord1.x,config.highrisklocation[i].npccoord1.y,config.highrisklocation[i].npccoord1.z-1), config.highrisklocation[i].npccoord1.w, true, true)
             NetworkRegisterEntityAsNetworked(highrisknpc[#highrisknpc])
             networkID = NetworkGetNetworkIdFromEntity(highrisknpc[#highrisknpc])
             SetNetworkIdCanMigrate(networkID, true)
             SetNetworkIdExistsOnAllMachines(networkID, true)
             SetPedRandomComponentVariation(highrisknpc[#highrisknpc], 0)
             SetPedRandomProps(highrisknpc[#highrisknpc])
             SetEntityAsMissionEntity(highrisknpc[#highrisknpc])
             SetEntityVisible(highrisknpc[#highrisknpc], true)
             SetPedRelationshipGroupHash(highrisknpc[#highrisknpc],GetHashKey("GuardPedsjewl"))
             SetPedAccuracy(highrisknpc[#highrisknpc], 50)
             SetPedArmour(highrisknpc[#highrisknpc], 100)
             SetPedCanSwitchWeapon(highrisknpc[#highrisknpc], true)
             SetPedDropsWeaponsWhenDead(highrisknpc[#highrisknpc], false)
             SetPedFleeAttributes(highrisknpc[#highrisknpc], 0, false)
             GiveWeaponToPed(highrisknpc[#highrisknpc], GetHashKey('WEAPON_PISTOL'), 255, false, false)
                
             highrisknpc[#highrisknpc+1] = CreatePed(26, GetHashKey('csb_car3guy1'), vector3(config.highrisklocation[i].npccoord2.x,config.highrisklocation[i].npccoord2.y,config.highrisklocation[i].npccoord2.z-1), config.highrisklocation[i].npccoord2.w, true, true)
             NetworkRegisterEntityAsNetworked(highrisknpc[#highrisknpc])
             networkID = NetworkGetNetworkIdFromEntity(highrisknpc[#highrisknpc])
             SetNetworkIdCanMigrate(networkID, true)
             SetNetworkIdExistsOnAllMachines(networkID, true)
             SetPedRandomComponentVariation(highrisknpc[#highrisknpc], 0)
             SetPedRandomProps(highrisknpc[#highrisknpc])
             SetEntityAsMissionEntity(highrisknpc[#highrisknpc])
             SetEntityVisible(highrisknpc[#highrisknpc], true)
             SetPedRelationshipGroupHash(highrisknpc[#highrisknpc],GetHashKey("GuardPedsjewl"))
             SetPedAccuracy(highrisknpc[#highrisknpc], 50)
             SetPedArmour(highrisknpc[#highrisknpc], 100)
             SetPedCanSwitchWeapon(highrisknpc[#highrisknpc], true)
             SetPedDropsWeaponsWhenDead(highrisknpc[#highrisknpc], false)
             SetPedFleeAttributes(highrisknpc[#highrisknpc], 0, false)
             GiveWeaponToPed(highrisknpc[#highrisknpc], GetHashKey('WEAPON_PISTOL'), 255, false, false)
             TaskGuardCurrentPosition(highrisknpc[#highrisknpc], 10.0, 10.0, 1)

            SetRelationshipBetweenGroups(0, GetHashKey("GuardPedsjewl"), GetHashKey("GuardPedsjewl"))
            SetRelationshipBetweenGroups(5, GetHashKey("GuardPedsjewl"), GetHashKey("PLAYER"))
            SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("GuardPedsjewl"))

             for k, v in pairs(config.highrisklocation[i].boxcoord) do
               highriskobject[#highriskobject+1]= CreateObject(GetHashKey('prop_boxpile_01a'),vector3(v.x,v.y,v.z-1), 1, 1, 0)
                SetEntityHeading( highriskobject[#highriskobject],v.w)
                FreezeEntityPosition( highriskobject[#highriskobject], true)
               local netid = ObjToNet( highriskobject[#highriskobject])
                SetNetworkIdExistsOnAllMachines( highriskobject[#highriskobject], true)
               NetworkSetNetworkIdDynamic( highriskobject[#highriskobject], true)
               SetNetworkIdCanMigrate( highriskobject[#highriskobject], false)

               exports['qb-target']:AddTargetEntity( highriskobject[#highriskobject], {
                options = {
                    {
                        event = "sam-jewelryrun:client:takeabox",
                        icon = "fas fa-cash-register",
                        label = "Take a Box",
                        obj=highriskobject[#highriskobject],
                        canInteract = function(entity)
                            return robstart
                        end,
                    },
                },
                distance = 1.5
            })

             end

             dist=1000
               while dist>10 do 
                 dist=#(GetEntityCoords(PlayerPedId())-vector3(config.highrisklocation[i].npccoord1.x,config.highrisklocation[i].npccoord1.y,config.highrisklocation[i].npccoord1.z-1))
                 Wait(100)
                end
                RemoveBlip(highriskblip)
            end
            exports["nxo-oui"]:Show('Task', '<b>Mission 1/2</b> <br/>Go to a Delivery Point')
            Wait(100)
            highriskblip= AddBlipForCoord(config.normal.deliverynpccoord.x, config.normal.deliverynpccoord.y,config.normal.deliverynpccoord.z-1)
            SetBlipColour(highriskblip, 3)
            SetBlipRoute(highriskblip, true)
            SetBlipRouteColour(highriskblip, 3)

            
            dist=1000
            while dist>10 do 
                dist=#(GetEntityCoords(PlayerPedId())-vector3(config.normal.deliverynpccoord.x,config.normal.deliverynpccoord.y,config.normal.deliverynpccoord.z-1))
                Wait(100)
            end

            local pedmodel = GetHashKey('csb_car3guy1')
            RequestModel(pedmodel)
            while not HasModelLoaded(pedmodel) do
                Wait(1)
            end

            highriskdeliveryped = CreatePed(4, pedmodel,config.normal.deliverynpccoord.x,config.normal.deliverynpccoord.y,config.normal.deliverynpccoord.z-1, false, true)
            SetEntityInvincible(highriskdeliveryped, true)
            FreezeEntityPosition(highriskdeliveryped, true)
            SetBlockingOfNonTemporaryEvents(highriskdeliveryped, true)
            TaskStartScenarioInPlace(highriskdeliveryped, 'WORLD_HUMAN_GUARD_STAND', 0, true)
            SetEntityHeading(highriskdeliveryped,config.normal.deliverynpccoord.w)
            exports["nxo-oui"]:Show('Task', '<b>Mission 2/2</b> <br/>Give a Packages')
            exports['qb-target']:AddTargetEntity(highriskdeliveryped, {
                options = {
                    {
                        event = "sam-jewelryrun:client:deliverypackagehighrisk",
                        icon = "fas fa-cash-register",
                        label = "Deliver Package",
                    },
                },
                distance = 1.5
            })

            RemoveBlip(highriskblip)
        end)

    end,'assortedjewelry',config.highrisk.itemneed)
end)

RegisterNetEvent('sam-jewelryrun:client:takeabox', function(data)
    ExecuteCommand('e search')
    QBCore.Functions.Progressbar("searchbox", "Search in box..", math.random(3000, 5000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
     DeleteEntity(data.obj)
    TriggerServerEvent("QBCore:Server:AddItem", 'stolengoods',config.highrisk.giveitem)
    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['stolengoods'], "add",config.highrisk.giveitem)
    ExecuteCommand('e c')
    end, function()
        ExecuteCommand('e c')
        QBCore.Functions.Notify("Canceled..", "error")
    end)

   
end)


RegisterNetEvent('sam-jewelryrun:client:deliverypackagehighrisk', function()
    if not robstart then
        QBCore.Functions.Notify('Not Allowed...!!!', 'error')
        return
    end

    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasitem)
        if not hasitem then
            QBCore.Functions.Notify('Not Enough Item...!', 'error')
            return 
        end
        
        TriggerServerEvent("sam-jewelryrun:server:insertrobed")
        
        print(config.highrisk.finalitemcount)

        TriggerServerEvent("QBCore:Server:RemoveItem", 'stolengoods',config.highrisk.finalitemcount)
        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['stolengoods'], "remove", config.highrisk.finalitemcount)
    
        TriggerServerEvent("QBCore:Server:AddItem", 'cash', config.highrisk.rewarditemcount)
        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['cash'], "add", config.highrisk.rewarditemcount)
        robstart=false
        finished=true
        DeletePed(highriskdeliveryped)
        exports["nxo-oui"]:Close()
    end,'stolengoods',config.highrisk.finalitemcount)
   
   

  
end)


