

-- meetingroom created by behno
Config.DoorList['mrpd-meetingroom'] = {
    doors = {
        {objName = 1079515784, objYaw = 270.00003051758, objCoords = vec3(440.380920, -989.822083, 30.838999)},
        {objName = 1079515784, objYaw = 89.999977111816, objCoords = vec3(440.381409, -987.221008, 30.838999)}
    },
    svgDistance = 2,
    doorType = 'double',
    doorRate = 1.0,
    interactDistance = 1,
    locked = true,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    cantUnlock = false,
}

-- recordsoffice created by behno
Config.DoorList['mrpd-recordsoffice'] = {
    svgDistance = 2,
    doorType = 'door',
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    objName = 1079515784,
    cantUnlock = false,
    fixText = false,
    hiddentext = false,
    objCoords = vec3(441.276581, -978.022644, 30.838999),
    interactDistance = 1,
    locked = true,
    doorRate = 1.0,
}

-- officehall created by behno
Config.DoorList['mrpd-officehall'] = {
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    locked = true,
    doorRate = 1.0,
    interactDistance = 1,
    hiddentext = false,
    svgDistance = 2,
    objName = 1079515784,
    doorType = 'door',
    fixText = false,
    objCoords = vec3(450.120026, -978.022644, 30.838999),
    cantUnlock = false,
}

-- restroom created by behno
Config.DoorList['mrpd-restroom'] = {
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    locked = true,
    doorRate = 1.0,
    interactDistance = 1,
    hiddentext = false,
    svgDistance = 2,
    objName = 1079515784,
    doorType = 'door',
    fixText = false,
    objCoords = vec3(450.006104, -990.751709, 30.838999),
    cantUnlock = false,
}

-- backdoor created by behno
Config.DoorList['mrpd-backdoor'] = {
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    locked = true,
    doorRate = 1.0,
    interactDistance = 1,
    hiddentext = false,
    svgDistance = 2,
    objName = 794198680,
    doorType = 'door',
    fixText = true,
    objCoords = vec3(425.754730, -998.760925, 30.838999),
    cantUnlock = false,
}

-- exityard created by behno
Config.DoorList['mrpd-exityard'] = {
    locked = true,
    interactDistance = 1,
    doorType = 'double',
    svgDistance = 2,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    doorRate = 1.0,
    cantUnlock = false,
    doors = {
        {objName = -1095702117, objYaw = 180.00003051758, objCoords = vec3(440.590851, -998.818420, 30.841000)},
        {objName = 1239973900, objYaw = 0.0, objCoords = vec3(443.189819, -998.818420, 30.841000)}
    },
}

-- exitgarage created by behno
Config.DoorList['mrpd-exitgarage'] = {
    cantUnlock = false,
    doorRate = 1.0,
    objName = -246583363,
    interactDistance = 5,
    locked = true,
    objCoords = vec3(432.542847, -1001.230469, 26.719370),
    fixText = true,
    doorType = 'garage',
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    svgDistance = 7,
    hiddentext = false,
}

-- entergarage created by behno
Config.DoorList['mrpd-entergarage'] = {
    fixText = true,
    doorType = 'garage',
    objName = -246583363,
    hiddentext = false,
    locked = true,
    interactDistance = 5,
    objCoords = vec3(451.387207, -1000.067505, 28.673513),
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    cantUnlock = false,
    svgDistance = 7,
    doorRate = 1.0,
}

-- garagedoorone created by behno
Config.DoorList['mrpd-garagedoorone'] = {
    doors = {
        {objName = 1079515784, objYaw = 270.00006103516, objCoords = vec3(457.598755, -994.267151, 26.536058)},
        {objName = 1079515784, objYaw = 90.000068664551, objCoords = vec3(457.598755, -991.667114, 26.536058)}
    },
    locked = true,
    interactDistance = 1,
    doorRate = 1.0,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    doorType = 'double',
    svgDistance = 2,
    cantUnlock = false,
}

-- garagedoortwo created by behno
Config.DoorList['mrpd-garagedoortwo'] = {
    doors = {
        {objName = 1079515784, objYaw = 270.00006103516, objCoords = vec3(457.598755, -982.213257, 26.536058)},
        {objName = 1079515784, objYaw = 90.000068664551, objCoords = vec3(457.598755, -979.613220, 26.536058)}
    },
    locked = true,
    interactDistance = 1,
    doorRate = 1.0,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    doorType = 'double',
    svgDistance = 2,
    cantUnlock = false,
}

-- mrpdslidingbackdoor created by behno
Config.DoorList['mrpd-mrpdslidingbackdoor'] = {
    fixText = false,
    doorType = 'sliding',
    objName = 81013194,
    hiddentext = false,
    locked = true,
    interactDistance = 5,
    objCoords = vec3(488.780518, -1024.406738, 27.027285),
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    cantUnlock = false,
    svgDistance = 7,
    doorRate = 1.0,
}

-- mrpdbackdoor created by behno
Config.DoorList['mrpd-mrpdbackdoor'] = {
    doorRate = 1.0,
    interactDistance = 1,
    doorType = 'double',
    locked = true,
    doors = {
        {objName = -158854912, objYaw = 180.00003051758, objCoords = vec3(470.019989, -1014.500916, 26.535961)},
        {objName = 794198680, objYaw = 0.0, objCoords = vec3(467.419983, -1014.500916, 26.535961)}
    },
    svgDistance = 2,
    cantUnlock = false,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
}

-- interrogationone created by behno
Config.DoorList['mrpd-interrogationone'] = {
    doorRate = 1.0,
    objName = 1079515784,
    objCoords = vec3(476.768646, -1008.536011, 26.536058),
    cantUnlock = false,
    fixText = false,
    interactDistance = 1,
    hiddentext = false,
    locked = true,
    svgDistance = 2,
    doorType = 'door',
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
}

-- interrogationtwo created by behno
Config.DoorList['mrpd-interrogationtwo'] = {
    doorRate = 1.0,
    objName = 1079515784,
    objCoords = vec3(482.967590, -1008.536011, 26.536058),
    cantUnlock = false,
    fixText = false,
    interactDistance = 1,
    hiddentext = false,
    locked = true,
    svgDistance = 2,
    doorType = 'door',
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
}

-- bigcell created by behno
Config.DoorList['mrpd-bigcell'] = {
    doorType = 'sliding',
    locked = true,
    objCoords = vec3(485.427460, -986.935242, 25.415939),
    fixText = true,
    objName = -691335480,
    interactDistance = 1,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    cantUnlock = false,
    hiddentext = false,
    doorRate = 1.0,
    svgDistance = 2,
}

-- cellone created by behno
Config.DoorList['mrpd-cellone'] = {
    doorType = 'door',
    locked = true,
    objCoords = vec3(484.346466, -998.300598, 26.566811),
    fixText = true,
    objName = -300093563,
    interactDistance = 1,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    cantUnlock = false,
    hiddentext = false,
    doorRate = 1.0,
    svgDistance = 2,
}

-- celltwo created by behno
Config.DoorList['mrpd-celltwo'] = {
    doorType = 'door',
    locked = true,
    objCoords = vec3(484.346466, -1002.881165, 26.566811),
    fixText = false,
    objName = 11515395,
    interactDistance = 1,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    cantUnlock = false,
    hiddentext = false,
    doorRate = 1.0,
    svgDistance = 2,
}

-- cellthree created by behno
Config.DoorList['mrpd-cellthree'] = {
    locked = true,
    fixText = true,
    interactDistance = 1,
    cantUnlock = false,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    hiddentext = false,
    svgDistance = 2,
    doorType = 'door',
    objCoords = vec3(477.408386, -989.746643, 26.566811),
    doorRate = 1.0,
    objName = -300093563,
}

-- cellfour created by behno
Config.DoorList['mrpd-cellfour'] = {
    locked = true,
    fixText = false,
    interactDistance = 1,
    cantUnlock = false,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    hiddentext = false,
    svgDistance = 2,
    doorType = 'door',
    objCoords = vec3(472.677826, -989.746643, 26.566811),
    doorRate = 1.0,
    objName = 11515395,
}

-- cellfive created by behno
Config.DoorList['mrpd-cellfive'] = {
    locked = true,
    fixText = false,
    interactDistance = 1,
    cantUnlock = false,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    hiddentext = false,
    svgDistance = 2,
    doorType = 'door',
    objCoords = vec3(477.408386, -986.962585, 26.566811),
    doorRate = 1.0,
    objName = 11515395,
}

-- cellsix created by behno
Config.DoorList['mrpd-cellsix'] = {
    locked = true,
    fixText = true,
    interactDistance = 1,
    cantUnlock = false,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    hiddentext = false,
    svgDistance = 2,
    doorType = 'door',
    objCoords = vec3(472.677826, -986.962585, 26.566811),
    doorRate = 1.0,
    objName = -300093563,
}

-- rooftopone created by behno
Config.DoorList['mrpd-rooftopone'] = {
    svgDistance = 2,
    objName = 794198680,
    locked = true,
    objCoords = vec3(469.673645, -983.341370, 45.360039),
    doorType = 'door',
    doorRate = 1.0,
    cantUnlock = false,
    hiddentext = false,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    fixText = true,
    interactDistance = 1,
}

-- rooftoptwo created by behno
Config.DoorList['mrpd-rooftoptwo'] = {
    svgDistance = 2,
    objName = -158854912,
    locked = true,
    objCoords = vec3(469.673645, -990.539734, 45.360039),
    doorType = 'door',
    doorRate = 1.0,
    cantUnlock = false,
    hiddentext = false,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    fixText = true,
    interactDistance = 1,
}

-- leftexitdoor created by Madagascar gameplay
Config.DoorList['mrpd-leftexitdoor'] = {
    cantUnlock = false,
    doors = {
        {objName = 1239973900, objYaw = 0.0, objCoords = vec3(470.020966, -972.028931, 30.841000)},
        {objName = -1095702117, objYaw = 180.00003051758, objCoords = vec3(467.421967, -972.028931, 30.841000)}
    },
    locked = true,
    svgDistance = 2,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    interactDistance = 1,
    doorRate = 1.0,
    doorType = 'double',
}

-- armory created by Meisam
Config.DoorList['mrpd-armory'] = {
    cantUnlock = false,
    doorType = 'door',
    hiddentext = false,
    objName = 1079515784,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    svgDistance = 2,
    locked = true,
    fixText = false,
    interactDistance = 1,
    objCoords = vec3(466.799988, -1002.900818, 30.838999),
    doorRate = 1.0,
}