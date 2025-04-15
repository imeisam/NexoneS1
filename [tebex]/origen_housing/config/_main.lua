Config.Language = 'en' -- Language to use for the script (en, es, fr, it)

Config.RenderDistance = 200 -- The distance in which the building and exterior furniture will be rendered

Config.DoorLimit = 10 -- The maximum number of doors that can be added to a house (Only mlo), if false the limit will be removed

Config.LightsLimit = {
    interior = 10, -- The maximum number of lights that can be added to an interior
    exterior = 10, -- The maximum number of lights that can be added to an exterior
}

Config.SaveDoorStatus = true -- Save the door status

Config.StartBuildingOnBuy = true -- If true, the building will start when the player buys the house, if false, the building will start when the house is created

Config.LoadFurnitureOnlyInPolyzone = false -- If true, the furniture will be loaded only in the polyzone

Config.GarageNeedMainDoorUnlocked = false -- If true, the garage will be locked if the main door is locked

Config.KeyHoldersNeedDoorUnlocked = false -- If true, the key holders can enter the house only if the main door is unlocked

Config.LimitOfHouses = 10 -- The maximum number of houses players can buy, if false the limit will be removed
Config.LimitOfKeyHolders = 15 -- The maximum number of key holders in a house, if false the limit will be removed

Config.CustomDrawText = false -- If true, the drawtext will be handled by the custom script, if false the drawtext will be handled by the framework
Config.CustomNotify = false -- If true, the notify will be handled by the custom script, if false the notify will be handled by the framework

Config.ExternalInteractionSystem = false -- If true, the house will use the external interaction system

Config.EnableStashesLimit = false -- If true, the stashes will be limited to the number of stashes in the house 🡇
Config.StashesLimit = 5 -- The maximum number of stashes in a house, if Config.EnableStashesLimit is false the limit will be removed

Config.ShowHousePanelOnBuy = true -- If true, the house panel will be shown when buying a house

Config.CustomInventory = false -- If true, the inventory will be handled by the custom script, if false the inventory will be recognized by the script
Config.CustomClothing = false -- If true, the clothing will be handled by the custom script, if false the clothing will be recognized by the script

Config.EnterHouseOnSpawn = true -- If true, the player will enter the house when spawning

Config.UseNameInBlipInsteadOfId = false -- If true, the name of the house will be used instead of the id in the blip

Config.UseHouseGarages = false -- If true, the garages included in the script will be used

Config.FurnitureEnable = {
    interior = true,
    exterior = true,
}

Config.Blip = { -- Blip settings
    sprite = 350,
    scale = 0.6,
    color = 0,
    buyedSprite = 40,

    showBlipInDistance = false, -- If true, the blip will be shown as a short range blip
}

Config.Markers = { -- Marker settings
    ['general'] = { -- Entry and exit markers
        type = 20,
        color = {0, 0, 0, 200},
        size = vector3(0.3, 0.3, 0.3),
        coords = vector3(0.0, 0.0, 1.0),
        bobUpAndDown = true,
        faceCamera = false,
        rotate = true,
    },
    ['garage'] = { -- Garage markers
        type = 36,
        color = {0, 0, 0, 200},
        size = vector3(0.3, 0.3, 0.3),
        coords = vector3(0.0, 0.0, 1.0),
        bobUpAndDown = true,
        faceCamera = false,
        rotate = true,
    },
}

Config.DefaultPaymentMethod = 'cash' -- The default payment method

Config.PaymentMethods = { -- The payment methods that are available
    ['cash'] = true,
    ['bank'] = true,
    -- ['custom_account'] = true,
}

Config.DoorDistances = {
    ['normal'] = 2.0,
    ['double'] = 2.0,
    ['garage'] = 3.5,
}

---------------------------------------------------------
--------------------------DEBUG--------------------------
---------------------------------------------------------

Config.Debug = false -- Enable debug mode

Config.DatabaseStructureCheck = true -- Check the database structure on start

---------------------------------------------------------
--------------------------CORE---------------------------
---------------------------------------------------------

Config.Columns = {
    ['qb-core'] = {
        ['players'] = 'players',
        ['identifier'] = 'citizenid',

        -- Garages
        ['vehicles'] = 'player_vehicles',
        ['owner'] = 'citizenid',
        ['mods'] = 'mods',
        ['state'] = 'state',
        ['garage'] = 'garage',
    },
    ['esx'] = {
        ['players'] = 'users',
        ['identifier'] = 'identifier',

        -- Garages
        ['vehicles'] = 'owned_vehicles',
        ['owner'] = 'owner',
        ['mods'] = 'vehicle',
        ['state'] = 'stored',
        ['garage'] = 'parking',
    },
    ['custom'] = {
        ['players'] = '',
        ['identifier'] = '',

        -- Garages
        ['vehicles'] = '',
        ['owner'] = '',
        ['mods'] = '',
        ['state'] = '',
        ['garage'] = '',
    },
}

Config.Translations = Translations