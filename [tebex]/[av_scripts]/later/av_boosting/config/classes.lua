Config = Config or {}
Config.Classes = {
    ["D"] = {
        ["Prices"] = {normal = {min = 1, max = 2}, vinscratch = {min = 20, max = 30}, payout = 10},
        ['Cops'] = { -- Min cops needed to start the contract
            ['normal'] = 0,
            ['vin'] = 0,
        },
        ["EXP"] = {driver = {min = 5, max = 10}, hacker = {min = 5, max = 10}, group = {min = 4, max = 7}},
        ["FailEXP"] = {min = 2, max = 5}, -- If the DeliveryTime expires, we will remove EXP from the driver (doesn't affect hacker)
        ['ContractTime'] = 2, -- (in hours) Time to start a contract before it expires
        ["Hacks"] = false,
        ["NextClass"] = "C",
        ["Guards"] = {min = 1, max = 2},
        ["Weapons"] = {"WEAPON_BAT", "WEAPON_KNUCKLE"}
    },
    ["C"] = {
        ["Prices"] = {normal = {min = 2, max = 4}, vinscratch = {min = 30, max = 40}, payout = 20},
        ['Cops'] = { -- Min cops needed to start the contract
            ['normal'] = 2,
            ['vin'] = 4,
        },
        ["EXP"] = {driver = {min = 5, max = 10}, hacker = {min = 5, max = 10}, group = {min = 4, max = 7}},
        ["FailEXP"] = {min = 3, max = 5},
        ['ContractTime'] = 2,
        ["Hacks"] = {min = 1, max = 2},
        ["NextClass"] = "B",
        ["Guards"] = {min = 2, max = 3},
        ["Weapons"] = {"WEAPON_BAT", "WEAPON_CROWBAR"}
    },
    ["B"] = {
        ["Prices"] = {normal = {min = 3, max = 5}, vinscratch = {min = 40, max = 60}, payout = 30},
        ['Cops'] = { -- Min cops needed to start the contract
            ['normal'] = 4,
            ['vin'] = 8,
        },
        ["EXP"] = {driver = {min = 5, max = 10}, hacker = {min = 5, max = 10}, group = {min = 4, max = 7}},
        ["FailEXP"] = {min = 4, max = 7},
        ['ContractTime'] = 2,
        ["Hacks"] = {min = 2, max = 3},
        ["NextClass"] = "A",
        ["Guards"] = {min = 2, max = 3},
        ["Weapons"] = {"WEAPON_MACHETE", "WEAPON_BATTLEAXE"}
    },
    ["A"] = {
        ["Prices"] = {normal = {min = 5, max = 8}, vinscratch = {min = 60, max = 80}, payout = 40},
        ['Cops'] = { -- Min cops needed to start the contract
            ['normal'] = 0,
            ['vin'] = 8,
        },
        ["EXP"] = {driver = {min = 10, max = 20}, hacker = {min = 10, max = 15}, group = {min = 8, max = 12}},
        ["FailEXP"] = {min = 6, max = 10},
        ['ContractTime'] = 2,
        ["Hacks"] = {min = 3, max = 5},
        ["NextClass"] = "A+",
        ["Guards"] = {min = 3, max = 4},
        ["Weapons"] = {"WEAPON_PISTOL"}
    },
    ["A+"] = {
        ["Prices"] = {normal = {min = 10, max = 20}, vinscratch = {min = 80, max = 100}, payout = 50},
        ['Cops'] = { -- Min cops needed to start the contract
            ['normal'] = 6,
            ['vin'] = 10,
        },
        ["EXP"] = {driver = {min = 15, max = 25}, hacker = {min = 10, max = 20}, group = {min = 8, max = 15}},
        ["FailEXP"] = {min = 10, max = 15},
        ['ContractTime'] = 2,
        ["Hacks"] = {min = 5, max = 7},
        ["NextClass"] = "S",
        ["Guards"] = {min = 3, max = 4},
        ["Weapons"] = {"WEAPON_PISTOL50"}
    },
    ["S"] = {
        ["Prices"] = {normal = {min = 15, max = 30}, vinscratch = {min = 100, max = 120}, payout = 60},
        ['Cops'] = { -- Min cops needed to start the contract
            ['normal'] = 8,
            ['vin'] = 12,
        },
        ["EXP"] = {driver = {min = 20, max = 30}, hacker = {min = 15, max = 25}, group = {min = 13, max = 20}},
        ["FailEXP"] = {min = 15, max = 20},
        ['ContractTime'] = 2,
        ["Hacks"] = {min = 8, max = 10},
        ["NextClass"] = "S+",
        ["Guards"] = {min = 4, max = 5},
        ["Weapons"] = {"WEAPON_MICROSMG", "WEAPON_COMBATPDW", "WEAPON_MINISMG", "WEAPON_COMPACTRIFLE"}
    },
    ["S+"] = {
        ["Prices"] = {normal = {min = 40, max = 50}, vinscratch = {min = 120, max = 150}, payout = 70},
        ['Cops'] = { -- Min cops needed to start the contract
            ['normal'] = 8,
            ['vin'] = 12,
        },
        ["EXP"] = {driver = {min = 25, max = 35}, hacker = {min = 25, max = 30}, group = {min = 15, max = 25}},
        ["FailEXP"] = {min = 20, max = 30},
        ['ContractTime'] = 2,
        ["Hacks"] = {min = 10, max = 12},
        ["NextClass"] = "Max",
        ["Guards"] = {min = 4, max = 5},
        ["Weapons"] = {"WEAPON_COMPACTRIFLE", "WEAPON_ASSAULTRIFLE", "WEAPON_ADVANCEDRIFLE"}
    },
}