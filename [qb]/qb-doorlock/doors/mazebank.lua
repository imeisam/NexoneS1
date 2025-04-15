

-- garagedoor1 created by behno
Config.DoorList['mazebank-garagedoor1'] = {
    doorRate = 1.0,
    objCoords = vec3(-1308.818237, -799.318970, 18.037479),
    objName = 774764467,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    doorType = 'garage',
    locked = true,
    hiddentext = false,
    fixText = true,
    cantUnlock = false,
    interactDistance = 4,
    svgDistance = 2,
}

-- garagedoor2 created by behno
Config.DoorList['mazebank-garagedoor2'] = {
    doorRate = 1.0,
    objCoords = vec3(-1306.664185, -802.215881, 17.678469),
    objName = 1573431937,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    doorType = 'door',
    locked = true,
    hiddentext = false,
    fixText = true,
    cantUnlock = false,
    interactDistance = 1,
    svgDistance = 2,
}

-- doubledoorbank1 created by behno
Config.DoorList['mazebank-doubledoorbank1'] = {
    doors = {
        {objName = -1858563744, objYaw = 217.00100708008, objCoords = vec3(-1304.335938, -813.304260, 17.056919)},
        {objName = -1560267537, objYaw = 37.000995635986, objCoords = vec3(-1306.252197, -814.748413, 17.056919)}
    },
    doorRate = 1.0,
    locked = true,
    doorType = 'double',
    interactDistance = 1,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    cantUnlock = false,
    svgDistance = 2,
}

-- doubledoorbank2 created by behno
Config.DoorList['mazebank-doubledoorbank2'] = {
    doors = {
        {objName = 1573431937, objYaw = 217.00100708008, objCoords = vec3(-1316.824463, -815.173889, 17.240009)},
        {objName = -1262069637, objYaw = 37.000995635986, objCoords = vec3(-1318.740845, -816.618042, 17.240009)}
    },
    doorRate = 1.0,
    locked = true,
    doorType = 'double',
    interactDistance = 1,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    cantUnlock = false,
    svgDistance = 2,
}

-- backdoorreception created by behno
Config.DoorList['mazebank-backdoorreception'] = {
    doorRate = 1.0,
    objCoords = vec3(-1313.359863, -820.079529, 17.054132),
    objName = 1869172162,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    doorType = 'door',
    locked = true,
    hiddentext = false,
    fixText = true,
    cantUnlock = false,
    interactDistance = 1,
    svgDistance = 2,
}

-- reception created by behno
Config.DoorList['mazebank-reception'] = {
    doorRate = 1.0,
    objCoords = vec3(-1306.672485, -816.572449, 17.056522),
    objName = -1038046021,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    doorType = 'door',
    locked = true,
    hiddentext = false,
    fixText = true,
    cantUnlock = false,
    interactDistance = 1,
    svgDistance = 2,
}

-- officebackdoor created by behno
Config.DoorList['mazebank-officebackdoor'] = {
    doorRate = 1.0,
    objCoords = vec3(-1287.621582, -833.310181, 17.201361),
    objName = 1869172162,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    doorType = 'door',
    locked = true,
    hiddentext = false,
    fixText = true,
    cantUnlock = false,
    interactDistance = 1,
    svgDistance = 2,
}

-- serverroom created by behno
Config.DoorList['mazebank-serverroom'] = {
    doorRate = 1.0,
    objCoords = vec3(-1295.208496, -826.561890, 12.154132),
    objName = -1038046021,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    doorType = 'door',
    locked = true,
    hiddentext = false,
    fixText = true,
    cantUnlock = false,
    interactDistance = 1,
    svgDistance = 2,
}

-- sewerdoor created by behno
Config.DoorList['mazebank-sewerdoor'] = {
    doorRate = 1.0,
    objCoords = vec3(-1293.548340, -830.264099, 4.257650),
    objName = 1972704169,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    doorType = 'door',
    locked = true,
    hiddentext = false,
    fixText = false,
    cantUnlock = false,
    interactDistance = 1,
    svgDistance = 2,
}

-- vaultdoor created by behno
Config.DoorList['mazebank-vaultdoor'] = {
    svgDistance = 2,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    doorType = 'door',
    cantUnlock = false,
    doorRate = 1.0,
    locked = true,
    hiddentext = false,
    objCoords = vec3(-1302.547852, -821.254761, 12.239700),
    objName = -541242305,
    interactDistance = 1,
    fixText = false,
}