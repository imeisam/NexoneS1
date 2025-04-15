

-- enterbobcat created by Amaterasu
Config.DoorList['bobcat-enterbobcat'] = {
    doors = {
        {objName = -1259801187, objYaw = 355.0022277832, objCoords = vec3(883.481079, -2258.529785, 30.560951)},
        {objName = -1563799200, objYaw = 175.0022277832, objCoords = vec3(880.895874, -2258.308350, 30.560951)}
    },
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    locked = true,
    cantUnlock = false,
    doorRate = 1.0,
    interactDistance = 1,
    doorType = 'double',
    svgDistance = 3,
}

-- firstdoor created by Amaterasu
Config.DoorList['bobcat-firstdoor'] = {
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    locked = true,
    doorType = 'door',
    fixText = true,
    objCoords = vec3(881.617798, -2264.669434, 30.617657),
    doorRate = 1.0,
    cantUnlock = false,
    objName = -551608542,
    hiddentext = false,
    interactDistance = 1,
    svgDistance = 3,
}

-- seconddoor created by Amaterasu
Config.DoorList['bobcat-seconddoor'] = {
    doors = {
        {objName = 933053701, objYaw = 355.0022277832, objCoords = vec3(882.620605, -2268.408203, 30.617695)},
        {objName = 933053701, objYaw = 175.00221252441, objCoords = vec3(880.030518, -2268.181641, 30.617695)}
    },
    authorizedJobs = { ['police'] = 0, ['justice'] = 0 },
    locked = true,
    cantUnlock = false,
    doorRate = 1.0,
    interactDistance = 1,
    doorType = 'double',
    svgDistance = 3,
}