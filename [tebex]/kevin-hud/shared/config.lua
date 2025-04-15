return {
    isMph = true,
    isMenuEnabled = true, -- this enables the menu
    isServerInfoEnabled = false, -- this enables the server info
    isCompassEnabled = false, -- this enables the compass
    isCrosshairEnabled = true, -- this enables the crosshair
    isStressDisabled = false, -- this disables the stress bar and everything related to it
    isLowFuelChecked = true, -- this checks if the fuel is low and notifies the player
    blackListVehicleHud = {
        [13] = true, -- this disables the vehicle hud for cycles
    },
    stress = {
        disableForLEO = true, -- this disables the stress system for LEO
        speedMultiplier = 3.6, -- this is the speed multiplier for the stress system
        stressSpeeding = {
            speed = 120, -- this is the speed at which the player will gain stress
            unbuckledSpeed = 80, -- this is the speed at which the player will gain stress if they are not wearing a seatbelt
            motorcycleSpeed = 100, -- this is the speed at which the player will gain stress if they are on a motorcycle
        },
        minStress = 50,-- minimum Stress Level For Screen Shaking
        stressShootingChance = 0.1, -- this is the chance that the player will gain stress when shooting
        blur = {
            [1] = {
                min = 50,
                max = 60,
                intensity = 1500,
            },
            [2] = {
                min = 60,
                max = 70,
                intensity = 2000,
            },
            [3] = {
                min = 70,
                max = 80,
                intensity = 2500,
            },
            [4] = {
                min = 80,
                max = 90,
                intensity = 2700,
            },
            [5] = {
                min = 90,
                max = 100,
                intensity = 3000,
            },
        },
        intervals = {
            [1] = {
                min = 50,
                max = 60,
                timeout = math.random(50000, 60000)
            },
            [2] = {
                min = 60,
                max = 70,
                timeout = math.random(40000, 50000)
            },
            [3] = {
                min = 70,
                max = 80,
                timeout = math.random(30000, 40000)
            },
            [4] = {
                min = 80,
                max = 90,
                timeout = math.random(20000, 30000)
            },
            [5] = {
                min = 90,
                max = 100,
                timeout = math.random(15000, 20000)
            },
        },
        vehicleClasses = {-- Enable/Disable gaining stress from vehicle classes in this table
            ['0'] = true,         -- Compacts
            ['1'] = true,         -- Sedans
            ['2'] = true,         -- SUVs
            ['3'] = true,         -- Coupes
            ['4'] = true,         -- Muscle
            ['5'] = true,         -- Sports Classics
            ['6'] = true,         -- Sports
            ['7'] = true,         -- Super
            ['8'] = true,         -- Motorcycles
            ['9'] = true,         -- Off Road
            ['10'] = true,        -- Industrial
            ['11'] = true,        -- Utility
            ['12'] = true,        -- Vans
            ['13'] = false,       -- Cycles
            ['14'] = false,       -- Boats
            ['15'] = false,       -- Helicopters
            ['16'] = false,       -- Planes
            ['18'] = false,       -- Emergency
            ['19'] = false,       -- Military
            ['20'] = false,       -- Commercial
            ['21'] = false        -- Trains
        },
        blackListedWeapons = { -- Disable gaining stress from weapons in this table
            [`weapon_petrolcan`] = true,
            [`weapon_hazardcan`] = true,
            [`weapon_fireextinguisher`] = true
        },
    },

    -- this is the position of the minimap
    minimapPosition = {
        ['bottom-left'] = {
            alignX = 'L',
            alignY = 'B',
            minimap = {
                posX = -0.021, -- adjust the position of the minimap horizontally
                posY = -0.042, -- adjust the position of the minimap vertically
                sizeX = 0.194, -- adjust the width of the minimap
                sizeY = 0.189, -- adjust the height of the minimap
            },
            minimapMask = {
                posX = 0.037, -- adjust the position of the mask horizontally
                posY = 0.07, -- adjust the position of the mask vertically
                sizeX = 0.125, -- adjust the width of the mask
                sizeY = 0.3, -- adjust the height of the mask
            },
            minimapBlur = {
                posX = -0.042, -- adjust the position of the minimap horizontally
                posY = -0.00, -- adjust the position of the minimap vertically
                sizeX = 0.3, -- adjust the width of the minimap
                sizeY = 0.25, -- adjust the height of the minimap
            },
        },
        ['top-left'] = {
            alignX = 'L',
            alignY = 'T',
            minimap = {
                posX = -0.02, -- adjust the position of the minimap horizontally
                posY = 0.02, -- adjust the position of the minimap vertically
                sizeX = 0.194, -- adjust the width of the minimap
                sizeY = 0.189, -- adjust the height of the minimap
            },
            minimapMask = {
                posX = 0.02, -- adjust the position of the mask horizontally
                posY = 0.07, -- adjust the position of the mask vertically
                sizeX = 0.125, -- adjust the width of the mask
                sizeY = 0.3, -- adjust the height of the mask
            },
            minimapBlur = {
                posX = -0.044, -- adjust the position of the minimap horizontally
                posY = -0.00, -- adjust the position of the minimap vertically
                sizeX = 0.3, -- adjust the width of the minimap
                sizeY = 0.25, -- adjust the height of the minimap
            },
        },
        ['bottom-right'] = {
            alignX = 'R',
            alignY = 'B',
            minimap = {
                posX = 0.024, -- adjust the position of the minimap horizontally
                posY = -0.042, -- adjust the position of the minimap vertically
                sizeX = 0.194, -- adjust the width of the minimap
                sizeY = 0.189, -- adjust the height of the minimap
            },
            minimapMask = {
                posX = 0.02, -- adjust the position of the mask horizontally
                posY = 0.07, -- adjust the position of the mask vertically
                sizeX = 0.125, -- adjust the width of the mask
                sizeY = 0.3, -- adjust the height of the mask
            },
            minimapBlur = {
                posX = 0.11, -- adjust the position of the minimap horizontally
                posY = -0.00, -- adjust the position of the minimap vertically
                sizeX = 0.3, -- adjust the width of the minimap
                sizeY = 0.25, -- adjust the height of the minimap
            },
        },
        ['top-right'] = {
            alignX = 'R',
            alignY = 'T',
            minimap = {
                posX = 0.024, -- adjust the position of the minimap horizontally
                posY = 0.02, -- adjust the position of the minimap vertically
                sizeX = 0.194, -- adjust the width of the minimap
                sizeY = 0.189, -- adjust the height of the minimap
            },
            minimapMask = {
                posX = 0.02, -- adjust the position of the mask horizontally
                posY = 0.07, -- adjust the position of the mask vertically
                sizeX = 0.125, -- adjust the width of the mask
                sizeY = 0.3, -- adjust the height of the mask
            },
            minimapBlur = {
                posX = 0.11, -- adjust the position of the minimap horizontally
                posY = -0.00, -- adjust the position of the minimap vertically
                sizeX = 0.3, -- adjust the width of the minimap
                sizeY = 0.25, -- adjust the height of the minimap
            },
        },
    },
    electricVehicles = {
        [`surge`] = true,
        [`surge2`] = true,
        [`voltic`] = true,
        [`voltic2`] = true,
        [`raiden`] = true,
        [`cyclone`] = true,
        [`tezeract`] = true,
        [`neon`] = true,
        [`omnisegt`] = true,
        [`imorgon`] = true,
        [`dilettante`] = true,
        [`khamelion`] = true,
        [`caddy`] = true,
        [`caddy2`] = true,
        [`caddy3`] = true,
        [`airtug`] = true,
        [`rcbandito`] = true,
        [`iwagen`] = true,
    },
}