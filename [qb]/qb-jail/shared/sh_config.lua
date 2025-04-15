Config = Config or {}

Config.poweplanttimeout=360000
Config.jailbreakactive=false
Config.jailbreak={
    {
        item="thermite",
        coord=vector3(1843.77, 2567.63, 45.67),
        h= 1.3, 
        w=0.5,
        heading=270,
        minZ=44.67,
        maxZ=46.47,
        doorname='prison-prisongate1',
        thermitecoord=vector3(1843.6717529297, 2567.3880566406, 45.672859191895),
        thermiteanim=vector3(1843.7506103516, 2567.076171875, 45.672721862793),
        busy=false,   
    },
    {
        item="paper",
        coord=vector3(1831.35, 2603.96, 45.89),
        h= 0.5, 
        w=0.5,
        heading=0,
        minZ=45.49,
        maxZ=46.29,
        doorname='prison gate 2',
        busy=false,   
    },
    {
        item="thermite",
        coord=vector3(1791.72, 2597.53, 45.55),
        h= 0.5, 
        w=0.5,
        heading=0,
        minZ=45.35,
        maxZ=46.15,
        doorname='prison gate 3',
        thermitecoord= vector3(1846.78, 2572.49, 45.67),
        busy=false,  
    },
 
}

Config.jailbreakpoliceneed=0

--- QBCore Framework related settings
Config.Inventory            = 'player' -- 'exports' for using qb-inventory exports or 'player' for using Player object functions
Config.Phone                = 'QBCore' -- 'This script supports standard QBCore, GKS Phone, options: (QBCore/GKS)'

--- Script related settings
Config.Debug                = true  -- Enables or disables extra console prints to the scripts
Config.AntiHelicopter       = true -- Enable or disable the guards that will shoot players if they enter prison with a helicopter to pick up someone
Config.JailBreakCops        = 0     -- Amount of cops on duty required to start a jailbreak
Config.JailBreakDuration    = 60    -- time in minutes that players have to comlete the jailbreak before breaking someone out is impossible
Config.BlipCoords           = vector3(1686.41, 2605.65, 45.55)           -- Bolingbroke Penitentiary blip location
Config.ReceptionPedCoords   = vector4(1840.35, 2577.71,  45.01, 358.01)   -- ped location for reception interaction
Config.BMXCoords            = vector4(1635.26, 2586.8, 44.79, 0.58)   -- ped location to grab BMX
Config.SpawnBMX             = vector3(1631.15, 2591.45, 45.55)            -- spawn location of BMX
Config.GardeningPed         = vector4(5000.63, 2551.78, 44.55, 242.68)  -- ped location for farming supplies
Config.InfirmaryPed         = vector4(1769.91, 2571.81, 45.73, 130.19)  -- ped location for infirmary
Config.SlushieSpoonChance   = 10    -- %Chance to receive a spoon after drinking a slushie
Config.KitchenRewardAmount  = 3     -- Amount that a player receives of a random item when doing kitchen jobs, chance per task is in kitchenTasks in sv_jobs
Config.CleaningTaskAmount   = 14    -- Amount of cleaning tasks that are generated per iteration, can't be higher than amount of objects in cleaningSetup (33)
Config.ScrapRewardAmount    = 1     -- Amount that a player receives of a random item when doing scrapyard jobs
Config.ScrapRewardChance    = 14    -- %Chance to receive an item when doing a scrapyard job
Config.FarmingLoopInterval  = 4     -- Minutes for the farming loop to increase growth and health based on water and nutrition
Config.FarmingHarvestAmount = 5     -- Amount of prisonfruit a player gets from harvesting a farming patch

Config.ReduceReward = { -- %Chance to reduce the jail sentence after completing a task; Amount of minutes to reduce the jail time with
    gardening   = { chance = 28,    amount = 5 },
    -- running     = { chance = 24,    amount = 3 },
    scrapyard   = { chance = 14,    amount = 3 },
    cleaning    = { chance = 14,    amount = 7 },
    workout     = { chance = 10,    amount = 3 },
    kitchen     = { chance = 14,    amount = 3 },
    electrical  = { chance = 14,    amount = 5 },
    lockup      = { chance = 0,     amount = 0 }
}

Config.scrapYardSetup = {
    [1] = {
        model = `prop_pile_dirt_03`,
        coords =vector3(1639.619, 2524.627, 44.41488),
        heading = 120.00,
        rewards = {'aluminum', 'steel', 'iron', 'copper', 'prisonrock'}
    },
    [2] = {
        model = `prop_rub_pile_01`,
        coords = vector3(1641.9, 2535.27, 44.20442),
        heading = 90.00,
        rewards = {'copper'}
    },
    [3] = {
        model = `prop_pile_dirt_02`,
        coords = vector3(1649.593, 2533.013, 44.48488),
        heading = 90.00,
        rewards = {'copper'} -- unused
    }
}

Config.workoutSetup = {
    [1] = {
        model = `prop_pris_bench_01`,
        coords =vector4(1772.2141113281, 2499.9567871094, 44.823787689209, 30.311080932617),
    },
    [2] = {
        model = `prop_weight_rack_02`,
        coords =vector4(1779.2005615234, 2502.0964355469, 44.825485229492, 120.4049987793),
    },
    [3] = {
        model = `prop_pris_bars_01`,
        coords =vector4(1774.3331298828, 2496.8713378906, 44.723036193848, 37.5)
    }
}
--- Economy
Config.CraftingCost = {
    [1] = {
        item = 'lockpick',
        header = 'Lockpick Set',
        amount = 1,
        duration = 5000,
        durationLabel = 'Short',
        items = {
            [1] = {
                item = 'copper',
                amount = 7
            },
            [2] = {
                item = 'iron',
                amount = 5
            },
            [3] = {
                item = 'aluminum',
                amount = 2
            }
        }
    },
    [2] = {
        item = 'prisonwine',
        header = 'Pruno',
        amount = 1,
        duration = 12000,
        durationLabel = 'Medium',
        items = {
            [1] = {
                item = 'prisonfruit',
                amount = 5
            },
            [2] = {
                item = 'prisonsugar',
                amount = 8
            },
            [3] = {
                item = 'prisonbag',
                amount = 1
            },
            [4] = {
                item = 'prisonslushie',
                amount = 3
            },
            [5] = {
                item = 'prisonjuice',
                amount = 3
            }
        }
    },
    [3] = {
        item = 'weapon_knife',
        header = 'Knife',
        amount = 1,
        duration = 36000,
        durationLabel = 'Long',
        items = {
            [1] = {
                item = 'prisonspoon',
                amount = 1
            },
            [2] = {
                item = 'prisonrock',
                amount = 2
            }
        }
    }
}

Config.PrisonerPedShop = {
    [1] = {
        item = 'phone',
        header = 'Phone',
        text = "To make contact with the outside",
        cost = {item = "prisonspoon", amount = 20}
    }
}
Config.gardenprop={
    {coord=vector3(1718.4621582031, 2550.6962890625, 44.552795410156),
    prop='bzzz_prop_seeds_001',
    handle = 0,
    planted = false,
    dead = false,
    growth = 0,
    stage = 1,
    health = 100,
    water = 0,
    fertilizer = 0
    },
    {coord= vector3(1715.1140136719, 2540.0122070312, 44.552806854248),
    prop='bzzz_prop_seeds_001',
    handle = 0,
    planted = false,
    dead = false,
    growth = 0,
    stage = 1,
    health = 100,
    water = 0,
    fertilizer = 0   
    },
    {coord=vector3(1713.5645751953, 2551.79296875, 44.552806854248),
    prop='bzzz_prop_seeds_001',
    handle = 0,
    planted = false,
    dead = false,
    growth = 0,
    stage = 1,
    health = 100,
    water = 0,
    fertilizer = 0    
    },
}
Config.kichentable={
    {coord=vector3(1780.62, 2550.29, 45.67),h=1.3,w=2.5,heading=90,minz=45.27,maxz=45.97},
    {coord=vector3(1780.63, 2547.27, 45.67),h=1.3,w=2.5,heading=270,minz=45.27,maxz=45.97},
    {coord=vector3(1784.99, 2550.3, 45.67),h=1.3,w=2.5,heading=270,minz=45.27,maxz=45.97},
    {coord=vector3(1784.96, 2547.26, 45.67),h=1.3,w=2.5,heading=270,minz=45.27,maxz=45.97},
    {coord=vector3(1788.64, 2547.26, 45.67),h=1.3,w=2.5,heading=270,minz=45.27,maxz=45.97},
    {coord=vector3(1788.67, 2550.27, 45.67),h=1.3,w=2.5,heading=270,minz=45.27,maxz=45.97},
    {coord=vector3(1788.33, 2555.98, 45.67),h=1.3,w=2.5,heading=7,minz=45.27,maxz=45.97},
}
--- Coordinates for teleportation
Config.Locations = {
    ['exit']        = vector4(1836.98, 2591.12, 45.01, 180.00),
    ['mugshot']     = vector4(1844.60, 2594.35, 45.01, 90.00),
    ['services']    = vector3(1828.70, 2580.17, 46.01),
    ['cells'] = { -- You don't really want to this these here
        [1]     = vector4(1768.10, 2500.25, 44.74, 210.00),
        [2]     = vector4(1764.64, 2498.91, 44.74, 210.00),
        [3]     = vector4(1761.20, 2497.47, 44.74, 210.00),
        [4]     = vector4(1755.07, 2493.48, 44.74, 210.00),
        [5]     = vector4(1751.99, 2491.72, 44.74, 210.00),
        [6]     = vector4(1748.81, 2489.95, 44.74, 210.00),
        [7]     = vector4(1767.85, 2500.76, 48.69, 210.00),
        [8]     = vector4(1764.67, 2498.97, 48.69, 210.00),
        [9]     = vector4(1761.25, 2497.09, 48.69, 210.00),
        [10]    = vector4(1758.30, 2495.28, 48.69, 210.00),
        [11]    = vector4(1755.10, 2493.63, 48.69, 210.00),
        [12]    = vector4(1751.97, 2491.73, 48.69, 210.00),
        [13]    = vector4(1748.70, 2489.80, 48.69, 210.00),
        [14]    = vector4(1758.42, 2472.79, 44.74, 30.00),
        [15]    = vector4(1761.44, 2474.73, 44.74, 30.00),
        [16]    = vector4(1764.50, 2476.30, 44.74, 30.00),
        [17]    = vector4(1767.75, 2478.51, 44.74, 30.00),
        [18]    = vector4(1770.54, 2480.31, 44.74, 30.00),
        [19]    = vector4(1774.19, 2481.78, 44.74, 30.00),
        [20]    = vector4(1777.28, 2483.62, 44.74, 30.00),
        [21]    = vector4(1758.13, 2473.03, 48.69, 30.00),
        [22]    = vector4(1761.51, 2474.30, 48.69, 30.00),
        [23]    = vector4(1764.71, 2476.23, 48.69, 30.00),
        [24]    = vector4(1767.61, 2478.39, 48.69, 30.00),
        [25]    = vector4(1770.74, 2480.02, 48.69, 30.00),
        [26]    = vector4(1774.03, 2481.64, 48.69, 30.00),
        [27]    = vector4(1777.12, 2483.52, 48.69, 30.00)
    },
}

Config.Electrical = { -- You don't really want to touch anything here, unless you want to add extra entries (Coords), completed changes dynamically during the script)
    [1] = { coords = vector4(1723.33, 2505.78, 45.55, 211.55),    completed = false },
    [2] = { coords = vector4(1718.63, 2488.1, 45.55, 172.54),    completed = false },
    [3] = { coords = vector4(1668.09, 2488.28, 45.55, 184.54),  completed = false },
    [4] = { coords = vector4(1657.33, 2488.79, 45.55, 142.54),    completed = false },
    [5] = { coords = vector4(1618.7, 2521.22, 45.55, 136.54),  completed = false },
    [6] = { coords = vector4(1616.93, 2528.02, 45.55, 91.54),    completed = false },
    [7] = { coords = vector4(1629.71, 2564.89, 45.55, 1.54),  completed = false },
    [8] = { coords = vector4(1652.37, 2564.88, 45.55, 4.53),  completed = false },
    [9] = { coords = vector4(1616.86, 2578.55, 45.56, 87.3),  completed = false },
    [10] = { coords = vector4(1687.53, 2533.26, 45.48, 263.16),  completed = false },
}

--- Prison break related states, these change dynamically during the script
Config.JailBreak = {
    PowerplantHit = false,
    JailBreakActive = false,
    Thermite = {
        [1] = { vector4(1846.73, 2571.49, 45.77, 90.00), vector3(1846.78, 2572.49, 45.67), 'jail-gate1', false },
        [2] = { vector4(1791.95, 2612.11, 45.67, 90.00), vector3(1791.98, 2613.11, 45.57), 'jail-gate3', false },
        [3] = { vector4(1761.14, 2517.25, 45.67, 255.0), vector3(1761.10, 2518.27, 45.57), 'jail-door5', false },
    },
    VARHack = false
}

--- Settings for the difficulty of the minigames
Config.Minigames = {
    ThermiteSettings = {
        correctBlocks = 7, -- correctBlocks = Number of correct blocks the player needs to click
        incorrectBlocks = 4, -- incorrectBlocks = number of incorrect blocks after which the game will fail
        timetoShow = 5, -- timetoShow = time in secs for which the right blocks will be shown
    },
    VarSettings = {
        varBlocks = 2, -- Amount of blocks displayed during the VAR Hack minigame
    }
}