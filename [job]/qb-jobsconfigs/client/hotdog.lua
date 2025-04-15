local QBCore = exports['qb-core']:GetCoreObject()
local objectname=`prop_hotdogstand_01`

CreateThread(function()
    exports["qb-interact"]:AddModelInteraction({
        model  ='Taco',
        name = 'hotdogprop', 
        id ='hotdogprop', 
        distance = 2.0, 
        interactDst = 1.5,
        offset =vec3(1.0, -1.5, 0.65), 
        options = {
            {
                label = "Counter",
                action = function(entity, coords, args)
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", "hotdogcunter", {maxweight =20000, slots = 30})
                end,
            },
            {
                label = "Bill",
                action = function(entity, coords, args)
                    TriggerEvent("nxo:client:openbill")
                end,
                canInteract = function()
                    return QBCore.Functions.GetPlayerData().job.name=="hotdog"
                  end,
            },
            {
                label = "Open/Close Window",
                action = function(entity, coords, args)
                    shopdoor(entity)
                end,
                canInteract = function()
                    return QBCore.Functions.GetPlayerData().job.name=="hotdog"
                  end,
            },
        }
    })
    exports["qb-interact"]:AddModelInteraction({
        model  ='Taco',
        name = 'tacomanage', 
        id ='tacomanage', 
        distance =0.5, 
        interactDst = 0.5,
        offset =vec3(-0.6, -1.0, 0.5), 
        options = {
            {
                label = "Manage Foods",
                action = function(entity, coords, args)
                    TriggerEvent("nxo-foodjob:client:managefood","hotdog")
                end,
                canInteract = function()
                    return QBCore.Functions.GetPlayerData().job.name=="hotdog"
                  end,
            },
           
            {
                label = "Storage",
                action = function(entity, coords, args)
                    local plate= QBCore.Functions.GetPlate(entity)
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", "hotdogveh_"..plate, {maxweight =500000, slots = 50})
                end,
                canInteract = function()
                    return QBCore.Functions.GetPlayerData().job.name=="hotdog"
                  end,
            },
            {
                label = "Boss Menu",
                event="",
                action = function(entity, coords, args)
                    TriggerEvent("qb-bossmenu:client:OpenMenu")
                end,
               
                canInteract = function()
                    return QBCore.Functions.GetPlayerData().job.isboss
                  end,
               
            },
        }
    })
    exports["qb-interact"]:AddModelInteraction({
        model  ='Taco',
        name = 'Tacomakefood', 
        id ='Tacomakefood', 
        distance =1.5, 
        interactDst = 1.0,
        offset =vec3(-0.3, 0.2, 0.8), 
        options = {
            {
                label = "Make Food",
                action = function()
                    TriggerEvent("nxo-foodjob:client:makefood","hotdog","food")
                end,
                canInteract = function()
                    return QBCore.Functions.GetPlayerData().job.name=="hotdog"
                  end,
            },
           
        }
    })
    exports["qb-interact"]:AddModelInteraction({
        model  ='Taco',
        name = 'tacobackdoor', 
        id ='tacobackdoor', 
        distance =1.5, 
        interactDst = 1.5,
        offset =vec3(0, -4.55, 0.5), 
        options = {
            {
                label = "Open/Close Backdoor",
                action = function(entity, coords, args)
                    backdoor(entity)
                end,
                canInteract = function()
                    return QBCore.Functions.GetPlayerData().job.name=="hotdog"
                  end,
            },
           
        }
    })
    exports["qb-interact"]:AddModelInteraction({
        model  ='Taco',
        name = 'tacomakedrink', 
        id ='tacomakedrink', 
        distance =1.5, 
        interactDst = 1.5,
        offset =vec3(0.5, 0.2, 1.0), 
        options = {
            {
                label = "Make Drink",
                action = function()
                    TriggerEvent("nxo-foodjob:client:makefood","hotdog","drink")
                end,
                canInteract = function()
                    return QBCore.Functions.GetPlayerData().job.name=="hotdog"
                  end,
            },
           
        }
    })
end)

function backdoor(entity)
    if GetVehicleDoorAngleRatio(entity, 3) > 0.0 or GetVehicleDoorAngleRatio(entity, 2)>0.0  then
        SetVehicleDoorShut(entity, 3, false)
        SetVehicleDoorShut(entity, 2, false)
    else
        SetVehicleDoorOpen(entity, 3, true, true)
        Wait(100)
        SetVehicleDoorOpen(entity,2, true, true)
    end
  
end

function shopdoor(entity)
    if GetVehicleDoorAngleRatio(entity, 5) > 0.0  then
        SetVehicleDoorShut(entity, 5, false)
    else
        SetVehicleDoorOpen(entity, 5, true, true)
    end
  
end


