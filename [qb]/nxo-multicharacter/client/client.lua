-- if Config.Framework == "esx" then
--     ESX = exports["es_extended"]:getSharedObject()
-- elseif Config.Framework == "qb" then
-- 	QBCore = exports["qb-core"]:GetCoreObject()
-- end

PlayerCharacters = {}
local spawnedPed = nil
local playerSkinData = {}
local cam = nil
local pedCamera = nil
local lastLocation = nil
local spawnCamera =  nil
local camZPlus1 = 1500
local camZPlus2 = 50
local pointCamCoords = 75
local pointCamCoords2 = 0
local cam1Time = 500
local cam2Time = 1000
local choosingSpawn = false
local Houses = {}
local cam2 = nil
local pedid
CreateThread(function()
    pedid=math.random(1,#Config.pedcoord)
    Wait(1000)
    SendNUIMessage({
        action = "loadLocale",
        data = Locales,
    })
    while true do
        Wait(0)
        if NetworkIsSessionStarted() then
            TriggerServerEvent("player:join")
            return
        end
    end
end)
local Refresh=false
RegisterCommand('reloadchar', function()
    if not Refresh then
        TriggerServerEvent('player:join')
    else
        QBCore.Functions.Notify('You Cant use That', 'error')
    end
end)

local function SetCam(campos)
   
    if not campos.z then campos = json.decode(campos) end
    SetEntityCoords(PlayerPedId(), campos.x, campos.y, campos.z)
    cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", campos.x, campos.y, campos.z + camZPlus1, 300.00,0.00,0.00, 110.00, false, 0)
    PointCamAtCoord(cam2, campos.x, campos.y, campos.z + pointCamCoords)
    SetCamActiveWithInterp(cam2, cam, cam1Time, true, true)
    if DoesCamExist(cam) then
        DestroyCam(cam, true)""
    end
    Wait(cam1Time)

    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", campos.x, campos.y, campos.z + camZPlus2, 300.00,0.00,0.00, 110.00, false, 0)
    PointCamAtCoord(cam, campos.x, campos.y, campos.z + pointCamCoords2)
    SetCamActiveWithInterp(cam, cam2, cam2Time, true, true)

end

local function TriggerCallback(name, ...)
    local id = GetRandomIntInRange(0, 999999)
    local eventName = "0r-multichar:triggerCallback:" .. id
    local eventHandler
    local promise = promise:new()
    RegisterNetEvent(eventName)
    local eventHandler = AddEventHandler(eventName, function(...)
        promise:resolve(...)
    end)
    SetTimeout(15000, function()
        promise:resolve("timeout")
        RemoveEventHandler(eventHandler)
    end)
    local args = { ... }
    TriggerServerEvent(name, id, args)
    local result = Citizen.Await(promise)
    RemoveEventHandler(eventHandler)
    return result
end
local skin = {}

ApplySkinToPed = function(ped,skn)
	-- if Config.skin == 'skinchanger' then
	-- 	TriggerEvent('skinchanger:loadSkin', skn)
	-- elseif Config.skin == 'fivem-appearance' then
	-- 	exports['fivem-appearance']:setPedAppearance(ped, skn)
	-- elseif Config.skin == 'illenium-appearance' then
	-- 	exports['illenium-appearance']:setPedAppearance(ped, skn)
	-- elseif Config.skin == 'qb-clothing' then
		TriggerEvent('qb-clothing:client:loadPlayerClothing', skn, ped)
	-- end
end

RegisterNUICallback('setCam', function(data, cb)
    local location = data.location
    local type = data.type
    DoScreenFadeOut(200)
    Wait(500)
    DoScreenFadeIn(200)
    if DoesCamExist(cam) then DestroyCam(cam, true) end
    if DoesCamExist(cam2) then DestroyCam(cam2, true) end
    if type == "current" then
        if Config.Framework == "qb" then

        -- QBCore.Functions.GetPlayerData(function(PlayerData)
        --     SetCam(PlayerData.position)
        -- end)
        for k,v in pairs(Config.SpawnLocations) do
            if v.lastLoc then
                SetCam(v.coords)
                break
            end
        end
    else
        -- local playerData = ESX.GetPlayerData()
        -- SetCam(playerData.coords)
        for k,v in pairs(Config.SpawnLocations) do
            if v.lastLoc then
                SetCam(v.coords)
                break
            end
        end
        -- get last location coord in startup

    end
    elseif type == "house" then
        SetCam(Houses[location].coords.enter)
    elseif type == "location" then
        -- -- -- -- print(99, location)
        SetCam(Config.SpawnLocations[location].coords)
    elseif type == "appartement" then
        SetCam(Apartments.Locations[location].coords.enter)
    end
    cb('ok')
end)


local function PreSpawnPlayer()
    -- SetDisplay(false)
    DoScreenFadeOut(500)
    Wait(2000)
end

local function PostSpawnPlayer(ped)
    FreezeEntityPosition(ped, false)
    RenderScriptCams(false, true, 500, true, true)
    SetCamActive(cam, false)
    DestroyCam(cam, true)
    SetCamActive(cam2, false)
    DestroyCam(cam2, true)
    SetEntityVisible(PlayerPedId(), true)
    Wait(500)
    DoScreenFadeIn(250)
end

RegisterNetEvent('spawnplayer', function(data)
    local location = tostring(data.spawnloc)
    local type = tostring(data.type)
    local ped = PlayerPedId()
    local PlayerData = QBCore.Functions.GetPlayerData()
    local insideMeta = PlayerData.metadata["inside"]
    if type == "current" then
        PreSpawnPlayer()
        QBCore.Functions.GetPlayerData(function(pd)
            ped = PlayerPedId()
            SetEntityCoords(ped, pd.position.x, pd.position.y, pd.position.z)
            SetEntityHeading(ped, pd.position.a)
            FreezeEntityPosition(ped, false)
        end)

        if insideMeta.house ~= nil then
            local houseId = insideMeta.house
            TriggerEvent('qb-houses:client:LastLocationHouse', houseId)
        elseif insideMeta.apartment.apartmentType ~= nil or insideMeta.apartment.apartmentId ~= nil then
            local apartmentType = insideMeta.apartment.apartmentType
            local apartmentId = insideMeta.apartment.apartmentId
            TriggerEvent('qb-apartments:client:LastLocationHouse', apartmentType, apartmentId)
        end
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
        PostSpawnPlayer()
    elseif type == "house" then
        PreSpawnPlayer()
        TriggerEvent('qb-houses:client:enterOwnedHouse', location)
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
        TriggerServerEvent('qb-houses:server:SetInsideMeta', 0, false)
        TriggerServerEvent('qb-apartments:server:SetInsideMeta', 0, 0, false)
        PostSpawnPlayer()
    elseif type == "normal" then
        local pos = QB.Spawns[location].coords
        PreSpawnPlayer()
        SetEntityCoords(ped, pos.x, pos.y, pos.z)
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
        TriggerServerEvent('qb-houses:server:SetInsideMeta', 0, false)
        TriggerServerEvent('qb-apartments:server:SetInsideMeta', 0, 0, false)
        Wait(500)
        SetEntityCoords(ped, pos.x, pos.y, pos.z)
        SetEntityHeading(ped, pos.w)
        PostSpawnPlayer()
    end
end)


finished = false

SkinMenu = function()
    local bucketId = math.random(1, 9999)
	if Config.skin == 'skinchanger' then
		TriggerEvent('skinchanger:loadSkin', skin, function()
			local playerPed = PlayerPedId()
			SetPedAoBlobRendering(playerPed, true)
			ResetEntityAlpha(playerPed)
			SetEntityVisible(playerPed,true)
			if Config.SkinMenu[Config.skin].event then
				TriggerEvent(Config.SkinMenu[Config.skin].event)
			elseif Config.SkinMenu[Config.skin].exports then
				Config.SkinMenu[Config.skin].exports()
			end
		end)
	elseif Config.skin == 'fivem-appearance' then
		local config = Config.fivemappearanceConfig
		local playerPed = PlayerPedId()
		SetPedAoBlobRendering(playerPed, true)
		ResetEntityAlpha(playerPed)
		SetEntityVisible(playerPed, true)
        TriggerServerEvent("setplayerbucket", bucketId)
		exports['fivem-appearance']:startPlayerCustomization(function (appearance)
			if (appearance) then
				TriggerServerEvent('0r-multicharacter:saveappearance', appearance)
                finished = true
  
            else 
				local appearance = exports['fivem-appearance']:getPedAppearance(playerPed)
				TriggerServerEvent('0r-multicharacter:saveappearance', appearance)
				finished = true
			end
            TriggerServerEvent("setplayerbucket", 0)
		end, config)
	elseif Config.skin == 'illenium-appearance' then
        -- -- print("illenium started")
		local config = Config.fivemappearanceConfig
		local playerPed = PlayerPedId()
		SetPedAoBlobRendering(playerPed, true)
		ResetEntityAlpha(playerPed)
		SetEntityVisible(playerPed, true)
        TriggerServerEvent("setplayerbucket", bucketId)
		exports['illenium-appearance']:startPlayerCustomization(function (appearance)
            -- -- print("illenium started2")
            -- -- -- print("illenium funct okk")
			if (appearance) then
                TriggerServerEvent('0r-multicharacter:saveappearance', appearance)
				finished = true
                -- -- print("finish")
			else -- if they cancel, so this will avoid player being invisible. because they dont have a skin and model saved in database.
				-- --  print("cancel")
                local appearance = exports['illenium-appearance']:getPedAppearance(playerPed)
                TriggerServerEvent('0r-multicharacter:saveappearance', appearance)
				finished = true
               
			end
            TriggerServerEvent("setplayerbucket", 0)
		end, config)
	elseif Config.skin == 'qb-clothing' then
		if Config.SkinMenu[Config.skin].event then
			TriggerEvent(Config.SkinMenu[Config.skin].event)
		elseif Config.SkinMenu[Config.skin].exports then
			Config.SkinMenu[Config.skin].exports()
		end
	end
end

LoadSkin = function(skin)
	-- if Config.skin == 'skinchanger' then
	-- 	TriggerEvent('skinchanger:loadSkin', skin)
	-- elseif Config.skin == 'fivem-appearance' then
	-- 	exports['fivem-appearance']:setPlayerAppearance(skin)
	-- elseif Config.skin == 'illenium-appearance' then
	-- 	exports['illenium-appearance']:setPlayerAppearance(skin)
	-- elseif Config.skin == 'qb-clothing' then
		TriggerEvent('qb-clothing:client:loadPlayerClothing', skin, PlayerPedId())
	-- end
end

GetModel = function(str,othermodel)
	if Config.skin == 'skinchanger' then
		skin = Config.Default[Config.skin][str or 'm']
		skin.sex = str == "m" and 0 or 1
		local model = skin.sex == 0 and `mp_m_freemode_01` or `mp_f_freemode_01`
		return model
	elseif Config.skin == 'fivem-appearance' then
		skin.sex = str == "m" and 0 or 1
		local model = othermodel or skin.sex == 0 and `mp_m_freemode_01` or `mp_f_freemode_01`
		return model
	elseif Config.skin == 'illenium-appearance' then
		skin.sex = str == "m" and 0 or 1
		local model = othermodel or skin.sex == 0 and `mp_m_freemode_01` or `mp_f_freemode_01`
		return model
	elseif Config.skin == 'qb-clothing' then
		local model = othermodel or str == 'm' and `mp_m_freemode_01` or `mp_f_freemode_01`
		return model
	end
end

SetSkin = function(ped,skn)
	-- if Config.skin == 'skinchanger' then
	-- 	TriggerEvent('skinchanger:loadSkin', skn)
	-- elseif Config.skin == 'fivem-appearance' then
	-- 	exports['fivem-appearance']:setPedAppearance(PlayerPedId(), skn)
	-- elseif Config.skin == 'illenium-appearance' then
	-- 	exports['illenium-appearance']:setPedAppearance(PlayerPedId(), skn)
	-- elseif Config.skin == 'qb-clothing' then
		TriggerEvent('qb-clothing:client:loadPlayerClothing', skn, PlayerPedId())
	-- end
end

SetModel = function(model)
	RequestModel(model)
	while not HasModelLoaded(model) do Wait(0) end
	SetPlayerModel(PlayerId(), model)
	SetModelAsNoLongerNeeded(model)
end


RegisterNetEvent('esx:playerLoaded', function(playerData, isNew, skin)
	loaded = true
	local spawn = playerData.coords
	skin = skin
	logout = false
	if not isNew then
		if string.find(tostring(playerData.sex):lower(), 'mal') then playerData.sex ='m' elseif string.find(tostring(playerData.sex):lower(),'fem') then playerData.sex = 'f' end -- supports other identity logic
		-- print("not is new")
        skin.sex = playerData.sex == "m" and 0 or 1
	end
	if isNew or not skin or #skin == 1 then
        playerData.sex = 0 and "m" or "f"
		finished = false
		local model = GetModel(playerData.sex or 'm')
		SetModel(model)
		skin = Config.Default[Config.skin][playerData.sex or 'm']
		skin.sex = playerData.sex == 'm' and 0 or 1
		SetSkin(PlayerPedId(), skin)
		SkinMenu()
		Wait(100)
		--repeat Wait(200) until finished
	end

	if not isNew then LoadSkin() end
	Wait(400)
	repeat Wait(200) until not IsScreenFadedOut()
	TriggerServerEvent('esx:onPlayerSpawn')
	TriggerEvent('esx:onPlayerSpawn')
	TriggerEvent('playerSpawned')
	TriggerEvent('esx:restoreLoadout')
	FreezeEntityPosition(PlayerPedId(),false)
	ClearPedTasks(PlayerPedId())
	stateactive = false
end)



-- RegisterNetEvent('qb-spawn:client:openUI', function()
--     QBCore.Functions.GetPlayerData(function(PlayerData)
--         lastLocation = PlayerData.position
--     end)
-- end)

local function setUPCharUI(bool)
    NetworkOverrideClockTime(22, 30, 0)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = (bool and "showCHARNUI" or "hideUI"),
        delchar = Config.CanDeleteCharacters,
        playerCharacters = PlayerCharacters,
        configData = Config
    })
    Wait(2000)
    DoScreenFadeIn(1000)
end



RegisterCommand("openspawn", function()
    TriggerEvent('qb-spawn:client:setupSpawns',{citizenid=0},false)
Wait(2000)
    setUPSpawnUI(true)
end, false)

local function loadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
end


local function setPedCamera(ped)
    if ped then
        if pedCamera then -- Kamera zaten varsa, önce mevcut kamerayı kapatıp yok edin.
            SetCamActive(pedCamera, false)
            DestroyCam(pedCamera, true)
            RenderScriptCams(0, 1, 1000, 1, 1)
        end
        local offset = GetOffsetFromEntityInWorldCoords(ped, -1.0, 4.0, 1.0) -- Kamerayı yükseltmek için z koordinatını artırın.
        pedCamera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        SetCamCoord(pedCamera, Config.pedcoord[pedid].hidden.x, Config.pedcoord[pedid].hidden.y, Config.pedcoord[pedid].hidden.z)
        PointCamAtEntity(pedCamera, ped, 0.0, 0.0, 0.6, true)
        RenderScriptCams(1, 1, 1000, 1, 1)
        SetCamFov(pedCamera, 25.0)
    else
        if pedCamera then -- Eğer pedCamera tanımlıysa, kamerayı kapatıp yok edin.
            SetCamActive(pedCamera, false)
            DestroyCam(pedCamera, true)
            RenderScriptCams(0, 1, 1000, 1, 1)
            pedCamera = nil
        end
    end
end


local function initializePedModel(model, data)

 
        if not model then
            model = Config.RandomPeds[math.random(#Config.RandomPeds)]
        end
        loadModel(model)
      if spawnedPed then
        DeleteEntity(spawnedPed)
        spawnedPed=nil
      end
        spawnedPed = CreatePed(2, model, Config.pedcoord[pedid].ped.x, Config.pedcoord[pedid].ped.y, Config.pedcoord[pedid].ped.z ,
        Config.pedcoord[pedid].ped.w, false, false)
        Wait(100)
        -- SetPedComponentVariation(spawnedPed, 0, 0, 0, 2)
       
        FreezeEntityPosition(spawnedPed, false)
        SetEntityInvincible(spawnedPed, true)
        PlaceObjectOnGroundProperly(spawnedPed)
        SetBlockingOfNonTemporaryEvents(spawnedPed, true)

        -- randompedanimations
        local anim = Config.randomPedAnimations[math.random(#Config.randomPedAnimations)]
        -- -- -- -- print(22, "anim", anim.anim)
        if anim.type == "sceneario" then
            TaskStartScenarioInPlace(spawnedPed, anim.anim, 0, true)
        else
            local tryCount = 10
            RequestAnimDict(anim.anim)
            while not HasAnimDictLoaded(anim.anim) do
                -- -- -- -- print("not loaded", anim.anim)
                tryCount = tryCount - 1
                if tryCount == 0 then
                    break
                end
                Wait(100)
            end
            TaskPlayAnim(spawnedPed, anim.anim, anim.dict, 8.0, 8.0, -1, 1, 0, false, false, false)
        end
        -- if data then
            -- ApplySkinToPed(spawnedPed, data)
            TriggerEvent('qb-clothing:client:loadPlayerClothing', data, spawnedPed)
        -- end
        setPedCamera(spawnedPed)
        Wait(500)
        DoScreenFadeIn(1000)
   
end

RegisterNetEvent('esx:onPlayerLogout', function()
	DoScreenFadeOut(500)
	Wait(1000)
	TriggerEvent('esx_skin:resetFirstSpawn')
end)



RegisterNUICallback("DeleteCharacter", function(data, cb)
    local cData = data
    TriggerServerEvent('0r-multicharacter:server:deleteCharacter', cData)
    --delete ped and make mission entity
    SetEntityAsMissionEntity(spawnedPed, false)
    DeleteEntity(spawnedPed)
    cb("ok")
end)

RegisterNetEvent("0r-multicharacter:client:setChars")
AddEventHandler("0r-multicharacter:client:setChars", function(plyChars, slots)
    PlayerCharacters = {}
    if Config.Framework == "esx" then
        ESX.PlayerLoaded = false
		ESX.PlayerData = {}
    end
    PlayerCharacters = plyChars
    -- for k = #Config.LockedSlots, 1, -1 do
    --     local v = Config.LockedSlots[k]
    --     for i, j in pairs(slots) do
    --         v = tonumber(v)
    --         j = tonumber(j)
    --         if v == j then
    --             table.remove(Config.LockedSlots, k)
    --         end
    --     end
    -- end
   
    SetNuiFocus(false, false)
    DoScreenFadeOut(10)
    Wait(1000)
    FreezeEntityPosition(PlayerPedId(), true)
    SetEntityVisible(PlayerPedId(), false)
    SetEntityCoords(PlayerPedId(), Config.pedcoord[pedid].hidden.x, Config.pedcoord[pedid].hidden.y, Config.pedcoord[pedid].hidden.z)
    Wait(1500)
    ShutdownLoadingScreen()
    ShutdownLoadingScreenNui()
    setUPCharUI(true)
end)

RegisterNetEvent('0r-multicharacter:client:closeNUI', function()
    DeleteEntity(spawnedPed)
    SetNuiFocus(false, false)
end)


RegisterNetEvent('0r-multicharacter:client:closeNUIdefault', function() -- This event is only for no starting apartments
    DeleteEntity(spawnedPed)
    SetNuiFocus(false, false)
    DoScreenFadeOut(500)
    Wait(2000)
    SetEntityCoords(PlayerPedId(), Config.DefaultSpawn.x, Config.DefaultSpawn.y, Config.DefaultSpawn.z)
    if Config.Framework == "qb" then
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
        TriggerServerEvent('qb-houses:server:SetInsideMeta', 0, false)
        TriggerServerEvent('qb-apartments:server:SetInsideMeta', 0, 0, false)
    end
    Wait(500)
    SetEntityVisible(PlayerPedId(), true)
    Wait(500)
    DoScreenFadeIn(250)
    TriggerEvent('qb-weathersync:client:EnableSync')
    TriggerEvent('qb-clothes:client:CreateFirstCharacter')
end)

-- RegisterNetEvent('0r-multicharacter:client:openSpawnSelector', function(data, isNew)
--     local playerhouses = {}
--     if Config.Framework == "qb" then
--         if isNew then
--             setUPSpawnUI(true, nil, )
--         end
--         QBCore.Functions.TriggerCallback('qb-spawn:server:getOwnedHouses', function(houses)
--             if houses ~= nil then
--                 for i = 1, (#houses), 1 do
--                     playerhouses[#playerhouses + 1] = {
--                         house = houses[i].house,
--                         label = Houses[houses[i].house].adress,
--                     }
--                 end
--             end
--         end, data.citizenid)
--         setUPSpawnUI(true, playerhouses)
--     else
--         setUPSpawnUI(true, {})
--     end
--     Wait(500)

-- end)

RegisterNUICallback("SpawnPed", function(data, cb)
    setUPCharUI(false)
    local ped = PlayerPedId()
    SetEntityAsMissionEntity(spawnedPed, true, true)
    DeleteEntity(spawnedPed)
    
    if data.type == "appartement" then
        
        local appaYeet = data.location
        -- -- SetDisplay(false)
        DoScreenFadeOut(500)
        Wait(5000)
        TriggerServerEvent("apartments:server:CreateApartment", appaYeet, Apartments.Locations[appaYeet].label)
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
        FreezeEntityPosition(ped, false)
        RenderScriptCams(false, true, 500, true, true)
        SetCamActive(cam, false)
        DestroyCam(cam, true)
        SetCamActive(cam2, false)
        DestroyCam(cam2, true)
        SetEntityVisible(ped, true)
        cb('ok')
    elseif data.type == "current" or data.type == nil then
        if Config.Framework == "esx" then
            PreSpawnPlayer()
            local pd = ESX.GetPlayerData()
            -- -- -- -- print(json.encode(pd, {indent = true}))
            ped = PlayerPedId()
            -- -- -- -- print(json.encode(pd.coords))
            SetEntityCoords(ped, pd.coords.x, pd.coords.y, pd.coords.z)
            SetEntityHeading(ped, 100.00)
            FreezeEntityPosition(ped, false)
            DoScreenFadeIn(500)
            PostSpawnPlayer()
            for k,v in pairs(Config.SpawnLocations) do
                if v.lastLoc then
                -- -- --   --  print("lastloc found")
                    --remove lastloc index from table
                    table.remove(Config.SpawnLocations, k)
                    break
                end
            end
            return
        end
        local PlayerData = QBCore.Functions.GetPlayerData()
        local insideMeta = PlayerData.metadata["inside"]
        PreSpawnPlayer()
        QBCore.Functions.GetPlayerData(function(pd)
            ped = PlayerPedId()
            SetEntityCoords(ped, pd.position.x, pd.position.y, pd.position.z)
            SetEntityHeading(ped, pd.position.a)
            FreezeEntityPosition(ped, false)
        end)

        if insideMeta.house ~= nil then
            local houseId = insideMeta.house
            TriggerEvent('qb-houses:client:LastLocationHouse', houseId)
        elseif insideMeta.apartment.apartmentType ~= nil or insideMeta.apartment.apartmentId ~= nil then
            local apartmentType = insideMeta.apartment.apartmentType
            local apartmentId = insideMeta.apartment.apartmentId
            TriggerEvent('qb-apartments:client:LastLocationHouse', apartmentType, apartmentId)
        end
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
        PostSpawnPlayer()
    elseif data.type == "house" then
        PreSpawnPlayer()
        TriggerEvent('qb-houses:client:enterOwnedHouse', location)
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
        TriggerServerEvent('qb-houses:server:SetInsideMeta', 0, false)
        TriggerServerEvent('qb-apartments:server:SetInsideMeta', 0, 0, false)
    elseif data.type == "location" then
        local pos = Config.SpawnLocations[data.location].coords
        PreSpawnPlayer()
        SetEntityCoords(ped, pos.x, pos.y, pos.z)
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
        TriggerServerEvent('qb-houses:server:SetInsideMeta', 0, false)
        TriggerServerEvent('qb-apartments:server:SetInsideMeta', 0, 0, false)
        Wait(500)
        SetEntityCoords(ped, pos.x, pos.y, pos.z)
        SetEntityHeading(ped, pos.w)
        PostSpawnPlayer()
    end
    DestroyCam(spawnCamera, false)
    RenderScriptCams(false, true, 1000, false, false)
    FreezeEntityPosition(PlayerPedId(), false)
    SetEntityVisible(PlayerPedId(), true)
    SetEntityCollision(PlayerPedId(), true, true)
    NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
    SetEveryoneIgnorePlayer(PlayerPedId(), false)
    SetNuiFocus(false, false)
    -- -- -- --print("lastloc removed")
    for k,v in pairs(Config.SpawnLocations) do
        if v.lastLoc then
        -- -- --   --  print("lastloc found")
            --remove lastloc index from table
            table.remove(Config.SpawnLocations, k)
            break
        end
    end
    cb("ok")
end)


RegisterNUICallback("CreateCharacter", function(data, cb)
    local cData = data
    DoScreenFadeOut(150)
    if cData.gender == "male" then
        cData.gender = 0
    elseif cData.gender == "female" then
        cData.gender = 1
    end
    setPedCamera(nil)
    TriggerServerEvent('0resmon-multicharacter:createCharacter', cData,false)
    -- if not Config.UseSpawnSelector then
    local spawnCoords = lastLocation ~= nil and lastLocation or Config.DefaultSpawn
    setUPCharUI(false)
    SetEntityAsMissionEntity(spawnedPed, true, true)
    DeleteEntity(spawnedPed)
    SetEntityCoords(PlayerPedId(), spawnCoords.x, spawnCoords.y, spawnCoords.z - 0.9)
    SetEntityHeading(PlayerPedId(), spawnCoords.w)
    FreezeEntityPosition(PlayerPedId(), false)
    SetEntityVisible(PlayerPedId(), true)
    SetEntityCollision(PlayerPedId(), true, true)
    NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
    SetEveryoneIgnorePlayer(PlayerPedId(), false)

        -- TriggerEvent("skinchanger:loadSkin", Config.DefaultSkin[tonumber(cData.gender)])
    -- end
    
    cb("ok")
end)

RegisterNetEvent("0r-multicharacter:esx:setPlayerData", function(data)
    Wait(100)
    ESX.SetPlayerData("name", ("%s %s"):format(data.firstame, data.lastname))
    ESX.SetPlayerData("firstName", data.firstname)
    ESX.SetPlayerData("lastName", data.lastname)
    ESX.SetPlayerData("dateofbirth", data.birthdate)
    ESX.SetPlayerData("sex", data.gender)
    ESX.SetPlayerData("height", data.height)
end)

RegisterNUICallback("PlayGame", function(data, cb)
    local cData = data.data
    -- DoScreenFadeOut(10)
    -- TriggerServerEvent('0r-multicharacter:server:loadUserData', cData)

    -- setPedCamera(nil)
    -- SetEntityAsMissionEntity(spawnedPed, true, true)
    -- DeleteEntity(spawnedPed)
    -- SetEntityVisible(PlayerPedId(), true)
    -- -- if not Config.UseSpawnSelector then
    --     local spawnCoords = lastLocation ~= nil and lastLocation or Config.DefaultSpawn
    --     SetEntityCoords(PlayerPedId(), spawnCoords.x, spawnCoords.y, spawnCoords.z - 0.9)
    --     SetEntityHeading(PlayerPedId(), spawnCoords.w)
    --     FreezeEntityPosition(PlayerPedId(), false)
    --     SetEntityVisible(PlayerPedId(), true)
    --     SetEntityCollision(PlayerPedId(), true, true)
    --     NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
    --     SetEveryoneIgnorePlayer(PlayerPedId(), false)
    --     SetNuiFocus(false, false)
    -- -- end
    -- cb("ok")
   
    DoScreenFadeOut(10)
    
    QBCore.Functions.TriggerCallback('nxo-multicharacter:server:getSkin', function(model, skin)
        if model ~= nil then
            TriggerServerEvent('nxo-multicharacter:server:loadUserData', cData)
        else
            TriggerServerEvent('0resmon-multicharacter:createCharacter', cData, true)
        end
    end, cData.citizenid)
    Refresh = true
    SetNuiFocus(false, false)
    setPedCamera(false)
    DeleteEntity(spawnedPed)
    cb("ok")
end)


RegisterNUICallback("CheckCode", function(data, cb)
    local code = data.code
    local retval = nil
    -- make with promise
    if Config.Framework == "esx" then
        ESX.TriggerServerCallback("0r-multicharacter:server:checkCode", function(result)
            retval = result
        end, { code, data.cid })
    elseif Config.Framework == "qb" then
        QBCore.Functions.TriggerCallback("0r-multicharacter:server:checkCode", function(result)
            retval = result
        end, { code, data.cid })
    end
    while retval == nil do
        Wait(500)
    end
    cb(retval)
end)


RegisterNUICallback("ChangeGender", function(data, cb)
    local gender = data.gender
    if spawnedPed ~= nil then
        local pedCoords = GetEntityCoords(spawnedPed)
        local pedHeading = GetEntityHeading(spawnedPed)
        SetEntityAsMissionEntity(spawnedPed, true, true)
        DeleteEntity(spawnedPed)

        local model = gender == "female" and ("mp_f_freemode_01") or ("mp_m_freemode_01")
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(1)
        end

        spawnedPed = CreatePed(2, model, pedCoords.x, pedCoords.y, pedCoords.z-0.98, pedHeading, false, true)
        SetModelAsNoLongerNeeded(model)
        setPedCamera(spawnedPed)

    end
    cb(true)
end)

RegisterNUICallback("SetPedAction", function(data, cb)
    -- -- -- -- print(614, json.encode(data))
    
    local currentCharData = data.data
    if spawnedPed ~= nil then
        DoScreenFadeOut(500)
        Wait(500)
        SetEntityAsMissionEntity(spawnedPed, true, true)
        DeleteEntity(spawnedPed)
    end
    if (currentCharData ~= nil) then
        -- -- -- -- print(currentCharData.citizenid)
        if not (playerSkinData[currentCharData.citizenid]) then
            local waitLoading=true

                local resolved_model 
            local resolved_data 
            print(currentCharData.citizenid)
                -- -- -- -- print("triggertst")
                QBCore.Functions.TriggerCallback("0r-multicharacter:server:getSkin", function(model, data)
                    resolved_model =(model)
                    resolved_data =(data)
                    waitLoading=false
                    -- -- -- -- print(model, data, "sadasd")
                end, currentCharData.citizenid)
                -- -- -- -- print("trigger success")
           
            while waitLoading do
                Wait(100)
            end
            
            playerSkinData[currentCharData.citizenid] = { model = resolved_model, data = resolved_data }
        end
        local model = playerSkinData[currentCharData.citizenid].model
        local data = playerSkinData[currentCharData.citizenid].data
        -- -- -- -- print(model, data)
       

        if model ~= nil then
            -- -- -- -- print(22, "model", model)
            initializePedModel(model, data)
        else
            initializePedModel()
        end
        cb("ok")
    else
        initializePedModel()
        cb("ok")
    end
end)


RegisterNetEvent('0r-multicharacter:client:spawnLastLocation', function(coords, cData)
    if Config.Framework == "esx" then
        local ped = PlayerPedId()
        SetEntityCoords(ped, coords.x, coords.y, coords.z)
        SetEntityHeading(ped, coords.w)
        FreezeEntityPosition(ped, false)
        SetEntityVisible(ped, true)
        DoScreenFadeOut(500)
        SetEntityCoords(ped, coords.x, coords.y, coords.z)
        SetEntityHeading(ped, coords.w)
        FreezeEntityPosition(ped, false)
        SetEntityVisible(ped, true)
        Wait(2000)
        DoScreenFadeIn(250)
        return
    else
        QBCore.Functions.TriggerCallback('apartments:GetOwnedApartment', function(result)
            if result then
                TriggerEvent("apartments:client:SetHomeBlip", result.type)
                local ped = PlayerPedId()
                SetEntityCoords(ped, coords.x, coords.y, coords.z)
                SetEntityHeading(ped, coords.w)
                FreezeEntityPosition(ped, false)
                SetEntityVisible(ped, true)
                local PlayerData = QBCore.Functions.GetPlayerData()
                local insideMeta = PlayerData.metadata["inside"]
                DoScreenFadeOut(500)
    
                if insideMeta.house then
                    TriggerEvent('qb-houses:client:LastLocationHouse', insideMeta.house)
                elseif insideMeta.apartment.apartmentType and insideMeta.apartment.apartmentId then
                    TriggerEvent('qb-apartments:client:LastLocationHouse', insideMeta.apartment.apartmentType, insideMeta.apartment.apartmentId)
                else
                    SetEntityCoords(ped, coords.x, coords.y, coords.z)
                    SetEntityHeading(ped, coords.w)
                    FreezeEntityPosition(ped, false)
                    SetEntityVisible(ped, true)
                end
    
                TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
                TriggerEvent('QBCore:Client:OnPlayerLoaded')
                Wait(2000)
                DoScreenFadeIn(250)
            end
        end, cData.citizenid)
    end
   
end)

 function setUPSpawnUI(bool, lastLoc)
    if lastLoc then 
        Config.SpawnLocations[#Config.SpawnLocations + 1] = {
            title = "Last Location",
            description = "Last location lorem ipsum simply dummy text.",
            coords = lastLoc,
            lastLoc = true
        }
        -- table.insert(Config.SpawnLocations, {
        --     title = "Last Location",
        --     description = "Last location lorem ipsum simply dummy text.",
        --     coords = lastLoc,
        --     lastLoc = true
        -- })
    end
    local ped = PlayerPedId()
    SetEntityVisible(ped, false)
    -- RenderScriptCams(false, false, 0, true, false)
    DestroyCam(spawnCamera, false)
    local coords = Config.SpawnLocations[1].coords
    
    local camX, camY, camZ = coords.x, coords.y, coords.z + 100
    spawnCamera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

    SetCamCoord(spawnCamera, camX, camY, camZ)
 
    PointCamAtCoord(spawnCamera, coords.x, coords.y, coords.z)
    RenderScriptCams(true, false, 1500, true, false)
    SetEntityCoords(ped, coords.x, coords.y, coords.z - 0.98)
    SendNUIMessage({
        action = (bool and "openSPAWNUI" or "hideUI"),
    })
    DoScreenFadeIn(1000)
    SetNuiFocus(bool, bool)
end



    RegisterNetEvent('qb-spawn:client:openUI', function(value, lastLoc)
        setUPSpawnUI(value, lastLoc)
    end)


    RegisterNetEvent('qb-spawn:client:setupSpawns', function(cData, new, apps)
        print("ok222")
        if not new then
            if Config.Framework == "qb"then
                QBCore.Functions.TriggerCallback('qb-spawn:server:getOwnedHouses', function(houses)
                    print("ok")
                    local myHouses = {}
                    if houses ~= nil then
                        for i = 1, (#houses), 1 do
                            myHouses[#myHouses+1] = {
                                house = houses[i].house,
                                label = Houses[houses[i].house].adress,
                            }
                        end
                    end
              
                    Wait(500)
                    print( Config.SpawnLocations)
                    SendNUIMessage({
                        action = "setupLocations",
                        locations = Config.SpawnLocations,
                        houses = myHouses,
                        isNew = new
                    })
                end, cData.citizenid)
            else
                SendNUIMessage({
                    action = "setupLocations",
                    locations = Config.SpawnLocations,
                    houses = {},
                    isNew = false
                })
            end
        elseif new then
            print("ok1")
            SendNUIMessage({
                action = "setupAppartements",
                locations = apps,
                isNew = new
            })
        end
    end)



RegisterNetEvent("nxo-multicharacter:client:loadsitecharacter")
AddEventHandler("nxo-multicharacter:client:loadsitecharacter", function(data)
    SendNUIMessage({
        action = "sitedata",
        char = data,
    })
end)


-- RegisterNetEvent("apartments:client:setupSpawnUI")
-- AddEventHandler("apartments:client:setupSpawnUI", function(cData)
--     QBCore.Functions.TriggerCallback('apartments:GetOwnedApartment', function(result)
--         if result then
--             TriggerEvent('qb-spawn:client:setupSpawns', cData, false, nil)
--             TriggerEvent('qb-spawn:client:openUI', true)
--             TriggerEvent("apartments:client:SetHomeBlip", result.type)
--         else
--             if Apartments.Starting then
--                 TriggerEvent('qb-spawn:client:setupSpawns', cData, true, Apartments.Locations)
--                 TriggerEvent('qb-spawn:client:openUI', true)
--             else
--                 TriggerEvent('qb-spawn:client:setupSpawns', cData, false, nil)
--                 TriggerEvent('qb-spawn:client:openUI', true)
--             end
--         end
--     end, cData.citizenid)

-- end)