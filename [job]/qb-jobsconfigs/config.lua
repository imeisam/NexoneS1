local QBCore = exports['qb-core']:GetCoreObject()

Config = {}
Config.shutter={
    {--smothie
      job="snrsmoothie",
      startcoord=vector4( -506.38177490234377,-706.5011596679688,35.58894119262695,0),
      upz=38.5,
      interactcoord=vector3(-506.4538269043, -708.90301513672, 33.67163848877),
    },
 
    {--sushi
        job="snrsushi",
        startcoord=vector4(-520.6661987304688,-714.4321899414063,35.58894119262695,27.72016525268554),
        upz=38.5,
        interactcoord=vector3(-521.67498779297, -712.18328857422, 33.671642303467),
      },
      {--coffe
        job="snrcoffee",
        startcoord=vector4(-523.108642578125,-709.1570434570313,35.58894119262695,21.40468215942382),
        upz=38.5,
        interactcoord=vector3(-523.92517089844, -706.82983398438, 33.671615600586),
      },
  
  
}
Config.BusinessZone = {
    {
        label = "cashexchange",
        zones = {
            vector2(145.72, -1340.12),
			vector2(131.16, -1319.73),
            vector2(103.78, -1336.79),
            vector2(129.86, -1362.3),
        },
        minz =-1000,
        maxz = 1000,
    },
    {
        label = "mechanicsh",
        zones = {
            vector2(21.42, -1671.09),
			vector2(-26.01, -1628.07),
			vector2(-74.18, -1689.59),
			vector2(-59.68, -1707.65),
        },
        minz =-1000,
        maxz = 1000,
    },
    {
        label = "snrbuns",
        zones = {
            vector2(-494.15, -669.86),
            vector2(-535.79, -671.47),
            vector2(-533.21, -715.53),
            vector2(-512.84, -741.67),
            vector2(-496.34, -739.85),
        },
        minz =-1000,
        maxz = 1000,
    },
    {
        label = "unicorn",
        zones = {
            vector2(145.53, -1292.9),
            vector2(101.8, -1320.44),
            vector2(82.02, -1284.07),
            vector2(134.94, -1272.03),
        },
        minz =-1000,
        maxz = 1000,
    },
    {
        label = "digitalden",
        zones = {
            vector2(224.62, -1533.53),
            vector2(239.49, -1521.29),
            vector2(213.76, -1493.9),
            vector2(198.92, -1510.34)
        },
        minz =-1000,
        maxz = 1000,
    },
    {
        label = "pawnshop",
        zones = {
            vector2(147.68, -1725.82),
            vector2(141.19, -1720.8),
            vector2(154.02, -1705.59),
            vector2(160.28, -1711.42),
        },
        minz =-1000,
        maxz = 1000,
    },
    {
        label = "gallery",
        zones = {
            vector2(94.23, -150.32),
            vector2(106.76, -113.78),
            vector2(160.86, -131.38),
            vector2(149.45, -171.15),
        },
        minz =-1000,
        maxz = 1000,
    },
    -- {
    --     label = "catcafe",
    --     zones = {
    --         vector2(-565.6, -1071.41),
    --         vector2(-601.01, -1070.19),
    --         vector2(-599.09, -1048.43),
    --         vector2(-565.37, -1047.57),
    --     },
    --     minz =-1000,
    --     maxz = 1000,
    -- },
    {
        label = "snrsushi",
        zones = {
            vector2(-536.8, -687.86),
            vector2(-520.25, -744.81),
            vector2(-498.43, -742.11),
            vector2(-497.02, -673.93),
        },
        minz =-1000,
        maxz = 1000,
    },
    {
        label = "snrcoffee",
        zones = {
            vector2(-536.8, -687.86),
            vector2(-520.25, -744.81),
            vector2(-498.43, -742.11),
            vector2(-497.02, -673.93),
        },
        minz =-1000,
        maxz = 1000,
    },
    {
        label = "snrsmoothie",
        zones = {
            vector2(-536.8, -687.86),
            vector2(-520.25, -744.81),
            vector2(-498.43, -742.11),
            vector2(-497.02, -673.93),
        },
        minz =-1000,
        maxz = 1000,
    },
    {
        label = "tuner",
        zones = {
            vector2(910.6, -1012.23),
            vector2(910.44, -1074.61),
            vector2(981.44, -1071.35),
            vector2(988.85, -1008.81),
        },
        minz =-1000.0,
        maxz = 1000.0,
    },
    {
        label = "tequilala",
        zones = {
            vector2(-534.809, 264.634),
            vector2(-611.728, 282.927),
            vector2(-583.072, 314.939),
            vector2(-537.826, 305.793),
        },
        minz =-1000.0,
        maxz = 1000.0,
    },
    {
        label = "snrpizza",
        zones = {
            vector2(-536.8, -687.86),
            vector2(-520.25, -744.81),
            vector2(-498.43, -742.11),
            vector2(-497.02, -673.93),
        },
        minz =-1000,
        maxz = 1000,
    },
    {
        label = "yellowjack",
        zones = {
            vector2(1986.2474365234, 3102.7797851562),
            vector2(1931.7969970703, 3030.1640625),
            vector2(1968.1291503906, 2985.1513671875),
            vector2(2042.8110351562, 3053.25390625),
        },
        minz =-1000,
        maxz = 1000,
    },
}

Config.Jobs = {
    ['banner']={
        
     },
    ['Blip'] = {
        {
            coords = vector3(268.45, 217.38, 106.28),
            sprite = 108,
            color = 1,
            label = 'Pacific Bank'
        },
        {
            coords = vector3(-37.38, -1677.39, 29.49),
            sprite = 50,
            color = 2,
            label = 'Mosleys Auto'
        },
        {
            coords = vector3(948.95, -1026.16, 40.97),
            sprite = 641,
            color = 0,
            label = 'Tuner Shop'
        },
        {
            coords = vector3(-766.42, -24.2, 41.08),
            sprite = 206,
            color = 47,
            label = 'Church'
       },
       {
            coords = vector3(146.72, -1718.53, 29.32),
            sprite = 605,
            color = 5,
            label = 'Pawn Shop'
        },
        {
            coords = vector3(87.12, -1554.46, 29.61),
            sprite = 728,
            color = 18,
            label = 'Laundromat'
        },
        {
            coords = vector3(217.87, -1512.83, 29.29),
            sprite = 606,
            color = 24,
            label = 'Click Lovers'
        },
        {
            coords = vector3(1139.23, -471.24, 66.66),
            sprite = 619,
            color = 83,
            label = 'DigitalDen'
        },
        {
            coords = vector3(426.55, -1893.44, 26.46),
            sprite = 500,
            color = 2,
            label = 'Cash Exchange'
        },
        {
            coords = vector3(125.04, -1346.02, 29.71),                
            sprite = 500,
            color = 2,
            label = 'Cash Exchange'
        },
        {
            coords = vector3(114.69, -150.96, 54.8),
            sprite = 269,
            color = 3,
            label = 'Art Gallery'
        },
        -- {
        --     coords = vector3(-580.97, -1067.21, 22.34),
        --     sprite = 621,
        --     color = 41,
        --     label = 'UwU Cafe'
        -- },
        {
            coords = vector3(1185.86, -3256.59, 6.39),
            sprite = 477,
            color = 5,
            label = 'Delivery'
        },
        {
            coords = vector3(-508.39, -694.76, 33.59),
            sprite = 293,
            color = 5,
            label = "Snr Buns"
        },
        {
            coords = vector3(-564.70599365234, 277.01290893555, 83.136329650879),
            sprite = 93,
            color = 1,
            label = "Tequilala Club"
        },
        {
            coords = vector3(1985.8865966797, 3050.1469726562, 47.215061187744),
            sprite = 93,
            color = 66,
            label = "Yellow Jack"
        },
        
    },
    ['bill'] = {
        -- ['uwu1']={coords =vector3(-584.03, -1061.47, 22.37),jobname='catcafe'},
        -- ['uwu2']={coords =vector3(-584.0, -1058.75, 22.37),jobname='catcafe'},
        ['pawnshop1']={coords = vector3(147.72981262207, -1714.1062011719, 29.580571365356),jobname='pawnshop'},
        ['artgallery']={coords =vector3(118.41027832031, -147.84013366699, 55.093836975098),jobname='gallery'},
        ['digitallden1']={coords =vector3(1133.1276855469, -468.30419921875, 66.846484375),jobname='digitalden'},
        ['digitallden_clicklovers']={coords =vector3(212.3067779541, -1508.7257080078, 29.294567108154),jobname='digitalden'},
        ['snrsushi']={coords =vector3(-521.8, -713.28, 33.67),jobname='snrsushi'},
        ['snrbuns1']={coords =vector3(-507.91506958008, -694.52880859375, 33.671600341797),jobname='snrbuns'},
        ['snrbuns2']={coords =vector3(-508.00100708008, -695.91296386719, 33.671600341797),jobname='snrbuns'},
        ['snrbuns3']={coords =vector3(-507.90084838867, -697.5283203125, 33.671600341797),jobname='snrbuns'},
        ['snrcaffe']={coords =vector3(-524.32, -708.8, 33.67),jobname='snrcoffee'},
        ['mechanicsh']={coords =vector3(-23.05, -1663.38, 29.5),jobname='mechanicsh'},
        ['tuner']={coords =vector3(956.33, -1046.06, 40.97),jobname='tuner'},
        ['snrsmoothie']={coords =vector3(-505.89114379883, -706.01446533203, 33.671592712402),jobname='snrsmoothie'},
        ['realestate']={coords =vector3(-707.34, 271.68, 83.15),jobname='realestate'},
        ['tequilala']={coords =vector3(-560.83306884766, 289.23272705078, 82.176345825195),jobname='tequilala'},
        ['snrpizza']={coords =vector3(-518.19708251953, -719.99249267578, 33.6715965271),jobname='snrpizza'},
        ['yellowjack']={coords =vector3(1981.7934570312, 3053.7531738281, 47.215099334717),jobname='yellowjack'},

    },
    ['Stash'] = {
       
        ['digitallden'] = {
            coords = vector3(1133.74, -466.59, 66.49) ,
            options = {
                {
                    action = function()
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "digitallden_Stash", {maxweight = 1000000, slots = 100})
                    end,
                    icon = "fas fa-box-open",
                    label = "Shared Stash",
                    job = 'digitalden',
                },
                {
                     action = function()
                         TriggerServerEvent("inventory:server:OpenInventory", "stash", "gbStash_"..QBCore.Functions.GetPlayerData().citizenid, {maxweight = 500000, slots = 100})
                     end,
                     icon = "fas fa-box-open",
                     label = "Personal Stash",
                     job = 'digitalden',
                },
            },
        },
        ['digitallden_clicklovers'] = {
            coords =  vector3(207.08834838867, -1509.2208251953, 29.289503097534) ,
            options = {
                {
                    action = function()
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "digitallden_Stash", {maxweight = 1000000, slots = 100})
                    end,
                    icon = "fas fa-box-open",
                    label = "Shared Stash",
                    job = 'digitalden',
                },
                {
                     action = function()
                         TriggerServerEvent("inventory:server:OpenInventory", "stash", "gbStash_"..QBCore.Functions.GetPlayerData().citizenid, {maxweight = 500000, slots = 100})
                     end,
                     icon = "fas fa-box-open",
                     label = "Personal Stash",
                     job = 'digitalden',
                },
            },
        },
        
        ['snrbuns'] = {
            coords = vector3(-503.2405090332, -703.17913818359, 33.6715965271),
            options = {
                {
                    action = function()
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "snrbuns_Stash", {maxweight = 1000000, slots = 100})
                    end,
                    icon = "fas fa-box-open",
                    label = "Shared Stash",
                    job = 'snrbuns',
                },
                {
                     action = function()
                         TriggerServerEvent("inventory:server:OpenInventory", "stash", "snrbuns_personal_"..QBCore.Functions.GetPlayerData().citizenid, {maxweight = 500000, slots = 100})
                     end,
                     icon = "fas fa-box-open",
                     label = "Personal Stash",
                     job = 'snrbuns',
                },
            },
        },
        ['snrbunsyakhchal'] = {
            coords = vector3(-507.86672973633, -685.99151611328, 33.671195983887),
            options = {
                
                {
                    action = function()
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "snrbuns_refrigerator", {maxweight = 1000000, slots = 100})
                    end,
                    icon = "fas fa-box-open",
                    label = "Refrigerator",
                    job = 'snrbuns',
                },
                
            },
        },
        ['snrbuns_readystash'] = {
            coords = vector3(-506.76666259766, -691.13629150391, 33.671195983887),
            options = {
              
                {
                    action = function()
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "snrbuns_readycounter", {maxweight = 500000, slots = 100})
                    end,
                    icon = "fas fa-box-open",
                    label = "Counter",
                    job = 'snrbuns',
                },
                
            },
        },
        ['tequilalayakhchal'] = {
            coords = vector3(-562.8, 284.55, 82.18),
            options = {
                
                {
                    action = function()
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "tequilala_refrigerator", {maxweight = 1000000, slots = 100})
                    end,
                    icon = "fas fa-box-open",
                    label = "Refrigerator",
                    job = 'tequilala',
                },
                
            },
        },
        ['tequilala_readystash'] = {
            coords = vector3(-561.02, 286.3, 82.18),
            options = {
              
                {
                    action = function()
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "tequilala_readycounter", {maxweight = 500000, slots = 100})
                    end,
                    icon = "fas fa-box-open",
                    label = "Counter",
                    
                },
                
            },
        },
        
        
        ['tuner'] = {
            coords = vector3(939.49, -1042.37, 40.97) ,
            options = {
                -- {
                --     action = function()
                --         TriggerServerEvent("inventory:server:OpenInventory", "stash", "gb_hc__Stash", {maxweight = 500000, slots = 100})
                --     end,
                --     icon = "fas fa-box-open",
                --     label = "High Ranks Stash",
                --     job = 'digitalden',
                --     canInteract = function()
                --         if QBCore.Functions.GetPlayerData().gang.grade.level >= 2 then
                --             return true
                --         end
                --         return false
                --     end,
                -- },
                {
                    action = function()
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "tuner_Stash", {maxweight = 1000000, slots = 100})
                    end,
                    icon = "fas fa-box-open",
                    label = "Shared Stash",
                    job = 'tuner',
                },
                {
                     action = function()
                         TriggerServerEvent("inventory:server:OpenInventory", "stash", "tuner_ShareStash"..QBCore.Functions.GetPlayerData().citizenid, {maxweight = 500000, slots = 100})
                     end,
                     icon = "fas fa-box-open",
                     label = "Personal Stash",
                     job = 'tuner',
                },
            },
        },
        ['lsnewsstash'] = {
            coords =  vector3(-603.21313476562, -918.28698730469, 23.777156829834) ,
            options = {
                -- {
                --     action = function()
                --         TriggerServerEvent("inventory:server:OpenInventory", "stash", "gb_hc__Stash", {maxweight = 500000, slots = 100})
                --     end,
                --     icon = "fas fa-box-open",
                --     label = "High Ranks Stash",
                --     job = 'digitalden',
                --     canInteract = function()
                --         if QBCore.Functions.GetPlayerData().gang.grade.level >= 2 then
                --             return true
                --         end
                --         return false
                --     end,
                -- },
                {
                    action = function()
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "lsnews_shareStash", {maxweight = 1000000, slots = 100})
                    end,
                    icon = "fas fa-box-open",
                    label = "Shared Stash",
                    job = 'lsnews',
                },
                {
                     action = function()
                         TriggerServerEvent("inventory:server:OpenInventory", "stash", "lsnews_Stash"..QBCore.Functions.GetPlayerData().citizenid, {maxweight = 500000, slots = 100})
                     end,
                     icon = "fas fa-box-open",
                     label = "Personal Stash",
                     job = 'lsnews',
                },
            },
        },
       
        ['snrsushi'] = {
            coords = vector3(-524.43, -716.56, 33.67) ,
            options = {
                -- {
                --     action = function()
                --         TriggerServerEvent("inventory:server:OpenInventory", "stash", "gb_hc__Stash", {maxweight = 500000, slots = 100})
                --     end,
                --     icon = "fas fa-box-open",
                --     label = "High Ranks Stash",
                --     job = 'digitalden',
                --     canInteract = function()
                --         if QBCore.Functions.GetPlayerData().gang.grade.level >= 2 then
                --             return true
                --         end
                --         return false
                --     end,
                -- },
                {
                    action = function()
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "snrsushi_Stash", {maxweight = 1000000, slots = 100})
                    end,
                    icon = "fas fa-box-open",
                    label = "Shared Stash",
                    job = 'snrsushi',
                },
                -- {
                --     action = function()
                --         TriggerServerEvent("inventory:server:OpenInventory", "stash", "gbStash_"..QBCore.Functions.GetPlayerData().citizenid, {maxweight = 1000000, slots = 100})
                --     end,
                --     icon = "fas fa-box-open",
                --     label = "Personal Stash",
                --     gang = 'gb',
                -- },
            },
        },
        ['mechanicsh'] = {
            coords = vector3(3.88, -1663.64, 29.49),
            options = {
                -- {
                --     action = function()
                --         TriggerServerEvent("inventory:server:OpenInventory", "stash", "gb_hc__Stash", {maxweight = 500000, slots = 100})
                --     end,
                --     icon = "fas fa-box-open",
                --     label = "High Ranks Stash",
                --     job = 'digitalden',
                --     canInteract = function()
                --         if QBCore.Functions.GetPlayerData().gang.grade.level >= 2 then
                --             return true
                --         end
                --         return false
                --     end,
                -- },
                -- {
                --     action = function()
                --         TriggerServerEvent("inventory:server:OpenInventory", "stash", "digitallden_Stash", {maxweight = 100000, slots = 30})
                --     end,
                --     icon = "fas fa-box-open",
                --     label = "Shared Stash",
                --     job = 'digitalden',
                -- },
                {
                    action = function()
                         TriggerServerEvent("inventory:server:OpenInventory", "stash", "mosleystash"..QBCore.Functions.GetPlayerData().citizenid, {maxweight = 500000, slots = 100})
                    end,
                    icon = "fas fa-box-open",
                    label = "Personal Stash",
                    job = 'mechanicsh',
                },
            },
        },
        -- ['snrsushi_share'] = {
        --     coords =vector3(-523.11, -713.04, 33.30),
        --     options = {
        --         {
        --             canInteract = function()
        --                 if QBCore.Functions.GetPlayerData().job.name== 'snrsushi' then
        --                     return true
        --                 end
        --                 return false
        --             end,
        --             action = function()
        --                 TriggerServerEvent("inventory:server:OpenInventory", "stash", "snrsushi", {maxweight = 75000, slots = 25})
        --             end,
        --             icon = "fas fa-box-open",
        --             label = "Share Stash",
        --         },
        --     },
        -- },
        ['mechanicshboss'] = {
            coords = vector3(-13.28, -1651.73, 29.49),
            options = {
                {
                    canInteract = function()
                        if QBCore.Functions.GetPlayerData().job.grade.level == 2 or QBCore.Functions.GetPlayerData().job.grade.level == 3 then
                            return true
                        end
                        return false
                    end,
                    job = 'mechanicsh',
                    action = function()
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "mechanicsh", {maxweight = 1000000, slots = 30})
                    end,
                    icon = "fas fa-box-open",
                    label = "Boss Stash",
                },
            },
        },
        
        ['mechanicshpublic2'] = {
            coords =   vector3(-6.43, -1677.77, 29.49),
            options = {
                {
                    job = 'mechanicsh',
                    action = function()
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "mechanicsh_pubic", {maxweight = 1000000, slots = 100})
                    end,
                    icon = "fas fa-box-open",
                    label = "Stash",
                },
                {
                    job = 'mechanicsh',
                    action = function()
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "mechanicsh_private_"..QBCore.Functions.GetPlayerData().citizenid, {maxweight = 500000, slots = 100})
                    end,
                    icon = "fas fa-box-open",
                    label = "Personal Stash",
                },
            },
        },

        ['pawnshopstash'] = {
            coords =   vector3(152.41117858887, -1709.0815429688, 29.310745239258),
            options = {
                {
                    job = 'pawnshop',
                    action = function()
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "pawnshop_stash", {maxweight = 1000000, slots = 50})
                    end,
                    icon = "fas fa-box-open",
                    label = "Stash",
                },
                {
                    job = 'pawnshop',
                    action = function()
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "pawnshop_personal_"..QBCore.Functions.GetPlayerData().citizenid, {maxweight = 500000, slots = 100})
                    end,
                    icon = "fas fa-box-open",
                    label = "Personal Stash",
                },
            },
        },
        ['yellowjackstash'] = {
            coords = vector3(1988.3815917969, 3049.4729003906, 50.501663208008),
            options = {
                {
                    job = 'yellowjack',
                    action = function()
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "yellowjack_personal_"..QBCore.Functions.GetPlayerData().citizenid, {maxweight = 500000, slots = 100})
                    end,
                    icon = "fas fa-box-open",
                    label = "Personal Stash",
                },
            },
        },
        ['snrpizzastash'] = {
            coords =vector3(-519.91027832031, -723.23693847656, 33.071600341797),
            options = {
               
                {
                    job = 'snrpizza',
                    action = function()
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "snrpizza_personal_"..QBCore.Functions.GetPlayerData().citizenid, {maxweight = 500000, slots = 100})
                    end,
                    icon = "fas fa-box-open",
                    label = "Personal Stash",
                },
            },
        },
        
        ['tequilala_stash'] = {
            coords =  vector3(-574.48706054688, 293.8489074707, 79.176689147949),
            options = {
                {
                    job = 'tequilala',
                    action = function()
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "tequilala_stash", {maxweight = 1000000, slots = 50})
                    end,
                    icon = "fas fa-box-open",
                    label = "Share Stash",
                },
                {
                    job = 'tequilala',
                    action = function()
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "tequilala_personal_"..QBCore.Functions.GetPlayerData().citizenid, {maxweight = 500000, slots = 100})
                    end,
                    icon = "fas fa-box-open",
                    label = "Personal Stash",
                },
            },
        },
        ['gallerystash'] = {
            coords =   vector3(111.03, -141.5, 54.8),
            options = {
                {
                    job = 'gallery',
                    action = function()
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "gallery_stash", {maxweight = 1000000, slots = 50})
                    end,
                    icon = "fas fa-box-open",
                    label = "Stash",
                },
            },
        },
        -- ['catcafe'] = {
        --     coords = vector3(-597.37, -1062.47, 22.34),
        --     options = {
        --         {
        --             job = 'catcafe',
        --             action = function()
        --                 TriggerServerEvent("inventory:server:OpenInventory", "stash", "uwu_stash33", {maxweight = 1000000, slots = 100})
        --             end,
        --             icon = "fas fa-box-open",
        --             label = "Stash I",
        --         },
        --         {
        --             job = 'catcafe',
        --             action = function()
        --                 TriggerServerEvent("inventory:server:OpenInventory", "stash", "uwu_stash32", {maxweight = 1000000, slots = 100})
        --             end,
        --             icon = "fas fa-box-open",
        --             label = "Stash II",
        --         },
        --         {
        --             job = 'catcafe',
        --             action = function()
        --                 TriggerServerEvent("inventory:server:OpenInventory", "stash", "uwu_stash322", {maxweight = 1000000, slots = 100})
        --             end,
        --             icon = "fas fa-box-open",
        --             label = "Stash III",
        --         },
        --         {
        --             job = 'catcafe',
        --             action = function()
        --                 TriggerServerEvent("inventory:server:OpenInventory", "stash", "uwu_personal_Stash_"..QBCore.Functions.GetPlayerData().citizenid, {maxweight = 500000, slots = 50})
        --             end,
        --             icon = "fas fa-box-open",
        --             label = "Personal Stash",
        --         },
        --     },
        -- },
        -- ['catcafetable'] = {
        --     coords = vector3(-587.80902099609, -1059.7471923828, 22.356168746948),
        --     options = {
        --         {
        --             job = 'catcafe',
        --             action = function()
        --                 TriggerServerEvent("inventory:server:OpenInventory", "stash", "uwu_stashtable", {maxweight = 500000, slots = 100})
        --             end,
        --             icon = "fas fa-box-open",
        --             label = "Stash",
        --         },
        --     },
        -- },
        ['mrpdyakhchal'] = {
            coords = vector3(447.96, -995.37, 30.69),
            options = {
                {
                    job = 'police',
                    action = function()
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "mrpd_yakhchal", {maxweight = 500000, slots = 90})
                    end,
                    icon = "fas fa-box-open",
                    label = "Stash",
                },
            },
        },
        ['snrsmoothieyakhchal'] = {
            coords =  vector3(-502.32360839844, -704.52020263672, 33.671600341797),
            options = {
                {
                    job = 'snrsmoothie',
                    action = function()
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "snrsmoothie_yakhchal", {maxweight = 1000000, slots = 90})
                    end,
                    icon = "fas fa-box-open",
                    label = "Refrigerator",
                },
            },
        },
        ['snrpizzayakhchal'] = {
            coords = vector3(-518.29229736328, -722.76116943359, 33.1715965271),
            options = {
                {
                    job = 'snrpizza',
                    action = function()
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "snrpizza_yakhchal", {maxweight = 1000000, slots = 90})
                    end,
                    icon = "fas fa-box-open",
                    label = "Refrigerator",
                },
            },
        },
        ['yellowjackyakhchal'] = {
            coords =vector3(1985.1499023438, 3048.5505371094, 47.215030670166),
            options = {
                {
                    job = 'yellowjack',
                    action = function()
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "yellowjack_yakhchal", {maxweight = 1000000, slots = 90})
                    end,
                    icon = "fas fa-box-open",
                    label = "Refrigerator",
                },
            },
        },
    },
    ['Counter'] = {
        
        {
            coords = vector3(-505.61932373047, -706.728515625, 34.15160369873),
            name = 'snrsmoothie_counter',
            slot = 50,
            weight = 500000
        },
        {
            coords = vector3(-521.43, -714.06, 33.67),
            name = 'sushi_counter',
            slot = 50,
            weight = 500000
        },
        {
            coords = vector3(-524.55, -708.17, 33.67),
            name = 'caffe_counter',
            slot = 50,
            weight = 500000
        },
        {
            coords = vector3(1134.35, -468.86, 66.49),
            name = 'digitalden_counter',
            slot = 50,
            weight = 500000
        },
        {
            coords = vector3(213.10145568848, -1508.0443115234, 29.294567108154),
            name = 'digitaldenclicklovers_counter',
            slot = 50,
            weight = 500000
        },
        {
            coords = vector3(148.43, -1714.63, 29.31),
            name = 'pawnshop_counter',
            slot = 50,
            weight = 500000
        },
        {
            coords = vector3(117.59, -147.51, 54.8),
            name = 'gallery_counter',
            slot = 50,
            weight = 500000
        },
        -- {
        --     coords = vector3(-584.00927734375, -1061.9978027344, 22.644193649292),
        --     name = 'uwu_counter',
        --     slot = 50,
        --     weight = 500000
        -- },
        -- {
        --     coords = vector3(-584.04510498047, -1059.3404541016, 22.644193649292),
        --     name = 'uwu2_counter',
        --     slot = 50,
        --     weight = 500000
        -- },
        {
            coords =  vector3(-508.40045166016, -698.29187011719, 33.6715965271),
            name = 'snrbuns1_counter',
            slot = 50,
            weight = 500000
        },
        {
            coords =vector3(-508.41979980469, -696.69897460938, 33.6715965271),
            name = 'snrbuns2_counter',
            slot = 50,
            weight = 500000
        },
        {
            coords =  vector3(-508.31344604492, -695.26013183594, 33.6715965271),
            name = 'snrbuns3_counter',
            slot = 50,
            weight = 500000
        },
        {
            coords = vector3(-517.74011230469, -720.31011962891, 33.671600341797),
            name = 'snrpizza_counter',
            slot = 50,
            weight = 500000
        },
        {
            coords = vector3(1985.1353759766, 3054.2570800781, 47.215099334717),
            name = 'yellowjack_counter',
            slot = 50,
            weight = 500000
        },
    },
    ['Craft'] = {
        ['digitalden'] = {
            jobname = 'digitalden',
            coords = vector3(211.61741638184, -1504.8127441406, 29.289503097534),
            items = {
                ['phone'] = {
                    ['copper'] = 16,
                    ['electronics'] = 16,
                    ['plastic'] = 16,
                    ['aluminum'] = 16,
                    ['glass'] = 16,
                },
                ['radio'] = {
                    ['copper'] = 16,
                    ['electronics'] = 16,
                    ['plastic'] = 16,
                    ['aluminum'] = 16,
                    ['glass'] = 16,
                },
                ['laptop'] = {
                    ['copper'] = 16,
                    ['electronics'] = 16,
                    ['plastic'] = 16,
                    ['aluminum'] = 16,
                    ['glass'] = 16,
                },
                ['boombox'] = {
                    ['copper'] = 16,
                    ['electronics'] = 16,
                    ['plastic'] = 16,
                    ['aluminum'] = 16,
                    ['scrapmetal'] = 16,
                },
                ['gopro'] = {
                    ['copper'] = 30,
                    ['electronics'] = 30,
                    ['plastic'] = 30,
                    ['aluminum'] = 30,
                    ['scrapmetal'] = 30,
                },
                ['weapon_flashlight'] = {
                    ['copper'] = 30,
                    ['electronics'] = 30,
                    ['plastic'] = 30,
                    ['aluminum'] = 30,
                    ['scrapmetal'] = 30,
                },
            }
        },
        ['digitaldenboss'] = {
            jobname = 'digitalden',
            rank = 3,
            coords = vector3(207.22616577148, -1507.0246582031, 29.289503097534),
            items = {
                ['gamenent_ticket'] = {
                    ['copper'] = 5,
                    ['electronics'] = 2,
                    ['plastic'] = 6,
                    ['aluminum'] = 2,
                    ['scrapmetal'] = 4,
                },
            }
        },
        ['pawnshop'] = {
            jobname = 'pawnshop',
            coords = vector3(150.7, -1713.74, 29.32),
            items = {

            }
        },
        ['gallery'] = {
            jobname = 'gallery',
            coords = vector3(115.34, -139.74, 54.8),
            items = {

            }
        },
        ['mosleymc2'] = {
            jobname = 'mechanicsh',
            coords = vector3(-17.67, -1663.8, 29.49),
            items = {
                ['customplate'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['hood'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['roof'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['spoiler'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['bumper'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['skirts'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['exhaust'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['seat'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['rims'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['livery'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['rollcage'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['paintcan'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['tires'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['horn'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['internals'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['externals'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
            }
        },
        ['tuner2'] = {
            jobname = 'tuner',
            coords = vector3(938.78, -1052.09, 40.97),
            items = {
                ['customplate'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['hood'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['roof'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['spoiler'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['bumper'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['skirts'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['exhaust'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['seat'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['rims'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['livery'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['rollcage'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['paintcan'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['tires'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['horn'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['internals'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
                ['externals'] = {
                    ['copper'] = 5,
                    ['rubber'] = 5,
                    ['aluminum'] = 5,
                    ['scrapmetal'] = 5,
                },
            }
        },
        ['mosleymc'] = {
            jobname = 'mechanicsh',
            coords = vector3(-12.67, -1657.24, 29.5),
            items = {
                ['turbo_d'] = {
                    ['copper'] = 16,
                    ['rubber'] = 16,
                    ['aluminum'] = 16,
                    ['scrapmetal'] = 16,
                },
                ['turbo_c'] = {
                    ['copper'] = 30,
                    ['rubber'] = 30,
                    ['aluminum'] = 30,
                    ['scrapmetal'] = 30,
                },
                ['turbo_b'] = {
                    ['copper'] = 60,
                    ['rubber'] = 60,
                    ['aluminum'] = 60,
                    ['scrapmetal'] = 60,
                },
                ['turbo_a'] = {
                    ['copper'] = 120,
                    ['rubber'] = 120,
                    ['aluminum'] = 120,
                    ['scrapmetal'] = 120,
                },
                ['turbo_s'] = {
                    ['copper'] = 260,
                    ['rubber'] = 260,
                    ['aluminum'] = 260,
                    ['scrapmetal'] = 260,
                },
                ['car_armor_d'] = {
                    ['copper'] = 20,
                    ['steel'] = 20,
                    ['plastic'] = 20,
                    ['scrapmetal'] = 20,
                },
                ['car_armor_c'] = {
                    ['copper'] = 40,
                    ['steel'] = 40,
                    ['plastic'] = 40,
                    ['scrapmetal'] = 40,
                },
                ['car_armor_b'] = {
                    ['copper'] = 70,
                    ['steel'] = 70,
                    ['plastic'] = 70,
                    ['scrapmetal'] = 70,
                },
                ['car_armor_a'] = {
                    ['copper'] = 170,
                    ['steel'] = 170,
                    ['plastic'] = 170,
                    ['scrapmetal'] = 170,
                },
                ['car_armor_s'] = {
                    ['copper'] = 340,
                    ['steel'] = 340,
                    ['plastic'] = 340,
                    ['scrapmetal'] = 340,
                },
                ['engine4_d'] = {
                    ['copper'] = 24,
                    ['rubber'] = 24,
                    ['aluminum'] = 24,
                    ['scrapmetal'] = 24,
                },
                ['engine4_c'] = {
                    ['copper'] = 50,
                    ['rubber'] = 50,
                    ['aluminum'] = 50,
                    ['scrapmetal'] = 50,
                },
                ['engine4_b'] = {
                    ['copper'] = 90,
                    ['steel'] = 90,
                    ['aluminum'] = 90,
                    ['scrapmetal'] = 90,
                },
                ['engine4_a'] = {
                    ['copper'] = 190,
                    ['rubber'] = 190,
                    ['aluminum'] = 190,
                    ['scrapmetal'] = 190,
                },
                ['engine4_s'] = {
                    ['copper'] = 380,
                    ['rubber'] = 380,
                    ['aluminum'] = 380,
                    ['scrapmetal'] = 380,
                },
                ['transmission3_d'] = {
                    ['copper'] = 20,
                    ['steel'] = 20,
                    ['plastic'] = 20,
                    ['scrapmetal'] = 20,
                },
                ['transmission3_c'] = {
                    ['copper'] = 40,
                    ['steel'] = 40,
                    ['plastic'] = 40,
                    ['scrapmetal'] = 40,
                },
                ['transmission3_b'] = {
                    ['copper'] = 70,
                    ['steel'] = 70,
                    ['plastic'] = 70,
                    ['scrapmetal'] = 70,
                },
                ['transmission3_a'] = {
                    ['copper'] = 170,
                    ['steel'] = 170,
                    ['plastic'] = 170,
                    ['scrapmetal'] = 170,
                },
                ['transmission3_s'] = {
                    ['copper'] = 340,
                    ['steel'] = 340,
                    ['plastic'] = 340,
                    ['scrapmetal'] = 340,
                },
                ['brakes3_d'] = {
                    ['copper'] = 20,
                    ['steel'] = 20,
                    ['rubber'] = 20,
                    ['scrapmetal'] = 20,
                },
                ['brakes3_c'] = {
                    ['copper'] = 40,
                    ['steel'] = 40,
                    ['rubber'] = 40,
                    ['scrapmetal'] = 40,
                },
                ['brakes3_b'] = {
                    ['copper'] = 70,
                    ['steel'] = 70,
                    ['rubber'] = 70,
                    ['scrapmetal'] = 70,
                },
                ['brakes3_a'] = {
                    ['copper'] = 170,
                    ['steel'] = 170,
                    ['rubber'] = 170,
                    ['scrapmetal'] = 170,
                },
                ['brakes3_s'] = {
                    ['copper'] = 340,
                    ['steel'] = 340,
                    ['rubber'] = 340,
                    ['scrapmetal'] = 340,
                },
                ['suspension1'] = {
                    ['copper'] = 16,
                    ['rubber'] = 16,
                    ['aluminum'] = 16,
                    ['scrapmetal'] = 16,
                },
                ['suspension2'] = {
                    ['copper'] = 30,
                    ['rubber'] = 30,
                    ['aluminum'] = 30,
                    ['scrapmetal'] = 30,
                },
                ['suspension3'] = {
                    ['copper'] = 60,
                    ['rubber'] = 60,
                    ['aluminum'] = 60,
                    ['scrapmetal'] = 60,
                },
                ['suspension4'] = {
                    ['copper'] = 120,
                    ['rubber'] = 120,
                    ['aluminum'] = 120,
                    ['scrapmetal'] = 120,
                },
            }
        },
        ['tuner'] = {
            jobname = 'tuner',
            coords = vector3(943.02, -1055.83, 40.97),
            items = {
                ['turbo_d'] = {
                    ['copper'] = 16,
                    ['rubber'] = 16,
                    ['aluminum'] = 16,
                    ['scrapmetal'] = 16,
                },
                ['turbo_c'] = {
                    ['copper'] = 30,
                    ['rubber'] = 30,
                    ['aluminum'] = 30,
                    ['scrapmetal'] = 30,
                },
                ['turbo_b'] = {
                    ['copper'] = 60,
                    ['rubber'] = 60,
                    ['aluminum'] = 60,
                    ['scrapmetal'] = 60,
                },
                ['turbo_a'] = {
                    ['copper'] = 120,
                    ['rubber'] = 120,
                    ['aluminum'] = 120,
                    ['scrapmetal'] = 120,
                },
                ['turbo_s'] = {
                    ['copper'] = 260,
                    ['rubber'] = 260,
                    ['aluminum'] = 260,
                    ['scrapmetal'] = 260,
                },
                ['car_armor_d'] = {
                    ['copper'] = 20,
                    ['steel'] = 20,
                    ['plastic'] = 20,
                    ['scrapmetal'] = 20,
                },
                ['car_armor_c'] = {
                    ['copper'] = 40,
                    ['steel'] = 40,
                    ['plastic'] = 40,
                    ['scrapmetal'] = 40,
                },
                ['car_armor_b'] = {
                    ['copper'] = 70,
                    ['steel'] = 70,
                    ['plastic'] = 70,
                    ['scrapmetal'] = 70,
                },
                ['car_armor_a'] = {
                    ['copper'] = 170,
                    ['steel'] = 170,
                    ['plastic'] = 170,
                    ['scrapmetal'] = 170,
                },
                ['car_armor_s'] = {
                    ['copper'] = 340,
                    ['steel'] = 340,
                    ['plastic'] = 340,
                    ['scrapmetal'] = 340,
                },
                ['engine4_d'] = {
                    ['copper'] = 24,
                    ['rubber'] = 24,
                    ['aluminum'] = 24,
                    ['scrapmetal'] = 24,
                },
                ['engine4_c'] = {
                    ['copper'] = 50,
                    ['rubber'] = 50,
                    ['aluminum'] = 50,
                    ['scrapmetal'] = 50,
                },
                ['engine4_b'] = {
                    ['copper'] = 90,
                    ['steel'] = 90,
                    ['aluminum'] = 90,
                    ['scrapmetal'] = 90,
                },
                ['engine4_a'] = {
                    ['copper'] = 190,
                    ['rubber'] = 190,
                    ['aluminum'] = 190,
                    ['scrapmetal'] = 190,
                },
                ['engine4_s'] = {
                    ['copper'] = 380,
                    ['rubber'] = 380,
                    ['aluminum'] = 380,
                    ['scrapmetal'] = 380,
                },
                ['transmission3_d'] = {
                    ['copper'] = 20,
                    ['steel'] = 20,
                    ['plastic'] = 20,
                    ['scrapmetal'] = 20,
                },
                ['transmission3_c'] = {
                    ['copper'] = 40,
                    ['steel'] = 40,
                    ['plastic'] = 40,
                    ['scrapmetal'] = 40,
                },
                ['transmission3_b'] = {
                    ['copper'] = 70,
                    ['steel'] = 70,
                    ['plastic'] = 70,
                    ['scrapmetal'] = 70,
                },
                ['transmission3_a'] = {
                    ['copper'] = 170,
                    ['steel'] = 170,
                    ['plastic'] = 170,
                    ['scrapmetal'] = 170,
                },
                ['transmission3_s'] = {
                    ['copper'] = 340,
                    ['steel'] = 340,
                    ['plastic'] = 340,
                    ['scrapmetal'] = 340,
                },
                ['brakes3_d'] = {
                    ['copper'] = 20,
                    ['steel'] = 20,
                    ['rubber'] = 20,
                    ['scrapmetal'] = 20,
                },
                ['brakes3_c'] = {
                    ['copper'] = 40,
                    ['steel'] = 40,
                    ['rubber'] = 40,
                    ['scrapmetal'] = 40,
                },
                ['brakes3_b'] = {
                    ['copper'] = 70,
                    ['steel'] = 70,
                    ['rubber'] = 70,
                    ['scrapmetal'] = 70,
                },
                ['brakes3_a'] = {
                    ['copper'] = 170,
                    ['steel'] = 170,
                    ['rubber'] = 170,
                    ['scrapmetal'] = 170,
                },
                ['brakes3_s'] = {
                    ['copper'] = 340,
                    ['steel'] = 340,
                    ['rubber'] = 340,
                    ['scrapmetal'] = 340,
                },
                ['suspension1'] = {
                    ['copper'] = 16,
                    ['rubber'] = 16,
                    ['aluminum'] = 16,
                    ['scrapmetal'] = 16,
                },
                ['suspension2'] = {
                    ['copper'] = 30,
                    ['rubber'] = 30,
                    ['aluminum'] = 30,
                    ['scrapmetal'] = 30,
                },
                ['suspension3'] = {
                    ['copper'] = 60,
                    ['rubber'] = 60,
                    ['aluminum'] = 60,
                    ['scrapmetal'] = 60,
                },
                ['suspension4'] = {
                    ['copper'] = 120,
                    ['rubber'] = 120,
                    ['aluminum'] = 120,
                    ['scrapmetal'] = 120,
                },
            }
        },
    },
    ['Repair'] = {
        ['pawnshop'] = {
            jobname = 'pawnshop',
            rank = 3,
            coords = vector3(150.07, -1711.43, 29.31),
            items = {
                ['lockpick'] = {
                    ['rubber'] = 5,
                    ['steel'] = 5,
                    ['plastic'] = 10,
                    ['aluminum'] = 5,
                },
                ['weapon_pistol50'] = {
                    ['rubber'] = 50,
                    ['steel'] = 50,
                    ['plastic'] = 50,
                    ['aluminum'] = 50,
                },
                ['safe_cracker'] = {
                    ['rubber'] = 20,
                    ['steel'] = 20,
                    ['plastic'] = 20,
                    ['aluminum'] = 20,
                },
                ['zatgpu'] = {
                    ['rubber'] = 15,
                    ['steel'] = 15,
                    ['plastic'] = 15,
                    ['aluminum'] = 15,
                },
                ['zatcpu'] = {
                    ['rubber'] = 15,
                    ['steel'] = 15,
                    ['plastic'] = 15,
                    ['aluminum'] = 15,
                },
                ['zatps'] = {
                    ['rubber'] = 15,
                    ['steel'] = 15,
                    ['plastic'] = 15,
                    ['aluminum'] = 15,
                },
                ['zatmb'] = {
                    ['rubber'] = 15,
                    ['steel'] = 15,
                    ['plastic'] = 15,
                    ['aluminum'] = 15,
                },
                ['zatmodem'] = {
                    ['rubber'] = 15,
                    ['steel'] = 15,
                    ['plastic'] = 15,
                    ['aluminum'] = 15,
                },
                ['weapon_heavypistol'] = {
                    ['rubber'] = 35,
                    ['steel'] = 35,
                    ['plastic'] = 35,
                    ['aluminum'] = 35,
                },
                ['weapon_pistol_mk2'] = {
                    ['rubber'] = 15,
                    ['steel'] = 15,
                    ['plastic'] = 15,
                    ['aluminum'] = 15,
                },
                ['weapon_vintagepistol'] = {
                    ['rubber'] = 15,
                    ['steel'] = 15,
                    ['plastic'] = 15,
                    ['aluminum'] = 15,
                },         
                ['weapon_snspistol_mk2'] = {
                    ['rubber'] = 15,
                    ['steel'] = 15,
                    ['plastic'] = 15,
                    ['aluminum'] = 15,
                },
                ['weapon_snspistol'] = {
                    ['rubber'] = 15,
                    ['steel'] = 15,
                    ['plastic'] = 15,
                    ['aluminum'] = 15,
                },
                ['weapon_pistol'] = {
                    ['rubber'] = 15,
                    ['steel'] = 15,
                    ['plastic'] = 15,
                    ['aluminum'] = 15,
                },
                ['weapon_microsmg'] = {
                    ['rubber'] = 50,
                    ['steel'] = 50,
                    ['plastic'] = 50,
                    ['aluminum'] = 50,
                },
                ['weapon_appistol'] = {
                    ['rubber'] = 50,
                    ['steel'] = 50,
                    ['plastic'] = 50,
                    ['aluminum'] = 50,
                },
                ['weapon_smg'] = {
                    ['rubber'] = 50,
                    ['steel'] = 50,
                    ['plastic'] = 50,
                    ['aluminum'] = 50,
                },
                ['weapon_smg_mk2'] = {
                    ['rubber'] = 50,
                    ['steel'] = 50,
                    ['plastic'] = 50,
                    ['aluminum'] = 50,
                },
                ['weapon_combatpdw'] = {
                    ['rubber'] = 50,
                    ['steel'] = 50,
                    ['plastic'] = 50,
                    ['aluminum'] = 50,
                },
                ['weapon_machinepistol'] = {
                    ['rubber'] = 50,
                    ['steel'] = 50,
                    ['plastic'] = 50,
                    ['aluminum'] = 50,
                },
                ['weapon_minismg'] = {
                    ['rubber'] = 50,
                    ['steel'] = 50,
                    ['plastic'] = 50,
                    ['aluminum'] = 50,
                },
                ['weapon_carbinerifle'] = {
                    ['rubber'] = 50,
                    ['steel'] = 50,
                    ['plastic'] = 50,
                    ['aluminum'] = 50,
                },
                ['weapon_assaultrifle_mk2'] = {
                    ['rubber'] = 50,
                    ['steel'] = 50,
                    ['plastic'] = 50,
                    ['aluminum'] = 50,
                },
                ['weapon_assaultrifle'] = {
                    ['rubber'] = 50,
                    ['steel'] = 50,
                    ['plastic'] = 50,
                    ['aluminum'] = 50,
                },
                ['weapon_carbinerifle_mk2'] = {
                    ['rubber'] = 50,
                    ['steel'] = 50,
                    ['plastic'] = 50,
                    ['aluminum'] = 50,
                },
                ['weapon_compactrifle'] = {
                    ['rubber'] = 50,
                    ['steel'] = 50,
                    ['plastic'] = 50,
                    ['aluminum'] = 50,
                },
                ['weapon_tacticalrifle'] = {
                    ['rubber'] = 50,
                    ['steel'] = 50,
                    ['plastic'] = 50,
                    ['aluminum'] = 50,
                },
                ['weapon_doubleaction'] = {
                    ['rubber'] = 50,
                    ['steel'] = 50,
                    ['plastic'] = 50,
                    ['aluminum'] = 50,
                },
            }
        },
        ['police'] = {
            jobname = 'police',
            rank = 15,
            coords = vector3(466.34, -1000.67, 30.72),
            items = {
                ['weapon_carbinerifle'] = {
                    ['rubber'] = 15,
                    ['steel'] = 15,
                    ['plastic'] = 15,
                    ['aluminum'] = 15,
                },
            }
        },
    },
    ['Sell'] = {
        -- ['weed'] = {
        --     coords = vector3(-193.91770935059, -1704.7572021484, 33.484535217285),
        --     grade = 1,
        --     boss = 25,
        --     items = {
        --         ['full_weed_bag'] = 450
        --     }
        -- },
    },
    ['duty'] = {
        ['lsnews']=vector3(-594.10540771484, -928.65979003906, 23.77716255188)
    },
    ['Separate'] = {
        ['digitalden'] = {
            coords = vector3(209.92509460449, -1506.3227539062, 29.289503097534),
            grade =1,
            items = {
                ['television']      = {['electronics'] = math.random(5,25),['copper']=math.random(5,25),['glass']=math.random(5,25),['scrapmetal']=math.random(5,25)},
                ['dj_deck']         = {['electronics'] = math.random(5,25),['copper']=math.random(5,25),['glass']=math.random(5,25),['scrapmetal']=math.random(5,25)},
                ['console']         = {['electronics'] = math.random(5,25),['copper']=math.random(5,25),['glass']=math.random(5,25),['scrapmetal']=math.random(5,25)},
                ['boombox']         = {['electronics'] = math.random(5,25),['copper']=math.random(5,25),['glass']=math.random(5,25),['scrapmetal']=math.random(5,25)},
                ['flat_television'] = {['electronics'] = math.random(5,25),['copper']=math.random(5,25),['glass']=math.random(5,25),['scrapmetal']=math.random(5,25)},
                ['j_phone']         = {['electronics'] = math.random(5,25),['copper']=math.random(5,25),['glass']=math.random(5,25),['scrapmetal']=math.random(5,25)},
                ['monitor']         = {['electronics'] = math.random(5,25),['copper']=math.random(5,25),['glass']=math.random(5,25),['scrapmetal']=math.random(5,25)},
                ['printer']         = {['electronics'] = math.random(5,25),['copper']=math.random(5,25),['glass']=math.random(5,25),['scrapmetal']=math.random(5,25)},
                ['tapeplayer']      = {['electronics'] = math.random(5,25),['copper']=math.random(5,25),['glass']=math.random(5,25),['scrapmetal']=math.random(5,25)},
                ['laptoph']         = {['electronics'] = math.random(5,25),['copper']=math.random(5,25),['glass']=math.random(5,25),['scrapmetal']=math.random(5,25)},
            }
        },
 
        ['pawnshop'] = {
            coords = vector3(156.4, -1712.61, 29.31),
            grade =1,
            items = {
                ['shoebox'] = {['rubber'] = math.random(12,38),['plastic']=math.random(12,38),['aluminum'] = math.random(12,38),['steel']=math.random(12,38)},
                ['bong'] = {['rubber'] = math.random(12,38),['plastic']=math.random(12,38),['aluminum'] = math.random(12,38),['steel']=math.random(12,38)},
                ['pogo'] = {['rubber'] = math.random(12,38),['plastic']=math.random(12,38),['aluminum'] = math.random(12,38),['steel']=math.random(12,38)},
                ['coffemachine'] = {['rubber'] = math.random(12,38),['plastic']=math.random(12,38),['aluminum'] = math.random(12,38),['steel']=math.random(12,38)},
                ['hairdryer'] = {['rubber'] = math.random(12,38),['plastic']=math.random(12,38),['aluminum'] = math.random(12,38),['steel']=math.random(12,38)},
                ['sculpture'] = {['rubber'] = math.random(12,38),['plastic']=math.random(12,38),['aluminum'] = math.random(12,38),['steel']=math.random(12,38)},
                ['toiletry'] = {['rubber'] = math.random(12,38),['plastic']=math.random(12,38),['aluminum'] = math.random(12,38),['steel']=math.random(12,38)},
                ['toothpaste'] = {['rubber'] = math.random(12,38),['plastic']=math.random(12,38),['aluminum'] = math.random(12,38),['steel']=math.random(12,38)},
                ['soap'] = {['rubber'] = math.random(12,38),['plastic']=math.random(12,38),['aluminum'] = math.random(12,38),['steel']=math.random(12,38)},
                ['romantic_book'] = {['rubber'] = math.random(12,38),['plastic']=math.random(12,38),['aluminum'] = math.random(12,38),['steel']=math.random(12,38)},
                ['book'] = {['rubber'] = math.random(12,38),['plastic']=math.random(12,38),['aluminum'] = math.random(12,38),['steel']=math.random(12,38)},
                ['pencil'] = {['rubber'] = math.random(12,38),['plastic']=math.random(12,38),['aluminum'] = math.random(12,38),['steel']=math.random(12,38)},
                ['notepad'] = {['rubber'] = math.random(12,38),['plastic']=math.random(12,38),['aluminum'] = math.random(12,38),['steel']=math.random(12,38)},
                ['watch'] = {['rubber'] = math.random(12,38),['plastic']=math.random(12,38),['aluminum'] = math.random(12,38),['steel']=math.random(12,38)},
                ['necklace'] = {['rubber'] = math.random(12,38),['plastic']=math.random(12,38),['aluminum'] = math.random(12,38),['steel']=math.random(12,38)},
                ['gold_watch'] = {['rubber'] = math.random(12,38),['plastic']=math.random(12,38),['aluminum'] = math.random(12,38),['steel']=math.random(12,38)},
                ['gold_bracelet'] = {['rubber'] = math.random(12,38),['plastic']=math.random(12,38),['aluminum'] = math.random(12,38),['steel']=math.random(12,38)},
                ['bracelet'] = {['rubber'] = math.random(12,38),['plastic']=math.random(12,38),['aluminum'] = math.random(12,38),['steel']=math.random(12,38)},
                ['earings'] = {['rubber'] = math.random(12,38),['plastic']=math.random(12,38),['aluminum'] = math.random(12,38),['steel']=math.random(12,38)},
                ['skull'] = {['rubber'] = math.random(12,38),['plastic']=math.random(12,38),['aluminum'] = math.random(12,38),['steel']=math.random(12,38)},
            }
        },
 
        ['gallery'] = {
            coords = vector3(116.53, -140.09, 54.8),
            grade =1,
            items = {

            }
        },

        ['mechanicsh'] = {
            coords = vector3(-13.77, -1656.36, 29.5),
            grade =1,
            items = {
                ['engine0_d'] = {['recyclablematerial'] = math.random(5,18)},
                ['engine0_c'] = {['recyclablematerial'] = math.random(20,40)},
                ['engine0_b'] = {['recyclablematerial'] = math.random(45,70)},
                ['engine0_a'] = {['recyclablematerial'] = math.random(75,145)},
                ['engine0_s'] = {['recyclablematerial'] = math.random(250,300)},
                ['transmission0_d'] = {['recyclablematerial'] = math.random(5,18)},
                ['transmission0_c'] = {['recyclablematerial'] = math.random(20,40)},
                ['transmission0_b'] = {['recyclablematerial'] = math.random(45,70)},
                ['transmission0_a'] = {['recyclablematerial'] = math.random(75,145)},
                ['transmission0_s'] = {['recyclablematerial'] = math.random(200,280)},
                ['brakes0_d'] = {['recyclablematerial'] = math.random(5,18)},
                ['brakes0_c'] = {['recyclablematerial'] = math.random(20,40)},
                ['brakes0_b'] = {['recyclablematerial'] = math.random(45,70)},
                ['brakes0_a'] = {['recyclablematerial'] = math.random(75,145)},
                ['brakes0_s'] = {['recyclablematerial'] = math.random(200,280)},
                ['suspension0'] = {['recyclablematerial'] = math.random(40,80)},
            }
        },

        ['tuner'] = {
            coords = vector3(937.99, -1056.07, 40.97),
            grade =1,
            items = {
                ['engine0_d'] = {['recyclablematerial'] = math.random(5,18)},
                ['engine0_c'] = {['recyclablematerial'] = math.random(20,40)},
                ['engine0_b'] = {['recyclablematerial'] = math.random(45,70)},
                ['engine0_a'] = {['recyclablematerial'] = math.random(75,145)},
                ['engine0_s'] = {['recyclablematerial'] = math.random(250,300)},
                ['transmission0_d'] = {['recyclablematerial'] = math.random(5,18)},
                ['transmission0_c'] = {['recyclablematerial'] = math.random(20,40)},
                ['transmission0_b'] = {['recyclablematerial'] = math.random(45,70)},
                ['transmission0_a'] = {['recyclablematerial'] = math.random(75,145)},
                ['transmission0_s'] = {['recyclablematerial'] = math.random(200,280)},
                ['brakes0_d'] = {['recyclablematerial'] = math.random(5,18)},
                ['brakes0_c'] = {['recyclablematerial'] = math.random(20,40)},
                ['brakes0_b'] = {['recyclablematerial'] = math.random(45,70)},
                ['brakes0_a'] = {['recyclablematerial'] = math.random(75,145)},
                ['brakes0_s'] = {['recyclablematerial'] = math.random(200,280)},
                ['suspension0'] = {['recyclablematerial'] = math.random(40,80)},
            }
        },
    },
    ['Clothes'] = {
        ['mechanicsh'] ={coord= vector3(7.9560432434082, -1666.2569580078, 29.491382598877),outfit=true,clothing=false},
        -- ['catcafe']={coord=vector3(-587.26, -1050.23, 22.34),outfit=true,},
        ['tuner']={coord=vector3(937.99, -1042.37, 40.97),outfit=true,},
        ['digitalden']={coord=vector3(208.95803833008, -1505.8342285156, 29.289503097534),outfit=true,},
        ['snrbuns']={coord= vector3(-500.89678955078, -699.5927734375, 34.117267608643),outfit=true,},
        ['cashexchange']={coord= vector3(136.03712463379, -1344.0280761719, 29.710422515869),outfit=true,},
        ['pawnshop']={coord= vector3(155.28953552246, -1711.5495605469, 29.310745239258),outfit=true,},
        ['lsnews']={coord= vector3(-599.80999755859, -917.16271972656, 28.936159133911),outfit=true,},
        ['yellowjack']={coord=vector3(1992.7283935547, 3047.4050292969, 50.501651763916),outfit=true,},
        ['snrpizza']={coord=vector3(-506.34085083008, -731.85821533203, 33.671646118164),outfit=true,},
        ['snrcoffee']={coord=vector3(-506.34085083008, -731.85821533203, 33.671646118164),outfit=true,},
        ['snrsushi']={coord=vector3(-506.34085083008, -731.85821533203, 33.671646118164),outfit=true,},
        ['snrsmoothie']={coord=vector3(-506.34085083008, -731.85821533203, 33.671646118164),outfit=true,},
    }
}

Config.Gang = {
    ['Stash'] = {
       
    },
    
    ['Clothes'] = {
     
     
        --['gb'] = vector3(-1796.0523681641, 428.64367675781, 132.25944519043),
    },
}