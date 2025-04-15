

-- prison gate 1 created by behno
Config.DoorList['prison-prisongate1'] = {
    interactDistance = 6,
    locked = true,
    doorType = 'sliding',
    objName = 741314661,
    doorRate = 1.0,
    cantUnlock = false,
    objCoords = vec3(1844.998047, 2604.810059, 44.637093),
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    fixText = true,
    hiddentext = false,
    svgDistance = 8,
}

-- prison gate 2 created by behno
Config.DoorList['prison-prisongate2'] = {
    interactDistance = 6,
    locked = true,
    doorType = 'sliding',
    objName = 741314661,
    doorRate = 1.0,
    cantUnlock = false,
    objCoords = vec3(1818.541748, 2604.810059, 44.607353),
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    fixText = true,
    hiddentext = false,
    svgDistance = 8,
}

-- prison gate 3 created by behno
Config.DoorList['prison-prisongate3'] = {
    interactDistance = 1,
    locked = true,
    doorType = 'door',
    objName = -1156020871,
    doorRate = 1.0,
    cantUnlock = false,
    objCoords = vec3(1797.760986, 2596.564941, 46.387310),
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    fixText = true,
    hiddentext = false,
    svgDistance = 2,
}

-- prison backdoor created by behno
Config.DoorList['prison-prison backdoor'] = {
    interactDistance = 1,
    items = { ['lockpick'] = 1 },
    cantUnlock = false,
    doorRate = 1.0,
    svgDistance = 2,
    locked = true,
    fixText = true,
    hiddentext = false,
    objCoords = vec3(1838.401978, 2559.837891, 46.098839),
    doorType = 'door',
    objName = 91564889,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
}

-- gate3 created by behno
Config.DoorList['prison-gate3'] = {
    doorRate = 1.0,
    interactDistance = 5,
    locked = true,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    hiddentext = false,
    objCoords = vec3(1663.369751, 2595.349121, 44.566223),
    fixText = true,
    svgDistance = 8,
    cantUnlock = false,
    doorType = 'sliding',
    objName = 741314661,
}

-- enterdoor created by behno
Config.DoorList['prison-enterdoor'] = {
    doorRate = 1.0,
    interactDistance = 1,
    locked = true,
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    hiddentext = false,
    objCoords = vec3(1831.339966, 2594.992188, 46.037910),
    fixText = false,
    svgDistance = 2,
    cantUnlock = false,
    doorType = 'door',
    objName = -684929024,
}