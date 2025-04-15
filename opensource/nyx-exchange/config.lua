Config = Config or {}
Config.PoliceNeeded = 8
Config.PoliceJobs = { -- Jobs that can access the laundromat 
    'police',
}

Config.PowerLocations = {
    ['generator'] = {
        label = 'Cut Generator Power',
        coords = vector3(438.40307617188, -1904.7091064453, 25.927848815918),
        isBusy = false, -- dont touch
        cut = false, -- dont touch
        doorids = { -- doorids to unlock when power is cut (dont touch unless you know what you're doing)
            'exchange-back',
            'exchange-inner',
        },
        requireditem = 'laundro_gen_usb', -- item required to cut the power if you dont want to require an item leave it empty ('') without the brackets
    },
    ['alarm'] = {
        label = 'Cut Alarm Power',
        coords = vector3(432.51, -1906.88, 26.44),
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
        isBusy = false, -- dont touch
        cut = false, -- dont touch
        doorids = { -- doorids to unlock when power is cut (dont touch unless you know what you're doing)
            'exchange-inner-2',
            'exchange-inner-3',
        },
        requireditem = 'laundro_gen_usb', -- item required to cut the power if you dont want to require an item leave it empty ('') without the brackets
    },

    ['generator_2'] = {
        label = 'Cut Generator Power',
        coords = vector3(438.40307617188, -1904.7091064453, 25.927848815918),
        isBusy = false, -- dont touch
        cut = false, -- dont touch
        doorids = { -- doorids to unlock when power is cut (dont touch unless you know what you're doing)
            'exchange-back',
            'exchange-inner',
        },
        requireditem = 'laundro_gen_usb', -- item required to cut the power if you dont want to require an item leave it empty ('') without the brackets
    },
    ['alarm_2'] = {
        label = 'Cut Alarm Power',
        coords = vector3(432.51, -1906.88, 26.44),
        isBusy = false, -- dont touch
        cut = false, -- dont touch
        doorids = { -- doorids to unlock when power is cut (dont touch unless you know what you're doing)
            'exchange-inner-1',
            'exchange-front',
        },
        requireditem = 'laundro_gen_usb', -- item required to cut the power if you dont want to require an item leave it empty ('') without the brackets
    },

    ['doorhack_2'] = {
        label = 'Hack The Smart Door',
        coords = vector3(426.88, -1901.03, 26.46),
        isBusy = false, -- dont touch
        cut = false, -- dont touch
        doorids = { -- doorids to unlock when power is cut (dont touch unless you know what you're doing)
            'exchange-inner-2',
            'exchange-inner-3',
        },
        requireditem = 'laundro_gen_usb', -- item required to cut the power if you dont want to require an item leave it empty ('') without the brackets
    },
}


Config.reward = {
    reward = { 
        item = 'banded_cash',
        amount = {min = 5000, max = 10000},
    },
}

Config.trollys = {
    trolly = {
        [1] = {
            type = 'money',
            taken = false,
            coords = vector4(433.74, -1899.77, 26.46, 100.9)
        },
        [2] = {
            type = 'money',
            taken = false,
            coords = vector4(432.12, -1901.31, 26.46, 13.66)
        },
        [3] = {
            type = 'money',
            taken = false,
            coords = vector4(432.3, -1898.47, 26.46, 225.17)
        }
    }
}

Config.TradeItems = {
    {
        item = "coin",
        reward = "cash"
    },
}

Config.Peds = {
    {
        model = "a_m_m_farmer_01",
        coords = vector4(424.76, -1897.21, 26.46, 45.52),
    },
    -- {
    --     model = "a_m_m_farmer_01",
    --     coords = vector4(130.67, -1347.32, 29.71, 318.12),
    -- },
}
