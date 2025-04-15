local QBCore = exports['qb-core']:GetCoreObject()
local count=0
local max=0
local finished =false
local contiainerblip
local startrob=false
local pass=""
local guard={}
local CurrentCops=0
local dispatch=false
RegisterNetEvent('police:SetCopCount', function(amount,amounthigh)
    CurrentCops = amount
end)

CreateThread(function()
    for k,v in pairs( config.containerlocation) do
        for m,n in pairs(v) do
            object=GetClosestObjectOfType(n.container.x,n.container.y,n.container.z,3.0,GetHashKey(config.containermodel))
            if n.ammorack then
                object1=GetClosestObjectOfType(n.ammorack.x,n.ammorack.y,n.ammorack.z,3.0,GetHashKey(config.ammorackmodel))
                DeleteObject(object1)
            end
             DeleteObject(object)
        end
     end
	-- local model = GetHashKey(config.pedmodel)
    -- RequestModel(model)
    -- while not HasModelLoaded(model) do
    --     Wait(1)
    -- end
    -- local ped = CreatePed(4, model,config.pedcoord.x,config.pedcoord.y,config.pedcoord.z, false, false)
    -- SetEntityInvincible(ped, true)
    -- FreezeEntityPosition(ped, true)
    -- SetBlockingOfNonTemporaryEvents(ped, true)
	-- TaskStartScenarioInPlace(ped, config.pedScenario, 0, true)
    -- SetEntityHeading(ped,config.pedcoord.w)

    -- exports['qb-target']:AddTargetEntity(ped, {
    --     options = {
    --         {
    --             event = "sam-amrob:client:prestartrob",
    --             icon = "fas fa-cash-register",
    --             label = "Get Container Location",
    --         },
    --     },
    --     distance = 1.5
    -- })
end)
local function LoadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(5)
    end
  end

  local netid 
local containerid
local container
RegisterNetEvent('sam-amrob:client:prestartrob', function()
    if not exports["qb-smallresources"]:getdevelopermode() and config.policerequire>CurrentCops then
		QBCore.Functions.Notify("Not Enough Police", "error")
		return
	end

    if not QBCore.Functions.HasItem(config.itemrequire)  then
        QBCore.Functions.Notify("Missing item to start the mission....", "error")
        return
    end

QBCore.Functions.TriggerCallback('sam-amorob:server:checkrobstart', function(result)
if not  result then
    TriggerEvent('sam-amrob:client:startrob')    
else
    QBCore.Functions.Notify("Not Allowed this time...", "error")
end
end)

end)

RegisterNetEvent('sam-amrob::client:coderequire', function(data)
    if not QBCore.Functions.HasItem(config.itemrequire)  then
        QBCore.Functions.Notify("Missing item....", "error")
        return
    end
    data=data.args
    local dialog = exports['qb-input']:ShowInput({
        header = 'Enter Door Password:',
        submitText = "Submit",
        inputs = {
            { type = 'password', isRequired = true, name = 'code', text = 'code' },
        }
    })
    if dialog then
        if not dialog.code then return end
       if dialog.code==tostring(pass) then
        if not dispatch then
            SpawnGuards()
            exports['qb-dispatch']:ammunation()
            dispatch=true
        end
      

        TriggerServerEvent("inventory:server:breakItem", config.itemrequire, 10)
        TriggerEvent('sam-amorob:client:containerSyncs',data)
       else
        QBCore.Functions.Notify("Password Not Valid...", "error")
       end
    end
end)

function loadModel(model)
    if type(model) == 'number' then
        model = model
    else
        model = GetHashKey(model)
    end
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
end

function SpawnGuards()
    local ped = PlayerPedId()
    AddRelationshipGroup('GuardPeds')
    SetPedRelationshipGroupHash(ped, GetHashKey('PLAYER'))
    guard={}
 
    for k, v in pairs(config.guard) do
        loadModel(config.guardmodel)
        guard[k]= CreatePed(26, GetHashKey(config.guardmodel), v.xyz, v.w, true, true)
        NetworkRegisterEntityAsNetworked(guard[k])
        networkID = NetworkGetNetworkIdFromEntity(guard[k])
        SetNetworkIdCanMigrate(networkID, true)
        SetNetworkIdExistsOnAllMachines(networkID, true)
        SetPedRandomComponentVariation(guard[k], 0)
        SetPedRandomProps(guard[k])
        SetEntityAsMissionEntity(guard[k])
        SetEntityVisible(guard[k], true)
        SetPedRelationshipGroupHash(guard[k], GetHashKey("GuardPeds"))
        SetPedAccuracy(guard[k], 100)
        SetPedArmour(guard[k], 100)
        SetPedCanSwitchWeapon(guard[k], true)
        SetPedDropsWeaponsWhenDead(guard[k], false)
		SetPedFleeAttributes(guard[k], 0, false)
        GiveWeaponToPed(guard[k], GetHashKey('WEAPON_PISTOL'), 255, false, false)
    end
    SetRelationshipBetweenGroups(0, GetHashKey("GuardPeds"), GetHashKey("GuardPeds"))
	SetRelationshipBetweenGroups(5, GetHashKey("GuardPeds"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("GuardPeds"))
end



RegisterNetEvent('sam-amrob:client:startrob', function()
    finished=false
    startrob=true
    count=0
    TriggerServerEvent('sam-amorob:server:startrob')         
    CreateThread(function()
        Wait(config.timeout)
        if not finished then
            robstart=false
        end
        for k,v in pairs(guard) do
            DeleteEntity(v)
        end
        dispatch=false
    end)
    local textcontainer={}
    local boxammocontainer={}
    containerid=math.random(1,#config.containerlocation)
    max=#config.containerlocation[containerid]
    for k,v in pairs(config.containerlocation[containerid]) do
        LoadModel(config.containermodel)
        container= CreateObject(GetHashKey(config.containermodel),vector3(v.container.x,v.container.y,v.container.z), true, true, 0)
        SetEntityHeading(container, v.container.w)
        FreezeEntityPosition(container, true)
        SetEntityCollision(container, true, true)
        LoadModel('tr_prop_tr_lock_01a')
        local lock = CreateObject(GetHashKey('tr_prop_tr_lock_01a'),vector3(v.lock.x,v.lock.y,v.lock.z),true, true, 0)
        SetEntityHeading(lock,v.container.w)
        FreezeEntityPosition(lock, true)
        SetEntityCollision(lock, true, true)
        chance =math.random(1,100)
        if chance>config.emptychance then
            boxammocontainer[#boxammocontainer+1]={containerid=containerid,index=k,ammorackx=v.ammorack.x,ammoracky=v.ammorack.y,ammorackz=v.ammorack.z,ammorackw=v.ammorack.w}
        end
        local objCoords = GetEntityCoords(container)
		local objHeading = GetEntityHeading(container)
        textcontainer[#textcontainer+1]={containerid=containerid,k=k,lockx=v.lock.x,locky=v.lock.y,lockz=v.lock.z}
        config.containerlocation[containerid][k].looted=true
        Wait(200)
    end
    pass=math.random(1111,9999)
    TriggerServerEvent('sam-amrob:server:patext',textcontainer,boxammocontainer,pass)
    exports["nxo-oui"]:Show('Task',  'Container Password: '.. pass ..'</br>Go To Container Point')
    contiainerblip= AddBlipForCoord(config.containerlocation[containerid][1].container.x,config.containerlocation[containerid][1].container.y,config.containerlocation[containerid][1].container.z)
    SetBlipColour(contiainerblip, 3)
    SetBlipRoute(contiainerblip, true)
    SetBlipRouteColour(contiainerblip, 3)
    dist=1000
    while dist>200 do 
        dist=#(GetEntityCoords(PlayerPedId())-vector3(config.containerlocation[containerid][1].container.x,config.containerlocation[containerid][1].container.y,config.containerlocation[containerid][1].container.z))
        Wait(100)
    end
    RemoveBlip(contiainerblip)
end)

RegisterNetEvent('sam-amrob:client:removepatext')
AddEventHandler('sam-amrob:client:removepatext', function(container,k)
    exports['qb-interact']:RemoveInteraction("sam-ammunation-" ..container..'-'..k)
end)

RegisterNetEvent('sam-amrob:client:removeammorack')
AddEventHandler('sam-amrob:client:removeammorack', function(container,k)
    object1=GetClosestObjectOfType(config.containerlocation[container][k].ammorack.x,config.containerlocation[container][k].ammorack.y,config.containerlocation[container][k].ammorack.z,3.0,GetHashKey(config.ammorackmodel))
    DeleteObject(object1)
end)
RegisterNetEvent('sam-amrob:client:patext')
AddEventHandler('sam-amrob:client:patext', function(data,boxammocontainer,password)
    pass=password
    startrob=true
    for k,v in pairs(data) do
        exports['qb-interact']:AddInteraction({
            coords =vector3(v.lockx,v.locky,v.lockz),
            distance = 5.0, 
            interactDst = 1.2, 
            id = "sam-ammunation-" ..v.containerid..'-'..v.k,
            name = "sam-ammunation-" ..v.containerid..'-'..v.k,
          
            options = {
                 {
                    canInteract = function(entity, coords, args)
                        return  startrob
                    end,
                    id = "sam-ammunation-" ..v.containerid..'-'..v.k,
                    label =  "Open Container",
                    event = "sam-amrob::client:coderequire",
                    args = {containerid=v.containerid,index=v.k}
                },
            }
        })
    end

    for k,v in pairs(boxammocontainer) do

        LoadModel((config.ammorackmodel))
       local boxammo= CreateObject(GetHashKey(config.ammorackmodel),vector3(v.ammorackx,v.ammoracky,v.ammorackz), false,false, 0)
        SetEntityHeading(boxammo,v.ammorackw)
        FreezeEntityPosition(boxammo, true)
        SetEntityCollision(boxammo, true, true)

        exports['qb-target']:AddTargetEntity(boxammo, {
            options = {
                {
                    event = "sam-amrob:client:loot",
                    icon = "fas fa-cash-register",
                    label = "Loot",
                    -- canInteract = function(entity)
                    --     return (not config.containerlocation[containerid][k].looted) and startrob
                    -- end,
                    indx=v.index,
                    containerid=v.containerid,
                    
                },
            },
            distance =1.5
        })
        Wait(1000)
    end


end)
function leave()

    dist=1
    while dist<200 do 
        dist=#(GetEntityCoords(PlayerPedId())-vector3(config.containerlocation[containerid][1].container.x,config.containerlocation[containerid][1].container.y,config.containerlocation[containerid][1].container.z))
        Wait(100)
    end
    exports["nxo-oui"]:Close()
  
end

RegisterNetEvent('sam-amorob:client:addopencontainer')
AddEventHandler('sam-amorob:client:addopencontainer', function(cunt)
    count=cunt
    if count==max then
        finished=true
        exports["nxo-oui"]:Show('Complete', 'Now After Pickup a loot Leave Area...')
        leave()
    else
        exports["nxo-oui"]:Show('Task', 'Container Password: '.. pass ..'</br> Container '..cunt..'/'..max)
    end
end)



RegisterNetEvent('sam-amrob:client:loot')
AddEventHandler('sam-amrob:client:loot', function(data)
    QBCore.Functions.TriggerCallback('sam-amorob:server:checkfreeloot', function(result)
       

if result then
    ExecuteCommand('e search')
    local reshack=exports['nxo-MiniGames']:untangle(10,30000)
    if not reshack then
        QBCore.Functions.Notify("Faild...", "error")
        ExecuteCommand('e c')
        TriggerServerEvent('sam-amrob:server:freeloot',data.containerid,data.indx)
        return
    end
    -- config.containerlocation[data.containerid][data.index].looted=true
    DeleteObject(data.entity)
    TriggerServerEvent('sam-amrob:server:removeammorack',data.containerid,data.indx)
    Wait(1000)
    ExecuteCommand('e c')
   
    TriggerServerEvent('sam-amorob:server:addtostash')
    -- Wait(100)
    -- TriggerServerEvent("inventory:server:OpenInventory", "stash",'samamo'..data.containerid..'-'..data.index, {
    --     maxweight = 1000000,
    --     slots =1,
    -- })
else

end
        end,data.containerid,data.indx)


   
end)


function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(50)
    end
end
function loadPtfxAsset(dict)
    while not HasNamedPtfxAssetLoaded(dict) do
        RequestNamedPtfxAsset(dict)
        Citizen.Wait(50)
	end
end

RegisterNetEvent('sam-amorob:client:containerSyncs')
AddEventHandler('sam-amorob:client:containerSyncs', function(data)
    TriggerServerEvent('sam-amrob:server:removepatext',data.containerid,data.index)
    exports['qb-interact']:RemoveInteraction("sam-ammunation-" ..data.containerid..'-'..data.index)
            count=count+1
            local ped = PlayerPedId()
            local pedCo = GetEntityCoords(ped)
            local pedRotation = GetEntityRotation(ped)
            local animDict = 'anim@scripted@player@mission@tunf_train_ig1_container_p1@male@'
            loadAnimDict(animDict)
            loadPtfxAsset('scr_tn_tr')
           
            for i = 1, #containerAnimation['objects'] do
                LoadModel(containerAnimation['objects'][i])
                containerAnimation['sceneObjects'][i] = CreateObject(GetHashKey(containerAnimation['objects'][i]), pedCo, 1, 1, 0)
            end
            sceneObject = GetClosestObjectOfType(pedCo, 2.5, GetHashKey('tr_prop_tr_container_01a'), 0, 0, 0)
            lockObject = GetClosestObjectOfType(pedCo, 2.5, GetHashKey('tr_prop_tr_lock_01a'), 0, 0, 0)
            NetworkRegisterEntityAsNetworked(sceneObject)
            NetworkRegisterEntityAsNetworked(lockObject)
            scene = NetworkCreateSynchronisedScene(GetEntityCoords(sceneObject), GetEntityRotation(sceneObject), 2, true, false, 1065353216, 0, 1065353216)
            NetworkAddPedToSynchronisedScene(ped, scene, animDict, containerAnimation['animations'][1][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
            NetworkAddEntityToSynchronisedScene(sceneObject, scene, animDict, containerAnimation['animations'][1][2], 1.0, -1.0, 1148846080)
            NetworkAddEntityToSynchronisedScene(lockObject, scene, animDict, containerAnimation['animations'][1][3], 1.0, -1.0, 1148846080)
            NetworkAddEntityToSynchronisedScene(containerAnimation['sceneObjects'][1], scene, animDict, containerAnimation['animations'][1][4], 1.0, -1.0, 1148846080)
            NetworkAddEntityToSynchronisedScene(containerAnimation['sceneObjects'][2], scene, animDict, containerAnimation['animations'][1][5], 1.0, -1.0, 1148846080)
            SetEntityCoords(ped, GetEntityCoords(sceneObject))
            NetworkStartSynchronisedScene(scene)
            Wait(4000)
            sparks = StartParticleFxLoopedOnEntity("scr_tn_tr_angle_grinder_sparks", containerAnimation['sceneObjects'][1], 0.0, 0.25, 0.0, 0.0, 0.0, 0.0, 1.0, false, false, false, 1065353216, 1065353216, 1065353216, 1)
            Wait(1000)
            StopParticleFxLooped(sparks, 1)
            Wait(GetAnimDuration(animDict, 'action') * 1000 - 5000)
            TriggerServerEvent('sam-amorob:server:containerSync', GetEntityCoords(sceneObject), GetEntityRotation(sceneObject),config.containerlocation[data.containerid][data.index].container)
            TriggerServerEvent('sam-amorob:server:objectSync', NetworkGetNetworkIdFromEntity(sceneObject))
            TriggerServerEvent('sam-amorob:server:objectSync', NetworkGetNetworkIdFromEntity(lockObject))
            DeleteObject(containerAnimation['sceneObjects'][1])
            DeleteObject(containerAnimation['sceneObjects'][2])
            ClearPedTasks(ped)
           
            config.containerlocation[data.containerid][data.index].looted=false
            TriggerServerEvent('sam-amorob:server:addopencontainer')
         
            
            if count==max then
                finished=true
                exports["nxo-oui"]:Show('Complete', 'Now After Pickup a loot Leave Area...')
                leave()
            end
            
end)


RegisterNetEvent('sam-amorob:client:objectSync')
AddEventHandler('sam-amorob:client:objectSync', function(e)
    local entity = NetworkGetEntityFromNetworkId(e)
    DeleteEntity(entity)
    DeleteObject(entity)
end)


RegisterNetEvent('sam-amorob:client:containerSync')
AddEventHandler('sam-amorob:client:containerSync', function(coords, rotation,contcoord)
    animDict = 'anim@scripted@player@mission@tunf_train_ig1_container_p1@male@'
    loadAnimDict(animDict)
    clientContainer = CreateObject(GetHashKey('tr_prop_tr_container_01a'), coords, 0,0, 0)
        clientLock = CreateObject(GetHashKey('tr_prop_tr_lock_01a'), coords, 0, 0, 0)
        clientScene = CreateSynchronizedScene(coords, rotation, 2, true, false, 1065353216, 0, 1065353216)
        PlaySynchronizedEntityAnim(clientContainer, clientScene, containerAnimation['animations'][1][2], animDict, 1.0, -1.0, 0, 1148846080)
        ForceEntityAiAndAnimationUpdate(clientContainer)
        PlaySynchronizedEntityAnim(clientLock, clientScene, containerAnimation['animations'][1][3], animDict, 1.0, -1.0, 0, 1148846080)
        ForceEntityAiAndAnimationUpdate(clientLock)
    

        SetSynchronizedScenePhase(clientScene, 0.99)
        SetEntityCollision(clientContainer, false, false)
        FreezeEntityPosition(clientContainer, true)
        LoadModel('tr_prop_tr_cont_coll_01a')
       
        res= CreateObject(GetHashKey('tr_prop_tr_cont_coll_01a'), vector3(contcoord.x,contcoord.y,contcoord.z), 0,0, 0)
        SetEntityCoords(res, coords, false, false, false)
        SetEntityCollision(res, true, false)
        FreezeEntityPosition(res, true)
        SetEntityHeading(res, contcoord.w)
      
end)

RegisterNetEvent('sam-amorob:client:removeallobject')
AddEventHandler('sam-amorob:client:removeallobject', function()
    for k,v in pairs( config.containerlocation) do
        for m,n in pairs(v) do
            exports['qb-interact']:RemoveInteraction("sam-ammunation-" ..k..'-'..m)
            object=GetClosestObjectOfType(n.container.x,n.container.y,n.container.z,3.0,GetHashKey(config.containermodel))
            if n.ammorack then
                object1=GetClosestObjectOfType(n.ammorack.x,n.ammorack.y,n.ammorack.z,3.0,GetHashKey(config.ammorackmodel))
                DeleteObject(object1)
            end
            lock=GetClosestObjectOfType(n.container.x,n.container.y,n.container.z,3.0,GetHashKey('tr_prop_tr_lock_01a'))
            
            object3=GetClosestObjectOfType(n.container.x,n.container.y,n.container.z,3.0,GetHashKey('tr_prop_tr_cont_coll_01a'))
             DeleteObject(object)
           
             DeleteObject(lock)
             DeleteObject(lock)
             DeleteObject(object3)
        end
     end
   
end)

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
     for k,v in pairs( config.containerlocation) do
        for m,n in pairs(v) do
            exports['qb-interact']:RemoveInteraction("sam-ammunation-" ..k..'-'..m)
            object=GetClosestObjectOfType(n.container.x,n.container.y,n.container.z,3.0,GetHashKey(config.containermodel))
            lock=GetClosestObjectOfType(n.container.x,n.container.y,n.container.z,3.0,GetHashKey('tr_prop_tr_lock_01a'))
            object3=GetClosestObjectOfType(n.container.x,n.container.y,n.container.z,3.0,GetHashKey('tr_prop_tr_cont_coll_01a'))
            if n.ammorack then
                object1=GetClosestObjectOfType(n.ammorack.x,n.ammorack.y,n.ammorack.z,3.0,GetHashKey(config.ammorackmodel))
                DeleteObject(object1)
            end

             DeleteObject(object)
             DeleteObject(lock)
             DeleteObject(lock)
             DeleteObject(object3)
             exports["nxo-oui"]:Close()
        end
     end
   
    end
end)





-- Citizen.CreateThread(function()
-- 		tempmodel = GetHashKey("freight")
-- 		RequestModel(tempmodel)
-- 		while not HasModelLoaded(tempmodel) do
-- 			RequestModel(tempmodel)
-- 			Citizen.Wait(0)
-- 		end

-- 		tempmodel = GetHashKey("freightcar")
-- 		RequestModel(tempmodel)
-- 		while not HasModelLoaded(tempmodel) do
-- 			RequestModel(tempmodel)
-- 			Citizen.Wait(0)
-- 		end

-- 		tempmodel = GetHashKey("freightgrain")
-- 		RequestModel(tempmodel)
-- 		while not HasModelLoaded(tempmodel) do
-- 			RequestModel(tempmodel)
-- 			Citizen.Wait(0)
-- 		end

-- 		tempmodel = GetHashKey("freightcont1")
-- 		RequestModel(tempmodel)
-- 		while not HasModelLoaded(tempmodel) do
-- 			RequestModel(tempmodel)
-- 			Citizen.Wait(0)
-- 		end

-- 		tempmodel = GetHashKey("freightcont2")
-- 		RequestModel(tempmodel)
-- 		while not HasModelLoaded(tempmodel) do
-- 			RequestModel(tempmodel)
-- 			Citizen.Wait(0)
-- 		end

-- 		tempmodel = GetHashKey("freighttrailer")
-- 		RequestModel(tempmodel)
-- 		while not HasModelLoaded(tempmodel) do
-- 			RequestModel(tempmodel)
-- 			Citizen.Wait(0)
-- 		end

-- 		tempmodel = GetHashKey("tankercar")
-- 		RequestModel(tempmodel)
-- 		while not HasModelLoaded(tempmodel) do
-- 			RequestModel(tempmodel)
-- 			Citizen.Wait(0)
-- 		end

-- 		tempmodel = GetHashKey("metrotrain")
-- 		RequestModel(tempmodel)
-- 		while not HasModelLoaded(tempmodel) do
-- 			RequestModel(tempmodel)
-- 			Citizen.Wait(0)
-- 		end

-- 		tempmodel = GetHashKey("s_m_m_lsmetro_01")
-- 		RequestModel(tempmodel)
-- 		while not HasModelLoaded(tempmodel) do
-- 			RequestModel(tempmodel)
-- 			Citizen.Wait(0)
-- 		end
-- 		if Debug then
-- 			if Debug then print("FiveM-Trains: Train Models Loaded" ) end
-- 		end


--     Wait(1000)
--     Train = CreateMissionTrain(21,-252.09346008301, -1187.5511474609, 29.143999099731,true)
--     while not DoesEntityExist(Train) do
--         Wait(800)
--     end
-- print('ok')
--     local MetroBlip = AddBlipForEntity(Train)      
-- 			SetBlipSprite (MetroBlip, 660)
-- 			SetBlipDisplay(MetroBlip, 4)
-- 			SetBlipScale  (MetroBlip, 0.8)
-- 			SetBlipColour (MetroBlip, 2)
-- 			SetBlipAsShortRange(MetroBlip, true)
-- 			BeginTextCommandSetBlipName("STRING")
-- 			AddTextComponentString("Metro")
-- 			EndTextCommandSetBlipName(MetroBlip)

--             SetTrainCruiseSpeed(Train, 150.0)



--             TrainDriverHash = GetHashKey("s_m_m_lsmetro_01")

-- 		-- By making a refrence to the drivers we can call them further on to make them invincible for example.
-- 		Driver1 = CreatePedInsideVehicle(Train, 26, TrainDriverHash, -1, 1, true)
-- 		-- Driver2 = CreatePedInsideVehicle(MetroTrain, 26, TrainDriverHash, -1, 1, true)

-- 		-- if UseTwoMetros == 1 then
-- 		-- 	Driver3 = CreatePedInsideVehicle(MetroTrain2, 26, TrainDriverHash, -1, 1, true) -- create peds for the trains
-- 		-- end

-- 		--=========================================================
-- 		-- XNL 'Addition': This SHOULD prevent the train driver(s)
-- 		-- from getting shot or fleeing out of the train/tram when
-- 		-- being targeted by the player.
-- 		-- We have had several instances where the tram driver just
-- 		-- teleported out of the tram to attack the player when it
-- 		-- it was targeted (even without holding a weapon).
-- 		-- I suspect that this behaviour is default in the game
-- 		-- unless you override it.
-- 		--=========================================================
-- 		SetBlockingOfNonTemporaryEvents(Driver1, true)
-- 		SetPedFleeAttributes(Driver1, 0, 0)
-- 		SetEntityInvincible(Driver1, true)
-- 		-- SetEntityAsMissionEntity(Driver1, true)


-- 		-- SetBlockingOfNonTemporaryEvents(Driver3, true)
-- 		-- SetPedFleeAttributes(Driver3, 0, 0)
-- 		-- SetEntityInvincible(Driver3, true)
-- 		-- SetEntityAsMissionEntity(Driver3, true)

-- 		-- SetEntityAsMissionEntity(Train,true,true) -- dunno if this does anything, just throwing it in for good measure
		

-- 		-- SetEntityInvincible(Train, true)
-- 		-- SetEntityInvincible(MetroTrain, true)

	
-- 			-- SetBlockingOfNonTemporaryEvents(Driver2, true)
-- 			-- SetPedFleeAttributes(Driver2, 0, 0)
-- 			-- SetEntityInvincible(Driver2, true)
-- 			-- SetEntityAsMissionEntity(Driver2, true)
-- 			-- SetEntityAsMissionEntity(MetroTrain2,true,true)
-- 			-- SetEntityInvincible(MetroTrain2, true)
	

-- 		-- Cleanup from memory
-- 		SetModelAsNoLongerNeeded(TrainDriverHash)

--         Wait(5000)
--         SetTrainCruiseSpeed(Train, 0)
-- end)