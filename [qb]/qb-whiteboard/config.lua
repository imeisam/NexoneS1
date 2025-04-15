Config = {}

Config.Debug = false -- Debug Status For PolyZone
Config.DefaultBoardUrl = "https://cdn.discordapp.com/attachments/979775387896774661/982377179751018577/unknown.png" -- Don't Edit

Config.Locations = {
    ['snrsushi'] = { -- Name Of Room
    PolyZone = { -- Room Area For After Enter Show Image
        coords = vector3(-512.04, -695.6, 101.24),
        length = 100,
        width =50,
        heading=0,
        minZ = 31.64,
        maxZ =64.84,
    },
    Target = { -- Area for Show Target Options
        coords = vector3(-520.47, -714.32, 33.67),
        heading=27,
        length = 3.6,
        width = 0.5,
        minZ = 35.67,
        maxZ = 37.07,
    },
    -- Props For Replace Texture
    origTxd = '3dp_snrbuns_shops_editable_txd', -- Prop
    origTxn = 'banner06', -- Texture
    job = {['snrsushi']=0,['goverment']=4}, -- Job Name Or false
    currentImage = Config.DefaultBoardUrl, -- Don't Edit
    inZone = false, -- Don't Edit
    autosave=true
},
['snrpizza'] = { -- Name Of Room
PolyZone = { -- Room Area For After Enter Show Image
    coords = vector3(-512.04, -695.6, 101.24),
    length = 100,
    width =50,
    heading=0,
    minZ = 31.64,
    maxZ =64.84,
},
Target = { -- Area for Show Target Options
    coords = vector3(-517.42, -719.25, 33.67),
    heading=305,
    length = 3.6,
    width = 0.5,
    minZ = 35.67,
    maxZ = 37.07,
},
-- Props For Replace Texture
origTxd = '3dp_snrbuns_shops_editable_txd', -- Prop
origTxn = 'banner05', -- Texture
job = {['snrpizza']=0,['goverment']=4}, -- Job Name Or false
currentImage = Config.DefaultBoardUrl, -- Don't Edit
inZone = false, -- Don't Edit
autosave=true
},
['snrsmoothie'] = { -- Name Of Room
PolyZone = { -- Room Area For After Enter Show Image
    coords = vector3(-512.04, -695.6, 101.24),
    length = 100,
    width =50,
    heading=0,
    minZ = 31.64,
    maxZ =64.84,
},
Target = { -- Area for Show Target Options
    coords = vector3(-506.57, -706.46, 33.67),
    heading=0,
    length = 3.8,
    width = 0.5,
    minZ =35.57,
    maxZ =37.17,
},
-- Props For Replace Texture
origTxd = '3dp_snrbuns_shops_editable_txd', -- Prop
origTxn = 'banner01', -- Texture
job = {['snrsmoothie']=0,['goverment']=4}, -- Job Name Or false
currentImage = Config.DefaultBoardUrl, -- Don't Edit
inZone = false, -- Don't Edit
autosave=true
},
['clickloverslcd'] = { -- Name Of Room
PolyZone = { -- Room Area For After Enter Show Image
coords =vector3(215.94, -1512.53, 30.64),
length =20,
heading=45,
width =10,
minZ =27.44,
maxZ =36.84,
},
Target = { -- Area for Show Target Options
coords =vector3(212.86, -1507.72, 29.29),
length = 2.2,
heading=310,
width =1,
minZ =30.49,
maxZ =32.09,
},
-- Props For Replace Texture
origTxd = 'prop_tv_flat_01', -- Prop
origTxn = 'script_rt_tvscreen', -- Texture
job = {['digitalden']=0,['goverment']=4}, -- Job Name Or false
currentImage = Config.DefaultBoardUrl, -- Don't Edit
inZone = false, -- Don't Edit
autosave=true
},
['mechanicshlcd'] = { -- Name Of Room
PolyZone = { -- Room Area For After Enter Show Image
coords =vector3(-9.43, -1667.28, 30.73),
length =34.2,
heading=230,
width =30,
minZ =28.93,
maxZ =39.13,
},
Target = { -- Area for Show Target Options
coords =vector3(-20.38, -1658.81, 29.49),
length = 2.2,
heading=315,
width =2,
minZ =30.09,
maxZ =31.49,
},
-- Props For Replace Texture
origTxd = 'prop_tv_flat_01_screen', -- Prop
origTxn = 'script_rt_tvscreen', -- Texture
job = 'mechanicsh', -- Job Name Or false
currentImage = Config.DefaultBoardUrl, -- Don't Edit
inZone = false, -- Don't Edit
autosave=true
},
['mayorlcd'] = { -- Name Of Room
PolyZone = { -- Room Area For After Enter Show Image
coords =vector3(330.19, -1637.01, 54.59),
length =35,
heading=320,
width =20,
minZ =53.39,
maxZ =58.19,
},
Target = { -- Area for Show Target Options
coords =vector3(337.78, -1621.89, 54.59),
length = 1.0,
heading=50,
width =0.5,
minZ =55.99,
maxZ =56.79
},
-- Props For Replace Texture
origTxd = 'sf_prop_sf_tv_studio_01a', -- Prop
origTxn = 'prop_studio_scr_01a', -- Texture
job = {['goverment']=0}, -- Job Name Or false
currentImage = Config.DefaultBoardUrl, -- Don't Edit
inZone = false, -- Don't Edit
autosave=true
},
['tunerlcd'] = { -- Name Of Room
PolyZone = { -- Room Area For After Enter Show Image
coords =vector3(941.23, -1031.74, 86.73),
length =50,
heading=0,
width =50,
minZ =39.13,
maxZ =59.13,
},
Target = { -- Area for Show Target Options
coords =vector3(959.63, -1033.63, 40.97),
length = 0.5,
heading=5,
width =2,
minZ =41.57,
maxZ =42.57
},
-- Props For Replace Texture
origTxd = 'prop_tv_flat_01_screen', -- Prop
origTxn = 'script_rt_tvscreen', -- Texture
job = {['tuner']=0,['goverment']=4}, -- Job Name Or false
currentImage = Config.DefaultBoardUrl, -- Don't Edit
inZone = false, -- Don't Edit
autosave=true
},
['yellowjack'] = { -- Name Of Room
PolyZone = { -- Room Area For After Enter Show Image
coords = vector3(1987.45, 3050.19, 47.22), 
length = 17.8,
heading=60,
width =10.0,
minZ =45.0,
maxZ =91.18,
},
Target = { -- Area for Show Target Options
coords =vector3(1983.68, 3048.72, 47.22),
length =0.1,
heading=326,
width =1.0,
minZ =48.42,
maxZ =49.22,
},
-- Props For Replace Texture
origTxd = 'prop_tv_flat_02', -- Prop
origTxn = 'script_rt_tvscreen', -- Texture
job = {['yellowjack']=0,['goverment']=4}, -- Job Name Or false
currentImage = Config.DefaultBoardUrl, -- Don't Edit
inZone = false, -- Don't Edit
autosave=true
},

['medicserjury'] = { -- Name Of Room
PolyZone = { -- Room Area For After Enter Show Image
coords =vector3(326.95, -572.3, 43.27),
length =9.0,
heading=340,
width =7.0,
minZ =42.27,
maxZ =45.67,
},
Target = { -- Area for Show Target Options
coords =vector3(327.29, -574.1, 43.27),
length =1.3,
heading=290,
width =0.5,
minZ =43.92,
maxZ =45.12
},
-- Props For Replace Texture
origTxd = 'xm_prop_x17_tv_flat_01', -- Prop
origTxn = 'script_rt_tv_flat_01', -- Texture
job = {['ambulance']=0,['goverment']=4}, -- Job Name Or false
currentImage = Config.DefaultBoardUrl, -- Don't Edit
inZone = false, -- Don't Edit
autosave=true
},
['medicmri'] = { -- Name Of Room
PolyZone = { -- Room Area For After Enter Show Image
coords =vector3(314.96, -569.01, 43.27),
length =16.4,
heading=70,
width =7.0,
minZ =42.27,
maxZ =45.87,
},
Target = { -- Area for Show Target Options
coords =vector3(316.61, -566.59, 43.27),
length =2.2,
heading=70,
width =0.25,
minZ =43.42,
maxZ =44.62
},
-- Props For Replace Texture
origTxd = 'prop_tv_flat_01_screen', -- Prop
origTxn = 'script_rt_tvscreen', -- Texture
job = {['ambulance']=0}, -- Job Name Or false
currentImage = Config.DefaultBoardUrl, -- Don't Edit
inZone = false, -- Don't Edit
autosave=true
},
['tequilala'] = { -- Name Of Room
PolyZone = { -- Room Area For After Enter Show Image
coords = vector3(-558.36, 285.8, 82.18),
length = 17.0,
heading=175,
width =20,
minZ =81.18,
maxZ =91.18,
},
Target = { -- Area for Show Target Options
coords =vector3(-560.31, 290.78, 82.18),
length =1.1,
heading=355,
width =0.5,
minZ =83.08,
maxZ =83.68
},
-- Props For Replace Texture
origTxd = 'prop_tv_flat_02', -- Prop
origTxn = 'script_rt_tvscreen', -- Texture
job = {['tequilala']=0,['goverment']=4}, -- Job Name Or false
currentImage = Config.DefaultBoardUrl, -- Don't Edit
inZone = false, -- Don't Edit
autosave=true
},
['exchange2'] = { -- Name Of Room
PolyZone = { -- Room Area For After Enter Show Image
coords = vector3(128.7, -1342.92, 44.26),
length = 28.0,
heading=140,
width =20,
minZ =28.26,
maxZ =41.26
},
Target = { -- Area for Show Target Options
coords =vector3(132.51, -1348.21, 29.71),
length = 0.5,
heading=350,
width =2,
minZ =30.71,
maxZ =31.71
},
-- Props For Replace Texture
origTxd = 'sf_prop_sf_tv_studio_01a', -- Prop
origTxn = 'prop_studio_scr_01a', -- Texture
job = {['goverment']=4}, -- Job Name Or false
currentImage ="https://nxone.ir/table/", -- Don't Edit
inZone = false, -- Don't Edit
autosave=true
},
['exchange1'] = { -- Name Of Room
PolyZone = { -- Room Area For After Enter Show Image
    coords = vector3(128.7, -1342.92, 44.26),
    length = 28.0,
    heading=140,
    width =20,
    minZ =28.26,
    maxZ =41.26
},
Target = { -- Area for Show Target Options
    coords = vector3(126.35, -1343.55, 29.71),
    heading=50,
    length = 1.2,
    width = 0.5,
    minZ =30.51,
    maxZ = 31.51
},
-- Props For Replace Texture
origTxd = '3dp_cash_exchange_txd', -- Prop
origTxn = 'exchange_screen', -- Texture
job = {['goverment']=4}, -- Job Name Or false
currentImage =Config.DefaultBoardUrl, -- Don't Edit
inZone = false, -- Don't Edit
autosave=true
},
    ['snrbuns'] = { -- Name Of Room
        PolyZone = { -- Room Area For After Enter Show Image
            coords = vector3(-512.04, -695.6, 101.24),
            length = 100,
            width =50,
            heading=0,
            minZ = 31.64,
            maxZ =64.84,
        },
        Target = { -- Area for Show Target Options
            coords = vector3(-505.15, -696.38, 33.67),
            heading=0,
            length = 1.3,
            width = 0.5,
            minZ =35.07,
            maxZ = 36.07,
        },
        -- Props For Replace Texture
        origTxd = '3dp_snrbuns_txd', -- Prop
        origTxn = '3dp_snrbuns_menu_screens_02', -- Texture
        job ={['snrbuns']=0,['goverment']=4}, -- Job Name Or false
        currentImage = Config.DefaultBoardUrl, -- Don't Edit
        inZone = false, -- Don't Edit
        autosave=true
    },
    ['snrcoffee'] = { -- Name Of Room
    PolyZone = { -- Room Area For After Enter Show Image
        coords = vector3(-512.04, -695.6, 101.24),
        length = 100,
        width =50,
        heading=0,
        minZ = 31.64,
        maxZ =64.84,
    },
    Target = { -- Area for Show Target Options
        coords = vector3(-522.77, -709.06, 33.67),
        heading=21,
        length = 3.6,
        width = 0.5,
        minZ = 35.57,
        maxZ =37.37,
    },
    -- Props For Replace Texture
    origTxd = '3dp_snrbuns_shops_editable_txd', -- Prop
    origTxn = 'banner07', -- Texture
    job ={['snrcoffee']=0,['goverment']=4}, -- Job Name Or false
    currentImage = Config.DefaultBoardUrl, -- Don't Edit
    inZone = false, -- Don't Edit
    autosave=true
},
}