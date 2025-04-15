Config = {}

Config.MicrophoneZones = {
    {
        name = "mrpd_training",
        effect=false,
        coords = vector3(432.95660400391, -997.00549316406, 30.839027404785),
        length = 1.5,
        width = 1.5,
        data = {
            debugPoly = false,
            heading = 272.2,
            minZ = 29.8,
            maxZ = 31.8,
            data = {
                range = 8.0
            }
          
        }
    },
    {
        name = "shahed",
        effect=false,
        coords =vector3(336.9, -1619.66, 47.45),
        length =2.2,
        width = 2.0,
        data = {
            debugPoly = false,
            heading = 50.0,
            minZ =44.85,
            maxZ =48.85,
            data = {
                range = 8.0
            }
           
        }
    },
    {--ok
        name = "poroce",
        effect=false,
        coords =vector3(329.02, -1621.71, 47.38),
        length = 4.2,
        width =2.0,
        data = {
            debugPoly = false,
            heading =320.0,
            minZ = 44.38,
            maxZ =48.38,
            data = {
                range = 8.0
            }
           
        }
    },
    {--ok
        name = "filix_curt",
        effect=false,
        coords =vector3(338.93, -1621.39, 47.69),
        length = 2.6,
        width = 2.0,
        data = {
            debugPoly = false,
            heading =230.0,
            minZ = 45.49,
            maxZ = 49.49,
            data = {
                range =12.0
            }
           
        }
    }, 
    {--ok
        name = "motaham1",
        effect=false,
        coords =vector3(337.52, -1630.01, 47.24),
        length = 4.2,
        width = 3.0,
        data = {
            debugPoly = false,
            heading =50.0,
            minZ =44.64,
            maxZ = 48.64,
            data = {
                range =8.0
            }
           
        }
    }, 
    {--ok
        name = "motaham2",
        effect=false,
        coords =vector3(331.91, -1625.12, 47.24),
        length = 4.2,
        width = 3.0,
        data = {
            debugPoly = false,
            heading =50.0,
            minZ =44.24,
            maxZ =48.24,
            data = {
                range =8.0
            }
           
        }
    }, 
     {--ok
     name = "shahed3",
     effect=false,
     coords =vector3(331.1, -1619.16, 47.24),
     length = 2.2,
     width = 2.0,
     data = {
         debugPoly = false,
         heading =320.0,
         minZ =44.24,
         maxZ =48.24,
         data = {
             range =8.0
         }
        
     }
 }, 
}

Config.EnableMegaphoneVehicles = {
    [GetHashKey('police')] = true,
    [GetHashKey('police3')] = true,
    [GetHashKey('polvstr')] = true,
    [GetHashKey('polcoquette')] = true,
    [GetHashKey('polpenumbra')] = true,
    [GetHashKey('polbuffalo4')] = true,
    [GetHashKey('polscout2')] = true,
    [GetHashKey('polcaracara')] = true,
    [GetHashKey('ambulance')] = true,
    [GetHashKey('rambulance')] = true,
    [GetHashKey('emsnspeedo')] = true,
    [GetHashKey('fbi2')] = true,
    [GetHashKey('nkbuffalos')] = true,
    [GetHashKey('rhinehart')] = true,
    [GetHashKey('slrr')] = true,
    [GetHashKey('nsandbrush6')] = true,
    [GetHashKey('nsandbrush4')] = true,
    [GetHashKey('bfdsuv')] = true,
}