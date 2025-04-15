-- Variables

local QBCore = exports['qb-core']:GetCoreObject()

local RadialMenu = nil

local meterIsOpen = false
local meterActive = false
local lastLocation = nil
local mouseActive = false

-- used for polyzones
local isInsidePickupZone = false
local isInsideDropZone = false


local meterData = {
    fareAmount = 6,
    currentFare = 0,
    distanceTraveled = 0,
}

local NpcData = {
    Active = false,
    CurrentNpc = nil,
    LastNpc = nil,
    CurrentDeliver = nil,
    LastDeliver = nil,
    Npc = nil,
    NpcBlip = nil,
    DeliveryBlip = nil,
    NpcTaken = false,
    NpcDelivered = false,
    CountDown = 180
}

-- Functions

local function ResetNpcTask()
    NpcData = {
        Active = false,
        CurrentNpc = nil,
        LastNpc = nil,
        CurrentDeliver = nil,
        LastDeliver = nil,
        Npc = nil,
        NpcBlip = nil,
        DeliveryBlip = nil,
        NpcTaken = false,
        NpcDelivered = false,
    }
end

local function resetMeter()
    meterData = {
        fareAmount = Config.Meter["defaultPrice"],
        currentFare = 0,
        distanceTraveled = 0,
    }
end

local function whitelistedVehicle()
    local ped = PlayerPedId()
    local veh = GetEntityModel(GetVehiclePedIsIn(ped))
    local retval = false

    for k,v in ipairs(Config.AllowedVehicles) do
        if veh == GetHashKey(v) then
            retval = true
            break
        end
    end

    return retval
end

local function IsDriver()
    return GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId()
end

local function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function GetDeliveryLocation()
    NpcData.CurrentDeliver = math.random(1, #Config.NPCLocations.DeliverLocations)
    if NpcData.LastDeliver ~= nil then
        while NpcData.LastDeliver ~= NpcData.CurrentDeliver do
            NpcData.CurrentDeliver = math.random(1, #Config.NPCLocations.DeliverLocations)
        end
    end

    if NpcData.DeliveryBlip ~= nil then
        RemoveBlip(NpcData.DeliveryBlip)
    end
    NpcData.DeliveryBlip = AddBlipForCoord(Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].x, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].y, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].z)
    SetBlipColour(NpcData.DeliveryBlip, 3)
    SetBlipRoute(NpcData.DeliveryBlip, true)
    SetBlipRouteColour(NpcData.DeliveryBlip, 3)
    NpcData.LastDeliver = NpcData.CurrentDeliver
end

local function calculateFareAmount()
    if meterIsOpen and meterActive then
        start = lastLocation

        if start then
            current = GetEntityCoords(PlayerPedId())
            distance = #(start - current) --Not the best result but work
            meterData['distanceTraveled'] = distance
            fareAmount = (meterData['distanceTraveled'] / 200) * meterData['fareAmount']

            meterData['currentFare'] = math.ceil(fareAmount)

            SendNUIMessage({
                action = "updateMeter",
                meterData = meterData
            })
        end
    end
end

-- qb-menu

function closeMenuFull()
    exports['qb-menu']:closeMenu()
end

-- CreateThread(function()
--     local model = GetHashKey(Config.Ped)
--     RequestModel(model)
--     while not HasModelLoaded(model) do
--         Wait(1)
--     end
--     local npc = CreatePed(4, model, Config.Location.x, Config.Location.y, Config.Location.z - 1,  Config.Location.w, false, true)
--     SetEntityHeading(npc,  Config.Location.w)
--     FreezeEntityPosition(npc, true)
--     SetEntityInvincible(npc, true)
--     SetBlockingOfNonTemporaryEvents(npc, true)
--     TaskStartScenarioInPlace(npc, "WORLD_HUMAN_CLIPBOARD", 0, true)
--     SetPedKeepTask(npc, true)
--     exports['qb-target']:AddTargetEntity(npc, {
--         options = {
--             {
--                 num = 1,
--                 type = "client",
--                 event = "qb-taxijob:client:requestcab",  
--                 icon = "fas fa-sign-in-alt",
--                 label = 'Request Taxi Cab',
--                 job = "taxi",
--             },
--             {
--                 num = 2,
--                 type = "client",
--                 event = "qb-taxijob:client:deletecab",  
--                 icon = "fas fa-sign-out-alt",
--                 label = 'Park Vehicle',
--                 job = "taxi",
--             }
--         },
--         distance = 3.0
--     })
-- end)

-- Events

RegisterNetEvent('qb-taxijob:client:requestcab', function()
    local vehicleMenu = {
        {
            header = "Taxi Vehicles",
            isMenuHeader = true
        }
    }
    for i=1, #Config.AllowedVehicles, 1 do
        vehicleMenu[#vehicleMenu+1] = {
            header =QBCore.Shared.Vehicles[Config.AllowedVehicles[i]].name  ,
            params = {
                event = "qb-taxi:client:TakeVehicle",
                args = {
                    model = Config.AllowedVehicles[i]
                }
            }
        }
    end
    vehicleMenu[#vehicleMenu+1] = {
        header = ("⬅ Close Menu"),
        params = {
            event = "qb-menu:client:closeMenu"
        }
    }
    exports['qb-menu']:openMenu(vehicleMenu)
end)

RegisterNetEvent("qb-taxi:client:opentaximeter", function(plate)
    local ped=PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, 0)
    if veh then
        local pedplate = GetVehicleNumberPlateText(veh)
        if pedplate==plate and GetPedInVehicleSeat(veh, -1)~=ped  then
            meterIsOpen=true
            meterActive=false
            TriggerEvent("qb-taxi:client:enableMeter")
        end
    end

end)


RegisterNetEvent("qb-taxi:client:TakeVehicle", function(data)
    QBCore.Functions.SpawnVehicle(data.model, function(veh)
        SetVehicleNumberPlateText(veh, "TAXI"..tostring(math.random(1000, 9999)))
        ClearVehicleCustomPrimaryColour(veh)
        ClearVehicleCustomSecondaryColour(veh)
        SetVehicleColours(veh, 64, 88)
        exports['qb-fuel']:SetFuel(veh, 100.0)
        SetEntityHeading(veh, Config.VehSpawn.w)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerServerEvent("qb-vehiclekeys:server:AcquireVehicleKeys", QBCore.Functions.GetPlate(veh))
    end, Config.VehSpawn, true)
end)

RegisterNetEvent('qb-taxijob:client:deletecab', function()
    if IsPedInAnyVehicle(PlayerPedId(), false) and whitelistedVehicle() and IsDriver() then
        if whitelistedVehicle() then
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            if meterIsOpen then
                TriggerEvent('qb-taxi:client:toggleMeter')
                meterActive = false
            end
            TaskLeaveVehicle(PlayerPedId(), vehicle, 0)
            Wait(2000)
            QBCore.Functions.DeleteVehicle(vehicle)
        end
    end
end)

RegisterNetEvent('qb-radialmenu:client:onRadialmenuOpen', function()
    if QBCore.Functions.GetPlayerData().job.name == 'taxi' and IsPedInAnyVehicle(PlayerPedId(), false) and whitelistedVehicle() and IsDriver() then
        if not RadialMenu then
            RadialMenu = exports['qb-radialmenu']:AddOption({
                id = 'taxiactions',
                title = 'Taxi Actions',
                icon = '#taxi',
                items = {
                    {
                        id = 'togglemeter',
                        title = 'Show/Hide Meter',
                        icon = '#taxi',
                        functiontype = 'client',
                        functionName = 'qb-taxi:client:toggleMeter',
                        shouldClose = false
                    },
                    {
                        id = 'togglemouse',
                        title = 'Start/Stop Meter',
                        icon = '#taxi',
                        functiontype = 'client',
                        functionName = 'qb-taxi:client:enableMeter',
                        shouldClose = true
                    },
                    {
                        id = 'npc_mission',
                        title = 'Start Uber',
                        icon = '#taxi',
                        functiontype = 'client',
                        functionName = 'qb-taxi:client:DoTaxiNpc',
                        shouldClose = true
                    }
                }
            }, RadialMenu)
        end
    else
        if RadialMenu then
            exports['qb-radialmenu']:RemoveOption(RadialMenu)
            RadialMenu = nil
        end
    end
end)

RegisterNetEvent('qb-taxi:client:DoTaxiNpc', function()
    if whitelistedVehicle() then
        if not NpcData.Active then
            NpcData.CurrentNpc = math.random(1, #Config.NPCLocations.TakeLocations)
            if NpcData.LastNpc ~= nil then
                while NpcData.LastNpc ~= NpcData.CurrentNpc do
                    NpcData.CurrentNpc = math.random(1, #Config.NPCLocations.TakeLocations)
                end
            end

            local Gender = math.random(1, #Config.NpcSkins)
            local PedSkin = math.random(1, #Config.NpcSkins[Gender])
            local model = GetHashKey(Config.NpcSkins[Gender][PedSkin])
            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(0)
            end
            NpcData.Npc = CreatePed(3, model, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].x, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].y, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].z - 0.98, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].w, true, true)
            PlaceObjectOnGroundProperly(NpcData.Npc)
            FreezeEntityPosition(NpcData.Npc, true)
            if NpcData.NpcBlip ~= nil then
                RemoveBlip(NpcData.NpcBlip)
            end
            QBCore.Functions.Notify(Lang:t("info.npc_on_gps"), 'success')

           -- added checks to disable distance checking if polyzone option is used
           createNpcPickUpLocation()

            NpcData.NpcBlip = AddBlipForCoord(Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].x, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].y, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].z)
            SetBlipColour(NpcData.NpcBlip, 3)
            SetBlipRoute(NpcData.NpcBlip, true)
            SetBlipRouteColour(NpcData.NpcBlip, 3)
            NpcData.LastNpc = NpcData.CurrentNpc
            NpcData.Active = true
        else
            QBCore.Functions.Notify(Lang:t("error.already_mission"))
        end
    else
        QBCore.Functions.Notify(Lang:t("error.not_in_taxi"))
    end
end)

RegisterNetEvent('qb-taxi:client:toggleMeter', function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        if whitelistedVehicle() then
            if not meterIsOpen and IsDriver() then
                SendNUIMessage({
                    action = "openMeter",
                    toggle = true,
                    meterData = Config.Meter
                })
                meterIsOpen = true
            else
                SendNUIMessage({
                    action = "openMeter",
                    toggle = false
                })
                meterIsOpen = false
            end
        else
            QBCore.Functions.Notify(Lang:t("error.missing_meter"), 'error')
        end
    else
        QBCore.Functions.Notify(Lang:t("error.no_vehicle"), 'error')
    end
end)

RegisterNetEvent('qb-taxi:client:enableMeter', function()
    if meterIsOpen then

        if meterActive then
            meterActive = false
            resetMeter()
            SendNUIMessage({
                action = "toggleMeter",
                state = false
            })
            SendNUIMessage({
                action = "resetMeter"
            })
        else
            ped=PlayerPedId()
            local veh = GetVehiclePedIsIn(ped, 0)
            if veh and GetPedInVehicleSeat(veh, -1)==ped  then
                local pedplate = GetVehicleNumberPlateText(veh)
                TriggerServerEvent("qb-taxi:server:opentaximeter",pedplate)
            end
            meterActive = true
            lastLocation = GetEntityCoords(PlayerPedId())
            resetMeter()
            SendNUIMessage({
                action = "openMeter",
                toggle = true,
                meterData = Config.Meter
            })
            SendNUIMessage({
                action = "toggleMeter",
                state = true
            })
        end
    else
        QBCore.Functions.Notify(Lang:t("error.not_active_meter"), 'error')
    end
end)

RegisterNetEvent('qb-taxi:client:toggleMuis', function()
    Wait(400)
    if meterIsOpen then
        if not mouseActive then
            SetNuiFocus(true, true)
            mouseActive = true
        end
    else
        QBCore.Functions.Notify(Lang:t("error.no_meter_sight"), 'error')
    end
end)

-- NUI Callbacks

RegisterNUICallback('hideMouse', function(_, cb)
    SetNuiFocus(false, false)
    mouseActive = false
    cb('ok')
end)

-- Threads
CreateThread(function()
    local TaxiBlip = AddBlipForCoord(Config.Location)
    SetBlipSprite (TaxiBlip, 198)
    SetBlipDisplay(TaxiBlip, 4)
    SetBlipScale  (TaxiBlip, 0.6)
    SetBlipAsShortRange(TaxiBlip, true)
    SetBlipColour(TaxiBlip, 5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Lang:t("info.blip_name"))
    EndTextCommandSetBlipName(TaxiBlip)
end)

CreateThread(function()
    while true do
        Wait(2000)
        calculateFareAmount()
    end
end)

AddEventHandler("baseevents:leftVehicle", function()
    if meterIsOpen then
        SendNUIMessage({
            action = "openMeter",
            toggle = false
        })
        meterIsOpen = false
    end
end)

local zone
local delieveryZone

function createNpcPickUpLocation()
   

    zone = BoxZone:Create(Config.PZLocations.TakeLocations[NpcData.CurrentNpc].coord, Config.PZLocations.TakeLocations[NpcData.CurrentNpc].height, Config.PZLocations.TakeLocations[NpcData.CurrentNpc].width, {
        heading = Config.PZLocations.TakeLocations[NpcData.CurrentNpc].heading,
        debugPoly = false,
        minZ = Config.PZLocations.TakeLocations[NpcData.CurrentNpc].minZ,
        maxZ = Config.PZLocations.TakeLocations[NpcData.CurrentNpc].maxZ,
    })

    zone:onPlayerInOut(function(isPlayerInside)
    
    
        if isPlayerInside then
            if whitelistedVehicle() and not isInsidePickupZone and not NpcData.NpcTaken then
                isInsidePickupZone = true
                exports['qb-core']:DrawText(Lang:t("info.call_npc"),'left','E')
                callNpcPoly()
            end
        else
            isInsidePickupZone = false
        end
    end)
end


function createNpcDelieveryLocation()
    sourcecoord = GetEntityCoords(PlayerPedId())
    destinationcoord =Config.PZLocations.DropLocations[NpcData.CurrentDeliver].coord
    dis=#(sourcecoord-destinationcoord)
    CreateThread(function()
        local time=(dis)/6
        local tim=0
        exports["nxo-oui"]:Show('Task', 'Time Remining: '.. math.round(time/60,0) .. "Min")
        while ( not isInsideDropZone and tim<time) do
           Wait(1000)
           tim =tim +1
        end
        if tim>=time then
            isInsideDropZone=true
            QBCore.Functions.Notify("Time out Request...","error")
            exports["nxo-oui"]:Close()
            dropNpcPoly(true)
        end
      
    end)

    delieveryZone = BoxZone:Create(Config.PZLocations.DropLocations[NpcData.CurrentDeliver].coord, Config.PZLocations.DropLocations[NpcData.CurrentDeliver].height, Config.PZLocations.DropLocations[NpcData.CurrentDeliver].width, {
        heading = Config.PZLocations.DropLocations[NpcData.CurrentDeliver].heading,
        debugPoly = false,
        minZ = Config.PZLocations.DropLocations[NpcData.CurrentDeliver].minZ,
        maxZ = Config.PZLocations.DropLocations[NpcData.CurrentDeliver].maxZ,
    })

    delieveryZone:onPlayerInOut(function(isPlayerInside)
        if isPlayerInside then
            if whitelistedVehicle() and not isInsideDropZone and NpcData.NpcTaken then
                isInsideDropZone = true
                exports['qb-core']:DrawText(Lang:t("info.drop_off_npc"),'left','E')
                dropNpcPoly(false)
                exports["nxo-oui"]:Close()
            end
        else
            isInsideDropZone = false
        end
    end)
end

function callNpcPoly()
    CreateThread(function()
        while not NpcData.NpcTaken do
            local ped = PlayerPedId()
            if isInsidePickupZone then
                if IsControlJustPressed(0, 38) then
                    exports['qb-core']:HideText()
                    local veh = GetVehiclePedIsIn(ped, 0)
                    local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(veh)

                    for i=maxSeats - 1, 0, -1 do
                        if IsVehicleSeatFree(veh, i) then
                            freeSeat = i
                            break
                        end
                    end

                    meterIsOpen = true
                    meterActive = true
                    lastLocation = GetEntityCoords(PlayerPedId())
                    resetMeter()
                    SendNUIMessage({
                        action = "openMeter",
                        toggle = true,
                        meterData = Config.Meter
                    })
                    SendNUIMessage({
                        action = "toggleMeter",
                        state = true
                    })
                    
                    ClearPedTasksImmediately(NpcData.Npc)
                    FreezeEntityPosition(NpcData.Npc, false)
                    TaskEnterVehicle(NpcData.Npc, veh, -1, freeSeat, 1.0, 0)
                    QBCore.Functions.Notify(Lang:t("info.go_to_location"))
                    if NpcData.NpcBlip ~= nil then
                        RemoveBlip(NpcData.NpcBlip)
                    end
                    GetDeliveryLocation()
                    NpcData.NpcTaken = true
                    createNpcDelieveryLocation()
                    zone:destroy()
                end
            end
            Wait(1)
        end
    end)
end

function dropNpcPoly(notsuccess)
    CreateThread(function()
        while NpcData.NpcTaken do
            local ped = PlayerPedId()
            if isInsideDropZone then
                if IsControlJustPressed(0, 38) or notsuccess then
                    exports['qb-core']:HideText()
                    local veh = GetVehiclePedIsIn(ped, 0)
                    TaskLeaveVehicle(NpcData.Npc, veh, 0)
                    SetEntityAsMissionEntity(NpcData.Npc, false, true)
                    SetEntityAsNoLongerNeeded(NpcData.Npc)
                    local targetCoords = Config.NPCLocations.TakeLocations[NpcData.LastNpc]
                    TaskGoStraightToCoord(NpcData.Npc, targetCoords.x, targetCoords.y, targetCoords.z, 1.0, -1, 0.0, 0.0)
                    if not notsuccess then
                        TriggerServerEvent('qb-taxi:server:NpcPay', meterData.currentFare)
                        QBCore.Functions.Notify(Lang:t("info.person_was_dropped_off"), 'success')
                    end
                    meterActive = false
                    resetMeter()
                    SendNUIMessage({
                        action = "toggleMeter",
                        state = false
                    })
                    SendNUIMessage({
                        action = "resetMeter"
                    })
                   

                  
                    if NpcData.DeliveryBlip ~= nil then
                        RemoveBlip(NpcData.DeliveryBlip)
                    end
                    local RemovePed = function(p)
                        SetTimeout(60000, function()
                            DeletePed(p)
                        end)
                    end
                    RemovePed(NpcData.Npc)
                    ResetNpcTask()
                    delieveryZone:destroy()
                    break
                end
            end
            Wait(1)
        end
    end)
end