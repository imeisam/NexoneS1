local QBCore = exports['qb-core']:GetCoreObject()
local count,sum
local startdelivery=false
local objectsp={}
local deliveryblip={}
RegisterNetEvent('sam-laundrymachine:client:prestartdelivery', function()
    if startdelivery then
        QBCore.Functions.Notify('Alredy Start Delivery...!', 'error')
        return
    end

    QBCore.Functions.TriggerCallback('sam-laundrymachine:server:startdelivery', function(data)
           if data then
            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasitem)
                print(hasitem)
                if not hasitem then
                    QBCore.Functions.Notify('Not Enough Item...!', 'error')
                    return 
                end
              
                TriggerEvent('sam-laundrymachine:client:startdelivery')
               
            end,Config.giveitem,#Config.delivery*Config.washedmoneydelivery)

        else
            QBCore.Functions.Notify('Not Allow this time...!', 'error')
            return
        end
    end)

end)

RegisterNetEvent('sam-laundrymachine:client:startdelivery', function()
    found =false
    local carcoord=nil
 for i=1,#Config.deliverycarspawn,1 do
    carcoord=Config.deliverycarspawn[i]
    local veh, distance = GetClosestVehicle(vector3(carcoord.x,carcoord.y,carcoord.z-1),2.0)
    if veh==0 then
        found=true
        break
    end
 end
     
    if not found then
        QBCore.Functions.Notify('Not Found Empty Spot', "error", 4500)
        return
    end

        startdelivery=true

        CreateThread(function()
            Wait(Config.Deliverytimeout)
            startdelivery=false
            for k, v in pairs(objectsp) do
                DeleteEntity(v.obj)
            end
            for k, v in pairs(deliveryblip) do
                RemoveBlip(v)
            end
            objectsp={}
        end)
        local model=GetHashKey(Config.deliverycarmodel[math.random(1,#Config.deliverycarmodel)])
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(0)
        end
        vehicl = CreateVehicle(model, carcoord.x, carcoord.y, carcoord.z, carcoord.w, true, false)
        net1 = NetworkGetNetworkIdFromEntity(vehicl)
        SetVehicleHasBeenOwnedByPlayer(vehicl, true)
        SetNetworkIdExistsOnAllMachines(net1, true)
        SetNetworkIdCanMigrate(vehicl, true)
        SetVehicleNeedsToBeHotwired(vehicl, false)
        SetVehRadioStation(vehicl, 'OFF')
        SetModelAsNoLongerNeeded(model)
        local plate =QBCore.Functions.GetPlate(vehicl)
        Config.GiveKey(plate)
        Config.SetFuel(vehicl, 100.0)
        sum=#Config.delivery
        count=0
        exports["nxo-oui"]:Show('Task', '<b>Mission '..count..'/'..sum..'</b> <br/>Go to Point')
        for k, v in pairs(Config.delivery) do
            objectsp[k]={}
            objectsp[k].robed=true
            objectsp[k].obj= CreateObject(GetHashKey(Config.moneypropmodel),vector3(v.x, v.y,v.z-1), true,true, 0)
            SetEntityHeading( objectsp[k].obj,v.w)
            FreezeEntityPosition( objectsp[k].obj, true)
            SetEntityCollision( objectsp[k].obj, true, true)

            deliveryblip[k]= AddBlipForCoord(v.x, v.y,v.z-1)
            SetBlipColour( deliveryblip[k], 3)
            SetBlipRoute( deliveryblip[k], true)
            SetBlipRouteColour( deliveryblip[k], 3)
          
                exports['qb-target']:AddTargetEntity(objectsp[k].obj,{
                    options = {
                        {
                            event = "sam-laundrymachine:client:purchesmoney",
                            name = 'washeddelivery..'..k,
                            icon = "fa fa-circle",
                            label = "Purchase $ ".. Config.washedmoneydelivery,
                            targetid=k,
                            canInteract = function(entity)
                                return objectsp[k].robed
                            end,
                        },
                    },
                    distance = 2.0
                })
        end


end)

function GetClosestVehicle(coords,checkdistance)
    local ped = PlayerPedId()
    local vehicles = GetGamePool('CVehicle')
    local closestDistance = 1
    local closestVehicle =0
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    for i = 1, #vehicles, 1 do
        local vehicleCoords = GetEntityCoords(vehicles[i])
        local distance = #(vehicleCoords - coords)

        if checkdistance >= distance then
            closestVehicle = vehicles[i]
            closestDistance = distance
        end
    end
    return closestVehicle, closestDistance
end

RegisterNetEvent('sam-laundrymachine:client:purchesmoney', function(data)
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasitem)
        if not hasitem then
            QBCore.Functions.Notify('Not Enough Item...!', 'error')
            return 
        end
        
        TriggerServerEvent('sam-laundrymachine:server:purchesmoney')
        Wait(500)
        count=count+1
        objectsp[data.targetid].robed=false
        exports["nxo-oui"]:Show('Task', '<b>Mission '..count..'/'..sum..'</b> <br/>Go to Point')
        if count==sum then
            for k, v in pairs(objectsp) do
                DeleteEntity(v.obj)
            end
            for k, v in pairs(deliveryblip) do
                RemoveBlip(v)
            end
            objectsp={}
            exports["nxo-oui"]:Close()
            QBCore.Functions.Notify('Finish Delivery', 'success')
        end

    end,Config.giveitem,1)
end)

RegisterNetEvent('sam-laundrymachine:client:turninmoney', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasitem)
        if not hasitem then
            QBCore.Functions.Notify('Not Enough money order...!', 'error')
            return 
        end
        TriggerServerEvent('sam-laundrymachine:server:turninmoney')

    end,Config.additemdelivery,#Config.delivery*Config.additemdeliverycount)
end)