

-- administration created by behno
Config.DoorList['snrbuns-administration'] = {
    doorType = 'door',
    authorizedJobs = { ['police'] = 14, ['justice'] = 0, ['goverment'] = 4, ['snrbuns'] = 0 , ['snrpizza'] = 0 , ['snrcoffee'] = 0, ['snrsushi'] = 0, ['snrsmoothie'] = 0},
    locked = true,
    fixText = false,
    cantUnlock = false,
    objName = -452300464,
    svgDistance = 2,
    hiddentext = false,
    objCoords = vec3(-509.881561, -726.986267, 33.796078),
    interactDistance = 1,
    doorRate = 1.0,
}

-- snrbunsbackdoor created by behno
Config.DoorList['snrbuns-snrbunsbackdoor'] = {
    authorizedJobs = { ['police'] = 14, ['justice'] = 0, ['goverment'] = 4, ['snrbuns'] = 0 },
    svgDistance = 2,
    doorRate = 1.0,
    objName = 1245241911,
    locked = true,
    interactDistance = 1,
    hiddentext = false,
    cantUnlock = false,
    fixText = false,
    objCoords = vec3(-501.529755, -692.953796, 33.798920),
    doorType = 'door',
}

-- enter created by behno
Config.DoorList['snrbuns-enter'] = {
    svgDistance = 4,
    cantUnlock = false,
    doors = {
        {objName = 345700088, objYaw = 270.0, objCoords = vec3(-508.227600, -693.401978, 33.216251)},
        {objName = 345700088, objYaw = 89.999977111816, objCoords = vec3(-508.227600, -692.498291, 33.216251)}
    },
    doorRate = 1.0,
    locked = true,
    doorType = 'double',
    authorizedJobs = { ['police'] = 14, ['justice'] = 0, ['goverment'] = 4, ['snrbuns'] = 0 },
    interactDistance = 1,
}

-- indoorlobbey created by Sam
Config.DoorList['snrbuns-indoorlobbey'] = {
    fixText = false,
    doorType = 'door',
    hiddentext = false,
    authorizedJobs =  { ['police'] = 14, ['justice'] = 0, ['goverment'] = 4, ['snrbuns'] = 0 },
    objName = -682043923,
    interactDistance = 1,
    objCoords = vec3(-504.757202, -693.029968, 33.796078),
    svgDistance = 2,
    locked = true,
    cantUnlock = false,
    doorRate = 1.0,
}

-- maindoor created by Sam
Config.DoorList['snrbuns-maindoor'] = {
    locked = true,
    interactDistance = 1,
    doors = {
        {objName = 30354137, objYaw = 89.999992370605, objCoords = vec3(-515.832520, -690.804138, 34.028046)},
        {objName = 30354137, objYaw = 270.0, objCoords = vec3(-515.832520, -693.336243, 34.028046)}
    },
    doorRate = 1.0,
    doorType = 'double',
    svgDistance = 2,
    authorizedJobs = {  ['police'] = 14, ['justice'] = 0, ['goverment'] = 4,['snrbuns'] = 0 },
    cantUnlock = false,
}