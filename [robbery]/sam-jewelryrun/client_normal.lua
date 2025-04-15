local QBCore = exports['qb-core']:GetCoreObject()
local robstart=false
local vehicle
local normalblip
local normaldeliveryped 
local finished=false
RegisterNetEvent('sam-jewelryrun:server:normalprestart', function()
                QBCore.Functions.TriggerCallback('qb-storerobbery:server:getnormalcooldown', function(res)
                        if res then
                            TriggerEvent('sam-jewelryrun:client:startnormal')
                        else
                            QBCore.Functions.Notify('Not Allow this time...', 'error')
                            return
                        end
                end)
end)

RegisterNetEvent('sam-jewelryrun:client:startnormal', function()
    if robstart then
        QBCore.Functions.Notify('Rob Already started...', 'error')
        return
    end

    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasitem)
    if not hasitem then
        QBCore.Functions.Notify('Not Enough Assorted Jewelry...!', 'error')
        return 
    end

    QBCore.Functions.TriggerCallback('sam-jewelryrun:server:checkbusynormal', function(result)
     if result>0 then
        TriggerServerEvent('sam-jewelryrun:server:startnormalrob')
    robstart=true
    finished=false
    TriggerServerEvent("QBCore:Server:RemoveItem", 'assortedjewelry',config.normal.itemneed)
	TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['assortedjewelry'], "remove", config.normal.itemneed)

    exports["nxo-oui"]:Show('Task', '<b>Mission 0/2</b> Find Car')
    CreateThread(function()
        Wait(config.normal.requesttimeout)
        if not finished then
            robstart=false
            exports["nxo-oui"]:Close()
        end
    end)
    local model=GetHashKey(config.normal.carmodel)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end

    local coord=config.carscoord[result].coord
 

    normalblip= AddBlipForCoord(coord.x, coord.y,coord.z)
    SetBlipColour(normalblip, 3)
    SetBlipRoute(normalblip, true)
    SetBlipRouteColour(normalblip, 3)

    QBCore.Functions.Notify('Check Map and Find a Car..!', 'info')
    local dist=100
    
    while dist>20 do 
      dist=#(GetEntityCoords(PlayerPedId())-vector3(coord.x,coord.y,coord.z))
      Wait(100)
    end
    vehicle = CreateVehicle(model, coord.x, coord.y, coord.z, coord.w, true, false)
 
    net1 = NetworkGetNetworkIdFromEntity(vehicle)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    SetNetworkIdExistsOnAllMachines(net1, true)
    SetNetworkIdCanMigrate(vehicle, true)
    SetVehicleNeedsToBeHotwired(vehicle, false)
    SetVehRadioStation(vehicle, 'OFF')
    SetModelAsNoLongerNeeded(model)
    local plate =QBCore.Functions.GetPlate(vehicle)
    config.GiveKey(plate)
    config.SetFuel(vehicle, 100.0)

    exports["nxo-oui"]:Show('Task', '<b>Mission 1/2</b> <br/>Now Go to Delivery Location')
    RemoveBlip(normalblip)
    Wait(1000)
     local  normalblip= AddBlipForCoord(config.normal.deliverynpccoord.x, config.normal.deliverynpccoord.y,config.normal.deliverynpccoord.z-1)
    SetBlipColour(normalblip, 3)
    SetBlipRoute(normalblip, true)
    SetBlipRouteColour(normalblip, 3)

    TriggerServerEvent('sam-jewelryrun:server:addnormalitemintrunk',plate)

   
    QBCore.Functions.Notify('Now Again Check Map and deliver the package in this car', 'info')
    dist=100
    while dist>10 do 
        dist=#(GetEntityCoords(PlayerPedId())-vector3(config.normal.deliverynpccoord.x,config.normal.deliverynpccoord.y,config.normal.deliverynpccoord.z-1))
        Wait(100)
    end
      RemoveBlip(normalblip)
      exports["nxo-oui"]:Show('Task', '<b>Mission 2/2</b> <br/>Now Give a Package')
      local pedmodel = GetHashKey('csb_car3guy1')
      RequestModel(pedmodel)
      while not HasModelLoaded(pedmodel) do
          Wait(1)
      end
      normaldeliveryped= CreatePed(4, pedmodel,config.normal.deliverynpccoord.x,config.normal.deliverynpccoord.y,config.normal.deliverynpccoord.z-1, false, true)
      SetEntityInvincible(normaldeliveryped, true)
      FreezeEntityPosition(normaldeliveryped, true)
      SetBlockingOfNonTemporaryEvents(normaldeliveryped, true)
      TaskStartScenarioInPlace(normaldeliveryped, 'WORLD_HUMAN_GUARD_STAND', 0, true)
      SetEntityHeading(normaldeliveryped,config.normal.deliverynpccoord.w)
      exports['qb-target']:AddTargetEntity(normaldeliveryped, {
        options = {
            {
                event = "sam-jewelryrun:client:deliverypackage",
                icon = "fas fa-cash-register",
                label = "Deliver Package",
            },
        },
        distance = 1.5
    })
  end
       
end)
end, "assortedjewelry",config.normal.itemneed)
end)

RegisterNetEvent('sam-jewelryrun:client:deliverypackage', function()
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

        TriggerServerEvent("QBCore:Server:RemoveItem", 'stolengoods', config.normal.packagecount)
        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['stolengoods'], "remove", config.normal.packagecount)
        Wait(200)
        TriggerServerEvent("QBCore:Server:AddItem", 'cash', config.normal.addmoney)
        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['cash'], "add", config.normal.addmoney)
        robstart=false
        finished=true
        DeletePed(normaldeliveryped)
        exports["nxo-oui"]:Close()
    end,'stolengoods',config.normal.packagecount)
   
   

  
end)