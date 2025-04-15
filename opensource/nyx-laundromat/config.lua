Config = Config or {}

Config.DoorLock = 'qb' -- Doorlock system to use (qb)
Config.Inventory = 'qb' -- Inventory system to use (ox, qb, ps, lj)
Config.Dispatch = 'ps' -- Dispatch system to use (ps, cd)
Config.PoliceNeeded = 8 -- Amount of police needed to rob the laundromat
Config.PoliceJobs = { -- Jobs that can access the laundromat 
    'police',
}

Config.PowerLocations = {
    ['generator'] = {
        label = 'Cut Generator Power',
        coords = vector3(106.4, -1559.38, 29.77),
        isBusy = false, -- dont touch
        cut = false, -- dont touch
        doorids = { -- doorids to unlock when power is cut (dont touch unless you know what you're doing)
            'laundromat-inner',
        },
        requireditem = 'laundro_gen_usb', -- item required to cut the power if you dont want to require an item leave it empty ('') without the brackets
    },
    ['power'] = {
        label = 'Cut Power',
        coords = vector3(96.58, -1565.01, 30.06),
        isBusy = false, -- dont touch
        cut = false, -- dont touch
        doorids = 'laundromat-office',
        requireditem = 'laundro_gen_usb', -- item required to cut the power 
    },
}

Config.Usb = {
    usbchance = 100, -- chance for the usb to spawn in the laundromat
    coords = vector3(94.9, -1556.74, 29.51),
    taken = false, -- dont touch
    item = { -- need to add your own usb items here (these are just examples)
        [1] = { name = 'usb_1', chance = 90, }, -- name = item name, chance = chance to get the item
        [2] = { name = 'usb_2', chance = 80, },
        [3] = { name = 'usb_3', chance = 35, },
        [4] = { name = 'usb_4', chance = 20, },
    },
}

Config.Safe = {
    coords = vector3(95.95, -1555.22, 30.02),
    opened = false, -- dont touch
    isBusy = false, -- dont touch
    attempts = 4, -- attempts to crack the safe
    reward = { -- reward for cracking the safe
        item = 'banded_cash', -- item to give
        amount = {min = 5000, max = 10000}, -- amount of the item to give (randomized)
    },
}

Config.WasherRewards = {
    item = 'coin', -- items that is set in the washer inventory
    amount = {min = 100, max = 150}, -- amount of the item you get from the washer (randomized)
}

Config.WasherInventory = {
    label = 'Nxo Laundromat', -- name of the laundromat inventory
    weight = 6000000, -- weight of the laundromat inventory
}

Config.LaundryMachines = {
    [1] = {
        coords = vector3(91.47, -1553.38, 29.85), -- coords of the washer (dont touch)
        isBusy = false, -- dont touch
        opened = false, -- dont touch
    },
    [2] = {
        coords = vector3(92.04, -1553.89, 29.85),
        isBusy = false,
        opened = false,
    },
    [3] = {
        coords = vector3(92.66, -1554.36, 29.85),
        isBusy = false,
        opened = false,
    },
    [4] = {
        coords = vector3(93.25, -1554.87, 29.85),
        isBusy = false,
        opened = false,
    },
    [5] = {
        coords = vector3(93.83, -1555.37, 29.85),
        isBusy = false,
        opened = false,
    },
    [6] = {
        coords = vector3(94.41, -1555.89, 29.85),
        isBusy = false,
        opened = false,
    },
    [7] = {
        coords = vector3(92.16, -1559.65, 29.68),
        isBusy = false,
        opened = false,
    },
    [8] = {
        coords = vector3(91.58, -1559.19, 29.68),
        isBusy = false,
        opened = false,
    },
    [9] = {
        coords = vector3(91.02, -1558.71, 29.68),
        isBusy = false,
        opened = false,
    },
    [10] = {
        coords = vector3(90.44, -1558.26, 29.68),
        isBusy = false,
        opened = false,
    },
    [11] = {
        coords = vector3(89.88, -1557.76, 29.68),
        isBusy = false,
        opened = false,
    },
    [12] = {
        coords = vector3(89.3, -1557.31, 29.68),
        isBusy = false,
        opened = false,
    },
    [13] = {
        coords = vector3(88.75, -1556.83, 29.68),
        isBusy = false,
        opened = false,
    },
    [14] = {
        coords = vector3(89.35, -1559.33, 29.68),
        isBusy = false,
        opened = false,
    },
    [15] = {
        coords = vector3(89.94, -1559.77, 29.68),
        isBusy = false,
        opened = false,
    },
    [16] = {
        coords = vector3(90.48, -1560.26, 29.68),
        isBusy = false,
        opened = false,
    },
    [17] = {
        coords = vector3(91.07, -1560.72, 29.68),
        isBusy = false,
        opened = false,
    },
    [18] = {
        coords = vector3(91.64, -1561.2, 29.68),
        isBusy = false,
        opened = false,
    },
    [19] = {
        coords = vector3(93.19, -1562.73, 29.68),
        isBusy = false,
        opened = false,
    },
    [20] = {
        coords = vector3(92.73, -1563.3, 29.68),
        isBusy = false,
        opened = false,
    },
    [21] = {
        coords = vector3(92.26, -1563.86, 29.68),
        isBusy = false,
        opened = false,
    },
    [22] = {
        coords = vector3(91.76, -1564.42, 29.68),
        isBusy = false,
        opened = false,
    },
    [23] = {
        coords = vector3(91.31, -1565.02, 29.68),
        isBusy = false,
        opened = false,
    },
    [24] = {
        coords = vector3(88.62, -1561.68, 29.91),
        isBusy = false,
        opened = false,
    },
    [25] = {
        coords = vector3(88.05, -1561.16, 29.92),
        isBusy = false,
        opened = false,
    },
    [26] = {
        coords = vector3(87.44, -1560.66, 29.93),
        isBusy = false,
        opened = false,
    },
    [27] = {
        coords = vector3(86.76, -1560.18, 29.8),
        isBusy = false,
        opened = false,
    },
    [28] = {
        coords = vector3(86.11, -1559.62, 29.8),
        isBusy = false,
        opened = false,
    },
    [29] = {
        coords = vector3(85.43, -1559.09, 29.8),
        isBusy = false,
        opened = false,
    },
}