cfg = {
    debug = false,
    serverName = "NEXONE",
    serverNameDesc = "HEALTH-SYSTEM",
    minStumbleHealth = 0,
    accessableJobs = {
        -- ["all"] = true,
        ['ambulance'] = true,
        ['police'] = true,
    },
    damages = {
        [`weapon_unarmed`] = function() return  math.random(24,34) end,
        [`weapon_m4`] = function() return math.random(10, 20) end,
        [`weapon_assaultrifle`] = function() return math.random(15, 40) end
    },
    items = {
        ["bandage"] = {
            label = 'Bandage',
            description = '',
            icon = 'bandage.png', -- you can add new image from web/dist
            giveHealth = 50
        },
        ["splint"] = {
            label = 'Splint',
            description = '',
            icon = 'splint.png', -- you can add new image from web/dist
            giveHealth = 30
        },
        ["tourniquet"] = {
            label = 'Tourniquet',
            description = '',
            icon = 'tourniquet.png', -- you can add new image from web/dist
            giveHealth = 20
        },
        ["tweezers"] = {
            label = 'Tweezers',
            description = '',
            icon = 'tweezers.png', -- you can add new image from web/dist
            giveHealth = 20
        },
        ["medkit"] = {
            label = 'Med Kit',
            description = '',
            icon = 'medkit.png', -- you can add new image from web/dist
            giveHealth = 70
        },
        ["bullet"] = {
            label = 'Bullet',
            description = '',
            icon = 'bullet.png' -- you can add new image from web/dist
        },
        ["knife"] = {
            label = 'Melee',
            description = '',
            icon = 'knife.png' -- you can add new image from web/dist
        },
        ["unarmed"] = {
            label = 'Punch',
            description = '',
            icon = 'punch.png' -- you can add new image from web/dist
        }
    },

    locale = "en",
    locales = {
        ["en"] = {
            inventoryItemsHeader = "Healing items you have",
            inventoryItemsDesc = "You have to put the bandage over the wound ",
            injuryListHeader = "Combined Injury List",
            injuryListDesc = "You can determine the type of injury a person has.",
            healthStatusHeader = "Status of Health",
            healthStatusDesc = "Stay alert and monitor player health status to keep your player in peak condition during their journey!",
            youCantAccess = "You cannot access!",
            successfulAction = "You did successful action!",
            healthyBone = "This bone already healthy!",
            lArm = 'Left Arm',
            rArm = 'Right Arm',
            head = 'Head',
            body = 'Body',
            lLeg = 'Left Leg',
            rLeg = 'Right Leg',
            lFoot = 'Left Foot',
            rFoot = 'Right Foot',
            health = 'Health'
        }
    }
}
