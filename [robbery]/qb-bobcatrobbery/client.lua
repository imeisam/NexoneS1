local QBCore = exports['qb-core']:GetCoreObject()
local CurrentCops = 0
local bomba = nil
local hostage = nil

function Hostage()
    if not hostage then
        local hash = GetHashKey("cs_casey")
        while not HasModelLoaded(hash) do
            RequestModel(hash)
            Wait(20)
        end
        hostage = CreatePed("PED_TYPE_CIVFEMALE", "cs_casey", Config.Hostage, false, false)
        SetBlockingOfNonTemporaryEvents(hostage, true)
        SetPedDiesWhenInjured(hostage, false)
        SetPedCanPlayAmbientAnims(hostage, true)
        SetPedCanRagdollFromPlayerImpact(hostage, false)
        SetEntityInvincible(hostage, false)
        RequestAnimDict('random@arrests@busted')
        while not HasAnimDictLoaded('random@arrests@busted') do
            RequestAnimDict('random@arrests@busted')
            Wait(10)
        end
        TaskPlayAnim(hostage, 'random@arrests@busted', 'idle_a', 8.0, 8.0, -1, 33, 0, 0, 0, 0)
        exports['qb-target']:AddTargetEntity(hostage, {
            options = {
                {
                    type = "server",
                    event = "qb-bobcat:server:boom",
                    icon = "fas fa-bomb",
                    label = "Blast the Door!",
                },
            },
            distance = 1.5
        })
    end
end

function DeleteBomb()
    if bomba then
        DeleteObject(bomba)
        bomba = nil
    end
end

function ThermiteAnim(coords)
    local ped = PlayerPedId()
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Wait(50)
    end
    SetEntityHeading(ped, 170.52)
    Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(coords.x, coords.y, coords.z, rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), coords.x, coords.y, coords.z, true, true, false)
    SetEntityCollision(bag, false, true)
    NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.2, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    NetworkStartSynchronisedScene(bagscene)
    Wait(1500)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    DeleteBomb()
    bomba = CreateObject(GetHashKey("hei_prop_heist_thermite"), x, y, z + 0.3,  true,  true, true)
    SetEntityCollision(bomba, false, true)
    AttachEntityToEntity(bomba, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    Wait(2000)
    DeleteObject(bag)
    DetachEntity(bomba, 1, 1)
    FreezeEntityPosition(bomba, true)
end

function CreatePeds()
    local ped = GetHashKey("mp_s_m_armoured_01")
    while not HasModelLoaded(ped) do
        RequestModel(ped)
        Wait(20)
    end
    AddRelationshipGroup("bobcatsecurity")
    for k,v in ipairs(Config.Peds) do
        bobcatped = CreatePed(5, ped, v.x, v.y, v.z - 2.0, 88.00, true, false)
        SetPedArmour(bobcatped, 100)
		SetPedAsEnemy(bobcatped, true)
		GiveWeaponToPed(bobcatped, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
        SetPedRelationshipGroupHash(bobcatped, 'bobcatsecurity')
		TaskCombatPed(bobcatped, PlayerPedId())
		SetPedAccuracy(bobcatped, 100)
		SetPedDropsWeaponsWhenDead(bobcatped, false)
    end
end

function UpdateIPL(state)
    local interiorid = GetInteriorAtCoords(883.4142, -2282.372, 30.44168)
    if state then
        ActivateInteriorEntitySet(interiorid, "np_prolog_broken")
        RemoveIpl(interiorid, "np_prolog_broken")
        DeactivateInteriorEntitySet(interiorid, "np_prolog_clean")
        RefreshInterior(interiorid)
    else
        ActivateInteriorEntitySet(interiorid, "np_prolog_clean")
        RemoveIpl(interiorid, "np_prolog_clean")
        DeactivateInteriorEntitySet(interiorid, "np_prolog_broken")
        RefreshInterior(interiorid)
    end
end

function AddLoot(k, v)
    exports["qb-target"]:AddCircleZone("bobcat_loot_"..k, v, 1.0, {
        name = "bobcat_loot_"..k,
        useZ = true,
        debugPoly=false
        }, {
            options = {
                {
                    type = "server",
                    event = "qb-bobcat:server:collectWeapon",
                    location = k,
                    icon = "fas fa-box",
                    label = "Loot Weapon!",
                },
            },
        distance = 1.5
    })
end

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

RegisterNetEvent('thermite:UseThermite', function(item)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local door1 = #(pos -  Config.Doors[1].loc)
    local door2 = #(pos - Config.Doors[2].loc)
    if door1 < 1.5 then
        QBCore.Functions.TriggerCallback("qb-bobcat:server:checkState", function(Do)
            if not Do then
                if exports["qb-smallresources"]:getdevelopermode() or CurrentCops >= 10 then
                    if exports['qb-cooldown']:isCooldown() then
                        if math.random(1, 100) >= 50 then
                            TriggerServerEvent('hud:Server:GainStress', math.random(5,8))
                        end
                        ThermiteAnim(Config.Doors[1].loc)
                        local success = exports['bd-minigames']:Thermite(20, 7, 7, 50)
                        if success then
                            exports['qb-dispatch']:BobcatRobbery()
                            TriggerServerEvent("qb-cooldown:server:startglobaltimeout", 90)
                            TriggerServerEvent("qb-bobcat:server:particle", Config.Doors[1].ptfx, item.slot)
                            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["thermite"], "remove")
                            SetTimeout(5000, function()
                                TriggerServerEvent('qb-bobcat:server:state', 'ThermiteOne', true)
                                TriggerServerEvent('qb-bobcat:server:state', 'Thermitetwo', nil)
                                TriggerServerEvent('qb-doorlock:server:updateState', 'bobcat-enterbobcat', false, nil, nil, true, false, false)
                                DeleteBomb()
                            end)
                        else
                            TriggerServerEvent('inventory:server:breakItem', 'thermite', 50, item.slot)
                            TriggerServerEvent('qb-bobcat:server:state', 'ThermiteOne', nil)
                            DeleteBomb()
                        end
                    end
                else
                    QBCore.Functions.Notify("Not Enough Cops", "error")
                end
            else
                QBCore.Functions.Notify("Bobcat is Empty", "error")
            end
        end, 'ThermiteOne')
    elseif door2 < 1.5 then
        QBCore.Functions.TriggerCallback("qb-bobcat:server:checkState", function(Do)
            if Do then
                if math.random(1, 100) <= 50 then
                    TriggerServerEvent('hud:Server:GainStress', math.random(5,8))
                end
                ThermiteAnim(Config.Doors[2].loc)
                local success = exports['bd-minigames']:Thermite(20, 7, 7, 50)
                if success then
                    TriggerServerEvent("qb-bobcat:server:particle", Config.Doors[2].ptfx, item.slot)
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["thermite"], "remove")
                    SetTimeout(5000, function()
                        TriggerServerEvent('qb-bobcat:server:state', 'ThermiteOne', nil)
                        TriggerServerEvent('qb-bobcat:server:state', 'Thermitetwo', true)
                        TriggerServerEvent('qb-doorlock:server:updateState', 'bobcat-firstdoor', false, nil, nil, true, false, false)
                        DeleteBomb()
                    end)
                else
                    TriggerServerEvent('inventory:server:breakItem', 'thermite', 50, item.slot)
                    TriggerServerEvent('qb-bobcat:server:state', 'Thermitetwo', nil)
                    DeleteBomb()
                end
            end
        end, 'ThermiteOne')
    end
end)

RegisterNetEvent("qb-bobcat:client:particle", function(coords)
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Wait(1)
    end
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", coords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Wait(4000)
    StopParticleFxLooped(effect, 0)
end)

RegisterNetEvent('qb-bobcat:client:firstCard', function()
    local ped = PlayerPedId()
    local door = #(GetEntityCoords(ped) - Config.CardLocations[1])
    if door < 2.0 then
        local success = exports['bd-minigames']:PinCracker(4, 50)
        if success then
            CreatePeds()
            TriggerServerEvent('qb-doorlock:server:updateState', 'bobcat-seconddoor', false, nil, nil, true, false, false)
            TriggerServerEvent("QBCore:Server:RemoveItem", "security_card", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["security_card"], "remove")
            TriggerServerEvent('qb-bobcat:server:state', 'Thermitetwo', nil)
            TriggerServerEvent('qb-bobcat:server:state', 'FirstCard', true)
        end
    end
end)

RegisterNetEvent('qb-bobcat:client:boom', function()
    exports['qb-target']:RemoveTargetEntity(hostage)
    ClearPedTasks(hostage)
	TaskGoStraightToCoord(hostage, 869.2078, -2292.60, 30.441, 150.0, -1, 265.61, 0)
	Wait(5000)
	TaskGoStraightToCoord(hostage, 893.3309, -2294.90, 30.441, 150.0, -1, 350.61, 0)
	Wait(13000)
    TaskGoStraightToCoord(hostage, 894.6337, -2284.97, 32.441, 150.0, -1, 82.56, 0)
	Wait(7500)
	RequestAnimDict('weapons@projectile@grenade_str')
    while not HasAnimDictLoaded('weapons@projectile@grenade_str') do
        RequestAnimDict('weapons@projectile@grenade_str')
        Wait(10)
    end
    TaskPlayAnim(hostage, 'weapons@projectile@grenade_str', 'throw_h_fb_backward', 8.0, 8.0, -1, 33, 0, 0, 0, 0)
	Wait(1000)
	AddExplosion(890.7849, -2284.88, 30.441, 32, 150000.0, true, false, 4.0)
	AddExplosion(894.0084, -2284.90, 30.580, 32, 150000.0, true, false, 4.0)
    hostage = nil
    UpdateIPL(true)
end)

RegisterNetEvent('qb-bobcat:client:removeLoot', function(k)
    exports["qb-target"]:RemoveZone("bobcat_loot_"..k)
end)

RegisterNetEvent('qb-bobcat:client:resetBobcat', function(full)
    if full then
        UpdateIPL(false)
        for k,v in ipairs(Config.loot) do
            AddLoot(k, v)
        end
        Hostage()
    else
        TriggerServerEvent('qb-doorlock:server:updateState', 'bobcat-enterbobcat', true, nil, nil, true, false, false)
        TriggerServerEvent('qb-doorlock:server:updateState', 'bobcat-firstdoor', true, nil, nil, true, false, false)
        TriggerServerEvent('qb-doorlock:server:updateState', 'bobcat-seconddoor', true, nil, nil, true, false, false)
    end
end)

CreateThread(function()
    QBCore.Functions.TriggerCallback("qb-bobcat:server:checkState", function(Do)
        if Do then
            UpdateIPL(true)
        else
            UpdateIPL(false)
            Hostage()
        end
    end, 'boom')
    QBCore.Functions.TriggerCallback("qb-bobcat:client:getLoots", function(Table)
        for k,v in ipairs(Config.loot) do
            if Table[k] then
                AddLoot(k, v)
            end
        end
    end)
end)