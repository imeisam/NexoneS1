Config = {}

Config.Framework        = "qb" -- "qb"
Config.Inventory        = "qb" -- "ps", "qb", "ox", "qs"
Config.Target           = "qb" -- qb
Config.FrameworkPseudo  = 'qb-core'
Config.AreaSize         = 3.0 --  Z is considered aswell.
Config.Img              = 'qb-inventory/html/images/'-- 'qb-inventory/html/images/'
Config.debug            = false -- set to true to see the mining from each rack on server console
Config.QBInventory      = "old" -- new
Config.UseBuckets       = true -- Keep it false unless you want to use props inside the apartments and houses taht uses buckets (instance) (Not Recommended)

Config.ServerName = 'Nexone'   -- prefix for usernames
Config.decay = 0.01 -- Decay of the items performance / update time (3 min default 'Config.DataUpdate')

Config.Minigames = {
    SmokeCrack = 6 , -- 3s progressbar speed
    Noid       = 2 , -- 1s Refresh Caracters
}

Config.EnableQbCrypto = false ----------------------- ONLY FOR QB

Config.Currency = {
    Butc = math.random(1000,2000) -- 1 butc = random value between (250 and 400)
}

Config.UnHackPC = 30 -- minutes

Config.Apps = {
    { name = "AntiVirus",   rep = 8,   wifi =  true,   price = 10, default = false}, 
    { name ="AppStore",     rep = 0,    wifi =  false,  price = 0,  default = true},
    { name ="Binunce",      rep = 0,    wifi =  false,  price = 0,  default = false},
    { name ="SmokeCrack",   rep = 0,    wifi =  false,  price = 3, default = false},
    { name ="Drone",        rep = 10,   wifi =  true,   price = 5, default = false},
    { name ="MinerExt",     rep = 4,   wifi =  false,  price = 10, default = false},
    { name ="Miner",        rep = 0,    wifi =  false,  price = 0,  default = false},
    { name ="Noid",         rep = 6,   wifi =  true,   price = 3, default = false},
    { name ="Notepad",      rep = 0,    wifi =  false,  price = 0,  default = false},
    { name ="Salty",        rep = 0,    wifi =  false,  price = 2,  default = false},
    { name ="Sniff",        rep = 8,   wifi =  true,   price = 10, default = false},
    { name ="Wally",        rep = 0,    wifi =  true,   price = 0,  default = false},
    { name ="Explorer",     rep = 0,    wifi =  false,  price = 0,  default = true},
}

Config.Prices = {
    saltyScan       = 1,
    sniffScan       = 2,
    securityLevel1  = 5,
    securityLevel2  = 15,
    securityLevel3  = 30,
    securityLevel4  = 50,
    securityLevel5  = 100,
}

Config.Rep = {
    SniffSuccess       = 1, -- Adds (1 x hack level) to the rep on success 
    SmokeCrackSuccess  = 1, -- Adds (1 x hack level) to the rep on success
    SniffFail          = 0, -- Removes (0 x hack level)  from the rep on success
    SmokeCrackFail     = 0, -- Removes (0 x hack level) from the rep on success
}

Config.DefaultBackground = 'https://i.postimg.cc/QxDs8dgg/nexone.png'

Config.DefaultTheme =   {
    bckDarkBlue     = '#242a34eb', 
    boxshadow       = '#0c0e12',
    npgreen         = '#2fa996',
    backGreen       = '#1e403db0',
    redBack         = '#ff000021',
    redFont         = '#ff0000c6',
    fontWhiteColor  = '#ffffffa1',
    upperBar        = '#131a1d',
    greyBck         = '#ffffff0f',
    whiteBorders    = '#ffffff4a',
    backBlue        = '#1e394c',
    backOrange      = '#3d322ede',
    fontOrangeColor = '#c38853',
}

Config.Items = {
    ["zatpc"]           = {model = 'prop_gaming_table'},
    ["zatminingrack"]   = {model = 'prop_mining_rack'},
    ["zatminingfan"]    = {model = 'prop_mining_fan'},
    ["zatbaskets"]      = {model = 'prop_basket_s'},
    ["zatbasketm"]      = {model = 'prop_basket_m'},
}

Config.Storage = {
    ["zatbaskets"] = 5,
    ["zatbasketm"] = 15,
}

Config.RandomItems = false -- if to choose random items from the Config.Drone items or not
Config.FixedCount  = 4 -- Generate only 3 items from the Config.drone items (0 : randomly)
Config.DroneProp = 'prop_drone'
Config.Drone = {
      [1] = {
          name = 'blueprint',                             -- item name
          label = 'Blueprint - XTG-1080',                 -- label to display      
          price = 10,                                      -- price (BUTC)
          image = "nui://"..Config.Img..'blueprint.png',  -- image.png (same name as in the inventory/html/images)
          info  = { type = 'XTG-1080'},                   -- info or metadata
          amount = 1,
         },  
      [2] = {
          name = 'blueprint',                             -- item name
          label = 'Blueprint - Mining Rack',                    -- label to display      
          price = 15,                                      -- price (BUTC)
          image = "nui://"..Config.Img..'blueprint.png',  -- image.png (same name as in the inventory/html/images)
          info  = { type = 'miningrack'},                   -- info or metadata
          amount = 1,
         },
      [3] = {
          name = 'blueprint',                             -- item name
          label = 'Blueprint - GPU Rack Cooler',                    -- label to display      
          price = 10,                                      -- price (BUTC)
          image = "nui://"..Config.Img..'blueprint.png',  -- image.png (same name as in the inventory/html/images)
          info  = { type = 'miningfan'},                   -- info or metadata
          amount = 1,
         },
    --  [4] = {
    --      name = 'grinder',
    --      label = 'Grinder',
    --      price = 7,
    --      image = "nui://"..Config.Img..'grinder.png',
    --      info  = {},
    --      amount = 1,
    --     },
    --  [5] = {
    --      name = 'laundro_gen_usb',
    --      label = 'Clipper Chimp Pro',
    --      price = 10,
    --      image = "nui://"..Config.Img..'clipper.png',
    --      info  = {},
    --      amount = 1,
    --     },
}
Config.phone = 'qb-phone' -- for Drone Notification (if you are using another phone change it under (client/Framework/SnedPhonNotification))
Config.DroneLocations = {   -- ADD AS MANY COORDS AS YOU WANT
    [1]     = {coords = vector3(-715.34, -714.47, 29.13)        , busy = false},
    [2]     = {coords = vector3(-1181.55, -751.63, 19.59)       , busy = false},
    [3]     = {coords = vector3(-1320.8, -548.96, 32.14)        , busy = false},
    [4]     = {coords = vector3(-1374.45, -319.9, 39.54)        , busy = false},
    [5]     = {coords = vector3(-1414.89, -938.63, 10.76)       , busy = false},
    [6]     = {coords = vector3(-1537.65, -3214.44, 13.94)      , busy = false},
    [7]     = {coords = vector3(-979.28, -1961.36, 13.19)       , busy = false},
    [8]     = {coords = vector3(-1284.19, -1611.29, 4.1)        , busy = false},
    [9]     = {coords = vector3(-1807.88, -404.4, 44.61)        , busy = false},
    [10]    = {coords = vector3(-2252.65, 378.06, 174.6)        , busy = false},
    [11]    = {coords = vector3(-1102.79, 2726.59, 18.8)        , busy = false},
    [12]    = {coords = vector3(245.64, 3173.59, 42.74)         , busy = false},
    [13]    = {coords = vector3(1311.82, 2986.26, 41.56)        , busy = false},
    [14]    = {coords = vector3(2374.92, 3058.21, 48.15)        , busy = false},
    [15]    = {coords = vector3(2745.88, 2788.74, 35.44)        , busy = false},
}


-- 1 BUTCOIN / 24 Hours
-- 1 BUTCOIN / 1440 Minutes
-- 1 BUTCOIN / 480 x 3 minutes
-- 1/480 = 0.00208 BUTCOIN every 3 minutes 
Config.DataUpdate = 3 -- 3 minutes (keep it more than 3 minutes)
Config.HackEarn = 0.10 -- 10% of the crypto on that pc
Config.Performance = {
    ------------------------ GPUs ---------------------------------
    ["XTR-4090"] = 0.00125 * 1.40, --> 1.39 BUTCOINS in 24 hours
    ["XTR-4080"] = 0.00125 * 1.30, --> 1.29 BUTCOINS in 24 hours
    ["XTR-4070"] = 0.00125 * 1.20, --> 1.19 BUTCOINS in 24 hours
    ["XTR-3090"] = 0.00125 * 1.17, --> 1.16 BUTCOINS in 24 hours
    ["XTR-3080"] = 0.00125 * 1.15, --> 1.14 BUTCOINS in 24 hours
    ["XTG-1080"] = 0.00125 * 1.10, --> 1.09 BUTCOINS in 24 hours
    ["XTG-1070"] = 0.00125 * 1.07, --> 1.06 BUTCOINS in 24 hours
    ["XTG-1660"] = 0.00125 * 1.05, --> 1.04 BUTCOINS in 24 hours
    ["XTG-980"]  = 0.00125 * 1.00, --> 1.00 BUTCOINS in 24 hours
    ------------------------ CPUs ---------------------------------
    ["NEZYR7-7950"]  = 0.00035 * 1.40, --> 1.39 BUTCOINS in 24 hours
    ["NEZYR7-7900"]  = 0.00035 * 1.30, --> 1.39 BUTCOINS in 24 hours
    ["LETNI9-14900"] = 0.00035 * 1.20, --> 1.39 BUTCOINS in 24 hours
    ["LETNI9-14700"] = 0.00035 * 1.15, --> 1.39 BUTCOINS in 24 hours
    ["LETNI7-13700"] = 0.00035 * 1.07, --> 1.39 BUTCOINS in 24 hours
    ["LETNI5-14600"] = 0.00035 * 1.05, --> 1.39 BUTCOINS in 24 hours
    ["LETNI5-13600"] = 0.00035 * 1.00, --> 1.39 BUTCOINS in 24 hours
    ------------------------ MBs ---------------------------------
    ["ETYBAGIG-B650E"]  = 0.00023 * 1.40, --> 1.39 BUTCOINS in 24 hours
    ["KCORSA-X670ELI"]  = 0.00023 * 1.30, --> 1.39 BUTCOINS in 24 hours
    ["ETYBAGIG-X670E"]  = 0.00023 * 1.20, --> 1.39 BUTCOINS in 24 hours
    ["GORSUSA-B550FL"]  = 0.00023 * 1.12, --> 1.39 BUTCOINS in 24 hours
    ["TXZNN7-B550LIE"]  = 0.00023 * 1.07, --> 1.39 BUTCOINS in 24 hours
    ["ETYBAGIG-Z970R"]  = 0.00023 * 1.05, --> 1.39 BUTCOINS in 24 hours
    ["GORSUSA-Z970LI"]  = 0.00023 * 1.00, --> 1.39 BUTCOINS in 24 hours
    ------------------------ PSs ---------------------------------
    ["RIASROC-RM750X"]  = 0.00025 * 1.40, --> 1.39 BUTCOINS in 24 hours
    ["CINOSAES-TX100"]  = 0.00025 * 1.30, --> 1.39 BUTCOINS in 24 hours
    ["GPXNOLYP-TX450"]  = 0.00025 * 1.20, --> 1.39 BUTCOINS in 24 hours
    ["TEIUQEB11-550W"]  = 0.00025 * 1.12, --> 1.39 BUTCOINS in 24 hours
    ["RIASROC-AX1600"]  = 0.00025 * 1.07, --> 1.39 BUTCOINS in 24 hours
    ["CINOSAES-SX100"]  = 0.00025 * 1.05, --> 1.39 BUTCOINS in 24 hours
    ["RIASROC-RM1200"]  = 0.00025 * 1.00, --> 1.39 BUTCOINS in 24 hours
}

----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------OPTIMISATION PART --------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
-- Description  : this part is responsable on deleting the not needed props when no players are nearby
-- refreshprops : is the time to check if there is someone near the props or not
-- radius       : is to check how far is the player from the prop if it is < then the prop will be deleted until someone is nearby...
Config.RefreshProps = 10     -- 15 seconds
Config.Radius       = 100.0  -- if the distance between the player and the prop is < 50 then the prop will be deleted.
----------------------------------------------------------------------------------------------------------------------------------------

