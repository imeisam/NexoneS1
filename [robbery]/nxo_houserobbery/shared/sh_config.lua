Config = {}

Config.Debug = false

--SERVER SETTINGS
Config.HouseType = "Both" -- AllHouses | OnlyMission | Both
Config.InteractionType = "target" -- target or textui or 3dtext | which type of interaction you want
Config.QuasarLockpickMinigame = false -- if you use lockpick resource from qusar set this to true
Config.Framework = "qbcore" -- Set your framework! types: qbcore, ESX, standalone
Config.NewESX = true -- if you use esx 1.1 set this to false
Config.Target = "qb-target" -- Which Target system do u use? types: qb-target, qtarget, ox_target
Config.Dispatch = { enabled = true, script = "ps-disptach" } -- cd_dispatch, linden_outlawalert, ps-disptach, core-dispatch
Config.NotificationType = "qbcore" -- Notifications | types: ESX, ox_lib, qbcore
Config.Progress = "qbcore" -- ProgressBars | types: progressBars, ox_lib, qbcore
Config.TextUI = "ox_lib" -- TextUIs | types: esx, ox_lib, luke
Config.Context = "qbcore" -- Context | types: ox_lib, qbcore
Config.Input = "qb-input" -- Input | types: ox_lib, qb-input
Config.TimeChange = true -- for realistic interior night time, can cause error when you dont use correct time sync!
Config.TimeSync = "none" -- Time Sync | types: cd_easytime, none, realtime
Config.PoliceJobs = { 'police' } -- jobs for police counting
--PLAYER CONTROL
Config.Logs = { enabled = true, type = "webhook" } --Change webhook in  use webhook or ox_lib (datadog) Can be changed in server > sv_utils.lua
Config.DropPlayer = false -- Drop (Kick) Player if tries to cheat!
Config.AnticheatBan = false -- Change in server/sv_Utils.lua!!! WIll not work by default you need to add your custom trigger to ban player!

Config.DirtyMoney = false

Config.ResetHousesAfterTime = true -- reset houses
Config.ResetTime = 30 -- in minutes

Config.Lockpick = { item = "lockpick", remove = false } -- item for lockpicking house

Config.NeedBag = {
    enabled = false, -- if needed to enter the house 
    var = 44, --ID of the bag
    color = 0 -- Color ID of the bag
}

Config.NightRob = {
    enabled = true, -- if you want rob house only in night
    time = { 
        from = 22,  -- from 10:00 PM
        to = 6     -- to 6:00 AM
    }
}     

Config.Tier = {
    ["Low Tier"] = {
        chance = 50, -- change in mission to get this house type
        ReportChanceWhenEntering = 15,
        NeedPoliceCount = 4,
        InsidePositions = {
            ["Exit"] = { 
                coords = vector4(266.03, -1007.61, -101.0, 40.0),        
            },
            ["Saffron"] = {
                ChanceToFindNothing = 5,
                coords = vector3(265.937714, -999.368348, -99.008666),        
                Items = {
                    { Item = "romantic_book", Chance = 30, MinCount = 1, MaxCount = 1 },
                    { Item = "notepad", Chance = 30, MinCount = 1, MaxCount = 1 },
                    { Item = "pencil", Chance = 30, MinCount = 1, MaxCount = 1 },
                    { Item = "bong", Chance = 30, MinCount = 1, MaxCount = 1 },
                }
            },
        },
        CreateProps = { -- Spawned props by script --
            ["pogo"] = { model = `vw_prop_vw_pogo_gold_01a`, Label = "Art piece", Item = "pogo", Coords = vec4(262.03, -1000.62, -99.21, 3.4+180.0), propPlacement = { pos = vec3( 0.17, 0.0, 0.05), rot = vec3(16.0, 0.0, 0.0), bone = 18905 }, CarryAnim = { dict = "anim@heists@box_carry@", anim = "idle" }, NeedTrunk = false, }
        },
        Safes = {
            ["safe"] = { model = `prop_ld_int_safe_01`, Label = "Safe", NeedItem = true, Item = "lockpick", Coords = vec4(259.54, -1003.65, -99.01, 120.98), 
            ChanceToFindNothing = 10,
                Items = {
                    { Item = "safe_cracker", Chance = 20, MinCount = 1, MaxCount = 1 },
                    { Item = "towingrope", Chance = 40, MinCount = 1, MaxCount = 1 },
                    { Item = "screwdriver", Chance = 30, MinCount = 1, MaxCount = 1 },
                },
            }
        },
        Ped = {
            chance = 100, model = `s_m_y_dealer_01`, coords = vec4(262.6, -1004.04, -99.26, 86.94), weapon = { enabled = false, chance = 50, weapon = `WEAPON_COMBATPISTOL`, DisableWeaponDrop = true }
        },
        StaticProps = { --Props that are already in interior
            TV = { model = `prop_tv_03`, Label = "TV", Item = "television", propPlacement = { pos = vec3(0.1, 0.42, 0.26), rot = vec3(-172.0, 182.0, -38.0), bone = 60309 }, CarryAnim = { dict = "anim@heists@box_carry@", anim = "idle" }, NeedTrunk = false, Robbed = false },
            SHOEBOX = { model = `v_res_fa_shoebox2`, Label = "Shoe Box", Item = "shoebox", propPlacement = { pos = vec3(0.1, 0.42, 0.26), rot = vec3(-172.0, 182.0, -38.0), bone = 60309 }, CarryAnim = { dict = "anim@heists@box_carry@", anim = "idle" }, NeedTrunk = false, Robbed = false },
            DECK = { model = `prop_dj_deck_02`, Label = "DJ deck", Item = "dj_deck", propPlacement = { pos = vec3(-0.03, 0.07, -0.11), rot = vec3(-60.0, -60.0, 0.0), bone = 60309 }, CarryAnim = { dict = "anim@heists@box_carry@", anim = "idle" }, NeedTrunk = false, Robbed = false },
            CONSOLE = { model = `prop_console_01`, Label = "Console", Item = "console", propPlacement = { pos = vec3(0.1, 0.42, 0.26), rot = vec3(-172.0, 182.0, -38.0), bone = 60309 }, CarryAnim = { dict = "anim@heists@box_carry@", anim = "idle" }, NeedTrunk = false, Robbed = false },
            BOOMBOX = { model = `prop_boombox_01`, Label = "Boombox", Item = "boombox", propPlacement = { pos = vec3(0.26, 0.1, 0.23), rot = vec3(-150.0, -74.0, -14.0), bone = 60309 }, CarryAnim = { dict = "anim@heists@box_carry@", anim = "idle" }, NeedTrunk = false, Robbed = false },
            BONG = { model = `prop_bong_01`, Label = "Bong", Item = "bong", propPlacement = { pos = vec3(0.1, 0.42, 0.26), rot = vec3(-172.0, 182.0, -38.0), bone = 60309 }, CarryAnim = { dict = "anim@heists@box_carry@", anim = "idle" }, NeedTrunk = false, Robbed = false },
        },
        HackDevice = {
            ["HackDevice"] = { model = `v_res_tre_alarmbox`, Label = "Hack Alarm", NeedItem = true, Item = "hack_laptop", Coords = vec4(264.13, -1002.68, -98.81, 85.72) }
        },
        LaserChance = 100,
        Lasers = {
            ["laser_low1"] = { FromCoords = vector3(256.502, -994.856, -97.32), ToCoords = vector3(266.916, -1000.504, -99.618), Visible = true, chance = 100, spawned = false },
            ["laser_low2"] = { FromCoords = vector3(266.732, -994.51, -97.194), ToCoords = vector3(259.326, -1001.644, -99.938), Visible = true, chance = 100, spawned = false },
        },
    },
    ["Mid Tier"] = {
        chance = 0, -- change in mission to get this house type
        ReportChanceWhenEntering = 10,
        NeedPoliceCount = 4,
        InsidePositions = {
            ["Exit"] = { 
                coords = vector4(346.61, -1013.14, -99.2, 357.81),        
            },
            ["Bag of Cocaine"] = {
                ChanceToFindNothing = 5,
                coords = vector3(349.19, -994.83, -99.2),        
                Items = {
                    { Item = "notepad", Chance = 30, MinCount = 1, MaxCount = 1 },
                    { Item = "pencil", Chance = 30, MinCount = 1, MaxCount = 1 },
                    { Item = "watch", Chance = 30, MinCount = 1, MaxCount = 1 },
                    { Item = "necklace", Chance = 30, MinCount = 1, MaxCount = 1 },
                    { Item = "bong", Chance = 30, MinCount = 1, MaxCount = 1 },
                },
            },
            ["Book"] = {
                ChanceToFindNothing = 5,
                coords = vector3(345.3, -995.76, -99.2),        
                Items = {
                    { Item = "book", Chance = 30, MinCount = 1, MaxCount = 1 },
                    { Item = "romantic_book", Chance = 30, MinCount = 1, MaxCount = 1 },
                    { Item = "book", Chance = 30, MinCount = 1, MaxCount = 1 },
                }
            },
            ["Bathroom"] = {
                ChanceToFindNothing = 5,
                coords = vector3(347.23, -994.09, -99.2),        
                Items = {
                    { Item = "toothpaste", Chance = 30, MinCount = 1, MaxCount = 1 },
                    { Item = "shampoo", Chance = 30, MinCount = 1, MaxCount = 1 },
                    { Item = "soap", Chance = 30, MinCount = 1, MaxCount = 1 },
                },
            },
        },
        CreateProps = { -- Spawned props by script
            ["pogo"] = { model = `vw_prop_vw_pogo_gold_01a`, Label = "Art piece", Item = "pogo", Coords = vec4(339.66, -1001.4, -99.31, 180.47), propPlacement = { pos = vec3( 0.17, 0.0, 0.05), rot = vec3(16.0, 0.0, 0.0), bone = 18905 }, CarryAnim = { dict = "anim@heists@box_carry@", anim = "idle" }, NeedTrunk = false, }
        },
        Safes = {
            ["safe"] = { model = `prop_ld_int_safe_01`, Label = "Safe", NeedItem = true, Item = "lockpick", Coords = vec4(352.34, -994.44, -100.2, 273.98),
                ChanceToFindNothing = 10,
                Items = {
                    { Item = "safe_cracker", Chance = 20, MinCount = 1, MaxCount = 1 },
                    { Item = "towingrope", Chance = 30, MinCount = 1, MaxCount = 1 },
                    { Item = "screwdriver", Chance = 30, MinCount = 1, MaxCount = 1 },
                },
            },
        },
        Ped = {
            chance = 100, model = `a_m_y_soucent_04`, coords = vec4(349.83, -996.29, -99.54, 270.66), weapon = { enabled = false, chance = 50, weapon = `WEAPON_COMBATPISTOL`, DisableWeaponDrop = true }
        },
        StaticProps = { --Props that are already in interior
            TV = { model = `prop_tv_flat_01`, Label = "TV", Item = "television", propPlacement = { pos = vec3( 0.18, 0.16, 0.25), rot = vec3(-44.0, 112.0, 10.0), bone = 60309 }, CarryAnim = { dict = "anim@heists@box_carry@", anim = "idle" }, Spawned = false, NeedTrunk = false },
            Coffe = { model = `prop_coffee_mac_02`, Label = "Coffe", Item = "coffemachine", propPlacement = { pos = vec3(0.18, 0.08, 0.25), rot = vec3(-16.0, 44.0, 106.0), bone = 60309 }, CarryAnim = { dict = "anim@heists@box_carry@", anim = "idle" }, Spawned = false, NeedTrunk = false },
            Tape = { model = `prop_tapeplayer_01`, Label = "Tape layer", Item = "tapeplayer", propPlacement = { pos = vec3(0.18, 0.08, 0.25), rot = vec3(-32.0, 100.0, 10.0), bone = 60309 }, CarryAnim = { dict = "anim@heists@box_carry@", anim = "idle" }, Spawned = false, NeedTrunk = false },
            Hair = { model = `v__club_vuhairdryer`, Label = "Hairdryer", Item = "hairdryer", propPlacement = { pos = vec3(0.1, 0.42, 0.26), rot = vec3(-172.0, 182.0, -38.0), bone = 60309 }, CarryAnim = { dict = "anim@heists@box_carry@", anim = "idle" }, Spawned = false, NeedTrunk = false },
            Phone = { model = `v_res_j_phone`, Label = "Phone", Item = "j_phone", propPlacement = { pos = vec3(0.1, 0.42, 0.26), rot = vec3(-172.0, 182.0, -38.0), bone = 60309 }, CarryAnim = { dict = "anim@heists@box_carry@", anim = "idle" }, Spawned = false, NeedTrunk = false },
            SCULPT = { model = `v_res_sculpt_decd`, Label = "Sculpture", Item = "sculpture", propPlacement = { pos = vec3(0.1, -0.16, 0.29), rot = vec3(-50.0, 106.0, -24.0), bone = 60309 }, CarryAnim = { dict = "anim@heists@box_carry@", anim = "idle" }, Spawned = false, NeedTrunk = false },
            Toiletry = { model = `v_ret_ps_toiletry_01`, Label = "Toiletry", Item = "toiletry", propPlacement = { pos = vec3(0.1, 0.42, 0.26), rot = vec3(-172.0, 182.0, -38.0), bone = 60309 }, CarryAnim = { dict = "anim@heists@box_carry@", anim = "idle" }, Spawned = false, NeedTrunk = false },
        },
        HackDevice = {
            ["HackDevice"] = { model = `v_res_tre_alarmbox`, Label = "Hack Alarm", NeedItem = true, Item = "hack_laptop", Coords = vec4(347.61, -1003.035, -99.2, 176.47) }
        },
        LaserChance = 100,
        Lasers = {
            ["laser_mid1"] = { FromCoords = vector3(337.312, -992.528, -97.266), ToCoords = vector3(348.432, -1000.686, -100.118), Visible = true, chance = 40 },
            ["laser_mid2"] = { FromCoords = vector3(353.02, -999.806, -97.48), ToCoords = vector3(348.726, -992.918, -99.98), Visible = false, chance = 40 },
        },
    },
    ["High Tier"] = {
        chance = 50, -- change in mission to get this house type
        ReportChanceWhenEntering = 15,
        NeedPoliceCount = 4,
        InsidePositions = {
            ["Exit"] = { 
                coords = vector4(-787.48413085938, 315.70617675782, 187.9133758545, 270.08288574218),        
            },
            ["Saffron"] = {
                ChanceToFindNothing = 10,
                coords = vector3(-788.957886, 320.741302, 187.313248),        
                Items = {
                    { Item = "bong", Chance = 20, MinCount = 1, MaxCount = 1 },
                    { Item = "earings", Chance = 30, MinCount = 1, MaxCount = 1 },
                }
            },
            ["Kitchen #1"] = { 
                ChanceToFindNothing = 10,
                coords = vector3(-783.327454, 325.411712, 187.313248),        
                Items = {
                    { Item = "earings", Chance = 30, MinCount = 1, MaxCount = 1 },
                    { Item = "watch", Chance = 30, MinCount = 1, MaxCount = 1 },
                },
            },
            ["Kitchen #2"] = {
                ChanceToFindNothing = 10,
                coords = vector3(-782.004090, 330.077392, 187.313248),        
                Items = {
                    { Item = "earings", Chance = 30, MinCount = 1, MaxCount = 1 },
                    { Item = "watch", Chance = 30, MinCount = 1, MaxCount = 1 },
                }
            },
            ["Heist storage"] = {
                ChanceToFindNothing = 10,
                coords = vector3(-794.997680, 326.787872, 187.313340),        
                Items = {
                    { Item = "earings", Chance = 30, MinCount = 1, MaxCount = 1 },
                    { Item = "watch", Chance = 30, MinCount = 1, MaxCount = 1 },

                }
            },
            ["Stair saffron"] = {
                ChanceToFindNothing = 10,
                coords = vector3(-793.373352, 341.711944, 187.113678),        
                Items = {
                    { Item = "earings", Chance = 30, MinCount = 1, MaxCount = 1 },
                    { Item = "watch", Chance = 30, MinCount = 1, MaxCount = 1 },
                    { Item = "gold_bracelet", Chance = 30, MinCount = 1, MaxCount = 1 },
                },
            },
            ["Bedroom saffron"] = {
                ChanceToFindNothing = 10,
                coords = vector3(-800.065612, 338.434052, 190.716018),        
                Items = {
                    { Item = "bong", Chance = 20.5, MinCount = 1, MaxCount = 1 },
                    { Item = "romantic_book", Chance = 30, MinCount = 1, MaxCount = 1 },
                    { Item = "watches", Chance = 30, MinCount = 1, MaxCount = 1 },
                },
            },
            ["Locker #2"] = {
                ChanceToFindNothing = 5,
                coords = vector3(-796.366760, 328.144348, 190.716004),        
                Items = {
                    { Item = "romantic_book", Chance = 30, MinCount = 1, MaxCount = 1 },
                    { Item = "watches", Chance = 30, MinCount = 1, MaxCount = 1 },
                },
            },
            ["Bathroom"] = {
                ChanceToFindNothing = 10,
                coords = vector3(-806.068360, 332.405182, 190.716004),        
                Items = {
                    { Item = "toothpaste", Chance = 30, MinCount = 1, MaxCount = 1 },
                    { Item = "shampoo", Chance = 30, MinCount = 1, MaxCount = 1 },
                    { Item = "soap", Chance = 30, MinCount = 1, MaxCount = 1 },
                },
            },
        },
        CreateProps = { -- Spawned props by script
            ["skull"] = { model = `vw_prop_casino_art_skull_03a`, Label = "Skull", Item = "skull", Coords = vec4(-796.78, 333.99, 191.08, 0.97), propPlacement = { pos = vec3( 0.17, 0.0, 0.05), rot = vec3(16.0, 0.0, 0.0), bone = 18905 }, CarryAnim = { dict = "anim@heists@box_carry@", anim = "idle" } , NeedTrunk = false,},
            ["pogo"] = { model = `vw_prop_vw_pogo_gold_01a`, Label = "Art piece", Item = "pogo", Coords = vec4(-787.66, 327.58, 187.13, 178.27), propPlacement = { pos = vec3( 0.17, 0.0, 0.05), rot = vec3(16.0, 0.0, 0.0), bone = 18905 }, CarryAnim = { dict = "anim@heists@box_carry@", anim = "idle" } , NeedTrunk = false,} 
        },
        Safes = {
            ["safe"] = { model = `prop_ld_int_safe_01`, Label = "Safe", NeedItem = true, Item = "lockpick", Coords = vec4(-797.56, 339.19, 190.02, 0.27),
            ChanceToFindNothing = 10,
            Items = {
                { Item = "safe_cracker", Chance = 20, MinCount = 1, MaxCount = 1 },
                { Item = "towingrope", Chance = 40, MinCount = 1, MaxCount = 1 },
                { Item = "screwdriver", Chance = 30, MinCount = 1, MaxCount = 1 },
            },
        }
    },
        Ped = {
            chance = 100, model = `a_m_y_soucent_04`, coords = vec4(-797.98, 335.78, 190.39, 1.37), weapon = { enabled = false, chance = 50, weapon = `WEAPON_COMBATPISTOL`, DisableWeaponDrop = true }
        },
        StaticProps = { --Props that are already in interior
            Bong = { model = `prop_bong_01`, Label = "Bong", Item = "bong", propPlacement = { pos = vec3(0.1, 0.42, 0.26), rot = vec3(-172.0, 182.0, -38.0), bone = 60309 }, CarryAnim = { dict = "anim@heists@box_carry@", anim = "idle" }, Spawned = false, NeedTrunk = false },
            Laptop = { model = `prop_laptop_01a`, Label = "Laptop", Item = "hack_laptop", propPlacement = { pos = vec3(0.1, 0.42, 0.26), rot = vec3(-172.0, 182.0, -38.0), bone = 60309 }, CarryAnim = { dict = "anim@heists@box_carry@", anim = "idle" }, Spawned = false, NeedTrunk = false },
            Monitor = { model = `prop_monitor_w_large`, Label = "Monitor", Item = "monitor", propPlacement = { pos = vec3(0.1, 0.42, 0.26), rot = vec3(-172.0, 182.0, -38.0), bone = 60309 }, CarryAnim = { dict = "anim@heists@box_carry@", anim = "idle" }, Spawned = false, NeedTrunk = false },
            Phone = { model = `prop_npc_phone`, Label = "Phone", Item = "npc_phone", propPlacement = { pos = vec3(0.1, 0.42, 0.26), rot = vec3(-172.0, 182.0, -38.0), bone = 60309 }, CarryAnim = { dict = "anim@heists@box_carry@", anim = "idle" }, Spawned = false, NeedTrunk = false },
            Printer = { model = `prop_printer_01`, Label = "Printer", Item = "printer", propPlacement = { pos = vec3(0.18, -0.11, 0.24), rot = vec3(-80.0, 6.0, 36.0), bone = 60309 }, CarryAnim = { dict = "anim@heists@box_carry@", anim = "idle" }, Spawned = false, NeedTrunk = false },
            TV = { model = `prop_tv_flat_01`, Label = "TV", Item = "flat_television", propPlacement = { pos = vec3(0.1, 0.42, 0.26), rot = vec3(-172.0, 182.0, -38.0), bone = 60309 }, CarryAnim = { dict = "anim@heists@box_carry@", anim = "idle" }, Spawned = false, NeedTrunk = false },
            radio = { model = `v_res_fa_radioalrm`, Label = "Radio", Item = "radio_alarm", propPlacement = { pos = vec3(0.1, 0.42, 0.26), rot = vec3(-172.0, 182.0, -38.0), bone = 60309 }, CarryAnim = { dict = "anim@heists@box_carry@", anim = "idle" }, Spawned = false, NeedTrunk = false },
            Fan = { model = `v_res_fh_towerfan`, Label = "Fan", Item = "fan", propPlacement = { pos = vec3(0.16, 0.1, 0.23), rot = vec3(-160.0, 36.0, -74.0), bone = 60309 }, CarryAnim = { dict = "anim@heists@box_carry@", anim = "idle" }, Spawned = false, NeedTrunk = false },
            TV2 = { model = `prop_tv_03`, Label = "TV", Item = "television", propPlacement = { pos = vec3(0.1, 0.42, 0.26), rot = vec3(-172.0, 182.0, -38.0), bone = 60309 }, CarryAnim = { dict = "anim@heists@box_carry@", anim = "idle" }, Spawned = false, NeedTrunk = false }
        },
        HackDevice = {
            ["HackDevice"] = { model = `v_res_tre_alarmbox`, Label = "Hack Alarm", NeedItem = true, Item = "hack_laptop", Coords = vec4(-781.71, 322.85, 188.19, 178.39 + 180.0) }
        },
        LaserChance = 100,
        Lasers = {
            ["laser_high1"] = { FromCoords = vector3(-791.046, 323.082, 190.122), ToCoords = vector3(-784.37, 327.042, 186.39), Visible = true, chance = 100 },
            ["laser_high2"] = { FromCoords = vector3(-792.338, 332.824, 192.952), ToCoords = vector3(-790.828, 343.812, 186.186), Visible = true, chance = 100 },
            ["laser_high3"] = { FromCoords = vector3(-794.62, 339.754, 192.808), ToCoords = vector3(-801.228, 331.73, 189.854), Visible = true, chance = 100 },
            ["laser_high4"] = { FromCoords = vector3(-781.26, 324.88, 190.46), ToCoords = vector3(-793.62, 332.88, 186.27), Visible = true, chance = 100 },
        },
    }
}

Config.HousesToRob = {
    ["Low Tier 1"] = {
        Coords = vec3(430.2, -1559.48, 32.82),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: There is grill near doors',
            'HINT: Its on second floor',
            'HINT: There are stairs near doors',
            'HINT: There are chairs near doors',
            'HINT: Its large apartment building'
        }
    },
    ["Low Tier 2"] = {
        Coords = vec3(1391.078, -1508.35, 58.43),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Light brown house',
            'HINT: Jesus grafity on fence',
            'HINT: Broken van near house',
            'HINT: Blue garage next to this house',
        }
    },
    ["Low Tier 3"] = {
        Coords = vec3(1344.677, -1513.24, 54.585),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Light green to white house',
            'HINT: Broken car on porch',
            'HINT: Tires near doors',
            'HINT: You need to go through back door',
        }
    },
    ["Low Tier 4"] = {
        Coords = vec3(1334.00, -1566.46, 54.447),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue Umbrella near door',
            'HINT: Red garage next to this house',
            'HINT: Red and White fence',
        }
    },
    ["Low Tier 5"] = {
        Coords = vec3(1205.712, -1607.179, 50.7),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue trash can',
            'HINT: Boxes near doors',
            'HINT: Flower near doors',
        }
    },
    ["Low Tier 6"] = {
        Coords = vec3(1203.47, -1670.49, 42.98),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 7"] = {
        Coords = vec3(101.04, -1912.15, 21.41),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 8"] = {
        Coords = vec3(118.49, -1921.02, 21.32),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 9"] = {
        Coords = vec3(126.83, -1930.03, 21.38),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 10"] = {
        Coords = vec3(114.34, -1961.24, 21.33),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 11"] = {
        Coords = vec3(76.27, -1948.1, 21.17),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 12"] = {
        Coords = vec3(72.07, -1939.07, 21.37),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 13"] = {
        Coords = vec3(56.53, -1922.78, 21.91),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 14"] = {
        Coords = vec3(38.96, -1911.52, 21.95),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 15"] = {
        Coords = vec3(5.33, -1884.25, 23.7),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 16"] = {
        Coords = vec3(-4.79, -1872.21, 24.15),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 17"] = {
        Coords = vec3(-20.46, -1859.02, 25.41),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 18"] = {
        Coords = vec3(-34.19, -1847.04, 26.19),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 19"] = {
        Coords = vec3(-50.4, -1783.23, 28.3),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 20"] = {
        Coords = vec3(-41.91, -1792.15, 27.83),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 21"] = {
        Coords = vec3(21.36, -1844.6, 24.6),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 22"] = {
        Coords = vec3(30.04, -1854.7, 24.07),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 23"] = {
        Coords = vec3(46.02, -1864.26, 23.28),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 24"] = {
        Coords = vec3(54.42, -1873.07, 22.81),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 25"] = {
        Coords = vec3(103.96, -1885.35, 24.32),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 26"] = {
        Coords = vec3(115.45, -1887.93, 23.93),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 27"] = {
        Coords = vec3(128.25, -1897.02, 23.67),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 28"] = {
        Coords = vec3(148.66, -1904.44, 23.53),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 29"] = {
        Coords = vec3(208.65, -1895.25, 24.81),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 30"] = {
        Coords = vec3(192.24, -1883.25, 25.06),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 31"] = {
        Coords = vec3(171.64, -1871.49, 24.4),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 32"] = {
        Coords = vec3(150.17, -1864.76, 24.59),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 33"] = {
        Coords = vec3(130.62, -1853.3, 25.23),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 34"] = {
        Coords = vec3(1286.77, -1604.56, 54.82),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 35"] = {
        Coords = vec3(1261.64, -1616.8, 54.74),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 36"] = {
        Coords = vec3(1245.4, -1626.96, 53.28),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 37"] = {
        Coords = vec3(1214.44, -1644.34, 48.65),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 37"] = {
        Coords = vec3(1193.61, -1656.57, 43.03),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 38"] = {
        Coords = vec3(1193.46, -1622.28, 45.22),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 39"] = {
        Coords = vec3(1210.45, -1606.54, 50.74),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 40"] = {
        Coords = vec3(1230.6, -1590.86, 53.77),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 41"] = {
        Coords = vec3(1365.6, -1721.75, 65.63),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 42"] = {
        Coords = vec3(1314.32, -1733.06, 54.7),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 43"] = {
        Coords = vec3(1295.01, -1739.85, 54.27),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 44"] = {
        Coords = vec3(1295.01, -1739.85, 54.27),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 45"] = {
        Coords = vec3(1259.21, -1761.95, 49.66),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 46"] = {
        Coords = vec3(1250.79, -1734.25, 52.03),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 47"] = {
        Coords = vec3(1289.19, -1710.53, 55.48),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 48"] = {
        Coords = vec3(1316.75, -1698.5, 58.23),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 49"] = {
        Coords = vec3(1358.34, -1752.14, 64.45),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 50"] = {
        Coords = vec3(-1070.45, -1515.25, 5.3),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 51"] = {
        Coords = vec3(-1091.0, -1485.13, 5.31),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 52"] = {
        Coords = vec3(-1109.12, -1482.42, 4.93),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 53"] = {
        Coords = vec3(-1117.8, -1488.39, 4.73),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 54"] = {
        Coords = vec3(-1130.0, -1496.82, 4.43),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 55"] = {
        Coords = vec3(489.55, -1714.08, 29.71),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 56"] = {
        Coords = vec3(479.69, -1735.67, 29.15),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 57"] = {
        Coords = vec3(474.42, -1757.68, 29.09),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 58"] = {
        Coords = vec3(472.06, -1775.26, 29.07),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 59"] = {
        Coords = vec3(495.3, -1823.4, 28.87),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 60"] = {
        Coords = vec3(500.4, -1813.26, 28.89),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 61"] = {
        Coords = vec3(512.6, -1790.73, 28.92),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 62"] = {
        Coords = vec3(514.36, -1780.88, 28.91),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 63"] = {
        Coords = vec3(440.54, -1829.66, 28.36),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 64"] = {
        Coords = vec3(427.28, -1842.14, 28.46),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 65"] = {
        Coords = vec3(412.35, -1856.33, 27.32),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 66"] = {
        Coords = vec3(399.23, -1865.07, 26.72),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 67"] = {
        Coords = vec3(385.07, -1881.49, 26.03),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 68"] = {
        Coords = vec3(368.66, -1895.7, 25.18),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 69"] = {
        Coords = vec3(320.35, -1854.11, 27.51),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 70"] = {
        Coords = vec3(329.37, -1845.98, 27.75),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 71"] = {
        Coords = vec3(338.67, -1829.64, 28.34),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 72"] = {
        Coords = vec3(348.61, -1820.94, 28.89),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 73"] = {
        Coords = vec3(332.96, -1740.8, 29.73),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 74"] = {
        Coords = vec3(320.65, -1759.75, 29.64),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 75"] = {
        Coords = vec3(304.33, -1775.56, 29.1),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 76"] = {
        Coords = vec3(300.21, -1783.66, 28.44),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 77"] = {
        Coords = vec3(288.7, -1792.55, 28.09),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 78"] = {
        Coords = vec3(197.59, -1725.79, 29.66),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 79"] = {
        Coords = vec3(216.52, -1717.42, 29.68),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 80"] = {
        Coords = vec3(222.56, -1702.44, 29.69),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 81"] = {
        Coords = vec3(240.66, -1687.68, 29.7),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 82"] = {
        Coords = vec3(252.9, -1670.76, 29.66),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 83"] = {
        Coords = vec3(282.06, -1694.76, 29.65),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 84"] = {
        Coords = vec3(269.72, -1712.84, 29.67),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 85"] = {
        Coords = vec3(257.61, -1722.8, 29.65),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["Low Tier 86"] = {
        Coords = vec3(250.07, -1730.82, 29.67),
        Residence = Config.Tier["Low Tier"],
        Hints = {
            'HINT: Blue house',
            'HINT: Long stairs leading to this house',
            'HINT: Yellow hydrant and red trash',
        }
    },
    ["High Tier 1"] = {
        Coords = vector4(216.44, 620.49, 187.75, 74.529731750488),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: Light brown house',
            'HINT: Camera next to doors',
            'HINT: For sale sign',
            'HINT: Brown garage',
            'HINT: 2 floors',
            'HINT: No house to the right',
        }
    },
    ["High Tier 2"] = {
        Coords = vector4(128.08, 565.98, 183.959, 13.116044998168),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 3"] = {
        Coords = vector4(224.22, 513.54, 140.93, 222.75),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 4"] = {
        Coords = vector4(167.54, 473.73, 142.51, 262.18),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 5"] = {
        Coords = vector4(119.93, 494.36, 147.34, 280.62),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 6"] = {
        Coords = vector4(107.02, 466.6, 147.56, 181.26),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 7"] = {
        Coords = vector4(79.95, 486.24, 148.2, 36.67),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 8"] = {
        Coords = vector4(57.57, 449.65, 147.04, 145.54),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 9"] = {
        Coords = vector4(43.08, 468.81, 148.1, 0.24),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 10"] = {
        Coords = vector4(-7.97, 467.82, 145.84, 158.4),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 11"] = {
        Coords = vector4(-66.83, 489.99, 144.88, 163.03),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 12"] = {
        Coords = vector4(-110.09, 501.93, 143.48, 171.28),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 11"] = {
        Coords = vector4(84.91, 561.64, 182.77, 183.71),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 12"] = {
        Coords = vector4(128.11, 565.99, 183.96, 186.64),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 13"] = {
        Coords = vector4(216.33, 620.36, 187.76, 259.54),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 14"] = {
        Coords = vector4(232.29, 672.12, 189.98, 222.1),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 15"] = {
        Coords = vector4(-230.22, 487.83, 128.77, 187.33),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 16"] = {
        Coords = vector4(-126.6, 588.22, 204.71, 181.75),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 17"] = {
        Coords = vector4(-185.21, 591.11, 197.82, 180.26),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 18"] = {
        Coords = vector4(-189.27, 618.34, 199.66, 1.05),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 19"] = {
        Coords = vector4(-232.7, 588.12, 190.54, 173.1),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 20"] = {
        Coords = vector4(-293.62, 600.75, 181.58, 176.19),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 21"] = {
        Coords = vector4(-307.45, 643.49, 176.13, 296.63),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 22"] = {
        Coords = vector4(-340.32, 668.6, 172.78, 75.45),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 23"] = {
        Coords = vector4(-339.48, 625.59, 171.36, 240.75),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 24"] = {
        Coords = vector4(-400.1, 664.65, 163.83, 185.46),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 25"] = {
        Coords = vector4(-446.24, 686.29, 153.12, 25.91),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 26"] = {
        Coords = vector4(-476.71, 647.52, 144.39, 195.41),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 27"] = {
        Coords = vector4(-564.47, 684.73, 146.63, 26.3),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 28"] = {
        Coords = vector4(-606.09, 672.23, 151.6, 172.96),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 29"] = {
        Coords = vector4(-606.09, 672.23, 151.6, 172.96),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 30"] = {
        Coords = vector4(-699.7, 705.98, 158.21, 141.1),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 31"] = {
        Coords = vector4(-700.92, 646.94, 155.38, 166.88),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 32"] = {
        Coords = vector4(-704.24, 588.39, 142.28, 176.75),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 33"] = {
        Coords = vector4(-765.8, 650.52, 145.7, 116.8),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 34"] = {
        Coords = vector4(-819.4, 696.6, 148.11, 199.67),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 35"] = {
        Coords = vector4(-884.52, 699.32, 151.27, 265.22),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 36"] = {
        Coords = vector4(-908.73, 693.65, 151.44, 179.04),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 37"] = {
        Coords = vector4(-931.45, 690.89, 153.47, 179.76),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 39"] = {
        Coords = vector4(-1065.03, 726.72, 165.47, 210.06),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 40"] = {
        Coords = vector4(-1056.42, 761.51, 167.32, 96.05),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 41"] = {
        Coords = vector4(-999.65, 816.93, 173.05, 48.9),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 42"] = {
        Coords = vector4(-962.76, 814.36, 177.76, 2.66),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 43"] = {
        Coords = vector4(-912.18, 777.07, 187.1, 184.49),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 44"] = {
        Coords = vector4(-867.29, 784.65, 191.93, 186.98),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 45"] = {
        Coords = vector4(-824.05, 805.85, 202.78, 202.84),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 45"] = {
        Coords = vector4(-747.32, 808.15, 215.15, 109.31),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 46"] = {
        Coords = vector4(-1974.77, 631.04, 122.69, 69.88),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 47"] = {
        Coords = vector4(-1996.42, 591.17, 118.1, 84.79),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 48"] = {
        Coords = vector4(-1937.48, 550.87, 115.02, 253.23),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 49"] = {
        Coords = vector4(-1929.03, 595.27, 122.29, 252.07),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 50"] = {
        Coords = vector4(-1896.21, 642.57, 130.21, 317.81),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 51"] = {
        Coords = vector4(-1540.03, 420.49, 110.01, 185.96),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 52"] = {
        Coords = vector4(-1495.77, 436.95, 112.5, 222.77),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 53"] = {
        Coords = vector4(-1500.76, 523.16, 118.27, 29.46),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 54"] = {
        Coords = vector4(-1453.9, 512.18, 117.8, 196.14),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 55"] = {
        Coords = vector4(-1452.88, 545.65, 121.0, 74.1),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 56"] = {
        Coords = vector4(-1405.35, 526.81, 123.83, 271.84),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 57"] = {
        Coords = vector4(-1405.08, 562.02, 125.41, 0.12),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 58"] = {
        Coords = vector4(-1346.35, 560.61, 130.53, 235.46),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 59"] = {
        Coords = vector4(-1367.37, 610.74, 133.88, 98.75),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 60"] = {
        Coords = vector4(-1337.03, 606.16, 134.38, 271.69),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 61"] = {
        Coords = vector4(-1291.88, 650.47, 141.5, 13.22),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 62"] = {
        Coords = vector4(-1277.5, 630.06, 143.26, 308.26),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 63"] = {
        Coords = vector4(-1248.81, 642.88, 142.72, 120.7),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 64"] = {
        Coords = vector4(-1241.31, 674.49, 142.81, 352.77),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 65"] = {
        Coords = vector4(-1196.72, 693.13, 147.43, 245.78),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 66"] = {
        Coords = vector4(-1165.67, 726.77, 155.61, 145.39),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 67"] = {
        Coords = vector4(-1117.7, 761.41, 164.29, 206.68),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 68"] = {
        Coords = vector4(-11301, 784.54, 163.89, 58.27),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 69"] = {
        Coords = vector4(-1100.69, 797.99, 167.26, 6.87),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 70"] = {
        Coords = vector4(-1067.59, 795.85, 166.99, 15.88),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 71"] = {
        Coords = vector4(-972.24, 752.18, 176.38, 224.88),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 72"] = {
        Coords = vector4(-166.45, 423.89, 111.81, 195.6),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 73"] = {
        Coords = vector4(-214.05, 399.55, 111.3, 198.57),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 74"] = {
        Coords = vector4(-239.01, 381.87, 112.62, 288.04),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 75"] = {
        Coords = vector4(-297.67, 379.83, 112.1, 200.16),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 76"] = {
        Coords = vector4(-327.92, 369.54, 110.22, 205.51),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 77"] = {
        Coords = vector4(-371.82, 343.24, 109.94, 184.69),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 78"] = {
        Coords = vector4(-409.67, 341.49, 108.91, 91.95),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 79"] = {
        Coords = vector4(-444.18, 342.74, 105.62, 196.73),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 80"] = {
        Coords = vector4(-477.29, 413.16, 103.12, 11.16),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
    ["High Tier 81"] = {
        Coords = vector4(-516.43, 433.43, 97.81, 312.64),
        Residence = Config.Tier["High Tier"],
        Hints = {
            'HINT: White house',
            'HINT: Light next to doors',
            'HINT: Bobcat sign',
            'HINT: Brown garage',
            'HINT: 1 floor',
            'HINT: White box fence near doors with motorcycle behind',
        }
    },
}
--Shop
Config.Shop = {
    enabled = true,   
    Header = "Tech guy Shop",
    Items = {
      --  { label = 'Laser Powder', item = 'powder', description = "Buy Laser discovering powder for: $", price = 20, MinAmount = 1, MaxAmount = 20},
        { label = 'Hacking laptop', item = 'hack_laptop', description = "Buy Laptop for: $", price = 500, MinAmount = 1, MaxAmount = 2 },
      --  { label = 'Lockpick', item = 'lockpick', description = "Buy Lockpick for: $", price = 10, MinAmount = 1, MaxAmount = 20 },
      --  { label = 'Duffle bag', item = 'loot_bag', description = "Buy Duffle Bag for: $", price = 100, MinAmount = 1, MaxAmount = 20 },
        { label = 'House Locator', item = 'house_locator', description = "Buy Locator for: $", price = 100, MinAmount = 1, MaxAmount = 20 },
    },
    Ped = {
        model = `s_m_y_waretech_01`, 
        coords = vector4(139.03, 273.58, 108.97, 72.38), 
        scenario = "WORLD_HUMAN_AA_SMOKE"
    },
    blip = {
        name = "Tech Guy", 
    },
}

--SellShop
Config.SellShop = {
    enabled = false,   
    EnabledSellAll = false,
    Header = "Sell",
    Items = {
        { label = 'TV', item = 'television', description = "Sell Square TV for: $", price = 400, MinAmount = 1, MaxAmount = 20},
        { label = 'Shoe Box', item = 'shoebox', description = "Sell Shoe Box for: $", price = 80, MinAmount = 1, MaxAmount =20},
        { label = 'DJ deck', item = 'dj_deck', description = "Sell DJ deck for: $", price = 250, MinAmount = 1, MaxAmount = 20 },
        { label = 'Console', item = 'console', description = "Sell console for: $", price = 200, MinAmount = 1, MaxAmount = 20 },
        { label = 'Boombox', item = 'boombox', description = "Sell boombox for: $", price = 150, MinAmount = 1, MaxAmount = 20 },
        { label = 'Bong', item = 'bong', description = "Sell bong for: $", price = 100, MinAmount = 1, MaxAmount = 20 },
        { label = 'Pogo Statue', item = 'pogo', description = "Sell Art Piece for: $", price = 100, MinAmount = 1, MaxAmount = 20 },
        { label = 'Flat Television', item = 'flat_television', description = "Sell Flat Television for: $", price = 450, MinAmount = 1, MaxAmount = 20 },
        { label = 'Coffe', item = 'coffemachine', description = "Sell Coffe for: $", price = 100, MinAmount = 1, MaxAmount = 20 },
        { label = 'Hairdryer', item = 'hairdryer', description = "Sell hairdryer for: $", price = 120, MinAmount = 1, MaxAmount = 20 },
        { label = 'Phone', item = 'j_phone', description = "Sell Phone for: $", price = 250, MinAmount = 1, MaxAmount = 20 },
        { label = 'Sculpture', item = 'sculpture', description = "Sell sculpture for: $", price = 120, MinAmount = 1, MaxAmount = 20 },
        { label = 'Toiletry', item = 'toiletry', description = "Sell toiletry for: $", price = 100, MinAmount = 1, MaxAmount = 20 },
        { label = 'Laptop', item = 'laptoph', description = "Sell Laptop for: $", price = 350, MinAmount = 1, MaxAmount = 20 },
        { label = 'Monitor', item = 'monitor', description = "Sell monitor for: $", price = 300, MinAmount = 1, MaxAmount = 20 },
        { label = 'Printer', item = 'printer', description = "Sell Printer for: $", price = 160, MinAmount = 1, MaxAmount = 20 },
        { label = 'Watch', item = 'watch', description = "Sell Watch for: $", price = 250, MinAmount = 1, MaxAmount = 20 },
        { label = 'Toothpaste', item = 'toothpaste', description = "Sell toothpaste for: $", price = 50, MinAmount = 1, MaxAmount = 20 },
        { label = 'Soap', item = 'soap', description = "Sell soap for: $", price = 50, MinAmount = 1, MaxAmount = 20 },
        { label = 'Shampoo', item = 'shampoo', description = "Sell shampoo for: $", price = 50, MinAmount = 1, MaxAmount = 20 },
        { label = 'Romantic book', item = 'romantic_book', description = "Sell romantic book for: $", price = 50, MinAmount = 1, MaxAmount = 20 },
        { label = 'Necklace', item = 'necklace', description = "Sell necklace for: $", price = 200, MinAmount = 1, MaxAmount = 20 },
        { label = 'Gold watch', item = 'gold_watch', description = "Sell gold watch for: $", price = 300, MinAmount = 1, MaxAmount = 20 },
        { label = 'Gold bracelet', item = 'gold_bracelet', description = "Sell gold bracelet for: $", price = 300, MinAmount = 1, MaxAmount = 20 },
        { label = 'Bracelet', item = 'bracelet', description = "Sell bracelet for: $", price = 150, MinAmount = 1, MaxAmount = 20 },
        { label = 'Earings', item = 'earings', description = "Sell earings for: $", price = 150, MinAmount = 1, MaxAmount = 20 },
        { label = 'Book', item = 'book', description = "Sell book for: $", price = 50, MinAmount = 1, MaxAmount = 20 },
        { label = 'Skull Art', item = 'skull', description = "Sell skull for: $", price = 300, MinAmount = 1, MaxAmount = 20 },
        { label = 'Pencil', item = 'pencil', description = "Sell pencil for: $", price = 50, MinAmount = 1, MaxAmount = 20 },
        { label = 'Notepad', item = 'notepad', description = "Sell notepad for: $", price = 50, MinAmount = 1, MaxAmount = 20 },
        { label = 'Tape layer', item = 'tapeplayer', description = "Sell tape player for: $", price = 50, MinAmount = 1, MaxAmount = 20 },
    },
    Ped = {
        model = `a_m_m_eastsa_01`, 
        coords = vector4(115.78861999512, -1685.9140625, 32.491424560547, 227.76132202148), 
        scenario = "WORLD_HUMAN_AA_COFFEE"
    },
}

Config.StartMission = {
    SendToTechGuy = true,
    time = { -- in Hours
        enabled = false,
        from = 22,  -- from 10:00 PM
        to = 6      -- to 6:00 AM
    },
    Ped = {
        model = `ig_chengsr`, 
        coords = vector4(-153.68, -41.19, 53.4, 73.21), 
        scenario = "WORLD_HUMAN_SMOKING" 
    },
    Vehicle = {    
        enabled = false,    
        Model = "burrito3",
        SpawnPoints = {
            { Coords = vector3(-573.5, 314.88, 83.54), Heading = 356.13, Radius = 3.0 },
            { Coords = vector3(-577.1, 315.14, 83.66), Heading = 356.13, Radius = 3.0 }
        }, 
    }
}
