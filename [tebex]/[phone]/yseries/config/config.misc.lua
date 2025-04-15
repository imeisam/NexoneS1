Config = Config or {}

Config.CityName = "Los Santos" -- The name that's being used in the weather app etc.
Config.RealTime = true         -- if true, the time will use real life time depending on where the user lives, if false, the time will be the ingame time.

Config.KeepInput = true        -- Keep input when nui is focused (meaning you can walk around while the phone is open)

Config.MouseLook = { 1, 2, 3, 4, 5, 6 }

Config.MainControlActions = { 263, 264, 257, 140, 141, 142, 143, 177, 200, 202, 322, 245, 37, 192, 204, 211, 349, 14,
    15, 16, 17, 81, 82, 24, 47, 58, 91, 68, 69, 92 }

-- example: 100$;
-- Choose the formatting of the currency.
-- {amount}$ - *default - !!! DO NOT CHANGE THE LABEL INSIDE THE BRAKETS !!!
Config.CurrencyFormat = "{amount}$"
Config.CurrencySymbol = "$"  -- Used as prefix/suffix in some places.
Config.CurrencyLabel = 'usd' -- Used as prefix/suffix in some places.

Config.GroupMembersLimit = 4 -- The limit of members in a group.

Config.Biometrics = {}
Config.Biometrics.CheckForGloves = false -- Whether to check for gloves when using biometrics. Default *false. - Adjust that in `client\custom\functions\biometrics.lua`

Config.UpdateUserPhoneNumber = false     -- Whether to update the phone number in the users/players(charinfo) table in the database when the phone is setup(won't work for unique phones). Default *false.

Config.Maps = {}
Config.Maps.RealTimeLocation = false   -- Whether to sync the location of the player with the map app in realtime.
Config.Maps.SyncLocationTimeout = 1500 -- The time in ms that the location of the player will be synced with the map app. Default *1500ms == 1.5s.

-- !! Only for QBCore/QBX !!
Config.Death = {}
Config.Death.CheckDeathTimeout = 2500 -- Check for death. (default 2500ms == 2.5s). !! Only for QBCore/QBox !!
Config.Death.LastStand = true         -- Enable phone usage on last stand. !! Only for QBCore/QBox !!
-- !! Only for QBCore/QBX !!

Config.YBuy = Config.YBuy or {}
Config.YBuy.Categories = { -- Categories for the YBuy app when creating a new ad.
    {
        value = "realestate",
        label = "Real Estate"
    },
    {
        value = "vehicles",
        label = "Vehicles"
    },
    {
        value = "electronics",
        label = "Electronics"
    },
    {
        value = "services",
        label = "Services"
    },
    {
        value = "other",
        label = "Other"
    }
}

Config.QuickShare = {}

-- Whether to show the full name of the player when sharing a contact. Default *true.
-- If false, only the ID will be shown.
Config.QuickShare.ShowFullName = true

-- If lore is *false the android/ios real branding icons will be used.
Config.LoreEnabled = true

Config.FlashlightSync = false         -- Whether to sync the flashlight with other players. A performance impact may appear. Default *false.
Config.FlashlightDistance = 5         -- The distance in meters that the flashlight will be visible to other players. Default *5m.

Config.HideHudWhileUsingCamera = true -- Whether you want yo hide the minimap while using the camera. Default *true.

Config.ValidConfigOptions = {}
Config.ValidConfigOptions.Framework = {
    ['auto'] = true,
    ['esx'] = true,
    ['qbox'] = true,
    ['qb'] = true,
    ['standalone'] = true,
    ['ox'] = true
}

Config.ValidConfigOptions.Inventory = {
    ['auto'] = true,
    ['ox_inventory'] = true,
    ['qb-inventory'] = true,
    ['lj-inventory'] = true,
    ['ps-inventory'] = true,
    ['qs-inventory'] = true,
    ['codem-inventory'] = true,
    ['core_inventory'] = true,
    ['tgiann-inventory'] = true,
}

Config.ValidConfigOptions.Items = {
    ["phone"] = true,
    ["yphone"] = true,
    ["yflipphone"] = true,
    ["yphone_natural"] = true,
    ["yphone_black"] = true,
    ["yphone_white"] = true,
    ["yphone_blue"] = true,
    ["yphone_fold_black"] = true,
    ["yflip_mint"] = true,
    ["yflip_gold"] = true,
    ["yflip_graphite"] = true,
    ["yflip_lavender"] = true,
    ["y24_black"] = true,
    ["y24_silver"] = true,
    ["y24_violet"] = true,
    ["y24_yellow"] = true,
    ["yfold_black"] = true
}

Config.ValidConfigOptions.UploadMethod = {
    ["Discord"] = true,
    ["Fivemanage"] = true,
    ["Fivemerr"] = true,
    ["Custom"] = true
}

Config.Damage = {}

-- If you want to add custom assets for broken screens, add them in `ui\public\utils\system\screen`.
-- The default levels are 1-9. You can add more if you like. Each level should point to the image in the directory above.
-- In the database, you can see the current level of screen damage, and you might notice that the number is negative. That is because, in that case, the touch screen will be broken, and no input will be possible.
Config.Damage.Screen = {}
Config.Damage.Screen.LevelLowest = 1
Config.Damage.Screen.LevelHighest = 9

Config.Security = {}

Config.Security.MaxAttempts = 5    -- The maximum number of attempts to unlock the phone before it gets locked. Default *5.
Config.Security.BaseLockTime = 60  -- Base time to lock the phone getafter max attempts) in seconds. Default *60s == 1 minute.
Config.Security.LockMultiplier = 2 -- Multiplier for each failed attempt. Default *2. (1st attempt = 60s, 2nd attempt = 120s, 3rd attempt = 240s, etc.)

Config.Weapon = {}
Config.Weapon.EnableDisarmPlayer = true -- Whether to disarm the player when they use the phone while holding a weapon. Default *true.
Config.Weapon.DisarmPlayer = function()
    GiveWeaponToPed(cache.ped, `WEAPON_UNARMED`, 0, false, true)
    SetCurrentPedWeapon(cache.ped, `WEAPON_UNARMED`, true)

    RemoveAllPedWeapons(cache.ped, true)
end

-- Whether to enable the layout switch functionality from the Settings app(Settings -> General -> Layout Manager).
Config.EnableLayoutSwitch = true

-- What options should be available in the Select Device screen.
Config.LayoutOptions = {
    "yphone_natural",
    "yphone_black",
    "yphone_white",
    "yphone_blue",

    "yflip_mint",
    "yflip_gold",
    "yflip_graphite",
    "yflip_lavender",

    "y24_black",
    "y24_silver",
    "y24_violet",
    "y24_yellow",

    "yphone_fold_black",
    "yfold_black",
}

Config.CleanupOldOfflineNotifications = true      -- Whether to cleanup old offline notifications. Default *true.
Config.CleanupOldOfflineNotificationsTimeout = 14 -- The timeout in days to cleanup the old offline notifications. Default *14 days.
