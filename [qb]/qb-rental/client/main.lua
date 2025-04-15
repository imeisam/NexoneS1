local QBCore = exports["qb-core"]:GetCoreObject()
local pedSpawned = false
local ShopPed = {}

local spawncarcoords

local function openRentMenu(data)
    SendNUIMessage({
        action = "OPEN",
        data = data,
        limitday=Config.limitday,
    })
    SetNuiFocus(true, true)
end

local function createBlips()
    if pedSpawned then return end

    for store in pairs(Config.Locations) do
        if Config.Locations[store]["showblip"] then
            local StoreBlip = AddBlipForCoord(Config.Locations[store]["coords"]["x"], Config.Locations[store]["coords"]["y"], Config.Locations[store]["coords"]["z"])
            SetBlipSprite(StoreBlip, Config.Locations[store]["blipsprite"])
            SetBlipScale(StoreBlip, Config.Locations[store]["blipscale"])
            SetBlipDisplay(StoreBlip, 4)
            SetBlipColour(StoreBlip, Config.Locations[store]["blipcolor"])
            SetBlipAsShortRange(StoreBlip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Config.Locations[store]["label"])
            EndTextCommandSetBlipName(StoreBlip)
        end
    end
end

local function createPeds()
    if pedSpawned then return end

    for k, v in pairs(Config.Locations) do
        local current = type(v["ped"]) == "number" and v["ped"] or joaat(v["ped"])

        RequestModel(current)
        while not HasModelLoaded(current) do
            Wait(0)
        end

        ShopPed[k] = CreatePed(0, current, v["coords"].x, v["coords"].y, v["coords"].z-1, v["coords"].w, false, false)
        TaskStartScenarioInPlace(ShopPed[k], v["scenario"], 0, true)
        FreezeEntityPosition(ShopPed[k], true)
        SetEntityInvincible(ShopPed[k], true)
        SetBlockingOfNonTemporaryEvents(ShopPed[k], true)

        -- exports['qb-target']:AddTargetEntity(ShopPed[k], {
        --     options = {
        --         {
        --             label = v["targetLabel"],
        --             icon = v["targetIcon"],
        --             action = function()
        --                 spawncarcoords = v.carspawn,
        --                 openRentMenu(v.categorie)
        --             end,
        --         }
        --     },
        --     distance = 2.0
        -- })

        exports["qb-interact"]:AddLocalEntityInteraction({
            entity = ShopPed[k],
            name = 'rental'..k,
            id = 'rental'..k, 
            distance = 3.0,
            interactDst = 1.5, 
            offset = vec3(0.0, 0.0, 0.0), -- optional
            groups = v.jobs,
            options = {
                {
                    label = v["targetLabel"],
                    action = function()
                        spawncarcoords = v.carspawn,
                        openRentMenu(v.categorie)
                    end,
                },
            }
        })
    end

    pedSpawned = true
end


local function deletePeds()
    if not pedSpawned then return end
    for _, v in pairs(ShopPed) do
        DeletePed(v)
    end
    pedSpawned = false
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    createBlips()
    createPeds()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    deletePeds()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    createBlips()
    createPeds()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    deletePeds()
end)


RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('rent', function(data)
    SetNuiFocus(false, false)
    if IsAnyVehicleNearPoint(spawncarcoords.x, spawncarcoords.y, spawncarcoords.z, 2.0) then
        QBCore.Functions.Notify("Vehicle Spot is occupied", "error", 4500)
        return
    end
    if tonumber(data.carDay) < 1 then QBCore.Functions.Notify("Do not push me to ban you please", "error", 4500) return end
    ExecuteCommand('e clipboard')
    QBCore.Functions.Progressbar("lockpick_vehicledoor", "Find Your Car...", 10000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        ExecuteCommand('e c')
        TriggerServerEvent("qb-rental:sv:rentVehicle", data)
    end, function()
        ExecuteCommand('e c')
        QBCore.Functions.Notify("Rent Cancel...", "error", 4500)
        return
    end)


   
end)

RegisterNetEvent('qb-rental:cl:spawnVehicle', function(model,time,plate)
    QBCore.Functions.SpawnVehicle(model, function(vehicle)
        SetVehicleNumberPlateText(vehicle, plate)
        SetEntityHeading(vehicle, spawncarcoords.w)
        TriggerServerEvent("qb-vehiclekeys:server:AcquireVehicleKeys", plate)
        SetVehicleDirtLevel(vehicle, 0.0)
        exports[Config.Fuel]:SetFuel(vehicle, 100)
        TriggerServerEvent("qb-rental:sv:updatesql", plate, model, time)
    end, spawncarcoords, true)
end)