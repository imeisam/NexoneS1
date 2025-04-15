local QBCore = exports['qb-core']:GetCoreObject()
local vehiclehotrun
local hotrunblip
local normaldeliverypeds
local TruckRobBlip = nil
local BlipStart=false
local PlayerJob = {}
CurrentCops=0
AddEventHandler("onResourceStart", function(resourceName)
	if ("sam-jewelryrun" == resourceName) then
        Wait(1000)
		QBCore.Functions.GetPlayerData(function(PlayerData)
			PlayerJob = PlayerData.job
		end)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    PlayerJob.onduty = duty
end)

RegisterNetEvent('police:SetCopCount', function(amount,amounthigh)
    CurrentCops = amount
end)

RegisterCommand('testme', function()
    TriggerEvent('sam-jewelryrun:server:horunprestart')
end)


RegisterNetEvent('sam-jewelryrun:server:horunprestart', function()
    if exports['qb-cooldown']:isCooldown() then
    QBCore.Functions.TriggerCallback('sam-jewelryrun:server:checkrob', function(res)
            if not res then
                QBCore.Functions.Notify('You Are One time start a rob...', 'error')
                return
            else
                if not exports["qb-smallresources"]:getdevelopermode() and config.hotrun.policerequire>CurrentCops then
                    QBCore.Functions.Notify("Not Enough Police", "error")
                    return
                end
                QBCore.Functions.TriggerCallback('qb-storerobbery:server:gethotreuncooldown', function(res)
                        if res then
                            TriggerEvent('sam-jewelryrun:client:starthotrun')
                        end
                end)
            
            end
     end)
    end
end)

RegisterNetEvent('sam-jewelryrun:client:starthotrun', function()
    if robstart then
        QBCore.Functions.Notify('Rob Already started...', 'error')
        return
    end
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasitem)
        if not hasitem then
            QBCore.Functions.Notify('Not Enough Assorted Jewelry...!', 'error')
            return 
        end

        QBCore.Functions.TriggerCallback('sam-jewelryrun:server:checkbusyhotrun', function(result)
            if result>0 then
                TriggerServerEvent('qb-storerobbery:server:sethotrunstatus')
                robstart=true
                finished=false
                TriggerServerEvent("QBCore:Server:RemoveItem", 'assortedjewelry',config.hotrun.itemneed)
                TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['assortedjewelry'], "remove", config.hotrun.itemneed)
                CreateThread(function()
                    Wait(config.hotrun.requesttimeout)
                    if not finished then
                        robstart=false
                        exports["nxo-oui"]:Close()
                    end
                end)
                exports["nxo-oui"]:Show('Task', '<b>Mission 0/3</b> <br/>Find a Car')
                local model=GetHashKey(config.hotrun.carmodel)
                RequestModel(model)
                while not HasModelLoaded(model) do
                    Wait(0)
                end
            
                local coord=config.hotruncarcoord[result].coord
                vehiclehotrun = CreateVehicle(model, coord.x, coord.y, coord.z, coord.w, true, false)
             
                net1 = NetworkGetNetworkIdFromEntity(vehiclehotrun)
                SetVehicleHasBeenOwnedByPlayer(vehiclehotrun, true)
                SetNetworkIdExistsOnAllMachines(net1, true)
                SetNetworkIdCanMigrate(vehiclehotrun, true)
                SetVehicleNeedsToBeHotwired(vehiclehotrun, false)
                SetVehRadioStation(vehiclehotrun, 'OFF')
                SetModelAsNoLongerNeeded(model)
                local plate =QBCore.Functions.GetPlate(vehiclehotrun)
                config.GiveKey(plate)
                config.SetFuel(vehiclehotrun, 100.0)
                TriggerServerEvent('sam-jewelryrun:server:addhotrunitemintrunk',plate)

                hotrunblip= AddBlipForCoord(coord.x, coord.y,coord.z)
                SetBlipColour(hotrunblip, 3)
                SetBlipRoute(hotrunblip, true)
                SetBlipRouteColour(hotrunblip, 3)
                dist=1000
                while dist>5 do 
                    dist=#(GetEntityCoords(PlayerPedId())-vector3(coord.x,coord.y,coord.z))
                    Wait(100)
                end
                RemoveBlip(hotrunblip)
                engineon()
                exports["nxo-oui"]:Show('Task', '<b>Mission 1/3</b> <br/>Tracking Car')
            end

        end)

    end,'assortedjewelry',config.hotrun.itemneed)
end)


RegisterNetEvent('sam-jewelryrun:client:hotrundeliverypackage', function()
    if not robstart then
        QBCore.Functions.Notify('Not Allowed...!!!', 'error')
        return
    end
    local vehcoord = GetEntityCoords(vehiclehotrun)
    dist=#(GetEntityCoords(PlayerPedId())-vector3(vehcoord.x,vehcoord.y,vehcoord.z))
    if dist > 10 then
        QBCore.Functions.Notify('I need a car...!', 'error')
        return 
    end

    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasitem)
        if not hasitem then
            QBCore.Functions.Notify('Not Enough Item...!', 'error')
            return 
        end
        
        TriggerServerEvent("sam-jewelryrun:server:insertrobed")

        TriggerServerEvent("QBCore:Server:RemoveItem", 'stolengoods', config.hotrun.packagecount)
        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['stolengoods'], "remove", config.hotrun.packagecount)
    
        TriggerServerEvent("QBCore:Server:AddItem", 'cash', config.hotrun.addmoney)
        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['cash'], "add", config.hotrun.addmoney)
        robstart=false
        finished=true
        DeletePed(normaldeliverypeds)
        QBCore.Functions.DeleteVehicle(vehiclehotrun)
        exports["nxo-oui"]:Close()
    end,'stolengoods',config.hotrun.packagecount)
end)

function BlipStartPD()
    BlipStart=true

    TriggerServerEvent("sam-jewelryrun:server:startblip")
	CreateThread(function()
      
		while BlipStart do
			local vehCoords = GetEntityCoords(vehiclehotrun)
			TriggerServerEvent("sam-jewelryrun:server:sendblips",true, vehCoords)
			Wait(10000)
		end
	end)
    CreateThread(function()
     local  tim=config.hotrun.blipoff
        local remind=""
		while tim>0 do
            tim=tim-1000
            if tim>=(60000) then
                remind=math.round((tim/1000)/60) .. " Min"
            else
                remind=math.round((tim/1000)).. "Sec"
            end
            exports["nxo-oui"]:Show('Task', '<b>Mission 1/3</b> <br/>Tracking Car<br/>Remind Time:'..remind)
			Wait(1000)
		end

	end)
end


RegisterNetEvent('sam-jewelryrun:timeover', function()
		BlipStart = false
		TriggerServerEvent("sam-jewelryrun:server:sendblips", false)
        TriggerEvent('sam-jewelryrun:delivery')
       
end)

RegisterNetEvent('sam-jewelryrun:client:SendBlips', function(toggle,mashin)
	if toggle then
		if LocalPlayer.state.isLoggedIn and (PlayerJob.name == "police" or PlayerJob.name == "justice") and PlayerJob.onduty then
			if TruckRobBlip ~= nil then
				RemoveBlip(TruckRobBlip)
			end
			TruckRobBlip = AddBlipForCoord(mashin.x, mashin.y, mashin.z)
			SetBlipSprite(TruckRobBlip, 67)
			SetBlipColour(TruckRobBlip, 1)
			SetBlipFlashes(TruckRobBlip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Truck Escort')
			EndTextCommandSetBlipName(TruckRobBlip)
		else
			if TruckRobBlip ~= nil then
				RemoveBlip(TruckRobBlip)
			end
		end
	else
		if TruckRobBlip ~= nil then
			RemoveBlip(TruckRobBlip)
		end
	end
end)

function engineon()
    CreateThread(function()
        while not GetIsVehicleEngineRunning(vehiclehotrun) do
          Wait(2000)
        end
--    exports['qb-dispatch']:dispatch('10-31', 'Hot Run', nil, 67, 1, 'robberysound', false, false, false)
   BlipStartPD()
    end)
    
end

RegisterNetEvent('sam-jewelryrun:delivery', function()

    hotrunblip= AddBlipForCoord(config.normal.deliverynpccoord.x, config.normal.deliverynpccoord.y,config.normal.deliverynpccoord.z-1)
    SetBlipColour(hotrunblip, 3)
    SetBlipRoute(hotrunblip, true)
    SetBlipRouteColour(hotrunblip, 3)

    exports["nxo-oui"]:Show('Task', '<b>Mission 2/3</b> <br/>Go to Delivery Point')
    QBCore.Functions.Notify('Now Again Check Map and deliver the package in this car', 'info')
    dist=100
    while dist>10 do 
        dist=#(GetEntityCoords(PlayerPedId())-vector3(config.normal.deliverynpccoord.x,config.normal.deliverynpccoord.y,config.normal.deliverynpccoord.z-1))
        Wait(100)
    end
      RemoveBlip(hotrunblip)

      local pedmodel = GetHashKey('g_m_m_chicold_01')
      RequestModel(pedmodel)
      while not HasModelLoaded(pedmodel) do
          Wait(1)
      end
      normaldeliverypeds= CreatePed(4, pedmodel,config.normal.deliverynpccoord.x,config.normal.deliverynpccoord.y,config.normal.deliverynpccoord.z-1, false, true)
      SetEntityInvincible(normaldeliverypeds, true)
     
      SetBlockingOfNonTemporaryEvents(normaldeliverypeds, true)
      TaskStartScenarioInPlace(normaldeliverypeds, 'WORLD_HUMAN_GUARD_STAND', 0, true)
      SetEntityHeading(normaldeliverypeds,config.normal.deliverynpccoord.w)
      FreezeEntityPosition(normaldeliverypeds, true)
      exports["nxo-oui"]:Show('Task', '<b>Mission 3/3</b> <br/>Give a Packages')
      exports['qb-target']:AddTargetEntity(normaldeliverypeds, {
        options = {
            {
                event = "sam-jewelryrun:client:hotrundeliverypackage",
                icon = "fas fa-cash-register",
                label = "Deliver Package",
            },
        },
        distance = 1.5
    })
end)

