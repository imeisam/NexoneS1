

-- enter created by Amaterasu
Config.DoorList['digitalden-enter'] = {
    objName = 1181020301,
    svgDistance = 3,
    hiddentext = false,
    locked = true,
    interactDistance = 1,
    doorRate = 1.0,
    objCoords = vec3(1137.338745, -470.038696, 66.906311),
    doorType = 'door',
    cantUnlock = false,
    fixText = true,
    authorizedJobs = { ['police'] = 14, ['justice'] = 4,['goverment']=2,['digitalden'] = 0 },
}

-- hiddenone created by Amaterasu
Config.DoorList['digitalden-hiddenone'] = {
    objName = 547719377,
    svgDistance = 3,
    hiddentext = true,
    locked = true,
    interactDistance = 1,
    doorRate = 1.0,
    objCoords = vec3(1136.689331, -466.895233, 66.634521),
    doorType = 'door',
    cantUnlock = false,
    fixText = true,
    authorizedJobs = {['police'] = 14, ['justice'] = 4,['goverment']=2, ['digitalden'] = 0 },
}

-- backdoor created by Amaterasu
Config.DoorList['digitalden-backdoor'] = {
    objName = -1565285813,
    svgDistance = 3,
    hiddentext = true,
    locked = true,
    interactDistance = 1,
    doorRate = 1.0,
    objCoords = vec3(1129.294189, -464.659241, 66.641548),
    doorType = 'door',
    cantUnlock = false,
    fixText = true,
    authorizedJobs = {['police'] = 14, ['justice'] = 4,['goverment']=2,  ['digitalden'] = 0 },
}

-- hiddentwo created by Amaterasu
Config.DoorList['digitalden-hiddentwo'] = {
    doors = {
        {objName = -1577379202, objYaw = 346.06643676758, objCoords = vec3(1135.493164, -463.911377, 66.509804)},
        {objName = -1577379202, objYaw = 165.99435424805, objCoords = vec3(1136.401001, -464.168365, 66.509804)}
    },
    doorRate = 1.0,
    interactDistance = 1,
    svgDistance = 3,
    hiddentext = true,
    doorType = 'double',
    cantUnlock = false,
    locked = true,
    authorizedJobs = { ['digitalden'] = 3 },
}

-- balcone created by Amaterasu
Config.DoorList['digitalden-balcone'] = {
    objName = -1503577684,
    svgDistance = 3,
    hiddentext = true,
    locked = true,
    interactDistance = 1,
    doorRate = 1.0,
    objCoords = vec3(1137.303223, -474.208740, 72.118126),
    doorType = 'door',
    cantUnlock = false,
    fixText = true,
    authorizedJobs = { ['police'] = 14, ['justice'] = 4,['goverment']=2, ['digitalden'] = 0 },
}