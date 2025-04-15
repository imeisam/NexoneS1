


-- bossroom created by behno
Config.DoorList['pawnshop-bossroom'] = {
    svgDistance = 2,
    objName = 860826688,
    locked = true,
    objCoords = vec3(154.723877, -1715.244141, 29.534849),
    doorType = 'door',
    doorRate = 1.0,
    cantUnlock = false,
    hiddentext = false,
    authorizedJobs = { ['police'] = 14, ['justice'] = 0, ['pawnshop'] = 0, ['goverment'] = 4 },
    fixText = true,
    interactDistance = 1,
}

-- enter created by Mani
Config.DoorList['pawnshop-enter'] = {
    authorizedJobs = { ['police'] = 14, ['justice'] = 0, ['pawnshop'] = 0, ['goverment'] = 4 },
    interactDistance = 2,
    doorType = 'door',
    objName = -2068754685,
    hiddentext = false,
    locked = true,
    fixText = false,
    objCoords = vec3(143.882874, -1720.913696, 29.534849),
    svgDistance = 2,
    cantUnlock = false,
    doorRate = 1.0,
}