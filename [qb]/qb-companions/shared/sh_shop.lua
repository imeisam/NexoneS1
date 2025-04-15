ShopConfig = {
    {
        ["Type"] = "k9",
        ["Label"] = "K9",
        ["Job"] = "police",
        ["Division"] = {'k9'},
        ["Pets"] = {
            { name = "Husky", model = 2, price = 0, variants = 2 },
            { name = "Retriever", model = 3, price = 0, variants = 3 },
            { name = "Shepherd", model = 4, price = 0, variants = 2 },
            { name = "Pitbull", model = 5, price = 0, variants = 2 },
        },
        ["NPC"] = {
            id = "police_petshop",
            name = "Police Petshop",
            pedType = 4,
            model = GetHashKey('s_m_y_cop_01'),
            position = {
                coords = vector3(459.24633789063, -986.47808837891, 26.386075973511),
                heading = 89.753326416016,
            },
            scenario = "WORLD_HUMAN_GUARD_STAND",
        },
    },
    {
        ["Type"] = "k9",
        ["Label"] = "K9",
        ["Job"] = "justice",
        ["Division"] = {'k9'},
        ["Pets"] = {
            { name = "Husky", model = 2, price = 0, variants = 2 },
            { name = "Retriever", model = 3, price = 0, variants = 3 },
            { name = "Shepherd", model = 4, price = 0, variants = 2 },
            { name = "Pitbull", model = 5, price = 0, variants = 2 },
        },
        ["NPC"] = {
            id = "doj_petshop",
            name = "DOJ Petshop",
            pedType = 4,
            model = GetHashKey('s_m_m_ciasec_01'),
            position = {
                coords = vector3(365.55770874023, -1609.2260742188, 29.294549942017),
                heading = 48.071559906006,
            },
            scenario = "WORLD_HUMAN_GUARD_STAND",
        },
    },
    {
        ["Type"] = nil,
        ["Label"] = "Pet Shop",
        ["Job"] = false,
        ["Pets"] = {
            -- { name = "coyote", model = 'coyote', price = 40000, variants = 1 },
            -- { name = "panther", model = 'panther', price = 35000, variants = 1 },
            { name = "pit", model = 'pit', price = 1000, variants = 1 },
            { name = "cat", model = 'cat', price = 800, variants = 1 },
            { name = "pug", model = 'pug', price = 2000, variants = 1 },
            { name = "poodle", model = 'poodle', price = 900, variants = 1 },
            { name = "westy", model = 'westy', price = 950, variants = 1 },
            { name = "cow", model = 'cow', price = 2000, variants = 1 },
            { name = "hen", model = 'hen', price = 700, variants = 1 },
            { name = "rabbit", model = 'rabbit', price = 800, variants = 1 },
            { name = "pig", model = 'pig', price = 1800, variants = 1 },
        },
        ["NPC"] = {
            id = "petshop",
            name = "Petshop",
            pedType = 4,
            model = GetHashKey('s_m_m_autoshop_01'),
            position = {
                coords = vector3(562.38983154297, 2739.50390625, 42.536323547363),
                heading = 182.35366821289,
            },
            scenario = "WORLD_HUMAN_CLIPBOARD",
        },
        ['Blip'] = {
            coords = vector3(562.34, 2741.28, 42.87),
            type = 463,
            color = 51
        }
    }
}