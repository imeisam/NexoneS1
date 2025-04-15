return {
    debug = false,
    percent = 40, -- A 1 in x % for a package to spawn
    searchTime = 5000, -- How long the progress bar is
    searchLabel = 'Searching', -- Label of the progress bar
    blacklistedModels = { --All Models you dont want the script to spawn packages in
        [`caddy`] = true, -- Classed as a "automobile"
        [`forklift`] = true, -- Classed as a "automobile"
        [`blazer`] = true, -- Classed as a "automobile"
        [`mlue`] = true, -- Classed as a "automobile"
        [`mlue2`] = true, -- Classed as a "automobile"
        
    },
    packageProps = { -- The model of the objects that can spawn in the seat
    `ch_prop_ch_bag_01a`,
    `tr_prop_tr_bag_clothing_01a`,
        -- `prop_luggage_07a`,
        -- `v_res_fa_shoebox2`,
    },
    rewardItems = { --Items gotten after searching the package
        {
            item = 'bandage',
            minAmount = 1,
            maxAmount = 2
        },
        {
            item = 'cash',
            minAmount = 1,
            maxAmount = 10
        },
        {
            item = 'meth_bag',
            minAmount = 1,
            maxAmount = 1
        },
        {
            item = 'water',
            minAmount = 1,
            maxAmount = 1
        },
        {
            item = 'energy_drink',
            minAmount = 1,
            maxAmount = 1
        },
        {
            item = 'hotdog',
            minAmount = 3,
            maxAmount = 10
        },
        {
            item = 'j_phone',
            minAmount = 1,
            maxAmount = 1
        },
        {
            item = 'watch',
            minAmount = 1,
            maxAmount = 1
        },
    }
}