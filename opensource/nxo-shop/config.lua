AC = {

    [1] = {
        ["name"] = "Convenience Store",
        ["category"] = "247",
        ["job"] = "",
        ["blip"]={
            blip=true,
            coords =vector3(24.5, -1347.94, 29.47),
            bliponnpc=true,
            BlipId = 52,
            BlipColor = 0,
            BlipSize = 0.7,
            BlipText = "24/7 Store",
        },
        ["npc"]={
            ['model']="mp_m_shopkeep_01",
            ['scenarios']='WORLD_HUMAN_STAND_MOBILE',
            ['coord']={
                vector4(24.5, -1347.94, 29.47, 270.72),
                vector4(-3038.31, 584.78, 7.91, 15.93),
                vector4(-3241.54, 999.9, 12.84, 357.83),
                vector4(1727.6, 6414.63, 35.07, 246.28),
                vector4(1960.44, 3739.45, 32.38, 300.39),
                vector4(548.94, 2672.03, 42.16, 98.02),
                vector4(2678.57, 3279.14, 55.24, 333.69),
                vector4(2557.89, 380.82, 108.62, 359.79),
                vector4(372.41, 325.78, 103.57, 255.93),
                vector4(-1221.34, -908.03, 12.33, 34.64),
                vector4(-2966.37, 391.54, 15.04, 87.42),
                vector4(-706.08, -914.53, 19.22, 94.44), 
                vector4(-1819.55, 793.51, 138.09, 140.09),
                vector4(1164.83, -323.63, 69.21, 103.59),
                vector4(1697.34, 4923.46, 42.06, 327.05),
                vector4(1134.14, -983.11, 46.42, 280.8),
                vector4(-1486.62, -377.51, 40.16, 132.56),
                vector4(-47.36, -1758.6, 29.42, 48.17)
        },
            
            ['label']='Shop',
        },
        ["categoryList"] = {
            [1]={name="Drinks" ,disc="Something refreshing"},
           [2] ={name="Foods" ,disc= "Are you hungry? "},
            [3]={name="Alcohol" ,disc= "Bottoms up",},
           [4]= {name="Smokes" ,disc= "Smoke em if you got am",},
           [5]= {name="Groceries" ,disc= "SuperMarket",},
            [6]={name="Accessories" ,disc= "Look good, feel good",},
        },
        ["itemList"] = {
            ["Drinks"] = {
                 [1] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Drinks",
                ["itemname"] = "water",
            },
            [2] = {
                ["price"] = 7,
                ["amount"] = 1,
                ["type"] = "Drinks",
                ["itemname"] = "energy_drink",
            },
        },
            ["Foods"] = {
                [1] = {
                    ["price"] = 12,
                    ["amount"] = 1,
                    ["type"] = "Foods",
                    ["itemname"] = "hotdog",
                },
            },
            ["Alcohol"] = {
                [1] = {
                    ["price"] = 7,
                    ["amount"] = 1,
                    ["type"] = "Alcohol",
                    ["itemname"] = "beer_pib",
                },
                [2] = {
                    ["price"] = 7,
                    ["amount"] = 1,
                    ["type"] = "Alcohol",
                    ["itemname"] = "beer_log",
                },
                [3] = {
                    ["price"] = 7,
                    ["amount"] = 1,
                    ["type"] = "Alcohol",
                    ["itemname"] = "beer_am",
                },
                [4] = {
                    ["price"] = 7,
                    ["amount"] = 1,
                    ["type"] = "Alcohol",
                    ["itemname"] = "beer_bar",
                },
                [5] = {
                    ["price"] = 7,
                    ["amount"] = 1,
                    ["type"] = "Alcohol",
                    ["itemname"] = "beer_stz",
                },
                [6] = {
                    ["price"] = 16,
                    ["amount"] = 1,
                    ["type"] = "Alcohol",
                    ["itemname"] = "liquor_vodka",
                },
                [7] = {
                    ["price"] = 16,
                    ["amount"] = 1,
                    ["type"] = "Alcohol",
                    ["itemname"] = "liquor_whiskey",
                },
                [8] = {
                    ["price"] = 16,
                    ["amount"] = 1,
                    ["type"] = "Alcohol",
                    ["itemname"] = "liquor_rum",
                },
                [9] = {
                    ["price"] = 16,
                    ["amount"] = 1,
                    ["type"] = "Alcohol",
                    ["itemname"] = "liquor_tequila",
                },
            },
            ["Smokes"] = {
                [1] = {
                    ["price"] = 22,
                    ["amount"] = 1,
                    ["type"] = "Smokes",
                    ["itemname"] = "cigarette_pack",
                },
                [2] = {
                    ["price"] = 8,
                    ["amount"] = 1,
                    ["type"] = "Smokes",
                    ["itemname"] = "cigar",
                },
                [3] = {
                    ["price"] = 8,
                    ["amount"] = 1,
                    ["type"] = "Smokes",
                    ["itemname"] = "lighter",
                },  
            },
            ["Groceries"] = {
                [1] = {
                    ["price"] = 20,
                    ["amount"] = 1,
                    ["type"] = "Groceries",
                    ["itemname"] = "powder",
                },
                [2] = {
                    ["price"] = 6,
                    ["amount"] = 1,
                    ["type"] = "Groceries",
                    ["itemname"] = "coco_milk",
                },
                [3] = {
                    ["price"] = 5,
                    ["amount"] = 1,
                    ["type"] = "Groceries",
                    ["itemname"] = "juice",
                },
                [4] = {
                    ["price"] = 6,
                    ["amount"] = 1,
                    ["type"] = "Groceries",
                    ["itemname"] = "lemon",
                },
                [5] = {
                    ["price"] = 5,
                    ["amount"] = 1,
                    ["type"] = "Groceries",
                    ["itemname"] = "lime",
                },
                [6] = {
                    ["price"] = 5,
                    ["amount"] = 1,
                    ["type"] = "Groceries",
                    ["itemname"] = "mint",
                },
                [7] = {
                    ["price"] = 7,
                    ["amount"] = 1,
                    ["type"] = "Groceries",
                    ["itemname"] = "rhum",
                },
                [8] = {
                    ["price"] = 4,
                    ["amount"] = 1,
                    ["type"] = "Groceries",
                    ["itemname"] = "sugar",
                },
                [9] = {
                    ["price"] = 8,
                    ["amount"] = 1,
                    ["type"] = "Groceries",
                    ["itemname"] = "vodka",
                },
                [10] = {
                    ["price"] = 8,
                    ["amount"] = 1,
                    ["type"] = "Groceries",
                    ["itemname"] = "nuts",
                },
                [11] = {
                    ["price"] = 8,
                    ["amount"] = 1,
                    ["type"] = "Groceries",
                    ["itemname"] = "beans",
                }, 
            },
            ["Accessories"] = {
                [1] = {
                    ["price"] = 50,
                    ["amount"] = 1,
                    ["type"] = "Notebooks",
                    ["itemname"] = "zat-notebook",
                },
            },
        },
        
    },
    [2] = {
        ["name"] = "Electronics Shop",
        ["category"] = "Click Lovers",
        ["job"] = "",
        ["blip"]={
            blip=false,
            coords =vector3(212.55, -1507.48, 29.29),
            bliponnpc=true,
            BlipId = 59,
            BlipColor = 2,
            BlipSize = 0.6,
            BlipText = "Electronics Shop",
        },
        ["npc"]={
            ['model']="ig_lifeinvad_01",
            ['scenarios']='WORLD_HUMAN_STAND_MOBILE',
            ['coord']={vector4(212.55, -1507.48, 29.29, 224.76),},
            ['label']='Shop',
        },
        ["categoryList"] = {
           [1]= {name="Electronics",disc = "You used to call me on my"},
        },
        ["itemList"] = {
            ["Electronics"] = {
                 [1] = {
                ["price"] = 350,
                ["amount"] = 1,
                ["type"] = "Digitall",
                ["itemname"] = "phone",
            },
            [2] = {
                ["price"] = 1500,
                ["amount"] = 1,
                ["type"] = "Digitall",
                ["itemname"] = "radio",
            },
        },
    }
},
    [3] = {
        ["name"] = "Prison Gardener",
        ["category"] = "Gardening",
        ["job"] = "",
        ["blip"]={
            blip=false,
            coords =vector3(1705.63, 2551.78, 45.55),
            bliponnpc=true,
            BlipId = 59,
            BlipColor = 2,
            BlipSize = 0.6,
            BlipText = "Prison Gardener",
        },
        ["npc"]={
            ['model']="s_m_m_migrant_01",
            ['scenarios']='WORLD_HUMAN_STAND_MOBILE',
            ['coord']={vector4(1705.63, 2551.78, 45.55, 242.68),},
            ['label']='shop',
        },
        ["categoryList"] = {
           [1]= {name="Supplies",disc = "Grow Joy, Harvest Peace"},
        },
        ["itemList"] = {
            ["Supplies"] = {
            [1] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Supplies",
                ["itemname"] = "prisonfarmseeds",
            },
            [2] = {
                ["price"] = 10,
                ["amount"] = 1,
                ["type"] = "Supplies",
                ["itemname"] = "prisonfarmnutrition",
            },
            [3] = {
                ["price"] = 6,
                ["amount"] = 1,
                ["type"] = "Supplies",
                ["itemname"] = "prisonwateringcan",
            },
        },
    }
},
    [4] = {
        ["name"] = "Fishing Shop",
        ["category"] = "Fishing",
        ["job"] = "",
        ["blip"]={
            blip=false,
            coords =vector3(1142.0759277344, 2664.0375976562, 38.160869598389),
            bliponnpc=true,
            BlipId = 59,
            BlipColor = 2,
            BlipSize = 0.6,
            BlipText = "Fishing Shop",
        },
        ["npc"]={
            ['model']="cs_josef",
            ['scenarios']='WORLD_HUMAN_CLIPBOARD',
            ['coord']={vector4(1142.0759277344, 2664.0375976562, 38.160869598389, 97.888130187988),},
            ['label']='shop',
        },
        ["categoryList"] = {
           [1]= {name="FishingRod",disc = "All Fishing Rod"},
           [2]= {name="FishingLur",disc = "All Fishing Lur"},
           [3]= {name="FishingReel",disc = "All Fishing Reel"},
           [4]= {name="fishingBait",disc = "All Fishing Bait"},

        },
        ["itemList"] = {
            ["FishingRod"] = {
            [1] = {
                ["price"] = 20,
                ["amount"] = 1,
                ["type"] = "FishingRod",
                ["itemname"] = "fishingrod",
            },
            [2] = {
                ["price"] = 40,
                ["amount"] = 1,
                ["type"] = "FishingRod",
                ["itemname"] = "fishingrod2",
            },
            [3] = {
                ["price"] = 60,
                ["amount"] = 1,
                ["type"] = "FishingRod",
                ["itemname"] = "fishingrod3",
            },
        },
            ["FishingLur"] = {
            [1] = {
                ["price"] = 40,
                ["amount"] = 1,
                ["type"] = "FishingLur",
                ["itemname"] = "fishinglure",
            },
            [2] = {
                ["price"] = 60,
                ["amount"] = 1,
                ["type"] = "FishingLur",
                ["itemname"] = "fishinglure2",
            },
        },
        ["FishingReel"] = {
            [1] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "FishingReel",
                ["itemname"] = "skill-reel",
            },
            
            [2] = {
                ["price"] = 15,
                ["amount"] = 1,
                ["type"] = "FishingReel",
                ["itemname"] = "pro-reel",
            },
        },
        ["fishingBait"] = {
            [1] = {
                ["price"] = 2,
                ["amount"] = 1,
                ["type"] = "fishingBait",
                ["itemname"] = "fishingbait",
            },
        },
        }
    },
    
    [5] = {
        ["name"] = "Marlowe Vineyard Shop",
        ["category"] = "Wine",
        ["job"] = "",
        ["blip"]={
            blip=false,
            coords =vector3(-1886.73, 2049.93, 140.98),
            bliponnpc=true,
            BlipId = 59,
            BlipColor = 2,
            BlipSize = 0.6,
            BlipText = "Marlowe Vineyard Shop",
        },
        ["npc"]={
            ['model']="mp_m_shopkeep_01",
            ['scenarios']='WORLD_HUMAN_STAND_MOBILE',
            ['coord']={vector4(-1886.73, 2049.93, 140.98, 161.79),},
            ['label']='shop',
        },
        ["categoryList"] = {
           [1]= {name="Supplies",disc = "Wine: Sip, Savor, Smile."},
        },
        ["itemList"] = {
            ["Supplies"] = {
            [1] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Supplies",
                ["itemname"] = "scissors_dirty",
            },
            [2] = {
                ["price"] = 10,
                ["amount"] = 1,
                ["type"] = "Supplies",
                ["itemname"] = "dirty_wine_bottle",
            },
            [3] = {
                ["price"] = 6,
                ["amount"] = 1,
                ["type"] = "Supplies",
                ["itemname"] = "wine_glass",
            },
            [4] = {
                ["price"] = 6,
                ["amount"] = 1,
                ["type"] = "Supplies",
                ["itemname"] = "wine_label",
            },
        },
    }
},
    [6] = {
        ["name"] = "Ammunation",
        ["category"] = "Gun Club",
        ["job"] = "",
        ["blip"]={
            blip=true,
            coords =vector3(-331.57, 6084.96, 31.45),
            bliponnpc=true,
            BlipId = 110,
            BlipColor = 64,
            BlipSize = 0.7,
            BlipText = "Gun Store",
        },
        ["npc"]={
            ['model']="s_m_y_ammucity_01",
            ['scenarios']='WORLD_HUMAN_SMOKING_POT',
            ['coord']={
                vector4(-331.57, 6084.96, 31.45, 228.61),
                vector4(1692.41, 3761.1, 34.71, 231.36),
                vector4(-3173.36, 1088.68, 20.84, 246.33),
                vector4(2567.72, 292.6, 108.73, 1.26),
                vector4(-1304.18, -394.97, 36.7, 72.17),
                vector4(253.68, -50.81, 69.94, 67.83),
                vector4(841.92, -1035.32, 28.19, 358.96),
                vector4(22.6, -1105.55, 29.8, 158.31),
                vector4(-662.29, -933.6, 21.83, 177.69),
        },
            
            ['label']='Shop',
        },
        ["categoryList"] = {
            [1]={name="Weapons",disc="I shot the sherrif"},
            [2] ={name="Ammo" ,disc= "But I didn't shoot no deputy "},
            [3]={name="Magazines" ,disc= "Reflexes had got the better of me",},
        },
        ["itemList"] = {
            ["Weapons"] = {
                 [1] = {
                ["price"] = 500,
                ["amount"] = 1,
                ["type"] = "Weapons",
                ["itemname"] = "weapon_knife",
            },
            [2] = {
                ["price"] = 700,
                ["amount"] = 1,
                ["type"] = "Weapons",
                ["itemname"] = "weapon_wrench",
            },
            [3] = {
                ["price"] = 900,
                ["amount"] = 1,
                ["type"] = "Weapons",
                ["itemname"] = "weapon_battleaxe",
            },
            [4] = {
                ["price"] = 1500,
                ["amount"] = 1,
                ["type"] = "Weapons",
                ["itemname"] = "weapon_snspistol",
            },
            [5] = {
                ["price"] = 2000,
                ["amount"] = 1,
                ["type"] = "Weapons",
                ["itemname"] = "weapon_vintagepistol",
            },
            [6] = {
                ["price"] = 2500,
                ["amount"] = 1,
                ["type"] = "Weapons",
                ["itemname"] = "weapon_pistol",
            },
        },
            ["Ammo"] = {
                [1] = {
                    ["price"] = 10,
                    ["amount"] = 7,
                    ["type"] = "Ammo",
                    ["itemname"] = "pistol_ammo",
                },
            },
            ["Magazines"] = {
                [1] = {
                    ["price"] = 15,
                    ["amount"] = 1,
                    ["type"] = "Magazines",
                    ["itemname"] = "pistol_clip",
                },
            },
        },
    },
    [7] = {
        ["name"] = "Clothes Store",
        ["category"] = "",
        ["job"] = "",
        ["blip"]={
            blip=false,
            coords =vector3(-1886.73, 2049.93, 140.98),
            bliponnpc=false,
            BlipId = 59,
            BlipColor = 2,
            BlipSize = 0.6,
            BlipText = "",
        },
        ["npc"]={
            ['model']="a_f_m_bevhills_01",
            ['scenarios']='WORLD_HUMAN_STAND_MOBILE',
            ['coord']={
            vector4(-189.20565795898, -1106.5920410156, 23.339170455933, 182.19686889648),
            vector4(77.190727233887, -1400.0400390625, 29.375965118408, 334.55584716797),
            vector4(423.82037353516, -798.95202636719, 29.490966796875, 146.34971618652),
            vector4(-827.78778076172, -1078.8616943359, 11.327929496765, 277.46978759766),
            vector4(-1183.9600830078, -769.76446533203, 17.33131980896, 84.556838989258),
            vector4(-1449.8289794922, -239.22303771973, 49.813606262207, 48.080177307129),
            vector4(-708.09979248047, -153.04179382324, 37.415134429932, 125.20238494873),
            vector4(-164.59187316895, -301.52560424805, 39.733276367188, 245.9323425293),
            vector4(117.09931182861, -227.4137878418, 54.557830810547, 295.89151000977),
            vector4(-3179.43359375, 1040.7327880859, 20.863212585449, 301.77127075195),
            vector4(-1105.7055664062, 2704.3315429688, 19.107690811157, 282.48745727539),
            vector4(620.56475830078, 2769.5483398438, 42.088096618652, 150.81130981445),
            vector4(1189.2956542969, 2708.3889160156, 38.222423553467, 244.58337402344),
            vector4(1691.2133789062, 4829.916015625, 42.062938690186, 151.0637512207),
            vector4(9.0113830566406, 6518.7177734375, 31.877658843994, 104.05973052979),
            vector4(-654.93, -247.15, 36.23, 121.86),
            vector4(49.98, -814.48, 31.22, 70.8),
        },
            ['label']='shop',
        },
        ["categoryList"] = {
           [1]= {name="Accessories",disc = "Need a Backpack?"},
        },
        ["itemList"] = {
            ["Accessories"] = {
            [1] = {
                ["price"] = 200,
                ["amount"] = 1,
                ["type"] = "Accessories",
                ["itemname"] = "backpack",
            },
        },
    },
},
[8] = {
    ["name"] = "Prison Food",
    ["category"] = "",
    ["job"] = "",
    ["blip"]={
        blip=false,
        coords =vector3(24.5, -1347.94, 29.47),
        bliponnpc=false,
        BlipId = 52,
        BlipColor = 0,
        BlipSize = 0.7,
        BlipText = "24/7 Store",
    },
    ["npc"]={
        ['model']="s_m_y_chef_01",
        ['scenarios']='WORLD_HUMAN_STAND_MOBILE',
        ['coord']={
            vector4(1780.61, 2557.78, 45.67, 179.15)
    },
        
        ['label']='Shop',
    },
    ["categoryList"] = {
        [1]={name="Drinks" ,disc="Something refreshing"},
        [2] ={name="Foods" ,disc= "Are you hungry? "},
    },
    ["itemList"] = {
        ["Drinks"] = {
             [1] = {
            ["price"] = 5,
            ["amount"] = 1,
            ["type"] = "Drinks",
            ["itemname"] = "water",
        },
        [2] = {
            ["price"] = 7,
            ["amount"] = 1,
            ["type"] = "Drinks",
            ["itemname"] = "energy_drink",
        },
    },
    ["Foods"] = {
            [1] = {
                ["price"] = 12,
                ["amount"] = 1,
                ["type"] = "Foods",
                ["itemname"] = "hotdog",
            },
        },
    }, 
},
[9] = {
    ["name"] = "Prison Medic",
    ["category"] = "",
    ["job"] = "",
    ["blip"]={
        blip=false,
        coords =vector3(24.5, -1347.94, 29.47),
        bliponnpc=false,
        BlipId = 52,
        BlipColor = 0,
        BlipSize = 0.7,
        BlipText = "",
    },
    ["npc"]={
        ['model']="s_m_m_doctor_01",
        ['scenarios']='CODE_HUMAN_MEDIC_TIME_OF_DEATH',
        ['coord']={
            vector4(1767.38, 2573.48, 45.73, 181.23)
    },
        
        ['label']='Shop',
    },
    ["categoryList"] = {
        [1]={name="Healings" ,disc= "Time to heal",},
    },
    ["itemList"] = {
        ["Healings"] = {
            [1] = {
                ["price"] = 8,
                ["amount"] = 1,
                ["type"] = "Healings",
                ["itemname"] = "bandage",
            },
        },
    }, 
},

    -- [3] = {
    --     ["name"] = "Market 3",
    --     ["category"] = "All In One",   
    --     ["job"] = "",     
    --     ["categoryList"] = {
    --         ["General"] = "Diverse items for various needs.",
    --         ["knifes"] = "Assortment of sharp cutting tools.",
    --         ["weapons"] = "Lethal tools for self-defense.",
    --         ["foods"] = "Foods for your hunger.",
    --         ["drinks"] = "Drinks for your thirst.",
    --         ["others"] = "Other items for your needs.",
    --     },
    --     ["itemList"] = {
    --         ["General"] = {},
    --         ["Knifes"] = {},
    --         ["Weapons"] = {},
    --         ["Foods"] = {},
    --         ["Drinks"] = {},
    --         ["Others"] = {},
    --     }
    -- }, 
    -- [4] = {
    --     ["name"] = "Market 4",
    --     ["category"] = "All In One",
    --     ["job"] = "",        
    --     ["categoryList"] = {
    --         ["General"] = "Diverse items for various needs.",
    --         ["knifes"] = "Assortment of sharp cutting tools.",
    --         ["weapons"] = "Lethal tools for self-defense.",
    --         ["foods"] = "Foods for your hunger.",
    --         ["drinks"] = "Drinks for your thirst.",
    --         ["others"] = "Other items for your needs.",
    --     },
    --     ["itemList"] = {
    --         ["General"] = {},
    --         ["Knifes"] = {},
    --         ["Weapons"] = {},
    --         ["Foods"] = {},
    --         ["Drinks"] = {},
    --         ["Others"] = {},
    --     }
    -- }, 
    -- [5] = {
    --     ["name"] = "Market 5",
    --     ["category"] = "All In One", 
    --     ["job"] = "",      
    --     ["categoryList"] = {
    --         ["General"] = "Diverse items for various needs.",
    --         ["knifes"] = "Assortment of sharp cutting tools.",
    --         ["weapons"] = "Lethal tools for self-defense.",
    --         ["foods"] = "Foods for your hunger.",
    --         ["drinks"] = "Drinks for your thirst.",
    --         ["others"] = "Other items for your needs.",
    --     },
    --     ["itemList"] = {
    --         ["General"] = {},
    --         ["Knifes"] = {},
    --         ["Weapons"] = {},
    --         ["Foods"] = {},
    --         ["Drinks"] = {},
    --         ["Others"] = {},
    --     }
    -- }, 
    -- [6] = {
    --     ["name"] = "Market 6",
    --     ["category"] = "All In One", 
    --     ["job"] = "",       
    --     ["categoryList"] = {
    --         ["General"] = "Diverse items for various needs.",
    --         ["knifes"] = "Assortment of sharp cutting tools.",
    --         ["weapons"] = "Lethal tools for self-defense.",
    --         ["foods"] = "Foods for your hunger.",
    --         ["drinks"] = "Drinks for your thirst.",
    --         ["others"] = "Other items for your needs.",
    --     },
    --     ["itemList"] = {
    --         ["General"] = {},
    --         ["Knifes"] = {},
    --         ["Weapons"] = {},
    --         ["Foods"] = {},
    --         ["Drinks"] = {},
    --         ["Others"] = {},
    --     }
    -- }, 
    -- [7] = {
    --     ["name"] = "Market 7",
    --     ["category"] = "All In One",   
    --     ["job"] = "",   
    --     ["categoryList"] = {
    --         ["General"] = "Diverse items for various needs.",
    --         ["knifes"] = "Assortment of sharp cutting tools.",
    --         ["weapons"] = "Lethal tools for self-defense.",
    --         ["foods"] = "Foods for your hunger.",
    --         ["drinks"] = "Drinks for your thirst.",
    --         ["others"] = "Other items for your needs.",
    --     },
    --     ["itemList"] = {
    --         ["General"] = {},
    --         ["Knifes"] = {},
    --         ["Weapons"] = {},
    --         ["Foods"] = {},
    --         ["Drinks"] = {},
    --         ["Others"] = {},
    --     }
    -- }, 
    -- [8] = {
    --     ["name"] = "Market 8",
    --     ["category"] = "All In One",
    --     ["job"] = "",       
    --     ["categoryList"] = {
    --         ["General"] = "Diverse items for various needs.",
    --         ["knifes"] = "Assortment of sharp cutting tools.",
    --         ["weapons"] = "Lethal tools for self-defense.",
    --         ["foods"] = "Foods for your hunger.",
    --         ["drinks"] = "Drinks for your thirst.",
    --         ["others"] = "Other items for your needs.",
    --     },
    --     ["itemList"] = {
    --         ["General"] = {},
    --         ["Knifes"] = {},
    --         ["Weapons"] = {},
    --         ["Foods"] = {},
    --         ["Drinks"] = {},
    --         ["Others"] = {},
    --     }
    -- },
    -- [9] = {
    --     ["name"] = "Market 9",
    --     ["category"] = "All In One",
    --     ["job"] = "",
    --     ["itemList"] = {
    --         ["knifes"] = {},
    --         ["weapons"] = {},
    --         ["foods"] = {},
    --         ["drinks"] = {},
    --         ["others"] = {}
    --     }
    -- },
    -- [10] = {
    --     ["name"] = "Market 10",
    --     ["category"] = "All In One",
    --     ["job"] = "",
    --     ["categoryList"] = {
    --         ["General"] = "Diverse items for various needs.",
    --         ["knifes"] = "Assortment of sharp cutting tools.",
    --         ["weapons"] = "Lethal tools for self-defense.",
    --         ["foods"] = "Foods for your hunger.",
    --         ["drinks"] = "Drinks for your thirst.",
    --         ["others"] = "Other items for your needs.",
    --     },
    --     ["itemList"] = {
    --         ["General"] = {},
    --         ["Knifes"] = {},
    --         ["Weapons"] = {},
    --         ["Foods"] = {},
    --         ["Drinks"] = {},
    --         ["Others"] = {},
    --     }
    -- },
    -- [11] = {
    --     ["name"] = "News",
    --     ["category"] = "All In One",
    --     ["job"] = "police",
    --     ["categoryList"] = {
    --         ["General"] = "Diverse items for various needs.",
    --     },
    --     ["itemList"] = {
    --         ["General"] = {

    --         },
    --     }
    -- },
    -- [12] = { 
    --     ["name"] = "Market 12",
    --     ["category"] = "All In One",
    --     ["job"] = "",
    --     ["categoryList"] = {
    --         ["General"] = "Diverse items for various needs.",
    --         ["Knifes"] = "Assortment of sharp cutting tools.",
    --         ["Weapons"] = "Lethal tools for self-defense.",
    --     },
    --     ["itemList"] = {
    --         ["General"] = { --["General Items"] --This category will be active when the page is first opened. This place should not be empty.
           
    --         },
    --         ["Knifes"] = {
              
    --         },
    --         ["Weapons"] = {},
    -- }
    -- },
    -- [13] = {
    --     ["name"] = "Market 13",
    --     ["category"] = "All In One",
    --     ["job"] = "police",
    --     ["categoryList"] = {
    --         ["General"] = "Diverse items for various needs.",
    --         ["Knifes"] = "Assortment of sharp cutting tools.",
    --         ["Weapons"] = "Lethal tools for self-defense.",
    --         ["Attachme"] = "Small add-ons for weapons.",
    --     },
    -- ["itemList"] = {
    --         ["General"] = { --["General Items"] --This category will be active when the page is first opened. This place should not be empty.
          
    --         },
    --         ["Knifes"] = {
               
    --         },
    --         ["Weapons"] = {
               

    --         },
    --         ["Attachme"] = {
              
    --         },
    --     }
    -- },
}

propshop={
    [1] = {
        ["prop"] ={"prop_vend_soda_02","prop_vend_soda_01"},
        ["coord"] = vec3(0.0, 0.0, 0),
        ["name"] = "Convenience Store",
        ["category"] = "247",
        ["categoryList"] = {
            [1]={name="Drinks" ,disc="Something refreshing"},
        },

        ["itemList"] = {
            ["Drinks"] = {
                 [1] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Drinks",
                ["itemname"] = "water",
            },
            [2] = {
                ["price"] = 7,
                ["amount"] = 1,
                ["type"] = "Drinks",
                ["itemname"] = "energy_drink",
            },
        },
           
        }
    },
    [2] = {
        ["prop"] ={"prop_vend_snak_01"},
        ["coord"] = vec3(0.0, 0.0, 0),
        ["name"] = "Convenience Store",
        ["category"] = "247",
        ["categoryList"] = {
            [1]={name="Sandwich" ,disc="Something refreshing"},
        },

        ["itemList"] = {
            ["Sandwich"] = {
                 [1] = {
                ["price"] = 7,
                ["amount"] = 1,
                ["type"] = "Sandwich",
                ["itemname"] = "sandwich",
            },
        },
           
        }
    },
    
    [3] = {
        ["prop"] ={"prop_watercooler","prop_watercooler_dark"},
        ["coord"] = vector3(0.0, 0.0,0.5),
        ["name"] = "Convenience Store",
        ["category"] = "Water",
        ["categoryList"] = {
            [1]={name="Water" ,disc="Something refreshing"},
        },

        ["itemList"] = {
            ["Water"] = {
                 [1] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Water",
                ["itemname"] = "water",
            },
        },
           
        }
    },
}

eventshop={
    ["dojarmory"] = {
        ["name"] = "DOJ Armory",
        ["category"] = "",
        ["job"] = "",
        ["blip"]={
            blip=false,
            coords =vector3(-331.57, 6084.96, 31.45),
            bliponnpc=false,
            BlipId = 110,
            BlipColor = 64,
            BlipSize = 0.7,
            BlipText = "Gun Store",
        },
        ["npc"]={
            ['model']="s_m_y_ammucity_01",
            ['scenarios']='WORLD_HUMAN_SMOKING_POT',
            ['coord']={
                vector4(-331.57, 6084.96, 31.45, 228.61),
        },
            
            ['label']='Shop',
        },
        ["categoryList"] = {
            [1]={name="Equipment",disc="Weapons"},
            [2]={name="Attachment",disc="Weapons Attachment"},
            [3]={name="Ammunition",disc="Ammo & Magazine"},
            [4]={name="Tools" ,disc= "Useful stuff",},
            [5]={name="Healings" ,disc= "Time to heal",},
        },
        ["itemList"] = {
            ["Equipment"] = {
            [1] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_flashlight",
            },
            [2] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_nightstick",
            },
            [3] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_taser",
                ["div"]="fa",
            },
            [4] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_combatpistol",
                ["div"]="fa",
            },
            [5] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_appistol",
                ["div"]="fa",
            },
            [6] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_combatpdw",
                ["div"]="fa",
            },
            [7] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_combatshotgun",
                ["div"]="fa",
            },
            [8] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_heavysniper_mk2",
                ["div"]="fa",
            },
            [9] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_carbinerifle_mk2",
                ["div"]="fa",
            },
            [10] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_assaultshotgun",
                ["div"]="fa",
            },
            [11] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_specialcarbine_mk2",
                ["div"]="fa",
            },
            [12] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_carbinerifle",
                ["div"]="fa",
            },
            [13] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_militaryrifle",
                ["div"]="fa",
            },
            [14] = {
                ["price"] = 1000,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_smokegrenade",
                ["div"]="fa",
            },
            [15] = {
                ["price"] = 1000,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_grenade",
                ["div"]="fa",
            },
            [16] = {
                ["price"] = 500,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_flare",
                ["div"]="fa",
            },
        },
            ["Attachment"] = {
                [1] = {
                    ["price"] = 10,
                    ["amount"] = 1,
                    ["type"] = "Attachment",
                    ["itemname"] = "flashlight_attachment",
                    ["div"]="fa",
                },
                [2] = {
                    ["price"] = 10,
                    ["amount"] = 1,
                    ["type"] = "Attachment",
                    ["itemname"] = "suppressor_attachment",
                    ["div"]="fa",
                },
                [3] = {
                    ["price"] = 10,
                    ["amount"] = 1,
                    ["type"] = "Attachment",
                    ["itemname"] = "clip_attachment",
                    ["div"]="fa",
                },
                [4] = {
                    ["price"] = 10,
                    ["amount"] = 1,
                    ["type"] = "Attachment",
                    ["itemname"] = "smallscope_attachment",
                    ["div"]="fa",
                },
                [5] = {
                    ["price"] = 10,
                    ["amount"] = 1,
                    ["type"] = "Attachment",
                    ["itemname"] = "medscope_attachment",
                    ["div"]="fa",
                },
                [6] = {
                    ["price"] = 10,
                    ["amount"] = 1,
                    ["type"] = "Attachment",
                    ["itemname"] = "grip_attachment",
                    ["div"]="fa",
                },
                [7] = {
                    ["price"] = 10,
                    ["amount"] = 1,
                    ["type"] = "Attachment",
                    ["itemname"] = "barrel_attachment",
                    ["div"]="fa",
                },
                [8] = {
                    ["price"] = 10,
                    ["amount"] = 1,
                    ["type"] = "Attachment",
                    ["itemname"] = "precision_muzzle_brake",
                    ["div"]="fa",
                },
                [9] = {
                    ["price"] = 10,
                    ["amount"] = 1,
                    ["type"] = "Attachment",
                    ["itemname"] = "tactical_muzzle_brake",
                    ["div"]="fa",
                },
            },
            ["Ammunition"] = {
                [1] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Ammunition",
                    ["itemname"] = "pistol_clip",
                    ["div"]="fa",
                },
                [2] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Ammunition",
                    ["itemname"] = "smg_clip",
                    ["div"]="fa",
                },
                [3] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Ammunition",
                    ["itemname"] = "rifle_clip",
                    ["div"]="fa",
                },
                [4] = {
                    ["price"] = 0,
                    ["amount"] = 1,
                    ["type"] = "Ammunition",
                    ["itemname"] = "pistol_ammo",
                    ["div"]="fa",
                },
                [5] = {
                    ["price"] = 0,
                    ["amount"] = 1,
                    ["type"] = "Ammunition",
                    ["itemname"] = "smg_ammo",
                    ["div"]="fa",
                },
                [6] = {
                    ["price"] = 0,
                    ["amount"] = 1,
                    ["type"] = "Ammunition",
                    ["itemname"] = "rifle_ammo",
                    ["div"]="fa",
                },
                [7] = {
                    ["price"] = 0,
                    ["amount"] = 1,
                    ["type"] = "Ammunition",
                    ["itemname"] = "shotgun_ammo",
                    ["div"]="fa",
                },
                [8] = {
                    ["price"] = 0,
                    ["amount"] = 1,
                    ["type"] = "Ammunition",
                    ["itemname"] = "snp_ammo",
                    ["div"]="fa",
                },
                [10] = {
                    ["price"] = 0,
                    ["amount"] = 1,
                    ["type"] = "Ammunition",
                    ["itemname"] = "ltl_ammo",
                    ["div"]="fa",
                },
                [11] = {
                    ["price"] = 0,
                    ["amount"] = 1,
                    ["type"] = "Ammunition",
                    ["itemname"] = "taser_ammo",
                    ["div"]="fa",
                },
            },
            ["Tools"] = {
                [1] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "pdradio",
                    ["div"]="fa",
                },
                [2] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "handcuffs",
                    ["div"]="fa",
                    ['rank']=1,
                },
                [3] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "cuff_keys",
                    ["div"]="fa",
                    ['rank']=1,
                },
                [4] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "bodycam",
                    ["div"]="fa",
                    ['rank']=1,
                },
                [5] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "dashcam",
                    ["div"]="fa",
                    ['rank']=1,
                },
                [6] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "police_stormram",
                    ["div"]="fa",
                    ['rank']=7,
                },
                [7] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "finger_scanner",
                    ["div"]="fa",
                    ['rank']=1,
                },
                [8] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "signalradar",
                    ["div"]="fa",
                    ['rank']=1,
                },
                [9] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "spike",
                    ["div"]="fa",
                    ['rank']=7,
                },
                [10] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "camera",
                    ["div"]="fa",
                    ['rank']=7,
                },
                [11] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools", 
                    ["itemname"] = "megaphone",
                    ["div"]="fa",
                    ['rank']=1,
                },
                [12] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "nightvision",
                    ["div"]="fa",
                    ['rank']=1,
                    
                },
                [13] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "empty_evidence_bag",
                    ["div"]="fa",
                    ['rank']=1,
                },
                [14] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "parachute",
                    ["div"]="fa",
                },
                [15] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "binoculars",
                    ["div"]="fa",
                },
                [16] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "diving_gear",
                    ["div"]="fa",
                    ['rank']=1,
                },
                [17] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "anklet",
                    ["div"]="fa",
                    ['rank']=1,
                },
                [18] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "compass",
                    ["div"]="fa",
                },
                [19] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "paper",
                    ["div"]="fa",
                },
                [20] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "enginerepairkit",
                    ["div"]="fa",
                },
              
            },
            ["Healings"] = {
                [1] = {
                    ["price"] = 1,
                    ["amount"] = 1,
                    ["type"] = "Healings",
                    ["itemname"] = "ifaks",
                    ["div"]="fa",
                },
                [2] = {
                    ["price"] = 1,
                    ["amount"] = 1,
                    ["type"] = "Healings",
                    ["itemname"] = "heavyarmor",
                    ["div"]="fa",
                },
            },
        },
    },
    ["govermentarmory"] = {
        ["name"] = "Goverment Armory",
        ["category"] = "",
        ["job"] = "",
        ["blip"]={
            blip=false,
            coords =vector3(313.62, -1644.36, 47.24),
            bliponnpc=false,
            BlipId = 110,
            BlipColor = 64,
            BlipSize = 0.7,
            BlipText = "Gun Store",
        },
        ["npc"]={
            ['model']="s_m_y_ammucity_01",
            ['scenarios']='WORLD_HUMAN_SMOKING_POT',
            ['coord']={
                vector4(-331.57, 6084.96, 31.45, 228.61),
        },
        ['label']='Shop',
        },
        ["categoryList"] = {
            [1]={name="Equipment",disc="Weapons"},
            [2]={name="Ammunition",disc="Ammo & Magazine"},
            [3]={name="Tools" ,disc= "Useful stuff",},
            [4]={name="Healings" ,disc= "Time to heal",},
        },
        ["itemList"] = {
            ["Equipment"] = {
                [1] = {
                    ["price"] = 5,
                    ["amount"] = 1,
                    ["type"] = "Equipment",
                    ["itemname"] = "weapon_combatpistol",
                    ["rank"]=4,
                },
            },
            ["Ammunition"] = {
                [1] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Ammunition",
                    ["itemname"] = "pistol_clip",
                    ["rank"]=4,
                },
                [2] = {
                    ["price"] = 0,
                    ["amount"] = 1,
                    ["type"] = "Ammunition",
                    ["itemname"] = "pistol_ammo",
                    ["rank"]=4,
                },
            },
            ["Tools"] = {
                [1] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "pdradio",
                    ["rank"]=4,
                },
                [2] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "handcuffs",
                    ["rank"]=4,
                },
                [3] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "cuff_keys",
                    ["rank"]=4,
                },
                [4] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "paper",
                },
            },
            ["Healings"] = {
                [1] = {
                    ["price"] = 1,
                    ["amount"] = 1,
                    ["type"] = "Healings",
                    ["itemname"] = "ifaks",
                    ["rank"]=2,
                },
                [2] = {
                    ["price"] = 1,
                    ["amount"] = 1,
                    ["type"] = "Healings",
                    ["itemname"] = "heavyarmor",
                    ["rank"]=2,
                },
            },
        },
    },
   
    ["policearmory"] = {
        ["name"] = "Police Armory",
        ["category"] = "",
        ["job"] = "",
        ["blip"]={
            blip=false,
            coords =vector3(-331.57, 6084.96, 31.45),
            bliponnpc=false,
            BlipId = 110,
            BlipColor = 64,
            BlipSize = 0.7,
            BlipText = "Gun Store",
        },
        ["npc"]={
            ['model']="s_m_y_ammucity_01",
            ['scenarios']='WORLD_HUMAN_SMOKING_POT',
            ['coord']={
                vector4(-331.57, 6084.96, 31.45, 228.61),
        },
            
            ['label']='Shop',
        },
        ["categoryList"] = {
            [1]={name="Equipment",disc="Weapons"},
            [2]={name="Attachment",disc="Weapons Attachment"},
            [3]={name="Ammunition",disc="Ammo & Magazine"},
            [4]={name="Tools" ,disc= "Useful stuff",},
            [5]={name="Healings" ,disc= "Time to heal",},
        },
        ["itemList"] = {
            ["Equipment"] = {
            [1] = {
            ["price"] = 5,
            ["amount"] = 1,
            ["type"] = "Equipment",
            ["itemname"] = "weapon_flashlight",
            },
            [2] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_nightstick",
            },
            [3] = {
            ["price"] = 5,
            ["amount"] = 1,
            ["type"] = "Equipment",
            ["itemname"] = "weapon_taser",
            ["div"]="fa",
            },
            [4] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_combatpistol",
                ["div"]="fa",
            },
            [5] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_heavypistol",
                ["div"]="fa",
            },
            [6] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_smg",
                ["div"]="fa",
            },
            [7] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_assaultsmg",
                ["div"]="fa",
            },
            [8] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_combatpdw",
                ["div"]="fa",
            },
            [9] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_pumpshotgun",
                ["div"]="fa",
            },
            [10] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_pumpshotgun_mk2",
                ["div"]="fa",
            },
            [11] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_assaultshotgun",
                ["div"]="fa",
            },
            [12] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_carbinerifle",
                ["div"]="fa",
            },
            [13] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_carbinerifle_mk2",
                ["div"]="fa",
            },
            [14] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_specialcarbine_mk2",
                ["div"]="fa",
            },
            [15] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_marksmanrifle_mk2",
                ["div"]="fa",
            },
            [16] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Equipment",
                ["itemname"] = "weapon_heavysniper_mk2",
                ["div"]="fa",
            },
        },
            ["Attachment"] = {
                [1] = {
                    ["price"] = 10,
                    ["amount"] = 1,
                    ["type"] = "Attachment",
                    ["itemname"] = "flashlight_attachment",
                    ["div"]="fa",
                },
                [2] = {
                    ["price"] = 10,
                    ["amount"] = 1,
                    ["type"] = "Attachment",
                    ["itemname"] = "suppressor_attachment",
                    ["div"]="fa",
                },
                [3] = {
                    ["price"] = 10,
                    ["amount"] = 1,
                    ["type"] = "Attachment",
                    ["itemname"] = "clip_attachment",
                    ["div"]="fa",
                },
                [4] = {
                    ["price"] = 10,
                    ["amount"] = 1,
                    ["type"] = "Attachment",
                    ["itemname"] = "smallscope_attachment",
                    ["div"]="fa",
                },
                [5] = {
                    ["price"] = 10,
                    ["amount"] = 1,
                    ["type"] = "Attachment",
                    ["itemname"] = "medscope_attachment",
                    ["div"]="fa",
                },
                [6] = {
                    ["price"] = 10,
                    ["amount"] = 1,
                    ["type"] = "Attachment",
                    ["itemname"] = "grip_attachment",
                    ["div"]="fa",
                },
                [7] = {
                    ["price"] = 10,
                    ["amount"] = 1,
                    ["type"] = "Attachment",
                    ["itemname"] = "barrel_attachment",
                    ["div"]="fa",
                },
                [8] = {
                    ["price"] = 10,
                    ["amount"] = 1,
                    ["type"] = "Attachment",
                    ["itemname"] = "precision_muzzle_brake",
                    ["div"]="fa",
                },
                [9] = {
                    ["price"] = 10,
                    ["amount"] = 1,
                    ["type"] = "Attachment",
                    ["itemname"] = "tactical_muzzle_brake",
                    ["div"]="fa",
                },
            },
            ["Ammunition"] = {
                [1] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Ammunition",
                    ["itemname"] = "pistol_clip",
                    ["div"]="fa",
                },
                [2] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Ammunition",
                    ["itemname"] = "smg_clip",
                    ["div"]="fa",
                },
                [3] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Ammunition",
                    ["itemname"] = "rifle_clip",
                    ["div"]="fa",
                },
                [4] = {
                    ["price"] = 0,
                    ["amount"] = 1,
                    ["type"] = "Ammunition",
                    ["itemname"] = "pistol_ammo",
                },
                [5] = {
                    ["price"] = 0,
                    ["amount"] = 1,
                    ["type"] = "Ammunition",
                    ["itemname"] = "smg_ammo",
                },
                [6] = {
                    ["price"] = 0,
                    ["amount"] = 1,
                    ["type"] = "Ammunition",
                    ["itemname"] = "rifle_ammo",
                },
                [7] = {
                    ["price"] = 0,
                    ["amount"] = 1,
                    ["type"] = "Ammunition",
                    ["itemname"] = "shotgun_ammo",
                },
                [8] = {
                    ["price"] = 0,
                    ["amount"] = 1,
                    ["type"] = "Ammunition",
                    ["itemname"] = "snp_ammo",
                },
                [10] = {
                    ["price"] = 0,
                    ["amount"] = 1,
                    ["type"] = "Ammunition",
                    ["itemname"] = "ltl_ammo",
                },
                [11] = {
                    ["price"] = 0,
                    ["amount"] = 1,
                    ["type"] = "Ammunition",
                    ["itemname"] = "taser_ammo",
                },
            },
            ["Tools"] = {
                [1] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "pdradio",
                    ["div"]="fa",
                },
                [2] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "handcuffs",
                    ["div"]="fa",
                },
                [3] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "cuff_keys",
                    ["div"]="fa",
                },
                [4] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "bodycam",
                    ["div"]="fa",
                },
                [5] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "dashcam",
                    ["div"]="fa",
                    -- ['rank']=5,
                },
                [6] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "police_stormram",
                },
                [7] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "finger_scanner",
                    ["div"]="fa",
                },
                [8] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "signalradar",
                },
                [9] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "spike",
                    ["div"]="fa",
                },
                [10] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "camera",
                },
                [11] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools", 
                    ["itemname"] = "megaphone",
                },
                [12] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "nightvision",
                    ["div"]="fa",
                },
                [13] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "empty_evidence_bag",
                },
                [14] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "parachute",
                },
                [15] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "binoculars",
                },
                [16] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "diving_gear",
                },
                [17] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "anklet",
                },
                [18] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "compass",
                    ["div"]="fa",
                },
                [19] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "paper",
                },
                [20] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "enginerepairkit",
                },
                [21] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "antiradiojammer",
                    ["div"]="fa",
                },
                [22] = {
                    ["price"] = 2,
                    ["amount"] = 1,
                    ["type"] = "Tools",
                    ["itemname"] = "weapon_fireextinguisher",
                },
            },
            ["Healings"] = {
                [1] = {
                    ["price"] = 1,
                    ["amount"] = 1,
                    ["type"] = "Healings",
                    ["itemname"] = "ifaks",
                },
                [2] = {
                    ["price"] = 1,
                    ["amount"] = 1,
                    ["type"] = "Healings",
                    ["itemname"] = "heavyarmor",
                },
            },
        },
    },
    ["mdarmory"] = {
        ["name"] = "MD Armory",
        ["category"] = "",
        ["job"] = "",
        ["blip"]={
            blip=false,
            coords =vector3(379.46, -1411.92, 32.94),
            bliponnpc=false,
            BlipId = 110,
            BlipColor = 64,
            BlipSize = 0.7,
            BlipText = "Medic",
        },
        ["npc"]={
            ['model']="s_m_y_ammucity_01",
            ['scenarios']='WORLD_HUMAN_SMOKING_POT',
            ['coord']={
                vector4(379.46, -1411.92, 32.94, 228.18),
        },
            
            ['label']='Shop',
        },
        ["categoryList"] = {
            [1]={name="Tools" ,disc= "Useful stuff",},
        },
        ["itemList"] = {
            ["Tools"] = {
            [1] = {
            ["price"] = 5,
            ["amount"] = 1,
            ["type"] = "Tools",
            ["itemname"] = "signalradar",
            },
            [2] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Tools",
                ["itemname"] = "pdradio",
            },
            [3] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Tools",
                ["itemname"] = "bodycam",
            },
            [4] = {
                ["price"] = 5,
                ["amount"] = 1,
                ["type"] = "Tools",
                ["itemname"] = "dashcam",
            },
            [5] = {
                ["price"] = 2,
                ["amount"] = 1,
                ["type"] = "Tools",
                ["itemname"] = "compass",
            },
            [6] = {
                ["price"] = 2,
                ["amount"] = 1,
                ["type"] = "Tools",
                ["itemname"] = "paper",
            },
            [7] = {
                ["price"] = 2,
                ["amount"] = 1,
                ["type"] = "Tools",
                ["itemname"] = "enginerepairkit",
            },
            [8] = {
                ["price"] = 2,
                ["amount"] = 1,
                ["type"] = "Tools",
                ["itemname"] = "parachute",
            },
            [9] = {
                ["price"] = 2,
                ["amount"] = 1,
                ["type"] = "Tools",
                ["itemname"] = "binoculars",
            },
            [10] = {
                ["price"] = 2,
                ["amount"] = 1,
                ["type"] = "Tools",
                ["itemname"] = "diving_gear",
            },
        },
    },
},
    ["mechanicsh"] = {
        ["name"] = "Mechanic Shop",
        ["category"] = "Shop",
        ["job"] = "",
        ["blip"]={
            blip=false,
            coords =vector3(-331.57, 6084.96, 31.45),
            bliponnpc=true,
            BlipId = 110,
            BlipColor = 64,
            BlipSize = 0.7,
            BlipText = "Mechanic Shop",
        },
        ["npc"]={
            ['model']="s_m_m_gaffer_01",
            ['scenarios']='WORLD_HUMAN_SMOKING_POT',
            ['coord']={
                vector4(-331.57, 6084.96, 31.45, 228.61),

        },
            
            ['label']='Shop',
        },
        ["categoryList"] = {
            [1]={name="Turbo",disc=""},
            [2] ={name="Armor" ,disc= ""},
            [3]={name="Engine" ,disc= "",},
            [4] ={name="Transmission" ,disc= ""},
            [5]={name="Brakes" ,disc= "",},
            [6]={name="Suspension" ,disc= "",},
            [7]={name="Accessories" ,disc= "",},
        },
        ["itemList"] = {
            ["Turbo"] = {
            [1] = {
                ["price"] = 500,
                ["amount"] = 1,
                ["type"] = "Turbo",
                ["itemname"] = "turbo_d",
            },
            [2] = {
                ["price"] = 700,
                ["amount"] = 1,
                ["type"] = "Turbo",
                ["itemname"] = "turbo_c",
            },
            [3] = {
                ["price"] = 900,
                ["amount"] = 1,
                ["type"] = "Turbo",
                ["itemname"] = "turbo_b",
            },
            [4] = {
                ["price"] = 1500,
                ["amount"] = 1,
                ["type"] = "Turbo",
                ["itemname"] = "turbo_a",
            },
            [5] = {
                ["price"] = 2000,
                ["amount"] = 1,
                ["type"] = "Turbo",
                ["itemname"] = "turbo_s",
            },
        },
            ["Armor"] = {
                [1] = {
                    ["price"] = 500,
                    ["amount"] = 1,
                    ["type"] = "Armor",
                    ["itemname"] = "car_armor_d",
                },
                [2] = {
                    ["price"] = 700,
                    ["amount"] = 1,
                    ["type"] = "Armor",
                    ["itemname"] = "car_armor_c",
                },
                [3] = {
                    ["price"] = 900,
                    ["amount"] = 1,
                    ["type"] = "Armor",
                    ["itemname"] = "car_armor_b",
                },
                [4] = {
                    ["price"] = 1500,
                    ["amount"] = 1,
                    ["type"] = "Armor",
                    ["itemname"] = "car_armor_a",
                },
                [5] = {
                    ["price"] = 2000,
                    ["amount"] = 1,
                    ["type"] = "Armor",
                    ["itemname"] = "car_armor_s",
                },
            },
            ["Engine"] = {
                [1] = {
                    ["price"] = 500,
                    ["amount"] = 1,
                    ["type"] = "Engine",
                    ["itemname"] = "engine4_d",
                },
                [2] = {
                    ["price"] = 700,
                    ["amount"] = 1,
                    ["type"] = "Engine",
                    ["itemname"] = "engine4_c",
                },
                [3] = {
                    ["price"] = 900,
                    ["amount"] = 1,
                    ["type"] = "Engine",
                    ["itemname"] = "engine4_b",
                },
                [4] = {
                    ["price"] = 1500,
                    ["amount"] = 1,
                    ["type"] = "Engine",
                    ["itemname"] = "engine4_a",
                },
                [5] = {
                    ["price"] = 2000,
                    ["amount"] = 1,
                    ["type"] = "Engine",
                    ["itemname"] = "engine4_s",
                },
            },
            ["Transmission"] = {
                [1] = {
                    ["price"] = 500,
                    ["amount"] = 1,
                    ["type"] = "Transmission",
                    ["itemname"] = "transmission3_d",
                },
                [2] = {
                    ["price"] = 700,
                    ["amount"] = 1,
                    ["type"] = "Transmission",
                    ["itemname"] = "transmission3_c",
                },
                [3] = {
                    ["price"] = 900,
                    ["amount"] = 1,
                    ["type"] = "Transmission",
                    ["itemname"] = "transmission3_b",
                },
                [4] = {
                    ["price"] = 1500,
                    ["amount"] = 1,
                    ["type"] = "Transmission",
                    ["itemname"] = "transmission3_a",
                },
                [5] = {
                    ["price"] = 2000,
                    ["amount"] = 1,
                    ["type"] = "Transmission",
                    ["itemname"] = "transmission3_s",
                },
            },
            ["Brakes"] = {
                [1] = {
                    ["price"] = 500,
                    ["amount"] = 1,
                    ["type"] = "Brakes",
                    ["itemname"] = "brakes3_d",
                },
                [2] = {
                    ["price"] = 700,
                    ["amount"] = 1,
                    ["type"] = "Brakes",
                    ["itemname"] = "brakes3_c",
                },
                [3] = {
                    ["price"] = 900,
                    ["amount"] = 1,
                    ["type"] = "Brakes",
                    ["itemname"] = "brakes3_b",
                },
                [4] = {
                    ["price"] = 1500,
                    ["amount"] = 1,
                    ["type"] = "Brakes",
                    ["itemname"] = "brakes3_a",
                },
                [5] = {
                    ["price"] = 2000,
                    ["amount"] = 1,
                    ["type"] = "Brakes",
                    ["itemname"] = "brakes3_s",
                },
            },
            ["Suspension"] = {
                [1] = {
                    ["price"] = 500,
                    ["amount"] = 1,
                    ["type"] = "Suspension",
                    ["itemname"] = "suspension1",
                },
                [2] = {
                    ["price"] = 700,
                    ["amount"] = 1,
                    ["type"] = "Suspension",
                    ["itemname"] = "suspension2",
                },
                [3] = {
                    ["price"] = 900,
                    ["amount"] = 1,
                    ["type"] = "Suspension",
                    ["itemname"] = "suspension3",
                },
                [4] = {
                    ["price"] = 1500,
                    ["amount"] = 1,
                    ["type"] = "Suspension",
                    ["itemname"] = "suspension4",
                },
            },
            ["Accessories"] = {
                [1] = {
                    ["price"] = 100,
                    ["amount"] = 1,
                    ["type"] = "Accessories",
                    ["itemname"] = "mechboard",
                },
                [2] = {
                    ["price"] = 75,
                    ["amount"] = 1,
                    ["type"] = "Accessories",
                    ["itemname"] = "bodyrepairkit",
                },
                [3] = {
                    ["price"] = 75,
                    ["amount"] = 1,
                    ["type"] = "Accessories",
                    ["itemname"] = "enginerepairkit",
                },
            },
        },
    }
}
Pos = {
    [1] = vector3(1135.8, -982.2, 46.4),
    [2] = vector3(-1222.9, -906.9, 12.3),
    [3] = vector3(-1487.5, -379.1, 40.1),
    [4] = vector3(-2968.2, 390.9, 15.0),
    [5] = vector3(1166.0, 2708.9, 38.1),
    [6] = vector3(1392.5, 3604.6, 34.9),
    [7] = vector3(127.8, -1284.7, 29.2),
    [8] = vector3(-1393.4, -606.6, 30.3),
    [9] = vector3(-48.5, -1757.5, 29.4),
    [10] = vector3(1163.3, -323.8, 69.2),
    [11] = vector3(429.25,-807.53,29.49),
    [12] = vector3(-1820.5, 792.5, 138.1),
    [13] = vector3(458.54, -979.47, 30.69),
}

itemlicenses={
    ["weapon_snspistol"]=1,
    ["weapon_vintagepistol"]=1,
    ["weapon_pistol"]=1,
    ["pistol_ammo"]=1,
    ["pistol_clip"]=1,
}
itemhuntinglicenses={
    ["huntingknife"]=1,
    ["snp_ammo"]=1,
    ["weapon_sniperrifle"]=1,
    ["huntingbait"]=1,
}
weaponlist={
    ['weapon_taser']=true,
    ['weapon_snspistol']=true,
    ['weapon_vintagepistol']=true,
    ['weapon_pistol']=true,
    ['weapon_stungun']=true,
    ['weapon_combatpistol']=true,
    ['weapon_heavypistol']=true,
    ['weapon_smg']=true,
    ['weapon_assaultsmg']=true,
    ['weapon_combatpdw']=true,
    ['weapon_tasertgun']=true,
    ['weapon_pumpshotgun_mk2']=true,
    ['weapon_carbinerifle']=true,
    ['weapon_assaultshotgun']=true,
    ['weapon_carbinerifle_mk2']=true,
    ['weapon_specialcarbine_mk2']=true,
    ['weapon_marksmanrifle_mk2']=true,
    ['weapon_heavysniper_mk2']=true,
    
}