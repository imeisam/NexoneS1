QBCore = exports['qb-core']:GetCoreObject()
startjailbrake=false
ispowerplant=false
CreateThread(function()
    exports['qb-target']:AddBoxZone("prison_powerplant",vector3(2463.0, 1482.42, 36.2), 0.9, 0.5,  {
        name = "prison_powerplant",
        heading=270,
        minZ=36.4,
        maxZ=37.4
    }, {
        options = { 
            {
                type = "client",
                event = "qb-jail:client:powerplant",
                icon = 'fas fa-glass-water',
                label = 'Power Off'
            }
        },
        distance = 1.5,
    })
end)
RegisterCommand('blk', function(source)
    TriggerServerEvent('qb-weathersync:server:zonebloackout', 'sandy',true)
end)


RegisterNetEvent('qb-jail:client:powerplant', function()
    -- Config.poweplanttimeout
    success= exports["five-repairkit"]:Minigame(math.random(2,3))
    if success then
        QBCore.Functions.TriggerCallback('qb-jail:server:started', function(result)
            if result then   QBCore.Functions.Notify('Jail Break Already started...', 'error', 2500) return end

            startjailbrake=true
            ispowerplant=true
            QBCore.Functions.Notify('Now Sandy Power Off...', 'success', 2500)
            TriggerServerEvent('qb-weathersync:server:zonebloackout', 'sandy',true)
            CreateThread(function()
                 Wait(Config.poweplanttimeout)
                 TriggerServerEvent('qb-weathersync:server:zonebloackout', 'sandy',false)
                 ispowerplant=false
            end)
        end)
    else
        local ped = PlayerPedId()
        RequestAnimDict('ragdoll@human')
        if QBCore.Functions.GetPlayerData().charinfo.gender == 0 then --male
            TriggerServerEvent("InteractSound_SV:PlayWithinDistance",4.0, "electricshockMale", 0.2)
        else
            TriggerServerEvent("InteractSound_SV:PlayWithinDistance",4.0, "electricshockFemale", 0.2)
        end
        Wait(500)
        SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) -10)
        TaskPlayAnim(ped, "ragdoll@human", 'electrocute', 8.0, 8.0, -1, 0, 0.0, false, false, false)
        Wait(GetAnimDuration("ragdoll@human", 'electrocute') * 1000)
        SetPedToRagdoll(ped, 5000, 5000, 0, 2, 0, 0)
    end
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone("prison_jailbreak1",Config.jailbreak[1].coord,Config.jailbreak[1].h,Config.jailbreak[1].w, {
        name = "prison_jailbreak1",
        heading = Config.jailbreak[1].heading,
        debugPoly = false,
        minZ =Config.jailbreak[1].minZ,
        maxZ = Config.jailbreak[1].maxZ
    }, {
        options = { 
            {
                type = "client",
                event = "qb-jail:client:onedoorThermite",
                icon = 'fas fa-glass-water',
                label = 'Use Thermite',
                index=1,
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone("prison_jailbreak3",Config.jailbreak[3].coord,Config.jailbreak[3].h,Config.jailbreak[3].w, {
        name = "prison_jailbreak3",
        heading = Config.jailbreak[3].heading,
        debugPoly = false,
        minZ =Config.jailbreak[3].minZ,
        maxZ = Config.jailbreak[3].maxZ
    }, {
        options = { 
            {
                type = "client",
                event = "qb-jail:client:onedoorThermite",
                icon = 'fas fa-glass-water',
                label = 'Use Thermite',
                index=3,
            }
        },
        distance = 1.5,
    })
end)

triggerAntiHeli = function()
    if not Config.AntiHelicopter then return end
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if GetPedInVehicleSeat(veh, -1) == ped then
        if IsPedInAnyPlane(ped) or IsPedInAnyHeli(ped) then
            QBCore.Functions.TriggerCallback('qb-jail:server:SpawnAntiHelicopterGuards', function(netIds)
                Wait(1000)
                for i=1, #netIds do
                    local guard = NetworkGetEntityFromNetworkId(netIds[i])
                    SetPedDropsWeaponsWhenDead(guard, false)
                    SetEntityInvincible(guard, true)
                    SetEntityMaxHealth(guard, 500)
                    SetEntityHealth(guard, 500)
                    SetCanAttackFriendly(guard, false, true)
                    SetPedCombatAttributes(guard, 46, true)
                    SetPedCombatAttributes(guard, 0, false)
                    SetPedCombatAbility(guard, 100)
                    SetPedAsCop(guard, true)
                    SetPedRelationshipGroupHash(guard, `HATES_PLAYER`)
                    SetPedAccuracy(guard, 100)
                    SetPedFleeAttributes(guard, 0, 0)
                    SetPedKeepTask(guard, true)
                end
            end)
        end
    end
end

local AlertCops = function()
    exports['qb-dispatch']:PrisonBreak()
end

RegisterNetEvent('qb-jail:client:onedoorThermite', function(data)
    QBCore.Functions.TriggerCallback('police:GetCops', function(cops)
        if cops < Config.jailbreakpoliceneed then
            QBCore.Functions.Notify('Not enough cops..', 'error', 2500)
            return
        else
            -- if QBCore.Functions.HasItem(Config.jailbreak[data.index].item) then
            if true then
                TriggerServerEvent('qb-jail:server:RemoveThermite',data.index)
                ThermiteCharge(data.index)
                -- exports['ps-ui']:Thermite(function(success)
                    -- if success then
                        TriggerServerEvent('qb-jail:server:ThermiteHit', data.index)
                        ThermiteEffect(data.index)
                        Wait(3000)
                        if data.index==1 then
                            AlertCops()
                            TriggerServerEvent('qb-jail:server:Lockdownalarm',true)
                        end
                       
                        if data.index==3 then
                            TriggerServerEvent('qb-jail:server:jailbreakactive')
                        end
                    -- end
                --  end, 20, 1, 3)
            else
                QBCore.Functions.Notify('You are missing the correct item', 'error', 2500)
            end
        end
    end)
    
end)
ThermiteEffect = function(index)
    
    RequestAnimDict('anim@heists@ornate_bank@thermal_charge')
    while not HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge') do Wait(10) end
    local ped = PlayerPedId()
    local ptfx =Config.jailbreak[index].thermitecoord.xyz
    TriggerServerEvent('thermite:server:thermitefire',Config.jailbreak[index].thermiteanim)
    TaskPlayAnim(ped, 'anim@heists@ornate_bank@thermal_charge', 'cover_eyes_intro', 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
    TaskPlayAnim(ped, 'anim@heists@ornate_bank@thermal_charge', 'cover_eyes_loop', 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
   
    TriggerServerEvent('qb-doorlock:server:updateState',Config.jailbreak[index].doorname, false, false, false, true, false, false)
end


ThermiteCharge = function(index)

  

    RequestAnimDict('anim@heists@ornate_bank@thermal_charge')
    RequestModel('hei_p_m_bag_var22_arm_s')
    RequestNamedPtfxAsset('scr_ornate_heist')
    while not HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge') and not HasModelLoaded('hei_p_m_bag_var22_arm_s') and not HasNamedPtfxAssetLoaded('scr_ornate_heist') do Wait(0) end
    local ped = PlayerPedId()
    local pos = Config.jailbreak[index].thermitecoord
    SetEntityHeading(ped, pos.w)

    local playerPed = PlayerPedId()
    local position = GetEntityCoords(playerPed, false)
    local endPosition = position + GetEntityForwardVector(playerPed)
    local raycast = StartShapeTestSweptSphere(position.x, position.y, position.z, endPosition.x, endPosition.y, endPosition.z, 0.2, 16, playerPed, 4)
    local retval, hit, endCoords, surfaceNormal, entity = GetShapeTestResult(raycast)
    
    
    Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(ped)))
    local bagscene = NetworkCreateSynchronisedScene(pos.x, pos.y, pos.z, rotx, roty, rotz, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, pos.x, pos.y, pos.z,  true,  true, false)
    SetEntityCollision(bag, false, true)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local charge = CreateObject(`hei_prop_heist_thermite`, x, y, z + 0.2,  true,  true, true)
    SetEntityCollision(charge, false, true)
    AttachEntityToEntity(charge, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    NetworkAddPedToSynchronisedScene(ped, bagscene, 'anim@heists@ornate_bank@thermal_charge', 'thermal_charge', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, 'anim@heists@ornate_bank@thermal_charge', 'bag_thermal_charge', 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(bagscene)
    Wait(5000)
    DetachEntity(charge, 1, 1)
    FreezeEntityPosition(charge, true)
    DeleteObject(bag)
    NetworkStopSynchronisedScene(bagscene)
    CreateThread(function()
        Wait(15000)
        DeleteEntity(charge)
    end)
end

RegisterNetEvent('qb-jail:client:Lockdownalarm', function(state)
    if state then
        local alarmIpl = GetInteriorAtCoordsWithType(1787.004, 2593.1984, 45.7978, "int_prison_main")
        RefreshInterior(alarmIpl)
        EnableInteriorProp(alarmIpl, "prison_alarm")
        CreateThread(function()
            while not PrepareAlarm("PRISON_ALARMS") do
                Wait(100)
            end
            StartAlarm("PRISON_ALARMS", true)
        end)
    else
        local alarmIpl = GetInteriorAtCoordsWithType(1787.004, 2593.1984, 45.7978, "int_prison_main")
        RefreshInterior(alarmIpl)
        DisableInteriorProp(alarmIpl, "prison_alarm")
        CreateThread(function()
            while not PrepareAlarm("PRISON_ALARMS") do
                Wait(100)
            end
            StopAllAlarms(true)
        end)
    end
end)


RegisterNetEvent("thermite:client:thermitefire") --Starts the fire here.
AddEventHandler("thermite:client:thermitefire", function(coords)
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Wait(1)
    end
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", coords.x,coords.y, coords.z,0.0, 0.0, false, false, false, false)
    Wait(5000)
    StopParticleFxLooped(effect, 0)
end)
