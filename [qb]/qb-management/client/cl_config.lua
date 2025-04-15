Config = Config or {}

Config.BossMenuZones = {
    ['police'] = {
        { coords = vector3(609.755859375, 8.3210258483887, 92.410125732422), length = 1.5, width = 1.5, heading = 0.0, minZ = 33.9, maxZ = 35.9,pointdistance=3.0,interactDistance= 2.0 } ,
        { coords = vector3(-1088.8587646484, -839.47790527344, 31.058437347412), length = 1.5, width = 1.5, heading = 0.0, minZ = 30.0, maxZ = 32.0 ,pointdistance=3.0,interactDistance= 2.0} ,
        { coords = vector3(455.06, -989.82, 30.69), length = 1.5, width = 1.5, heading = 0.0, minZ = 30.0, maxZ = 32.0 ,pointdistance=3.0,interactDistance= 2.0} ,
        
    },
    ['ambulance'] = {
        { coords = vector3(329.57257080078, -602.03637695312, 43.267589569092), length = 1.2, width = 1.0, heading = 341.0, minZ = 31.4, maxZ = 33.4,pointdistance=1.0,interactDistance= 0.8 },
    },
    ['lsnews'] = {
        { coords = vector3(-593.09832763672, -917.53112792969, 29.73028755188), length = 1.2, width = 1.0, heading = 341.0, minZ = 31.4, maxZ = 33.4,pointdistance=1.0,interactDistance= 0.8 },
    },
    ['snrsmoothie'] = {
        { coords =  vector3(-504.24185180664, -703.69854736328, 34.211608886719), length = 1.2, width = 1.0, heading = 341.0, minZ = 31.4, maxZ = 33.4,pointdistance=1.0,interactDistance= 0.8 },
    },
   
    ['justice'] = {
        { coords = vector3(347.06695556641, -1630.7923583984, 38.500492095947), length = 1.15, width = 2.6, heading = 179.0, minZ = 37.5, maxZ = 39.5 ,pointdistance=3.0,interactDistance= 2.0},
        { coords = vector3(354.3486328125, -1594.5593261719, 29.294553756714), length = 1.15, width = 2.6, heading = 179.0, minZ = 37.5, maxZ = 39.5 ,pointdistance=3.0,interactDistance= 2.0},
    },
    ['lawyer'] = {
        { coords = vector3(321.13674926758, -1640.2468261719, 47.243827819824), length = 1.15, width = 2.6, heading = 179.0, minZ = 37.5, maxZ = 39.5 ,pointdistance=3.0,interactDistance= 2.0},
    },
    ['goverment'] = {
        { coords = vector3(341.17620849609, -1617.7807617188, 54.587512969971), length = 1.15, width = 2.6, heading = 249.0, minZ = 53.5, maxZ = 55.5,pointdistance=3.0,interactDistance= 2.0 },
    },
    ['cardealer'] = {
        { coords =vector3(-12.828544616699, -1648.5853271484, 29.311332702637), length = 0.9, width = 0.9, heading = 301.22, minZ =28.0, maxZ = 29.5 ,pointdistance=3.0,interactDistance= 2.0},
    },
   
    ['taxi'] = {
        { coords = vector3(907.0654296875, -150.34698486328, 74.168296813965), length = 0.9, width = 0.9, heading = 323.61, minZ = 73.1, maxZ = 75.1,pointdistance=3.0,interactDistance= 2.0 },
    },
    ['mechanicsh'] = {
        { coords =vector3(-12.423748970032, -1654.3760986328, 29.491380691528), length = 1.0, width = 1.2, heading = 301.8, minZ = 49.69, maxZ = 51.69 ,pointdistance=3.0,interactDistance= 2.0},
    },
    ['digitalden'] = {
        { coords =vector3(1135.32, -468.84, 66.49), length =0.5, width = 0.5, heading =45, minZ = 29.09, maxZ =29.69 ,pointdistance=3.0,interactDistance= 2.0},
        { coords = vector3(209.43182373047, -1510.6555175781, 29.289503097534), length =0.5, width = 0.5, heading =45, minZ = 29.09, maxZ =29.69 ,pointdistance=3.0,interactDistance= 2.0},
    },
    ['gallery'] = {
        { coords = vector3(120.94, -146.18, 54.8), length = 1.0, width = 1.0, heading = 301.8, minZ = 74.0, maxZ = 76.0 ,pointdistance=3.0,interactDistance= 2.0},
    },
    ['pawnshop'] = {
        { coords = vector3(151.53, -1713.1, 29.31), length = 1.0, width = 1.0, heading = 301.8, minZ = 74.0, maxZ = 76.0 ,pointdistance=3.0,interactDistance= 2.0},
    },
   ['catcafe'] = {
        { coords =vector3(-578.26, -1066.89, 26.61), length = 1.0, width = 1.0, heading = 301.8, minZ = 74.0, maxZ = 76.0 ,pointdistance=3.0,interactDistance= 2.0},
    },
    ['yoga'] = {
        { coords = vector3(1166.26, -445.23, 67.01), length = 1.0, width = 1.0, heading = 301.8, minZ = 74.0, maxZ = 76.0 ,pointdistance=3.0,interactDistance= 2.0},
    },
    ['snrbuns'] = {
        { coords = vector3(-505.22259521484, -700.60534667969, 33.671588897705), length = 1.5, width = 1.5, heading = 0, minZ =32.0, maxZ = 34.0,pointdistance=3.0,interactDistance= 2.0 },
    },
    ['cashexchange'] = {
        { coords = vector3(131.68026733398, -1341.8594970703, 29.710426330566), length = 1.5, width = 1.5, heading = 0, minZ =32.0, maxZ = 34.0,pointdistance=3.0,interactDistance= 2.0 },
    },
    ['snrsushi'] = {
        { coords = vector3(-522.23, -712.81, 34.0), length = 1.5, width = 1.5, heading = 0, minZ =32.0, maxZ = 34.0,pointdistance=3.0,interactDistance= 2.0 },
    },
    ['snrcoffee'] = {
        { coords = vector3(-525.15, -707.84, 33.25), length = 1.5, width = 1.5, heading = 0, minZ =32.0, maxZ = 34.0,pointdistance=3.0,interactDistance= 2.0 },
    },
    ['yellowjack'] = {
        { coords =vector3(1996.8359375, 3048.24609375, 47.692176818848), length = 1.5, width = 1.5, heading = 0, minZ =32.0, maxZ = 34.0,pointdistance=3.0,interactDistance= 2.0 },
    },
    ['snrpizza'] = {
        { coords =vector3(-521.20758056641, -718.47521972656, 34.151607513428), length = 1.5, width = 1.5, heading = 0, minZ =32.0, maxZ = 34.0,pointdistance=3.0,interactDistance= 2.0 },
    },
    ['tuner'] = {
        { coords = vector3(960.46, -1037.36, 46.24), length = 1.5, width = 1.5, heading = 0, minZ =32.0, maxZ = 34.0,pointdistance=3.0,interactDistance= 2.0 },
    },
    ['realestate'] = {
        { coords = vector3(-716.21, 261.22, 84.14), length = 1.5, width = 1.5, heading = 0, minZ =32.0, maxZ = 34.0,pointdistance=3.0,interactDistance= 2.0 },
    },
    ['tequilala'] = {
        { coords =vector3(-559.26263427734, 280.80084228516, 85.736457824707), length = 1.5, width = 1.5, heading = 0, minZ =32.0, maxZ = 34.0,pointdistance=3.0,interactDistance= 2.0 },
    },
    
}

Config.GangMenuZones = {
    -- ['hotel'] = {
    --     { coords = vector3(429.4665222168, 5.6850056648254, 91.93537902832), length = 1.0, width = 1.0, heading = 0.0, minZ = 90.935, maxZ = 92.935,pointdistance=3.0,interactDistance= 2.0 },
    -- },
}