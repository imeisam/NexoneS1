Config.Blips = {
    ["clothing"] = {
        Show = false,
        Sprite = 73,
        Color = 3,
        Scale = 0.7,
        Name = "Clothing Store",
    },
    ["barber"] = {
        Show = true,
        Sprite = 71,
        Color = 0,
        Scale = 0.7,
        Name = "Barber",
    },
    ["tattoo"] = {
        Show = true,
        Sprite = 75,
        Color = 1,
        Scale = 0.7,
        Name = "Tattoo Shop",
    },
    ["surgeon"] = {
        Show = true,
        Sprite = 102,
        Color = 4,
        Scale = 0.7,
        Name = "Plastic Surgeon",
    }
}

Config.Stores = {
    {
        type = "clothing",
        coords = vector4(1691.81, 4819.96, 42.06, 99.83),
        size = vector3(4, 4, 4),
        rotation = 45,
        showBlip = false, -- overrides the blip visibilty configured above for the group
        --targetModel = "s_m_m_doctor_01", -- overrides the target ped configured for the group
        --targetScenario = "" -- overrides the target scenario configure for the group
        usePoly = true, -- false => uses the size + rotation to create the zone | true => uses points to create the zone
        points = {
            vector3(1686.9018554688, 4829.8330078125, 42.07),
            vector3(1698.8566894531, 4831.4604492188, 42.07),
            vector3(1700.2448730469, 4817.7734375, 42.07),
            vector3(1688.3682861328, 4816.2954101562, 42.07)
        }
    },
    {
        type = "clothing",
        coords = vector4(-189.19, -1111.69, 23.34, 181.64),
        size = vector3(4, 4, 4),
        rotation = 111.41,
        usePoly = false,        
        showBlip = false, 
        points = {
            vector3(-199.77911376953, -1114.2086181641, 23.339195251465),
            vector3(-180.43634033203, -1114.5783691406, 23.339191436768),
            vector3(-180.3695526123, -1102.5764160156, 23.771181106567),
            vector3(-194.59059143066, -1094.4428710938, 24.43288230896),
        }
    },
    {
        type = "clothing",
        coords = vector4(-712.58, -155.55, 37.42, 127.86),
        size = vector3(4, 4, 4),
        rotation = 111.41,
        usePoly = false,        showBlip = false, 
        points = {
            vector3(-719.86212158203, -147.83151245117, 37.42),
            vector3(-709.10491943359, -141.53076171875, 37.42),
            vector3(-699.94342041016, -157.44494628906, 37.42),
            vector3(-710.68774414062, -163.64665222168, 37.42)
        }
    },
    {
        type = "clothing",
        coords = vector4(-1189.95, -769.87, 17.32, 126.51),
        size = vector3(4, 4, 4),
        rotation = 127.9,
        usePoly = false,        showBlip = false, 
        points = {
            vector3(-1206.9552001953, -775.06304931641, 17.32),
            vector3(-1190.6080322266, -764.03198242188, 17.32),
            vector3(-1184.5672607422, -772.16949462891, 17.32),
            vector3(-1199.24609375, -783.07928466797, 17.32)
        }
    },
    {
        type = "clothing",
        coords = vector4(422.9, -809.02, 29.49, 104.72),
        size = vector3(5, 5, 4),
        rotation = 0,
        usePoly = false,        showBlip = false, 
        points = {
            vector3(419.55020141602, -798.36547851562, 29.49),
            vector3(431.61773681641, -798.31909179688, 29.49),
            vector3(431.19784545898, -812.07122802734, 29.49),
            vector3(419.140625, -812.03594970703, 29.49)
        }
    },
    {
        type = "clothing",
        coords = vector4(-160.05, -303.1, 39.73, 249.7),
        size = vector3(4, 4, 4),
        rotation = 252.3,
        usePoly = false,        showBlip = false, 
        points = {
            vector3(-160.82145690918, -313.85919189453, 39.73),
            vector3(-172.56513977051, -309.82858276367, 39.73),
            vector3(-166.5775604248, -292.48077392578, 39.73),
            vector3(-154.84906005859, -296.51647949219, 39.73)
        }
    },
    {
        type = "clothing",
        coords = vector4(78.1, -1390.3, 29.38, 275.2),
        size = vector3(5, 5, 4),
        rotation = 272.0,
        usePoly = false,        showBlip = false, 
        points = {
            vector3(81.406135559082, -1400.7791748047, 29.38),
            vector3(69.335029602051, -1400.8251953125, 29.38),
            vector3(69.754981994629, -1387.078125, 29.38),
            vector3(81.500122070312, -1387.3002929688, 29.38)
        }
    },
    {
        type = "clothing",
        coords = vector4(-818.72, -1074.45, 11.33, 248.0),
        size = vector3(5, 5, 4),
        rotation = 207.0,
        usePoly = false,        showBlip = false, 
        points = {
            vector3(-826.26251220703, -1082.6293945312, 11.33),
            vector3(-832.27856445312, -1072.2819824219, 11.33),
            vector3(-820.16442871094, -1065.7727050781, 11.33),
            vector3(-814.08953857422, -1076.1878662109, 11.33)
        }
    },
    {
        type = "clothing",
        coords = vector4(-1453.84, -235.95, 49.8, 46.22),
        size = vector3(4, 4, 4),
        rotation = 45.7,
        usePoly = false,        showBlip = false, 
        points = {
            vector3(-1448.4829101562, -226.39401245117, 49.82),
            vector3(-1439.2475585938, -234.70428466797, 49.82),
            vector3(-1451.5389404297, -248.33193969727, 49.82),
            vector3(-1460.7554931641, -240.02815246582, 49.82)
        }
    },
    {
        type = "clothing",
        coords = vector4(0.79, 6512.43, 31.88, 47.57),
        size = vector3(5, 5, 4),
        rotation = 45,
        usePoly = false,        showBlip = false, 
        points = {
            vector3(6.4955291748047, 6522.205078125, 31.88),
            vector3(14.737417221069, 6513.3872070312, 31.88),
            vector3(4.3691010475159, 6504.3452148438, 31.88),
            vector3(-3.5187695026398, 6513.1538085938, 31.88)
        }
    },
    {
        type = "clothing",
        coords = vector4(617.53, 2765.22, 42.09, 185.89),
        size = vector3(4, 4, 4),
        rotation = 45,
        usePoly = false,        showBlip = false, 
        points = {
            vector3(612.58312988281, 2747.2814941406, 42.09),
            vector3(612.26214599609, 2767.0520019531, 42.09),
            vector3(622.37548828125, 2767.7614746094, 42.09),
            vector3(623.66833496094, 2749.5180664062, 42.09)
        }
    },
    {
        type = "clothing",
        coords = vector4(1199.55, 2707.48, 38.22, 195.33),
        size = vector3(5, 5, 4),
        rotation = 176.7,
        usePoly = false,        showBlip = false, 
        points = {
            vector3(1188.7923583984, 2704.2021484375, 38.22),
            vector3(1188.7498779297, 2716.2661132812, 38.22),
            vector3(1202.4979248047, 2715.8479003906, 38.22),
            vector3(1202.3558349609, 2703.9294433594, 38.22)
        }
    },
    {
        type = "clothing",
        coords = vector4(-3174.49, 1043.1, 20.86, 348.16),
        size = vector3(4, 4, 4),
        rotation = 45,
        usePoly = false,        showBlip = false, 
        points = {
            vector3(-3162.0075683594, 1056.7303466797, 20.86),
            vector3(-3170.8247070312, 1039.0412597656, 20.86),
            vector3(-3180.0979003906, 1043.1201171875, 20.86),
            vector3(-3172.7292480469, 1059.8623046875, 20.86)
        }
    },
    {
        type = "clothing",
        coords = vector4(-1097.46, 2710.3, 19.11, 240.46),
        size = vector3(4, 4, 4),
        rotation = 216.85,
        usePoly = false,        showBlip = false, 
        points = {
            vector3(-1103.3004150391, 2700.8195800781, 19.11),
            vector3(-1111.3771972656, 2709.884765625, 19.11),
            vector3(-1100.8548583984, 2718.638671875, 19.11),
            vector3(-1093.1976318359, 2709.7365722656, 19.11)
        }
    },
    {
        type = "clothing",
        coords = vector4(122.55, -223.81, 54.56, 345.38),
        size = vector3(4, 4, 4),
        rotation = 345.0,
        usePoly = false,        showBlip = false, 
        points = {
            vector3(133.60948181152, -210.31390380859, 54.56),
            vector3(125.8349609375, -228.48097229004, 54.56),
            vector3(116.3140335083, -225.02020263672, 54.56),
            vector3(122.56930541992, -207.83396911621, 54.56)
        }
    },
    {
    type = "clothing",
    coords = vector4(46.04, -819.68, 31.22, 69.73),
    size = vector3(4, 4, 4),
    rotation = 345.0,
    usePoly = false,    
    showBlip = false, 
    points = {
        vector3(53.24, -814.12, 31.22),
        vector3(48.27, -827.96, 31.81),
        vector3(38.99, -824.4, 31.72),
        vector3(43.62, -811.21, 31.22)
    }
},
{
    type = "clothing",
    coords = vector4(-653.59, -253.46, 36.23, 119.08),
    size = vector3(4, 4, 4),
    rotation = 345.0,
    usePoly = false,    
    showBlip = false, 
    points = {
        vector3(-652.42, -244.39, 36.23),
        vector3(-645.63, -257.19, 36.81),
        vector3(-654.56, -261.87, 36.73),
        vector3(-661.71, -249.38, 36.38)
    }
},
{
    type = "clothing",
    coords = vector4(1948.46, 3766.3, 32.6, 32.65),
    size = vector3(4, 4, 4),
    rotation = 345.0,
    usePoly = false,    
    showBlip = false, 
    points = {
        vector3(1944.16, 3768.0, 32.6),
        vector3(1955.13, 3774.39, 32.6),
        vector3(1960.24, 3765.33, 32.89),
        vector3(1947.91, 3761.98, 33.93)
    }
},
    {
        type = "barber",
        coords = vector4(-814.22, -183.7, 37.57, 116.91),
        size = vector3(4, 4, 4),
        rotation = 45,
        usePoly = false,        showBlip = false, 
        points = {
            vector3(-825.06127929688, -182.67497253418, 37.57),
            vector3(-808.82415771484, -179.19134521484, 37.57),
            vector3(-808.55261230469, -184.9720916748, 37.57),
            vector3(-819.77899169922, -191.81831359863, 37.57)
        }
    },
    {
        type = "barber",
        coords = vector4(136.78, -1708.4, 29.29, 144.19),
        size = vector3(4, 4, 4),
        rotation = 45,
        usePoly = false,        showBlip = false, 
        points = {
            vector3(132.57008361816, -1710.5053710938, 29.29),
            vector3(138.77899169922, -1702.6778564453, 29.29),
            vector3(142.73052978516, -1705.6853027344, 29.29),
            vector3(135.49719238281, -1712.9750976562, 29.29)
        }
    },
    {
        type = "barber",
        coords = vector4(-1282.57, -1116.84, 6.99, 89.25),
        size = vector3(4, 4, 4),
        rotation = 45,
        usePoly = false,        showBlip = false, 
        points = {
            vector3(-1287.4735107422, -1115.4364013672, 6.99),
            vector3(-1277.5638427734, -1115.1229248047, 6.99),
            vector3(-1277.2469482422, -1120.1147460938, 6.99),
            vector3(-1287.4561767578, -1119.2506103516, 6.99)
        }
    },
    {
        type = "barber",
        coords = vector4(1931.41, 3729.73, 32.84, 212.08),
        size = vector3(4, 4, 4),
        rotation = 45,
        usePoly = false,        showBlip = false, 
        points = {
            vector3(1932.4931640625, 3725.3374023438, 32.84),
            vector3(1927.2720947266, 3733.7663574219, 32.84),
            vector3(1931.4379882812, 3736.5327148438, 32.84),
            vector3(1936.0697021484, 3727.2839355469, 32.84)
        }
    },
    {
        type = "barber",
        coords = vector4(1212.8, -472.9, 65.2, 60.94),
        size = vector3(4, 4, 4),
        rotation = 45,
        usePoly = false,        showBlip = false, 
        points = {
            vector3(1208.3327636719, -469.84338378906, 65.2),
            vector3(1217.9066162109, -472.40216064453, 65.2),
            vector3(1216.9870605469, -477.00939941406, 65.2),
            vector3(1206.1077880859, -473.83499145508, 65.2)
        }
    },
    {
        type = "barber",
        coords = vector4(-32.9, -152.3, 56.1, 335.22),
        size = vector3(4, 4, 4),
        rotation = 45,
        usePoly = false,        showBlip = false, 
        points = {
            vector3(-29.730783462524, -148.67495727539, 56.1),
            vector3(-32.919719696045, -158.04254150391, 56.1),
            vector3(-37.612594604492, -156.62759399414, 56.1),
            vector3(-33.30192565918, -147.31649780273, 56.1)
        }
    },
    {
        type = "barber",
        coords = vector4(-278.1, 6228.5, 30.7, 49.32),
        size = vector3(4, 4, 4),
        rotation = 45,
        usePoly = false,        showBlip = false, 
        points = {
            vector3(-280.29818725586, 6232.7265625, 30.7),
            vector3(-273.06427001953, 6225.9692382812, 30.7),
            vector3(-276.25280761719, 6222.4013671875, 30.7),
            vector3(-282.98211669922, 6230.015625, 30.7)
        }
    },
    {
        type = "tattoo",
        coords = vector4(1322.6, -1651.9, 51.2, 42.47),
        size = vector3(4, 4, 4),
        rotation = 45,
        usePoly = false,        showBlip = false, 
        points = {
            vector3(1323.9360351562, -1649.2370605469, 51.2),
            vector3(1328.0186767578, -1654.3087158203, 51.2),
            vector3(1322.5780029297, -1657.7045898438, 51.2),
            vector3(1319.2043457031, -1653.0885009766, 51.2)
        }
    },
    {
        type = "tattoo",
        coords = vector4(-1154.01, -1425.31, 4.95, 23.21),
        size = vector3(4, 4, 4),
        rotation = 45,
        usePoly = false,        showBlip = false, 
        points = {
            vector3(-1152.7110595703, -1422.8382568359, 4.95),
            vector3(-1149.0043945312, -1428.1975097656, 4.95),
            vector3(-1154.6730957031, -1431.1898193359, 4.95),
            vector3(-1157.7064208984, -1426.3433837891, 4.95)
        }
    },
    {
        type = "tattoo",
        coords = vector4(322.62, 180.34, 103.59, 156.2),
        size = vector3(4, 4, 4),
        rotation = 45,
        usePoly = false,        showBlip = false, 
        points = {
            vector3(319.28741455078, 179.9383392334, 103.59),
            vector3(321.537109375, 186.04516601562, 103.59),
            vector3(327.24526977539, 183.12303161621, 103.59),
            vector3(325.01351928711, 177.8542175293, 103.59)
        }
    },
    {
        type = "tattoo",
        coords = vector4(-3169.52, 1074.86, 20.83, 253.29),
        size = vector3(4, 4, 4),
        rotation = 45,
        usePoly = false,        showBlip = false, 
        points = {
            vector3(-3169.5861816406, 1072.3740234375, 20.83),
            vector3(-3175.4802246094, 1075.0703125, 20.83),
            vector3(-3172.2041015625, 1080.5860595703, 20.83),
            vector3(-3167.076171875, 1078.0391845703, 20.83)
        }
    },
    {
        type = "tattoo",
        coords = vector4(1864.1, 3747.91, 33.03, 17.23),
        size = vector3(4, 4, 4),
        rotation = 45,
        usePoly = false,        showBlip = false, 
        points = {
            vector3(1860.2752685547, 3750.1608886719, 33.03),
            vector3(1866.390625, 3752.8081054688, 33.03),
            vector3(1868.6164550781, 3747.3562011719, 33.03),
            vector3(1863.65234375, 3744.5034179688, 33.03)
        }
    },
    {
        type = "tattoo",
        coords = vector4(-294.24, 6200.12, 31.49, 195.72),
        size = vector3(4, 4, 4),
        rotation = 45,
        usePoly = false,        showBlip = false, 
        points = {
            vector3(-289.42239379883, 6198.68359375, 31.49),
            vector3(-294.69515991211, 6194.5366210938, 31.49),
            vector3(-298.23013305664, 6199.2451171875, 31.49),
            vector3(-294.1501159668, 6203.2700195312, 31.49)
        }
    }
    -- {
    --     type = "surgeon",
    --     coords = vector4(298.78, -572.81, 43.26, 114.27),
    --     size = vector3(4, 4, 4),
    --     rotation = 45,
    --     usePoly = false,    --     showBlip = false, 
    --     points = {
    --         vector3(298.84417724609, -572.92205810547, 43.26),
    --         vector3(296.39556884766, -575.65942382812, 43.26),
    --         vector3(293.56317138672, -572.60675048828, 43.26),
    --         vector3(296.28656005859, -570.330078125, 43.26)
    --     }
    -- }
}