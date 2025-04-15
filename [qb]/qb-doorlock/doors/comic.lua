

-- enter created by Amaterasu
Config.DoorList['comic-enter'] = {
    cantUnlock = false,
    doorRate = 1.0,
    authorizedJobs = { ['police'] = 0 },
    doors = {
        {objName = 1483722564, objYaw = 359.99996948242, objCoords = vec3(-142.469955, 228.695007, 95.136536)},
        {objName = -1508283750, objYaw = 179.99998474121, objCoords = vec3(-145.070786, 228.695007, 95.136536)}
    },
    locked = true,
    doorType = 'double',
    interactDistance = 1,
    svgDistance = 3,
}

-- bossroom created by Amaterasu
Config.DoorList['comic-bossroom'] = {
    fixText = false,
    doorType = 'door',
    objName = 1715961343,
    objCoords = vec3(-138.995026, 221.384521, 95.143997),
    svgDistance = 3,
    cantUnlock = false,
    doorRate = 1.0,
    authorizedJobs = { ['police'] = 0 },
    locked = true,
    hiddentext = false,
    interactDistance = 1,
}