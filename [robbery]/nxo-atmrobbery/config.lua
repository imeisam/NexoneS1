Config = {}

Config.MinimumATMRobberyPolice =4

Config.ItemName = "towingrope"
Config.ATMItemName = "atmobject"
Config.iligalpoint=5
Config.PoliceAlert = true
Config.cooldown=60 --min
Config.RemoveItemToUsed = true
Config.itemchance=35
Config.itemdropname='laptopg'
Config.MaxTry = 15

Config.Point = {
    ["GodPower"] = 2,
    ["MinPower"] = 1,
}

Config.ATMs = {
    "prop_atm_02",
    "prop_atm_03",
    "prop_fleeca_atm"
}

Config.BlackListCar = {
    8, -- Motorcycles 
    13, -- Cycles  
    14, -- Boats 
    15, -- Helicopters  
    16, -- Planes  
    18, -- Emergency 
    21, -- Trains
}

Config.PowerCar = {
    8, -- SUVs  
    15, -- Off-road  
    20, -- Vans 
}

Config.AttachCarTimer = 5000
Config.AttachATMTimer = 10000
Config.SearchATMTimer = 15000
Config.PickUpATMTimer = 15000

Config.SearchRewardCash = {
    ["min"] = 3000,
    ["max"] = 3200
}

Config.ATMRewardCash = {
    ["min"] = 3200,
    ["max"] = 3500
}

Config.ATMSell = vector3(-2220.63, -366.96, 13.32)

Config.LockPick = {
    ["timer-min"] = 7,
    ["timer-max"] = 12,
    ["circles-min"] = 3,
    ["circles-max"] = 4,
}