-- Variables

local ParachuteEquiped = false
local healing = false
local hunger = 100
local thirst = 100
local overozeNum = 0
local nightvision = false
local Mast = false

-- Functions

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

function EquipParachuteAnim()
    loadAnimDict("clothingshirt")
    TaskPlayAnim(PlayerPedId(), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end

function HealOxy()
    if not healing then
        healing = true
    else
        return
    end

    local count = 9
    while count > 0 do
        Wait(1000)
        count = count - 1
        SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 6)
    end
    healing = false
end
RegisterNetEvent('consumables:client:runDrinkAlcohol', function()
    DrinkAlcohol()
end)
function DrinkAlcohol()
    if Mast then return end
    Mast = true
    CreateThread(function()
        Wait(15000)
        while Mast do
            RequestAnimSet("move_m@drunk@moderatedrunk")
            while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
              Wait(10)
            end
            SetPedMovementClipset(PlayerPedId(), "move_m@drunk@moderatedrunk", true)
            SetTimecycleModifier("spectator5")
            SetPedMotionBlur(PlayerPedId(), true)
            SetPedIsDrunk(PlayerPedId(), true)
            Wait(5000)
        end
        ClearTimecycleModifier()
        ResetScenarioTypesEnabled()
        ResetPedMovementClipset(PlayerPedId(), 0)
        SetPedIsDrunk(PlayerPedId(), false)
        SetPedMotionBlur(PlayerPedId(), false)
        TriggerEvent('animation:ResettoOldWalk')
    end)
    SetTimeout(5*60*1000, function()
        Mast = false
    end)
end

function MethBagEffect()
    local startStamina = 8
    TrevorEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
    while startStamina > 0 do
        Wait(1000)
        if math.random(5, 100) < 10 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(5, 100) < 51 then
            TrevorEffect()
        end
    end
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

function TrevorEffect()
    StartScreenEffect("DrugsTrevorClownsFightIn", 3.0, 0)
    Wait(3000)
    StartScreenEffect("DrugsTrevorClownsFight", 3.0, 0)
    Wait(3000)
	StartScreenEffect("DrugsTrevorClownsFightOut", 3.0, 0)
	StopScreenEffect("DrugsTrevorClownsFight")
	StopScreenEffect("DrugsTrevorClownsFightIn")
	StopScreenEffect("DrugsTrevorClownsFightOut")
end

function EcstasyEffect()
    local startStamina = 30
    SetFlash(0, 0, 500, 7000, 500)
    while startStamina > 0 do
        Wait(1000)
        startStamina = startStamina - 1
        RestorePlayerStamina(PlayerId(), 1.0)
        if math.random(1, 100) < 51 then
            SetFlash(0, 0, 500, 7000, 500)
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
        end
    end
    if IsPedRunning(PlayerPedId()) then
        SetPedToRagdoll(PlayerPedId(), math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
    end
end

function CrackBaggyEffect()
    local startStamina = 8
    local ped = PlayerPedId()
    AlienEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.3)
    while startStamina > 0 do
        Wait(1000)
        if math.random(1, 100) < 10 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(1, 100) < 60 and IsPedRunning(ped) then
            SetPedToRagdoll(ped, math.random(1000, 2000), math.random(1000, 2000), 3, 0, 0, 0)
        end
        if math.random(1, 100) < 51 then
            AlienEffect()
        end
    end
    if IsPedRunning(ped) then
        SetPedToRagdoll(ped, math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
    end
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

function CokeBaggyEffect()
    local startStamina = 20
    local ped = PlayerPedId()
    AlienEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.1)
    while startStamina > 0 do
        Wait(1000)
        if math.random(1, 100) < 20 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(1, 100) < 10 and IsPedRunning(ped) then
            SetPedToRagdoll(ped, math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
        end
        if math.random(1, 300) < 10 then
            AlienEffect()
            Wait(math.random(3000, 6000))
        end
    end
    if IsPedRunning(ped) then
        SetPedToRagdoll(ped, math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
    end
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

function AlienEffect()
    StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
    Wait(math.random(5000, 8000))
    StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
    Wait(math.random(5000, 8000))
    StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
    StopScreenEffect("DrugsMichaelAliensFightIn")
    StopScreenEffect("DrugsMichaelAliensFight")
    StopScreenEffect("DrugsMichaelAliensFightOut")
end

function AddrenalinEffect()
    local ped = PlayerId()
    if overozeNum == 0 then
        SetTimeout(300000, function()
            overozeNum = 0
        end)
    end
    if math.random(1, 100) <= overozeNum then
        QBCore.Functions.Notify('Overdozed', 'error')
        TriggerEvent('hospital:client:KillPlayer')
        return
    end
    overozeNum = overozeNum + 20
    exports['qb-buffs']:StaminaBuffEffect(60000, 1.2)
end

-- Events

RegisterNetEvent('hud:client:UpdateNeeds', function(newHunger, newThirst) -- Triggered in qb-core
    hunger = newHunger
    thirst = newThirst
end)

RegisterNetEvent('consumables:client:callAnimation', function(emote)
    TriggerEvent('animations:client:EmoteCommandStart', {emote})
end)

RegisterNetEvent('consumables:client:Eat', function(itemName, slot)
    QBCore.Functions.Progressbar("eat_something", "Eating..", 3000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("QBCore:Server:RemoveItem", itemName, 1, slot)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + ConsumeablesEat[itemName])
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end)
end)

RegisterNetEvent('consumables:client:foodcontainer', function(itemName)
    TriggerEvent('inventory:client:SetCurrentStash', 'package_'..itemName)
    TriggerServerEvent('inventory:server:OpenInventory', 'stash', 'package_'..itemName, {
        maxweight =50000,
        slots = 20,
    })
end)

RegisterNetEvent('consumables:client:Drink', function(itemName, slot)
    QBCore.Functions.Progressbar("drink_something", "Drinking..", 3000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("QBCore:Server:RemoveItem", itemName, 1, slot)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + ConsumeablesDrink[itemName])
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end)
end)

RegisterNetEvent('consumables:client:Job', function(itemName, slot, hunger, thirst, stress)
    QBCore.Functions.Progressbar("drink_something", "Food..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("QBCore:Server:RemoveItem", itemName, 1, slot)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        if hunger then
            TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + hunger)
        end
        if thirst then
            TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + thirst)
        end
        if stress then
            TriggerServerEvent('hud:server:RelieveStress', stress)
        end
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end)
end)

RegisterNetEvent('consumables:client:DrinkAlcohol', function(itemName, slot)
    QBCore.Functions.Progressbar("drink_alcohol", "Drinking liquor..", math.random(3000, 6000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        TriggerServerEvent("QBCore:Server:RemoveItem", itemName, 1, slot)
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] - 5)
        TriggerServerEvent('hud:server:RelieveStress', 20)
        DrinkAlcohol()
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end)
end)

RegisterNetEvent('consumables:client:Cokebaggy', function()
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("snort_coke", "Quick sniff..", math.random(5000, 8000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "switch@trevor@trev_smoking_meth",
        anim = "trev_smoking_meth_loop",
        flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "cokebaggy", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["cokebaggy"], "remove")
        TriggerEvent("evidence:client:SetStatus", "widepupils", 200)
        CokeBaggyEffect()
    end, function() -- Cancel
        StopAnimTask(ped, "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('consumables:client:Crackbaggy', function()
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("snort_coke", "Smoking crack..", math.random(7000, 10000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "switch@trevor@trev_smoking_meth",
        anim = "trev_smoking_meth_loop",
        flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "crack_baggy", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["crack_baggy"], "remove")
        TriggerEvent("evidence:client:SetStatus", "widepupils", 300)
        CrackBaggyEffect()
    end, function() -- Cancel
        StopAnimTask(ped, "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('consumables:client:EcstasyBaggy', function()
    QBCore.Functions.Progressbar("use_ecstasy", "Pops Pills", 3000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mp_suicide",
		anim = "pill",
		flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "xtcbaggy", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["xtcbaggy"], "remove")
        EcstasyEffect()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:oxy', function()
    QBCore.Functions.Progressbar("use_oxy", "Healing", 2000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mp_suicide",
		anim = "pill",
		flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "oxy", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["oxy"], "remove")
        ClearPedBloodDamage(PlayerPedId())
		HealOxy()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        QBCore.Functions.Notify("Canceled", "error")
    end)
end)

RegisterNetEvent('consumables:client:meth', function()
    QBCore.Functions.Progressbar("snort_meth", "Smoking Ass Meth", 1500, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "switch@trevor@trev_smoking_meth",
        anim = "trev_smoking_meth_loop",
        flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "meth", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["meth"], "remove")
        TriggerEvent("evidence:client:SetStatus", "widepupils", 300)
		TriggerEvent("evidence:client:SetStatus", "agitated", 300)
        MethBagEffect()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        QBCore.Functions.Notify("Canceled..", "error")
	end)
end)

RegisterNetEvent('consumables:client:UseCigarBox', function(slot)
    QBCore.Functions.Progressbar("smoke_cigar", "Open Cigarette Box..", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('inventory:server:breakItem', 'cigar_box', 10, slot)
        TriggerServerEvent("qb-smallresources:server:addcigar")
    end)
end)

RegisterNetEvent('consumables:client:UseCigaret', function()
    QBCore.Functions.Progressbar("smoke_cigar", "Lighting Cigar..", 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("QBCore:Server:RemoveItem", "cigarette", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["cigarette"], "remove")
        if not IsPedInAnyVehicle(PlayerPedId(), false) then
            TriggerEvent('animations:client:EmoteCommandStart', {"smoke"})
        end
        TriggerServerEvent('hud:server:RelieveStress', math.random(3, 6))
        if hunger < 98 then
            TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", hunger + 2)
        end
        if thirst > 6 then
            TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", thirst - 5)
        end
    end)
end)

RegisterNetEvent('consumables:client:UseCigar', function()
    QBCore.Functions.Progressbar("smoke_cigar", "Lighting Cigar..", 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("QBCore:Server:RemoveItem", "cigarette", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["cigarette"], "remove")
        if not IsPedInAnyVehicle(PlayerPedId(), false) then
            TriggerEvent('animations:client:EmoteCommandStart', {"cigar"})
        end
        TriggerServerEvent('hud:server:RelieveStress', math.random(3, 6))
        if hunger < 98 then
            TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", hunger + 2)
        end
        if thirst > 6 then
            TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", thirst - 5)
        end
    end)
end)

RegisterNetEvent('consumables:client:UseParachute', function()
    EquipParachuteAnim()
    QBCore.Functions.Progressbar("use_parachute", "parachute using..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        local ped = PlayerPedId()
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["parachute"], "remove")
        GiveWeaponToPed(ped, `GADGET_PARACHUTE`, 1, false)
        ParachuteEquiped = true
        TaskPlayAnim(ped, "clothingshirt", "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    end)
end)

RegisterNetEvent('consumables:client:ResetParachute', function()
    if ParachuteEquiped then
        EquipParachuteAnim()
        QBCore.Functions.Progressbar("reset_parachute", "Packing parachute..", 5000, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            local ped = PlayerPedId()
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["parachute"], "add")
            local ParachuteRemoveData = {
                outfitData = {
                    ["bag"] = { item = 0, texture = 0} -- Removing Parachute Clothing
                }
            }
            TriggerEvent('qb-clothing:client:loadOutfit', ParachuteRemoveData)
            TaskPlayAnim(ped, "clothingshirt", "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
            TriggerServerEvent("qb-smallpenis:server:AddParachute")
            ParachuteEquiped = false
        end)
    else
        local ParachuteRemoveData = {
            outfitData = {
                ["bag"] = { item = 0, texture = 0} -- Removing Parachute Clothing
            }
        }
        TriggerEvent('qb-clothing:client:loadOutfit', ParachuteRemoveData)
        local ped = PlayerPedId()
        TaskPlayAnim(ped, "clothingshirt", "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    end
end)

RegisterNetEvent('consumables:client:UseArmor', function()
    if GetPedArmour(PlayerPedId()) == 50 then QBCore.Functions.Notify('You already have enough armor on!', 'error') return end
    ExecuteCommand('e adjust')
    QBCore.Functions.Progressbar("use_armor", "Putting on the body armour..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        ExecuteCommand('e c')
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["armor"], "remove")
        TriggerServerEvent("QBCore:Server:RemoveItem", "armor", 1)
        SetPedArmour(PlayerPedId(), 50)
    end, function() -- Cancel
        ExecuteCommand('e c')
        QBCore.Functions.Notify("Canceled..", "error")
	end)
end)

RegisterNetEvent('consumables:client:UseHeavyArmor', function()
    -- if GetPedArmour(PlayerPedId()) == 50 then QBCore.Functions.Notify('You already have enough armor on!', 'error') return end
    ExecuteCommand('e adjust')
    local ped = PlayerPedId()
    local PlayerData = QBCore.Functions.GetPlayerData()
    QBCore.Functions.Progressbar("use_heavyarmor", "Putting on body armour..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        ExecuteCommand('e c')
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["heavyarmor"], "remove")
        TriggerServerEvent("QBCore:Server:RemoveItem", "heavyarmor", 1)
        SetPedArmour(ped, 100)
    end, function() -- Cancel
        ExecuteCommand('e c')
        QBCore.Functions.Notify("Canceled..", "error")
	end)
end)

RegisterNetEvent("consumables:client:UseAdrenalin", function()
    QBCore.Functions.Progressbar("zadan_adrenalin", "Using ...", 3000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
		animDict = "anim@amb@business@weed@weed_inspecting_high_dry@",
		anim = "weed_inspecting_high_base_inspector",
		flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "anim@amb@business@weed@weed_inspecting_high_dry@", "weed_inspecting_high_base_inspector", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "adrenalin", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["adrenalin"], "remove")
        AddrenalinEffect()
    end, function() -- Cancel
        StopAnimTask(ped, "anim@amb@business@weed@weed_inspecting_high_dry@", "weed_inspecting_high_base_inspector", 1.0)
        QBCore.Functions.Notify("Canceled..", "error")
	end)
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    if nightvision then
        local _hasNightv = false
        for _, item in pairs(val.items) do
            if item.name == "nightvision" then
                _hasNightv = true
                break
            end
        end
        if not _hasNightv then
            TriggerEvent('qb-nightvision:client:use')
        end
    end
end)

RegisterNetEvent('qb-nightvision:client:use', function()
    local player = PlayerPedId()
    if nightvision then
        loadAnimDict("mp_masks@standard_car@ds@")
        TaskPlayAnim(player, "mp_masks@standard_car@ds@", "put_on_mask", 2.0, 2.0, 800, 51, 0, false, false, false)
        Wait(1000)
        SetNightvision(false)
        nightvision = false
    else
        loadAnimDict("mp_masks@standard_car@ds@")
        TaskPlayAnim(player, "mp_masks@standard_car@ds@", "put_on_mask", 2.0, 2.0, 800, 51, 0, false, false, false)
        SetPedComponentVariation(player, 1, 132, 0, 0)
        Wait(1000)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "nightvision", 0.25)
        SetNightvision(true)
        nightvision = true
    end
end)

RegisterNetEvent('weed:client:useWidow', function(slot)
    ExecuteCommand('e smoke3')
    QBCore.Functions.Progressbar("use_weed_widow", "Using Widow ..", math.random(5000, 8000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        ExecuteCommand('e c')
        TriggerServerEvent("QBCore:Server:RemoveItem", "widow_weed", 1, slot)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["widow_weed"], "remove")
        exports['qb-buffs']:AddXrayBuff(60000)
    end, function()
        ExecuteCommand('e c')
    end)
end)

RegisterNetEvent('weed:client:usePurple', function(slot)
    ExecuteCommand('e smoke3')
    QBCore.Functions.Progressbar("use_weed_purple", "Using Purple ..", math.random(5000, 8000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        ExecuteCommand('e c')
        TriggerServerEvent("QBCore:Server:RemoveItem", "purple_weed", 1, slot)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["purple_weed"], "remove")
        exports['qb-buffs']:AddArmorBuff(15000, 23)
    end, function()
        ExecuteCommand('e c')
    end)
end)

RegisterNetEvent('weed:client:useSkunk', function(slot)
    ExecuteCommand('e smoke3')
    QBCore.Functions.Progressbar("use_weed_skunk", "Using Skunk ..", math.random(5000, 8000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        ExecuteCommand('e c')
        TriggerServerEvent("QBCore:Server:RemoveItem", "skunk_weed", 1, slot)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["skunk_weed"], "remove")
        exports['qb-buffs']:AddStressBuff(20000, 20)
    end, function()
        ExecuteCommand('e c')
    end)
end)

RegisterNetEvent('weed:client:useKush', function(slot)
    ExecuteCommand('e smoke3')
    QBCore.Functions.Progressbar("use_weed_kush", "Using Kush ..", math.random(5000, 8000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        ExecuteCommand('e c')
        TriggerServerEvent("QBCore:Server:RemoveItem", "kush_weed", 1, slot)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["kush_weed"], "remove")
        exports['qb-buffs']:SwimmingBuffEffect(30000, 1.49)
    end, function()
        ExecuteCommand('e c')
    end)
end)

RegisterNetEvent('weed:client:useAmnesia', function(slot)
    ExecuteCommand('e smoke3')
    QBCore.Functions.Progressbar("use_weed_amnesia", "Using Amnesia ..", math.random(5000, 8000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        ExecuteCommand('e c')
        TriggerServerEvent("QBCore:Server:RemoveItem", "amnesia_weed", 1, slot)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["amnesia_weed"], "remove")
        exports['qb-buffs']:StaminaBuffEffect(60000, 1)
    end, function()
        ExecuteCommand('e c')
    end)
end)

RegisterNetEvent('ring:client:useCitrine', function(slot)
    ExecuteCommand('e knucklecrunch')
    QBCore.Functions.Progressbar("use_ring", "Using Citrine ..", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        ExecuteCommand('e c')
        TriggerServerEvent("QBCore:Server:RemoveItem", "citrine", 1, slot)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["citrine"], "remove")
        exports['qb-buffs']:RecoilBuffEffect(720000)
    end, function()
        ExecuteCommand('e c')
    end)
end)

RegisterNetEvent('ring:client:useSapphire', function(slot)
    ExecuteCommand('e knucklecrunch')
    QBCore.Functions.Progressbar("use_ring", "Using Sapphire ..", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        ExecuteCommand('e c')
        TriggerServerEvent("QBCore:Server:RemoveItem", "sapphire-ring", 1, slot)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["sapphire-ring"], "remove")
        exports['qb-buffs']:HackBuffEffect(300000)
    end, function()
        ExecuteCommand('e c')
    end)
end)

RegisterNetEvent('ring:client:useRuby', function(slot)
    ExecuteCommand('e knucklecrunch')
    QBCore.Functions.Progressbar("use_ring", "Using Ruby ..", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        ExecuteCommand('e c')
        TriggerServerEvent("QBCore:Server:RemoveItem", "ruby-ring", 1, slot)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["ruby-ring"], "remove")
        exports['qb-buffs']:CuffBuffEffect(360000)
    end, function()
        ExecuteCommand('e c')
    end)
end)