local QBCore = exports['qb-core']:GetCoreObject()
local MyHouse = nil
local HouseObj = nil

local ShellTypes = {
    ['lev'] = {
        model='lev_apartment_shell',
        exit = {x=-0.71,y=-2.64,z=0.38},
        stash = {x=3.35,y=-2.25,z=0.38},
        outfit = {x=7.36,y=3.80,z=1.0},
        enter = {x=-0.33,y=-2.42,z=0.38,h=272.40}
    },
    ['tihulu'] = {
        model='tihulu_kafi_motel',
        exit = {x=0.0,y=-4.89,z=0.0},
        stash = {x=-2.34,y=-2.18,z=1.0},
        outfit = {x=4.38,y=-2.98,z=1.0},
        enter = {x=0.03,y=-4.37,z=0.0,h=1.26}
    },
    ['tpcm'] = {
        model='envi_shell_03_furnished',
        exit = {x=5.07,y=1.12,z=0.19},
        stash = {x=0.74,y=-2.53,z=0.19},
        outfit = {x=-3.470032,y=4.760498,z= 1.194542},
        enter = {x=4.75,y=1.11,z=0.19,h=91.93}
    },
}

if Config.Debug then
    local debugc = nil
    RegisterCommand('spawnapt', function(source, args)
        local model = GetHashKey(args[1])
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(3)
        end
        local coords = GetEntityCoords(PlayerPedId())
        HouseObj = CreateObject(model, coords.x, coords.y, coords.z-50, false, false, false)
        FreezeEntityPosition(HouseObj, true)
        debugc = coords
        print('done')
    end)
    RegisterCommand('getapt', function()
        local coords = GetEntityCoords(PlayerPedId())
        print(debugc.x - coords.x)
        print(debugc.y - coords.y)
        print(debugc.z-50 - coords.z)
    end)
    RegisterCommand('enterapt', function()
        TriggerServerEvent('qb-apartments:server:EnterHouse')
    end)
end

local function CreateTargets()
    local shelltype = ShellTypes[Config.Appartments[MyHouse].Shell]
    local apt = Config.Appartments[MyHouse].enterCoords
    exports['qb-target']:AddBoxZone('appartment_enter', apt, 1, 1, {
        name = 'appartment_enter',
        debugPoly = Config.Debug,
        minZ = apt.z - 1,
        maxZ = apt.z + 1,
    }, {
        options = {
            {
                type = "client",
                event = "qb-apartments:client:EnterHouse",
                icon = "fas fa-door-open",
                label = "Enter Room"
            }
        },
        distance = 1.5
    })
    exports['qb-target']:AddBoxZone('appartment_exit', vector3(apt.x+shelltype.exit.x,apt.y+shelltype.exit.y,apt.z-50+shelltype.exit.z), 1.8, 1.5, {
        name = 'appartment_exit',
        debugPoly = Config.Debug,
        heading=0,
        minZ=apt.z-50+shelltype.exit.z -2,
        maxZ=apt.z-50+shelltype.exit.z +2
    }, {
        options = {
            {
                type = "client",
                event = "apartments:client:LeaveApartment",
                icon = "fas fa-door-open",
                label = "Leave Room"
            }
        },
        distance = 1.5
    })
    exports['qb-target']:AddBoxZone("appartment_stash",vector3(apt.x+shelltype.stash.x,apt.y+shelltype.stash.y,apt.z-50+shelltype.stash.z),1.2, 1, {
        name = 'appartment_stash',
        debugPoly = Config.Debug,
        heading=180,
        minZ=apt.z-50+shelltype.stash.z-1,
        maxZ=apt.z-50+shelltype.stash.z+1
    }, {
        options = {
            {
                type = "client",
                event = "apartments:client:OpenStash",
                icon = "fas fa-box-open",
                label = "Open Stash"
            }
        },
        distance = 1.5
    })
    exports['qb-target']:AddBoxZone("appartment_outfit",vector3(apt.x+shelltype.outfit.x,apt.y+shelltype.outfit.y,apt.z-50+shelltype.outfit.z), 1.6, 1, {
        name = 'appartment_outfit',
        debugPoly = Config.Debug,
        heading=0,
        minZ=apt.z-50+shelltype.outfit.z-1,
        maxZ=apt.z-50+shelltype.outfit.z+1
    }, {
        options = {
            {
                type = "client",
                event = "apartments:client:ChangeOutfit",
                icon = "fas fa-tshirt",
                label = "Open Outfit Menu"
            }
        },
        distance = 1.5
    })
end

local function GetAptLabel()
    local aptNum = MyHouse or 1
    local apt = Config.Appartments[MyHouse]
    local streetName,_ = GetStreetNameAtCoord(apt.enterCoords.x,apt.enterCoords.y,apt.enterCoords.z)
    streetName = GetStreetNameFromHashKey(streetName)
    if apt.label == 'Room' then
        return streetName
    else
        return streetName..', Room '..apt.label
    end
end exports('GetRoomLabel', GetAptLabel)

local function DespawnInterior(cb)
    CreateThread(function()
        if HouseObj and DoesEntityExist(HouseObj) then
            DeleteEntity(HouseObj)
            HouseObj = nil
        end
        if cb then
            cb()
        end
    end)
end

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

local function openHouseAnim()
    loadAnimDict("anim@heists@keycard@")
    TaskPlayAnim(PlayerPedId(), "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0)
    Wait(400)
    ClearPedTasks(PlayerPedId())
end

local function EnterApartment()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.1)
    openHouseAnim()
    Wait(250)
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Wait(10)
    end
    local shell = ShellTypes[Config.Appartments[MyHouse].Shell]
    local model = GetHashKey(shell.model)
	RequestModel(model)
	while not HasModelLoaded(model) do
	    Wait(3)
	end
    local apt = Config.Appartments[MyHouse].enterCoords
	HouseObj = CreateObject(model, apt.x, apt.y, apt.z - 50, false, false, false)
    FreezeEntityPosition(HouseObj, true)
    Wait(500)
    TriggerEvent('qb-weathersync:client:DisableSync')
    TriggerEvent("backitems:displayItems", false)
    SetEntityCoords(PlayerPedId(), apt.x+shell.enter.x, apt.y+shell.enter.y, apt.z-50+shell.enter.z)
    SetEntityHeading(PlayerPedId(), shell.enter.h)
    Wait(100)
    DoScreenFadeIn(1000)
    Wait(100)
    TriggerServerEvent('qb-apartments:server:SetInsideMeta', true)
    TriggerEvent('qb-apartments:client:InsideState', true)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_close", 0.1)
end

local function LeaveApartment()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.1)
    openHouseAnim()
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Wait(10)
    end
    TriggerEvent('qb-weathersync:client:EnableSync')
    local apt = Config.Appartments[MyHouse].exitCoords
    SetEntityCoords(PlayerPedId(), apt.x, apt.y, apt.z)
    SetEntityHeading(PlayerPedId(), apt.w)
    DespawnInterior(function()
        Wait(1000)
        TriggerServerEvent('qb-apartments:server:SetInsideMeta', false)
        TriggerEvent('qb-apartments:client:InsideState', false)
        DoScreenFadeIn(1000)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_close", 0.1)
        Wait(1000)
        TriggerEvent("backitems:displayItems", true)
    end)
end

RegisterNetEvent('qb-apartments:client:EnterHouse', function(houseNum, notGo)
    if not MyHouse then
        MyHouse = houseNum
        local apt = Config.Appartments[MyHouse]
        local blip = AddBlipForCoord(apt.enterCoords.x,apt.enterCoords.y,apt.enterCoords.z)
        SetBlipSprite(blip, 475)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.7)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, 3)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(GetAptLabel())
        EndTextCommandSetBlipName(blip)
        CreateTargets()
    end
    if not notGo then
        EnterApartment()
    end
end)

RegisterNetEvent('apartments:client:LeaveApartment', function()
    LeaveApartment()
end)

RegisterNetEvent('apartments:client:OpenStash', function()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'Appartment_'..QBCore.Functions.GetPlayerData().citizenid, {maxweight = 200000, slots = 50})
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "StashOpen", 0.4)
end)

RegisterNetEvent('apartments:client:ChangeOutfit', function()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "Clothes", 0.4)
    TriggerEvent('lvs_clothing:client:openOutfit')
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        if HouseObj then
            DespawnInterior()
        end
        exports['qb-target']:RemoveZone("appartment_enter")
        exports['qb-target']:RemoveZone("appartment_exit")
        exports['qb-target']:RemoveZone("appartment_stash")
        exports['qb-target']:RemoveZone("appartment_outfit")
    end
end)