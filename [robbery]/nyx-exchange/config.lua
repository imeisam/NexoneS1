Config = Config or {}
Config.PoliceNeeded = 20
Config.PoliceJobs = { -- Jobs that can access the laundromat 
    'police',
}


Config.PowerLocations = {
    {
    ['generator'] = {
        label = 'Cut Generator Power',
        coords = vector3(438.40307617188, -1904.7091064453, 25.927848815918),
        animcoord= vector4(438.43, -1904.76, 25.93, 32.98),
        usbcoord=vector3(437.912262, -1904.46094, 26.2491665),
        alarmcoord=vector3(433.3, -1896.59, 28.42),
        isBusy = false, -- dont touch
        cut = false, -- dont touch
        doorids = { -- doorids to unlock when power is cut (dont touch unless you know what you're doing)
            'exchange-back',
        },
        requireditem = 'laundro_gen_usb', -- item required to cut the power if you dont want to require an item leave it empty ('') without the brackets
    },
    ['alarm'] = {
        label = 'Cut Alarm Power',
        coords = vector3(432.51, -1906.88, 26.44),
        animcoord= vector4(432.58, -1906.81, 25.98, 136.56),
        usbcoord= vector3(432.305969, -1907.07056, 26.3831558),
        isBusy = false, -- dont touch
        cut = false, -- dont touch
        doorids = { -- doorids to unlock when power is cut (dont touch unless you know what you're doing)
            'exchange-inner-1',
            'exchange-front',
        },
        requireditem = 'laundro_gen_usb', -- item required to cut the power if you dont want to require an item leave it empty ('') without the brackets
    },

    ['doorhack'] = {
        label = 'Hack The Smart Door',
        coords = vector3(426.88, -1901.03, 26.46),
        laptopanim=vector3(427.04, -1900.9, 27.61),
        isBusy = false, -- dont touch
        cut = false, -- dont touch
        doorids = { -- doorids to unlock when power is cut (dont touch unless you know what you're doing)
            'exchange-inner-2',
            'exchange-inner-3',
        },
        requireditem = 'laundro_gen_usb', -- item required to cut the power if you dont want to require an item leave it empty ('') without the brackets
    },
},
}


Config.reward = {
    reward = { 
        item = 'banded_cash',
        amount = {min = 10000, max = 20000},
    },
}

Config.trollys = {
   {
        [1] = {
            type = 'money',
            taken = false,
            spawned = false,
            coords = vector4(433.74, -1899.77, 26.46, 100.9)
        },
        [2] = {
            type = 'money',
            taken = false,
            spawned = false,
            coords = vector4(432.12, -1901.31, 26.46, 13.66)
        },
        [3] = {
            type = 'money',
            taken = false,
            spawned = false,
            coords = vector4(432.3, -1898.47, 26.46, 225.17)
        }
    },
}

Config.TradeItems = {
    {
        item = "coin",
        reward = "cash"
    },
}

Config.Peds = {
    -- {
    --     model = "a_m_m_farmer_01",
    --     coords =vector3(425.05194091797, -1897.5450439453, 26.461709976196),

    -- },
    -- {
    --     model = "a_m_m_farmer_01",
    --     coords = vector3(130.67, -1347.33, 29.71),
    -- },
}
