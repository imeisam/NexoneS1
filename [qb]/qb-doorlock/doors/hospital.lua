

-- care unit created by behno
Config.DoorList['hospital-care unit'] = {
    doors = {
        {objName = -1026546088, objYaw = 50.0, objCoords = vec3(362.799011, -1391.432861, 33.087341)},
        {objName = -1026546088, objYaw = 230.0, objCoords = vec3(364.354950, -1389.736206, 33.087341)}
    },
    doorType = 'double',
    svgDistance = 2,
    cantUnlock = false,
    locked = true,
    interactDistance = 1,
    doorRate = 1.0,
    authorizedJobs = { ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4},
}

-- mri created by behno
Config.DoorList['hospital-mri'] = {
    doors = {
        {objName = -1026546088, objYaw = 230.00001525879, objCoords = vec3(369.639557, -1394.170044, 33.087830)},
        {objName = -1026546088, objYaw = 49.999973297119, objCoords = vec3(368.084351, -1395.869019, 33.087830)}
    },
    doorType = 'double',
    svgDistance = 2,
    cantUnlock = false,
    locked = true,
    interactDistance = 1,
    doorRate = 1.0,
    authorizedJobs = {  ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
}

-- staffarea created by behno
Config.DoorList['hospital-staffarea'] = {
    doors = {
        {objName = -1026546088, objYaw = 230.00001525879, objCoords = vec3(347.622711, -1419.992920, 32.580090)},
        {objName = -1026546088, objYaw = 49.999973297119, objCoords = vec3(346.067596, -1421.690186, 32.581440)}
    },
    doorType = 'double',
    svgDistance = 2,
    cantUnlock = false,
    locked = true,
    interactDistance = 1,
    doorRate = 1.0,
    authorizedJobs = {  ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
}

-- staffroom created by behno
Config.DoorList['hospital-staffroom'] = {
    doorType = 'door',
    objName = -1789670568,
    doorRate = 1.0,
    authorizedJobs = { ['ambulance'] = 0, ['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    fixText = true,
    svgDistance = 2,
    cantUnlock = false,
    hiddentext = false,
    interactDistance = 1,
    objCoords = vec3(351.810089, -1427.075195, 32.579567),
    locked = true,
}

-- exam created by behno
Config.DoorList['hospital-exam'] = {
    doorRate = 1.0,
    objCoords = vec3(354.986298, -1426.951050, 32.580978),
    hiddentext = false,
    fixText = true,
    cantUnlock = false,
    doorType = 'door',
    svgDistance = 2,
    objName = -1789670568,
    locked = true,
    authorizedJobs = {  ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    interactDistance = 1,
}

-- doktorofficeup created by Meisam
Config.DoorList['hospital-doktorofficeup'] = {
    authorizedJobs = {  ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4  },
    doorRate = 1.0,
    doorType = 'doublesliding',
    doors = {
        {objName = 133611380, objYaw = 319.99768066406, objCoords = vec3(356.913239, -1412.484009, 31.452030)},
        {objName = -572986567, objYaw = 139.98614501953, objCoords = vec3(359.158905, -1414.429565, 31.452030)}
    },
    cantUnlock = false,
    interactDistance = 3,
    svgDistance = 3,
    fixText = true,
    locked = true,
}

-- rightroom1 created by Meisam
Config.DoorList['hospital-rightroom1'] = {
    doorRate = 1.0,
    authorizedJobs = { ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4  },
    cantUnlock = false,
    doors = {
        {objName = -1026546088, objYaw = 139.99998474121, objCoords = vec3(346.311066, -1418.387817, 32.579758)},
        {objName = -1026546088, objYaw = 320.0, objCoords = vec3(344.548553, -1416.908813, 32.579758)}
    },
    doorType = 'double',
    svgDistance = 2,
    locked = false,
    interactDistance = 1,
}

-- leftdoorroom1 created by Meisam
Config.DoorList['hospital-leftdoorroom1'] = {
    doorRate = 1.0,
    authorizedJobs = { ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4  },
    cantUnlock = false,
    doors = {
        {objName = -1026546088, objYaw = 320.0, objCoords = vec3(364.351624, -1393.304565, 33.092930)},
        {objName = -1026546088, objYaw = 139.99998474121, objCoords = vec3(366.116852, -1394.780151, 33.097908)}
    },
    doorType = 'double',
    svgDistance = 2,
    locked = true,
    interactDistance = 1,
}

-- emergencyroom1 created by Meisam
Config.DoorList['hospital-emergencyroom1'] = {
    cantUnlock = false,
    hiddentext = false,
    svgDistance = 2,
    locked = true,
    objName = -1026546088,
    authorizedJobs = { ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    fixText = true,
    objCoords = vec3(341.838104, -1414.629761, 32.583118),
    interactDistance = 1,
    doorRate = 1.0,
    doorType = 'door',
}

-- emergencyroom2 created by Meisam
Config.DoorList['hospital-emergencyroom2'] = {
    cantUnlock = false,
    hiddentext = false,
    svgDistance = 2,
    locked = true,
    objName = -1026546088,
    authorizedJobs = { ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    fixText = true,
    objCoords = vec3(336.666107, -1410.302979, 32.583118),
    interactDistance = 1,
    doorRate = 1.0,
    doorType = 'door',
}

-- patentroom1 created by Meisam
Config.DoorList['hospital-patentroom1'] = {
    cantUnlock = false,
    hiddentext = false,
    svgDistance = 2,
    locked = true,
    objName = -1789670568,
    authorizedJobs = { ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    fixText = true,
    objCoords = vec3(338.649719, -1415.896851, 32.580479),
    interactDistance = 1,
    doorRate = 1.0,
    doorType = 'door',
}

-- patentroom2 created by Meisam
Config.DoorList['hospital-patentroom2'] = {
    cantUnlock = false,
    hiddentext = false,
    svgDistance = 2,
    locked = true,
    objName = -1789670568,
    authorizedJobs = {  ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    fixText = true,
    objCoords = vec3(336.281982, -1413.910767, 32.580479),
    interactDistance = 1,
    doorRate = 1.0,
    doorType = 'door',
}

-- icu1 created by Meisam
Config.DoorList['hospital-icu1'] = {
    hiddentext = false,
    doorType = 'sliding',
    objName = 916619038,
    fixText = true,
    svgDistance =3,
    locked = true,
    interactDistance = 2,
    cantUnlock = false,
    authorizedJobs = { ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    doorRate = 1.0,
    objCoords = vec3(361.646973, -1387.026001, 31.932413),
}

-- icu2 created by Meisam
Config.DoorList['hospital-icu2'] = {
    objName = 916619038,
    doorRate = 1.0,
    authorizedJobs = {['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4  },
    interactDistance = 2,
    doorType = 'sliding',
    svgDistance = 3,
    locked = true,
    hiddentext = false,
    cantUnlock = false,
    fixText = true,
    objCoords = vec3(357.806061, -1383.800659, 31.932331),
}

-- icu3 created by Meisam
Config.DoorList['hospital-icu3'] = {
    objName = 916619038,
    doorRate = 1.0,
    authorizedJobs = {['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    interactDistance = 2,
    doorType = 'sliding',
    svgDistance = 3,
    locked = true,
    hiddentext = false,
    cantUnlock = false,
    fixText = true,
    objCoords = vec3(354.786621, -1381.270508, 31.932413),
}

-- icu4 created by Meisam
Config.DoorList['hospital-icu4'] = {
    objName = 916619038,
    doorRate = 1.0,
    authorizedJobs = { ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    interactDistance = 3,
    doorType = 'sliding',
    svgDistance = 2,
    locked = true,
    hiddentext = false,
    cantUnlock = false,
    fixText = true,
    objCoords = vec3(351.783478, -1378.746338, 31.932413),
}

-- icu5 created by Meisam
Config.DoorList['hospital-icu5'] = {
    objName = 916619038,
    doorRate = 1.0,
    authorizedJobs = {['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    interactDistance = 2,
    doorType = 'sliding',
    svgDistance = 3,
    locked = true,
    hiddentext = false,
    cantUnlock = false,
    fixText = true,
    objCoords = vec3(349.628754, -1376.940918, 31.932413),
}

-- surgeryroom created by Meisam
Config.DoorList['hospital-surgeryroom'] = {
    interactDistance = 2,
    svgDistance = 3,
    cantUnlock = false,
    doorRate = 1.0,
    locked = true,
    authorizedJobs = { ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4},
    doors = {
        {objName = 916619038, objYaw = 320.02221679688, objCoords = vec3(375.402496, -1402.476807, 31.938389)},
        {objName = 916619038, objYaw = 139.99998474121, objCoords = vec3(377.032928, -1403.845337, 31.938389)}
    },
    doorType = 'doublesliding',
}

-- mirroom created by Meisam
Config.DoorList['hospital-mirroom'] = {
    cantUnlock = false,
    doorRate = 1.0,
    objName = -1488883917,
    doorType = 'door',
    hiddentext = false,
    svgDistance = 2,
    objCoords = vec3(377.101318, -1399.846436, 33.088150),
    locked = true,
    interactDistance = 1,
    fixText = true,
    authorizedJobs = { ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4},
}

-- clotheroom created by Meisam
Config.DoorList['hospital-clotheroom'] = {
    cantUnlock = false,
    doorRate = 1.0,
    objName = -1298168329,
    doorType = 'door',
    hiddentext = false,
    svgDistance = 2,
    objCoords = vec3(381.659210, -1407.841797, 33.090446),
    locked = true,
    interactDistance = 1,
    fixText = true,
    authorizedJobs = { ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4},
}

-- labartory created by Meisam
Config.DoorList['hospital-labartory'] = {
    cantUnlock = false,
    doorRate = 1.0,
    objName = -1488883917,
    doorType = 'door',
    hiddentext = false,
    svgDistance = 2,
    objCoords = vec3(385.962250, -1407.286011, 33.087547),
    locked = true,
    interactDistance = 1,
    fixText = true,
    authorizedJobs = { ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
}

-- emergencyroomain created by Meisam
Config.DoorList['hospital-emergencyroomain'] = {
    interactDistance = 1,
    svgDistance = 2,
    cantUnlock = false,
    doorRate = 1.0,
    locked = false,
    authorizedJobs = {  ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    doors = {
        {objName = -1026546088, objYaw = 230.00001525879, objCoords = vec3(335.085083, -1409.473389, 32.582222)},
        {objName = -1026546088, objYaw = 50.0, objCoords = vec3(333.611084, -1411.239624, 32.580799)}
    },
    doorType = 'double',
}

-- emergencyroom3 created by Meisam
Config.DoorList['hospital-emergencyroom3'] = {
    cantUnlock = false,
    doorRate = 1.0,
    objName = -1026546088,
    doorType = 'door',
    hiddentext = false,
    svgDistance = 2,
    objCoords = vec3(332.459412, -1413.169434, 32.581360),
    locked = true,
    interactDistance = 1,
    fixText = true,
    authorizedJobs = {  ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
}

-- emergencyroom4 created by Meisam
Config.DoorList['hospital-emergencyroom4'] = {
    cantUnlock = false,
    doorRate = 1.0,
    objName = -1026546088,
    doorType = 'door',
    hiddentext = false,
    svgDistance = 2,
    objCoords = vec3(328.128937, -1418.338623, 32.581360),
    locked = true,
    interactDistance = 1,
    fixText = true,
    authorizedJobs = {  ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4},
}

-- patentroom3 created by Meisam
Config.DoorList['hospital-patentroom3'] = {
    cantUnlock = false,
    doorRate = 1.0,
    objName = -1789670568,
    doorType = 'door',
    hiddentext = false,
    svgDistance = 2,
    objCoords = vec3(326.242554, -1423.209229, 32.579670),
    locked = true,
    interactDistance = 1,
    fixText = true,
    authorizedJobs = {  ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
}

-- emergencyroommain2 created by Meisam
Config.DoorList['hospital-emergencyroommain2'] = {
    doors = {
        {objName = -1026546088, objYaw = 230.00001525879, objCoords = vec3(321.983978, -1416.202393, 32.581409)},
        {objName = -1026546088, objYaw = 50.0, objCoords = vec3(320.511749, -1417.969849, 32.580940)}
    },
    doorType = 'double',
    authorizedJobs = {   ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4},
    cantUnlock = false,
    locked = false,
    doorRate = 1.0,
    svgDistance = 2,
    interactDistance = 1,
}

-- maindoordown created by Meisam
Config.DoorList['hospital-maindoordown'] = {
    doors = {
        {objName = 799767705, objYaw = 320.0, objCoords = vec3(307.253571, -1432.233154, 28.816029)},
        {objName = 799767705, objYaw = 139.99998474121, objCoords = vec3(308.885284, -1433.602295, 28.816029)}
    },
    doorType = 'doublesliding',
    authorizedJobs = {   ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4},
    cantUnlock = false,
    locked = false,
    doorRate = 1.0,
    svgDistance = 3,
    interactDistance = 2,
}

-- patentroom4 created by Meisam
Config.DoorList['hospital-patentroom4'] = {
    authorizedJobs = {  ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    cantUnlock = false,
    locked = true,
    doorRate = 1.0,
    interactDistance = 1,
    hiddentext = false,
    doorType = 'door',
    objName = -1789670568,
    fixText = true,
    svgDistance = 2,
    objCoords = vec3(329.645447, -1421.240356, 32.579380),
}

-- coffeteia created by Meisam
Config.DoorList['hospital-coffeteia'] = {
    doors = {
        {objName = -770904654, objYaw = 139.99998474121, objCoords = vec3(343.033447, -1423.930054, 32.582947)},
        {objName = -770904654, objYaw = 320.0, objCoords = vec3(341.335968, -1422.375000, 32.582947)}
    },
    doorType = 'double',
    authorizedJobs = {  ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4},
    cantUnlock = false,
    locked = true,
    doorRate = 1.0,
    svgDistance = 2,
    interactDistance = 1,
}

-- officeroom1 created by Meisam
Config.DoorList['hospital-officeroom1'] = {
    authorizedJobs = {  ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4},
    cantUnlock = false,
    locked = true,
    doorRate = 1.0,
    interactDistance = 1,
    hiddentext = false,
    doorType = 'door',
    objName = 1706193071,
    fixText = true,
    svgDistance = 2,
    objCoords = vec3(337.896606, -1420.268188, 36.670197),
}

-- officeroom5 created by Meisam
Config.DoorList['hospital-officeroom5'] = {
    authorizedJobs = {   ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4},
    cantUnlock = false,
    locked = true,
    doorRate = 1.0,
    interactDistance = 1,
    hiddentext = false,
    doorType = 'door',
    objName = 1706193071,
    fixText = true,
    svgDistance = 2,
    objCoords = vec3(328.961670, -1412.771851, 36.678070),
}

-- officeroom6 created by Meisam
Config.DoorList['hospital-officeroom6'] = {
    authorizedJobs = {   ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4},
    cantUnlock = false,
    locked = true,
    doorRate = 1.0,
    interactDistance = 1,
    hiddentext = false,
    doorType = 'door',
    objName = 1706193071,
    fixText = true,
    svgDistance = 2,
    objCoords = vec3(320.026215, -1405.293213, 36.667419),
}

-- officeroom1-1 created by Meisam
Config.DoorList['hospital-officeroom1-1'] = {
    authorizedJobs = {   ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4},
    cantUnlock = false,
    locked = true,
    doorRate = 1.0,
    interactDistance = 1,
    hiddentext = false,
    doorType = 'door',
    objName = 1706193071,
    fixText = true,
    svgDistance = 2,
    objCoords = vec3(355.567871, -1413.803345, 36.667450),
}

-- officeroom2 created by Meisam
Config.DoorList['hospital-officeroom2'] = {
    authorizedJobs = {   ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    cantUnlock = false,
    locked = true,
    doorRate = 1.0,
    interactDistance = 1,
    hiddentext = false,
    doorType = 'door',
    objName = 1706193071,
    fixText = true,
    svgDistance = 2,
    objCoords = vec3(363.078918, -1404.873413, 36.667450),
}

-- officeroom3 created by Meisam
Config.DoorList['hospital-officeroom3'] = {
    authorizedJobs = {  ['ambulance'] = 0,['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    cantUnlock = false,
    locked = true,
    doorRate = 1.0,
    interactDistance = 1,
    hiddentext = false,
    doorType = 'door',
    objName = 1706193071,
    fixText = true,
    svgDistance = 2,
    objCoords = vec3(370.565826, -1395.950562, 36.660259),
}



-- ambulance-maindoor1 created by ParsaBG

-- maindoor1 created by ParsaBG
Config.DoorList['hospital-maindoor1'] = {
    doorType = 'double',
    authorizedJobs = { ['ambulance'] = 0 },
    locked = false,
    doorRate = 1.0,
    interactDistance = 4,
    cantUnlock = false,
    svgDistance = 2,
    doors = {
        {objName = 825916969, objYaw = 250.00054931641, objCoords = vec3(80.804070, -411.835175, 38.377998)},
        {objName = 400083814, objYaw = 69.998756408691, objCoords = vec3(81.566795, -409.739594, 38.377998)}
    },
}