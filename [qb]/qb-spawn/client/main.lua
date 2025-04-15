local QBCore = exports['qb-core']:GetCoreObject()
local Zones = {}
local Locations = {
    ['government'] = {
        coords = vector4(380.89971923828, -1539.3629150391, 29.291622161865, 141.45587158203),
        image = "city-hall.png",
        top = "53.3%",
        left = "28%",
    },
    ['missionrow station'] = {
        coords = vector4(418.45153808594, -944.37866210938, 29.367740631104, 175.95484924316),
        image = "policeman.png",
        top = "54%",
        left = "32.5%",
    },
    ['vespucci station'] = {
        coords = vector4(-1150.8824462891, -800.81213378906, 15.502883911133, 217.18379211426),
        image = "policeman.png",
        top = "38%",
        left = "33.5%",
    },
    ['air port'] = {
        coords = vector4(-1035.6904296875, -2735.1604003906, 20.169273376465, 332.41363525391),
        image = "travelling.png",
        top = "39%",
        left = "22%",
    },
    ['sandy shores'] = {
        coords = vector4(1911.4809570313, 3711.2333984375, 32.698997497559, 211.50872802734),
        image = "",
        top = "68%",
        left = "62%",
    },
    ['paleto bay'] = {
        coords = vector4(-391.0676574707, 6048.013671875, 31.499979019165, 136.62980651855),
        image = "",
        top = "45%",
        left = "76%",
    },
}
local Apartments = {
    {
        name = 'aptHospital',
        zone = {
            vector2(317.67739868164, -1337.0515136719),
            vector2(245.72387695312, -1427.3223876953),
            vector2(179.68095397949, -1387.3210449219),
            vector2(235.78242492676, -1306.748046875)
        },
        top = "53%",
        left = "30.5%"
    },
    {
        name = 'aptMegaMall',
        zone = {
            vector2(-39.016544342041, -1731.8618164062),
            vector2(45.412734985352, -1686.5001220703),
            vector2(156.87338256836, -1781.5819091797),
            vector2(92.012016296387, -1848.703125)
        },
        top = "50%",
        left = "27.5%"
    },
    {
        name = 'aptPinkacge',
        zone = {
            vector2(289.44326782227, -227.66732788086),
            vector2(304.90069580078, -177.08329772949),
            vector2(360.18206787109, -197.41371154785),
            vector2(345.12228393555, -248.18411254883)
        },
        top = "53%",
        left = "37.5%"
    },
    {
        name = 'aptBeach',
        zone = {
            vector2(-1523.9024658203, -667.70739746094),
            vector2(-1454.4942626953, -617.43481445312),
            vector2(-1428.6826171875, -656.86395263672),
            vector2(-1483.4024658203, -695.81280517578)
        },
        top = "36%",
        left = "35.5%"
    },
    {
        name = 'aptGSF',
        zone = {
            vector2(-175.40788269043, -1763.2866210938),
            vector2(-329.03247070312, -1652.4326171875),
            vector2(-128.34642028809, -1387.8275146484),
            vector2(30.546144485474, -1551.4010009766)
        },
        top = "49%",
        left = "30%"
    },
    {
        name = 'aptGhashange',
        zone = {
            vector2(592.16619873047, -1734.9345703125),
            vector2(576.22344970703, -1807.1760253906),
            vector2(523.81170654297, -1791.8062744141),
            vector2(554.24877929688, -1718.2573242188)
        },
        top = "56%",
        left = "26.5%"
    },
    {
        name = 'aptDavis',
        zone = {
            vector2(347.90347290039, -1797.7266845703),
            vector2(379.47442626953, -1759.5832519531),
            vector2(424.65606689453, -1796.7504882812),
            vector2(384.05743408203, -1833.6474609375)
        },
        top = "57%",
        left = "27.5%"
    },
    {
        name = 'aptCrown',
        zone = {
            vector2(-1292.5260009766, -943.94512939453),
            vector2(-1317.2385253906, -882.53686523438),
            vector2(-1370.1989746094, -919.07165527344),
            vector2(-1356.2183837891, -970.94689941406)
        },
        top = "37%",
        left = "33.5%"
    },
    {
        name = 'aptVagos',
        zone = {
            vector2(365.09027099609, -1934.5091552734),
            vector2(238.08682250977, -2072.7761230469),
            vector2(344.72161865234, -2165.9506835938),
            vector2(467.03729248047, -2025.6282958984)
        },
        top = "53%",
        left = "25.5%"
    }
}

local function beforePlayer()
    DoScreenFadeOut(500)
    SetNuiFocus(false,false)
    SendNUIMessage({
        action = 'close',
        data = nil
    })
    Wait(1000)
end

local function afterPlayer()
    Wait(500)
    DoScreenFadeIn(250)
    TriggerEvent('hud:client:status', true)
end

local function GetAppartmentData(coords)
    for k,v in ipairs(Apartments) do
        if Zones[k]:isPointInside(coords) then
            return {top=v.top,left=v.left}
        end
    end
    return false
end

RegisterNetEvent('qb-spawn:client:choose:spawn', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
		if PlayerData.metadata["injail"] > 0 then
            DoScreenFadeOut(500)
            Wait(2000)
            SetEntityCoords(PlayerPedId(), 1724.755, 2529.161, 45.552)
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
            TriggerEvent('QBCore:Client:OnPlayerLoaded')
            TriggerServerEvent('qb-apartments:server:SetInsideMeta', false)
            Wait(1000)
            FreezeEntityPosition(PlayerPedId(), false)
            TriggerEvent('backitems:displayItems', true)
            TriggerServerEvent('qb-apartments:server:EnterHouse', true)
            afterPlayer()
		else
            QBCore.Functions.TriggerCallback("qb-spawn:server:info", function(apt, weather, time)
                local lc = {}
                if apt.success then
                    local data = GetAppartmentData(apt.coords)
                    if data then
                        lc[1] = {title = 'apartment', image = "building.png", top = data.top, left = data.left}
                    end
                end
                for k,v in pairs(Locations) do
                    lc[#lc + 1] = {title = k, image = v.image, top = v.top, left = v.left}
                end
                SetNuiFocus(true,true)
                SendNUIMessage({
                    action = 'open',
                    data = {cityInfo = {time = time, weather = weather}, locations = lc}
                })
            end)
		end


	end)
end)

RegisterNUICallback('spawn', function (data)
    beforePlayer()
    if data.data == 'last' then
        local PlayerData = QBCore.Functions.GetPlayerData()
        local x = PlayerData.position.x
        local y = PlayerData.position.y
        local z = PlayerData.position.z
        local apt = PlayerData.metadata.inapartment
        local def=Locations['missionrow station']
       
        if apt then
            TriggerServerEvent('qb-apartments:server:EnterHouse')
            TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
            TriggerEvent('QBCore:Client:OnPlayerLoaded')
        else
            if #(vector3( PlayerData.position.x, PlayerData.position.y,PlayerData.position.z)-vector3(-1583.5010986328, 187.53814697266, 63.893245697021))<30 then
                x=def.coords.x
                y=def.coords.y
                z=def.coords.z
            end
            SetEntityCoords(PlayerPedId(), x,y,z)
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
            TriggerEvent('QBCore:Client:OnPlayerLoaded')
            TriggerServerEvent('qb-apartments:server:SetInsideMeta', false)
            Wait(1000)
            FreezeEntityPosition(PlayerPedId(), false)
            TriggerEvent('backitems:displayItems', true)
            TriggerServerEvent('qb-apartments:server:EnterHouse', true)
            afterPlayer()
        end
  
     if not (PlayerData.metadata['isdead'] or PlayerData.metadata['inlaststand'] or PlayerData.metadata['ishandcuffed']) then
        local dict = "anim@scripted@heist@ig25_beach@male@"
        RequestAnimDict(dict)
        repeat Wait(0) until HasAnimDictLoaded(dict)
        local ped = PlayerPedId()
        local playerPos = GetEntityCoords(ped)
        local playerHead = GetEntityHeading(ped)
        local scene = NetworkCreateSynchronisedScene(playerPos.x, playerPos.y, playerPos.z-0.87, 0.0, 0.0, playerHead, 4, false, false, 8.0, 1000.0, 1.0)
        NetworkAddPedToSynchronisedScene(ped, scene, dict, "action", 1000.0, 8.0, 0, 0, 1000.0, 8192)
        NetworkAddSynchronisedSceneCamera(scene, dict, "action_camera")
        NetworkStartSynchronisedScene(scene)
     end



    elseif data.data == 'apartment' then
        TriggerServerEvent('qb-apartments:server:EnterHouse')
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
        FreezeEntityPosition(PlayerPedId(), false)
    else
        local coords = Locations[data.data].coords
        SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z)
        SetEntityHeading(PlayerPedId(), coords.w)
        FreezeEntityPosition(PlayerPedId(), true)
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
        TriggerServerEvent('qb-apartments:server:SetInsideMeta', false)
        Wait(1000)
        FreezeEntityPosition(PlayerPedId(), false)
        TriggerEvent('backitems:displayItems', true)
        TriggerServerEvent('qb-apartments:server:EnterHouse', true)
        afterPlayer()
    end
    SetEntityVisible(PlayerPedId(), true)
end)

CreateThread(function()
    for k,v in ipairs(Apartments) do
        Zones[k] = PolyZone:Create(v.zone, {
            name = v.name,
            minZ = -1000,
            maxZ = 1000,
            debugPoly = false
        })
    end
end)