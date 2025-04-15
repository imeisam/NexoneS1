
Config.Cloakroom = {
    -- {
    --     job = "police", -- job name
    --     coords = vector4(454.91, -990.89, 30.69, 193.4),
    --     size = vector3(4, 4, 4),
    --     rotation = 45,
    --     usePoly = false,
    --     points = {
    --         vector3(460.41918945312, -993.11444091797, 30.69),
    --         vector3(449.39508056641, -993.60614013672, 30.69),
    --         vector3(449.88696289062, -990.23779296875, 30.69),
    --         vector3(450.97882080078, -989.71411132812, 30.69),
    --         vector3(451.0325012207, -987.89904785156, 30.69),
    --         vector3(453.47863769531, -987.76928710938, 30.69),
    --         vector3(454.35513305664, -988.46459960938, 30.69),
    --         vector3(460.4231262207, -987.94573974609, 30.69)
    --     }
    -- },
    {
        job = "ambulance",
        coords = vector4(317.74, -599.38, 43.29, 340.41),
        size = vector3(4, 4, 4),
        rotation = 45,
        usePoly = false,
        points = {
            vector3(320.98458862305, -598.33776855469, 43.29),
            vector3(320.13272094727, -600.88928222656, 43.29),
            vector3(315.77648925781, -599.40057373047, 43.29),
            vector3(316.94616699219, -596.88690185547, 43.29)
        }
    },
    -- {
    --     gang = "vagos", -- gang name
    --     coords = vector4(363.87, -2065.24, 21.74, 37.34),
    --     size = vector3(4, 4, 4),
    --     rotation = 45,
    --     usePoly = false,
    --     points = {
    --         vec3(364.29998779297, -2062.8999023438, 21.9),
    --         vec3(362.20001220703, -2065.3999023438, 21.9),
    --         vec3(363.79998779297, -2066.6999511719, 21.9),
    --         vec3(365.79998779297, -2064.3000488281, 21.9),
    -- }
    -- }
}

Config.Outfits = {
    ["police"] = {
        ["Male"] = {
            {
                name = "Short Sleeve",
                tags = 'short-sleeve',
                outfitData = {
                    ["pants"] = {item = 24, texture = 0}, -- Pants
                    ["arms"] = {item = 19, texture = 0}, -- Arms
                    ["t-shirt"] = {item = 58, texture = 0}, -- T Shirt
                    ["vest"] = {item = 0, texture = 0}, -- Body Vest
                    ["torso2"] = {item = 55, texture = 0}, -- Jacket
                    ["shoes"] = {item = 51, texture = 0}, -- Shoes
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory
                    ["bag"] = {item = 0, texture = 0}, -- Bag
                    ["hat"] = {item = -1, texture = -1}, -- Hat
                    ["glass"] = {item = 0, texture = 0}, -- Glasses
                    ["mask"] = {item = 0, texture = 0} -- Mask
                },
                grades = {0, 1, 2, 3, 4},
            },
            {
                name = "Trooper Tan",
                tags = 'trooper-tan',
                outfitData = {
                    ["pants"] = {item = 24, texture = 0}, -- Pants
                    ["arms"] = {item = 20, texture = 0}, -- Arms
                    ["t-shirt"] = {item = 58, texture = 0}, -- T Shirt
                    ["vest"] = {item = 0, texture = 0}, -- Body Vest
                    ["torso2"] = {item = 317, texture = 3}, -- Jacket
                    ["shoes"] = {item = 51, texture = 0}, -- Shoes
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory
                    ["bag"] = {item = 0, texture = 0}, -- Bag
                    ["hat"] = {item = 58, texture = 0}, -- Hat
                    ["glass"] = {item = 0, texture = 0}, -- Glasses
                    ["mask"] = {item = 0, texture = 0} -- Mask
                },
                grades = {0, 1, 2, 3, 4},
            },
            {
                name = "Long Sleeve",
                tags = 'long-sleeve',
                outfitData = {
                    ["pants"] = {item = 24, texture = 0}, -- Pants
                    ["arms"] = {item = 20, texture = 0}, -- Arms
                    ["t-shirt"] = {item = 58, texture = 0}, -- T Shirt
                    ["vest"] = {item = 0, texture = 0}, -- Body Vest
                    ["torso2"] = {item = 317, texture = 0}, -- Jacket
                    ["shoes"] = {item = 51, texture = 0}, -- Shoes
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory
                    ["bag"] = {item = 0, texture = 0}, -- Bag
                    ["hat"] = {item = -1, texture = -1}, -- Hat
                    ["glass"] = {item = 0, texture = 0}, -- Glasses
                    ["mask"] = {item = 0, texture = 0} -- Mask
                },
                grades = {1, 2, 3, 4},
            },
            {
                name = "Trooper Black",
                tags = 'trooper-black',
                outfitData = {
                    ["pants"] = {item = 24, texture = 0}, -- Pants
                    ["arms"] = {item = 20, texture = 0}, -- Arms
                    ["t-shirt"] = {item = 58, texture = 0}, -- T Shirt
                    ["vest"] = {item = 0, texture = 0}, -- Body Vest
                    ["torso2"] = {item = 317, texture = 8}, -- Jacket
                    ["shoes"] = {item = 51, texture = 0}, -- Shoes
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory
                    ["bag"] = {item = 0, texture = 0}, -- Bag
                    ["hat"] = {item = 58, texture = 3}, -- Hat
                    ["glass"] = {item = 0, texture = 0}, -- Glasses
                    ["mask"] = {item = 0, texture = 0} -- Mask
                },
                grades = {2, 3, 4},
            },
            {
                name = "SWAT",
                tags = 'swat',
                outfitData = {
                    ["pants"] = {item = 130, texture = 1}, -- Pants
                    ["arms"] = {item = 172, texture = 0}, -- Arms
                    ["t-shirt"] = {item = 15, texture = 0}, -- T Shirt
                    ["vest"] = {item = 15, texture = 2}, -- Body Vest
                    ["torso2"] = {item = 336, texture = 3}, -- Jacket
                    ["shoes"] = {item = 24, texture = 0}, -- Shoes
                    ["accessory"] = {item = 133, texture = 0}, -- Neck Accessory
                    ["hat"] = {item = 150, texture = 0}, -- Hat
                    ["glass"] = {item = 0, texture = 0}, -- Glasses
                    ["mask"] = {item = 52, texture = 0} -- Mask
                },
                grades = {3, 4},
            }
        },
        ["Female"] = {
            {
                name = "Short Sleeve",
                tags = "short-sleeve",
                outfitData = {
                    ["pants"] = {item = 133, texture = 0}, -- Pants
                    ["arms"] = {item = 31, texture = 0}, -- Arms
                    ["t-shirt"] = {item = 35, texture = 0}, -- T Shirt
                    ["vest"] = {item = 34, texture = 0}, -- Body Vest
                    ["torso2"] = {item = 48, texture = 0}, -- Jacket
                    ["shoes"] = {item = 52, texture = 0}, -- Shoes
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory
                    ["bag"] = {item = 0, texture = 0}, -- Bag
                    ["hat"] = {item = 0, texture = 0}, -- Hat
                    ["glass"] = {item = 0, texture = 0}, -- Glasses
                    ["mask"] = {item = 0, texture = 0} -- Mask
                },
                grades = {0, 1, 2, 3, 4},
            },
            {
                name = "Trooper Tan",
                tags = "troopertan",
                outfitData = {
                    ["pants"] = {item = 133, texture = 0}, -- Pants
                    ["arms"] = {item = 31, texture = 0}, -- Arms
                    ["t-shirt"] = {item = 35, texture = 0}, -- T Shirt
                    ["vest"] = {item = 34, texture = 0}, -- Body Vest
                    ["torso2"] = {item = 327, texture = 3}, -- Jacket
                    ["shoes"] = {item = 52, texture = 0}, -- Shoes
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory
                    ["bag"] = {item = 0, texture = 0}, -- Bag
                    ["hat"] = {item = 0, texture = 0}, -- Hat
                    ["glass"] = {item = 0, texture = 0}, -- Glasses
                    ["mask"] = {item = 0, texture = 0} -- Mask
                },
                grades = {0, 1, 2, 3, 4},
            },
            {
                name = "Long Sleeve",
                tags = "long sleeve",
                outfitData = {
                    ["pants"] = {item = 133, texture = 0}, -- Pants
                    ["arms"] = {item = 31, texture = 0}, -- Arms
                    ["t-shirt"] = {item = 35, texture = 0}, -- T Shirt
                    ["vest"] = {item = 34, texture = 0}, -- Body Vest
                    ["torso2"] = {item = 327, texture = 0}, -- Jacket
                    ["shoes"] = {item = 52, texture = 0}, -- Shoes
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory
                    ["bag"] = {item = 0, texture = 0}, -- Bag
                    ["hat"] = {item = 0, texture = 0}, -- Hat
                    ["glass"] = {item = 0, texture = 0}, -- Glasses
                    ["mask"] = {item = 0, texture = 0} -- Mask
                },
                grades = {1, 2, 3, 4},
            },
            {
                name = "Trooper Black",
                tags = "trooper-black",
                outfitData = {
                    ["pants"] = {item = 133, texture = 0}, -- Pants
                    ["arms"] = {item = 31, texture = 0}, -- Arms
                    ["t-shirt"] = {item = 35, texture = 0}, -- T Shirt
                    ["vest"] = {item = 34, texture = 0}, -- Body Vest
                    ["torso2"] = {item = 327, texture = 8}, -- Jacket
                    ["shoes"] = {item = 52, texture = 0}, -- Shoes
                    ["accessory"] = {item = 0, texture = 0}, -- Neck Accessory
                    ["bag"] = {item = 0, texture = 0}, -- Bag
                    ["hat"] = {item = 0, texture = 0}, -- Hat
                    ["glass"] = {item = 0, texture = 0}, -- Glasses
                    ["mask"] = {item = 0, texture = 0} -- Mask
                },
                grades = {2, 3, 4},
            },
            {
                name = "SWAT",
                tags = "swat",
                outfitData = {
                    ["pants"] = {item = 135, texture = 1}, -- Pants
                    ["arms"] = {item = 213, texture = 0}, -- Arms
                    ["t-shirt"] = {item = 0, texture = 0}, -- T Shirt
                    ["vest"] = {item = 17, texture = 2}, -- Body Vest
                    ["torso2"] = {item = 327, texture = 8}, -- Jacket
                    ["shoes"] = {item = 52, texture = 0}, -- Shoes
                    ["accessory"] = {item = 102, texture = 0}, -- Neck Accessory
                    ["bag"] = {item = 0, texture = 0}, -- Bag
                    ["hat"] = {item = 149, texture = 0}, -- Hat
                    ["glass"] = {item = 0, texture = 0}, -- Glasses
                    ["mask"] = {item = 35, texture = 0} -- Mask
                },
                grades = {3, 4},
            }
        }
    },
    ["realestate"] = {
        ["Male"] = {
            {
                -- Outfits
                name = "Worker",
                tags = "worker",
                outfitData = {
                    ["pants"]       = { item = 28, texture = 0},  -- Pants
                    ["arms"]        = { item = 1, texture = 0},  -- Arms
                    ["t-shirt"]     = { item = 31, texture = 0},  -- T Shirt
                    ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                    ["torso2"]      = { item = 294, texture = 0},  -- Jacket
                    ["shoes"]       = { item = 10, texture = 0},  -- Shoes
                    ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                    ["bag"]         = { item = 0, texture = 0},  -- Bag
                    ["hat"]         = { item = 12, texture = -1},  -- Hat
                    ["glass"]       = { item = 0, texture = 0},  -- Glasses
                    ["mask"]        = { item = 0, texture = 0},  -- Mask
                },
                grades = {0, 1, 2, 3, 4},
            }
        },
        ["Female"] = {
            {
                name = "Worker",
                tags = "worker",
                outfitData = {
                    ["pants"]       = { item = 57, texture = 2},  -- Pants
                    ["arms"]        = { item = 0, texture = 0},  -- Arms
                    ["t-shirt"]     = { item = 34, texture = 0},  -- T Shirt
                    ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                    ["torso2"]      = { item = 105, texture = 7},  -- Jacket
                    ["shoes"]       = { item = 8, texture = 5},  -- Shoes
                    ["accessory"]   = { item = 11, texture = 3},  -- Neck Accessory
                    ["bag"]         = { item = 0, texture = 0},  -- Bag
                    ["hat"]         = { item = -1, texture = -1},  -- Hat
                    ["glass"]       = { item = 0, texture = 0},  -- Glasses
                    ["mask"]        = { item = 0, texture = 0},  -- Mask
                },
                grades = {0, 1, 2, 3, 4},
            }
        }
    },
    ["ambulance"] = {
        ["Male"] = {
            {
                name = "Long Sleeve-1",
                tags = "SAFR",
                outfitData = {
                    ["arms"] = {item = 88, texture = 1}, -- Arms
                    ["t-shirt"] = {item = 153, texture = 0}, -- T-Shirt
                    ["torso2"] = {item = 524, texture = 6}, -- Jackets
                    ["vest"] = {item = 94, texture = 0}, -- Vest
                    ["decals"] = {item = 0, texture = 0}, -- Decals
                    ["accessory"] = {item = 197, texture = 0}, -- Neck
                    ["bag"] = {item = 0, texture = 0}, -- Bag
                    ["pants"] = {item = 193, texture = 3}, -- Pants
                    ["shoes"] = {item = 145, texture = 0}, -- Shoes
                    ["mask"] = {item = 0, texture = 0}, -- Mask
                    ["hat"] = {item = 0, texture = 0}, -- Hat
                    ["glass"] = {item = 0, texture = 0}, -- Glasses
                    ["ear"] = {item = 0, texture = 0} -- Ear accessories
                },
                grades = {0, 1, 2, 3, 4, 5},
            },
            {
                name = "Long Sleeve-2",
                tags = "SAFR",
                outfitData = {
                    ["arms"] = {item = 88, texture = 1}, -- Arms
                    ["t-shirt"] = {item = 153, texture = 0}, -- T-Shirt
                    ["torso2"] = {item = 525, texture = 6}, -- Jackets
                    ["vest"] = {item = 94, texture = 0}, -- Vest
                    ["decals"] = {item = 0, texture = 0}, -- Decals
                    ["accessory"] = {item = 197, texture = 0}, -- Neck
                    ["bag"] = {item = 0, texture = 0}, -- Bag
                    ["pants"] = {item = 193, texture = 3}, -- Pants
                    ["shoes"] = {item = 145, texture = 0}, -- Shoes
                    ["mask"] = {item = 0, texture = 0}, -- Mask
                    ["hat"] = {item = 0, texture = 0}, -- Hat
                    ["glass"] = {item = 0, texture = 0}, -- Glasses
                    ["ear"] = {item = 0, texture = 0} -- Ear accessories
                },
                grades = {0, 1, 2, 3, 4, 5},
            },
            {
                name = "Long Sleeve-3",
                tags = "SAFR",
                outfitData = {
                    ["arms"] = {item = 88, texture = 1}, -- Arms
                    ["t-shirt"] = {item = 153, texture = 0}, -- T-Shirt
                    ["torso2"] = {item = 528, texture = 6}, -- Jackets
                    ["vest"] = {item = 94, texture = 0}, -- Vest
                    ["decals"] = {item = 0, texture = 0}, -- Decals
                    ["accessory"] = {item = 197, texture = 0}, -- Neck
                    ["bag"] = {item = 0, texture = 0}, -- Bag
                    ["pants"] = {item = 193, texture = 3}, -- Pants
                    ["shoes"] = {item = 145, texture = 0}, -- Shoes
                    ["mask"] = {item = 0, texture = 0}, -- Mask
                    ["hat"] = {item = 0, texture = 0}, -- Hat
                    ["glass"] = {item = 0, texture = 0}, -- Glasses
                    ["ear"] = {item = 0, texture = 0} -- Ear accessories
                },
                grades = {0, 1, 2, 3, 4, 5},
            },
            {
                name = "shirt-1",
                tags = "SAFR",
                outfitData = {
                    ["arms"] = {item = 85, texture = 1}, -- Arms
                    ["t-shirt"] = {item = 153, texture = 0}, -- T-Shirt
                    ["torso2"] = {item = 526, texture = 6}, -- Jackets
                    ["vest"] = {item = 94, texture = 0}, -- Vest
                    ["decals"] = {item = 0, texture = 0}, -- Decals
                    ["accessory"] = {item = 197, texture = 0}, -- Neck
                    ["bag"] = {item = 0, texture = 0}, -- Bag
                    ["pants"] = {item = 193, texture = 3}, -- Pants
                    ["shoes"] = {item = 145, texture = 0}, -- Shoes
                    ["mask"] = {item = 0, texture = 0}, -- Mask
                    ["hat"] = {item = 0, texture = 0}, -- Hat
                    ["glass"] = {item = 0, texture = 0}, -- Glasses
                    ["ear"] = {item = 0, texture = 0} -- Ear accessories
                },
                grades = {0, 1, 2, 3, 4, 5},
            },
            {
                name = "shirt-2",
                tags = "SAFR",
                outfitData = {
                    ["arms"] = {item = 85, texture = 1}, -- Arms
                    ["t-shirt"] = {item = 153, texture = 0}, -- T-Shirt
                    ["torso2"] = {item = 527, texture = 6}, -- Jackets
                    ["vest"] = {item = 94, texture = 0}, -- Vest
                    ["decals"] = {item = 0, texture = 0}, -- Decals
                    ["accessory"] = {item = 197, texture = 0}, -- Neck
                    ["bag"] = {item = 0, texture = 0}, -- Bag
                    ["pants"] = {item = 193, texture = 3}, -- Pants
                    ["shoes"] = {item = 145, texture = 0}, -- Shoes
                    ["mask"] = {item = 0, texture = 0}, -- Mask
                    ["hat"] = {item = 0, texture = 0}, -- Hat
                    ["glass"] = {item = 0, texture = 0}, -- Glasses
                    ["ear"] = {item = 0, texture = 0} -- Ear accessories
                },
                grades = {0, 1, 2, 3, 4, 5},
            },
            {
                name = "shirt-3",
                tags = "SAFR",
                outfitData = {
                    ["arms"] = {item = 85, texture = 1}, -- Arms
                    ["t-shirt"] = {item = 153, texture = 0}, -- T-Shirt
                    ["torso2"] = {item = 529, texture = 6}, -- Jackets
                    ["vest"] = {item = 94, texture = 0}, -- Vest
                    ["decals"] = {item = 0, texture = 0}, -- Decals
                    ["accessory"] = {item = 197, texture = 0}, -- Neck
                    ["bag"] = {item = 0, texture = 0}, -- Bag
                    ["pants"] = {item = 193, texture = 3}, -- Pants
                    ["shoes"] = {item = 145, texture = 0}, -- Shoes
                    ["mask"] = {item = 0, texture = 0}, -- Mask
                    ["hat"] = {item = 0, texture = 0}, -- Hat
                    ["glass"] = {item = 0, texture = 0}, -- Glasses
                    ["ear"] = {item = 0, texture = 0} -- Ear accessories
                },
                grades = {0, 1, 2, 3, 4, 5},
            },
            {
                name = "Medical Center",
                tags = "MC",
                outfitData = {
                    ["arms"] = {item = 85, texture = 1}, -- Arms
                    ["t-shirt"] = {item = 15, texture = 0}, -- T-Shirt
                    ["torso2"] = {item = 671, texture = 2}, -- Jackets
                    ["vest"] = {item = 0, texture = 0}, -- Vest
                    ["decals"] = {item = 0, texture = 0}, -- Decals
                    ["accessory"] = {item = 231, texture = 0}, -- Neck
                    ["bag"] = {item = 0, texture = 0}, -- Bag
                    ["pants"] = {item = 250, texture = 5}, -- Pants
                    ["shoes"] = {item = 6, texture = 0}, -- Shoes
                    ["mask"] = {item = 0, texture = 0}, -- Mask
                    ["hat"] = {item = 0, texture = 0}, -- Hat
                    ["glass"] = {item = 0, texture = 0}, -- Glasses
                    ["ear"] = {item = 0, texture = 0} -- Ear accessories
                },
                grades = {0, 1, 2, 3, 4, 5},
            },
        },
        ["Female"] = {
            {
                name = "Long Sleeve-1",
                tags = "SAFR",
                outfitData = {
                    ["arms"] = {item = 101, texture = 1}, -- Arms
                    ["t-shirt"] = {item = 3, texture = 0}, -- T-Shirt
                    ["torso2"] = {item = 565, texture = 6}, -- Jackets
                    ["vest"] = {item = 94, texture = 0}, -- Vest
                    ["decals"] = {item = 0, texture = 0}, -- Decals
                    ["accessory"] = {item = 167, texture = 0}, -- Neck
                    ["bag"] = {item = 0, texture = 0}, -- Bag
                    ["pants"] = {item = 208, texture = 3}, -- Pants
                    ["shoes"] = {item = 154, texture = 0}, -- Shoes
                    ["mask"] = {item = 0, texture = 0}, -- Mask
                    ["hat"] = {item = 0, texture = 0}, -- Hat
                    ["glass"] = {item = 0, texture = 0}, -- Glasses
                    ["ear"] = {item = 0, texture = 0} -- Ear accessories
                },
                grades = {0, 1, 2, 3, 4, 5},
            },
            {
                name = "Long Sleeve-2",
                tags = "SAFR",
                outfitData = {
                    ["arms"] = {item = 101, texture = 1}, -- Arms
                    ["t-shirt"] = {item = 3, texture = 0}, -- T-Shirt
                    ["torso2"] = {item = 566, texture = 6}, -- Jackets
                    ["vest"] = {item = 94, texture = 0}, -- Vest
                    ["decals"] = {item = 0, texture = 0}, -- Decals
                    ["accessory"] = {item = 167, texture = 0}, -- Neck
                    ["bag"] = {item = 0, texture = 0}, -- Bag
                    ["pants"] = {item = 208, texture = 3}, -- Pants
                    ["shoes"] = {item = 154, texture = 0}, -- Shoes
                    ["mask"] = {item = 0, texture = 0}, -- Mask
                    ["hat"] = {item = 0, texture = 0}, -- Hat
                    ["glass"] = {item = 0, texture = 0}, -- Glasses
                    ["ear"] = {item = 0, texture = 0} -- Ear accessories
                },
                grades = {0, 1, 2, 3, 4, 5},
            },
            {
                name = "Long Sleeve-3",
                tags = "SAFR",
                outfitData = {
                    ["arms"] = {item = 101, texture = 1}, -- Arms
                    ["t-shirt"] = {item = 3, texture = 0}, -- T-Shirt
                    ["torso2"] = {item = 569, texture = 6}, -- Jackets
                    ["vest"] = {item = 94, texture = 0}, -- Vest
                    ["decals"] = {item = 0, texture = 0}, -- Decals
                    ["accessory"] = {item = 167, texture = 0}, -- Neck
                    ["bag"] = {item = 0, texture = 0}, -- Bag
                    ["pants"] = {item = 208, texture = 3}, -- Pants
                    ["shoes"] = {item = 154, texture = 0}, -- Shoes
                    ["mask"] = {item = 0, texture = 0}, -- Mask
                    ["hat"] = {item = 0, texture = 0}, -- Hat
                    ["glass"] = {item = 0, texture = 0}, -- Glasses
                    ["ear"] = {item = 0, texture = 0} -- Ear accessories
                },
                grades = {0, 1, 2, 3, 4, 5},
            },
            {
                name = "shirt-1",
                tags = "SAFR",
                outfitData = {
                    ["arms"] = {item = 96, texture = 0}, -- Arms
                    ["t-shirt"] = {item = 153, texture = 0}, -- T-Shirt
                    ["torso2"] = {item = 567, texture = 6}, -- Jackets
                    ["vest"] = {item = 94, texture = 0}, -- Vest
                    ["decals"] = {item = 0, texture = 0}, -- Decals
                    ["accessory"] = {item = 197, texture = 0}, -- Neck
                    ["bag"] = {item = 0, texture = 0}, -- Bag
                    ["pants"] = {item = 193, texture = 3}, -- Pants
                    ["shoes"] = {item = 145, texture = 0}, -- Shoes
                    ["mask"] = {item = 0, texture = 0}, -- Mask
                    ["hat"] = {item = 0, texture = 0}, -- Hat
                    ["glass"] = {item = 0, texture = 0}, -- Glasses
                    ["ear"] = {item = 0, texture = 0} -- Ear accessories
                },
                grades = {0, 1, 2, 3, 4, 5},
            },
            {
                name = "shirt-2",
                tags = "SAFR",
                outfitData = {
                    ["arms"] = {item = 96, texture = 0}, -- Arms
                    ["t-shirt"] = {item = 153, texture = 0}, -- T-Shirt
                    ["torso2"] = {item = 568, texture = 6}, -- Jackets
                    ["vest"] = {item = 94, texture = 0}, -- Vest
                    ["decals"] = {item = 0, texture = 0}, -- Decals
                    ["accessory"] = {item = 197, texture = 0}, -- Neck
                    ["bag"] = {item = 0, texture = 0}, -- Bag
                    ["pants"] = {item = 193, texture = 3}, -- Pants
                    ["shoes"] = {item = 145, texture = 0}, -- Shoes
                    ["mask"] = {item = 0, texture = 0}, -- Mask
                    ["hat"] = {item = 0, texture = 0}, -- Hat
                    ["glass"] = {item = 0, texture = 0}, -- Glasses
                    ["ear"] = {item = 0, texture = 0} -- Ear accessories
                },
                grades = {0, 1, 2, 3, 4, 5},
            },
            {
                name = "shirt-3",
                tags = "SAFR",
                outfitData = {
                    ["arms"] = {item = 96, texture = 0}, -- Arms
                    ["t-shirt"] = {item = 153, texture = 0}, -- T-Shirt
                    ["torso2"] = {item = 570, texture = 6}, -- Jackets
                    ["vest"] = {item = 94, texture = 0}, -- Vest
                    ["decals"] = {item = 0, texture = 0}, -- Decals
                    ["accessory"] = {item = 197, texture = 0}, -- Neck
                    ["bag"] = {item = 0, texture = 0}, -- Bag
                    ["pants"] = {item = 193, texture = 3}, -- Pants
                    ["shoes"] = {item = 145, texture = 0}, -- Shoes
                    ["mask"] = {item = 0, texture = 0}, -- Mask
                    ["hat"] = {item = 0, texture = 0}, -- Hat
                    ["glass"] = {item = 0, texture = 0}, -- Glasses
                    ["ear"] = {item = 0, texture = 0} -- Ear accessories
                },
                grades = {0, 1, 2, 3, 4, 5},
            },
            {
                name = "Medical Center",
                tags = "MC",
                outfitData = {
                    ["arms"] = {item = 96, texture = 0}, -- Arms
                    ["t-shirt"] = {item = 3, texture = 0}, -- T-Shirt
                    ["torso2"] = {item = 698, texture = 1}, -- Jackets
                    ["vest"] = {item = 0, texture = 0}, -- Vest
                    ["decals"] = {item = 0, texture = 0}, -- Decals
                    ["accessory"] = {item = 195, texture = 0}, -- Neck
                    ["bag"] = {item = 0, texture = 0}, -- Bag
                    ["pants"] = {item = 261, texture = 5}, -- Pants
                    ["shoes"] = {item = 133, texture = 0}, -- Shoes
                    ["mask"] = {item = 0, texture = 0}, -- Mask
                    ["hat"] = {item = 0, texture = 0}, -- Hat
                    ["glass"] = {item = 0, texture = 0}, -- Glasses
                    ["ear"] = {item = 0, texture = 0} -- Ear accessories
                },
                grades = {0, 1, 2, 3, 4, 5},
            },
        }
    },
    ["vagos"] = {
        ["Male"] = {
            {
                name = "Outfit 1",
                tags = "No tags",
                outfitData = {
                    ["arms"] = {item = 1, texture = 0}, -- Arms
                    ["t-shirt"] = {item = 15, texture = 0}, -- T-Shirt
                    ["torso2"] = {item = 87, texture = 1}, -- Jackets
                    ["vest"] = {item = 0, texture = 0}, -- Vest
                    ["decals"] = {item = 0, texture = 0}, -- Decals
                    ["accessory"] = {item = 0, texture = 0}, -- Neck
                    ["bag"] = {item = 0, texture = 0}, -- Bag
                    ["pants"] = {item = 59, texture = 0}, -- Pants
                    ["shoes"] = {item = 25, texture = 0}, -- Shoes
                    ["mask"] = {item = 16, texture = 1}, -- Mask
                    ["hat"] = {item = 14, texture = 4}, -- Hat
                    ["glass"] = {item = 0, texture = 0}, -- Glasses
                    ["ear"] = {item = 0, texture = 0} -- Ear accessories
                },
                grades = {0, 1, 2, 3, 4},
            }
        },
        ["Female"] = {
            {
                name = "Outfit 1",
                tags = "No Tags",
                outfitData = {
                    ["arms"] = {item = 3, texture = 0}, -- Arms
                    ["t-shirt"] = {item = 3, texture = 0}, -- T-Shirt
                    ["torso2"] = {item = 81, texture = 1}, -- Jackets
                    ["vest"] = {item = 0, texture = 0}, -- Vest
                    ["decals"] = {item = 0, texture = 0}, -- Decals
                    ["accessory"] = {item = 0, texture = 0}, -- Neck
                    ["bag"] = {item = 0, texture = 0}, -- Bag
                    ["pants"] = {item = 61, texture = 0}, -- Pants
                    ["shoes"] = {item = 33, texture = 6}, -- Shoes
                    ["mask"] = {item = 16, texture = 1}, -- Mask
                    ["hat"] = {item = 0, texture = 0}, -- Hat
                    ["glass"] = {item = 0, texture = 0}, -- Glasses
                    ["ear"] = {item = 0, texture = 0} -- Ear accessories
                },
                grades = {0, 1, 2, 3, 4},
            }
        }
    }
}

