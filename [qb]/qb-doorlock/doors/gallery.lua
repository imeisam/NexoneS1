

-- reception created by behno
Config.DoorList['gallery-reception'] = {
    doorType = 'door',
    hiddentext = false,
    fixText = true,
    interactDistance = 1,
    objName = -1506340036,
    objCoords = vec3(115.497055, -145.043503, 54.924122),
    svgDistance = 2,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    locked = true,
    doorRate = 1.0,
    cantUnlock = false,
}

-- receptionbackdoor created by behno
Config.DoorList['gallery-receptionbackdoor'] = {
    doorType = 'door',
    hiddentext = false,
    fixText = true,
    interactDistance = 1,
    objName = -1151729846,
    objCoords = vec3(111.558937, -138.238693, 54.924355),
    svgDistance = 2,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    locked = true,
    doorRate = 1.0,
    cantUnlock = false,
}

-- backdoorexit created by behno
Config.DoorList['gallery-backdoorexit'] = {
    interactDistance = 1,
    doorType = 'double',
    doors = {
        {objName = 1333601429, objYaw = 70.000038146973, objCoords = vec3(127.023308, -127.646233, 54.924355)},
        {objName = -428323923, objYaw = 70.000038146973, objCoords = vec3(127.876991, -125.300758, 54.924355)}
    },
    doorRate = 1.0,
    cantUnlock = false,
    locked = true,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    svgDistance = 2,
}

-- garagedoor created by behno
Config.DoorList['gallery-garagedoor'] = {
    doorType = 'door',
    hiddentext = false,
    fixText = true,
    interactDistance = 1,
    objName = -1151729846,
    objCoords = vec3(141.522736, -131.409210, 54.924362),
    svgDistance = 2,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    locked = true,
    doorRate = 1.0,
    cantUnlock = false,
}

-- garage created by behno
Config.DoorList['gallery-garage'] = {
    doorType = 'garage',
    doorRate = 1.0,
    locked = true,
    objCoords = vec3(147.342514, -133.505585, 55.171288),
    objName = 1109400112,
    fixText = true,
    hiddentext = false,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    svgDistance = 7,
    cantUnlock = false,
    interactDistance = 4,
}

-- backdoorexitgarage created by behno
Config.DoorList['gallery-backdoorexitgarage'] = {
    doorType = 'door',
    doorRate = 1.0,
    cantUnlock = false,
    fixText = false,
    hiddentext = false,
    locked = true,
    svgDistance = 2,
    objName = -1516005479,
    objCoords = vec3(132.257019, -124.668884, 60.524353),
    authorizedJobs = { ['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    interactDistance = 1,
}

-- entergarageone created by behno
Config.DoorList['gallery-entergarageone'] = {
    doorType = 'double',
    doorRate = 1.0,
    locked = true,
    svgDistance = 2,
    doors = {
        {objName = -1055437184, objYaw = 70.000038146973, objCoords = vec3(135.123856, -137.589172, 54.924362)},
        {objName = -1628533937, objYaw = 70.000038146973, objCoords = vec3(135.977539, -135.243698, 54.924362)}
    },
    interactDistance = 1,
    cantUnlock = false,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
}

-- entergaragetwo created by behno
Config.DoorList['gallery-entergaragetwo'] = {
    doorType = 'door',
    doorRate = 1.0,
    cantUnlock = false,
    fixText = true,
    hiddentext = false,
    locked = true,
    svgDistance = 4,
    objName = -1055437184,
    objCoords = vec3(136.893570, -132.726913, 54.924126),
    authorizedJobs = { ['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    interactDistance = 1,
}

-- floorone created by behno
Config.DoorList['gallery-floorone'] = {
    hiddentext = false,
    objCoords = vec3(124.000107, -143.378586, 54.924122),
    svgDistance = 2,
    cantUnlock = false,
    locked = true,
    interactDistance = 1,
    objName = -1506340036,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    doorType = 'door',
    fixText = true,
    doorRate = 1.0,
}

-- floortwo created by behno
Config.DoorList['gallery-floortwo'] = {
    interactDistance = 1,
    doors = {
        {objName = -1506340036, objYaw = 250.00003051758, objCoords = vec3(150.372925, -138.510452, 60.525146)},
        {objName = -1506340036, objYaw = 70.000007629395, objCoords = vec3(149.519241, -140.855927, 60.525146)}
    },
    svgDistance = 2,
    doorRate = 1.0,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    cantUnlock = false,
    locked = true,
    doorType = 'double',
}

-- bossroomone created by behno
Config.DoorList['gallery-bossroomone'] = {
    hiddentext = false,
    objCoords = vec3(126.434738, -131.071701, 60.524117),
    svgDistance = 2,
    cantUnlock = false,
    locked = true,
    interactDistance = 1,
    objName = -1506340036,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    doorType = 'door',
    fixText = true,
    doorRate = 1.0,
}

-- bossroomtwo created by behno
Config.DoorList['gallery-bossroomtwo'] = {
    hiddentext = false,
    objCoords = vec3(124.331734, -128.575623, 60.524117),
    svgDistance = 2,
    cantUnlock = false,
    locked = true,
    interactDistance = 1,
    objName = -1506340036,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    doorType = 'door',
    fixText = true,
    doorRate = 1.0,
}

-- auctionroom created by behno
Config.DoorList['gallery-auctionroom'] = {
    cantUnlock = false,
    doors = {
        {objName = -1506340036, objYaw = 250.00003051758, objCoords = vec3(149.543533, -140.789444, 50.324120)},
        {objName = -1506340036, objYaw = 70.000007629395, objCoords = vec3(148.689850, -143.134918, 50.324120)}
    },
    interactDistance = 1,
    doorRate = 1.0,
    locked = true,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    doorType = 'double',
    svgDistance = 2,
}

-- bartenderdoor created by behno
Config.DoorList['gallery-bartenderdoor'] = {
    fixText = true,
    objName = -1506340036,
    svgDistance = 2,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    doorType = 'door',
    objCoords = vec3(117.570900, -146.054260, 49.524117),
    cantUnlock = false,
    hiddentext = false,
    locked = true,
    interactDistance = 1,
    doorRate = 1.0,
}