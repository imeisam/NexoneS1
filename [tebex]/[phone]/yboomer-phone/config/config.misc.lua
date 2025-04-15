Config = Config or {}

Config.Security = {}

Config.Security.MaxAttempts = 5    -- The maximum number of attempts to unlock the phone before it gets locked. Default *5.
Config.Security.BaseLockTime = 60  -- Base time to lock the phone getafter max attempts) in seconds. Default *60s == 1 minute.
Config.Security.LockMultiplier = 2 -- Multiplier for each failed attempt. Default *2. (1st attempt = 60s, 2nd attempt = 120s, 3rd attempt = 240s, etc.)

Config.RealTime = true

-- !! Only for QBCore/QBX !!
Config.Death = {}
Config.Death.CheckDeathTimeout = 2500 -- Check for death. (default 2500ms == 2.5s). !! Only for QBCore/QBX !!
Config.Death.LastStand = true         -- Enable phone usage on last stand. !! Only for QBCore/QBX !!
-- !! Only for QBCore/QBX !!