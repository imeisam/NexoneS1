CreateThread(function()
	SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), 0.1) -- Melee
	SetWeaponDamageModifier(GetHashKey("WEAPON_BOTTLE"), 0.3) -- Melee
	SetWeaponDamageModifier(GetHashKey("WEAPON_FLASHLIGHT"), 0.3) -- Melee
	SetWeaponDamageModifier(GetHashKey("WEAPON_KNUCKLE"), 0.4) -- Melee
	SetWeaponDamageModifier(GetHashKey("WEAPON_NIGHTSTICK"), 0.4) -- Melee
	SetWeaponDamageModifier(GetHashKey("WEAPON_HAMMER"), 0.4) -- Melee
	SetWeaponDamageModifier(GetHashKey("WEAPON_CROWBAR"), 0.4) -- Melee
	SetWeaponDamageModifier(GetHashKey("WEAPON_POOLCUE"), 0.4) -- Melee
	SetWeaponDamageModifier(GetHashKey("WEAPON_GOLFCLUB"), 0.4) -- Melee
	SetWeaponDamageModifier(GetHashKey("WEAPON_BAT"), 0.4) -- Melee
	SetWeaponDamageModifier(GetHashKey("WEAPON_KNIFE"), 0.6) -- Melee
	SetWeaponDamageModifier(GetHashKey("WEAPON_DAGGER"), 0.6) -- Melee
	SetWeaponDamageModifier(GetHashKey("WEAPON_SWITCHBLADE"), 0.6) -- Melee
	SetWeaponDamageModifier(GetHashKey("WEAPON_MACHETE"), 0.7) -- Melee
	SetWeaponDamageModifier(GetHashKey("WEAPON_HATCHET"), 0.7) -- Melee
	SetWeaponDamageModifier(GetHashKey("WEAPON_SMOKEGRENADE"), 0.1) -- Utility
	SetWeaponDamageModifier(GetHashKey("WEAPON_CASH"), 0.1) -- Utility
	SetWeaponDamageModifier(GetHashKey("WEAPON_SHOE"), 0.2) -- Utility
	SetWeaponDamageModifier(GetHashKey("WEAPON_HIT_BY_WATER_CANNON"), 0.0) -- Fire Truck Cannon
	while true do
		Wait(0)
		SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
		SetPedSuffersCriticalHits(PlayerPedId(), false)
	end
end)