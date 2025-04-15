CreateThread(function()
    exports['qb-interact']:AddInteraction({
        coords = vector3(321.1155090332, -1650.8848876953, 47.243831634521),
        distance = 2.0,
        interactDst = 1.5, 
        id = "doj-badge",
        groups = {
            ['justice'] = 0, 
        },
        options = {
             {
                id =  "doj-badge",
                label = 'Take Badge',
                event =  "qb-policebadge:client:badge",
                args = {}
            },
        }
    })

    exports['qb-interact']:AddInteraction({
        coords = vector3(313.72906494141, -1644.4058837891, 47.243824005127),
        distance = 1.5,
        interactDst = 1.5, 
        id = "doj-stash",
        groups = {
            ['justice'] = 0, 
        },
        options = {
            {
                id =  "doj-sharedstash",
                label = 'Shared Stash',
                action = function(entity, coords, args)
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", "dojsharestash", {maxweight = 100000, slots = 50})
                end,
                args = {}
            },
            {
                id =  "doj-personalstash",
                label = 'Personal Stash',
                action = function(entity, coords, args)
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", "dojpersonalstash_"..QBCore.Functions.GetPlayerData().citizenid, {maxweight = 100000, slots = 50})
                end,
                args = {}
            },
            {
                id =  "doj-armory",
                label = "Armory",
                action = function(entity, coords, args)
                    TriggerEvent("nxo-shop:client:openshopname", "dojarmory")
                end,
                args = {}
            },
        }
    })

    exports['qb-interact']:AddInteraction({
        coords =vector3(325.20953369141, -1642.7432861328, 47.243816375732),
        distance = 2.5,
        interactDst = 1.5, 
        id = "doj-clothing",
        groups = {
            ['justice'] = 0, 
        },
        options = {
            {
                id ="doj-outfit",
                label = "Outfit",
                event = "lvs_clothing:client:openOutfit",
                args = {}
            },
          
            {
                id = "doj-clothingmenu",
                label = "Change Clothes",
                event = "lvs_clothing:client:OpenClothingShop",
                args = {}
            },
        }
    })

    exports['qb-interact']:AddInteraction({
        coords =vector3(321.1438293457, -1653.5285644531, 47.243816375732),
        distance = 2.5,
        interactDst = 1.5, 
        id = "doj-printer",
        groups = {
            ['justice'] = 0, 
        },
        options = {
            {
                id = "doj-printermenu", 
                label = "Use Printer",
                event = "qb-printer:client:openInteraction",
                args = {}
            },
           
        }
    })

    exports['qb-target']:AddBoxZone("justicdoor1", vector3(346.56, -1637.66, 38.93), 0.5, 0.5, {
        name = "justicdoor1",
        heading = 50,
        debugPoly = false,
        minZ = 38.73,
        maxZ =39.13,
    }, {
        options = {
            {
                type = "client",
                action = function(entity, coords, args)
                    TriggerServerEvent('qb-doorlock:server:updateState', "cityhall-3", true, false, false, true, false, false)
                end,
                icon = "fa fa-lock",
                label = "Lock Door",
                job = "justice",
            },
            {
                type = "client",
                action = function(entity, coords, args)
                    TriggerServerEvent('qb-doorlock:server:updateState', "cityhall-3", false, false, false, true, false, false)
                end,
                icon = "fa fa-unlock",
                label = "Unlock Door",
                job = "justice",
            },
        },
        distance = 2.0
    })

    exports['qb-target']:AddBoxZone("justicdoor2", vector3(339.56, -1622.57, 47.69), 0.3, 0.5, {
        name = "justicdoor2",
        heading = 320,
        debugPoly = false,
        minZ = 47.49,
        maxZ =47.89
    }, {
        options = {
            {
                type = "client",
                action = function(entity, coords, args)
                    TriggerServerEvent('qb-doorlock:server:updateState', "cityhall-11", true, false, false, true, false, false)
                end,
                icon = "fa fa-lock",
                label = "Lock Door",
                job = "justice",
            },
            {
                type = "client",
                action = function(entity, coords, args)
                    TriggerServerEvent('qb-doorlock:server:updateState', "cityhall-11", false, false, false, true, false, false)
                end,
                icon = "fa fa-unlock",
                label = "Unlock Door",
                job = "justice",
            },
        },
        distance = 2.0
    })
    
    exports['qb-interact']:AddInteraction({
        coords = vector3(323.34127807617, -1649.6459960938, 47.243827819824),
        distance = 3.0,
        interactDst = 1.5, 
        id = "justiconduty",
        groups = {
            ['justice'] = 0, ['lawyer'] = 0, 
        },
        options = {
            {
                label = "Duty Toggle",
                action = function(entity, coords, args)
                    TriggerServerEvent("QBCore:ToggleDuty")
                end,
                args = {}
            },
        }
    })

    exports['qb-target']:AddBoxZone("cityhall_gavel", vector3(345.47814941406, -1636.806640625, 39.100505828857), 2, 2, {
        name = "cityhall_gavel",
        debugPoly = false,
        minZ = 38.1,
        maxZ = 40.1,
    }, {
        options = {
            {
                action = function()
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "gavel_hits", 0.5)
                end,
                icon = "fa fa-gavel",
                label = "Gavel",
                job = "justice",
            },
        },
        distance = 2.5
    })
    exports['qb-target']:AddBoxZone("cityhall_gavel2", vector3(338.43426513672, -1621.8985595703, 47.686256408691), 2, 2, {
        name = "cityhall_gavel2",
        debugPoly = false,
        minZ = 46.6,
        maxZ = 48.6,
    }, {
        options = {
            {
                action = function()
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "gavel_hits", 0.5)
                end,
                icon = "fa fa-gavel",
                label = "Gavel",
                job = "justice",
            },
        },
        distance = 2.5
    })
end)