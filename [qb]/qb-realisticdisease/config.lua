Config = {}

Config.DebugMode = false -- if true will enable debug mode  

Config.RemoveInjuresWhenRevive = true -- if true when player revive will remove all injures else doctor will need to heal player

Config.UseTarget = false -- if true will use target else will use closest player

Config.OnlyWithAim = true -- if true player will need to aim to damage player else will damage player without aim

Config.Jobs = { "ambulance", "police", "justice" } -- job name that can heal players

Config.ReverseHud = true -- if true will reverse hud else will not reverse hud

Config.GetNameFromSQL = true -- if true will get name from sql else will get name from server (ESX)
 
Config.EnableBleeding = false -- if true will enable bleeding

Config.BleedingHitDamage = 1 -- how many times player can bleed 

Config.BleedingPerMillisecond = 10000 -- how many seconds player will bleed

Config.BleedingMultiplier = 1 -- how many times player will bleed

Config.DisableSetPlayerHealthRecharge = false -- if true will disable recharge player health

Config.ExperimentalFeatures = false -- activating fall damage and traffic accident damage

Config.Theme = 'red' -- cyan, red
 
Config.Functions = {} -- dont touch this
 
 
Config.Functions.PlayAnim = function(lib, anim)
    RequestAnimDict(lib)
    while not HasAnimDictLoaded(lib) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
    Citizen.SetTimeout(2500, function()
        ClearPedTasksImmediately(PlayerPedId())
    end)
end
 
Config.Anims = {  -- you can change animations here
    ["check"] = {
        lib = 'amb@medic@standing@timeofdeath@enter',
        anim = 'enter',
    },
    ["heal"] = {
        lib = 'anim@mp_player_intcelebrationfemale@knuckle_crunch',
        anim = 'knuckle_crunch',
    },
    ["treat"] = {
        lib = 'anim@mp_player_intcelebrationfemale@knuckle_crunch',
        anim = 'knuckle_crunch',
    },
    ["fail"] = {
        lib = 'move_m@_idles@shake_off',
        anim = 'shakeoff_1',
    },
    ["revive"] = {
        lib = 'anim@mp_player_intcelebrationfemale@knuckle_crunch',
        anim = 'knuckle_crunch',
    },
}
 
Config.ItemsForHeal = {
    ["head"] = {
        "gauze", "pill", "surgical_gloves", "surgical_staple", "forceps", "syringe", "tape", "iodine", "bandage", "surgical_tray" 
    },
    ["body"] = {
        "gauze", "pill", "surgical_gloves", "surgical_staple", "forceps", "syringe", "tape", "iodine", "bandage", "surgical_tray" 
    },
    ["chest"] = {
        "gauze", "pill", "surgical_gloves", "surgical_staple", "forceps", "syringe", "tape", "iodine", "bandage", "surgical_tray" 
    },
    ["lleg"] = {
        "gauze", "pill", "surgical_gloves", "surgical_staple", "forceps", "syringe", "tape", "iodine", "bandage", "surgical_tray" 
    },
    ["rleg"] = {
        "gauze", "pill", "surgical_gloves", "surgical_staple", "forceps", "syringe", "tape", "iodine", "bandage", "surgical_tray" 
    },
    ["rarm"] = {
        "gauze", "pill", "surgical_gloves", "surgical_staple", "forceps", "syringe", "tape", "iodine", "bandage", "surgical_tray" 
    },
    ["larm"] = {
        "gauze", "pill", "surgical_gloves", "surgical_staple", "forceps", "syringe", "tape", "iodine", "bandage", "surgical_tray" 
    },
    ["rfoot"] = {
        "gauze", "pill", "surgical_gloves", "surgical_staple", "forceps", "syringe", "tape", "iodine", "bandage", "surgical_tray" 
    },
    ["lfoot"] = {
        "gauze", "pill", "surgical_gloves", "surgical_staple", "forceps", "syringe", "tape", "iodine", "bandage", "surgical_tray" 
    }
}

Config.Framework = ''

QBCore = exports['qb-core']:GetCoreObject()
    Config.Framework = 'QBCore'


Notify = function(typse, msg, title)
    QBCore.Functions.Notify(msg, typse)
end



Revive = function(playerId)
    TriggerServerEvent('hospital:server:RevivePlayer', playerId) 
    Config.Functions.PlayAnim(Config.Anims["revive"].lib, Config.Anims["revive"].anim)
end

Config.Lang = "en"

Config.Langs = {
    ["en"] = {
        ["succeed_treat"] = "You succeed to treat the patient",
        ["failed_treat"] = "You failed to treat the patient",
        ["no_money"] = "You don't have enough money to treat the patient!",
        ["no_skill"] = "We're sorry, but you're not skilled enough to perform this surgery!",
        ["no_item"] = "We're sorry, but you're not skilled enough to perform this surgery!",
        ["wrong"] = "We're sorry, but you're not skilled enough to perform this surgery!",
        ["start_bleeding"] = "Your bleeding has been stopped.",
        ["stop_bleeding"] = "The medicine wore off and you started bleeding again.",
        ["fail_bleed"] = "You're wounded again and you're bleeding!",
        ["traffic"] = "Traffic Accident",
        ["knifed"] = "Stabbed with knife",
        ["fdm"] = "Fall Damage",
        ["bullets"] = "Bullets",
        ["fist"] = "Fist attack",
        ["notdc"] = "Not detected!"
    }
}
 
Config.PlayerBones = {
    ['RFoot'] = 52301,
    ['LFoot'] = 14201,
    ['RKnee'] = 36864,
    ['LKnee'] = 63931,
    ['Head'] = 31086,
    ['RArm'] = 28252,
    ['LArm'] = 61163,
    ['Chest'] = 24818,
}

Config.BoneLabelText = {
    [52301] = { name = "RFoot", Label = "Right Foot", unity = 'RFoot' },
    [14201] = { name = "LFoot", Label = "Left Foot", unity = 'LFoot' },
    [36864] = { name = "RKnee", Label = "Right Leg", unity = 'RKnee' },
    [63931] = { name = "LKnee", Label = "Left Leg", unity = 'LKnee' },
    [31086] = { name = "Head", Label = "Head" , unity = 'Head' },
    [28252] = { name = "RArm", Label = "Right Arm", unity = 'RArm' },
    [61163] = { name = "LArm", Label = "Left Arm", unity = 'LArm' },
    [24818] = { name = "Chest", Label = "Body", unity = 'Chest' },
}
 
Config.items = {
    ["forceps"] = "forceps.png",
    ["gauze"] = "gauze.png",
    ["iodine"] = "iodine.png",
    ["pill"] = "pill.png",
    ["surgical_gloves"] = "surgical_gloves.png",
    ["surgical_staple"] = "surgical_staple.png",
    ["surgical_tray"] = "surgical_tray.png",
    ["syringe"] = "syringe.png",
    ["tape"] = "tape.png",
    ["bandage"] = "bandageg.png"
} -- import items your server database
 


Config.WeaponsLabel = { -- edit here for weapon labels
    [-1075685676] = "WEAPON_PISTOL_MK2",
    [126349499] = "WEAPON_SNOWBALL",
    [-270015777] = "WEAPON_ASSAULTSMG",
    [615608432] = "WEAPON_MOLOTOV",
    [2024373456] = "WEAPON_SMG_MK2",
    [-1810795771] = "WEAPON_POOLCUE",
    [-1813897027] = "WEAPON_GRENADE",
    [-598887786] = "WEAPON_MARKSMANPISTOL",
    [-1654528753] = "WEAPON_BULLPUPSHOTGUN",
    [-72657034] = "GADGET_PARACHUTE",
    [-102323637] = "WEAPON_BOTTLE",
    [2144741730] = "WEAPON_COMBATMG",
    [-1121678507] = "WEAPON_MINISMG",
    [-1652067232] = "WEAPON_SWEEPERSHOTGUN",
    [961495388] = "WEAPON_ASSAULTRIFLE_MK2",
    [-86904375] = "WEAPON_CARBINERIFLE_MK2",
    [-1786099057] = "WEAPON_BAT",
    [177293209] = "WEAPON_HEAVYSNIPER_MK2",
    [600439132] = "WEAPON_BALL",
    [1432025498] = "WEAPON_PUMPSHOTGUN_MK2",
    [-1951375401] = "WEAPON_FLASHLIGHT",
    [171789620] = "WEAPON_COMBATPDW",
    [1593441988] = "WEAPON_COMBATPISTOL",
    [-2009644972] = "WEAPON_SNSPISTOL_MK2",
    [2138347493] = "WEAPON_FIREWORK",
    [1649403952] = "WEAPON_COMPACTRIFLE",
    [-619010992] = "WEAPON_MACHINEPISTOL",
    [-952879014] = "WEAPON_MARKSMANRIFLE",
    [317205821] = "WEAPON_AUTOSHOTGUN",
    [-1420407917] = "WEAPON_PROXMINE",
    [-1045183535] = "WEAPON_REVOLVER",
    [94989220] = "WEAPON_COMBATSHOTGUN",
    [-1658906650] = "WEAPON_MILITARYRIFLE",
    [1198256469] = "WEAPON_RAYCARBINE",
    [2132975508] = "WEAPON_BULLPUPRIFLE",
    [1627465347] = "WEAPON_GUSENBERG",
    [984333226] = "WEAPON_HEAVYSHOTGUN",
    [1233104067] = "WEAPON_FLARE",
    [-1716189206] = "WEAPON_KNIFE",
    [940833800] = "WEAPON_STONE_HATCHET",
    [1305664598] = "WEAPON_GRENADELAUNCHER_SMOKE",
    [727643628] = "WEAPON_CERAMICPISTOL",
    [-1074790547] = "WEAPON_ASSAULTRIFLE",
    [-1169823560] = "WEAPON_PIPEBOMB",
    [324215364] = "WEAPON_MICROSMG",
    [-1834847097] = "WEAPON_DAGGER",
    [-1466123874] = "WEAPON_MUSKET",
    [-1238556825] = "WEAPON_RAYMINIGUN",
    [-1063057011] = "WEAPON_SPECIALCARBINE",
    [1470379660] = "WEAPON_GADGETPISTOL",
    [584646201] = "Ap Pistol",
    [-494615257] = "WEAPON_ASSAULTSHOTGUN",
    [-771403250] = "WEAPON_HEAVYPISTOL",
    [1672152130] = "WEAPON_HOMINGLAUNCHER",
    [338557568] = "WEAPON_PIPEWRENCH",
    [1785463520] = "WEAPON_MARKSMANRIFLE_MK2",
    [-1355376991] = "WEAPON_RAYPISTOL",
    [101631238] = "WEAPON_FIREEXTINGUISHER",
    [1119849093] = "WEAPON_MINIGUN",
    [883325847] = "WEAPON_PETROLCAN",
    [-102973651] = "WEAPON_HATCHET",
    [-275439685] = "WEAPON_DBSHOTGUN",
    [-1746263880] = "WEAPON_DOUBLEACTION",
    [-879347409] = "WEAPON_REVOLVER_MK2",
    [125959754] = "WEAPON_COMPACTLAUNCHER",
    [911657153] = "WEAPON_STUNGUN",
    [-2066285827] = "WEAPON_BULLPUPRIFLE_MK2",
    [-538741184] = "WEAPON_SWITCHBLADE",
    [100416529] = "WEAPON_SNIPERRIFLE",
    [-656458692] = "WEAPON_KNUCKLE",
    [-1768145561] = "WEAPON_SPECIALCARBINE_MK2",
    [1737195953] = "WEAPON_NIGHTSTICK",
    [2017895192] = "WEAPON_SAWNOFFSHOTGUN",
    [-2067956739] = "WEAPON_CROWBAR",
    [-1312131151] = "WEAPON_RPG",
    [-1568386805] = "WEAPON_GRENADELAUNCHER",
    [205991906] = "WEAPON_HEAVYSNIPER",
    [1834241177] = "WEAPON_RAILGUN",
    [-1716589765] = "WEAPON_PISTOL50",
    [736523883] = "WEAPON_SMG",
    [1317494643] = "WEAPON_HAMMER",
    [453432689] = "Pistol",
    [1141786504] = "WEAPON_GOLFCLUB",
    [-1076751822] = "WEAPON_SNSPISTOL",
    [-2084633992] = "WEAPON_CARBINERIFLE",
    [487013001] = "WEAPON_PUMPSHOTGUN",
    [-1168940174] = "WEAPON_HAZARDCAN",
    [-38085395] = "WEAPON_DIGISCANNER",
    [-1853920116] = "WEAPON_NAVYREVOLVER",
    [-37975472] = "WEAPON_SMOKEGRENADE",
    [-1600701090] = "WEAPON_BZGAS",
    [-1357824103] = "WEAPON_ADVANCEDRIFLE",
    [-581044007] = "WEAPON_MACHETE",
    [741814745] = "WEAPON_STICKYBOMB",
    [-608341376] = "WEAPON_COMBATMG_MK2",
    [137902532] = "WEAPON_VINTAGEPISTOL",
    [-1660422300] = "WEAPON_MG",
    [1198879012] = "WEAPON_FLAREGUN"
}


Config.Weapons = { -- do not edit here 
    [-1075685676] = "WEAPON_PISTOL_MK2",
    [126349499] = "WEAPON_SNOWBALL",
    [-270015777] = "WEAPON_ASSAULTSMG",
    [615608432] = "WEAPON_MOLOTOV",
    [2024373456] = "WEAPON_SMG_MK2",
    [-1810795771] = "WEAPON_POOLCUE",
    [-1813897027] = "WEAPON_GRENADE",
    [-598887786] = "WEAPON_MARKSMANPISTOL",
    [-1654528753] = "WEAPON_BULLPUPSHOTGUN",
    [-72657034] = "GADGET_PARACHUTE",
    [-102323637] = "WEAPON_BOTTLE",
    [2144741730] = "WEAPON_COMBATMG",
    [-1121678507] = "WEAPON_MINISMG",
    [-1652067232] = "WEAPON_SWEEPERSHOTGUN",
    [961495388] = "WEAPON_ASSAULTRIFLE_MK2",
    [-86904375] = "WEAPON_CARBINERIFLE_MK2",
    [-1786099057] = "WEAPON_BAT",
    [177293209] = "WEAPON_HEAVYSNIPER_MK2",
    [600439132] = "WEAPON_BALL",
    [1432025498] = "WEAPON_PUMPSHOTGUN_MK2",
    [-1951375401] = "WEAPON_FLASHLIGHT",
    [171789620] = "WEAPON_COMBATPDW",
    [1593441988] = "WEAPON_COMBATPISTOL",
    [-2009644972] = "WEAPON_SNSPISTOL_MK2",
    [2138347493] = "WEAPON_FIREWORK",
    [1649403952] = "WEAPON_COMPACTRIFLE",
    [-619010992] = "WEAPON_MACHINEPISTOL",
    [-952879014] = "WEAPON_MARKSMANRIFLE",
    [317205821] = "WEAPON_AUTOSHOTGUN",
    [-1420407917] = "WEAPON_PROXMINE",
    [-1045183535] = "WEAPON_REVOLVER",
    [94989220] = "WEAPON_COMBATSHOTGUN",
    [-1658906650] = "WEAPON_MILITARYRIFLE",
    [1198256469] = "WEAPON_RAYCARBINE",
    [2132975508] = "WEAPON_BULLPUPRIFLE",
    [1627465347] = "WEAPON_GUSENBERG",
    [984333226] = "WEAPON_HEAVYSHOTGUN",
    [1233104067] = "WEAPON_FLARE",
    [-1716189206] = "WEAPON_KNIFE",
    [940833800] = "WEAPON_STONE_HATCHET",
    [1305664598] = "WEAPON_GRENADELAUNCHER_SMOKE",
    [727643628] = "WEAPON_CERAMICPISTOL",
    [-1074790547] = "WEAPON_ASSAULTRIFLE",
    [-1169823560] = "WEAPON_PIPEBOMB",
    [324215364] = "WEAPON_MICROSMG",
    [-1834847097] = "WEAPON_DAGGER",
    [-1466123874] = "WEAPON_MUSKET",
    [-1238556825] = "WEAPON_RAYMINIGUN",
    [-1063057011] = "WEAPON_SPECIALCARBINE",
    [1470379660] = "WEAPON_GADGETPISTOL",
    [584646201] = "WEAPON_APPISTOL",
    [-494615257] = "WEAPON_ASSAULTSHOTGUN",
    [-771403250] = "WEAPON_HEAVYPISTOL",
    [1672152130] = "WEAPON_HOMINGLAUNCHER",
    [338557568] = "WEAPON_PIPEWRENCH",
    [1785463520] = "WEAPON_MARKSMANRIFLE_MK2",
    [-1355376991] = "WEAPON_RAYPISTOL",
    [101631238] = "WEAPON_FIREEXTINGUISHER",
    [1119849093] = "WEAPON_MINIGUN",
    [883325847] = "WEAPON_PETROLCAN",
    [-102973651] = "WEAPON_HATCHET",
    [-275439685] = "WEAPON_DBSHOTGUN",
    [-1746263880] = "WEAPON_DOUBLEACTION",
    [-879347409] = "WEAPON_REVOLVER_MK2",
    [125959754] = "WEAPON_COMPACTLAUNCHER",
    [911657153] = "WEAPON_STUNGUN",
    [-2066285827] = "WEAPON_BULLPUPRIFLE_MK2",
    [-538741184] = "WEAPON_SWITCHBLADE",
    [100416529] = "WEAPON_SNIPERRIFLE",
    [-656458692] = "WEAPON_KNUCKLE",
    [-1768145561] = "WEAPON_SPECIALCARBINE_MK2",
    [1737195953] = "WEAPON_NIGHTSTICK",
    [2017895192] = "WEAPON_SAWNOFFSHOTGUN",
    [-2067956739] = "WEAPON_CROWBAR",
    [-1312131151] = "WEAPON_RPG",
    [-1568386805] = "WEAPON_GRENADELAUNCHER",
    [205991906] = "WEAPON_HEAVYSNIPER",
    [1834241177] = "WEAPON_RAILGUN",
    [-1716589765] = "WEAPON_PISTOL50",
    [736523883] = "WEAPON_SMG",
    [1317494643] = "WEAPON_HAMMER",
    [453432689] = "WEAPON_PISTOL",
    [1141786504] = "WEAPON_GOLFCLUB",
    [-1076751822] = "WEAPON_SNSPISTOL",
    [-2084633992] = "WEAPON_CARBINERIFLE",
    [487013001] = "WEAPON_PUMPSHOTGUN",
    [-1168940174] = "WEAPON_HAZARDCAN",
    [-38085395] = "WEAPON_DIGISCANNER",
    [-1853920116] = "WEAPON_NAVYREVOLVER",
    [-37975472] = "WEAPON_SMOKEGRENADE",
    [-1600701090] = "WEAPON_BZGAS",
    [-1357824103] = "WEAPON_ADVANCEDRIFLE",
    [-581044007] = "WEAPON_MACHETE",
    [741814745] = "WEAPON_STICKYBOMB",
    [-608341376] = "WEAPON_COMBATMG_MK2",
    [137902532] = "WEAPON_VINTAGEPISTOL",
    [-1660422300] = "WEAPON_MG",
    [1198879012] = "WEAPON_FLAREGUN",
}

Config.WeaponsExtra = {}

for k,v in pairs(QBCore.Shared.Items) do
	if v.type == 'weapon' then
        Config.Weapons[GetHashKey(k)] = string.upper(v.name)
		Config.WeaponsLabel[GetHashKey(k)] = string.upper(v.name)
        Config.WeaponsExtra[GetHashKey(k)] = {name = v.name, label = v.label, weapontype = v.ammotype}
	end
end
 



Config.BoneGroups = {
    [52301] = {  -- RFoot
         20781,24806,52301
    },
    [14201] = {  -- LFoot
        2108,14201,35502,57717,65245
    },
    [36864] = {  -- RKnee
        16335,36864,51826
    },
    [63931] = {  -- LKnee
        23639,46078,58271,63931
    },
    [31086] = {  -- Head
        1356, 10706, 11174,12844,17188,17719,19336,20178,20279,20623,21550,25260,27474,29868,31086,35731,
        37193,39317,43536,45750,46240,47419,47495,49979,58331,61839,64729,65068
    },
    [28252] = {  -- RArm
        2992,6286,6442,26610,26611,26612,26613,26614,28252,28422,37119,
        40269,43810,57005, 
        58866,58867,58868,58869,58870,
        64016,64017,64064,64065,64080,64081,64096,64097,64112,64113
    },
    [61163] = {  -- LArm
        4089,4090,4137,4138,4153,4154,4169,4170,4185,4186,
        5232,18905,22711,36029,45509,60309,61007,61163
    },
    [24818] = {  -- Chest
        0, 11816,23553,24816,24817,24818,56604,57597
    }
}

Config.GetAlternativeBone = function(bone) 

--    if Config.OnlyAllowChestDamageForExperimental == true then 
--        return 24818
--    end

   for k,v in pairs(Config.PlayerBones) do 
       if v == bone then 
           return v
       end
   end

   for k,v in pairs(Config.BoneGroups) do
        for kk,vv in pairs(v) do
            if vv == bone then
                return k
            end
        end
   end
 
   return false
end