

-- cardealeroffice1 created by behno
Config.DoorList['mosleys-cardealeroffice1'] = {
    objName = 2086311126,
    doorRate = 1.0,
    interactDistance = 1,
    hiddentext = false,
    objCoords = vec3(-16.165661, -1648.657471, 29.641317),
    doorType = 'door',
    svgDistance = 2,
    fixText = false,
    cantUnlock = false,
    authorizedJobs = { ['cardealer'] = 0, ['justice'] = 0, ['police'] = 14, ['goverment'] = 4 },
    locked = true,
}

-- cardealeroffice2 created by behno
Config.DoorList['mosleys-cardealeroffice2'] = {
    objName = 2086311126,
    doorRate = 1.0,
    interactDistance = 1,
    hiddentext = false,
    objCoords = vec3(-17.328636, -1650.043457, 29.641317),
    doorType = 'door',
    svgDistance = 2,
    fixText = false,
    cantUnlock = false,
    authorizedJobs = { ['cardealer'] = 0, ['justice'] = 0, ['police'] = 14, ['goverment'] = 4 },
    locked = true,
}

-- cardealerinformation created by behno
Config.DoorList['mosleys-cardealerinformation'] = {
    svgDistance = 2,
    fixText = false,
    doorRate = 1.0,
    doorType = 'door',
    locked = true,
    authorizedJobs = { ['cardealer'] = 0, ['justice'] = 0, ['police'] = 14, ['goverment'] = 4 },
    cantUnlock = false,
    hiddentext = false,
    objCoords = vec3(-37.416077, -1674.089355, 29.615818),
    objName = -1918617751,
    interactDistance = 1,
}

-- cardealerbackdoor created by behno
Config.DoorList['mosleys-cardealerbackdoor'] = {
    objName = 1608375261,
    objCoords = vec3(-35.480816, -1676.560669, 29.623363),
    interactDistance = 1,
    doorRate = 1.0,
    fixText = false,
    svgDistance = 2,
    cantUnlock = false,
    locked = true,
    hiddentext = false,
    authorizedJobs = { ['cardealer'] = 0, ['justice'] = 0, ['police'] = 14, ['goverment'] = 4 },
    doorType = 'door',
}

-- cardealerinformation2 created by behno
Config.DoorList['mosleys-cardealerinformation2'] = {
    hiddentext = false,
    authorizedJobs = { ['cardealer'] = 0, ['justice'] = 0, ['police'] = 14, ['goverment'] = 4 },
    doorType = 'door',
    doorRate = 1.0,
    objName = -1918617751,
    svgDistance = 2,
    interactDistance = 1,
    locked = true,
    objCoords = vec3(-28.766182, -1665.326904, 29.615818),
    fixText = false,
    cantUnlock = false,
}

-- entermechanic created by Meisam
Config.DoorList['mosleys-entermechanic'] = {
    cantUnlock = false,
    hiddentext = false,
    svgDistance = 3,
    fixText = false,
    locked = true,
    authorizedJobs = { ['mechanicsh']=0, ['justice'] = 0, ['police'] = 14, ['goverment'] = 4 },
    objCoords = vec3(-25.816319, -1672.385864, 29.625610),
    interactDistance = 1,
    doorRate = 1.0,
    doorType = 'door',
    objName = -1705512110,
}


-- mechanicmosleygarage created by Meisam
Config.DoorList['mosleys-mechanicmosleygarage'] = {
    hiddentext = false,
    doorRate = 1.0,
    authorizedJobs = { ['mechanicsh']=0,['justice'] = 0, ['police'] = 14, ['goverment'] = 4 },
    objName = -1454127503,
    interactDistance = 5,
    locked = true,
    objCoords = vec3(-17.656887, -1673.186768, 32.647491),
    fixText = false,
    cantUnlock = false,
    doorType = 'garage',
    svgDistance =7,
}

-- cardealertomechanic created by Meisam
Config.DoorList['mosleys-cardealertomechanic'] = {
    authorizedJobs = { ['cardealer'] = 0,['mechanicsh']=0,['justice'] = 0, ['police'] = 14, ['goverment'] = 4 },
    fixText = false,
    objName = -1902126086,
    interactDistance = 1,
    hiddentext = false,
    svgDistance = 3,
    doorType = 'door',
    objCoords = vec3(-25.058641, -1667.112305, 29.625610),
    locked = true,
    cantUnlock = false,
    doorRate = 1.0,
}


-- boss created by Sam
Config.DoorList['mosleys-boss'] = {
    objName = 1860476036,
    objCoords = vec3(-9.378210, -1658.898682, 29.625610),
    authorizedJobs = { ['mechanicsh'] = 0 ,['justice'] = 0, ['police'] = 14, ['goverment'] = 4},
    svgDistance = 2,
    doorRate = 1.0,
    hiddentext = false,
    cantUnlock = false,
    fixText = false,
    doorType = 'door',
    interactDistance = 1,
    locked = true,
}

-- restroom created by Sam
Config.DoorList['mosleys-restroom'] = {
    fixText = false,
    doorRate = 1.0,
    cantUnlock = false,
    objCoords = vec3(-1.738118, -1665.309448, 29.625610),
    objName = -1902126086,
    hiddentext = false,
    svgDistance = 2,
    authorizedJobs = { ['mechanicsh'] = 0 ,['justice'] = 0, ['police'] = 14, ['goverment'] = 4},
    doorType = 'door',
    interactDistance = 1,
    locked = true,
}