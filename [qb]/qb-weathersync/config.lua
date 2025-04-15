Config                  = {}
Config.DynamicWeather   = true -- Set this to false if you don't want the weather to change automatically every 10 minutes.

-- On server start
Config.realtimedif      =  6  --- (sec) diffrent real to game
Config.StartWeather     = 'CLEAR' -- Default weather                       default: 'EXTRASUNNY'
Config.BaseTime         = 8 -- Time                                             default: 8
Config.TimeOffset       =math.random(0, 23) -- Time offset                                      default: 0
Config.FreezeTime       = false -- freeze time                                  default: false
Config.Blackout         = false -- Set blackout                                 default: false
Config.BlackoutVehicle  = false -- Set blackout affects vehicles                default: false
Config.NewWeatherTimer  = 120 -- Time (in minutes) between each weather change   default: 10
Config.Disabled         = false -- Set weather disabled                         default: false
Config.RealTimeSync     = false -- Activate realtime synchronization            default: false

Config.AvailableWeatherTypes = { -- DON'T TOUCH EXCEPT IF YOU KNOW WHAT YOU ARE DOING
    'EXTRASUNNY',
    'CLEAR',
    'NEUTRAL',
    'SMOG',
    'FOGGY',
    'OVERCAST',
    'CLOUDS',
    'CLEARING',
    'RAIN',
    'THUNDER',
    'SNOW',
    'BLIZZARD',
    'SNOWLIGHT',
    'XMAS',
    'HALLOWEEN',
}

Config.AdminWeathers = { -- List of available weathers for admin menu
    {text  = "BLIZZARD", value = "BLIZZARD"},
    {text  = "CLEAR", value = "CLEAR"},
    {text  = "CLEARING", value = "CLEARING"},
    {text  = "CLOUDS", value = "CLOUDS"},
    {text  = "EXTRASUNNY", value = "EXTRASUNNY"},
    {text  = "FOGGY", value = "FOGGY"},
    {text  = "HALLOWEEN", value = "HALLOWEEN"},
    {text  = "NEUTRAL", value = "NEUTRAL"},
    {text  = "OVERCAST", value = "OVERCAST"},
    {text  = "RAIN", value = "RAIN"},
    {text  = "SMOG", value = "SMOG"},
    {text  = "SNOW", value = "SNOW"},
    {text  = "SNOWLIGHT", value = "SNOWLIGHT"},
    {text  = "THUNDER", value = "THUNDER"},
    {text  = "XMAS", value = "XMAS"},
}
Config.scriptzone={
    -- ['prison']={
    --     blackout=true,
    --   coord={
    --     vector2(1954.52734375, 1370.701171875),
    --     vector2(934.35791015625, 1659.9654541016),
    --   } 
    -- }
}
Config.zone={
    ['santos']={
        coord={
            vector2(4561.9931640625, -4065.748046875),
            vector2(4809.1127929688, 1836.2026367188),
            vector2(-789.36505126953, 1994.4796142578),
            vector2(-561.87634277344, 5052.9194335938),
            vector2(-5135.0673828125, 5052.8999023438),
            vector2(-5085.4067382812, -4407.8735351562),
        },
        autoweather={'CLEAR'},
        lastWeather="CLEAR",
        blackout=false,
        freezweather=false,
    },
    ['sandy']={
        coord={
            vector2(4854.4375, 5370.115234375),
            vector2(4809.1127929688, 1836.2026367188),
            vector2(-789.36505126953, 1994.4796142578),
            vector2(-561.87634277344, 5052.9194335938)
        },
        autoweather={'CLEAR'},
        lastWeather="CLEAR",
        blackout=false,
        freezweather=false,
    },
    ['paleto']={
        coord={
            vector2(4854.4375, 5370.115234375),
            vector2(-4252.578125, 5401.4052734375),
            vector2(-4297.3940429688, 8165.4018554688),
            vector2(5974.193359375, 8165.40234375),
        },
        autoweather={'CLEAR'},
        lastWeather="CLEAR",
        blackout=false,
        freezweather=false,
    },
    -- ['cayo']={
    --     coord={
    --         vector2(-756.89300537109, 3415.3518066406),
    --         vector2(-734.67059326172, 1617.0354003906),
    --         vector2(1667.5238037109, 2211.0495605469),
    --         vector2(2463.9318847656, 5205.2578125)
    --     },
            -- autoweather={'RAIN','SNOW','THUNDER'},
    --     lastWeather="RAIN",
    --     blackout=false,
    --     freezweather=false,
    -- },
}