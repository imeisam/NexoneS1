Config = {}
QBCore = exports['qb-core']:GetCoreObject()
Config.Framework        = "qb" -- "qb"
Config.Inventory        = "qb" -- "ps", "qb", "ox", "qs"
Config.FrameworkPseudo  = 'qb-core'
Config.Target           = "qb" -- ox !!!!!!!!! IMPORTANT
Config.UseInteract      = false
Config.Img              = 'qb-inventory/html/images/'
Config.Tax = 0


-- just an example on how to use can interact.
-- as it is not possible to pass a function into json.
local function CanToggleSignIn()
    return true
end

Config.NPCs = {
    -- roofrunning
    -- {
    --     ped         = 'a_m_m_hillbilly_02',
    --     anim        = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
    --     coords      =  vector4(574.08, 133.01, 98.47, 249.26),
    --     job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
    --     gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
    --     groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
    --     firstname   = 'RUFIS',
    --     lastname    = 'MDRID',
    --     rep         = 0,
    --     mission     = 'Roof Running',
    --     text        = 'Hey there, always on the lookout for a side gig, huh? I have got this idea that is a bit out there, but trust me, it pays off. Imagine sneaking onto rooftops, nabbing those AC units, and turning them into a sweet wad of cash, quick and discreet. what do you say? Insterested in a profitable adventure ?',
    --     buttons     = {
    --         {
    --             text= 'I want to work',
    --             rep = 0,
    --             answer ='Ready for a day of hard work?',
    --             buttons={{
    --                     text = 'yes',
    --                     shop =false,
    --                     rep = 0,
    --                     action= {
    --                         isServer= false,
    --                         event= 'zat-roofrunning:client:StartWorking',
    --                         data= {}
    --                     },
    --                     canInteract = CanToggleSignIn(),
    --                 },
    --                 {
    --                     text = 'Leave Conversation',
    --                     shop =false,
    --                     rep = 0,
    --                     action= {
    --                         isServer= false,
    --                         event= 'zat-dialog:client:HideUi',
    --                         data= {}
    --                     },
    --                     canInteract = true
    --                 }
    --             },
    --             canInteract = true
    --         },
    --         {
    --             text = 'Abandon Mission',
    --             rep = 0,
    --             shop =false,
    --             action= {
    --                 isServer= false,
    --                 event= 'zat-roofrunning:client:StopWorking',
    --                 data= {}
    --             },
    --             canInteract = true
    --         },
    --         {
    --             text = 'Join/Create Group',
    --             rep = 0,
    --             shop =false,
    --             action= {
    --                 isServer= false,
    --                 event= 'zat-groups:client:OpenUi',
    --                 data= {}
    --             },
    --             canInteract = true
    --         },
    --         {
    --             text    = 'Open Shop',
    --             rep = 0,
    --             shop    = true,
    --             answer  = null,
    --             canInteract = true
    --         },
    --     },
    --     items={
    --         {
    --             name   = 'screwdriver',
    --             label  = QBCore.Shared.Items['paper'].label,
    --             image  = 'nui://'..Config.Img.. QBCore.Shared.Items['paper'].image,
    --             type   = 'Equipement',
    --             price  = 10,
    --             rep    = 0,
    --             amount = 0, -- keep it 0
    --             info   = {},
    --             canInteract = true
    --         },        
    --     }
    -- }, 
    -- -- garbage
    -- {
    --     ped         = 's_m_y_garbage',
    --     anim        = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
    --     coords      =  vector4(-322.08, -1539.33, 26.73, 272.88),
    --     job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
    --     gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
    --     groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
    --     firstname   = 'LEO',
    --     lastname    = 'EARTHWELL',
    --     rep         = 0,
    --     mission     = 'Garbage Job',
    --     text        = 'Nice To see you again, What can I do for you?',
    --     buttons     = {
    --         {
    --             text = 'Sign in/out',
    --             shop =false,
    --             rep = 0,
    --             action= {
    --                 isServer= false,
    --                 event= 'zat-garbagejob:client:ToggleSingin',
    --                 data= {}
    --             },
    --             canInteract = CanToggleSignIn(),
    --         },
    --         {
    --             text = 'Join/Create Group',
    --             shop =false,
    --             rep = 0,
    --             action= {
    --                 isServer= false,
    --                 event= 'zat-groups:client:OpenUi',
    --                 data= {}
    --             },
    --             canInteract = true
    --         },
    --         {
    --             text= 'I want to work',
    --             answer ='Ready for a day of hard work?',
    --             rep = 0,
    --             buttons={{
    --                     text = 'yes',
    --                     shop =false,
    --                     rep = 0,
    --                     action= {
    --                         isServer= false,
    --                         event= 'zat-garbagejob:client:StartWorking',
    --                         data= {}
    --                     },
    --                     canInteract = true
    --                 },
    --                 {
    --                     text = 'Leave Conversation',
    --                     shop =false,
    --                     rep = 0,
    --                     action= {
    --                         isServer= false,
    --                         event= 'zat-dialog:client:HideUi',
    --                         data= {}
    --                     },
    --                     canInteract = true
    --                 }
    --             },
    --             canInteract = true
    --         },
    --         {
    --             text = 'Work Clothes',
    --             shop =false,
    --             rep = 0,
    --             action= {
    --                 isServer= false,
    --                 event= 'zat-garbagejob:client:Clothes',
    --                 data= {}
    --             },
    --             canInteract = true
    --         },
            

    --     },
    --     items={}
    -- }, 
    ---- snr buns
    -- {
    --     ped         = 'csb_burgerdrug',
    --     anim        = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
    --     coords      =  vector4(-504.14, -697.66, 32.67, 291.65),
    --     job         = {["snrbuns"]=0}, -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
    --     gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
    --     groups      =  {["snrbuns"]=0}, -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
    --     firstname   = 'MITCH',
    --     lastname    = 'BUN',
    --     rep         = 0,
    --     mission     = 'Snr Bun Worker',
    --     text        = 'Hey there, I do not think we have crossed paths before. I am Mitch, and I am in charge of the Snr Buns. You thinking about joining our crew ?',
    --     buttons     = {
    --         -- {
    --         --     text = 'sign in/out',
    --         --     shop =false,
    --         --     rep = 0,
    --         --     action= {
    --         --         isServer= false,
    --         --         event= 'zat-snrbuns:client:Clothes',
    --         --         data= {}
    --         --     },
    --         --     canInteract = true
    --         -- },
    --         {
    --             text = 'Order on/off',
    --             shop =false,
    --             rep = 0,
    --             action= {
    --                 isServer= true,
    --                 event= 'zat-snrbuns:server:ToggleSingin',
    --                 data= 1
    --             },
    --             canInteract = CanToggleSignIn(),
    --         },
    --         {
    --             text = 'Leave Conversation',
    --             shop =false,
    --             rep = 0,
    --             action= {
    --                 isServer= false,
    --                 event= 'zat-dialog:client:HideUi',
    --                 data= {}
    --             },
    --             canInteract = true
    --         },
            

    --     },
    --     items={}
    -- }, 
    --------------robberycooldown NPC--------------
    {
        ped         = 'ig_g',
        anim        = 'WORLD_HUMAN_LEANING',
        coords      =  vector4(-44.7, -1387.92, 29.29, 272.88),
        job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
        gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
        groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
        firstname   = 'Liam',
        lastname    = 'Elijah',
        rep         = 0,
        mission     = 'Robbery',
        text        = 'Cooldown?',
        buttons     = {
            {
                 text = 'Check Cooldown',
                 shop =false,
                 rep = 0,
                action= {
                isServer= false,
                event= 'qb-cooldown:client:showlist',
                data= {},
                },
                canInteract = true,
            },
            {
                text = 'Open Shop',
                shop =true,
                rep = 0,
                answer  = null,
                canInteract =true,
              
            },
            {
             text = 'Leave Conversation',
             shop =false,
             rep = 0,
             action= {
                 isServer= false,
                 event= 'zat-dialog:client:HideUi',
                data= {}
             },
            canInteract = true
            },
    },   
    items={
        {
            name   = 'lockpick',
            label  = "Lockpick",
            image  = 'nui://'..Config.Img.. 'lockpick.png',
            type   = 'Equipement',
            price  = 700,
            rep    = 0,
            amount = 0, -- keep it 0
            info   = {},
        },          
    }
    },
     
    ----------change phone case
    {
        ped         = 'a_f_y_bevhills_01',
        anim        = 'WORLD_HUMAN_STAND_MOBILE',
        coords      =  vector4(215.79417419434, -1517.1336669922, 28.294563293457, 13.930436134338),
        job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
        gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
        groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
        firstname   = 'Ashly',
        lastname    = 'Fernandez',
        rep         = 0,
        mission     = 'Phone Case',
        text        = 'Do You Want To Change Your Phone Case?',
        buttons     = {
            {
                 text = 'Change Phone Case',
                 shop =false,
                 rep = 0,
                action= {
                isServer= false,
                event= 'qb-phone:client:changephoneprop',
                data= {},
                },
                canInteract = true,
            },
            {
                text = 'Change Greetingsong',
                shop =false,
                rep = 0,
               action= {
               isServer= false,
               event= 'qb-phone:client:changegreetingsong',
               data= {},
               },
               canInteract = true,
           },
           {
            text = 'Change PhoneRingtoon',
            shop =false,
            rep = 0,
           action= {
           isServer= false,
           event= 'qb-phone:client:changephoneringtoon',
           data= {},
           },
           canInteract = true,
       },
            {
             text = 'Leave Conversation',
             shop =false,
             rep = 0,
             action= {
                 isServer= false,
                 event= 'zat-dialog:client:HideUi',
                data= {}
             },
            canInteract = true
            },
    },   
    items={
    },
    },
    {
        ped         = 'a_f_y_bevhills_01',
        anim        = 'WORLD_HUMAN_STAND_MOBILE',
        coords      =  vector4(1129.91, -475.83, 65.49, 310.87),
        job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
        gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
        groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
        firstname   = 'Sophia',
        lastname    = 'Fernandez',
        rep         = 0,
        mission     = 'Phone Case',
        text        = 'Do You Want To Change Your Phone Case?',
        buttons     = {
            {
                 text = 'Change Phone Case',
                 shop =false,
                 rep = 0,
                action= {
                isServer= false,
                event= 'qb-phone:client:changephoneprop',
                data= {},
                },
                canInteract = true,
            },
            {
                text = 'Change Greetingsong',
                shop =false,
                rep = 0,
               action= {
               isServer= false,
               event= 'qb-phone:client:changegreetingsong',
               data= {},
               },
               canInteract = true,
           },
            {
             text = 'Leave Conversation',
             shop =false,
             rep = 0,
             action= {
                 isServer= false,
                 event= 'zat-dialog:client:HideUi',
                data= {}
             },
            canInteract = true
            },
    },   
    items={
    },
    },
    --------------choppawnitem NPC--------------
    {
        ped         = 'ig_djgeneric_01',
        anim        = 'WORLD_HUMAN_AA_SMOKE',
        coords      =  vector4(-700.41, -1142.98, 9.81, 39.31),
        job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
        gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
        groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
        firstname   = 'Mason',
        lastname    = 'James',
        rep         = 0,
        mission     = 'Pawnshop',
        text        = 'You want to trade?',
        buttons     = {
            {
                 text = 'Trade Component',
                 shop =false,
                 rep = 0,
                action= {
                isServer= false,
                event= 'sam-jewelryrun:client:tradeitem',
                data= {},
                },
                canInteract = true,
            },
            {
             text = 'Leave Conversation',
             shop =false,
             rep = 0,
             action= {
                 isServer= false,
                 event= 'zat-dialog:client:HideUi',
                data= {}
             },
            canInteract = true
            },
    },
        items={}
    },
    --------------choppawnmoney NPC--------------
          {
        ped         = 'ig_mp_agent14',
        anim        = 'WORLD_HUMAN_STAND_MOBILE',
        coords      =  vector4(481.29, -1554.61, 28.28, 324.36),
        job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
        gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
        groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
        firstname   = 'William',
        lastname    = 'Aiden',
        rep         = 0,
        mission     = 'Pawnshop',
        text        = 'Do you have anything for sell?',
        buttons     = {
            {
                 text = 'Sell Component',
                 shop =false,
                 rep = 0,
                action= {
                isServer= false,
                event= 'sam-jewelryrun:client:rolemoney',
                data= {},
                },
                canInteract = true,
            },
            {
             text = 'Leave Conversation',
             shop =false,
             rep = 0,
             action= {
                 isServer= false,
                 event= 'zat-dialog:client:HideUi',
                data= {}
             },
            canInteract = true
            },
    },
        items={}
    },
    
      --------------roof runing NPC--------------
      {
        ped         = 'csb_cletus',
        anim        = 'Standing',
        coords      =  vector4(574.33, 132.86, 98.47, 258.16),
        job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
        gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
        groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
        firstname   = 'David',
        lastname    = 'Logan',
        rep         = 0,
        mission     = 'RoofRuning',
        text        = 'Are you ready for some action?',
        buttons     = {
            {
                 text = 'Sign In',
                 shop =false,
                 rep = 0,
                action= {
                isServer= false,
                event= 'sam-Roofrunning:client:startrob',
                data= {},
                },
                canInteract = true,
            },
            {
                text = 'Open Shop',
                shop =true,
                rep = 0,
                answer  = null,
                canInteract =true,
              
            },
            {
             text = 'Leave Conversation',
             shop =false,
             rep = 0,
             action= {
                 isServer= false,
                 event= 'zat-dialog:client:HideUi',
                data= {}
             },
            canInteract = true
            },
    },   
        items={
            -- {
            --     name   = 'screwdriver',
            --     label  = "Screwdriver",
            --     image  = 'nui://'..Config.Img.. 'screwdriver.png',
            --     type   = 'Equipement',
            --     price  = 1000,
            --     rep    = 0,
            --     amount = 0, -- keep it 0
            --     info   = {},
            -- }, 
        }
    },
    --------------ammunationrobbery NPC--------------
       {
    ped         = 'u_m_m_streetart_01',
    anim        = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
    coords      =  vector4(215.85, -1861.92, 29.86, 52.77),
    job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
    gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
    groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
    firstname   = 'Liam',
    lastname    = 'Campbell',
    rep         = 0,
    mission     = 'Ammunation',
    text        = 'Are you ready for some action?',
    buttons     = {
        {
             text = 'Start Mission',
             shop =false,
             rep = 0,
            action= {
            isServer= false,
            event= 'sam-amrob:client:prestartrob',
            data= {},
            },
            canInteract = true,
        },
        {
         text = 'Leave Conversation',
         shop =false,
         rep = 0,
         action= {
             isServer= false,
             event= 'zat-dialog:client:HideUi',
            data= {}
         },
        canInteract = true
        },
},   
    items={}
},
   --------------Mecicraft NPC--------------
   {
    ped         = 'claude',
    anim        = 'Standing',
    coords      =  vector4(2588.3, 3167.82, 50.37, 317.57),
    job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
    gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
    groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction 
    firstname   = 'Claude',
    lastname    = 'Speed',
    rep         = 0,
    mission     = 'Crafting',
    text        = 'Need anything?',
    buttons     = {
        {
            text = 'Open Shop',
            shop =true,
            rep = 0,
            answer  = null,
            canInteract =true,
          
        },
        {
         text = 'Leave Conversation',
         shop =false,
         rep = 0,
         action= {
             isServer= false,
             event= 'zat-dialog:client:HideUi',
            data= {}
         },
        canInteract = true
        },
},   
    items={
        {
            name   = 'craftingtable',
            label  = "Crafting Table",
            image  = 'nui://'..Config.Img.. 'craftingtable.png',
            type   = 'Equipement',
            price  = 10000,
            rep    = 0,
            amount = 0, -- keep it 0
            info   = {},
        },
        {
            name   = 'lockpick',
            label  = "Lockpick",
            image  = 'nui://'..Config.Img.. 'lockpick.png',
            type   = 'Equipement',
            price  = 700,
            rep    = 0,
            amount = 0, -- keep it 0
            info   = {},
        },          
    }
},

    ---- Hospital
    {
        ped         = 's_m_m_doctor_01',
        anim        = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
        coords      =  vector4(310.63067626953, -585.53997802734, 42.267589569092, 67.513565063477),
        job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
        gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
        groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
        firstname   = 'NOLAN',
        lastname    = 'LIFELINE',
        rep         = 0,
        mission     = 'Medical',
        text        = 'Need anything?',
        buttons     = {
            {
                text = 'Open Shop',
                shop =true,
                rep = 0,
                answer  = null,
                canInteract =true,
              
            },
            {
             text = 'Leave Conversation',
             shop =false,
             rep = 0,
             action= {
                 isServer= false,
                 event= 'zat-dialog:client:HideUi',
                data= {}
             },
            canInteract = true
            },
    },   
        items={
            {
                name   = 'bandage',
                label  = "Bandage",
                image  = 'nui://'..Config.Img.. 'bandageg.png',
                type   = 'Equipement',
                price  = 8,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },        
        }
    },
    {
        ped         = 's_m_m_doctor_01',
        anim        = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
        coords      = vector4(357.02584838867, -586.95526123047, 27.847406387329, 67.841674804688),
        job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
        gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
        groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
        firstname   = 'NOLAN',
        lastname    = 'LIFELINE',
        rep         = 0,
        mission     = 'Medical',
        text        = 'Need anything?',
        buttons     = {
            {
                text = 'Open Shop',
                shop =true,
                rep = 0,
                answer  = null,
                canInteract =true,
              
            },
            {
             text = 'Leave Conversation',
             shop =false,
             rep = 0,
             action= {
                 isServer= false,
                 event= 'zat-dialog:client:HideUi',
                data= {}
             },
            canInteract = true
            },
    },   
        items={
            {
                name   = 'bandage',
                label  = "Bandage",
                image  = 'nui://'..Config.Img.. 'bandageg.png',
                type   = 'Equipement',
                price  = 8,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },        
        }
    },
    {
        ped         = 's_m_m_doctor_01',
        anim        = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
        coords      =  vector4(1827.97, 3671.82, 33.16, 209.49),
        job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
        gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
        groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
        firstname   = 'NOLAN',
        lastname    = 'LIFELINE',
        rep         = 0,
        mission     = 'Medical',
        text        = 'Need anything?',
        buttons     = {
            {
                text = 'Open Shop',
                shop =true,
                rep = 0,
                answer  = null,
                canInteract =true,
              
            },
            {
             text = 'Leave Conversation',
             shop =false,
             rep = 0,
             action= {
                 isServer= false,
                 event= 'zat-dialog:client:HideUi',
                data= {}
             },
            canInteract = true
            },
    },   
        items={
            {
                name   = 'bandage',
                label  = "Bandage",
                image  = 'nui://'..Config.Img.. 'bandageg.png',
                type   = 'Equipement',
                price  = 8,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },        
        }
    },
   
        ---- Hospitalarmory
        {
            ped         = 's_f_y_scrubs_01',
            anim        = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
            coords      =   vector4(326.95434570312, -589.94036865234, 42.267597198486, 157.95565795898),
            job         = "ambulance", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
            gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
            groups      = "ambulance", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
            firstname   = 'Sydney',
            lastname    = 'Sweet',
            rep         = 0,
            mission     = 'Medical',
            text        = 'Need anything?',
            buttons     = {
                {
                    text = 'Open Shop',
                    shop =true,
                    rep = 0,
                    answer  = null,
                    canInteract =true,
                  
                },
                {
                 text = 'Leave Conversation',
                 shop =false,
                 rep = 0,
                 action= {
                     isServer= false,
                   
                {
                    name   = 'emsbag',
                    label  = "Ems Bag",
                    image  = 'nui://'..Config.Img.. 'emsbag.png',
                    type   = 'Equipement',
                    price  = 1000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },   ent= 'zat-dialog:client:HideUi',
                    data= {}
                 },
                canInteract = true
                },
        },   
            items={
                {
                    name   = 'bandage',
                    label  = "Bandage",
                    image  = 'nui://'..Config.Img.. 'bandageg.png',
                    type   = 'Equipement',
                    price  = 0,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'medkit',
                    label  = "IFAK",
                    image  = 'nui://'..Config.Img.. 'medkit.png',
                    type   = 'Equipement',
                    price  = 0,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'splint',
                    label  = "Splint",
                    image  = 'nui://'..Config.Img.. 'splint.png',
                    type   = 'Equipement',
                    price  = 0,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },  
                {
                    name   = 'tourniquet',
                    label  = "Tourniquet",
                    image  = 'nui://'..Config.Img.. 'tourniquet.png',
                    type   = 'Equipement',
                    price  = 0,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'tweezers',
                    label  = "Tweezers",
                    image  = 'nui://'..Config.Img.. 'tweezers.png',
                    type   = 'Equipement',
                    price  = 0,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'wheelchair',
                    label  = "Wheelchair",
                    image  = 'nui://'..Config.Img.. 'wheelchair.png',
                    type   = 'Equipement',
                    price  = 0,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
            }
        },
        {
            ped         = 's_f_y_scrubs_01',
            anim        = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
            coords      =  vector4(1827.2, 3683.95, 33.16, 218.35),
            job         = "ambulance", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
            gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
            groups      = "ambulance", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
            firstname   = 'Sydney',
            lastname    = 'Sweet',
            rep         = 0,
            mission     = 'Medical',
            text        = 'Need anything?',
            buttons     = {
                {
                    text = 'Open Shop',
                    shop =true,
                    rep = 0,
                    answer  = null,
                    canInteract =true,
                  
                },
                {
                 text = 'Leave Conversation',
                 shop =false,
                 rep = 0,
                 action= {
                     isServer= false,
                     event= 'zat-dialog:client:HideUi',
                    data= {}
                 },
                canInteract = true
                },
        },   
            items={
                {
                    name   = 'bandage',
                    label  = "Bandage",
                    image  = 'nui://'..Config.Img.. 'bandageg.png',
                    type   = 'Equipement',
                    price  = 0,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'medkit',
                    label  = "IFAK",
                    image  = 'nui://'..Config.Img.. 'medkit.png',
                    type   = 'Equipement',
                    price  = 0,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'splint',
                    label  = "splint",
                    image  = 'nui://'..Config.Img.. 'splint.png',
                    type   = 'Equipement',
                    price  = 0,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },  
                {
                    name   = 'tourniquet',
                    label  = "tourniquet",
                    image  = 'nui://'..Config.Img.. 'tourniquet.png',
                    type   = 'Equipement',
                    price  = 0,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'tweezers',
                    label  = "tweezers",
                    image  = 'nui://'..Config.Img.. 'tweezers.png',
                    type   = 'Equipement',
                    price  = 0,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'wheelchair',
                    label  = "Wheelchair",
                    image  = 'nui://'..Config.Img.. 'wheelchair.png',
                    type   = 'Equipement',
                    price  = 0,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },          
            }
        },
     --------------PC NPC--------------
    {
        ped         = 'ig_lestercrest',
        anim        = 'Standing',
        coords      =  vector4(1272.12, -1712.13, 53.77, 296.84),
        job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
        gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
        groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
        firstname   = 'LESTER',
        lastname    = 'CREST',
        rep         = 0,
        mission     = 'Hacker',
        text        = 'Need anything?',
        buttons     = {
            {
                text = 'Open Shop',
                shop =true,
                rep = 0,
                answer  = null,
                canInteract =true,
              
            },
            {
             text = 'Leave Conversation',
             shop =false,
             rep = 0,
             action= {
                 isServer= false,
                 event= 'zat-dialog:client:HideUi',
                data= {}
             },
            canInteract = true
            },
    },   
        items={
            {
                name   = 'blueprint',
                label  = "Blueprint - CPU",
                image  = 'nui://'..Config.Img.. 'blueprint.png',
                type   = 'Blueprint',
                price  = 2000,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {
                    type   = 'LETNI5-13600',
                },
            },
            {
                name   = 'blueprint',
                label  = "Blueprint - GPU",
                image  = 'nui://'..Config.Img.. 'blueprint.png',
                type   = 'Blueprint',
                price  = 3000,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {
                    type   = 'XTG-980',
                },
            },
            {
                name   = 'blueprint',
                label  = "Blueprint - Motherboard",
                image  = 'nui://'..Config.Img.. 'blueprint.png',
                type   = 'Blueprint',
                price  = 2500,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {
                    type   = 'GORSUSA-Z970LI',
                },
            },
            {
                name   = 'blueprint',
                label  = "Blueprint - Power Supply",
                image  = 'nui://'..Config.Img.. 'blueprint.png',
                type   = 'Blueprint',
                price  = 1000,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {
                    type   = 'RIASROC-RM1200',
                },
            },
            {
                name   = 'zatmodem',
                label  = "VPN",
                image  = 'nui://'..Config.Img.. 'zatmodem.png',
                type   = 'Equipement',
                price  = 8000,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },            
        }
    },
   --------------Weed NPC--------------
    -- {
    --     ped         = 'a_m_m_socenlat_01',
    --     anim        = 'WORLD_HUMAN_LEANING',
    --     coords      =  vector4(2016.9, 4997.05, 39.97, 113.29),
    --     job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
    --     gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
    --     groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
    --     firstname   = 'Jesse',
    --     lastname    = 'Pinkman',
    --     rep         = 0,
    --     mission     = 'Farmer',
    --     text        = 'Need anything?',
    --     buttons     = {
    --         {
    --             text = 'Open Shop',
    --             shop =true,
    --             rep = 0,
    --             answer  = null,
    --             canInteract =true,
              
    --         },
    --         {
    --          text = 'Leave Conversation',
    --          shop =false,
    --          rep = 0,
    --          action= {
    --              isServer= false,
    --              event= 'zat-dialog:client:HideUi',
    --             data= {}
    --          },
    --         canInteract = true
    --         },
    -- },   
    --     items={
    --         {
    --             name   = 'zatweedseed',
    --             label  = "Weed Seed",
    --             image  = 'nui://'..Config.Img.. 'zatweedseed.png',
    --             type   = 'Tools',
    --             price  = 100,
    --             rep    = 0,
    --             amount = 0, -- keep it 0
    --             info   = {},
    --         },
    --         {
    --             name   = 'zatweednutrition',
    --             label  = "Fertilizer",
    --             image  = 'nui://'..Config.Img.. 'zatweednutrition.png',
    --             type   = 'Tools',
    --             price  = 30,
    --             rep    = 0,
    --             amount = 0, -- keep it 0
    --             info   = {},
    --         },
    --         {
    --             name   = 'zatplanter',
    --             label  = "Planter",
    --             image  = 'nui://'..Config.Img.. 'zatplanter.png',
    --             type   = 'Tools',
    --             price  = 1000,
    --             rep    = 0,
    --             amount = 0, -- keep it 0
    --             info   = {},
    --         },
    --         {
    --             name   = 'zatwaterbottleempty',
    --             label  = "Water Bottle",
    --             image  = 'nui://'..Config.Img.. 'zatwaterbottleempty.png',
    --             type   = 'Tools',
    --             price  = 20,
    --             rep    = 0,
    --             amount = 0, -- keep it 0
    --             info   = {},
    --         },
    --         {
    --             name   = 'zatwatersetup',
    --             label  = "Water Filtration",
    --             image  = 'nui://'..Config.Img.. 'zatwatersetup.png',
    --             type   = 'Tools',
    --             price  = 600,
    --             rep    = 0,
    --             amount = 0, -- keep it 0
    --             info   = {},
    --         },
    --         {
    --             name   = 'zatweedrackxs',
    --             label  = "Weed Rack (Small)",
    --             image  = 'nui://'..Config.Img.. 'zatweedrackxs.png',
    --             type   = 'Tools',
    --             price  = 400,
    --             rep    = 0,
    --             amount = 0, -- keep it 0
    --             info   = {},
    --         },
    --         {
    --             name   = 'blueprint',
    --             label  = "Weed Rack (Medium)",
    --             image  = 'nui://'..Config.Img.. 'blueprint.png',
    --             type   = 'Blueprint',
    --             price  = 3000,
    --             rep    = 0,
    --             amount = 0, -- keep it 0
    --             info   = {
    --                 type   = 'WeedRack',
    --             },
    --         },    
    --         {
    --             name   = 'zatfan01',
    --             label  = "Fan",
    --             image  = 'nui://'..Config.Img.. 'zatfan01.png',
    --             type   = 'Tools',
    --             price  = 250,
    --             rep    = 0,
    --             amount = 0, -- keep it 0
    --             info   = {},
    --         },
    --         {
    --             name   = 'zatresfan',
    --             label  = "Modern Fan",
    --             image  = 'nui://'..Config.Img.. 'zatresfan.png',
    --             type   = 'Tools',
    --             price  = 500,
    --             rep    = 0,
    --             amount = 0, -- keep it 0
    --             info   = {},
    --         },
    --         {
    --             name   = 'zatheater',
    --             label  = "Wall Heater",
    --             image  = 'nui://'..Config.Img.. 'zatheater.png',
    --             type   = 'Tools',
    --             price  = 300,
    --             rep    = 0,
    --             amount = 0, -- keep it 0
    --             info   = {},
    --         },
    --         {
    --             name   = 'zatpatioheater',
    --             label  = "Patio Heater",
    --             image  = 'nui://'..Config.Img.. 'zatpatioheater.png',
    --             type   = 'Tools',
    --             price  = 500,
    --             rep    = 0,
    --             amount = 0, -- keep it 0
    --             info   = {},
    --         },
    --         {
    --             name   = 'zatbluelight',
    --             label  = "Blue Light",
    --             image  = 'nui://'..Config.Img.. 'zatbluelight.png',
    --             type   = 'Tools',
    --             price  = 200,
    --             rep    = 0,
    --             amount = 0, -- keep it 0
    --             info   = {},
    --         }, 
    --         {
    --             name   = 'zatwalllight',
    --             label  = "Wall Light",
    --             image  = 'nui://'..Config.Img.. 'zatwalllight.png',
    --             type   = 'Tools',
    --             price  = 350,
    --             rep    = 0,
    --             amount = 0, -- keep it 0
    --             info   = {},
    --         },
    --         {
    --             name   = 'zatceilinglight',
    --             label  = "Ceiling Light",
    --             image  = 'nui://'..Config.Img.. 'zatceilinglight.png',
    --             type   = 'Tools',
    --             price  = 500,
    --             rep    = 0,
    --             amount = 0, -- keep it 0
    --             info   = {},
    --         },                
    --     }
    -- },
   
    --------------Lumberjack NPC--------------
        {
        ped         = 'a_m_m_hillbilly_01',
        anim        = 'Standing',
        coords      =  vector4(-580.32, 5368.73, 69.36, 343.47),
        job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
        gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
        groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
        firstname   = 'Oliver',
        lastname    = 'Grayson',
        rep         = 0,
        mission     = 'LumberJack',
        text        = 'Need anything?',
        buttons     = {
            {
            text = 'Sign In/Sign Out',
            shop =false,
            rep = 0,
            action= {
                isServer= false,
                event= 'jimlumberjack:client:singin',
                data= {}
                },
            canInteract = true
            },
            {
                text = 'Open Shop',
                shop =true,
                rep = 0,
                answer  = null,
                canInteract =true, 
            },
            {
             text = 'Leave Conversation',
             shop =false,
             rep = 0,
             action= {
                 isServer= false,
                 event= 'zat-dialog:client:HideUi',
                data= {}
             },
            canInteract = true
            },
    },   
        items={
            {
                name   = 'powersaw',
                label  = "Chainsaw",
                image  = 'nui://'..Config.Img.. 'powersaw.png',
                type   = 'Equipement',
                price  = 350,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },        
        }
    },
   --------------Deliveryjob NPC--------------
    {
        ped         = 's_m_m_postal_02',
        anim        = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
        coords      =  vector4(1185.37, -3257.39, 5.03, 0.0),
        job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
        gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
        groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
        firstname   = 'Robert',
        lastname    = 'Lewis',
        rep         = 0,
        mission     = 'Deliver Job',
        text        = 'Are You Ready for delivery job?',
        buttons     = {
            {
                text = 'Sign in/out',
                answer="You Are Now Sign In",
                shop =false,
                rep = 0,
                canInteract =true,
                action= {
                    isServer= false,
                    event= '0r-delivery:Client:ToggleDeliveryJobDuty',
                    data = 1 -- first job in snrbuns Config.Jobs --> Config.Jobs[1] in Snr buns Script
                },
            },
            {
                text = 'Open Tablet',
                shop =false,
                rep = 0,
                action= {
                    isServer= false,
                    event= '0r-delivery:Client:OpenTablet',
                    data= {}
                },
                canInteract = true
            },
            {
                text = 'Group Manager',
                shop =false,
                rep = 0,
                buttons={
                    {
                        text = 'Accept Invitation',
                        shop =false,
                        rep = 0,
                        action= {
                            isServer= false,
                            event= '0r-delivery:Client:AcceptInvitation',
                            data= {}
                        },
                        canInteract = true
                    }, 
                    {
                        text = 'Deny Invitation',
                        shop =false,
                        rep = 0,
                        action= {
                            isServer= false,
                            event= '0r-delivery:Client:DenyInvitation',
                            data= {}
                        },
                        canInteract = true
                    }, 
                    {
                        text = 'Block/UnBlock Invitation',
                        shop =false,
                        rep = 0,
                        action= {
                            isServer= false,
                            event= '0r-delivery:Client:BlockInvitations',
                            data= {}
                        },
                        canInteract = true
                    }, 
                    {
                        text = 'Leave CurrentTeam',
                        shop =false,
                        rep = 0,
                        action= {
                            isServer= false,
                            event= '0r-delivery:Client:LeaveCurrentTeam',
                            data= {}
                        },
                        canInteract = true
                    }, 
                    {
                        text = 'Leave Conversation',
                        shop =false,
                        rep = 0,
                        action= {
                            isServer= false,
                            event= 'zat-dialog:client:HideUi',
                            data= {}
                        },
                        canInteract = true
                    },
                },
                canInteract = true
            },
           
            {
                text = 'Leave Conversation',
                shop =false,
                rep = 0,
                action= {
                    isServer= false,
                    event= 'zat-dialog:client:HideUi',
                    data= {}
                },
                canInteract = true
            },
            

        },
        items={}
    }, 
   --------------TowTruck Job NPC--------------
    {
        ped         = 's_m_m_autoshop_02',
        anim        = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
        coords      =  vector4(-212.6882019043, -1398.2028808594, 30.259220123291, 334.07733154297),
        job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
        gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
        groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
        firstname   = 'Jack',
        lastname    = 'Bennett',
        rep         = 0,
        mission     = 'Tow Track Job',
        text        = 'Are You Ready for Tow Track job?',
        buttons     = {
            {
                text = 'Sign in/out',
                shop =false,
                rep = 0,
                action= {
                    isServer= false,
                    event= '0r-towtruck:client:togglejob',
                    data = 1 -- first job in snrbuns Config.Jobs --> Config.Jobs[1] in Snr buns Script
                },
                canInteract =true,
            },
            {
                text = 'Take a Job',
                shop =false,
                rep = 0,
                action= {
                    isServer= false,
                    event= '0r-towtruck:client:towtrack',
                    data= {}
                },
                canInteract = true
            },
            {
                text = 'Leave Conversation',
                shop =false,
                rep = 0,
                action= {
                    isServer= false,
                    event= 'zat-dialog:client:HideUi',
                    data= {}
                },
                canInteract = true
            },
            

        },
        items={}
    },
       --------------ChopChop NPC--------------
    {
        ped         = 'niko',
        anim        = 'WORLD_HUMAN_DRUG_DEALER',
        coords      =  vector4(961.71, -1826.52, 30.23, 264.79),
        job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
        gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
        groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
        firstname   = 'Niko',
        lastname    = 'Bellic',
        rep         = 0,
        mission     = 'Chop Shop',
        text        = 'Are You Ready for Chop Shop?',
        buttons     = {
            {
                text = 'I want to work',
                answer="You Are Now Sign In",
                shop =false,
                rep = 0,
                buttons={
                            {
                                text = 'Locate A Vehicle',
                                answer="",
                                shop =false,
                                rep = 0,
                                buttons={
                                    {
                                        text = 'Leave Conversation',
                                        shop =false,
                                        rep = 0,
                                        action= {
                                            isServer= false,
                                            event= 'orbit-chopshop:jobaccept',
                                            data= {}
                                        },
                                        canInteract = true
                                    },
                                },
                                canInteract = true
                            },
                            {
                                text = 'Leave Conversation',
                                shop =false,
                                rep = 0,
                                action= {
                                    isServer= false,
                                    event= 'zat-dialog:client:HideUi',
                                    data= {}
                                },
                                canInteract = true
                            },      
                        },
                        canInteract = true,
                  
            },
            {
                text = 'Open Shop',
                shop =true,
                rep = 0,
                answer  = null,
                canInteract =true,
              
            },
            {
                text = 'Leave Conversation',
                shop =false,
                rep = 0,
                action= {
                    isServer= false,
                    event= 'zat-dialog:client:HideUi',
                    data= {}
                },
                canInteract = true
            },
            
        },
        items={
            {
                name   = 'weapon_digiscanner',
                label  = "Key Frequency Radar",
                image  = 'nui://'..Config.Img.. 'weapon_digiscanner.png',
                type   = 'Equipement',
                price  = 1500,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },  
        }
    },
   --------------MoneyWash NPC--------------
    {
        ped         = 'cs_stretch',
        anim        = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
        coords      =   vector4(-1563.94, -440.29, 36.03, 137.85),
        job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
        gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
        groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
        firstname   = 'George',
        lastname    = 'Walker',
        rep         = 0,
        mission     = 'Drew Wash',
        text        = 'Are You Ready for Drew Wash?',
        buttons     = {
            {
                text = 'Sign in/out',
                answer="You Are Now Sign In",
                shop =false,
                rep = 0,
                buttons={
                    {
                        text = 'Start Delivery',
                        answer = 'I parked the vehicle in the back.You can take it from there.The guys we boost these from have added some security measures if you take too long,so be quick about it.',
                        shop =false,
                        rep = 0,
                        buttons={
                                    {
                                        text = 'Leave Conversation',
                                        shop =false,
                                        rep = 0,
                                        action= {
                                            isServer= false,
                                            event= 'sam-laundrymachine:client:prestartdelivery',
                                            data= {}
                                        },
                                        canInteract = true
                                    },  
                        },
                        canInteract = true
                    },
                },
                canInteract =true,
            },

            {
                text = 'Turn in Money Orders',
                shop =false,
                rep = 0,
                action= {
                    isServer= false,
                    event= 'sam-laundrymachine:client:turninmoney',
                    data= {}
                },
                canInteract = true
            },
            
            {
                text = 'Leave Conversation',
                shop =false,
                rep = 0,
                action= {
                    isServer= false,
                    event= 'zat-dialog:client:HideUi',
                    data= {}
                },
                canInteract = true
            },
            

        },
        items={}
    },
--------------------------------------police traning
    {
        ped         = 's_m_m_marine_01',
        anim        = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
        coords      =   vector4(-2003.78, 3150.89, 31.81, 323.53),
        job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
        gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
        groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
        firstname   = 'Kevin',
        lastname    = 'Antonov',
        rep         = 0,
        mission     = 'Police Traning',
        text        = 'Are You Ready for Fight?',
        buttons     = {
            {
                text = 'Start Training',
                answer="Select Difficulty",
                shop =false,
                rep = 0,
                buttons={
                    {
                        text = 'Start Easy',
                        answer = 'Now Go Die',
                        shop =false,
                        rep = 0,
                        buttons={
                                    {
                                        text = 'Leave Conversation',
                                        shop =false,
                                        rep = 0,
                                        action= {
                                            isServer= false,
                                            event= 'phoenix:startmission:easy',
                                            data= {}
                                        },
                                        canInteract = true
                                    },  
                        },
                        canInteract = true
                    },
                    {
                        text = 'Start Normal',
                        answer = 'Now Go Die',
                        shop =false,
                        rep = 0,
                        buttons={
                                    {
                                        text = 'Leave Conversation',
                                        shop =false,
                                        rep = 0,
                                        action= {
                                            isServer= false,
                                            event= 'phoenix:startmission:normal',
                                            data= {}
                                        },
                                        canInteract = true
                                    },  
                        },
                        canInteract = true
                    },
                    {
                        text = 'Start Hard',
                        answer = 'Now Go Die',
                        shop =false,
                        rep = 0,
                        buttons={
                                    {
                                        text = 'Leave Conversation',
                                        shop =false,
                                        rep = 0,
                                        action= {
                                            isServer= false,
                                            event= 'phoenix:startmission:hard',
                                            data= {}
                                        },
                                        canInteract = true
                                    },  
                        },
                        canInteract = true
                    },
                   
                },
                canInteract =true,
            },

            {
                text = 'Cancel the Traning',
                shop =false,
                rep = 0,
                action= {
                    isServer= false,
                    event= 'phoenix:stopmission',
                    data= {}
                },
                canInteract = true
            },
            
            {
                text = 'Leave Conversation',
                shop =false,
                rep = 0,
                action= {
                    isServer= false,
                    event= 'zat-dialog:client:HideUi',
                    data= {}
                },
                canInteract = true
            },
            

        },
        items={}
    },
      --------------Pawnshop NPC-------------- 
    
    {
        ped         = 'a_m_m_farmer_01',
        anim        = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
        coords      =  vector4(162.47, -1706.96, 28.45, 15.65),
        job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
        gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
        groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
        firstname   = 'Edward',
        lastname    = 'Harris',
        rep         = 0,
        mission     = 'Pawn shop',
        text        = 'Are You Ready for Pawn shop?',
        buttons     = {
            {
                text = 'Normal(Need 200)',
                shop =false,
                rep = 0,
                buttons={
                    {
                        text = 'Normal',
                        answer = 'Check the Map After Leave a Conversation...!',
                        shop =false,
                        rep = 0,
                        buttons={
                                    {
                                        text = 'Leave Conversation',
                                        shop =false,
                                        rep = 0,
                                        action= {
                                            isServer= false,
                                            event= 'sam-jewelryrun:server:normalprestart',
                                            data= {}
                                        },
                                        canInteract = true
                                    },  
                        },
                        canInteract = true
                    },
                },
                canInteract =true,
            },

            {
                text = 'High Risk(Need1000)',
                shop =false,
                rep = 0,
                buttons={
                    
                      {
                                        text = 'Leave Conversation',
                                        shop =false,
                                        rep = 0,
                                        action= {
                                            isServer= false,
                                            event= 'sam-jewelryrun:server:highriskprestart',
                                            data= {}
                                        },
                                        canInteract = true
                                    },  
                   
                },
                canInteract =true,
            },

            {
                text = 'Hot Run(Need1500)',
                shop =false,
                rep = 0,
                buttons={
                    
                      {
                                        text = 'Leave Conversation',
                                        shop =false,
                                        rep = 0,
                                        action= {
                                            isServer= false,
                                            event= 'sam-jewelryrun:server:horunprestart',
                                            data= {}
                                        },
                                        canInteract = true
                                    },  
                   
                },
                canInteract =true,
            },
            {
                text = 'Open Shop',
                shop =true,
                rep = 0,
                answer  = null,
                canInteract =true,
              
            },
            {
                text = 'Leave Conversation',
                shop =false,
                rep = 0,
                action= {
                    isServer= false,
                    event= 'zat-dialog:client:HideUi',
                    data= {}
                },
                canInteract = true
            },
            

        },
        items={
            {
                name   = 'trowel',
                label  = "Trowel",
                image  = 'nui://'..Config.Img.. 'trowel.png',
                type   = 'Equipement',
                price  = 700,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },    
            {
                name   = 'vehiclebattery',
                label  = "Vehicle Battery",
                image  = 'nui://'..Config.Img.. 'vehbatt.png',
                type   = 'Equipement',
                price  = 300,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            }, 
        }
    },

   --------------Hunting NPC--------------
    {
        ped         = "cs_hunter",
        anim        = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
        coords      =   vector4(-679.67, 5838.94, 16.33, 223.54),
        job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
        gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
        groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
        firstname   = 'Alexander',
        lastname    = 'Hunter',
        rep         = 0,
        mission     = 'Hunting mission',
        text        = 'Are You Ready for Hunting?',
        buttons     = {
            {
                text = 'Open Shop',
                shop =true,
                rep = 0,
                answer  = null,
                canInteract =true,
              
            },
            {
                text = 'Sell Goods',
                shop =false,
                rep = 0,
                action= {
                    isServer= false,
                    event= 'qb-hunting:client:sell',
                    data = 1 -- first job in snrbuns Config.Jobs --> Config.Jobs[1] in Snr buns Script
                },
                canInteract =true,
            },
            {
                text = 'Leave Conversation',
                shop =false,
                rep = 0,
                action= {
                    isServer= false,
                    event= 'zat-dialog:client:HideUi',
                    data= {}
                },
                canInteract = true
            },
            

        },
        items={
            {
                name   = 'huntingbait',
                label  = "Hunting Bait",
                image  = 'nui://'..Config.Img.. 'huntingbait.png',
                type   = 'Equipement',
                price  = 8,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },  
            {
                name   = 'huntingknife',
                label  = "Hunting Knife",
                image  = 'nui://'..Config.Img.. 'huntingknife.png',
                type   = 'Equipement',
                price  = 50,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },  
            {
                name   = 'snp_ammo',
                label  = "Sniper Ammo",
                image  = 'nui://'..Config.Img.. 'rifle_ammo.png',
                type   = 'Equipement',
                price  = 3,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },  
            {
                name   = 'weapon_sniperrifle',
                label  = "Sniper Rifle",
                image  = 'nui://'..Config.Img.. 'weapon_sniperrifle.png',
                type   = 'Equipement',
                price  = 150,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },
        }
    },
    --Meth and coke npc
    {
        ped         = 's_m_m_doctor_01',
        anim        = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
        coords      =  vector4(1153.1, -1579.85, 34.19, 294.38),
        job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
        gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
        groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
        firstname   = 'Alex',
        lastname    = 'LIFELINE',
        rep         = 0,
        mission     = 'Drug',
        text        = 'How did you find me?',
        buttons     = {
            {
                text = 'Open Shop',
                shop =true,
                rep = 0,
                answer  = null,
                canInteract =true,
              
            },
            {
             text = 'Leave Conversation',
             shop =false,
             rep = 0,
             action= {
                 isServer= false,
                 event= 'zat-dialog:client:HideUi',
                data= {}
             },
            canInteract = true
            },
    },   
        items={
            {
                name   = 'meth_amoniak',
                label  = "Amonian",
                image  = 'nui://'..Config.Img.. 'meth_amoniak.png',
                type   = 'Equipement',
                price  = 100,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },
            {
                name   = 'syringe',
                label  = "Syringe",
                image  = 'nui://'..Config.Img.. 'syringe.png',
                type   = 'Equipement',
                price  = 20,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            }, 
            {
                name   = 'meth_pipe',
                label  = "Meth Pipe",
                image  = 'nui://'..Config.Img.. 'meth_pipe.png',
                type   = 'Equipement',
                price  = 30,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },
            {
                name   = 'crack_pipe',
                label  = "Crack Pipe",
                image  = 'nui://'..Config.Img.. 'crack_pipe.png',
                type   = 'Equipement',
                price  = 30,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },            
        }
    },
    --MosleyJOb
    {
        ped         = 'ig_benny',
        anim        = 'WORLD_HUMAN_CLIPBOARD',
        coords      =  vector4(-37.38, -1677.39, 28.49, 140.3),
        job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
        gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
        groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
        firstname   = 'Ben',
        lastname    = 'Benny',
        rep         = 0,
        mission     = 'Mosley',
        text        = 'Ready to work?',
        buttons     = {
            {
                text = 'Sign in',
                shop =false,
                rep = 0,
                action= {
                    isServer= false,
                    event= 'kne-mj:SignIn',
                    data= 1
                },
                canInteract = CanToggleSignIn(),
            },
            {
                text = 'Sign Out',
                shop =false,
                rep = 0,
                action= {
                    isServer= false,
                    event= 'kne-mj:endJob',
                    data= {}
                },
                canInteract = true
            },
            {
                text = 'Sell Used Vehicle',
                shop =false,
                rep = 0,
                action= {
                    isServer= false,
                    event= 'qb-vehicleshop:client:sellusedcar',
                   data= {}
                },
               canInteract = true
               },
            {
                text = 'Open Shop',
                shop =true,
                rep = 0,
                answer  = null,
                canInteract =true,
              
            },
           
            {
             text = 'Leave Conversation',
             shop =false,
             rep = 0,
             action= {
                 isServer= false,
                 event= 'zat-dialog:client:HideUi',
                data= {}
             },
            canInteract = true
            },
    },   
        items={         
        }
    },
    {
        ped         = 'a_m_m_farmer_01',
        anim        = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
        coords      =  vector4(53.17, -1479.04, 28.28, 182.16),
        job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
        gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
        groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
        firstname   = 'Ramon',
        lastname    = 'Barnes',
        rep         = 0,
        mission     = 'Food',
        text        = 'Hi! How can I help you?',
        buttons     = {
            {
                text = 'Open Shop',
                shop =true,
                rep = 0,
                answer  = null,
                canInteract =true,
              
            },
            {
             text = 'Leave Conversation',
             shop =false,
             rep = 0,
             action= {
                 isServer= false,
                 event= 'zat-dialog:client:HideUi',
                data= {}
             },
            canInteract = true
            },
    },   
        items={
            {
                name   = 'protein',
                label  = "Protein",
                image  = 'nui://'..Config.Img.. 'protein.png',
                type   = 'Equipement',
                price  = 3,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },
            {
                name   = 'seasoning',
                label  = "Seasoning",
                image  = 'nui://'..Config.Img.. 'seasoning.png',
                type   = 'Equipement',
                price  = 3,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            }, 
            {
                name   = 'sugar',
                label  = "Sugar",
                image  = 'nui://'..Config.Img.. 'sugar.png',
                type   = 'Equipement',
                price  = 3,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },
            {
                name   = 'vegetables',
                label  = "Vegetables",
                image  = 'nui://'..Config.Img.. 'vegetables.png',
                type   = 'Equipement',
                price  = 3,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },
            {
                name   = 'grain',
                label  = "Grain",
                image  = 'nui://'..Config.Img.. 'grain.png',
                type   = 'Equipement',
                price  = 3,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },
            {
                name   = 'leavening',
                label  = "Leavening",
                image  = 'nui://'..Config.Img.. 'leavening.png',
                type   = 'Equipement',
                price  = 3,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },
            {
                name   = 'powder',
                label  = "Soda Powder",
                image  = 'nui://'..Config.Img.. 'powder.png',
                type   = 'Equipement',
                price  = 2,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },
            {
                name   = 'oil',
                label  = "Oil",
                image  = 'nui://'..Config.Img.. 'oil.png',
                type   = 'Equipement',
                price  = 3,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },
            {
                name   = 'dairy',
                label  = "Dairy",
                image  = 'nui://'..Config.Img.. 'dairy.png',
                type   = 'Equipement',
                price  = 3,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },
            {
                name   = 'strawberry',
                label  = "Strawberry",
                image  = 'nui://'..Config.Img.. 'strawberry.png',
                type   = 'Equipement',
                price  = 2,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },
            {
                name   = 'apples',
                label  = "Apples",
                image  = 'nui://'..Config.Img.. 'apples.png',
                type   = 'Equipement',
                price  = 2,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },  
            {
                name   = 'orange',
                label  = "Orange",
                image  = 'nui://'..Config.Img.. 'orange.png',
                type   = 'Equipement',
                price  = 2,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },
            {
                name   = 'lime',
                label  = "Lime",
                image  = 'nui://'..Config.Img.. 'lime.png',
                type   = 'Equipement',
                price  = 2,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },
            {
                name   = 'juice',
                label  = "Juice",
                image  = 'nui://'..Config.Img.. 'juice.png',
                type   = 'Equipement',
                price  = 2,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },  
            {
                name   = 'alcohol',
                label  = "Alcohol",
                image  = 'nui://'..Config.Img.. 'alchol.png',
                type   = 'Equipement',
                price  = 2,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },  
            
            {
                name   = 'foodcontainer',
                label  = "Food Box",
                image  = 'nui://'..Config.Img.. 'zatfoodcontainer.png',
                type   = 'Equipement',
                price  = 10,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
            },        
        }
    },
        --tuner
        {
            ped         = 'ig_benny',
            anim        = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
            coords      =  vector4(935.08898925781, -1037.9299316406, 39.977233886719, 281.14291381836),
            job         = "tuner", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
            gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
            groups      = "tuner", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
            firstname   = 'Zack',
            lastname    = 'Booker',
            rep         = 0,
            mission     = 'Tuner',
            text        = 'Need Anything?',
            buttons     = {
                {
                    text = 'Open Shop',
                    shop =true,
                    rep = 0,
                    answer  = null,
                    canInteract =true,
                  
                },
                {
                 text = 'Leave Conversation',
                 shop =false,
                 rep = 0,
                 action= {
                     isServer= false,
                     event= 'zat-dialog:client:HideUi',
                    data= {}
                 },
                canInteract = true
                },
        },   
            items={
                {
                    name   = 'turbo_d',
                    label  = "Turbo D",
                    image  = 'nui://'..Config.Img.. 'turbo.png',
                    type   = 'Equipement',
                    price  = 750,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'turbo_c',
                    label  = "Turbo C",
                    image  = 'nui://'..Config.Img.. 'turbo.png',
                    type   = 'Equipement',
                    price  = 1500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'turbo_b',
                    label  = "Turbo B",
                    image  = 'nui://'..Config.Img.. 'turbo.png',
                    type   = 'Equipement',
                    price  = 3000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'turbo_a',
                    label  = "Turbo A",
                    image  = 'nui://'..Config.Img.. 'turbo.png',
                    type   = 'Equipement',
                    price  = 6000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'turbo_s',
                    label  = "Turbo S",
                    image  = 'nui://'..Config.Img.. 'turbo.png',
                    type   = 'Equipement',
                    price  = 12000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'car_armor_d',
                    label  = "Vehicle Armor D",
                    image  = 'nui://'..Config.Img.. 'armour.png',
                    type   = 'Equipement',
                    price  = 1000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'car_armor_c',
                    label  = "Vehicle Armor C",
                    image  = 'nui://'..Config.Img.. 'armour.png',
                    type   = 'Equipement',
                    price  = 2000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },  
                {
                    name   = 'car_armor_b',
                    label  = "Vehicle Armor B",
                    image  = 'nui://'..Config.Img.. 'armour.png',
                    type   = 'Equipement',
                    price  = 3400,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },  
                {
                    name   = 'car_armor_a',
                    label  = "Vehicle Armor A",
                    image  = 'nui://'..Config.Img.. 'armour.png',
                    type   = 'Equipement',
                    price  = 8000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },  
                {
                    name   = 'car_armor_s',
                    label  = "Vehicle Armor S",
                    image  = 'nui://'..Config.Img.. 'armour.png',
                    type   = 'Equipement',
                    price  = 16000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'engine4_d',
                    label  = "Modded Engine D",
                    image  = 'nui://'..Config.Img.. 'mod_engine.png',
                    type   = 'Equipement',
                    price  = 1100,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'engine4_c',
                    label  = "Modded Engine C",
                    image  = 'nui://'..Config.Img.. 'mod_engine.png',
                    type   = 'Equipement',
                    price  = 2200,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'engine4_b',
                    label  = "Modded Engine B",
                    image  = 'nui://'..Config.Img.. 'mod_engine.png',
                    type   = 'Equipement',
                    price  = 4400,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'engine4_a',
                    label  = "Modded Engine A",
                    image  = 'nui://'..Config.Img.. 'mod_engine.png',
                    type   = 'Equipement',
                    price  = 8800,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'engine4_s',
                    label  = "Modded Engine S",
                    image  = 'nui://'..Config.Img.. 'mod_engine.png',
                    type   = 'Equipement',
                    price  = 18400,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'transmission3_d',
                    label  = "Modded Transmission D",
                    image  = 'nui://'..Config.Img.. 'mod_transmission.png',
                    type   = 'Equipement',
                    price  = 1000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'transmission3_c',
                    label  = "Modded Transmission C",
                    image  = 'nui://'..Config.Img.. 'mod_transmission.png',
                    type   = 'Equipement',
                    price  = 2000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                }, 
                {
                    name   = 'transmission3_b',
                    label  = "Modded Transmission B",
                    image  = 'nui://'..Config.Img.. 'mod_transmission.png',
                    type   = 'Equipement',
                    price  = 3400,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                }, 
                {
                    name   = 'transmission3_a',
                    label  = "Modded Transmission A",
                    image  = 'nui://'..Config.Img.. 'mod_transmission.png',
                    type   = 'Equipement',
                    price  = 8000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                }, 
                {
                    name   = 'transmission3_s',
                    label  = "Modded Transmission S",
                    image  = 'nui://'..Config.Img.. 'mod_transmission.png',
                    type   = 'Equipement',
                    price  = 16000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'brakes3_d',
                    label  = "Modded Brakes D",
                    image  = 'nui://'..Config.Img.. 'mod_brakes.png',
                    type   = 'Equipement',
                    price  = 1000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'brakes3_c',
                    label  = "Modded Brakes C",
                    image  = 'nui://'..Config.Img.. 'mod_brakes.png',
                    type   = 'Equipement',
                    price  = 2000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'brakes3_b',
                    label  = "Modded Brakes B",
                    image  = 'nui://'..Config.Img.. 'mod_brakes.png',
                    type   = 'Equipement',
                    price  = 3400,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'brakes3_a',
                    label  = "Modded Brakes A",
                    image  = 'nui://'..Config.Img.. 'mod_brakes.png',
                    type   = 'Equipement',
                    price  = 8000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'brakes3_s',
                    label  = "Modded Brakes S",
                    image  = 'nui://'..Config.Img.. 'mod_brakes.png',
                    type   = 'Equipement',
                    price  = 16000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'suspension1',
                    label  = "Modded Suspension 1",
                    image  = 'nui://'..Config.Img.. 'mod_suspension.png',
                    type   = 'Equipement',
                    price  = 750,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'suspension2',
                    label  = "Modded Suspension 2",
                    image  = 'nui://'..Config.Img.. 'mod_suspension.png',
                    type   = 'Equipement',
                    price  = 1500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'suspension3',
                    label  = "Modded Suspension 3",
                    image  = 'nui://'..Config.Img.. 'mod_suspension.png',
                    type   = 'Equipement',
                    price  = 3000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'suspension4',
                    label  = "Modded Suspension 4",
                    image  = 'nui://'..Config.Img.. 'mod_suspension.png',
                    type   = 'Equipement',
                    price  = 6000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'customplate',
                    label  = "Customized Plates",
                    image  = 'nui://'..Config.Img.. 'plate.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'hood',
                    label  = "Vehicle Hood",
                    image  = 'nui://'..Config.Img.. 'hood.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'roof',
                    label  = "Vehicle Roof",
                    image  = 'nui://'..Config.Img.. 'roof.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'spoiler',
                    label  = "Vehicle Spoiler",
                    image  = 'nui://'..Config.Img.. 'spoiler.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'bumper',
                    label  = "Vehicle Bumper",
                    image  = 'nui://'..Config.Img.. 'bumper.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'skirts',
                    label  = "Vehicle Skirts",
                    image  = 'nui://'..Config.Img.. 'skirts.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'exhaust',
                    label  = "Vehicle Exhaust",
                    image  = 'nui://'..Config.Img.. 'exhaust.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'seat',
                    label  = "Seat Cosmetics",
                    image  = 'nui://'..Config.Img.. 'seat.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'rims',
                    label  = "Custom Wheel Rims",
                    image  = 'nui://'..Config.Img.. 'rims.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'livery',
                    label  = "Livery Roll",
                    image  = 'nui://'..Config.Img.. 'livery.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'rollcage',
                    label  = "Roll Cage",
                    image  = 'nui://'..Config.Img.. 'rollcage.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'paintcan',
                    label  = "Vehicle Spray Can",
                    image  = 'nui://'..Config.Img.. 'spraycan.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'tires',
                    label  = "Drift Smoke Tires",
                    image  = 'nui://'..Config.Img.. 'tires.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'horn',
                    label  = "Custom Vehicle Horn",
                    image  = 'nui://'..Config.Img.. 'horn.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'internals',
                    label  = "Internal Cosmetics",
                    image  = 'nui://'..Config.Img.. 'internals.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'externals',
                    label  = "Exterior Cosmetics",
                    image  = 'nui://'..Config.Img.. 'mirror.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'tint_supplies',
                    label  = "Tint Supplies",
                    image  = 'nui://'..Config.Img.. 'tint_supplies.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                }, 
                {
                    name   = 'underglow_controller',
                    label  = "Neon Controller",
                    image  = 'nui://'..Config.Img.. 'underglow_controller.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                }, 
                {
                    name   = 'headlights',
                    label  = "Xenon Headlights",
                    image  = 'nui://'..Config.Img.. 'headlights.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'ducttape',
                    label  = "Duct Tape",
                    image  = 'nui://'..Config.Img.. 'bodyrepair.png',
                    type   = 'Equipement',
                    price  = 100,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                }, 
                {
                    name   = 'mechboard',
                    label  = "Mechanic Sheet",
                    image  = 'nui://'..Config.Img.. 'mechboard.png',
                    type   = 'Equipement',
                    price  = 100,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'cleaningkit',
                    label  = "Cleaning Kit",
                    image  = 'nui://'..Config.Img.. 'cleaningkit.png',
                    type   = 'Equipement',
                    price  = 50,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'enginerepairkitadv',
                    label  = "Advanced Engine RepairKit",
                    image  = 'nui://'..Config.Img.. 'enginerepairkitadv.png',
                    type   = 'Equipement',
                    price  = 50,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'enginerepairkit',
                    label  = "Engine RepairKit",
                    image  = 'nui://'..Config.Img.. 'enginerepairkit.png',
                    type   = 'Equipement',
                    price  = 50,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'bodyrepairkit',
                    label  = "Body RepairKit",
                    image  = 'nui://'..Config.Img.. 'bodyrepairkit.png',
                    type   = 'Equipement',
                    price  = 50,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'advancedrepairkit',
                    label  = "Advanced Repairkit",
                    image  = 'nui://'..Config.Img.. 'advancedkit.png',
                    type   = 'Equipement',
                    price  = 50,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },                     
            }
        },
        --mechanic
        {
            ped         = 'ig_benny',
            anim        = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
            coords = vector4(-10.01, -1653.66, 28.49, 146.55),
            job         = { ["mechanicsh"] = 2}, -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
            gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
            groups      = { ["mechanicsh"] = 2}, -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
            firstname   = 'Zack',
            lastname    = 'Booker',
            rep         = 0,
            mission     = 'Tuner',
            text        = 'Need Anything?',
            buttons     = {
                {
                    text = 'Open Shop',
                    shop =true,
                    rep = 0,
                    answer  = null,
                    canInteract =true,
                  
                },
                {
                 text = 'Leave Conversation',
                 shop =false,
                 rep = 0,
                 action= {
                     isServer= false,
                     event= 'zat-dialog:client:HideUi',
                    data= {}
                 },
                canInteract = true
                },
        },   
            items={
                {
                    name   = 'turbo_d',
                    label  = "Turbo D",
                    image  = 'nui://'..Config.Img.. 'turbo.png',
                    type   = 'Equipement',
                    price  = 750,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'turbo_c',
                    label  = "Turbo C",
                    image  = 'nui://'..Config.Img.. 'turbo.png',
                    type   = 'Equipement',
                    price  = 1500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'turbo_b',
                    label  = "Turbo B",
                    image  = 'nui://'..Config.Img.. 'turbo.png',
                    type   = 'Equipement',
                    price  = 3000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'turbo_a',
                    label  = "Turbo A",
                    image  = 'nui://'..Config.Img.. 'turbo.png',
                    type   = 'Equipement',
                    price  = 6000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'turbo_s',
                    label  = "Turbo S",
                    image  = 'nui://'..Config.Img.. 'turbo.png',
                    type   = 'Equipement',
                    price  = 12000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'car_armor_d',
                    label  = "Vehicle Armor D",
                    image  = 'nui://'..Config.Img.. 'armour.png',
                    type   = 'Equipement',
                    price  = 1000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'car_armor_c',
                    label  = "Vehicle Armor C",
                    image  = 'nui://'..Config.Img.. 'armour.png',
                    type   = 'Equipement',
                    price  = 2000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },  
                {
                    name   = 'car_armor_b',
                    label  = "Vehicle Armor B",
                    image  = 'nui://'..Config.Img.. 'armour.png',
                    type   = 'Equipement',
                    price  = 3400,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },  
                {
                    name   = 'car_armor_a',
                    label  = "Vehicle Armor A",
                    image  = 'nui://'..Config.Img.. 'armour.png',
                    type   = 'Equipement',
                    price  = 8000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },  
                {
                    name   = 'car_armor_s',
                    label  = "Vehicle Armor S",
                    image  = 'nui://'..Config.Img.. 'armour.png',
                    type   = 'Equipement',
                    price  = 16000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'engine4_d',
                    label  = "Modded Engine D",
                    image  = 'nui://'..Config.Img.. 'mod_engine.png',
                    type   = 'Equipement',
                    price  = 1100,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'engine4_c',
                    label  = "Modded Engine C",
                    image  = 'nui://'..Config.Img.. 'mod_engine.png',
                    type   = 'Equipement',
                    price  = 2200,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'engine4_b',
                    label  = "Modded Engine B",
                    image  = 'nui://'..Config.Img.. 'mod_engine.png',
                    type   = 'Equipement',
                    price  = 4400,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'engine4_a',
                    label  = "Modded Engine A",
                    image  = 'nui://'..Config.Img.. 'mod_engine.png',
                    type   = 'Equipement',
                    price  = 8800,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'engine4_s',
                    label  = "Modded Engine S",
                    image  = 'nui://'..Config.Img.. 'mod_engine.png',
                    type   = 'Equipement',
                    price  = 18400,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'transmission3_d',
                    label  = "Modded Transmission D",
                    image  = 'nui://'..Config.Img.. 'mod_transmission.png',
                    type   = 'Equipement',
                    price  = 1000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'transmission3_c',
                    label  = "Modded Transmission C",
                    image  = 'nui://'..Config.Img.. 'mod_transmission.png',
                    type   = 'Equipement',
                    price  = 2000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                }, 
                {
                    name   = 'transmission3_b',
                    label  = "Modded Transmission B",
                    image  = 'nui://'..Config.Img.. 'mod_transmission.png',
                    type   = 'Equipement',
                    price  = 3400,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                }, 
                {
                    name   = 'transmission3_a',
                    label  = "Modded Transmission A",
                    image  = 'nui://'..Config.Img.. 'mod_transmission.png',
                    type   = 'Equipement',
                    price  = 8000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                }, 
                {
                    name   = 'transmission3_s',
                    label  = "Modded Transmission S",
                    image  = 'nui://'..Config.Img.. 'mod_transmission.png',
                    type   = 'Equipement',
                    price  = 16000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'brakes3_d',
                    label  = "Modded Brakes D",
                    image  = 'nui://'..Config.Img.. 'mod_brakes.png',
                    type   = 'Equipement',
                    price  = 1000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'brakes3_c',
                    label  = "Modded Brakes C",
                    image  = 'nui://'..Config.Img.. 'mod_brakes.png',
                    type   = 'Equipement',
                    price  = 2000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'brakes3_b',
                    label  = "Modded Brakes B",
                    image  = 'nui://'..Config.Img.. 'mod_brakes.png',
                    type   = 'Equipement',
                    price  = 3400,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'brakes3_a',
                    label  = "Modded Brakes A",
                    image  = 'nui://'..Config.Img.. 'mod_brakes.png',
                    type   = 'Equipement',
                    price  = 8000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'brakes3_s',
                    label  = "Modded Brakes S",
                    image  = 'nui://'..Config.Img.. 'mod_brakes.png',
                    type   = 'Equipement',
                    price  = 16000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'suspension1',
                    label  = "Modded Suspension 1",
                    image  = 'nui://'..Config.Img.. 'mod_suspension.png',
                    type   = 'Equipement',
                    price  = 750,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'suspension2',
                    label  = "Modded Suspension 2",
                    image  = 'nui://'..Config.Img.. 'mod_suspension.png',
                    type   = 'Equipement',
                    price  = 1500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'suspension3',
                    label  = "Modded Suspension 3",
                    image  = 'nui://'..Config.Img.. 'mod_suspension.png',
                    type   = 'Equipement',
                    price  = 3000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'suspension4',
                    label  = "Modded Suspension 4",
                    image  = 'nui://'..Config.Img.. 'mod_suspension.png',
                    type   = 'Equipement',
                    price  = 6000,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'customplate',
                    label  = "Customized Plates",
                    image  = 'nui://'..Config.Img.. 'plate.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'hood',
                    label  = "Vehicle Hood",
                    image  = 'nui://'..Config.Img.. 'hood.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'roof',
                    label  = "Vehicle Roof",
                    image  = 'nui://'..Config.Img.. 'roof.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'spoiler',
                    label  = "Vehicle Spoiler",
                    image  = 'nui://'..Config.Img.. 'spoiler.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'bumper',
                    label  = "Vehicle Bumper",
                    image  = 'nui://'..Config.Img.. 'bumper.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'skirts',
                    label  = "Vehicle Skirts",
                    image  = 'nui://'..Config.Img.. 'skirts.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'exhaust',
                    label  = "Vehicle Exhaust",
                    image  = 'nui://'..Config.Img.. 'exhaust.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'seat',
                    label  = "Seat Cosmetics",
                    image  = 'nui://'..Config.Img.. 'seat.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'rims',
                    label  = "Custom Wheel Rims",
                    image  = 'nui://'..Config.Img.. 'rims.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'livery',
                    label  = "Livery Roll",
                    image  = 'nui://'..Config.Img.. 'livery.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'rollcage',
                    label  = "Roll Cage",
                    image  = 'nui://'..Config.Img.. 'rollcage.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'paintcan',
                    label  = "Vehicle Spray Can",
                    image  = 'nui://'..Config.Img.. 'spraycan.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'tires',
                    label  = "Drift Smoke Tires",
                    image  = 'nui://'..Config.Img.. 'tires.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'horn',
                    label  = "Custom Vehicle Horn",
                    image  = 'nui://'..Config.Img.. 'horn.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'internals',
                    label  = "Internal Cosmetics",
                    image  = 'nui://'..Config.Img.. 'internals.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'externals',
                    label  = "Exterior Cosmetics",
                    image  = 'nui://'..Config.Img.. 'mirror.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'tint_supplies',
                    label  = "Tint Supplies",
                    image  = 'nui://'..Config.Img.. 'tint_supplies.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                }, 
                {
                    name   = 'underglow_controller',
                    label  = "Neon Controller",
                    image  = 'nui://'..Config.Img.. 'underglow_controller.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                }, 
                {
                    name   = 'headlights',
                    label  = "Xenon Headlights",
                    image  = 'nui://'..Config.Img.. 'headlights.png',
                    type   = 'Equipement',
                    price  = 500,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'ducttape',
                    label  = "Duct Tape",
                    image  = 'nui://'..Config.Img.. 'bodyrepair.png',
                    type   = 'Equipement',
                    price  = 100,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                }, 
                {
                    name   = 'mechboard',
                    label  = "Mechanic Sheet",
                    image  = 'nui://'..Config.Img.. 'mechboard.png',
                    type   = 'Equipement',
                    price  = 100,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'cleaningkit',
                    label  = "Cleaning Kit",
                    image  = 'nui://'..Config.Img.. 'cleaningkit.png',
                    type   = 'Equipement',
                    price  = 50,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'enginerepairkitadv',
                    label  = "Advanced Engine RepairKit",
                    image  = 'nui://'..Config.Img.. 'enginerepairkitadv.png',
                    type   = 'Equipement',
                    price  = 50,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'enginerepairkit',
                    label  = "Engine RepairKit",
                    image  = 'nui://'..Config.Img.. 'enginerepairkit.png',
                    type   = 'Equipement',
                    price  = 50,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'bodyrepairkit',
                    label  = "Body RepairKit",
                    image  = 'nui://'..Config.Img.. 'bodyrepairkit.png',
                    type   = 'Equipement',
                    price  = 50,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },
                {
                    name   = 'advancedrepairkit',
                    label  = "Advanced Repairkit",
                    image  = 'nui://'..Config.Img.. 'advancedkit.png',
                    type   = 'Equipement',
                    price  = 50,
                    rep    = 0,
                    amount = 0, -- keep it 0
                    info   = {},
                },                     
            }
        },
    }

