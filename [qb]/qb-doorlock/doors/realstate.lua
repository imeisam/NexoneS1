

-- frontdoor created by behno
Config.DoorList['realstate-frontdoor'] = {
    doors = {
        {objName = -1922281023, objYaw = 115.49955749512, objCoords = vec3(-699.655945, 271.888641, 83.414963)},
        {objName = -1922281023, objYaw = 295.49960327148, objCoords = vec3(-698.747864, 269.975983, 83.414627)}
    },
    doorType = 'double',
    svgDistance = 2,
    authorizedJobs = { ['police'] = 14, ['realestate'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    doorRate = 1.0,
    cantUnlock = false,
    locked = true,
    interactDistance = 1,
}

-- bossroom created by behno
Config.DoorList['realstate-bossroom'] = {
    cantUnlock = false,
    locked = true,
    interactDistance = 1,
    doorRate = 1.0,
    objName = 1901183774,
    authorizedJobs = { ['police'] = 14, ['realestate'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    hiddentext = false,
    fixText = false,
    objCoords = vec3(-713.923157, 264.462982, 84.194962),
    svgDistance = 2,
    doorType = 'door',
}

-- backdoor created by behno
Config.DoorList['realstate-backdoor'] = {
    cantUnlock = false,
    locked = true,
    interactDistance = 1,
    doorRate = 1.0,
    objName = 1901183774,
    authorizedJobs = { ['police'] = 14, ['realestate'] = 0, ['justice'] = 0, ['goverment'] = 4 },
    hiddentext = false,
    fixText = false,
    objCoords = vec3(-716.373047, 270.603546, 84.815918),
    svgDistance = 2,
    doorType = 'door',
}