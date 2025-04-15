-- Variables
local PlayerLoaded = false
local ObjectList = {}
local SpawnedSpikes = {}
local SpikeObjects = {}
local ClosestSpike = nil

-- Functions
local function GetClosestPoliceObject()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil
    for k,v in pairs(ObjectList) do
        local dist2 = #(pos - vector3(v.x, v.y, v.z))
        if current then
            if dist2 < dist then
                current = k
                dist = dist2
            end
        else
            dist = dist2
            current = k
        end
    end
    return current, dist
end

local function GetClosestSpike()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil
    for id, spike in pairs(SpawnedSpikes) do
        if current then
            if #(pos - vector3(spike.coords[1].x, spike.coords[1].y, spike.coords[1].z)) < dist then
                current = id
            end
        else
            dist = #(pos - vector3(spike.coords[1].x, spike.coords[1].y, spike.coords[1].z))
            current = id
        end
    end
    ClosestSpike = current
end

-- Events

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    if not PlayerLoaded then
        PlayerLoaded = true
        QBCore.Functions.TriggerCallback("police:server:GetObjects", function(objects, spikes)
            CreateThread(function()
                if objects then
                    for k,v in pairs(objects) do
                        TriggerEvent('police:client:spawnObject', k, v)
                    end
                end
            end)
            CreateThread(function()
                if spikes then
                    for k,v in pairs(spikes) do
                        TriggerEvent('police:client:spawnSpikeObject', k, v)
                    end
                end
            end)
        end)
    end
end)

RegisterNetEvent('police:client:spawnCone', function()
    if not IsPedInAnyVehicle(PlayerPedId()) then
        QBCore.Functions.Progressbar("spawn_object", Lang:t("progressbar.place_object"), 2500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@narcotics@trash",
            anim = "drop_front",
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
            local coords = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())
            local forward = GetEntityForwardVector(PlayerPedId())
            local x, y, z = table.unpack(coords + forward * 0.5)
            TriggerServerEvent("police:server:spawnObject", "cone", x, y, z, heading)
        end, function() -- Cancel
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
            QBCore.Functions.Notify(Lang:t("error.canceled"), "error")
        end)
    end
end)

RegisterNetEvent('police:client:spawnRedCone', function()
    if not IsPedInAnyVehicle(PlayerPedId()) then
        QBCore.Functions.Progressbar("spawn_object", Lang:t("progressbar.place_object"), 2500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@narcotics@trash",
            anim = "drop_front",
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
            local coords = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())
            local forward = GetEntityForwardVector(PlayerPedId())
            local x, y, z = table.unpack(coords + forward * 0.5)
            TriggerServerEvent("police:server:spawnObject", "redcone", x, y, z, heading)
        end, function() -- Cancel
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
            QBCore.Functions.Notify(Lang:t("error.canceled"), "error")
        end)
    end
end)

RegisterNetEvent('police:client:spawnBlueCone', function()
    if not IsPedInAnyVehicle(PlayerPedId()) then
        QBCore.Functions.Progressbar("spawn_object", Lang:t("progressbar.place_object"), 2500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@narcotics@trash",
            anim = "drop_front",
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
            local coords = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())
            local forward = GetEntityForwardVector(PlayerPedId())
            local x, y, z = table.unpack(coords + forward * 0.5)
            TriggerServerEvent("police:server:spawnObject", "bluecone", x, y, z, heading)
        end, function() -- Cancel
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
            QBCore.Functions.Notify(Lang:t("error.canceled"), "error")
        end)
    end
end)

RegisterNetEvent('police:client:spawnBarrier', function()
    if not IsPedInAnyVehicle(PlayerPedId()) then
        QBCore.Functions.Progressbar("spawn_object", Lang:t("progressbar.place_object"), 2500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@narcotics@trash",
            anim = "drop_front",
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
            local coords = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())
            local forward = GetEntityForwardVector(PlayerPedId())
            local x, y, z = table.unpack(coords + forward * 0.5)
            TriggerServerEvent("police:server:spawnObject", "barrier", x, y, z, heading)
        end, function() -- Cancel
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
            QBCore.Functions.Notify(Lang:t("error.canceled"), "error")
        end)
    end
end)

RegisterNetEvent('police:client:spawnRoadSign', function()
    if not IsPedInAnyVehicle(PlayerPedId()) then
        QBCore.Functions.Progressbar("spawn_object", Lang:t("progressbar.place_object"), 2500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@narcotics@trash",
            anim = "drop_front",
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
            local coords = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())
            local forward = GetEntityForwardVector(PlayerPedId())
            local x, y, z = table.unpack(coords + forward * 0.5)
            TriggerServerEvent("police:server:spawnObject", "roadsign", x, y, z, heading)
        end, function() -- Cancel
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
            QBCore.Functions.Notify(Lang:t("error.canceled"), "error")
        end)
    end
end)

RegisterNetEvent('police:client:spawnScreen', function()
    if not IsPedInAnyVehicle(PlayerPedId()) then
        QBCore.Functions.Progressbar("spawn_object", Lang:t("progressbar.place_object"), 2500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@narcotics@trash",
            anim = "drop_front",
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
            local coords = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())
            local forward = GetEntityForwardVector(PlayerPedId())
            local x, y, z = table.unpack(coords + forward * 0.5)
            TriggerServerEvent("police:server:spawnObject", "screen", x, y, z, heading)
        end, function() -- Cancel
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
            QBCore.Functions.Notify(Lang:t("error.canceled"), "error")
        end)
    end
end)

RegisterNetEvent('police:client:spawnTent', function()
    if not IsPedInAnyVehicle(PlayerPedId()) then
        QBCore.Functions.Progressbar("spawn_object", Lang:t("progressbar.place_object"), 2500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@narcotics@trash",
            anim = "drop_front",
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
            local coords = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())
            local forward = GetEntityForwardVector(PlayerPedId())
            local x, y, z = table.unpack(coords + forward * 0.5)
            TriggerServerEvent("police:server:spawnObject", "tent", x, y, z, heading)
        end, function() -- Cancel
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
            QBCore.Functions.Notify(Lang:t("error.canceled"), "error")
        end)
    end
end)

RegisterNetEvent('police:client:spawnLight', function()
    if not IsPedInAnyVehicle(PlayerPedId()) then
        QBCore.Functions.Progressbar("spawn_object", Lang:t("progressbar.place_object"), 2500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@narcotics@trash",
            anim = "drop_front",
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
            local coords = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())
            local forward = GetEntityForwardVector(PlayerPedId())
            local x, y, z = table.unpack(coords + forward * 0.5)
            TriggerServerEvent("police:server:spawnObject", "light", x, y, z, heading)
        end, function() -- Cancel
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
            QBCore.Functions.Notify(Lang:t("error.canceled"), "error")
        end)
    end
end)

RegisterNetEvent('police:client:spawnAscene', function()
    if not IsPedInAnyVehicle(PlayerPedId()) then
        QBCore.Functions.Progressbar("spawn_object", Lang:t("progressbar.place_object"), 2500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@narcotics@trash",
            anim = "drop_front",
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
            local coords = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())
            local forward = GetEntityForwardVector(PlayerPedId())
            local x, y, z = table.unpack(coords + forward * 0.5)
            TriggerServerEvent("police:server:spawnObject", "ascene", x, y, z, heading)
        end, function() -- Cancel
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
            QBCore.Functions.Notify(Lang:t("error.canceled"), "error")
        end)
    end
end)

RegisterNetEvent('police:client:spawnBscene', function()
    if not IsPedInAnyVehicle(PlayerPedId()) then
        QBCore.Functions.Progressbar("spawn_object", Lang:t("progressbar.place_object"), 2500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@narcotics@trash",
            anim = "drop_front",
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
            local coords = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())
            local forward = GetEntityForwardVector(PlayerPedId())
            local x, y, z = table.unpack(coords + forward * 0.5)
            TriggerServerEvent("police:server:spawnObject", "bscene", x, y, z, heading)
        end, function() -- Cancel
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
            QBCore.Functions.Notify(Lang:t("error.canceled"), "error")
        end)
    end
end)

RegisterNetEvent('police:client:spawnCscene', function()
    if not IsPedInAnyVehicle(PlayerPedId()) then
        QBCore.Functions.Progressbar("spawn_object", Lang:t("progressbar.place_object"), 2500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@narcotics@trash",
            anim = "drop_front",
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
            local coords = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())
            local forward = GetEntityForwardVector(PlayerPedId())
            local x, y, z = table.unpack(coords + forward * 0.5)
            TriggerServerEvent("police:server:spawnObject", "cscene", x, y, z, heading)
        end, function() -- Cancel
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
            QBCore.Functions.Notify(Lang:t("error.canceled"), "error")
        end)
    end
end)

RegisterNetEvent('police:client:spawnDscene', function()
    if not IsPedInAnyVehicle(PlayerPedId()) then
        QBCore.Functions.Progressbar("spawn_object", Lang:t("progressbar.place_object"), 2500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@narcotics@trash",
            anim = "drop_front",
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
            local coords = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())
            local forward = GetEntityForwardVector(PlayerPedId())
            local x, y, z = table.unpack(coords + forward * 0.5)
            TriggerServerEvent("police:server:spawnObject", "dscene", x, y, z, heading)
        end, function() -- Cancel
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
            QBCore.Functions.Notify(Lang:t("error.canceled"), "error")
        end)
    end
end)

RegisterNetEvent('police:client:spawnEscene', function()
    if not IsPedInAnyVehicle(PlayerPedId()) then
        QBCore.Functions.Progressbar("spawn_object", Lang:t("progressbar.place_object"), 2500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@narcotics@trash",
            anim = "drop_front",
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
            local coords = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())
            local forward = GetEntityForwardVector(PlayerPedId())
            local x, y, z = table.unpack(coords + forward * 0.5)
            TriggerServerEvent("police:server:spawnObject", "escene", x, y, z, heading)
        end, function() -- Cancel
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
            QBCore.Functions.Notify(Lang:t("error.canceled"), "error")
        end)
    end
end)

RegisterNetEvent('police:client:spawnObject', function(key, value)
    ObjectList[key] = value
    local heading = value.heading
    local x, y, z = value.x, value.y, value.z
    local model = Config.Objects[value.type].model
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(50)
    end
    local spawnedObj = CreateObject(model, x, y, z - 1, false, false, false)
    PlaceObjectOnGroundProperly(spawnedObj)
    SetEntityHeading(spawnedObj, heading)
    FreezeEntityPosition(spawnedObj, Config.Objects[value.type].freeze)
    ObjectList[key].object = spawnedObj
end)

RegisterNetEvent('police:client:deleteObject', function()
    if not IsPedInAnyVehicle(PlayerPedId()) then
        local objectId, dist = GetClosestPoliceObject()
        if dist < 5.0 then
            QBCore.Functions.Progressbar("remove_object", Lang:t('progressbar.remove_object'), 2500, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "weapons@first_person@aim_rng@generic@projectile@thermal_charge@",
                anim = "plant_floor",
                flags = 16,
            }, {}, {}, function() -- Done
                StopAnimTask(PlayerPedId(), "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)
                TriggerServerEvent("police:server:deleteObject", objectId)
            end, function() -- Cancel
                StopAnimTask(PlayerPedId(), "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)
                QBCore.Functions.Notify(Lang:t("error.canceled"), "error")
            end)
        end
    end
end)

RegisterNetEvent('police:client:removeObject', function(objectId)
    if ObjectList[objectId] then
        NetworkRequestControlOfEntity(ObjectList[objectId].object)
        DeleteObject(ObjectList[objectId].object)
        ObjectList[objectId] = nil
    end
end)

-- LocalPlayer.state:set("inv_busy", false, true)
RegisterNetEvent('police:client:startspike', function(slot)
    local count=0

   LocalPlayer.state:set("inv_busy", true, true)
    exports['qb-core']:DrawText("Hold E and Press a Number 1 - 3 To Place Spikes / Press BACKSPACE for Cancel")
    local allow=false
    while not allow do 
        if IsControlPressed(0,38) then --E
            if IsControlPressed(0,157) then --1
                count=1
                allow=true
            end 
            if IsControlPressed(0,158) then --2
                count=2
                allow=true
            end
            if IsControlPressed(0,160) then --3
                count=3
                allow=true
            end
        end  
        if IsControlPressed(0,177) then --backspace
            count=0
            allow=true
        end      
        Wait(1)
    end
    LocalPlayer.state:set("inv_busy", false, true)
    exports['qb-core']:HideText()
    if count>0 then
        TriggerEvent('police:client:spawnSpike',slot,count)
    end
end)
RegisterNetEvent('police:client:spawnSpike', function(slot,count)
    if not IsPedInAnyVehicle(PlayerPedId()) then
        TriggerServerEvent("QBCore:Server:RemoveItem", 'spike', 1, slot)
        local model = GetHashKey('P_ld_stinger_s')
        while not HasModelLoaded(model) do
            RequestModel(model)
            Wait(50)
        end
        -- local spawnCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), -0.2, 2.0, 0.0)

        local spawnCoords = {}
	        for i = 1, count do
	        	spawnCoords[i] = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, -1.5+(3.5*i), 0.15)
	        end

        local heading = GetEntityHeading(PlayerPedId())

        while not HasAnimDictLoaded('amb@medic@standing@kneel@enter') do 
            Wait(0)
            RequestAnimDict('amb@medic@standing@kneel@enter')
        end
        local scene = NetworkCreateSynchronisedScene(GetEntityCoords(PlayerPedId()), GetEntityRotation(PlayerPedId(), 2), 2, false, false, 1065353216, 0, 1.0)
        NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, 'amb@medic@standing@kneel@enter', "enter", 8.0, -8.0, 3341, 16, 1148846080, 0)
        NetworkStartSynchronisedScene(scene)
        while not IsSynchronizedSceneRunning(NetworkConvertSynchronisedSceneToSynchronizedScene(scene)) do
            Wait(0)
        end
        SetSynchronizedSceneRate(NetworkConvertSynchronisedSceneToSynchronizedScene(scene), 3.0)
        while GetSynchronizedScenePhase(NetworkConvertSynchronisedSceneToSynchronizedScene(scene)) < 0.14 do
            Wait(0)
        end
        NetworkStopSynchronisedScene(scene)
        while not HasAnimDictLoaded('p_ld_stinger_s') do 
            Wait(0)
            RequestAnimDict('p_ld_stinger_s')
        end
        spikeobj={}
        for i=1 , #spawnCoords do
        local stinger = CreateObject(model, spawnCoords[i].x, spawnCoords[i].y, spawnCoords[i].z, true, true, 0)
        spikeobj[i]=stinger
        SetEntityHeading(stinger, heading)
        FreezeEntityPosition(stinger, true)
        PlaceObjectOnGroundProperly(stinger)
        SetEntityVisible(stinger, false)
        
        PlayEntityAnim(stinger, "P_Stinger_S_Deploy", 'p_ld_stinger_s', 1000.0, false, true, 0, 0.0, 0)
        while not IsEntityPlayingAnim(stinger, "p_ld_stinger_s", "P_Stinger_S_Deploy", 3) do
            Wait(0)
        end
        SetEntityVisible(stinger, true)
        while IsEntityPlayingAnim(stinger, "p_ld_stinger_s", "P_Stinger_S_Deploy", 3) and GetEntityAnimCurrentTime(stinger, "p_ld_stinger_s", "P_Stinger_S_Deploy") <= 0.99 do
            Wait(0)
        end
        PlayEntityAnim(stinger, "p_stinger_s_idle_deployed", 'p_ld_stinger_s', 1000.0, false, true, 0, 0.99, 0)
      
     end
     for i=1 , #spawnCoords do
        DeleteObject( spikeobj[i])
     end
   
     TriggerServerEvent('police:server:spawnSpike', spawnCoords, heading)
    end
end)

RegisterNetEvent('police:client:spawnSpikeObject', function(key, value)
    if SpawnedSpikes[key] then return end
    if SpawnedSpikes[key] then
        for i=1 , #SpawnedSpikes[key].coords do
        NetworkRequestControlOfEntity(SpikeObjects[key])
        DeleteObject(SpikeObjects[key].spike[i])
        SpikeObjects[key] = nil
        end
    end
    SpawnedSpikes[key] = value
    local coords = value.coords
    local heading = value.heading
    local model = GetHashKey('P_ld_stinger_s')
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(50)
    end
    SpikeObjects[key]={}
    SpikeObjects[key].spike={}
  
    exports['qb-interact']:AddInteraction({
        coords =vector3(value.coords[1].x, value.coords[1].y, value.coords[1].z-1),
        distance = 5.0, -- optional
        interactDst = 1.5, -- optional
        id = "spike-" .. key,  -- needed for removing interactions
        name = "spike-" .. key,  -- optional
        options = {
             {
                id = "spike-" .. key, 
                label = "Remove Spike",
                event = "police:client:removeSpikeintract",
                args = {}
            },
        }
    })

    for i=1 , #value.coords do
        local spawnedSpike = CreateObject(model, value.coords[i].x, value.coords[i].y, value.coords[i].z, false, false, false)
        PlaceObjectOnGroundProperly(spawnedSpike)
        SetEntityHeading(spawnedSpike, heading)
        FreezeEntityPosition(spawnedSpike, true)
        SpikeObjects[key].spike[i] = spawnedSpike   

    end
      
end)

RegisterNetEvent('police:client:removeSpike', function(spikeId)
    if SpikeObjects[spikeId] then
        for i=1 , #SpikeObjects[spikeId].spike do
            DeleteObject(SpikeObjects[spikeId].spike[i])
            Wait(100)
        end
        for i=1 , #SpawnedSpikes[spikeId].coords do
            local entity=GetClosestObjectOfType(SpawnedSpikes[spikeId].coords[i], 1.0 ,GetHashKey('P_ld_stinger_s'), 0, 0, 0)
            DeleteEntity(entity)
            Wait(100)
        end
      
        
  exports['qb-interact']:RemoveInteraction("spike-" ..spikeId)
        SpawnedSpikes[spikeId] = nil
        SpikeObjects[spikeId] = nil
    end
   
end)
function removespike()
    if not IsPedInAnyVehicle(PlayerPedId()) then
        GetClosestSpike()
        if ClosestSpike and SpawnedSpikes[ClosestSpike] then
            local coords = SpawnedSpikes[ClosestSpike].coords[1]
            local distance = #(GetEntityCoords(PlayerPedId()) - vector3(coords.x, coords.y, coords.z))
            if distance <= 2 then
                RequestAnimDict("pickup_object")
                while not HasAnimDictLoaded("pickup_object") do
                    Wait(7)
                end
                TaskPlayAnim(PlayerPedId(), "pickup_object" ,"pickup_low" ,8.0, -8.0, -1, 1, 0, false, false, false )
                Wait(2000)
                ClearPedTasks(PlayerPedId())
                TriggerServerEvent('police:server:removeSpike', ClosestSpike)
            end
        end
    end
end
RegisterNetEvent('police:client:removeSpikeintract', function(spikeId)
    removespike()
end)
RegisterCommand('spike', function()
    removespike()
end)
TriggerEvent('chat:addSuggestion', '/spike', 'Pickup Spike')

CreateThread(function()
    while true do
        if LocalPlayer.state.isLoggedIn then
            GetClosestSpike()
        end
        Wait(500)
    end
end)

local ActiveLoopSpike = false
AddEventHandler("baseevents:enteredVehicle", function(pCurrentVehicle)
    if LocalPlayer.state.isLoggedIn and not ActiveLoopSpike then
        ActiveLoopSpike = true
		SpikeLoopFunc()
    end
end)

AddEventHandler("baseevents:leftVehicle", function()
    if ActiveLoopSpike then
        ActiveLoopSpike = false
    end
end)

function SpikeLoopFunc()
    CreateThread(function()
        while ActiveLoopSpike do
            local Sleep = 500
            if ClosestSpike then
                Sleep = 10
                local tires = {
                    {bone = "wheel_lf", index = 0},
                    {bone = "wheel_rf", index = 1},
                    {bone = "wheel_lm", index = 2},
                    {bone = "wheel_rm", index = 3},
                    {bone = "wheel_lr", index = 4},
                    {bone = "wheel_rr", index = 5}
                }
                for a = 1, #tires do
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    local tirePos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, tires[a].bone))
                    local spike = GetClosestObjectOfType(tirePos.x, tirePos.y, tirePos.z, 15.0, GetHashKey('P_ld_stinger_s'), 1, 1, 1)
                    local spikePos = GetEntityCoords(spike, false)
                    local distance = #(tirePos - spikePos)
                    if distance < 1.8 then
                        if not IsVehicleTyreBurst(vehicle, tires[a].index, true) or IsVehicleTyreBurst(vehicle, tires[a].index, false) then
                            SetVehicleTyreBurst(vehicle, tires[a].index, false, 1000.0)
                        end
                    end
                end
            end
            Wait(Sleep)
        end
    end)
end