local QBCore = exports['qb-core']:GetCoreObject()

local LocProbed = nil
local probeobj = nil
local pickaxeobj = nil
local miningArea = {["Great Chaparral"] = true}
local Props = {}

function isMiningArea()
    return miningArea[GetLabelText(GetNameOfZone(GetEntityCoords(PlayerPedId())))] == true
end

RegisterNetEvent('mining:useProbe')
AddEventHandler('mining:useProbe',function(slot)
    if not isMiningArea() then
        QBCore.Functions.Notify('You can\'t use this here!', 'error')
        return
    end
    local pos = GetEntityCoords(PlayerPedId())
    if not LocalPlayer.state["inv_busy"] then
        QBCore.Functions.TriggerCallback('qb-mining:Callback:CheckIfDigged', function(Digged)
            if not Digged then
                UseProbe()
                TriggerServerEvent("inventory:server:breakItem", 'miningprobe', 1, slot)
            else
                QBCore.Functions.Notify('Nothing here!', 'error')
            end
        end, pos)
    else
        QBCore.Functions.Notify('You can\'t use this Right Now!', 'error')
    end
end)

RegisterNetEvent('mining:usePickaxe')
AddEventHandler('mining:usePickaxe',function(slot)
    if not isMiningArea() then
        QBCore.Functions.Notify('You can\'t use this here!', 'error')
        return
    end
    local pos = GetEntityCoords(PlayerPedId())
    if not LocalPlayer.state["inv_busy"] then
        QBCore.Functions.TriggerCallback('qb-mining:Callback:CheckIfDigged', function(Digged)
            if not Digged then
                UsePickaxe()
                TriggerServerEvent("inventory:server:breakItem", 'miningpickaxe', 1, slot)
            else
                QBCore.Functions.Notify('This place is already digged!', 'error')
            end
        end, pos)
    else
        QBCore.Functions.Notify('You can\'t use this Right Now!', 'error')
    end
end)

Citizen.CreateThread(function()
    -- Blip --
    -- blip = AddBlipForCoord(Config.BlipLocation)
    -- SetBlipSprite(blip, 366)
    -- SetBlipDisplay(blip, 4)
    -- SetBlipScale(blip, 0.68)
    -- SetBlipColour(blip, 2)
    -- SetBlipAsShortRange(blip, true)
    -- BeginTextCommandSetBlipName("STRING")
    -- AddTextComponentString(Config.BlipName)
    -- EndTextCommandSetBlipName(blip)

    -- Spawn Ped and setup eye target --
    exports["qb-target"]:AddBoxZone("kharidmining", vector3(-599.97, 2088.04, 132.37), 1.5, 1.5, {
        name="kharidmining",
        heading=0,
        debugPoly=false,
        minZ=130.13,
        maxZ=135.13,
    }, {
        options = {
            {
                event = "qb-mining:shop",
                icon = "fas fa-print",
                label = "Mining Items",
            }
        },
        distance = 2
    })

    -- Sang Shooi
    -- local sangblip = AddBlipForCoord(286.58804321289, 2845.2653808594, 43.704154968262)
    -- SetBlipSprite(sangblip, 366)
    -- SetBlipDisplay(sangblip, 4)
    -- SetBlipScale(sangblip, 0.68)
    -- SetBlipColour(sangblip, 3)
    -- SetBlipAsShortRange(sangblip, true)
    -- BeginTextCommandSetBlipName("STRING")
    -- AddTextComponentString('Melter')
    -- EndTextCommandSetBlipName(sangblip)
    local model = GetHashKey('s_m_m_dockwork_01')
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    local ped = CreatePed(4, model, 286.58804321289, 2845.2653808594, 43.704154968262, 123.41134643555, false, false)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)
    exports['qb-target']:AddCircleZone('sangshoii', vector3(286.58804321289, 2845.2653808594, 44.704154968262), 2.0,{
        name="sangshoii",
        debugPoly=false,
        useZ=true,
    }, {
        options = {
            {
                event = "qb-crafting:client:openCraft",
                name = 'Meltitem',
                icon = "fa fa-circle",
                label = "Open Melter"
            },
        },
        distance = 1.5
    })
end)

function loadModel(model) if not HasModelLoaded(model) then RequestModel(model) while not HasModelLoaded(model) do Wait(0) end end end

function makeProp(data)
	loadModel(data.prop)
	local object = CreateObject(data.prop, vector3(data.coords.x, data.coords.y, data.coords.z-1.03), false, false, false)
	SetEntityHeading(object, data.coords[4]-180.0)
	FreezeEntityPosition(object, true)
end

CreateThread(function()
    makeProp({coords = vector4(-593.29, 2093.22, 131.7, 110.0), prop = `prop_worklight_02a`}) -- Mineshaft door
    makeProp({coords = vector4(-604.55, 2089.74, 131.15, 300.0), prop = `prop_worklight_02a`}) -- Mineshaft door 2
    makeProp({coords = vector4(2991.59, 2758.07, 42.68, 250.85), prop = `prop_worklight_02a`}) -- Quarry Light
    makeProp({coords = vector4(2991.11, 2758.02, 42.66, 194.6), prop = `prop_worklight_02a`}) -- Quarry Light
    makeProp({coords = vector4(2971.78, 2743.33, 43.29, 258.54), prop = `prop_worklight_02a`}) -- Quarry Light
    makeProp({coords = vector4(3000.72, 2777.08, 43.08, 211.7), prop = `prop_worklight_02a`}) -- Quarry Light
    makeProp({coords = vector4(2998.0, 2767.45, 42.71, 249.22), prop = `prop_worklight_02a`}) -- Quarry Light
    makeProp({coords = vector4(2959.93, 2755.26, 43.71, 164.24), prop = `prop_worklight_02a`}) -- Quarry Light
    makeProp({coords = vector4(1106.46, -1991.44, 31.49, 185.78), prop = `prop_worklight_02a`}) -- Foundary Light
end)

CreateModelHide(vector3(-596.04, 2089.01, 131.41), 10.5, -1241212535, true)

RegisterNetEvent('qb-mining:shop')
AddEventHandler('qb-mining:shop',function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "mining", Config.Items)
end)

function UseProbe()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local dedector = "w_am_digiscanner"
    RequestModel(dedector)
    while not HasModelLoaded(dedector) do
        Wait(1)
    end

    probeobj = CreateObject(dedector, coords.x, coords.y, coords.z, false, false, false)
    AttachEntityToEntity(probeobj, ped, GetPedBoneIndex(ped, 18905), 0.15, 0.1, 0.0, 270.0, 90.0, 80.0, 1, 1, 0, 0, 2, 1)
    LocalPlayer.state:set("inv_busy", true, true)
    QBCore.Functions.Progressbar('probing', 'Probing...', 15000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@golfai",
        anim = "wood_idle_a",
        flags = 7,
    }, {}, {}, function()
        LocProbed = coords
        ClearPedTasks(ped)
        SetEntityCompletelyDisableCollision(probeobj, false, true)
        DetachEntity(probeobj, 1, false)
        DeleteObject(probeobj)
        QBCore.Functions.Notify('This looks like a good place to dig')
        probeobj = nil
        LocalPlayer.state:set("inv_busy", false, true)
    end, function() -- Cancel
        ClearPedTasks(ped)
        SetEntityCompletelyDisableCollision(probeobj, false, true)
        DetachEntity(probeobj, 1, false)
        DeleteObject(probeobj)
        QBCore.Functions.Notify('Cancelled.')
        probeobj = nil
    end)
end

function UsePickaxe()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    if #(LocProbed - coords) < 3 then
        local pickaxe = "prop_tool_pickaxe"
        RequestModel(pickaxe)
        while not HasModelLoaded(pickaxe) do
            Wait(1)
        end
        LocalPlayer.state:set("inv_busy", true, true)
        pickaxeobj = CreateObject(pickaxe, coords.x, coords.y, coords.z, false, false, false)
        AttachEntityToEntity(pickaxeobj, ped, GetPedBoneIndex(ped, 57005), 0.09, 0.03, -0.02, -78.0, 13.0, 28.0, false, true, true, true, 0, true)
        QBCore.Functions.Progressbar('mine_start', 'Mining...', 15000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "melee@large_wpn@streamed_core",
            anim = "ground_attack_on_spot",
            flags = 7,
        }, {}, {}, function()
            TriggerServerEvent('qb-mining:server:SyncDiggedPos', coords)
            ClearPedTasks(ped)
            SetEntityCompletelyDisableCollision(pickaxeobj, false, true)
            DetachEntity(pickaxeobj, 1, false)
            DeleteObject(pickaxeobj)
            TriggerServerEvent("qb-mining:giveItems")
            pickaxeobj = nil
            LocalPlayer.state:set("inv_busy", false, true)
        end, function() -- Cancel
            ClearPedTasks(ped)
            SetEntityCompletelyDisableCollision(pickaxeobj, false, true)
            DetachEntity(pickaxeobj, 1, false)
            DeleteObject(pickaxeobj)
            QBCore.Functions.Notify('Cancelled.')
            pickaxeobj = nil
            LocalPlayer.state:set("inv_busy", false, true)
        end)
    else
        QBCore.Functions.Notify('Check this place first!', 'error')
    end
end