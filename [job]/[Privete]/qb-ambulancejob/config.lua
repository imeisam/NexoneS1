Config = {}

Config.MinimalDoctors =3 -- How many players with the ambulance job to prevent the hospital check-in system from being used
Config.WipeInventoryOnRespawn = true -- Enable or disable removing all the players items when they respawn at the hospital
Config.BillCost = 20 -- Price that players are charged for using the hospital check-in system
Config.DeathTime = 300 -- How long the timer is for players to bleed out completely and respawn at the hospital
Config.LastStandTime = 60 -- How long the timer is for players to last stand completely and respawn
Config.AIHealTimer = 12 -- How long it will take to be healed after checking in, in seconds

Config.Locations = { -- Edit the various interaction points for players or create new ones
    ["checking"] = {
        {type="davis",name='lsmdsuspect',coord=vector3(88.64, -413.11, 39.20),distance=3.0,interactDst=2.0},
        {type="davis",name='lsmdpublic',coord=vector3(310.49151611328, -583.56701660156, 43.167585754395),distance=3.0,interactDst=2.0},
        {type="sandy",name='sandypublic',coord= vector3(1832.47, 3672.15, 34.16),distance=4.0,interactDst=2.0},
    },

    ["duty"] = {
       {coord= vector3(89.02, -415.47, 39.75),type="davis",activeother={"sandy"}},
       { coord=vector3(1842.482421875, 3680.4655761719, 34.159999847412),type="sandy"},
    },
    ["armory"] = {
        vector3(379.46, -1411.92, 32.94),
        vector3(1836.87, 3693.31, 34.16),
        vector3(51.21, -387.77, 39.38),
    },
    ["stash"] = {
        vector3(319.91879272461, -587.79846191406, 43.267581939697),
        vector3(61.25, -389.22, 39.55),
    },
    ["clothes"] = {
        vector3(379.01867675781, -1407.7270507813, 32.936214447021),
        vector3(1835.0137939453, 3692.251953125, 34.159980773926),
        vector3(381.42, -1409.68, 32.94),
        vector3(58.83, -390.84, 39.38),--pillbox
    },
    ["dna"] = {
        vector3(108.89, -372.35, 39.50)
    },
    ["beds"] = {
        {coords = vector4(100.50501251221, -407.15930175781, 39.415382385254, 344.31826782227), taken = false,checkin='lsmdpublic'},
        {coords =vector4(105.83576965332, -403.06805419922, 39.440048217773, 71.470634460449),  taken = false,checkin='lsmdpublic'},
        {coords =vector4(104.12995147705, -409.32632446289, 40.54642868042, 343.4928894043), taken = false,checkin='lsmdpublic'},
        -- {coords = vector4(325.58514, -587.695, 44.124095, 339.3793),  taken = false,checkin='lsmdpublic'},
        -- {coords =  vector4(321.26086, -581.7551, 44.124092, 157.39794),  taken = false,checkin='lsmdpublic'},

        -- {coords = vector4(352.97, -579.65, 29.94, 161.1), taken = false,checkin='lsmdsuspect'},
        -- {coords =vector4(349.27, -578.74, 30.09, 161.48), taken = false,checkin='lsmdsuspect'},
        -- {coords =vector4(346.73, -595.56, 29.94, 336.62), taken = false,checkin='lsmdsuspect'},
        -- {coords =vector4(343.15, -594.69, 29.95, 341.53), taken = false,checkin='lsmdsuspect'},
        -- {coords = vector4(339.61, -593.08, 29.88, 337.29), taken = false,checkin='lsmdsuspect'},
        -- {coords = vector4(335.94, -591.77, 29.87, 336.35) , taken = false,checkin='lsmdsuspect'},

        -- {coords = vector4(1832.85, 3681.77, 33.88, 31.55), taken = false,checkin='sandypublic'},
        -- {coords = vector4(1830.35, 3680.17, 33.88, 30.7), taken = false,checkin='sandypublic'},
        -- {coords = vector4(1827.73, 3678.8, 33.88, 32.51), taken = false,checkin='sandypublic'},
        -- {coords = vector4(1824.93, 3676.97, 33.88, 32.33), taken = false,checkin='sandypublic'},
    },
    ["stations"] = {
        {label = "Medical Center",coords =vector3(64.55, -405.26, 40.95)},
        -- {label = "LS Medical", coords = vector4(346.82, -1401.47, 32.42, 51.31)},
        {label = "Sandy Medical", coords = vector4(1833.09, 3670.09, 34.16, 206.64)}
    },
    ["Stretcher"] = {
        {coords =vector3(311.91885375977, -1425.5974121094, 29.854829788208),spawn=vector4(309.5881652832, -1426.3833007812, 28.854829788208, 144.85096740723)},
        {coords =vector3(349.6203918457, -589.4453125, 28.847400665283),spawn=vector4(350.2282409668, -591.4638671875, 28.847400665283, 82.115791320801)},
    }
}

Config.custombed={
  {  interactcoord=vector3(382.43835449219, -1399.6811523438, 32.936233520508),
    coord=vector4(383.21594238281, -1400.1810302734, 34.0, 50.847183227539),},

    {  interactcoord=vector3(374.5458984375, -1406.3643798828, 32.826470947266),
    coord=vector4(374.40444946289, -1406.6007080078, 34.0, 320.00979614258),}
}
