Config = {}

Config.Debug = false -- Debug
--SERVER SETTINGS
Config.Framework = "qbcore" -- Framework | types: auto-detect, qbcore, ESX, standalone
Config.NewESX = false -- if you use esx 1.1 version set this to false
Config.InteractionType = "target" -- target or textui or 3dtext | which type of interaction you want
Config.Target = "qb-target" -- Target | types: auto-detect, qb-target, qtarget, ox_target
Config.BossMenu = "qb-management" -- BossMenu | types: auto-detect, esx_society, qb-management
Config.NotificationType = "qbcore" -- Notifications | types: ESX, ox_lib, qbcore
Config.Progress = "qbcore" -- ProgressBar | types: progressBars, ox_lib, qbcore
Config.Clothing = "qb-clothing" -- Skin / Clothing | types: auto-detect, esx_skin, qb-clothing, fivem-appearance, ox_appearance, illenium-appearance
Config.TextUI = "ox_lib" -- TextUIs | types: esx, ox_lib, luke
Config.Context = "qbcore" -- Context | types: ox_lib, qbcore
Config.Input = "qb-input" -- Input | types: ox_lib, qb-input
--PLAYER SETTINGS
Config.DisableJob = false -- everyone can work on vineyard
Config.JobName = "wine" -- Job name for Vineyard
Config.BossGrade = 5 -- Boss Grade
Config.NeedCleanHands = false -- Required to clean hands to do actions etc.

Config.Logs = { enabled = true, type = "webhook" } -- use webhook or ox_lib (datadog) Can be changed in server > sv_utils.lua
Config.DropPlayer = true -- Drop (Kick) Player if tries to cheat!
Config.AnticheatBan = false -- Change in server/sv_Utils.lua!!! WIll not work by default you need to add your custom trigger to ban player!

Config.Inventory = "qb" -- ox, quasar, chezza, qb

Config.wine = {

    Garage = {
        Ped = {
            { Model = "s_m_y_xmech_01", Coords = vec4(-1924.95, 2048.03, 139.83, 258.23), Scenario = "WORLD_HUMAN_SMOKING" }
        },
        Vehicles = {
            { Model = "bison", Label = "Marlowe Bison", livery = 1 },
        },
        SpawnPoints = {
            { Coords = vector3(-1918.35, 2056.79, 139.74), Heading = 258.15, Radius = 3.0 },
            { Coords = vector3(-1919.81, 2052.65, 139.74), Heading = 256.15, Radius = 3.0 }
        },
    },
    SinkMinigame = true, -- if you want disable minigame for sink set this to false
    Sinks = {
        Sink1 = {
            coords = vector3(-1897.65, 2078.97, 140.78),
            radius = 1.5,
            WaterStream = vector3(-1897.66, 2078.95, 141.065),
            Occupied = false -- dont change!!!
        }
    },

    LabelingMinigame = true, -- if you want disable minigame for labeling set this to false
    Labeling = {
        Labeling1 = {
            coords = vector3(-1907.54, 2092.26, 139.99),
            radius = 1.5,
            PropCoords = vector3(-1907.44, 2092.07, 140.15),
            Occupied = false -- dont change!!!
        }
    },

    CloakRoom = {
        Main = { coords = vector3(-1909.29, 2072.05, 140.64), radius = 1.6 },
    },

    Stashes = {
        Main = {
            name = "wine_Stash1",
            label = "wine Stash 1",
            TargetIcon = "fas fa-warehouse",
            TargetLabel = "Stash",
            Slots = 20,
            Weight = 50000, -- 50 KG
            coords = vector3(-1885.7, 2075.11, 140.0),
            radius = 1.5,
            debug = false,
            job = "wine"
        },
    },

    Delivery = vector3(-5133.49, 16008.26, 209.88),
    DeliveryRadius = 1.5,

    BossMenu = {
        Main = { coords = vector3(-1860.37, 2053.66, 141.18), radius = 1.55, debug = false },
    },

    HarvestCrates = {
        coords = vector3(-1879.77, 2091.79, 140.35), radius = 1.45, debug = false, amount = 0,
    },
}


--Wine
Config.Wines = {
    GatherMinigame = true,  -- if you want disable minigame set this to false
    GatherNeedCrate = true,
    Gather = {
       ["Red wine"] = {
            Locations = {
                { Coords = vector3(-1859.24, 2098.63, 138.53), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!!
                { Coords = vector3(-1851.58, 2107.21, 135.69), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!!
                { Coords = vector3(-1851.15, 2102.26, 138.0), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!!
                { Coords = vector3(-1843.9, 2105.78, 137.79), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!!
                { Coords = vector3(-1839.64, 2107.94, 137.62), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!!
                { Coords = vector3(-1833.63, 2110.65, 136.31), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!!
                { Coords = vector3(-1827.33, 2113.39, 134.63), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!!
                { Coords = vector3(-1824.43, 2110.33, 137.07), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!!
                { Coords = vector3(-1854.9, 2105.59, 136.08), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!!
                { Coords = vector3(-1844.72, 2110.52, 135.02), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!!
                { Coords = vector3(-1837.05, 2113.81, 133.89), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!!
                { Coords = vector3(-1831.57, 2116.44, 133.32), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!!
                { Coords = vector3(-1827.94, 2118.24, 132.35), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!!
            },
            Target = "Gather red wine grapes",
            prop = `wine_grape`,
            RequiredItems = {
                { item = "scissors", count = 1, remove = false },
            },
            AddItems = {
                { item = "red_wine_grapes", count = 1 },
            }
        },
        ["White wine"] = {
            Locations = {
                { Coords = vector3(-1874.71, 2099.45, 139.14), radius = 1.9, cooldown = 3.0, Occupied = false },-- dont change Occupied !!!
                { Coords = vector3(-1882.07, 2099.61, 139.24), radius = 1.9, cooldown = 3.0, Occupied = false },-- dont change Occupied !!! 
                { Coords = vector3(-1886.34, 2100.06, 138.99), radius = 1.9, cooldown = 3.0, Occupied = false },-- dont change Occupied !!! 
                { Coords = vector3(-1891.79, 2100.55, 138.21), radius = 1.9, cooldown = 3.0, Occupied = false },-- dont change Occupied !!! 
                { Coords = vector3(-1889.8, 2105.08, 136.9), radius = 1.9, cooldown = 3.0, Occupied = false },-- dont change Occupied !!! 
                { Coords = vector3(-1883.13, 2104.22, 137.61), radius = 1.9, cooldown = 3.0, Occupied = false },-- dont change Occupied !!!
                { Coords = vector3(-1873.85, 2103.65, 137.82), radius = 1.9, cooldown = 3.0, Occupied = false },-- dont change Occupied !!! 
                { Coords = vector3(-1873.18, 2108.13, 136.34), radius = 1.9, cooldown = 3.0, Occupied = false },-- dont change Occupied !!!
                { Coords = vector3(-1880.0, 2108.84, 136.42), radius = 1.9, cooldown = 3.0, Occupied = false },-- dont change Occupied !!!
                { Coords = vector3(-1889.18, 2109.36, 135.49), radius = 1.9, cooldown = 3.0, Occupied = false },-- dont change Occupied !!!
                { Coords = vector3(-1872.79, 2112.41, 135.09), radius = 1.9, cooldown = 3.0, Occupied = false },-- dont change Occupied !!!
                { Coords = vector3(-1878.03, 2112.95, 135.13), radius = 1.9, cooldown = 3.0, Occupied = false },-- dont change Occupied !!!
                { Coords = vector3(-1890.08, 2113.92, 133.44), radius = 1.9, cooldown = 3.0, Occupied = false },-- dont change Occupied !!!
                { Coords = vector3(-1885.73, 2113.68, 134.22), radius = 1.9, cooldown = 3.0, Occupied = false },-- dont change Occupied !!!
                { Coords = vector3(-1874.27, 2117.06, 133.66), radius = 1.9, cooldown = 3.0, Occupied = false },-- dont change Occupied !!!
                { Coords = vector3(-1880.6, 2117.63, 133.13), radius = 1.9, cooldown = 3.0, Occupied = false },-- dont change Occupied !!!
                { Coords = vector3(-1885.88, 2118.02, 132.56), radius = 1.9, cooldown = 3.0, Occupied = false },-- dont change Occupied !!!
                { Coords = vector3(-1890.73, 2118.29, 131.7), radius = 1.9, cooldown = 3.0, Occupied = false },-- dont change Occupied !!!
            },
            Target = "Gather white wine grapes",
            prop = `wine_grape_white`,
            RequiredItems = {
                { item = "scissors", count = 1, remove = false },
            },
            AddItems = {
                { item = "white_wine_grapes", count = 1 },
            }
        },
        ["Rose wine"] = {
            Locations = {
                 { Coords = vector3(-1850.22, 2089.88, 139.88), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!! 
                { Coords = vector3(-1844.92, 2093.4, 139.41), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!! 
                { Coords = vector3(-1840.25, 2095.5, 138.61), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!! 
                { Coords = vector3(-1834.37, 2098.92, 137.97), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!! 
                { Coords = vector3(-1832.85, 2094.59, 137.53), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!! 
                { Coords = vector3(-1839.18, 2091.16, 138.4), radius = 2.5, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!! 
                { Coords = vector3(-1845.62, 2087.16, 139.19), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!! 
                { Coords = vector3(-1849.26, 2085.22, 139.56), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!!
                { Coords = vector3(-1845.03, 2082.44, 138.86), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!!
                { Coords = vector3(-1837.54, 2087.06, 138.0), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!! 
                { Coords = vector3(-1831.25, 2090.36, 136.96), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!!
                { Coords = vector3(-1843.38, 2078.42, 138.9), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!!
                { Coords = vector3(-1835.64, 2082.72, 137.66), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!!
                { Coords = vector3(-1828.47, 2087.09, 136.48), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!! 
                { Coords = vector3(-1840.0, 2075.5, 138.03), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!! 
                { Coords = vector3(-1830.74, 2080.66, 136.53), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!! 
                { Coords = vector3(-1825.3, 2083.95, 135.76), radius = 1.9, cooldown = 3.0, Occupied = false }, -- dont change Occupied !!! 
            },
            Target = "Gather rose wine grapes",
            prop = `wine_grape_pink`,
            RequiredItems = {
                { item = "scissors", count = 1, remove = false },
            },
            AddItems = {
                { item = "rose_wine_grapes", count = 1 },
            }
        },
    },
    ["Press"] = {
        Minigame = true, -- if you want disable minigame set this to false
        Locations = {
            { 
                Coords = vector3(-1882.69, 2091.74, 139.89),
                AnimationCoords = vec4(-1882.69, 2091.74, 140.07, 0.0),
                PropCoords = vec4(-1882.68, 2091.76, 140.25, 250.75),
                radius = 1.3, 
                Occupied = false -- dont change!!!
            },
            { 
                Coords = vector3(-1885.75, 2092.59, 139.89),
                AnimationCoords = vec4(-1885.75, 2092.59, 140.06, 0.0),
                PropCoords = vec4(-1885.75, 2092.58, 140.25, 250.75),
                radius = 1.3, 
                Occupied = false -- dont change!!!
            },
            { 
                Coords = vector3(-1888.42, 2092.98, 139.89),
                AnimationCoords = vec4(-1888.42, 2092.98, 140.04, 0.0),
                PropCoords = vec4(-1888.42, 2092.98, 140.25, 250.75),
                radius = 1.3, 
                Occupied = false -- dont change!!!
            },
        },
        Wines = {
            ["Red_Wine"] = {
                Title = "Red Wine",
                description = "Press 2x prepared red wine grapes",
                prop = `wine_grapes`,
                particledict = "core",
                particle = "trail_splash_oil",
                scale = 2.0,
                RequiredItems = {
                    { item = "red_wine_prepared", count = 2, remove = true },
                },
                AddItems = {
                    { item = "red_wine_juice", count = 1 },
                }
            },
            ["White_Wine"] = {
                Title = "White Wine",
                description = "Press 2x prepared white wine grapes",
                prop = `wine_grapes_white`,
                particledict = "core",
                particle = "water_splash_ped_wade",
                scale = 5.0,
                RequiredItems = {
                    { item = "white_wine_prepared", count = 2, remove = true },
                },
                AddItems = {
                    { item = "white_wine_juice", count = 1 },
                }
            },
            ["Rose_Wine"] = {
                Title = "Rose Wine",
                description = "Press 2x prepared rose wine grapes",
                prop = `wine_grapes_pink`,
                particledict = "core",
                particle = "trail_splash_blood",
                scale = 2.0,
                RequiredItems = {
                    { item = "rose_wine_prepared", count = 2, remove = true },
                },
                AddItems = {
                    { item = "rose_wine_juice", count = 1 },
                }
            }
        },
    },
    ["Prepare"] = {
        Minigame = true, -- if you want disable minigame set this to false
        Locations = {
            { 
                Coords = vector3(-1890.21, 2074.35, 140.84),
                AnimationCoords = vec4(-1890.75, 2074.56, 140.0, 250.13),
                PropCoords = vec4(-1889.95, 2074.81, 140.79, 250.75),
                radius = 1.0, 
                Occupied = false, -- dont change!!!
                prop = `prop_crate_02a`,
            },
        },
        Wines = {
            ["Red_Wine"] = {
                Title = "Red Wine",
                description = "Prepare red wine grapes",
                prop = `wine_grape`,
                RequiredItems = {
                    { item = "red_wine_grapes", count = 1, remove = true },
                },
                AddItems = {
                    { item = "red_wine_prepared", count = 1 },
                }
            },
            ["White_Wine"] = {
                Title = "White Wine",
                description = "Prepare white wine grapes",
                prop = `wine_grape_white`,
                RequiredItems = {
                    { item = "white_wine_grapes", count = 1, remove = true },
                },
                AddItems = {
                    { item = "white_wine_prepared", count = 1 },
                }
            },
            ["Rose_Wine"] = {
                Title = "Rose Wine",
                description = "Prepare Rose wine grapes",
                prop = `wine_grape_pink`,
                RequiredItems = {
                    { item = "rose_wine_grapes", count = 1, remove = true },
                },
                AddItems = {
                    { item = "rose_wine_prepared", count = 1 },
                }
            }
        },
    },
    ["Fill"] = {
        Minigame = true, -- if you want disable minigame set this to false
        Locations = {
            { 
                Coords = vector3(-1904.6711, 2093.0754, 139.85),
                AnimationCoords = vec4(-1904.3606, 2091.9949, 140.3857, 15.0064),
                ParticleCoords = vec4(-1904.59, 2092.634, 139.82, 8.0775), 
                radius = 1.35, 
                Occupied = false -- dont change!!!
            },
            { 
                Coords = vector3(-1900.4412, 2093.7637, 139.85),
                AnimationCoords = vec4(-1900.2516, 2092.6807, 140.3897, 14.4603),
                ParticleCoords = vec4(-1900.36, 2093.33, 139.795, 8.0775),
                radius = 1.35, 
                Occupied = false -- dont change!!!
            },
            { 
                Coords = vector3(-1895.9293, 2094.2668, 139.85),
                AnimationCoords = vec4(-1895.8782, 2093.2346, 140.3932, 8.0775),
                ParticleCoords = vec4(-1895.825, 2093.85, 139.795, 8.0775),
                radius = 1.35, 
                Occupied = false -- dont change!!!
            },
        },
        Wines = {
            ["Red_Wine"] = {
                Title = "Red Wine",
                description = "Requirements: Empty wine bottle labeled, red wine juice",
                RequiredItems = {
                    { item = "red_wine_juice", count = 1, remove = true },
                    { item = "empty_wine_bottle_labeled", count = 1, remove = true },
                },
                AddItems = {
                    { item = "red_wine_bottle", count = 1 },
                }
            },
            ["White_Wine"] = {
                Title = "White Wine",
                description = "Requirements: Empty wine bottle labeled, white wine juice",
                RequiredItems = {
                    { item = "white_wine_juice", count = 1, remove = true },
                    { item = "empty_wine_bottle_labeled", count = 1, remove = true },
                },
                AddItems = {
                    { item = "white_wine_bottle", count = 1 },
                }
            },
            ["Rose_Wine"] = {
                Title = "Rose Wine",
                description = "Requirements: Empty wine bottle labeled, rose wine juice",
                RequiredItems = {
                    { item = "rose_wine_juice", count = 1, remove = true },
                    { item = "empty_wine_bottle_labeled", count = 1, remove = true },
                },
                AddItems = {
                    { item = "rose_wine_bottle", count = 1 },
                }
            } 
        } 
    },
}

--Sink
Config.Sink = {
    CleanDirtyBottles = {
        Title = "Clean dirty wine bottle",
        description = "Requirements: Dirty wine bottle",
        prop = `prop_wine_bot_01`,
        RequiredItems = {
            { item = "dirty_wine_bottle", count = 1, remove = true },
        },
        AddItems = {
            { item = "empty_wine_bottle", count = 1 },
        }
    },
    CleanDirtyScissors = {
        Title = "Clean dirty scissors",
        description = "Requirements: Dirty scissors",
        prop = `prop_cs_scissors`,
        RequiredItems = {
            { item = "scissors_dirty", count = 1, remove = true },
        },
        AddItems = {
            { item = "scissors", count = 1 },
        }
    },
}

--Labeling
Config.Labeling = {
    LabelWine = {
        Title = "Add label to wine bottle",
        description = "Requirements: empty wine bottle, label",
        prop = `prop_wine_bot_01`,
        RequiredItems = {
            { item = "empty_wine_bottle", count = 1, remove = true },
            { item = "wine_label", count = 1, remove = true },
        },
        AddItems = {
            { item = "empty_wine_bottle_labeled", count = 1 },
        }
    },
}

--BLIPS
Config.Blips = {
    wine = { -- do not use same value twice (will result in overwriting of blip)
        BlipCoords = vec3(-1868.01, 2048.29, 139.98), -- Blip coords
        Sprite = 85, -- Blip Icon
        Display = 4, -- keep 4
        Scale = 0.8, -- Size of blip
        Colour = 27, -- colour
        Name = "Marlowe Vineyard" -- Blip name
    },
}

--Job BLIPS
Config.JobBlips = {
    -- Shop = { -- do not use same value twice (will result in overwriting of blip)
    --     BlipCoords = vec3(-1090.61, 2715.17, 18.08), -- Blip coords
    --     Sprite = 59, -- Blip Icon
    --     Display = 4, -- keep 4
    --     Scale = 0.8, -- Size of blip
    --     Colour = 27, -- colour
    --     Name = "Marlowe Vineyard - Shop" -- Blip name
    -- },
    -- LabelShop = { -- do not use same value twice (will result in overwriting of blip)
    --     BlipCoords = vec3(-144.55, -65.09, 53.6), -- Blip coords
    --     Sprite = 59, -- Blip Icon
    --     Display = 4, -- keep 4
    --     Scale = 0.8, -- Size of blip
    --     Colour = 27, -- colour
    --     Name = "Marlowe Vineyard - Label Shop" -- Blip name
    -- },
}

--Shop
Config.Shop = {
    Header = "Marlowe Vineyard Shop",
    Items = {
        { label = 'Dirty Scissors', item = 'scissors_dirty', description = "Buy dirty Scissors for: $", price = 70, MinAmount = 1,
            MaxAmount = 30 },
        { label = 'Dirty Wine Bottle', item = 'dirty_wine_bottle', description = "Buy Dirty Wine Bottle for: $", price = 2,
            MinAmount = 1, MaxAmount = 20 },
        { label = 'Wine glass', item = 'wine_glass', description = "Buy Wine glass for: $", price = 2,
            MinAmount = 1, MaxAmount = 20 },
    },
    Ped = {
        { model = "mp_m_shopkeep_01", coords = vector4(-1089.9752197266, 2713.9936523438, -90.733917236328, 42.131427764893), scenario = "WORLD_HUMAN_SMOKING" },
    },
}

--LabelShop
Config.LabelShop = {
    Header = "Label Shop",
    Items = {
        { label = 'label for bottle', item = 'wine_label', description = "Buy Bottle label for: $", price = 70, MinAmount = 1,
            MaxAmount = 30 },
    },
    Ped = {
        { model = "mp_m_shopkeep_01", coords = vector4(-1089.9752197266, 2713.9936523438, -90.733917236328, 42.131427764893), scenario = "WORLD_HUMAN_SMOKING" },
    },
}

-- Consumables / Drinking / Eating
Config.Consumables = {
    white_wine_glass = { -- Item name
        Remove = true, -- Remove item
        RemoveItem = "white_wine_glass", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        Add = true,
        AddItem = "wine_glass", -- Remove Item name
        AddItemCount = 1, -- Remove Item Count
        ProgressBar = "Drinking...",
        duration = 12500,
        Effect = { status = "drunk", add = 100000 },
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'amb@world_human_drinking@coffee@male@idle_a',
                    clip = 'idle_c'
                },
                prop = {
                    model = 'prop_drink_whtwine',
                    bone = 57005,
                    pos = vec3(0.14, -0.07, -0.01),
                    rot = vec3(-80.0, 100.0, 0.0)
                },

            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
        }
    },
    rose_wine_glass = { -- Item name
        Remove = true, -- Remove item
        RemoveItem = "rose_wine_glass", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        Add = true,
        AddItem = "wine_glass", -- Remove Item name
        AddItemCount = 1, -- Remove Item Count
        ProgressBar = "Drinking...",
        duration = 12500,
        Effect = { status = "drunk", add = 100000 },
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'amb@world_human_drinking@coffee@male@idle_a',
                    clip = 'idle_c'
                },
                prop = {
                    model = 'prop_drink_redwine',
                    bone = 57005,
                    pos = vec3(0.14, -0.07, -0.01),
                    rot = vec3(-80.0, 100.0, 0.0)
                },

            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
        }
    },
    red_wine_glass = { -- Item name
        Remove = true, -- Remove item
        RemoveItem = "red_wine_glass", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        Add = true,
        AddItem = "wine_glass", -- Remove Item name
        AddItemCount = 1, -- Remove Item Count
        ProgressBar = "Drinking...",
        duration = 12500,
        Effect = { status = "drunk", add = 100000 },
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'amb@world_human_drinking@coffee@male@idle_a',
                    clip = 'idle_c'
                },
                prop = {
                    model = 'prop_drink_redwine',
                    bone = 57005,
                    pos = vec3(0.14, -0.07, -0.01),
                    rot = vec3(-80.0, 100.0, 0.0)
                },

            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
        }
    }
}
Config.Bottles = {
    white_wine_bottle = { -- Item name
        Remove = true, -- Remove item
        RemoveItem = "white_wine_bottle", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        Add = false,
        AddItem = "wine_glass", -- Remove Item name
        AddItemCount = 1, -- Remove Item Count
        ProgressBar = "Drinking...",
        duration = 12500,
        Effect = { status = "drunk", add = 100000 },
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'amb@world_human_drinking@coffee@male@idle_a',
                    clip = 'idle_c'
                },
                prop = {
                    model = 'prop_wine_white',
                    bone = 57005,
                    pos = vec3(0.08, -0.22, -0.11),
                    rot = vec3(-70.0, 50.0, 0.0)
                },

            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
        }
    },
    rose_wine_bottle = { -- Item name
        Remove = true, -- Remove item
        RemoveItem = "rose_wine_bottle", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        Add = false,
        AddItem = "wine_glass", -- Remove Item name
        AddItemCount = 1, -- Remove Item Count
        ProgressBar = "Drinking...",
        duration = 12500,
        Effect = { status = "drunk", add = 100000 },
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'amb@world_human_drinking@coffee@male@idle_a',
                    clip = 'idle_c'
                },
                prop = {
                    model = 'prop_wine_rose',
                    bone = 57005,
                    pos = vec3(0.08, -0.22, -0.11),
                    rot = vec3(-70.0, 50.0, 0.0)
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
        }
    },
    red_wine_bottle = { -- Item name
        Remove = true, -- Remove item
        RemoveItem = "red_wine_bottle", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        Add = false,
        AddItem = "wine_glass", -- Remove Item name
        AddItemCount = 1, -- Remove Item Count
        ProgressBar = "Drinking...",
        duration = 12500,
        Effect = { status = "drunk", add = 100000 },
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'amb@world_human_drinking@coffee@male@idle_a',
                    clip = 'idle_c'
                },
                prop = {
                    model = 'prop_wine_red',
                    bone = 57005,
                    pos = vec3(0.08, -0.22, -0.11),
                    rot = vec3(-70.0, 50.0, 0.0)
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
        }
    }
}

Config.WineCosumables = {
    ["red_wine_bottle"] = {
        label = 'Red Wine',
        glassname = 'red_wine_glass',
        emptyglass = 'wine_glass',
        emptybottlename = 'dirty_wine_bottle',
        prop = `prop_wine_red`,
        RequiredItems = {
            { item = "wine_glass", count = 1 },
        }
    },
    ["white_wine_bottle"] = {
        label = 'White Wine',
        glassname = 'white_wine_glass',
        emptyglass = 'wine_glass',
        emptybottlename = 'dirty_wine_bottle',
        prop = `prop_wine_white`,
        RequiredItems = {
            { item = "wine_glass", count = 1 },
        }
    },
    ["rose_wine_bottle"] = {
        label = 'Rose Wine',
        glassname = 'rose_wine_glass',
        emptyglass = 'wine_glass',
        emptybottlename = 'dirty_wine_bottle',
        prop = `prop_wine_rose`,
        RequiredItems = {
            { item = "wine_glass", count = 1 },
        }
    }
}

Config.Peds = {
    CloakRoomPed = {
        model = "a_m_m_farmer_01", coords = vec4(-1860.54, 2053.66, 139.99, 179.62), scenario = "WORLD_HUMAN_SMOKING" 
   }, 
   BossMenuPed = {
        model = "a_m_y_business_03", coords = vec4(-1909.17, 2072.0, 139.39, 148.69), scenario = "WORLD_HUMAN_SMOKING" 
   }, 
}

Config.Objects = {
    ["basket1"] = { Coords = vec3(-1882.69, 2091.74, 139.89) , Prop = `wine_basket`, Heading = 252.75, DrawDistance = 50.0 },
    -- ["grapesforbasket1"] = { Coords = vec3(-1885.93, 2092.75, 140.06) , Prop = `wine_grapes`, Heading = 10.0, DrawDistance = 50.0 },
    ["basket2"] = { Coords = vec3(-1885.75, 2092.59, 139.89) , Prop = `wine_basket`, Heading = 252.758, DrawDistance = 50.0 },
    -- ["grapesforbasket2"] = { Coords = vec3(-1884.5, 2092.49, 140.06) , Prop = `wine_grapes_pink`, Heading = 10.0, DrawDistance = 50.0 },
    ["basket3"] = { Coords = vec3(-1888.42, 2092.98, 139.89) , Prop = `wine_basket`, Heading = 252.75, DrawDistance = 50.0 },
    -- ["grapesforbasket3"] = { Coords = vec3(-1887.55, 2092.9, 140.06) , Prop = `wine_grapes_white`, Heading = 10.0, DrawDistance = 50.0 },
    ["Barrell1"] = { Coords = vec3(-1904.6711, 2093.0754, 139.35) , Prop = `wine_barrel`, Heading = 276.9268, DrawDistance = 50.0 },
    ["Barrell2"] = { Coords = vec3(-1900.4412, 2093.7637, 139.35) , Prop = `wine_barrel`, Heading = 276.9268, DrawDistance = 50.0 },
    ["Barrell3"] = { Coords = vec3(-1895.9293, 2094.2668, 139.35) , Prop = `wine_barrel`, Heading = 276.9268, DrawDistance = 50.0 },
    ["tap1"] = { Coords = vec3(-1895.8695, 2094.065, 139.053) , Prop = `wine_tap`, Heading = 276.9268, DrawDistance = 50.0 },
    ["tap2"] = { Coords = vec3(-1900.4036865234375, 2093.5537109375, 139.05039978027344) , Prop = `wine_tap`, Heading = 276.9268, DrawDistance = 50.0 },
    ["tap3"] = { Coords = vec3(-1904.6102294921875, 2092.8798828125, 139.06491088867188) , Prop = `wine_tap`, Heading = 276.9268, DrawDistance = 50.0 },
    ["sink1"] = { Coords = vec3(-1897.390, 2078.86, 140.0) , Prop = `prop_ff_sink_02`, Heading = 144.3, DrawDistance = 50.0 },
    ["table1"] = { Coords = vec3(-1889.94, 2074.3, 140.0) , Prop = `prop_table_04`, Heading = 70.47, DrawDistance = 50.0 },
   -- ["table1"] = { Coords = vec3(-1889.94, 2074.3, 140.0) , Prop = `prop_table_04`, Heading = 70.47, DrawDistance = 50.0 },
    ["table2"] = { Coords = vec3(-1907.54, 2092.26, 139.39) , Prop = `prop_table_03`, Heading = 189.22, DrawDistance = 50.0 },
    --["table3"] = { Coords = vec3(-1911.72, 2088.58, 139.38) , Prop = `prop_table_03`, Heading = 230.28, DrawDistance = 50.0 },
    ["table2_dec"] = { Coords = vec3(-1908.09, 2091.9, 140.15) , Prop = `prop_paint_wpaper01`, Heading = 189.22, DrawDistance = 50.0 },
    ["Crate1"] = { Coords = vec3(-1879.4, 2091.73, 139.99) , Prop = `prop_crate_02a`, Heading = 70.47, DrawDistance = 50.0 },
    ["Crate2"] = { Coords = vec3(-1880.09, 2091.9, 139.99) , Prop = `prop_crate_02a`, Heading = 70.47, DrawDistance = 50.0 },
    ["Crate3"] = { Coords = vec3(-1879.64, 2091.8, 140.36) , Prop = `prop_crate_02a`, Heading = 160.47, DrawDistance = 50.0 },
    --["Phone1"] = { Coords = vec3(-1911.95, 2088.09, 140.15) , Prop = `prop_office_phone_tnt`, Heading = 70.5, DrawDistance = 50.0 },
    ["Storage"] = { Coords = vec3(-1885.7, 2075.11, 140.0) , Prop = `prop_box_wood05b`, Heading = 160.5, DrawDistance = 50.0 },
   -- ["Barrell1"] = { Coords = vec3(-1887.55, 2092.9, 140.06) , Prop = `prop_grapes_02`, Heading = 10.0, DrawDistance = 50.0 },
  --  ["Barrell2"] = { Coords = vec3(-1887.55, 2092.9, 140.06) , Prop = `prop_grapes_02`, Heading = 10.0, DrawDistance = 50.0 },
}

Config.Delivery = {
    {   
        item = "red_wine_bottle", -- Item name
        Label = "Red Wine", -- Item label
        MinPrice = 30, -- Min price
        MaxPrice = 100, -- Max price
        MinCount = 1, -- Min Count
        MaxCount = 5, -- Max Count
    },
    {   
        item = "white_wine_bottle", -- Item name
        Label = "White Wine", -- Item label
        MinPrice = 30, -- Min price
        MaxPrice = 100, -- Max price
        MinCount = 1, -- Min Count
        MaxCount = 5, -- Max Count
    },
    {   
        item = "rose_wine_bottle", -- Item name
        Label = "Rose Wine", -- Item label
        MinPrice = 30, -- Min price
        MaxPrice = 100, -- Max price
        MinCount = 1, -- Min Count
        MaxCount = 5, -- Max Count
    },
}