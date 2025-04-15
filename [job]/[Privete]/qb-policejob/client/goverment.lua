CreateThread(function()
    exports['qb-interact']:AddInteraction({
        coords =vector3(338.39337158203, -1667.4794921875, 54.586757659912),
        distance = 1.5,
        interactDst = 1.5, 
        id = "goverment-stash",
        groups = {
            ['goverment'] = 0, 
        },
        options = {
            {
                id = "goverment-sharedstash",
                label = 'Shared Stash',
                action = function(entity, coords, args)
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", "govermentsharestash", {maxweight = 100000, slots = 50})
                end,
                args = {}
            },
             {
                id =  "goverment-personalstash",
                label = 'Personal Stash',
                action = function(entity, coords, args)
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", "govermentpersonalstash_"..QBCore.Functions.GetPlayerData().citizenid, {maxweight = 100000, slots = 50})
                end,
                args = {}
            },
            {
                id =  "goverment-armory",
                label = "Armory",
                action = function(entity, coords, args)
                    TriggerEvent("nxo-shop:client:openshopname","govermentarmory")
                end,
                args = {}
            },
        }
    })

    exports['qb-interact']:AddInteraction({
        coords =vector3(336.06, -1663.08, 54.59),
        distance = 1.0,
        interactDst = 1.0, 
        id = "goverment-clothing", 
        groups = {
            ['goverment'] = 0, 
        },
        options = {
            {
                id ="goverment-outfit",
                label = "Outfit",
                event = "lvs_clothing:client:openOutfit",
                args = {}
            },
            {
                id = "goverment-clothingmenu",
                label = "Change Clothes",
                event = "lvs_clothing:client:OpenClothingShop",
                args = {}
            },
        }
    })
  
    exports['qb-interact']:AddInteraction({
        coords =vector3(321.08392333984, -1651.6872558594, 54.587753295898),
        distance = 3.0,
        interactDst = 1.5, 
        id = "govermentprinter",
        groups = {
            ['goverment'] = 0, 
        },
        options = {
            {
                label = "Use Printer",
                event = "qb-printer:client:openInteraction",
                args = {}
            },
        }
    })
    
    exports['qb-interact']:AddInteraction({
        coords = vector3(349.64584350586, -1654.0246582031, 54.587760925293),
        distance = 3.0,
        interactDst = 1.5, 
        id = "govermentonduty",
        groups = {
            ['goverment'] = 0, 
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

    exports['qb-interact']:AddInteraction({
        coords =vector3(313.04766845703, -1639.9519042969, 32.535301208496),
        distance = 2.5,
        interactDst = 1.5, 
        id = "govermentpublicprinter",
        options = {
            {
                label = "Use Printer (100$)",
                action = function(entity, coords, args)
                    TriggerEvent("qb-printer:client:openInteraction",{args{price=100}})
                end,
                args = {}
            },
        }
    })

    exports['qb-interact']:AddInteraction({
        coords =vector3(348.88, -1652.78, 54.30),
        distance = 4.0,
        interactDst = 1.0, 
        id = "goverment-paybill",
        options = {
            {
                id = "goverment-paybill",
                label = "Bill List",
                event = "qb-billing:openbill:client",
                args = {}
            },
        }
    })
    
    exports['qb-target']:AddBoxZone("mayordoorlock", vector3(342.12, -1618.09, 54.59), 0.1, 0.5, {
        name = "mayordoorlock",
        heading = 320,
        debugPoly = false,
        minZ = 54.29,
        maxZ =54.49,
    }, {
        options = {
            {
                type = "client",
                action = function(entity, coords, args)
                    TriggerServerEvent('qb-doorlock:server:updateState', "cityhall-19", true, false, false, true, false, false)
                end,
                icon = "fa fa-lock",
                label = "Lock Door",
                job = "goverment",
            },
            {
                type = "client",
                action = function(entity, coords, args)
                    TriggerServerEvent('qb-doorlock:server:updateState', "cityhall-19", false, false, false, true, false, false)
                end,
                icon = "fa fa-unlock",
                label = "Unlock Door",
                job = "goverment",
            },
        },
        distance = 2.0
    })
end)

