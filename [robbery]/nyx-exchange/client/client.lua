local QBCore = exports['qb-core']:GetCoreObject()
local animationObjects = {}
local scenes = {}
local powerid=0
local animStages = {
    ['intro'] = { 'action_var_01', 'action_var_01_ch_prop_ch_usb_drive01x', 'action_var_01_prop_phone_ing' },
    ['idle'] = {'hack_loop_var_01', 'hack_loop_var_01_ch_prop_ch_usb_drive01x', 'hack_loop_var_01_prop_phone_ing'},
    ['outro'] = {'success_react_exit_var_01', 'success_react_exit_var_01_ch_prop_ch_usb_drive01x', 'success_react_exit_var_01_prop_phone_ing'},
}

function StartPhoneAnimation(playerCoords, usbCoords)
    local animDict = 'anim_heist@hs3f@ig1_hack_keypad@arcade@male@'
    local usbHash = `ch_prop_ch_usb_drive01x`
    local phoneHash = `ch_prop_ch_phone_ing_01a`
    lib.requestAnimDict(animDict)
    
    local usbObject = CreateObject(usbHash, 0, 0, 0, true, true, true)
    local phoneObject = CreateObject(phoneHash, 0, 0, 0, true, true, true)
    animationObjects.usbObject = usbObject
    animationObjects.phoneObject = phoneObject

    TaskGoStraightToCoord(cache.ped, playerCoords.x, playerCoords.y, playerCoords.z, 1.0, 2000, playerCoords.w, 0.0)
    Wait(600)
    for _, stage in ipairs({'intro', 'idle', 'outro'}) do
        local animData = animStages[stage]
        scenes[stage] = NetworkCreateSynchronisedScene(usbCoords.x, usbCoords.y, usbCoords.z, 0.0, 0.0, playerCoords.w, 2, false, false, 1065353216, 0, 1065353216)
        NetworkAddPedToSynchronisedScene(cache.ped, scenes[stage], animDict, animData[1], 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(usbObject, scenes[stage], animDict, animData[2], 1.5, -4.0, 1)
        NetworkAddEntityToSynchronisedScene(phoneObject, scenes[stage], animDict, animData[3], 1.5, -4.0, 1)
    end

    NetworkStartSynchronisedScene(scenes['intro'])
    Wait(5000)
    NetworkStartSynchronisedScene(scenes['idle'])
    Wait(1000)
end

function FinishPhoneAnimation()
    NetworkStartSynchronisedScene(scenes['outro'])
    Wait(5000)
    
    DeleteObject(animationObjects.usbObject)
    DeleteObject(animationObjects.phoneObject)
    animationObjects = {}
end

function TriggerAlert()
    exports['qb-dispatch']:Exchange()
end

LaptopAnimation = function(data) -- Globally used
    local loc = Config.PowerLocations[powerid]['doorhack'].laptopanim
    local item = QBCore.Functions.HasItem(data.requireditem, 1)
    if item then
        LocalPlayer.state:set("inv_busy", false, false)
        local animDict = "anim@heists@ornate_bank@hack"
        RequestAnimDict(animDict)
        RequestModel("hei_prop_hst_laptop")
        RequestModel("hei_p_m_bag_var22_arm_s")
        while not HasAnimDictLoaded(animDict) or not HasModelLoaded("hei_prop_hst_laptop") or not HasModelLoaded("hei_p_m_bag_var22_arm_s") do Wait(10) end
        local ped = PlayerPedId()
        local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
        if math.random(1, 100) <= 65 and not QBCore.Functions.IsWearingGloves() then
            TriggerServerEvent("evidence:server:CreateFingerDrop", targetPosition)
        end

        local animPos = GetAnimInitialOffsetPosition(animDict, "hack_enter", loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
        local animPos2 = GetAnimInitialOffsetPosition(animDict, "hack_loop", loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
        local animPos3 = GetAnimInitialOffsetPosition(animDict, "hack_exit", loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
        FreezeEntityPosition(ped, true)

        local netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
        local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, targetPosition, 1, 1, 0)
        local laptop = CreateObject(`hei_prop_hst_laptop`, targetPosition, 1, 1, 0)
        NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "hack_enter", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, "hack_enter_bag", 4.0, -8.0, 1)
        NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, "hack_enter_laptop", 4.0, -8.0, 1)

        local netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, true, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "hack_loop", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(bag, netScene2, animDict, "hack_loop_bag", 4.0, -8.0, 1)
        NetworkAddEntityToSynchronisedScene(laptop, netScene2, animDict, "hack_loop_laptop", 4.0, -8.0, 1)

        local netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, "hack_exit", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(bag, netScene3, animDict, "hack_exit_bag", 4.0, -8.0, 1)
        NetworkAddEntityToSynchronisedScene(laptop, netScene3, animDict, "hack_exit_laptop", 4.0, -8.0, 1)

        Wait(200)
        NetworkStartSynchronisedScene(netScene)
        Wait(6300)
        NetworkStartSynchronisedScene(netScene2)
        Wait(2000)
        local memorygame = exports['nxo-MiniGames']:words(2, 60000)
      
        local doorData = Config.PowerLocations[powerid]['doorhack']
        if memorygame then
            TriggerServerEvent('nyx-exchange:removeitem')
            NetworkStartSynchronisedScene(netScene3)
            Wait(4600)
            NetworkStopSynchronisedScene(netScene3)
            DeleteObject(bag)
            DeleteObject(laptop)
            FreezeEntityPosition(ped, false)
            TriggerServerEvent('nyx-exchange:server:setbusystate', 'doorhack', true,powerid)
            TriggerEvent("QBCore:Notify", "Wait 3 minutes for the door to get Unlocked", "error")
            Wait(180000)
            TriggerEvent('nyx-exchange:HackSmartDoor', 'doorhack', doorData)
            CreateTrollys()
        else
            NetworkStartSynchronisedScene(netScene3)
            Wait(4600)
            NetworkStopSynchronisedScene(netScene3)
            DeleteObject(bag)
            DeleteObject(laptop)
            FreezeEntityPosition(ped, false)
        end
    else
        TriggerEvent("QBCore:Notify", "you missing something...", "error")
    end
end

CreateTrollys = function()
    RequestModel("hei_prop_hei_cash_trolly_01")
    RequestModel("ch_prop_gold_trolly_01a")
    while not HasModelLoaded("hei_prop_hei_cash_trolly_01") or not HasModelLoaded("ch_prop_gold_trolly_01a") do Wait(10) end
    for z,m in pairs(Config.trollys) do
    for k, v in pairs(m) do
        if v.type == 'money' then
            -- DELETE OLD
            local oldcashtrolley = GetClosestObjectOfType(v.coords.x, v.coords.y, v.coords.z, 1.0, 269934519, false, false, false)
            if oldcashtrolley ~= 0 then
                local netId = NetworkGetNetworkIdFromEntity(oldcashtrolley)
                TriggerServerEvent('nyx-exchange:server:DeleteObject', netId)
                Wait(500)
            end
            local emptytrolly = GetClosestObjectOfType(v.coords.x, v.coords.y, v.coords.z, 1.0, 769923921, false, false, false)
            if emptytrolly ~= 0 then
                local netId = NetworkGetNetworkIdFromEntity(emptytrolly)
                TriggerServerEvent('nyx-exchange:server:DeleteObject', netId)
                Wait(500)
            end
            -- CREATE NEW
            local trolly = CreateObject(269934519, v.coords.x, v.coords.y, v.coords.z, 1, 0, 0)
            SetEntityHeading(trolly, v.coords.w)
            FreezeEntityPosition(trolly, true)
            SetEntityInvincible(trolly, true)
            PlaceObjectOnGroundProperly(trolly)
        elseif v.type == 'gold' then
            -- DELETE OLD
            local oldgoldtrolly = GetClosestObjectOfType(v.coords.x, v.coords.y, v.coords.z, 2.0, 2007413986, false, false, false)
            if oldgoldtrolly ~= 0 then
                local netId = NetworkGetNetworkIdFromEntity(oldgoldtrolly)
                TriggerServerEvent('nyx-exchange:server:DeleteObject', netId)
                Wait(500)
            end
            local emptytrolly = GetClosestObjectOfType(v.coords.x, v.coords.y, v.coords.z, 1.0, -1580618867, false, false, false)
            if emptytrolly ~= 0 then
                local netId = NetworkGetNetworkIdFromEntity(emptytrolly)
                TriggerServerEvent('nyx-exchange:server:DeleteObject', netId)
                Wait(500)
            end
            -- CREATE NEW
            local trolly = CreateObject(2007413986, v.coords.x, v.coords.y, v.coords.z, 1, 0, 0)
            SetEntityHeading(trolly, v.coords.w)
            FreezeEntityPosition(trolly, true)
            SetEntityInvincible(trolly, true)
            PlaceObjectOnGroundProperly(trolly)
        end
    end
end
end


LootTrolly = function(index) -- Globally used
    -- set taken
    TriggerServerEvent('nyx-exchange:server:SetTrollyBusy', index, true, powerid)
    -- animation
    LocalPlayer.state:set("inv_busy", true, true)

    -- Determine the type of trolly (money or gold)
    local trollyType = Config.trollys[powerid][index].type
    local coords = Config.trollys[powerid][index].coords
    local ped = PlayerPedId()
    
    if trollyType == 'money' then
        local CurrentTrolly = GetClosestObjectOfType(coords.x, coords.y, coords.z, 1.0, 269934519, false, false, false)
        local MoneyObject = CreateObject(`hei_prop_heist_cash_pile`, GetEntityCoords(ped), true)
        SetEntityVisible(MoneyObject, false, false)
        AttachEntityToEntity(MoneyObject, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
        local GrabBag = CreateObject(`hei_p_m_bag_var22_arm_s`, GetEntityCoords(ped), true, false, false)
        
        local GrabOne = NetworkCreateSynchronisedScene(GetEntityCoords(CurrentTrolly), GetEntityRotation(CurrentTrolly), 2, false, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, GrabOne, "anim@heists@ornate_bank@grab_cash", "intro", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(GrabBag, GrabOne, "anim@heists@ornate_bank@grab_cash", "bag_intro", 4.0, -8.0, 1)
        SetPedComponentVariation(ped, 5, 0, 0, 0)
        NetworkStartSynchronisedScene(GrabOne)
        Wait(1500)
        SetEntityVisible(MoneyObject, true, true)
        
        local GrabTwo = NetworkCreateSynchronisedScene(GetEntityCoords(CurrentTrolly), GetEntityRotation(CurrentTrolly), 2, false, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, GrabTwo, "anim@heists@ornate_bank@grab_cash", "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(GrabBag, GrabTwo, "anim@heists@ornate_bank@grab_cash", "bag_grab", 4.0, -8.0, 1)
        NetworkAddEntityToSynchronisedScene(CurrentTrolly, GrabTwo, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 4.0, -8.0, 1)
        NetworkStartSynchronisedScene(GrabTwo)
        Wait(37000)
        SetEntityVisible(MoneyObject, false, false)
        
        local GrabThree = NetworkCreateSynchronisedScene(GetEntityCoords(CurrentTrolly), GetEntityRotation(CurrentTrolly), 2, false, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, GrabThree, "anim@heists@ornate_bank@grab_cash", "exit", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(GrabBag, GrabThree, "anim@heists@ornate_bank@grab_cash", "bag_exit", 4.0, -8.0, 1)
        NetworkStartSynchronisedScene(GrabThree)
        
        local NewTrolley = CreateObject(769923921, GetEntityCoords(CurrentTrolly) + vector3(0.0, 0.0, - 0.985), true, false, false)
        SetEntityRotation(NewTrolley, GetEntityRotation(CurrentTrolly))
        while not NetworkHasControlOfEntity(CurrentTrolly) do
            Wait(10)
            NetworkRequestControlOfEntity(CurrentTrolly)
        end
        DeleteObject(CurrentTrolly)
        while DoesEntityExist(CurrentTrolly) do
            Wait(10)
            DeleteObject(CurrentTrolly)
        end
        PlaceObjectOnGroundProperly(NewTrolley)
        Wait(1800)
        DeleteEntity(GrabBag)
        DeleteObject(MoneyObject)

        -- Reward
        TriggerServerEvent('nyx-exchange:givetrollyreward')

    elseif trollyType == 'gold' then
        RequestModel("ch_prop_gold_bar_01a")
        RequestModel("ch_prop_gold_trolly_empty")
        local CurrentTrolly = GetClosestObjectOfType(coords.x, coords.y, coords.z, 1.0, 2007413986, false, false, false)
        local GoldObject = CreateObject(`ch_prop_gold_bar_01a`, GetEntityCoords(ped), true)
        SetEntityVisible(GoldObject, false, false)
        AttachEntityToEntity(GoldObject, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
        local GrabBag = CreateObject(`hei_p_m_bag_var22_arm_s`, GetEntityCoords(ped), true, false, false)
        
        local GrabOne = NetworkCreateSynchronisedScene(GetEntityCoords(CurrentTrolly), GetEntityRotation(CurrentTrolly), 2, false, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, GrabOne, "anim@heists@ornate_bank@grab_cash", "intro", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(GrabBag, GrabOne, "anim@heists@ornate_bank@grab_cash", "bag_intro", 4.0, -8.0, 1)
        SetPedComponentVariation(ped, 5, 0, 0, 0)
        NetworkStartSynchronisedScene(GrabOne)
        Wait(1500)
        SetEntityVisible(GoldObject, true, true)
        
        local GrabTwo = NetworkCreateSynchronisedScene(GetEntityCoords(CurrentTrolly), GetEntityRotation(CurrentTrolly), 2, false, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, GrabTwo, "anim@heists@ornate_bank@grab_cash", "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(GrabBag, GrabTwo, "anim@heists@ornate_bank@grab_cash", "bag_grab", 4.0, -8.0, 1)
        NetworkAddEntityToSynchronisedScene(CurrentTrolly, GrabTwo, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 4.0, -8.0, 1)
        NetworkStartSynchronisedScene(GrabTwo)
        Wait(37000)
        SetEntityVisible(GoldObject, false, false)
        
        local GrabThree = NetworkCreateSynchronisedScene(GetEntityCoords(CurrentTrolly), GetEntityRotation(CurrentTrolly), 2, false, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, GrabThree, "anim@heists@ornate_bank@grab_cash", "exit", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(GrabBag, GrabThree, "anim@heists@ornate_bank@grab_cash", "bag_exit", 4.0, -8.0, 1)
        NetworkStartSynchronisedScene(GrabThree)
        
        local NewTrolley = CreateObject(-1580618867, GetEntityCoords(CurrentTrolly) + vector3(0.0, 0.0, - 0.985), true, false, false)
        SetEntityRotation(NewTrolley, GetEntityRotation(CurrentTrolly))
        while not NetworkHasControlOfEntity(CurrentTrolly) do
            Wait(10)
            NetworkRequestControlOfEntity(CurrentTrolly)
        end
        DeleteObject(CurrentTrolly)
        while DoesEntityExist(CurrentTrolly) do
            Wait(10)
            DeleteObject(CurrentTrolly)
        end
        PlaceObjectOnGroundProperly(NewTrolley)
        Wait(1800)
        DeleteEntity(GrabBag)
        DeleteObject(GoldObject)

        -- Reward
        TriggerServerEvent('nyx-exchange:givetrollyreward')
    end

    -- evidence
    if math.random(1, 100) <= 65 and not QBCore.Functions.IsWearingGloves() then
        local pos = GetEntityCoords(PlayerPedId())
        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
    end

    LocalPlayer.state:set("inv_busy", false, true)
end



RegisterNetEvent('nyx-exchange:client:setpowerid', function(powid)
powerid=powid
end)
RegisterNetEvent('nyx-exchange:SmartLock', function(id, data,powid)
    local playerCoords =Config.PowerLocations[powid][id].animcoord 
    local usbCoords =Config.PowerLocations[powid][id].usbcoord
    local hasCops = lib.callback.await('nyx-exchange:hasenoughcops', false)
    local alarm_coords = Config.PowerLocations[powid][id].alarmcoord
    local item = QBCore.Functions.HasItem(data.requireditem, 1)
    --if exports["qb-smallresources"]:getdevelopermode() or (hasCops and exports['qb-cooldown']:isCooldown()) then
        if item then
            StartPhoneAnimation(playerCoords, usbCoords)
            powerid=powid
            TriggerServerEvent('nyx-exchange:server:setpowerid', powerid)
            TriggerServerEvent('nyx-exchange:server:setbusystate', id, true,powerid)
            QBCore.Functions.Progressbar("avalin_generator", "Disabling Smart Lock...", 4500, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function()
                for key, doorId in pairs(data.doorids) do
                    TriggerServerEvent('qb-doorlock:server:updateState', doorId, false, false, false, true, false, false)
                end
                FinishPhoneAnimation()
                exports["nxo-oui"]:Show('Cash Exchange',"Disable The Remote Door Locks")
                TriggerServerEvent('nyx-exchange:togglealarm', 'exchangealarm', true, alarm_coords)
                TriggerServerEvent("qb-cooldown:server:startglobaltimeout", 90)
                TriggerAlert()
            end, function()
                FinishPhoneAnimation()
                TriggerEvent("QBCore:Notify", "Cancelled", "error")
            end)
        else
            TriggerEvent("QBCore:Notify", "you missing something...", "error")
        end
    --else
        --TriggerEvent("QBCore:Notify", "Not Enough in This Time", "error")
    --end
end)


RegisterNetEvent('nyx-exchange:DoorLock', function(id, data)
    local playerCoords =Config.PowerLocations[powerid][id].animcoord 
    local usbCoords =Config.PowerLocations[powerid][id].usbcoord
    local item = QBCore.Functions.HasItem(data.requireditem, 1)
    if item then
        StartPhoneAnimation(playerCoords, usbCoords)
        local alphabet = exports['nxo-MiniGames']:alphabet(2, 20000)
        if alphabet then
            TriggerServerEvent('nyx-exchange:togglealarm', 'exchangealarm', false)
            TriggerServerEvent('nyx-exchange:server:setbusystate', id, true,powerid)
            for key, doorId in pairs(data.doorids) do
                TriggerServerEvent('qb-doorlock:server:updateState', doorId, false, false, false, true, false, false)
            end
            FinishPhoneAnimation()
            TriggerEvent("QBCore:Notify", "Alarm Disabled successfully", "success")
            exports["nxo-oui"]:Show('Strawberry Cash Exchange', "Disable The Door Locks")
        else
            TriggerEvent("QBCore:Notify", "Failed", "error")
            FinishPhoneAnimation()
        end
    else
        TriggerEvent("QBCore:Notify", "you are missing something...", "error")
    end
end)

RegisterNetEvent('nyx-exchange:HackSmartDoor', function(id, data)
        TriggerServerEvent('nyx-exchange:server:setbusystate', id, true,powerid)
        for key, doorId in pairs(data.doorids) do
            TriggerServerEvent('qb-doorlock:server:updateState', doorId, false, false, false, true, false, false)
        end
        
        TriggerEvent("QBCore:Notify", "Door Unlocked Successfully", "success")
        exports["nxo-oui"]:Close()
end)

RegisterNetEvent('nyx-exchange:StartHackSmartDoor', function(data)
    LaptopAnimation(data)
end)

RegisterNetEvent('nyx-exchange:client:setbusystate', function(id, state,pwid)
    if id == 'generator' then
        Config.PowerLocations[pwid][id].isBusy = state
    elseif id == 'alarm' then
        Config.PowerLocations[pwid][id].isBusy = state
    elseif id == 'doorhack' then
        Config.PowerLocations[pwid][id].isBusy = state
    end
end)

CreateThread(function()
    for key, data in pairs(Config.PowerLocations) do 

    local generatorData = Config.PowerLocations[key]['generator']
    exports['qb-interact']:AddInteraction({
        coords = generatorData.coords,
        distance = 1.5,
        interactDst = 1.0,
        id = 'exchange_power_power',
        options = {
            {
                label = 'Disable Smart Lock',
                action = function(entity, coords, args)
                    TriggerEvent("nyx-exchange:SmartLock", 'generator', generatorData,key)
                end,

                canInteract = function(entity, coords, args)
                    return not generatorData.isBusy and not generatorData.cut
                end,
            },
        }
    })
    local powerData = Config.PowerLocations[key]['alarm']
    exports['qb-interact']:AddInteraction({
        coords = powerData.coords,
        distance = 1.5,
        interactDst = 1.0,
        id = 'exchange_power_power2',
        options = {
            {
                label = 'Disable Door Locks',
                action = function(entity, coords, args)
                    TriggerEvent("nyx-exchange:DoorLock", 'alarm', powerData)
                end,

                canInteract = function(entity, coords, args)
                    return not powerData.isBusy and not powerData.cut and not generatorData.cut
                end,
            },
            {
                label = 'Restore Power',
                groups = {
                    ['police'] = 0, -- Jobname | Job grade
                    ['justice'] = 0,
                },
                action = function(entity, coords, args)
                    TriggerEvent('nyx-exchange:reset', key)
                end,

                canInteract = function(entity, coords, args)
                    return powerData.isBusy 
                end,
            },
        }
    })

    local doorData = Config.PowerLocations[key]['doorhack']
    exports['qb-interact']:AddInteraction({
        coords = doorData.coords,
        distance = 1.5,
        interactDst = 1.0,
        id = 'exchange_power_power4',
        options = {
            {
                label = 'Hack The Smart Door',
                action = function(entity, coords, args)
                    TriggerEvent('nyx-exchange:StartHackSmartDoor', doorData)
                end,

                canInteract = function(entity, coords, args)
                    return not doorData.isBusy and not doorData.cut and not powerData.cut
                end,
            },
        }
    })

    end
end)

RegisterNetEvent('nyx-exchange:client:SetTrollyBusy', function(index, state,pwid)
    Config.trollys[pwid][index].taken = state
end)


RegisterNetEvent('nyx-exchange:reset', function(id)
    for key, data in pairs(Config.PowerLocations[id]) do
        if type(data.doorids) == 'table' then
            for _, doorId in pairs(data.doorids) do
                if Config.DoorLock == 'ox' then
                    TriggerServerEvent('nyx-exchange:updateoxlocks', doorId, true)
                else
                    TriggerServerEvent('qb-doorlock:server:updateState', doorId, true, false, false, true, false, false)
                end
            end
        else
            if Config.DoorLock == 'ox' then
                TriggerServerEvent('nyx-exchange:updateoxlocks', data.doorids, true)
            else
                TriggerServerEvent('qb-doorlock:server:updateState', data.doorids, true, false, false, true, false, false)
            end
        end
        TriggerServerEvent('nyx-exchange:server:setbusystate', 'generator', false,id)
        TriggerServerEvent('nyx-exchange:server:setbusystate', 'alarm', false,id)
        TriggerServerEvent('nyx-exchange:server:setbusystate', 'doorhack', false,id)
    end
    TriggerServerEvent('nyx-exchange:togglealarm', 'exchangealarm', false)
    TriggerServerEvent('nyx-exchange:server:setpowerid', -1)
end)


AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        
        Wait(500)
        for k, v in pairs(Config.PowerLocations) do
        for key, data in pairs(v) do
            if type(data.doorids) == 'table' then
                for _, doorId in pairs(data.doorids) do
                    if Config.DoorLock == 'ox' then
                        TriggerServerEvent('nyx-exchange:updateoxlocks', doorId, true)
                    else
                        TriggerServerEvent('qb-doorlock:server:updateState', doorId, true, false, false, true, false, false)
                    end
                end
            else
                if Config.DoorLock == 'ox' then
                    TriggerServerEvent('nyx-exchange:updateoxlocks', data.doorids, true)
                else
                    TriggerServerEvent('qb-doorlock:server:updateState', data.doorids, true, false, false, true, false, false)
                end
            end
            TriggerServerEvent('nyx-exchange:server:setbusystate', 'generator', false,k)
            TriggerServerEvent('nyx-exchange:server:setbusystate', 'alarm', false,k)
            TriggerServerEvent('nyx-exchange:server:setbusystate', 'doorhack', false,k)
        end
    end
        TriggerServerEvent('nyx-exchange:togglealarm', 'exchangealarm', false)
       
    end
end)


CreateThread(function()
    for i, trolly in pairs(Config.trollys) do
        for k, v in pairs(trolly) do
            exports['qb-target']:AddBoxZone("trolly_" .. i, v.coords.xyz, 0.5, 0.5, {
                name = "trolly_" .. i,
                heading = 0, -- Adjust heading if necessary
                debugPoly = false,
                minZ = v.coords.z - 1.0,
                maxZ = v.coords.z + 1.0,
            }, {
                options = {
                    {
                        type = 'client',
                        label = 'Grab ' .. v.type,
                        icon = 'fas fa-hand-holding',
                        action = function()
                            LootTrolly(k)
                        end,
                        canInteract = function()
                            return not v.taken
                        end,
                    },
                },
                distance = 1.5
            })
        end
    end
end)
