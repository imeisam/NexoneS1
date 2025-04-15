

-- storage one created by Amaterasu
Config.DoorList['vultur-storage one'] = {
    doorType = 'door',
    hiddentext = true,
    objName = -1795835524,
    fixText = true,
    objCoords = vec3(-449.266815, -48.022987, 44.663258),
    svgDistance = 3,
    interactDistance = 1,
    locked = true,
    cantUnlock = false,
    allAuthorized = true,
    doorRate = 1.0,
}

-- storage two created by Amaterasu
Config.DoorList['vultur-storage two'] = {
    doorType = 'garage',
    hiddentext = true,
    objName = -901044889,
    fixText = true,
    objCoords = vec3(-454.506714, -47.677563, 45.522209),
    svgDistance = 3,
    interactDistance = 1,
    locked = true,
    cantUnlock = false,
    allAuthorized = true,
    doorRate = 1.0,
}

-- storage three created by Amaterasu
Config.DoorList['vultur-storage three'] = {
    doorType = 'garage',
    hiddentext = true,
    objName = -901044889,
    fixText = true,
    objCoords = vec3(-460.774231, -47.400894, 45.518097),
    svgDistance = 3,
    interactDistance = 1,
    locked = true,
    cantUnlock = false,
    allAuthorized = true,
    doorRate = 1.0,
}

-- storage four created by Amaterasu
Config.DoorList['vultur-storage four'] = {
    doorType = 'door',
    hiddentext = true,
    objName = 1221385821,
    fixText = true,
    objCoords = vec3(-445.065369, -26.461613, 44.724850),
    svgDistance = 3,
    interactDistance = 1,
    locked = true,
    cantUnlock = false,
    allAuthorized = true,
    doorRate = 1.0,
}

-- enter created by Amaterasu
Config.DoorList['vultur-enter'] = {
    doorType = 'double',
    doorRate = 1.0,
    svgDistance = 3,
    authorizedJobs = { ['police'] = 0 },
    locked = true,
    doors = {
        {objName = -1663450520, objYaw = 355.02020263672, objCoords = vec3(-426.076569, 23.748024, 46.523895)},
        {objName = -1854854241, objYaw = 355.02020263672, objCoords = vec3(-423.596741, 23.533863, 46.523220)}
    },
    interactDistance = 1,
    cantUnlock = false,
}

-- back garage created by Amaterasu
Config.DoorList['vultur-backgarage'] = {
    authorizedJobs = { ['police'] = 0 },
    hiddentext = false,
    objName = -429115342,
    fixText = false,
    objCoords = vec3(-491.205200, 51.213734, 53.247948),
    svgDistance = 6,
    cantUnlock = false,
    locked = true,
    interactDistance = 4,
    doorType = 'garage',
    doorRate = 1.0,
}

-- entertwo created by Amaterasu
Config.DoorList['vultur-entertwo'] = {
    cantUnlock = false,
    doorRate = 1.0,
    authorizedJobs = { ['police'] = 0 },
    doors = {
        {objName = 1709680887, objYaw = 175.02018737793, objCoords = vec3(-491.358978, 28.952126, 46.575893)},
        {objName = -752680088, objYaw = 175.02018737793, objCoords = vec3(-488.961060, 28.741531, 46.575893)}
    },
    locked = true,
    doorType = 'double',
    interactDistance = 1,
    svgDistance = 3,
}

-- balcon created by Amaterasu
Config.DoorList['vultur-balcon'] = {
    cantUnlock = false,
    doorRate = 1.0,
    authorizedJobs = { ['police'] = 0 },
    doors = {
        {objName = -1854854241, objYaw = 175.02018737793, objCoords = vec3(-441.469177, 40.223148, 53.064793)},
        {objName = -1663450520, objYaw = 175.02018737793, objCoords = vec3(-438.990997, 40.008835, 53.064793)}
    },
    locked = true,
    doorType = 'double',
    interactDistance = 1,
    svgDistance = 3,
}