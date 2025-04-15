local QBCore = exports['qb-core']:GetCoreObject()
local taskActive = false
local currentMenuVehs = {}
local isBoss = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    local myJob = QBCore.Functions.GetPlayerData().job
    if myJob.name == 'cardealer' and myJob.isboss then
        isBoss = true
    else
        isBoss = false
    end
end)

RegisterNetEvent('qb-vehicleshop:client:sellusedcar', function()
    local targetVehicle, dist =  QBCore.Functions.GetClosestVehicle()
    local playerPed = PlayerPedId()
    if DoesEntityExist(targetVehicle) and dist <= 4.5 and not IsPedInAnyVehicle(playerPed, false) then
       local plate= QBCore.Functions.GetPlate(targetVehicle)
       local price =1000
       local model = GetDisplayNameFromVehicleModel(GetEntityModel(targetVehicle))
       local vehprop=QBCore.Shared.Vehicles[string.lower(model)]
       local price =math.round(vehprop.price*0.7,0)
        exports['qb-menu']:openMenu({
            {
				header = "Sell Used Car",
				isMenuHeader = true,
			},
            {
                header = vehprop.name ,
                txt = "Plate: "..plate.. "</br>Sell Price: "..price ,
                icon = 'fas fa-car',
                isMenuHeader = true,
            },
            {
                header = "I Sure a sell vehicle",
                params = {
                    event = "qb-vehicle:client:acceptsellusedcar",
                    args = {price=price,plate=plate,vehicle=targetVehicle,model=string.lower(model)}
                }
            },
            {
                header = "No No No..!" ,
            }
        })

    end
end)
RegisterNetEvent('qb-vehicle:client:acceptsellusedcar', function(data)
    TriggerServerEvent('qb-vehicle:server:sellusedvehicle',data.plate, data.price, data.vehicle,data.model)
end)

RegisterNetEvent('qb-vehicle:server:dvusedcar', function(veh)
    QBCore.Functions.DeleteVehicle(veh)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    local myJob = QBCore.Functions.GetPlayerData().job
    if myJob.name == 'cardealer' and myJob.isboss then
        isBoss = true
    else
        isBoss = false
    end
end)
function allowjob(jobname)
    if not jobname then return true end
        if jobname=="ambulance" or jobname=="police" or jobname=="justice" then
            if QBCore.Functions.GetPlayerData().job.name==jobname then
                if jobname=="ambulance" then
                    if  QBCore.Functions.GetPlayerData().job.grade.level>=4 then
                        return true
                    else
                        return false
                    end
                else
                    return true
                end
               
            else
                return false
            end
        else
            return true
        end
   
end
Citizen.CreateThread(function()
    -- Functions
    for k, v in pairs(Config.VehicleShops) do
        -- if v.Interaction.Target.Enable then
        --     if GetResourceState('ox_target') == 'started' or GetResourceState('pa-target') == 'started' then
        --         local targetData = {}
        --         targetData[1] = {
        --             label = v.Interaction.Target.Label,
        --             icon = v.Interaction.Target.Icon,
        --             distance = v.Interaction.Target.Distance,
        --             onSelect = function()
        --                 openDealership(true, k)
        --             end
        --         }
        --         if v.Management.Enable then
        --             targetData[2] = {
        --                 label = v.Interaction.Target.Label2,
        --                 icon = v.Interaction.Target.Icon2,
        --                 distance = v.Interaction.Target.Distance,
        --                 groups = v.Management.Job,
        --                 onSelect = function()
        --                     openShowroomMenu(k, true, v.ShowroomVehicles, v.Management.Job)
        --                 end
        --             }
        --         end
        --         exports['ox_target']:addLocalEntity(v.Ped.ped, targetData)
        --     elseif GetResourceState('qb-target') == 'started' then

        exports['qb-interact']:AddInteraction({
            coords =v.Ped.Coords,
            distance = 5.0,
            interactDst = 1.2,
            id = 'showroom_t'..k,
            name = 'showroom_t'..k,
            options = {
                 {
                    id = "showroom_t"..k, 
                    label =  v.Interaction.Target.Label,
                    action = function()
                        openDealership(true, k)
                    end,
                    canInteract = function()
                        return allowjob(v.Management.Job)
                    end,
                },
               
            }
        })

                -- local targetData = {}
                -- table.insert(targetData, {
                --     label = v.Interaction.Target.Label,
                --     icon = v.Interaction.Target.Icon,
                --     action = function()
                --         openDealership(true, k)
                --     end
                -- })
                -- if v.Management.Enable then
                    -- table.insert(targetData, {
                    --     label = v.Interaction.Target.Label2,
                    --     icon = v.Interaction.Target.Icon2,
                    --     job = v.Management.Job,
                    --     action = function()
                    --         openShowroomMenu(k, true, v.ShowroomVehicles, v.Management.Job)
                    --     end
                    -- })
                   
                -- end

              

                
                -- exports['qb-target']:AddBoxZone('showroom_t'..k, v.Ped.Coords, 1.0, 1.0,  {
                --     name = 'showroom_t'..k,
                --     minZ=v.Ped.Coords.z-1,
                --     maxZ=v.Ped.Coords.z+1
                --     }, {
                --         options = targetData,
                --         distance = v.Interaction.Target.Distance
                --     }
                -- )
        --     end
        -- end
        if v.Blip.Enable then
			local blip = AddBlipForCoord(v.Blip.coords.x, v.Blip.coords.y, v.Blip.coords.z)
			SetBlipSprite(blip, v.Blip.sprite)
			SetBlipScale(blip, v.Blip.scale)
			SetBlipDisplay(blip, 4)
			SetBlipColour(blip, v.Blip.color)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentSubstringPlayerName(v.Blip.text)
			EndTextCommandSetBlipName(blip)
		end
        v.created = false
        for a, b in pairs(v.ShowroomVehicles) do
            b.spotId = a
        end
        if v.Management.Enable then
            exports['qb-interact']:AddInteraction({
                coords =v.Coords.SellingPoint,
                distance = 5.0,
                interactDst = 1.2,
                id = "qb-vehicleshop-vehshop-" .. k,
                name ="qb-vehicleshop-vehshop-" .. k,
                groups = {
                    ['cardealer'] = 0,
                },
                options = {
                     {
                        canInteract = function()
                            return not taskActive
                        end,
                        id = "qb-vehicleshop-vehshop-" .. k, 
                        label =  "Selling Point",
                       event= "qb-vehicleshop:openSellingMenu:client",
                       args = {vehshopId = k, open = true, sell = true}
                    },
                    {
                        label =  v.Interaction.Target.Label2,
                        action = function()
                          openShowroomMenu(k, true, v.ShowroomVehicles, v.Management.Job)
                      end,
                     
                    },
                }
            })

            -- exports['qb-textui']:create3DTextUI("qb-vehicleshop-vehshop-" .. k, {
            --     coords = v.Coords.SellingPoint,
            --     displayDist = 5.0,
            --     interactDist = 2.0,
            --     enableKeyClick = true,
            --     keyNum = 38,
            --     key = "E",
            --     text = "Selling Point",
            --     theme = "green", -- or red
            --     job = v.Management.Job,
            --     canInteract = function()
            --         return not taskActive
            --     end,
            --     triggerData = {
            --         triggerName = "qb-vehicleshop:openSellingMenu:client",
            --         args = {vehshopId = k, open = true, sell = true}
            --     }
            -- })
        else
            if v.EnableStocks then
                exports['qb-interact']:AddInteraction({
                    coords =v.Coords.SellingPoint,
                    distance = 3.0,
                    interactDst = 1.2,
                    id = "qb-vehicleshop-vehshop-" .. k,
                    name ="qb-vehicleshop-vehshop-" .. k,
                   
                  
                    options = {
                         {
                            canInteract = function()
                                        return isBoss
                                    end,
                            label =  "Selling Point",
                           event= "qb-vehicleshop:openSellingMenu:client",
                           args = {vehshopId = k, open = true, sell = true}
                        },
                       
                    }
                })

              
                
                -- exports['qb-textui']:create3DTextUI("qb-vehicleshop-vehshop-" .. k, {
                --     coords = v.Coords.SellingPoint,
                --     displayDist = 5.0,
                --     interactDist = 2.0,
                --     enableKeyClick = true,
                --     keyNum = 38,
                --     key = "E",
                --     text = "Selling Point",
                --     theme = "green", -- or red
                --     job = "all",
                --     canInteract = function()
                --         return isBoss
                --     end,
                --     triggerData = {
                --         triggerName = "qb-vehicleshop:openSellingMenu:client",
                --         args = {vehshopId = k, open = true, sell = false}
                --     }
                -- })
            end
        end
    end
end)

local sellMenuActive = false
RegisterNetEvent('qb-vehicleshop:openSellingMenu:client', function(data1)
    local data=data1.args
    sellMenuActive = data.open
    if sellMenuActive then
        local showAddStockBtn = false
        if isBoss then
            showAddStockBtn = true
        end
        if Config.VehicleShops[data.vehshopId].EnableStocks then
            currentMenuVehs = Vehicles
            TriggerCallback('qb-vehicleshop:getVehStock:server', function(stockData)
                if stockData ~= 0 then
                    for k, v in pairs(stockData) do
                        for a, b in pairs(currentMenuVehs) do
                            if b.model == v.model then
                                b.stock = v.stock
                                b.name = Vehicles2[v.model].name
                            end
                        end
                    end
                end
            end, data.vehshopId)
            Citizen.Wait(1000)
            SendNUIMessage({action = "openSellMenu", stoke=true ,sellBtnActive = data.sell, dealershipId = data.vehshopId, vehicles = currentMenuVehs, vehicles2 = currentMenuVehs, showAddStockBtn = showAddStockBtn})
        else
            SendNUIMessage({action = "openSellMenu", dealershipId = data.vehshopId, vehicles = Vehicles,stoke=false})
        end
        SetNuiFocus(true, true)
    else
        SetNuiFocus(false, false)
    end
end)

-- local Initialized = false
-- AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
--     if not Initialized then Init() end
-- end)

-- AddEventHandler('onResourceStart', function(resource)
--     if resource ~= GetCurrentResourceName() then return end
--     if not Initialized then Init() end
-- end)

-- function Init()
--     Initialized = true
--     Citizen.CreateThread(function()
--         TriggerCallback('qb-vehicleshop:getShowroomData:server', function(showroomData)
--             for k, v in pairs(showroomData) do
--                 if v.vehicleModel then
--                     local model = GetHashKey(v.vehicleModel)
--                     RequestModel(model)
--                     while not HasModelLoaded(model) do Citizen.Wait(0) end
--                     Config.VehicleShops[v.dealershipId].ShowroomVehicles[v.spotId].vehicleModel = v.vehicleModel
--                     Config.VehicleShops[v.dealershipId].ShowroomVehicles[v.spotId].vehicle = CreateVehicle(model, v.coords.x, v.coords.y, v.coords.z, false, false)
--                     local vehicle = Config.VehicleShops[v.dealershipId].ShowroomVehicles[v.spotId].vehicle
--                     SetModelAsNoLongerNeeded(model)
--                     SetVehicleOnGroundProperly(vehicle)
--                     SetEntityInvincible(vehicle, true)
--                     SetVehicleDirtLevel(vehicle, 0.0)
--                     SetVehicleDoorsLocked(vehicle, 3)
--                     SetEntityHeading(vehicle, v.coords.w)
--                     FreezeEntityPosition(vehicle, true)
--                     SetVehicleNumberPlateText(vehicle, 'BUY ME')
--                     exports['qb-textui']:create3DTextUI("qb-vehicleshop-showroom-vehicle-" .. model .. "-spotId-" .. v.spotId, {
--                         coords = vector3(v.coords.x, v.coords.y, v.coords.z),
--                         displayDist = 5.0,
--                         interactDist = 1.5,
--                         enableKeyClick = true,
--                         keyNum = 38,
--                         key = "E",
--                         text = "Ask an employee",
--                         theme = "green", 
--                         triggerData = {
--                             triggerName = "qb-vehicleshop:askAnEmployee:client",
--                             args = {}
--                         }
--                     })
--                 end
--             end
--         end)
--     end)
-- end

closestVehShop = {}
Citizen.CreateThread(function()
	while true do
		local sleep = 2000
		playerPed = PlayerPedId()
		playerCoords = GetEntityCoords(playerPed)
		if not closestVehShop.id then
			for k, v in pairs(Config.VehicleShops) do
				local dist = #(playerCoords - vector3(v.ShowroomVehicles[1].coords.x, v.ShowroomVehicles[1].coords.y, v.ShowroomVehicles[1].coords.z))
                if dist <= 40 then
                    closestVehShop = {id = k, created = v.created, distance = dist, maxDist = 40, data = {coords = vector3(v.ShowroomVehicles[1].coords.x, v.ShowroomVehicles[1].coords.y, v.ShowroomVehicles[1].coords.z)}}
                    if v.ClearAreaOfNPCVehicles then
                        ClearAreaOfVehicles(v.Coords.ShowroomVehicles.x, v.Coords.ShowroomVehicles.y, v.Coords.ShowroomVehicles.z, 30.0, false, false, false, false, false)
                    end
                end
			end
		end
		if closestVehShop.id and not closestVehShop.created then
			while not closestVehShop.created do
				playerCoords = GetEntityCoords(playerPed)
				closestVehShop.distance = #(closestVehShop.data.coords - playerCoords)
				if closestVehShop.distance < closestVehShop.maxDist then
                    Config.VehicleShops[closestVehShop.id].created = true
                    --closestVehShop.created = true
                    TriggerCallback('qb-vehicleshop:getShowroomData:server', function(showroomData)
                        for k, v in pairs(showroomData) do
                            if v.vehicleModel then
                                local model = GetHashKey(v.vehicleModel)
                                RequestModel(model)
                                while not HasModelLoaded(model) do Citizen.Wait(0) end
                                Config.VehicleShops[v.dealershipId].ShowroomVehicles[v.spotId].vehicleModel = v.vehicleModel
                                Config.VehicleShops[v.dealershipId].ShowroomVehicles[v.spotId].vehicle = CreateVehicle(model, v.coords.x, v.coords.y, v.coords.z, false, false)
                                local vehicle = Config.VehicleShops[v.dealershipId].ShowroomVehicles[v.spotId].vehicle
                                SetModelAsNoLongerNeeded(model)
                                SetVehicleOnGroundProperly(vehicle)
                                SetEntityInvincible(vehicle, true)
                                SetVehicleDirtLevel(vehicle, 0.0)
                                SetVehicleDoorsLocked(vehicle, 3)
                                SetEntityHeading(vehicle, v.coords.w)
                                FreezeEntityPosition(vehicle, true)
                                SetVehicleNumberPlateText(vehicle, 'BUY ME')
                                -- exports['qb-interact']:AddInteraction({
                                --     coords =vector3(v.coords.x, v.coords.y, v.coords.z),
                                --     distance = 5.0,
                                --     interactDst = 1.5,
                                --     id = "qb-vehicleshop-showroom-vehicle-" .. model .. "-spotId-" .. v.spotId,
                                --     name ="qb-vehicleshop-showroom-vehicle-" .. model .. "-spotId-" .. v.spotId,
                                   
                                   
                                --     options = {
                                --          {
                                --             canInteract = function()
                                --                 return not isBoss
                                --             end,
                                --             id = "qb-vehicleshop-showroom-vehicle-" .. model .. "-spotId-" .. v.spotId,
                                --             label = "Ask an employee",
                                --            event=  "qb-vehicleshop:askAnEmployee:client",
                                --            args = {}
                                --         },
                                --     }
                                -- })

                                
                                -- exports['qb-textui']:create3DTextUI("qb-vehicleshop-showroom-vehicle-" .. model .. "-spotId-" .. v.spotId, {
                                --     coords = vector3(v.coords.x, v.coords.y, v.coords.z),
                                --     displayDist = 5.0,
                                --     interactDist = 1.5,
                                --     enableKeyClick = true,
                                --     keyNum = 38,
                                --     key = "E",
                                --     text = "Ask an employee",
                                --     theme = "green", 
                                --     triggerData = {
                                --         triggerName = "qb-vehicleshop:askAnEmployee:client",
                                --         args = {}
                                --     }
                                -- })
                            end
                        end
                    end, closestVehShop.id)
                    break
				else
					break
				end
				Citizen.Wait(0)
			end
			closestVehShop = {}
			sleep = 0
		end
		Citizen.Wait(sleep)
	end
end)

RegisterNetEvent('qb-vehicleshop:askAnEmployee:client', function()
    Notify("You need ask an employee to purchase this vehicle.", 7500, "error")
end)

local lastCoords = nil
local currentCar = nil
local menuActive = false
local showroomMenuActive = false
local currentCoords = {}
local nuiState = nil
function openDealership(state, id)
    menuActive = state
    nuiState = state
   
    Config.HUD(not menuActive)
    if menuActive then
        lastCoords = GetEntityCoords(PlayerPedId())
        -- Functions
        currentCoords.boughtVehCoords = Config.VehicleShops[id].Coords.BoughtVehicles
        currentCoords.testVehCoords = Config.VehicleShops[id].Coords.TestVehicles
        currentCoords.showroomVehCoords = Config.VehicleShops[id].Coords.ShowroomVehicles
        DisplayRadar(0)
        SetNuiFocus(true, true)
        local allowedCategories = Config.VehicleShops[id].AllowedCategories
        local categoriesData = {}
        for k, v in pairs(Categories) do
            for a, b in pairs(allowedCategories) do
                if k == b then
                    table.insert(categoriesData, {
                        name = k,
                        label = Lang:t("categories." .. k)
                    })
                end
            end
        end
        table.sort(categoriesData, function(a, b) return a.label < b.label end)
        SetEntityVisible(PlayerPedId(), false, 0)
        SetUserRadioControlEnabled(false)
        local vehiclesT = setupVehicles(id)
        Citizen.Wait(350)
        if  Config.VehicleShops[id].Testdrive==nil then
            Config.VehicleShops[id].Testdrive=true
        end
      
        SendNUIMessage({action = "openDealership",dealershipId = id,testbutton=Config.VehicleShops[id].Testdrive,buybutton=Config.VehicleShops[id].buyinhtml,managementState = false, vehicles = vehiclesT, categories = categoriesData, testDriveTime = Config.TestDriveTime})
    else
        SetEntityVisible(PlayerPedId(), true, 0)
        ClearFocus()
        RenderScriptCams(false, true, 1000, true, false)
        DestroyCam(cam, false)
        DeleteVehiclesInsideShop()
        SetNuiFocus(false, false)
        SendNUIMessage({action = "closeUI"})
        SetUserRadioControlEnabled(true)
        if lastCoords then
            SetEntityCoords(PlayerPedId(), lastCoords)
            lastCoords = nil
        end
    end 
end

function setupVehicles(vehshopId)
    local p = promise:new()
    local data ={}-- = Vehicles
    for k, v in pairs(Vehicles) do
        if v.shop==Config.VehicleShops[vehshopId].shopname then
            data[#data+1]=v
        end
    end
 

    if Config.VehicleShops[vehshopId].EnableStocks == false  then
        for k, v in pairs(data) do
            v.stock = 1
        end
        p:resolve(data)
    else
        TriggerCallback('qb-vehicleshop:getVehStock:server', function(stockData)
            if stockData ~= 0 then
                for k, v in pairs(stockData) do
                    for a, b in pairs(data) do
                        if b.model == v.model then
                            b.stock = v.stock
                        end
                    end
                end
            end
            p:resolve(data)
        end, vehshopId)
    end
    return Citizen.Await(p)
end


function ShowFloatingHelpNotification(msg, coords)
    AddTextEntry('acVehicleShopFloatingHelpNotification', msg)
    SetFloatingHelpTextWorldPosition(1, coords)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('acVehicleShopFloatingHelpNotification')
    EndTextCommandDisplayHelp(2, false, false, -1)
end

RegisterNetEvent('qb-dealership:close:client', function()
    openDealership(false)
end)

local lastVehicles = {}
local testDriveState = false
RegisterNUICallback('callback', function(data)
    if data.action == "chooseVeh" then
        -- Car
        DeleteVehiclesInsideShop()
        RequestModel(GetHashKey(data.veh))
        while not HasModelLoaded(GetHashKey(data.veh)) do
            Citizen.Wait(0)
        end
        currentCar = CreateVehicle(GetHashKey(data.veh), currentCoords.showroomVehCoords, false, false)
       
        local brake = GetVehicleMaxBraking(currentCar)
        local speed = GetVehicleHandlingFloat(currentCar, "CHandlingData", "fInitialDriveMaxFlatVel")
        local acceleration = GetVehicleHandlingInt(currentCar, "CHandlingData", "fSteeringLock")
        local weight = GetVehicleHandlingInt(currentCar, "CHandlingData", "fMass")
        SendNUIMessage({action = "updateCarInformations", acceleration = acceleration, speed = speed, handling = weight, brake = brake})
        -- TaskWarpPedIntoVehicle(PlayerPedId(), currentCar, -1)
        
        SetFocusEntity(currentCar)
        SetVehicleDirtLevel(currentCar, 0.0)
        SetVehicleNumberPlateText(currentCar, "SHOWROOM")
        table.insert(lastVehicles, currentCar)
        SetEntityCoords(PlayerPedId(),currentCoords.showroomVehCoords)

        -- Camera
        local coords = GetOffsetFromEntityInWorldCoords(currentCar, 0, 4.5, 0)
        DestroyCam(cam, false)
        if not DoesCamExist(cam) then
            cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
            SetCamActive(cam, true)
            RenderScriptCams(true, true, 1000, true, true)
            SetCamCoord(cam, coords.x, coords.y, coords.z + 0.6)
            SetCamRot(cam, 0.0, 0.0, GetEntityHeading(currentCar) + 180)
            SetCamUseShallowDofMode(cam, true)
            SetCamNearDof(cam, 0.7)
            SetCamFarDof(cam, 3.3)
            SetCamDofStrength(cam, 0.9)
            Citizen.CreateThread(function()
                while DoesCamExist(cam) do
                    SetUseHiDof()
                    Citizen.Wait(0)  
                end
            end)
        end
      
        SetVehicleEngineOn(currentCar, false, false)
        headingToCam = GetEntityHeading(currentCar) + 90
        camOffset = 4.5
    elseif data.action == "close" then
        if data.type == "showroom" then
            openDealership(false)
        elseif data.type == "showroomEdit" then
            openShowroomMenu(false)
            TriggerServerEvent('qb-vehicleshop:updateShowroomVehicles:server', data.dealershipId, Config.VehicleShops[data.dealershipId].ShowroomVehicles)
        elseif data.type == "sellMenu" then
            TriggerEvent('qb-vehicleshop:openSellingMenu:client',{args= {open = false}})
        else
            SetNuiFocus(false, false)
        end
        if data.test == true and not testDriveState then
            if IsSpawnPointClear(vector3(currentCoords.testVehCoords.x, currentCoords.testVehCoords.y, currentCoords.testVehCoords.z), 2.5) then
                local plate = "TEST" .. math.random(1000, 9999)
                local ped = PlayerPedId()
                playerLastCoords = GetEntityCoords(ped)
                local model = type(data.model) == 'string' and GetHashKey(data.model) or data.model
             
                if not IsModelInCdimage(model) then return end
                if coords then
                    coords = type(coords) == 'table' and vec3(currentCoords.testVehCoords.x, currentCoords.testVehCoords.y, currentCoords.testVehCoords.z) or coords
                else
                    coords = GetEntityCoords(ped)
                end
                RequestModel(model)
                while not HasModelLoaded(model) do
                    Wait(0)
                end
                QBCore.Functions.SpawnVehicle(model, function(currentTestVehicle)
                    -- currentTestVehicle = CreateVehicle(model, currentCoords.testVehCoords.x, currentCoords.testVehCoords.y, currentCoords.testVehCoords.z, currentCoords.testVehCoords.w, true, false)
                    currentTestVehicleNetId = NetworkGetNetworkIdFromEntity(currentTestVehicle)
                    SetVehicleHasBeenOwnedByPlayer(currentTestVehicle, true)
                    SetNetworkIdExistsOnAllMachines(currentTestVehicleNetId, true)
                    SetNetworkIdCanMigrate(currentTestVehicleNetId, true)
                    SetVehicleNeedsToBeHotwired(currentTestVehicle, false)
                    SetModelAsNoLongerNeeded(model)
                    SetVehicleNumberPlateText(currentTestVehicle, plate)
                    Config.GiveKey(plate)
                    Config.SetFuel(currentTestVehicle, 100.0)
                    testDriveState = true
    
                    SendNUIMessage({action = "startTestTimer", testDriveTime = Config.TestDriveTime})
                    TriggerServerEvent('qb-vehicle:server:addtestplate', plate,currentTestVehicleNetId)
                    TriggerServerEvent('qb-vehicleshop:startTest:server', currentTestVehicleNetId)
                    if Config.WarpPedToTestVehicle then
                        TaskWarpPedIntoVehicle(PlayerPedId(), currentTestVehicle, -1)
                    end
                end, currentCoords.testVehCoords, true)

               
            else
                Notify("Spawn point isn't clear.", 7500, "error")
            end
        elseif DoesEntityExist(currentTestVehicle) then
            Notify("You already have a test drive in progress.", 7500, "error")
        end
    elseif data.action == "changeVehColor" then
        SetVehicleCustomPrimaryColour(currentCar, data.r, data.g, data.b)
        SetVehicleCustomSecondaryColour(currentCar, data.r, data.g, data.b)
    elseif data.action == "finishTest" then
        testDriveState = false
        if Config.TeleportBackWhenTestFinishes then
            Notify("Your test period is over.", 7500, "info")
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            SetEntityCoords(PlayerPedId(), playerLastCoords)
            DeleteVehicle(currentTestVehicle)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)
        else
            Notify("Your test period is over.", 7500, "info")
            SetVehicleUndriveable(currentTestVehicle, true)
        end
    elseif data.action == "camLeft" then
        local pedPos = GetEntityCoords(currentCar)
        local camPos = GetCamCoord(cam)
        local heading = headingToCam
        heading = heading - 2.5
        headingToCam = heading
        local cx, cy = GetPositionByRelativeHeading(currentCar, heading, camOffset)
        SetCamCoord(cam, cx, cy, camPos.z)
        PointCamAtCoord(cam, pedPos.x, pedPos.y, camPos.z)
    elseif data.action == "camRight" then
        local pedPos = GetEntityCoords(currentCar)
        local camPos = GetCamCoord(cam)
        local heading = headingToCam
        heading = heading + 2.5
        headingToCam = heading
        local cx, cy = GetPositionByRelativeHeading(currentCar, heading, camOffset)
        SetCamCoord(cam, cx, cy, camPos.z)
        PointCamAtCoord(cam, pedPos.x, pedPos.y, camPos.z)
    elseif data.action == "zoomOut" then
        local pedPos = GetEntityCoords(currentCar)
        if camOffset < 5.6 then
            camOffset = camOffset + 0.50
            local cx, cy = GetPositionByRelativeHeading(currentCar, headingToCam, camOffset)
            SetCamCoord(cam, cx, cy, pedPos.z + 0.65)
            PointCamAtCoord(cam, pedPos.x, pedPos.y, pedPos.z + 0.65)
        end
    elseif data.action == "zoomIn" then
        local pedPos = GetEntityCoords(currentCar)
        if camOffset > 3.4 then
            camOffset = camOffset - 0.50
            local cx, cy = GetPositionByRelativeHeading(currentCar, headingToCam, camOffset)
            SetCamCoord(cam, cx, cy, pedPos.z + 0.65)
            PointCamAtCoord(cam, pedPos.x, pedPos.y, pedPos.z + 0.65)
        end
    elseif data.action == "camDown" then
        local pedPos = GetEntityCoords(currentCar)
        local camPos = GetCamCoord(cam)
        local cx, cy = GetPositionByRelativeHeading(currentCar, headingToCam, camOffset)
        SetCamCoord(cam, cx, cy, camPos.z)
        SetCamRot(cam, 0.0, 0.0, 0.0, 0)
    elseif data.action == "camUp" then
        camPitch = camPitch - 0.5
        SetGameplayCamRelativePitch(camPitch, 1.0)
    elseif data.action == "nuiFocusEvent" then
        camHeading = GetGameplayCamRelativeHeading()
        if nuiState then
            SetNuiFocus(true, false)
            nuiState = false
            RenderScriptCams(false, true, 1000, true, false)
        else
            nuiState = true
            SetNuiFocus(true, true)
            RenderScriptCams(true, true, 1000, true, true)
        end
    elseif data.action == "updateShowroomVehicle" then
        if DoesEntityExist(Config.VehicleShops[data.dealershipId].ShowroomVehicles[data.spotId].vehicle) then
            DeleteVehicle(Config.VehicleShops[data.dealershipId].ShowroomVehicles[data.spotId].vehicle)
        end
        local model = GetHashKey(data.model)
        RequestModel(model)
        while not HasModelLoaded(model) do Citizen.Wait(0) end
        Config.VehicleShops[data.dealershipId].ShowroomVehicles[data.spotId].vehicleModel = data.model
        local spot = Config.VehicleShops[data.dealershipId].ShowroomVehicles[data.spotId]
        Config.VehicleShops[data.dealershipId].ShowroomVehicles[data.spotId].vehicle = CreateVehicle(model, spot.coords.x, spot.coords.y, spot.coords.z, false, false)
        local vehicle = Config.VehicleShops[data.dealershipId].ShowroomVehicles[data.spotId].vehicle
        SetModelAsNoLongerNeeded(model)
        SetVehicleOnGroundProperly(vehicle)
        SetEntityInvincible(vehicle, true)
        SetVehicleDirtLevel(vehicle, 0.0)
        SetVehicleDoorsLocked(vehicle, 3)
        SetEntityHeading(vehicle, spot.coords.w)
        FreezeEntityPosition(vehicle, true)
        SetVehicleNumberPlateText(vehicle, 'BUY ME')
        PlaceObjectOnGroundProperly(vehicle)
        SetVehicleColourCombination(vehicle, 0)
        while not DoesEntityExist(vehicle) do Citizen.Wait(0) end
        TriggerServerEvent('qb-vehicleshop:deleteVehicleShowroom:server', data.dealershipId, data.spotId, data.model)
    elseif data.action == "createSpotCam" then
        DeleteVehiclesInsideShop()
        local coords = GetOffsetFromEntityInWorldCoords(Config.VehicleShops[tonumber(data.dealershipId)].ShowroomVehicles[tonumber(data.spotId)].vehicle, 1.0, 5.5, 0.5)
        if DoesEntityExist(Config.VehicleShops[tonumber(data.dealershipId)].ShowroomVehicles[tonumber(data.spotId)].vehicle) then
            DestroyCam(cam, false)
            if not DoesCamExist(cam) then
                cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
                SetCamActive(cam, true)
                RenderScriptCams(true, true, 1000, true, true)
                SetCamCoord(cam, coords.x, coords.y, coords.z + 0.6)
                SetCamRot(cam, 0.0, 0.0, GetEntityHeading(currentCar) + 0)
            end
        else
            local coords = Config.VehicleShops[tonumber(data.dealershipId)].ShowroomVehicles[tonumber(data.spotId)].coords
            local model = GetHashKey("dubsta2")
            RequestModel("dubsta2")
            while not HasModelLoaded("dubsta2") do Citizen.Wait(0) end
            local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, false, false)
            table.insert(lastVehicles, vehicle)
            SetEntityVisible(vehicle, false, 0)
            SetModelAsNoLongerNeeded(model)
            SetVehicleOnGroundProperly(vehicle)
            DestroyCam(cam, false)
            local camCoords = GetOffsetFromEntityInWorldCoords(vehicle, 1.0, 5.5, 0.5)
            if not DoesCamExist(cam) then
                cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
                SetCamActive(cam, true)
                RenderScriptCams(true, true, 1000, true, true)
                SetCamCoord(cam, camCoords.x, camCoords.y, camCoords.z + 0.6)
                SetCamRot(cam, 0.0, 0.0, GetEntityHeading(vehicle) + 0)
            end
        end
    elseif data.action == "createTextsOnPlayers" then
        SetNuiFocus(false, false)
        sellMenuActive = false
        nearbyPlayers = GetPlayersInArea(GetEntityCoords(PlayerPedId()), 5.0)
        if next(nearbyPlayers) ~= nil and next(nearbyPlayers) then
            taskActive = true
            for _, id in pairs(nearbyPlayers) do
                exports["qb-interact"]:addGlobalPlayerInteraction({
                    distance = 5.0,
                    interactDst = 1.3,
                    offset = vec3(0.0, 0.0, 0.0),
                    id = "qb-vehicleshop-vehshop-players-" .. id,
                    options = {
                        name ="qb-vehicleshop-vehshop-players-" .. id,
                        label = "Send Request",
                        action = function(entity, _, _, serverId)
                            args = {sender = GetPlayerServerId(PlayerId()), target = serverId, model = data.model, price = data.price, dealershipId = data.dealershipId}
                            TriggerEvent('qb-vehicleshop:sendSellRequest:client',args)
                        end,
                    }
                })
                -- exports['qb-textui']:create3DTextUIOnPlayers("qb-vehicleshop-vehshop-players-" .. id, {
                --     id = id,
                --     displayDist = 5.0,
                --     interactDist = 1.3,
                --     enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
                --     keyNum = 38,
                --     key = "E",
                --     text = "Send Request",
                --     theme = "red", -- or red
                --     triggerData = {
                --         triggerName = "qb-vehicleshop:sendSellRequest:client",
                --         args = {sender = GetPlayerServerId(PlayerId()), target = id, model = data.model, price = data.price, dealershipId = data.dealershipId}
                --     }
                -- })
            end
            Citizen.Wait(7500)
            taskActive = false
            Notify("Request timed out.", 7500, "error")
            if next(nearbyPlayers) ~= nil and next(nearbyPlayers) then
                for _, id in pairs(nearbyPlayers) do
                    exports["qb-interact"]:RemoveGlobalPlayerInteraction("qb-vehicleshop-vehshop-players-" .. id)
                end
            end
        else
            Notify("No players nearby.", 7500, "error")
        end
    elseif data.action == "confirmPurchase" then
        local boughtVehCoords = Config.VehicleShops[tonumber(data.dealershipId)].Coords.BoughtVehicles
        if IsAnyVehicleNearPoint(boughtVehCoords.x, boughtVehCoords.y, boughtVehCoords.z, 4.0) then
            QBCore.Functions.Notify("Vehicle Spot is occupied", "error", 4500)
            return
        end

        TriggerServerEvent('qb-vehicleshop:buyVehicle:server', data.paymentType, data.model, Vehicles2[data.model].price, data.dealershipId, data.sender, Config.VehicleShops[data.dealershipId].Management.Job)
    elseif data.action == "addStockForAllVehicles" then
        SetNuiFocus(false, false)
        taskActive = true
        local stocks = {}
        for k, v in pairs(currentMenuVehs) do
            if v.stock then
                v.stock = v.stock + tonumber(data.addStockNum)
            else
                v.stock = tonumber(data.addStockNum)
            end
            table.insert(stocks, {model = v.model, stock = v.stock})
        end
        Citizen.Wait(3000)
        Notify("Successfully added " .. data.addStockNum .. " stock to all vehicles.", 7500, "success")
        TriggerServerEvent('qb-vehicleshop:updateDealershipStockData:server', data.dealershipId, stocks)
        taskActive = false
    elseif data.action == "addStockForSpecificVehicle" then
        SetNuiFocus(false, false)
        taskActive = true
        local stocks = {}
        for k, v in pairs(currentMenuVehs) do
            if v.model == data.model then
                if v.stock then
                    v.stock = v.stock + tonumber(data.addStockNum)
                else
                    v.stock = tonumber(data.addStockNum)
                end
                table.insert(stocks, {model = data.model, stock = v.stock})
            else
                table.insert(stocks, {model = v.model, stock = v.stock})
            end
        end
        Citizen.Wait(3000)
        Notify("Successfully added " .. data.addStockNum .. " stock to " .. data.model .. ".", 7500, "success")
        TriggerServerEvent('qb-vehicleshop:updateDealershipStockData:server', data.dealershipId, stocks)
        taskActive = false
    end
end)

RegisterNetEvent('qb-vehicleshop:sendSellRequest:client', function(data)
    -- Delete All
    if next(nearbyPlayers) ~= nil and next(nearbyPlayers) then
        for _, id in pairs(nearbyPlayers) do
            exports["qb-interact"]:RemoveGlobalPlayerInteraction("qb-vehicleshop-vehshop-players-" .. id)
        end
    end
    -- Add To Sender
    TriggerServerEvent('qb-vehicleshop:sendRequestText:server', data.sender,  data.target,  data.price,  data.model,  data.dealershipId)
    Citizen.Wait(500)
    taskActive = false
end)

currentSender = nil
RegisterNetEvent('qb-vehicleshop:sendRequestText:client', function(sender, price, model, dealershipId)
   
    currentSender = sender
    exports["qb-interact"]:addGlobalPlayerInteraction({
        distance = 5.0,
        interactDst = 1.3,
        offset = vec3(0.0, 0.0, 0.0),
        id = "qb-vehicleshop-vehshop-players-confirm-purchase-" .. sender,
        options = {
          {
            label = "Accept Bank - ($" .. price .. ") / Decline",
            action = function(entity, _, _, serverId)
                args = {price = price, model = model, sender = sender, me = GetPlayerServerId(PlayerId()), dealershipId = dealershipId}
                TriggerEvent("qb-vehicleshop:acceptPayment:client",args)
            end,
          },
          {
            label = "Decline Bank - ($" .. price .. ")",
            action = function(entity, _, _, serverId)
                args = {sender = sender, me = GetPlayerServerId(PlayerId())}
                TriggerEvent('qb-vehicleshop:declinePayment:client',args)
            end,
          } ,
        }
    })
    
    -- exports['qb-textui']:create3DTextUIOnPlayers("qb-vehicleshop-vehshop-players-confirm-purchase-" .. sender, {
    --     id = sender,
    --     displayDist = 5.0,
    --     interactDist = 1.3,
    --     enableKeyClick = true,
    --     keyNum = 38,
    --     keyNum2 = 246,
    --     key = "E/Y",
    --     text = "Accept Bank - ($" .. price .. ") / Decline",
    --     theme = "red",
    --     triggerData = {
    --         triggerName = "qb-vehicleshop:acceptPayment:client",
    --         args = {price = price, model = model, sender = sender, me = GetPlayerServerId(PlayerId()), dealershipId = dealershipId}
    --     },
    --     triggerData2 = {
    --         triggerName = "qb-vehicleshop:declinePayment:client",
    --         args = {sender = sender, me = GetPlayerServerId(PlayerId())}
    --     }
    -- })
    Citizen.Wait(7500)
    taskActive = false
    Notify("Request timed out.", 7500, "error")
    exports["qb-interact"]:RemoveGlobalPlayerInteraction("qb-vehicleshop-vehshop-players-confirm-purchase-" .. sender)
    currentSender = nil
end)

RegisterNetEvent('qb-vehicleshop:acceptPayment:client', function(data)
    Notify("Request accepted.", 7500, "success")
    exports["qb-interact"]:RemoveGlobalPlayerInteraction("qb-vehicleshop-vehshop-players-confirm-purchase-" .. data.sender)
    currentSender = nil
    TriggerServerEvent('qb-vehicleshop:buyVehicle:server', "bank", data.model, tonumber(data.price), data.dealershipId, data.sender, Config.VehicleShops[data.dealershipId].Management.Job)
end)

RegisterNetEvent('qb-vehicleshop:declinePayment:client', function(data)
    Notify("Request declined.", 7500, "error")
    exports["qb-interact"]:RemoveGlobalPlayerInteraction("qb-vehicleshop-vehshop-players-confirm-purchase-" .. data.sender)
    TriggerServerEvent('qb-vehicleshop:declinePayment:server', data.sender)
end)

function GetPlayers(onlyOtherPlayers, returnKeyValue, returnPeds)
    local players, myPlayer = {}, PlayerId()
    local active = GetActivePlayers()
    for i = 1, #active do
        local currentPlayer = active[i]
        local ped = GetPlayerPed(currentPlayer)
        if DoesEntityExist(ped) and ((onlyOtherPlayers and currentPlayer ~= myPlayer) or not onlyOtherPlayers) then
            if returnKeyValue then
                players[currentPlayer] = {entity = ped, id = GetPlayerServerId(currentPlayer)}
            else
                players[#players + 1] = returnPeds and ped or currentPlayer
            end
        end
    end
    return players
end

function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
    local nearbyEntities = {}
    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        local playerPed = PlayerPedId()
        coords = GetEntityCoords(playerPed)
    end
    for k, v in pairs(entities) do
        local distance = #(coords - GetEntityCoords(v.entity))
        if distance <= maxDistance then
            nearbyEntities[#nearbyEntities + 1] = v.id
        end
    end
    return nearbyEntities
end

function EnumerateEntitiesWithinDistance2(entities, isPlayerEntities, coords, maxDistance)
    local nearbyEntities = {}
    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        local playerPed = ESX.PlayerData.ped
        coords = GetEntityCoords(playerPed)
    end
    for k, entity in pairs(entities) do
        local distance = #(coords - GetEntityCoords(entity))

        if distance <= maxDistance then
            nearbyEntities[#nearbyEntities + 1] = isPlayerEntities and k or entity
        end
    end
    return nearbyEntities
end

function GetPlayersInArea(coords, maxDistance)
    return EnumerateEntitiesWithinDistance(GetPlayers(true, true), true, coords, maxDistance)
end

function GetVehiclesInArea(coords, maxDistance)
    return EnumerateEntitiesWithinDistance2(GetVehicles(), false, coords, maxDistance)
end

function IsSpawnPointClear(coords, maxDistance)
    return #GetVehiclesInArea(coords, maxDistance) == 0
end

function GetVehicles()
    return GetGamePool("CVehicle")
end

function GetPositionByRelativeHeading(ped, head, dist)
    local pedPos = GetEntityCoords(ped)
    local finPosx = pedPos.x + math.cos(head * (math.pi / 180)) * dist
    local finPosy = pedPos.y + math.sin(head * (math.pi / 180)) * dist
    return finPosx, finPosy
end

function DeleteVehiclesInsideShop()
	while #lastVehicles > 0 do
		local vehicle = lastVehicles[1]
		DeleteVehicle(vehicle)
		table.remove(lastVehicles, 1)
	end
end

AddEventHandler('onResourceStop', function(resource)
    if GetCurrentResourceName() == resource then
        DeleteEntity(obj)
        openDealership(false)
        DeleteVehicle(currentCar)
        ClearFocus()
        RenderScriptCams(false, true, 1000, true, false)
        DestroyCam(cam, false)
        for k, v in pairs(Config.VehicleShops) do
            for a, b in pairs(v.ShowroomVehicles) do
                DeleteVehicle(b.vehicle)
                local model = GetHashKey(b.vehicleModel)
                exports["qb-interact"]:RemoveGlobalPlayerInteraction("qb-vehicleshop-showroom-vehicle-" .. model .. "-spotId-" .. b.spotId)
            end
            
            exports["qb-interact"]:RemoveGlobalPlayerInteraction("qb-vehicleshop-vehshop-" .. k)
        end
        if nearbyPlayers and next(nearbyPlayers) ~= nil and next(nearbyPlayers) then
            for _, id in pairs(nearbyPlayers) do
                exports["qb-interact"]:RemoveGlobalPlayerInteraction("qb-vehicleshop-vehshop-players-" .. id)
            end
        end
        if currentSender then
            exports["qb-interact"]:RemoveGlobalPlayerInteraction("qb-vehicleshop-vehshop-players-confirm-purchase-" .. currentSender)

        end
    end
end)

AddEventHandler('gameEventTriggered', function(event, data)
    if event == 'CEventNetworkEntityDamage' then
        local victim, attacker, victimDied, weapon = data[1], data[2], data[4], data[7]
		if not IsEntityAPed(victim) then return end
        if victimDied and NetworkGetPlayerIndexFromPed(victim) == PlayerId() and IsEntityDead(PlayerPedId()) and menuActive then
            openDealership(false)
            menuActive = false
		end
	end
end)

local str = [[🚫Keep Area Clear🚫
Test Drive Vehicle Returns]]
Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local playerCoords = GetEntityCoords(PlayerPedId())
        for k, v in pairs(Config.VehicleShops) do
            local dist = #(playerCoords - vector3(v.Coords.TestVehicles.x, v.Coords.TestVehicles.y, v.Coords.TestVehicles.z))
            if dist <= 3 then
                sleep = 0
                DrawText3D(v.Coords.TestVehicles.x, v.Coords.TestVehicles.y, v.Coords.TestVehicles.z, str)
            end
        end
        Citizen.Wait(sleep)
    end
end)

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(6)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 245)
    BeginTextCommandDisplayText('STRING')
    SetTextCentre(true)
    AddTextComponentSubstringPlayerName(text)
    SetDrawOrigin(x, y, z, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    local factor = (string.len(text)) / 570
    DrawRect(0.0, 0.0 + 0.025, 0.017 + factor, 0.06, 0, 0, 0, 145)
    ClearDrawOrigin()
end

RegisterNetEvent('qb-vehicleshop:buyVehicle:client', function(model, plate, dealershipId)
    -- DoScreenFadeOut(500)
    openDealership(false)
    Citizen.Wait(1000)
    local boughtVehCoords = Config.VehicleShops[tonumber(dealershipId)].Coords.BoughtVehicles
    QBCore.Functions.SpawnVehicle(model, function(vehicle)
        SetVehicleNumberPlateText(vehicle, plate)
        SetVehicleDoorsLocked(vehicle, 2)
        Config.GiveKey(plate)
        Config.SetFuel(currentBoughtVehicle, 100.0)
        TriggerServerEvent("qb-vehicleshop:server:saveVehicle", plate, model, QBCore.Functions.GetVehicleProperties(vehicle))
    end, vector4(boughtVehCoords.x, boughtVehCoords.y, boughtVehCoords.z, boughtVehCoords.w), true, false)
    -- DoScreenFadeIn(500)
end)

function openShowroomMenu(id, state, spots, job)
    showroomMenuActive = state
    if showroomMenuActive then
        if GetPlayerJob() == job then else return Notify("You don't have access here.", 7500, "error") end
        local spotsData = {}
        for k, v in pairs(spots) do
            table.insert(spotsData, {
                id = k,
                coords = v.coords
            })
        end
        SendNUIMessage({action = "openShowroomMenu", dealershipId = id, spots = spotsData, vehicles = Vehicles})
        SetNuiFocus(true, true)
    else
        DeleteVehiclesInsideShop()
        RenderScriptCams(false, true, 1000, true, false)
        DestroyCam(cam, false)
        SetNuiFocus(false, false)
        SendNUIMessage({action = "closeUI"})
    end
end

RegisterNetEvent('qb-vehicleshop:finishTest:client', function()
    testDriveState = false
    SendNUIMessage({action = "stopTestTimer"})
    if Config.TeleportBackWhenTestFinishes then
        Notify("Your test period is over.", 7500, "info")
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        SetEntityCoords(PlayerPedId(), playerLastCoords)
        if DoesEntityExist(currentTestVehicle) then DeleteVehicle(currentTestVehicle) end
        Citizen.Wait(1000)
        DoScreenFadeIn(1000)
    else
        Notify("Your test period is over.", 7500, "info")
        if DoesEntityExist(currentTestVehicle) then
            SetVehicleUndriveable(currentTestVehicle, true)
        end
    end
end)

AddEventHandler('gameEventTriggered', function(event, data)
    if event == "CEventNetworkVehicleUndrivable" then
        local vehicle = data[1]
        local netId = NetworkGetNetworkIdFromEntity(vehicle)
        if netId == currentTestVehicleNetId then
            TriggerEvent('qb-vehicleshop:finishTest:client')
            TriggerServerEvent('qb-vehicleshop:finishTest:server', netId)
        end
    end
    if event == "CEventNetworkEntityDamage" then
        local vehicle = data[1]
        local netId = NetworkGetNetworkIdFromEntity(vehicle)
        if netId == currentTestVehicleNetId then
            if GetVehicleBodyHealth(vehicle) == 0 then
                TriggerEvent('qb-vehicleshop:finishTest:client')
                TriggerServerEvent('qb-vehicleshop:finishTest:server', netId)
            end
        end
    end
end)

closestDeliveryPoints = {}
local showTextUI = false
Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		playerPed = PlayerPedId()
		playerCoords = GetEntityCoords(playerPed)
        if IsPedInAnyVehicle(playerPed, false) then
            if not closestDeliveryPoints.id then
                for k, v in pairs(Config.VehicleShops) do
                    local dist = #(playerCoords - vector3(v.Coords.TestVehicles.x, v.Coords.TestVehicles.y, v.Coords.TestVehicles.z))
                    if dist <= 3 then
                        function currentShow()
                            exports["qb-textui"]:displayTextUI("Give Back Test Vehicle", "E")
                            showTextUI = true
                        end
                        function currentHide()
                            showTextUI = false
                            exports["qb-textui"]:hideTextUI()
                        end
                        closestDeliveryPoints = {id = k, distance = dist, maxDist = 5.0, data = {coords = vector3(v.Coords.TestVehicles.x, v.Coords.TestVehicles.y, v.Coords.TestVehicles.z)}}
                    end
                end
            end
        end
		if closestDeliveryPoints.id then
			while true do
				playerCoords = GetEntityCoords(playerPed)
				closestDeliveryPoints.distance = #(closestDeliveryPoints.data.coords - playerCoords)
				if closestDeliveryPoints.distance < closestDeliveryPoints.maxDist then
					if IsControlJustReleased(0, 38) then
                        local veh = GetVehiclePedIsUsing(PlayerPedId())
                        if VehToNet(veh) == VehToNet(currentTestVehicle) then
                            testDriveState = false
                            SendNUIMessage({action = "stopTestTimer"})
                            TriggerServerEvent('qb-vehicleshop:finishTest:server', VehToNet(currentTestVehicle))
                            TaskLeaveVehicle(PlayerPedId(), currentTestVehicle, 0)
                            while IsPedInAnyVehicle(playerPed, false) do Citizen.Wait(2000) end
                            if DoesEntityExist(currentTestVehicle) then DeleteVehicle(currentTestVehicle) end
                            showTextUI = false
                            exports["qb-textui"]:hideTextUI()
                        end
					end
					if not showTextUI then
						currentShow()
					end
				else
					currentHide()
					break
				end
				Citizen.Wait(0)
			end
			showTextUI = false
			closestDeliveryPoints = {}
			--sleep = 0
		end
		Citizen.Wait(sleep)
	end
end)

RegisterNetEvent('qb-vehicleshop:deleteVehicle:client', function(netId)
    local vehicle = NetToVeh(netId)
    if DoesEntityExist(vehicle) then
        DeleteVehicle(vehicle)
    end
end)

--RegisterNetEvent('qb-vehicleshop:deleteVehicleShowroom:client', function(dealershipId, spotId, newModel, props)
RegisterNetEvent('qb-vehicleshop:deleteVehicleShowroom:client', function(dealershipId, spotId, newModel, createNew)
    -- Delete Old
    if Config.VehicleShops[dealershipId].ShowroomVehicles[spotId].vehicle then
        if DoesEntityExist(Config.VehicleShops[dealershipId].ShowroomVehicles[spotId].vehicle) then
            DeleteVehicle(Config.VehicleShops[dealershipId].ShowroomVehicles[spotId].vehicle)
        end
    end
    -- New Model
    Config.VehicleShops[dealershipId].ShowroomVehicles[spotId].vehicleModel = newModel
    if createNew then
        local model = GetHashKey(newModel)
        RequestModel(model)
        while not HasModelLoaded(model) do Citizen.Wait(0) end
        local spot = Config.VehicleShops[dealershipId].ShowroomVehicles[spotId]
        Config.VehicleShops[dealershipId].ShowroomVehicles[spotId].vehicle = CreateVehicle(model, spot.coords.x, spot.coords.y, spot.coords.z, false, false)
        local vehicle = Config.VehicleShops[dealershipId].ShowroomVehicles[spotId].vehicle
        SetModelAsNoLongerNeeded(model)
        SetVehicleOnGroundProperly(vehicle)
        SetEntityInvincible(vehicle, true)
        SetVehicleDirtLevel(vehicle, 0.0)
        SetVehicleDoorsLocked(vehicle, 3)
        SetEntityHeading(vehicle, spot.coords.w)
        FreezeEntityPosition(vehicle, true)
        SetVehicleNumberPlateText(vehicle, 'BUY ME')
        PlaceObjectOnGroundProperly(vehicle)
        SetVehicleColourCombination(vehicle, 0)
    end
end)