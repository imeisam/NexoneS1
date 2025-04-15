

-- garagefront1 created by Madagascar gameplay
Config.DoorList['tuner-garagefront1'] = {
    objName = -1462510521,
    cantUnlock = false,
    hiddentext = false,
    locked = true,
    interactDistance = 5,
    objCoords = vec3(962.605652, -1016.953247, 42.334969),
    authorizedJobs = { ['police'] = 14, ['justice'] = 0, ['goverment'] = 4, ['tuner'] = 0},
    svgDistance = 7,
    doorRate = 1.0,
    doorType = 'garage',
    fixText = true,
}


-- garagefront2 created by Madagascar gameplay
Config.DoorList['tunder-garagefront2'] = {
    objName = -1462510521,
    cantUnlock = false,
    hiddentext = false,
    locked = true,
    interactDistance = 5,
    objCoords = vec3(962.599548, -1028.261841, 42.335873),
    authorizedJobs = { ['police'] = 14, ['justice'] = 0, ['goverment'] = 4, ['tuner'] = 0},
    svgDistance = 7,
    doorRate = 1.0,
    doorType = 'garage',
    fixText = true,
}

-- frontdoor created by Madagascar gameplay
Config.DoorList['tuner-frontdoor'] = {
    objName = -959792794,
    cantUnlock = false,
    hiddentext = false,
    locked = true,
    interactDistance = 1,
    objCoords = vec3(956.724243, -1034.754028, 41.123379),
    authorizedJobs = { ['police'] = 14, ['justice'] = 0, ['goverment'] = 4, ['tuner'] = 0},
    svgDistance = 2,
    doorRate = 1.0,
    doorType = 'door',
    fixText = false,
}

-- backdoor created by Amaterasu
Config.DoorList['tuner-backdoor'] = {
    locked = true,
    doors = {
        {objName = 273112136, objYaw = 179.99998474121, objCoords = vec3(947.330078, -1011.356201, 41.275337)},
        {objName = 1827509655, objYaw = 179.99998474121, objCoords = vec3(949.932617, -1011.356201, 41.275337)}
    },
    svgDistance = 3,
    authorizedJobs = {['police'] = 14, ['justice'] = 0, ['goverment'] = 4,  ['tuner'] = 0 },
    interactDistance = 1,
    cantUnlock = false,
    doorRate = 1.0,
    doorType = 'double',
}

-- kitchen created by Amaterasu
Config.DoorList['tuner-kitchen'] = {
    locked = true,
    doorType = 'door',
    cantUnlock = false,
    doorRate = 1.0,
    authorizedJobs = { ['police'] = 14, ['justice'] = 0, ['goverment'] = 4, ['tuner'] = 0 },
    interactDistance = 1,
    hiddentext = false,
    svgDistance = 3,
    objCoords = vec3(940.510803, -1037.097656, 41.123375),
    fixText = false,
    objName = -66313236,
}

-- changeclothes created by Amaterasu
Config.DoorList['tuner-changeclothes'] = {
    locked = true,
    doorType = 'door',
    cantUnlock = false,
    doorRate = 1.0,
    authorizedJobs = { ['police'] = 14, ['justice'] = 0, ['goverment'] = 4, ['tuner'] = 0 },
    interactDistance = 1,
    hiddentext = false,
    svgDistance = 3,
    objCoords = vec3(940.507813, -1040.698975, 41.123375),
    fixText = false,
    objName = -66313236,
}

-- hallway created by Amaterasu
Config.DoorList['tuner-hallway'] = {
    locked = true,
    doorType = 'door',
    cantUnlock = false,
    doorRate = 1.0,
    authorizedJobs = { ['police'] = 14, ['justice'] = 0, ['goverment'] = 4, ['tuner'] = 0 },
    interactDistance = 1,
    hiddentext = false,
    svgDistance = 3,
    objCoords = vec3(940.664612, -1038.085327, 46.393330),
    fixText = false,
    objName = -959792794,
}

-- pumpdoor created by Amaterasu
Config.DoorList['tuner-pumpdoor'] = {
    locked = true,
    doorType = 'sliding',
    cantUnlock = false,
    doorRate = 1.0,
    authorizedJobs = {['police'] = 14, ['justice'] = 0, ['goverment'] = 4,  ['tuner'] = 0 },
    interactDistance = 1,
    hiddentext = false,
    svgDistance = 3,
    objCoords = vec3(939.195251, -1013.484131, 39.986008),
    fixText = false,
    objName = -498865902,
}

-- colorroom1 created by Sam
Config.DoorList['tuner-colorroom1'] = {
    svgDistance = 3,
    objName = -1945708956,
    interactDistance = 3,
    doorType = 'garage',
    authorizedJobs = {['police'] = 14, ['justice'] = 4,['goverment']=2, ['tuner'] = 0 },
    doorRate = 1.0,
    hiddentext = false,
    cantUnlock = false,
    fixText = false,
    objCoords = vec3(939.072021, -1016.156189, 42.510586),
    locked = true,
}

-- colorroom2 created by Sam
Config.DoorList['tuner-colorroom2'] = {
    svgDistance = 3,
    objName = -1945708956,
    interactDistance = 3,
    doorType = 'garage',
    authorizedJobs = { ['police'] = 14, ['justice'] = 4,['goverment']=2,['tuner'] = 0 },
    doorRate = 1.0,
    hiddentext = false,
    cantUnlock = false,
    fixText = true,
    objCoords = vec3(939.041321, -1030.931396, 42.499157),
    locked = true,
}