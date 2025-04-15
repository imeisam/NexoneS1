--  ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗
-- ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝
-- ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
-- ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
-- ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
--  ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝

Config = {}

Config.Lang = 'en'

Config.Notify = 'qb' -- lvs_lib, ox_lib, qb, esx
Config.TextUI = 'qb' -- lvs_lib, ox_lib, qb, esx

--- ### HOW TO OPEN A SHOP ###
-- by default is TextUI
Config.UseRadialMenu = false
Config.Radial = 'ox_lib' -- ox_lib, qb-radialmenu

Config.UseTarget = false
Config.Target = 'qb_target' -- ox_target, qb-target

--- ### WHEN TARGET IS TRUE ###
Config.EnablePedsForShops = true
Config.EnablePedsForClothingRooms = true
Config.EnablePedsForPlayerOutfitRooms = true

--- ### PRICES ###
Config.ClothingCost = 10
Config.BarberCost = 20
Config.TattooCost = 30
Config.SurgeonCost = 1000

-- Charge players per tattoo.
-- Config.TattooCost will become the cost of 1 tattoo. The cost can be overridden by adding `cost` key in config/tattoos.lua for specific tattoos
Config.ChargePerTattoo = true

-- Set this to true if you're using rcore_tattoos
Config.RCoreTattoos = false

--- ### COMMANDS ###
Config.Commands = {
    Reload = 'bir',
    ClearProps = 'cprop',
    Cooldown = 5000 -- Cooldown for this commands
}

Config.AdminCommands = {
    Enabled = true,
    AdminAce = 'group.admin',

    PedCommand = 'pedmenu',
    ClothingCommand = 'clothingmenu',
    FaceCommand = 'facemenu',
    AllCommand = 'allmenu',
}

Config.Aces = {'group.admin'} -- list of ace permissions used for blacklisting

Config.HideRadar = false -- Hides the minimap while the menu is open

Config.InvincibleDuringCustomization = true

Config.NewCharacterSections = {
    Ped = false, -- Set this to true if you want player able to chosen a custom ped at character creation
    HeadBlend = true,
    FaceFeatures = true,
    HeadOverlays = true,
    Components = true,
    Props = true,
}

Config.AlwaysKeepProps = false

-- ## ONX Faces (onx_mp_faces) ##
Config.ONXFaces = true   -- if you have onx_mp_faces as addon, set to true


Config.PersistUniforms = false          -- Keeps Job / Gang Outfits on player reconnects / logout
Config.OnDutyOnlyClothingRooms = false  -- Set to `true` to make the clothing rooms accessible only to players who are On Duty

-- If you have lvs_multichar, ignore this configuration. It is overridden when using the multicharacter.
-- Set up your initial character preferences in lvs_multichar/config/clothing/lvs.lua as desired
Config.InitialPlayerClothes = {
    Male = {
        Model = "mp_m_freemode_01",
        Components = {
            {
                component_id = 0, -- Face
                drawable = 0,
                texture = 0
            },
            {
                component_id = 1, -- Mask
                drawable = 0,
                texture = 0
            },
            {
                component_id = 2, -- Hair
                drawable = 0,
                texture = 0
            },
            {
                component_id = 3, -- Upper Body
                drawable = 0,
                texture = 0
            },
            {
                component_id = 4, -- Lower Body
                drawable = 0,
                texture = 0
            },
            {
                component_id = 5, -- Bag
                drawable = 0,
                texture = 0
            },
            {
                component_id = 6, -- Shoes
                drawable = 0,
                texture = 0
            },
            {
                component_id = 7, -- Scarf & Chains
                drawable = 0,
                texture = 0
            },
            {
                component_id = 8, -- Shirt
                drawable = 0,
                texture = 0
            },
            {
                component_id = 9, -- Body Armor
                drawable = 0,
                texture = 0
            },
            {
                component_id = 10, -- Decals
                drawable = 0,
                texture = 0
            },
            {
                component_id = 11, -- Jacket
                drawable = 0,
                texture = 0
            }
        },
        Props = {
            {
                prop_id = 0, -- Hat
                drawable = -1,
                texture = -1
            },
            {
                prop_id = 1, -- Glasses
                drawable = -1,
                texture = -1
            },
            {
                prop_id = 2, -- Ear
                drawable = -1,
                texture = -1
            },
            {
                prop_id = 6, -- Watch
                drawable = -1,
                texture = -1
            },
            {
                prop_id = 7, -- Bracelet
                drawable = -1,
                texture = -1
            }
        },
        Hair = {
            color = 0,
            highlight = 0,
            style = 0,
            texture = 0
        }
    },
    Female = {
        Model = "mp_f_freemode_01",
        Components = {
            {
                component_id = 0, -- Face
                drawable = 0,
                texture = 0
            },
            {
                component_id = 1, -- Mask
                drawable = 0,
                texture = 0
            },
            {
                component_id = 2, -- Hair
                drawable = 0,
                texture = 0
            },
            {
                component_id = 3, -- Upper Body
                drawable = 0,
                texture = 0
            },
            {
                component_id = 4, -- Lower Body
                drawable = 0,
                texture = 0
            },
            {
                component_id = 5, -- Bag
                drawable = 0,
                texture = 0
            },
            {
                component_id = 6, -- Shoes
                drawable = 0,
                texture = 0
            },
            {
                component_id = 7, -- Scarf & Chains
                drawable = 0,
                texture = 0
            },
            {
                component_id = 8, -- Shirt
                drawable = 0,
                texture = 0
            },
            {
                component_id = 9, -- Body Armor
                drawable = 0,
                texture = 0
            },
            {
                component_id = 10, -- Decals
                drawable = 0,
                texture = 0
            },
            {
                component_id = 11, -- Jacket
                drawable = 0,
                texture = 0
            }
        },
        Props = {
            {
                prop_id = 0, -- Hat
                drawable = -1,
                texture = -1
            },
            {
                prop_id = 1, -- Glasses
                drawable = -1,
                texture = -1
            },
            {
                prop_id = 2, -- Ear
                drawable = -1,
                texture = -1
            },
            {
                prop_id = 6, -- Watch
                drawable = -1,
                texture = -1
            },
            {
                prop_id = 7, -- Bracelet
                drawable = -1,
                texture = -1
            }
        },
        Hair = {
            color = 0,
            highlight = 0,
            style = 0,
            texture = 0
        }
    }
}

Config.ClothesOff = {
    male = {
        hat = -1, -- prop drawable id
        mask = 0, -- component drawable id
        glasses = -1, -- prop drawable id
        bag = 0, -- component drawable id
        pants = 61, -- component drawable id
        shoes = 34, -- component drawable id
        -- To remove the jacket, it's necessary to change more than one component, like jacket, undershirt, arms and decals
        -- so the value of the jacket is a table with the component ID and the drawable ID
        jacket = {
            {11, 252}, -- jacket
            {3, 15}, -- undershirt
            {8, 15}, -- arms
            {10, 0} -- decals
        }
    },

    female = {
        hat = -1,
        mask = 0,
        glasses = -1,
        bag = 0,
        pants = 15,
        shoes = 35,
        jacket = {
            {11, 15},
            {8, 14},
            {3, 15},
            {10, 0},
        }
    }
}

Config.WearQuickAccess = {
    enable = true, -- false disable completely this feature, set to false if you have your own menu

    -- keyboard key to open menu, if you set this to false you can open an close the menu with events
    -- lvs_clothing:client:OpenQuickWearClothes & lvs_clothing:client:CloseQuickWearClothes
    key = 'K',
}

-- ██╗    ██╗   ██╗      ███████╗ ██████╗ ███████╗████████╗
-- ██║    ██║   ██║      ██╔════╝██╔═══██╗██╔════╝╚══██╔══╝
-- ██║    ██║   ██║█████╗███████╗██║   ██║█████╗     ██║
-- ██║    ╚██╗ ██╔╝╚════╝╚════██║██║   ██║██╔══╝     ██║
-- ███████╗╚████╔╝       ███████║╚██████╔╝██║        ██║
-- ╚══════╝ ╚═══╝        ╚══════╝ ╚═════╝ ╚═╝        ╚═╝