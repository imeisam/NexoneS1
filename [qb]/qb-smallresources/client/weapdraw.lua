local Holster = false
local HasWeapon = false

-- Types: DutyBelt, Leg, Front
local Clothes = {
	[GetHashKey("mp_m_freemode_01")] = {
		[5] = {[112] = 'DutyBelt', [113] = 'DutyBelt', [114] = 'DutyBelt', [115] = 'DutyBelt', [116] = 'DutyBelt', [117] = 'DutyBelt',  [118] = 'DutyBelt', [119] = 'DutyBelt'},--bag
		[7] = {[226] = 'DutyBelt', [227] = 'DutyBelt', [228] = 'DutyBelt', [229] = 'Leg', [235] = 'DutyBelt'}, ---scarf
	},
	[GetHashKey("mp_f_freemode_01")] = {
		[5] = {[112] = 'DutyBelt', [113] = 'DutyBelt', [114] = 'DutyBelt', [115] = 'DutyBelt', [116] = 'DutyBelt', [117] = 'DutyBelt',  [118] = 'DutyBelt', [119] = 'DutyBelt'},--bag
		[7] = {[189] = 'DutyBelt', [191] = 'DutyBelt', [192] = 'DutyBelt', [190] = 'Leg', [193] = 'Leg'}, ---scarf
	},
	[GetHashKey("kira")] = {
        [8] = {[8] = 'Leg', [9] = 'Leg'},
		[4] = {[10] = 'Leg'},
    },
}

RegisterNetEvent('weapons:client:SetCurrentWeapon', function(weapon, noAnim)
	local ped = PlayerPedId()
	if weapon then
		HasWeapon = true
	else
		if HasWeapon then
			HasWeapon = false
		else
			return
		end
	end
	if not noAnim and not Holster and not IsEntityDead(ped) and not IsPedInParachuteFreeFall(ped) and not IsPedFalling(ped) and (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) then
		Holster = true
		DisableShoot()
		local HolsterType = HolsterClothes()
		if HolsterType == 'DutyBelt' then
			LoadAnimDict("rcmjosh4")
			TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 3.0, 3.0, -1, 50, 0, 0, 0)
			Wait(600)
			StopAnimTask(ped, "rcmjosh4", "josh_leadout_cop2", 3.0)
		elseif HolsterType == 'Leg' then
			LoadAnimDict("reaction@male_stand@big_variations@d")
			TaskPlayAnim(ped, "reaction@male_stand@big_variations@d", "react_big_variations_m", 3.0, 3.0, -1, 50, 0.325, 0, 0)
			Wait(700)
			StopAnimTask(ped, "reaction@male_stand@big_variations@d", "react_big_variations_m", 3.0)
		elseif HolsterType == 'Front' then
			if weapon then
				LoadAnimDict("combat@combat_reactions@pistol_1h_hillbilly")
				TaskPlayAnim(ped, "combat@combat_reactions@pistol_1h_hillbilly", "0", 3.0, 3.0, -1, 50, 0.325, 0, 0)
				Wait(700)
				StopAnimTask(ped, "combat@combat_reactions@pistol_1h_hillbilly", "0", 3.0)
			else
				LoadAnimDict("combat@combat_reactions@pistol_1h_gang")
				TaskPlayAnim(ped, "combat@combat_reactions@pistol_1h_gang", "0", 3.0, 3.0, -1, 50, 0.325, 0, 0)
				Wait(600)
				StopAnimTask(ped, "combat@combat_reactions@pistol_1h_gang", "0", 3.0)
			end
		else
			local animName = "outro"
			if weapon then
				animName = "intro"
			end
			LoadAnimDict("reaction@intimidation@1h")
			TaskPlayAnim(ped, "reaction@intimidation@1h", animName, 8.0, 3.0, -1, 50, 0, 0, 0)
			Wait(2400)
			StopAnimTask(ped, "reaction@intimidation@1h", animName, 8.0)
		end
		Holster = false
	end
end)

function HolsterClothes()
	local ped = PlayerPedId()
	local PedModel = Clothes[GetEntityModel(ped)]
	if PedModel then
		for k,v in pairs(PedModel) do
			local clothes = v[GetPedDrawableVariation(ped, k)]
			if clothes then
				return clothes
			end
		end
	end
	return false
end

function DisableShoot()
	CreateThread(function()
		while Holster do
			Wait(5)
			DisableControlAction(0, 25, true)
			DisablePlayerFiring(PlayerPedId(), true)
		end
	end)
end

function LoadAnimDict(dict)
	if HasAnimDictLoaded(dict) then return end
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end