Config = {}
Config.policestation=vector3(622.9580078125, -2.002828836441, 82.760055541992)

Config.Objects = {
    ["cone"] = {model = `bzzz_police_props_cone_red`, freeze = false},
    ["redcone"] = {model = `bzzz_police_props_cone_red_anim`, freeze = true},
    ["bluecone"] = {model = `bzzz_police_props_cone_blue_anim`, freeze = true},
    ["barrier"] = {model = `prop_barrier_work06a`, freeze = true},
    ["roadsign"] = {model = `bzzz_police_props_roadclosed_a`, freeze = true},
    ["screen"] = {model = `bzzz_police_props_screen_a`, freeze = true},
    ["tent"] = {model = `prop_gazebo_03`, freeze = true},
    ["light"] = {model = `prop_worklight_03b`, freeze = true},
    ["ascene"] = {model = `bzzz_police_props_number_a`, freeze = true},
    ["bscene"] = {model = `bzzz_police_props_number_b`, freeze = true},
    ["cscene"] = {model = `bzzz_police_props_number_c`, freeze = true},
    ["dscene"] = {model = `bzzz_police_props_number_d`, freeze = true},
    ["escene"] = {model = `bzzz_police_props_number_e`, freeze = true},
    ["light"] = {model = `prop_worklight_03b`, freeze = true},

}

Config.PoliceBoat = "predator"

Config.Locations = {
    ["duty"] = {
        vector3(615.0361328125, 3.7846066951752, 82.594589233398),
        vector3(450.4, -984.02, 30.57),
    },
    ["stash"] = {
        ['vespucci_stash'] = {shared = false, coords = vector3(566.67468261719, 6.3206205368042, 70.767227172852)},
        ['vespucci_food'] = {shared = true, coords = vector3(602.03112792969, -10.091226577759, 92.633285522461)},
        ['vespucci_swat'] = {shared = true, division = 'mp', coords = vector3(605.36462402344, 21.251180648804, 84.040985107422)},
        ['vespucci_prisoner_1'] = {shared = false, coords = vector3(-1076.2462158203, -819.21557617188, 3.6824123859406)},
        ['vespucci_prisoner_2'] = {shared = false, coords = vector3(-1076.7523193359, -814.87817382812, 3.6824128627777)},
        ['vespucci_prisoner_3'] = {shared = false, coords = vector3(-1074.5711669922, -813.10064697266, 3.6824154853821)},
    },
    ["clothes"] = {
        ['vespucci_man'] = {
            vector3(-1077.0343017578, -817.94250488281, 19.32622718811),
            vector3(-1076.9350585938, -821.06500244141, 19.32622718811),
            vector3(-1080.1931152344, -823.61218261719, 19.32622718811),
            vector3(-1073.9771728516, -821.96282958984, 19.32622718811),
            vector3(-1073.7169189453, -824.59387207031, 19.32622718811),
            vector3(-1077.1281738281, -827.45654296875, 19.32622718811),
            vector3(-1086.9455566406, -821.83013916016, 27.14720916748),
        },
        ['mrpd']={
            vector3(551.85955810547, 27.901411056519, 69.109451293945),
            vector3(476.41, -990.5, 30.69)
        }
    },
    ["fingerprint"] = {
        vector3(-1074.0494384766, -819.23968505859, 3.6824133396149),
        vector3(475.39120483398, -1002.5818481445, 26.386098861694),
    },
    ["badge"] = {
        vector3(602.96380615234, 13.423038482666, 83.603324890137),
        vector3(443.13, -975.24, 30.30),
    },
    ["evidence"] = {
        ['vespucci'] = vector4(-1099.345703125, -844.11975097656, 3.6824131011963, 37.960578918457),
        ['mrpd'] = vector4(567.19396972656, 7.7228031158447, 69.35717010498, 70.355545043945),
    },
    ["trashevidence"]={
        ['vespucci'] ={
            vector3(-1076.578125, -837.31579589844, 26.347232055664),
            vector3(-1076.5992431641, -822.14135742188, 26.347235870361),
            vector3(-1078.0606689453, -823.36022949219, 26.347235870361),
            vector3(-1096.5506591797, -836.45050048828, 3.6824150085449),
        },
        ['mrpd'] ={
            vector3(561.45782470703, 7.7433867454529, 69.198799133301),
        }

    },
    ["boat"] = {
        vector3(-285.545, 6620.511, -0.233),
        vector3(-797.604, -1498.50, -0.474),
        vector3(-3318.83, 955.7942, -0.369),
    },
    ["stations"] = {
        {label = "Police Department", color = 3, coords = vector3(622.9580078125, -2.002828836441, 82.760055541992)},
    },
    ["TrackPhone"] = {
        vector3(-1103.9342041016, -840.39306640625, 31.058441162109)
    },
}

Config.AmmoLabels = {
    ["AMMO_PISTOL"] = "9x19mm parabellum bullet",
    ["AMMO_SMG"] = "9x19mm parabellum bullet",
    ["AMMO_RIFLE"] = "7.62x39mm bullet",
    ["AMMO_MG"] = "7.92x57mm mauser bullet",
    ["AMMO_SHOTGUN"] = "12-gauge bullet",
    ["AMMO_SNIPER"] = "Large caliber bullet",
    ["AMMO_TASER"] = "Taser bullet",
    ["AMMO_LTL"] = "LtL bullet",
}