Config = {}

-- Minigame Settings
Config.Difficulty = {
    Easy = {
        time = 5000, -- 5 seconds
        successChance = 0.8 -- 80% chance
    },
    Medium = {
        time = 3000, -- 3 seconds
        successChance = 0.6 -- 60% chance
    },
    Hard = {
        time = 2000, -- 2 seconds
        successChance = 0.4 -- 40% chance
    }
}

-- Rewards
Config.Rewards = {
    Easy = {
        min = 100,
        max = 500
    },
    Medium = {
        min = 500,
        max = 1000
    },
    Hard = {
        min = 1000,
        max = 2000
    }
}

-- Cooldown (in minutes)
Config.Cooldown = 5

-- Police Alert Settings
Config.PoliceAlert = {
    enabled = true,
    requiredCops = 2,
    alertRadius = 50.0
} 