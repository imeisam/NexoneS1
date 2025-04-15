Citizen.CreateThread(function()
	while true do
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.5) 
	Wait(0)
	end
end)


function getdevelopermode()
 return developermode
end
exports("getdevelopermode",getdevelopermode)
CreateThread(function()
	
    while true do
        for _, sctyp in next, BlacklistedScenarios['TYPES'] do
            SetScenarioTypeEnabled(sctyp, false)
        end
        for _, scgrp in next, BlacklistedScenarios['GROUPS'] do
            SetScenarioGroupEnabled(scgrp, false)
        end
		Wait(10000)
    end
end)

AddEventHandler("populationPedCreating", function(x, y, z)
	Wait(500)	-- Give the entity some time to be created
	local _, handle = GetClosestPed(x, y, z, 1.0) -- Get the entity handle
	SetPedDropsWeaponsWhenDead(handle, false)
end)

CreateThread(function()
	SetCanAttackFriendly(PlayerPedId(), true, false)
    NetworkSetFriendlyFireOption(true)
	StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
	SetAudioFlag("DisableFlightMusic", true)
	SetAudioFlag("PoliceScannerDisabled", true)
	SetGarbageTrucks(false)
	SetCreateRandomCops(false)
	SetCreateRandomCopsNotOnScenarios(false)
	SetCreateRandomCopsOnScenarios(false)
	DistantCopCarSirens(false)
	CancelCurrentPoliceReport()
	RemoveVehiclesFromGeneratorsInArea(335.2616 - 300.0, -1432.455 - 300.0, 46.51 - 300.0, 335.2616 + 300.0, -1432.455 + 300.0, 46.51 + 300.0) -- central los santos medical center
	RemoveVehiclesFromGeneratorsInArea(441.8465 - 500.0, -987.99 - 500.0, 30.68 -500.0, 441.8465 + 500.0, -987.99 + 500.0, 30.68 + 500.0) -- police station mission row
	RemoveVehiclesFromGeneratorsInArea(316.79 - 300.0, -592.36 - 300.0, 43.28 - 300.0, 316.79 + 300.0, -592.36 + 300.0, 43.28 + 300.0) -- pillbox
	RemoveVehiclesFromGeneratorsInArea(-2150.44 - 500.0, 3075.99 - 500.0, 32.8 - 500.0, -2150.44 + 500.0, -3075.99 + 500.0, 32.8 + 500.0) -- military
	RemoveVehiclesFromGeneratorsInArea(-1108.35 - 300.0, 4920.64 - 300.0, 217.2 - 300.0, -1108.35 + 300.0, 4920.64 + 300.0, 217.2 + 300.0) -- nudist
	RemoveVehiclesFromGeneratorsInArea(-458.24 - 300.0, 6019.81 - 300.0, 31.34 - 300.0, -458.24 + 300.0, 6019.81 + 300.0, 31.34 + 300.0) -- police station paleto
	RemoveVehiclesFromGeneratorsInArea(1854.82 - 300.0, 3679.4 - 300.0, 33.82 - 300.0, 1854.82 + 300.0, 3679.4 + 300.0, 33.82 + 300.0) -- police station sandy
	RemoveVehiclesFromGeneratorsInArea(-724.46 - 300.0, -1444.03 - 300.0, 5.0 - 300.0, -724.46 + 300.0, -1444.03 + 300.0, 5.0 + 300.0) -- REMOVE CHOPPERS WOW
	RemoveVehiclesFromGeneratorsInArea(-577.55 - 300.0, -1118.40 - 300.0, 22.37 - 300.0, -577.55 + 300.0, -1118.40 + 300.0, 22.37 + 300.0) -- UWU Area
	RemoveVehiclesFromGeneratorsInArea(-577.55 - 300.0, -1118.40 - 300.0, 22.37 - 300.0, -577.55 + 300.0, -1118.40 + 300.0, 22.37 + 300.0) -- UWU Area
	RemoveVehiclesFromGeneratorsInArea(327.34 - 300.0,-1474.21 - 300.0, 29.79 - 300.0, 327.34 + 300.0,-1474.21 + 300.0, 29.79 + 300.0) -- md Area
	RemoveVehiclesFromGeneratorsInArea(390.33 - 300.0,-1445.35 - 300.0,  29.41- 300.0, 390.33 + 300.0,-1445.35 + 300.0,  29.41+ 300.0) -- md Area
end)

CreateThread(function()
    while true do
		
		HideHudComponentThisFrame(1) -- 1 : WANTED_STARS
		HideHudComponentThisFrame(2) -- 2 : WEAPON_ICON
		HideHudComponentThisFrame(3) -- 3 : CASH
		HideHudComponentThisFrame(4) -- 4 : MP_CASH
		HideHudComponentThisFrame(6) -- 6 : VEHICLE_NAME
		HideHudComponentThisFrame(7) -- 7 : AREA_NAME
		HideHudComponentThisFrame(9) -- 9 : STREET_NAME
		HideHudComponentThisFrame(13) -- 13 : CASH_CHANGE
		HideHudComponentThisFrame(16) -- 16 : Radio
		HideHudComponentThisFrame(17) -- 17 : SAVING_GAME
		DisableControlAction(0,36,true)
		HideHudComponentThisFrame(14) -- 14 : RETICLE
		HideHudComponentThisFrame(19) -- 19 : WEAPON_WHEEL
		HideHudComponentThisFrame(20) -- 20 : WEAPON_WHEEL_STATS
		HideHudComponentThisFrame(21) -- 21 : HUD_COMPONENTS
		HideHudComponentThisFrame(22) -- 22 : HUD_WEAPONS
		DisableControlAction(1, 37)
		DisplayAmmoThisFrame(true)
		Wait(4)
    end
end)

CreateThread(function()
	while true do
		for i = 1, 13 do
			EnableDispatchService(i, false) --ambulance,police car not spawn
		end
        DisablePlayerVehicleRewards(PlayerId())
        RemoveAllPickupsOfType(0xDF711959)
        RemoveAllPickupsOfType(0xF9AFB48F)
        RemoveAllPickupsOfType(0xA9355DCD)
		SetParkedVehicleDensityMultiplierThisFrame(Density['parked'])
        SetVehicleDensityMultiplierThisFrame(Density['vehicle'])
        SetRandomVehicleDensityMultiplierThisFrame(Density['multiplier'])
        SetPedDensityMultiplierThisFrame(Density['peds'])
        SetScenarioPedDensityMultiplierThisFrame(Density['scenario'], Density['scenario'])
		Wait(0)
	end
end)

local lastped = nil
CreateThread(function()
	SetPedCanLosePropsOnDamage(PlayerPedId(), false, 0)
	while true do
		if PlayerPedId() ~= lastped then
			lastped = PlayerPedId()
			SetPedCanLosePropsOnDamage(PlayerPedId(), false, 0)
		end
		Wait(5000)
	end
end)

CreateThread(function()
	while true do
		Wait(1)
		local ped = PlayerPedId()
		if IsPedBeingStunned(ped) then
			SetPedMinGroundTimeForStungun(ped, math.random(4000, 7000))
		else
			Wait(1000)
		end
	end
end)


CreateThread(function()
	SetMaxWantedLevel(0)
	DisableIdleCamera(true)
end)

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local weapon = GetSelectedPedWeapon(ped)
		if weapon ~= `WEAPON_UNARMED` then
			if IsPedArmed(ped, 6) then
				DisableControlAction(1, 140, true)
				DisableControlAction(1, 141, true)
				DisableControlAction(1, 142, true)
			end
			if weapon == `WEAPON_FIREEXTINGUISHER` then
				if IsPedShooting(ped) then
					SetPedInfiniteAmmo(ped, true, `WEAPON_FIREEXTINGUISHER`)
				end
			end
		else
			Wait(500)
		end
        Wait(7)
    end
end)

CreateThread(function()
    local pedPool = GetGamePool('CPed')
    for _, v in pairs(pedPool) do
        SetPedDropsWeaponsWhenDead(v, false)
    end
end)

Citizen.CreateThread(function()
    while true do
      InvalidateIdleCam()
      N_0x9e4cfff989258472()
      Wait(10000)
    end
end)

CreateThread(function()
    while true do
        Wait(500)
		-- RemoveVehiclesFromGeneratorsInArea(327.34 - 300.0,-1474.21 - 300.0, 29.79 - 300.0, 327.34 + 300.0,-1474.21 + 300.0, 29.79 + 300.0) -- md Area
		-- RemoveVehiclesFromGeneratorsInArea(390.33 - 300.0,-1445.35 - 300.0,  29.41- 300.0, 390.33 + 300.0,-1445.35 + 300.0,  29.41+ 300.0) -- md Area
		-- RemoveVehiclesFromGeneratorsInArea(316.79 - 300.0, -592.36 - 300.0, 43.28 - 300.0, 316.79 + 300.0, -592.36 + 300.0, 43.28 + 300.0) -- pillbox
		RemoveVehiclesFromGeneratorsInArea(-44.25 - 300.0,-1098.62 - 300.0,  26.42- 300.0, -44.25 + 300.0,-1098.62 + 300.0,  26.42+ 300.0) -- cardelaer Area

        local ped = PlayerPedId()
        if not IsPedInAnyVehicle(ped, false) then
            if IsPedUsingActionMode(ped) then
                SetPedUsingActionMode(ped, -1, -1, 1)
            end
        else
            Wait(3000)
        end
    end
end)

local oldstyle =nil
CreateThread( function()
    while true do
        local ped = PlayerPedId()
        Wait(100)
        if IsPedInAnyVehicle(ped, false) then
            Wait(1000)
        else
            if GetPedConfigFlag(ped, 388) then
				if GetFollowPedCamViewMode() ~= 4 then
					if not oldstyle then
						oldstyle = GetFollowPedCamViewMode()
					end
						SetFollowPedCamViewMode(4)
				end
			else
				if oldstyle then
					SetFollowPedCamViewMode(oldstyle)
					oldstyle=nil
				end
					
            end
        end
    end
end)

SetRelationshipBetweenGroups(1, `AMBIENT_GANG_HILLBILLY`, `PLAYER`)
SetRelationshipBetweenGroups(1, `AMBIENT_GANG_BALLAS`, `PLAYER`)
SetRelationshipBetweenGroups(1, `AMBIENT_GANG_MEXICAN`, `PLAYER`)
SetRelationshipBetweenGroups(1, `AMBIENT_GANG_FAMILY`, `PLAYER`)
SetRelationshipBetweenGroups(1, `AMBIENT_GANG_MARABUNTE`, `PLAYER`)
SetRelationshipBetweenGroups(1, `AMBIENT_GANG_SALVA`, `PLAYER`)
SetRelationshipBetweenGroups(1, `AMBIENT_GANG_LOST`, `PLAYER`)
SetRelationshipBetweenGroups(1, `GANG_1`, `PLAYER`)
SetRelationshipBetweenGroups(1, `GANG_2`, `PLAYER`)
SetRelationshipBetweenGroups(1, `GANG_9`, `PLAYER`)
SetRelationshipBetweenGroups(1, `GANG_10`, `PLAYER`)
SetRelationshipBetweenGroups(1, `FIREMAN`, `PLAYER`)
SetRelationshipBetweenGroups(1, `MEDIC`, `PLAYER`)
SetRelationshipBetweenGroups(1, `COP`, `PLAYER`)
SetRelationshipBetweenGroups(1, `PRISONER`, `PLAYER`)
