Config = {}

Config.MenuItems = {
    {
        id = 'citizen',
        title = 'Citizen',
        icon = '#citizen',
        items = {
            {
                id = 'getintrunk',
                title = 'Get In Trunk',
                icon = '#trunk',
                functiontype = 'client',
                functionName = 'qb-trunk:client:GetIn',
                shouldClose = true
            },
            {
                id = 'flipvehicle',
                title = 'Flip Vehicle',
                icon = '#flip',
                functiontype = 'client',
                functionName = 'qb-vehicle:client:flip',
                shouldClose = true
            },
            {
                id = 'scenemenu',
                title = 'Scene Menu',
                icon = '#clipboard',
                functiontype = 'client',
                functionName = 'qb-scenes:client:startScenes',
                shouldClose = true
            },
            {
                id = 'givecontact',
                title = 'Give Contact',
                icon = '#contact',
                functiontype = 'client',
                functionName = 'qb-phone:client:GiveContactDetails',
                shouldClose = true
            }
            
        }
    },
    {
        id = 'blips',
        title = 'Blips',
        icon = '#blips',
        items = {
            {
                id = 'gasstation',
                title = 'Gas Stations',
                icon = '#blips-gasstations',
                functiontype = 'client',
                functionName = 'qb-fuel:client:toggleBlips',
                shouldClose = true
            },
            {
                id = 'trainstations',
                title = 'Train Stations',
                icon = '#blips-trainstations',
                functiontype = 'client',
                functionName = 'metro:client:toggleBlips',
                shouldClose = true
            },
            {
                id = 'clothingblip',
                title = 'Clothing Shop',
                icon = '#blips-clothing',
                functiontype = 'client',
                functionName = 'lvs_clothing:client:toggleBlips',
                shouldClose = true
            },
        }
    },
    {
        id = 'emotes',
        title = 'Emote',
        icon = '#emotes',
        functiontype = 'client',
        functionName = 'emotes:openMenu',
        shouldClose = true
    },

    {
        id = 'pets',
        title = 'Pet Action',
        icon = '#pet',
        items = {
            {
                id = 'startselect',
                title = 'Start Selecting',
                icon = '#pet',
                functiontype = 'client',
                functionName = 'qb-pet:radial:StartSelect',
                shouldClose = true
            },
            {
                id = 'deselect',
                title = 'Stop Selecting',
                icon = '#pet',
                functiontype = 'client',
                functionName = 'qb-pet:radial:StopSelect',
                shouldClose = true
            },
            {
                id = 'selecttarget',
                title = 'Select',
                icon = '#pet',
                functiontype = 'client',
                functionName = 'qb-pet:radial:SelectTarget',
                shouldClose = true
            },
            {
                id = 'followself',
                title = 'Follow Self',
                icon = '#user',
                functiontype = 'client',
                functionName = 'qb-pet:radial:FollowSelf',
                shouldClose = true
            },
            {
                id = 'followvehicle',
                title = 'Get in Vehicle',
                icon = '#vehicle',
                functiontype = 'client',
                functionName = 'qb-pet:radial:FollowVehicle',
                shouldClose = true
            },
            {
                id = 'attack',
                title = 'Attack Next Target',
                icon = '#angry',
                functiontype = 'client',
                functionName = 'qb-pet:radial:track',
                shouldClose = true
            },
        }
    },
}

Config.JobInteractions = {
    ["ambulance"] = {
        {
            id = 'joblist',
            title = 'Jobs List',
            icon = '#list',
            functiontype = 'client',
            functionName = 'qb-joblist:client:showmenu',
            shouldClose = false
        },
        {
            id = 'recordbodycam',
            title = 'Record Bodycam',
            icon = '#camera',
            functiontype = 'server',
            functionName = 'spy-bodycam:server:recordcam',
            shouldClose = false
        },
        {
            id = 'mdt',
            title = 'MDT',
            icon = '#mdw',
            functiontype = 'command',
            functionName = 'mdt',
            shouldClose = true
        }, {
            id = 'healthsystem',
            title = 'Health Status',
            icon = '#blood',
            functiontype = 'command',
            functionName = 'openht',
            shouldClose = true
        }, {
            id = 'radiochannel',
            title = 'Radio',
            icon = '#wifi',
            items = {
                {
                    id = 'radiofreq1',
                    title = '1',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 1',
                    shouldClose = false
                },
                {
                    id = 'radiofreq2',
                    title = '2',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 2',
                    shouldClose = false
                },
                {
                    id = 'radiofreq3',
                    title = '3',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 3',
                    shouldClose = false
                },
                {
                    id = 'radiofreq4',
                    title = '4',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 4',
                    shouldClose = false
                },
                {
                    id = 'radiofreq5',
                    title = '5',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 5',
                    shouldClose = false
                },
                {
                    id = 'radiofreq6',
                    title = '6',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 6',
                    shouldClose = false
                },
                {
                    id = 'radiofreq7',
                    title = '7',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 7',
                    shouldClose = false
                },
                {
                    id = 'radiofreq8',
                    title = '8',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 8',
                    shouldClose = false
                },
                {
                    id = 'radiofreq9',
                    title = '9',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 9',
                    shouldClose = false
                },
            }
        }, {
            id = 'policeobjects',
            title = 'Objects',
            icon = '#object',
            items = {
                {
                    id = 'spawnpion',
                    title = 'Cone',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnCone',
                    shouldClose = false
                }, {
                    id = 'spawnpionred',
                    title = 'Red Cone',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnRedCone',
                    shouldClose = false
                },  {
                    id = 'spawnpionblue',
                    title = 'Blue Cone',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnBlueCone',
                    shouldClose = false
                }, {
                    id = 'spawnhek',
                    title = 'Barrier',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnBarrier',
                    shouldClose = false
                }, {
                    id = 'spawnschotten',
                    title = 'Road Closed',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnRoadSign',
                    shouldClose = false
                },  {
                    id = 'spawnscreen',
                    title = 'Screen',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnScreen',
                    shouldClose = false
                },  {
                    id = 'spawntent',
                    title = 'Tent',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnTent',
                    shouldClose = false
                }, {
                    id = 'spawnverlichting',
                    title = 'Lighting',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnLight',
                    shouldClose = false
                },  {
                    id = 'ascene',
                    title = 'A Marker',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnAscene',
                    shouldClose = false
                },  {
                    id = 'bscene',
                    title = 'B Marker',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnBscene',
                    shouldClose = false
                },  {
                    id = 'cscene',
                    title = 'C Marker',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnCscene',
                    shouldClose = false
                }, 
                {
                    id = 'deleteobject',
                    title = 'Remove object',
                    icon = '#delete',
                    functiontype = 'client',
                    functionName = 'police:client:deleteObject',
                    shouldClose = false
                }
              
            },
        }, {
            id = 'getkey',
            title = 'Get Key',
            icon = '#givekey',
            functiontype = 'client',
            functionName = 'police:client:getkey',
            shouldClose = true
        }
    },
    ["police"] = {
        {
            id = 'joblist',
            title = 'Jobs List',
            icon = '#list',
            functiontype = 'client',
            functionName = 'qb-joblist:client:showmenu',
            shouldClose = false
        },
        {
            id = 'anklettablet',
            title = 'Anklet Tablet',
            icon = '#mdw',
            functiontype = 'client',
            functionName = 'cuff:client:showElectronicCuffTrackMenu',
            shouldClose = false
        },
        {
            id = 'recordbodycam',
            title = 'Record Bodycam',
            icon = '#camera',
            functiontype = 'server',
            functionName = 'spy-bodycam:server:recordcam',
            shouldClose = false
        },
        {
            id = 'radarplate',
            title = 'Radar Plate',
            icon = '#roadcirclecheck',
            functiontype = 'client',
            functionName = 'police:client:checkradarplate',
            shouldClose = false
        },
        {
            id = 'panicbut',
            title = 'Panic Alert',
            icon = '#panic',
            functiontype = 'client',
            functionName = 'qb-dispatch:client:panic',
            shouldClose = true
        },
        {
            id = 'radiochannel',
            title = 'Radio',
            icon = '#wifi',
            items = {
                {
                    id = 'radiochecker',
                    title = 'Check Emergency Freqs',
                    icon = '#wifi',
                    functiontype = 'server',
                    functionName = 'qb-radiochecker:server:getEmergencyFreqs',
                    shouldClose = false
                },
                {
                    id = 'radiofreq1',
                    title = '1',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 1',
                    shouldClose = false
                },
                {
                    id = 'radiofreq2',
                    title = '2',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 2',
                    shouldClose = false
                },
                {
                    id = 'radiofreq3',
                    title = '3',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 3',
                    shouldClose = false
                },
                {
                    id = 'radiofreq4',
                    title = '4',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 4',
                    shouldClose = false
                },
                {
                    id = 'radiofreq5',
                    title = '5',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 5',
                    shouldClose = false
                },
                {
                    id = 'radiofreq6',
                    title = '6',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 6',
                    shouldClose = false
                },
                {
                    id = 'radiofreq7',
                    title = '7',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 7',
                    shouldClose = false
                },
                {
                    id = 'radiofreq8',
                    title = '8',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 8',
                    shouldClose = false
                },
                {
                    id = 'radiofreq9',
                    title = '9',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 9',
                    shouldClose = false
                },
            }
        }, {
            id = 'radar',
            title = 'Radar',
            icon = '#radar',
            functiontype = 'client',
            functionName = 'startSpeedo',
            shouldClose = true
        }, {
            id = 'healthsystem',
            title = 'Health Status',
            icon = '#blood',
            functiontype = 'command',
            functionName = 'openht',
            shouldClose = true
        }, {
            id = 'safestash',
            title = 'Gun Rack',
            icon = '#job',
            functiontype = 'client',
            functionName = 'police:client:openstashSafe',
            shouldClose = true
        }, {
            id = 'getkey',
            title = 'Get Key',
            icon = '#givekey',
            functiontype = 'client',
            functionName = 'police:client:getkey',
            shouldClose = true
        }, {
            id = 'policeobjects',
            title = 'Objects',
            icon = '#object',
            items = {
                {
                    id = 'spawnpion',
                    title = 'Cone',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnCone',
                    shouldClose = false
                },{
                    id = 'spawnpionred',
                    title = 'Red Cone',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnRedCone',
                    shouldClose = false
                },{
                    id = 'spawnpionred',
                    title = 'Blue Cone',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnBlueCone',
                    shouldClose = false
                }, {
                    id = 'spawnhek',
                    title = 'Barrier',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnBarrier',
                    shouldClose = false
                }, {
                    id = 'spawnschotten',
                    title = 'Road Closed',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnRoadSign',
                    shouldClose = false
                },  {
                    id = 'spawnscreen',
                    title = 'Screen',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnScreen',
                    shouldClose = false
                },  {
                    id = 'spawntent',
                    title = 'Tent',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnTent',
                    shouldClose = false
                }, {
                    id = 'spawnverlichting',
                    title = 'Lighting',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnLight',
                    shouldClose = false
                },  {
                    id = 'ascene',
                    title = 'A Marker',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnAscene',
                    shouldClose = false
                },  {
                    id = 'bscene',
                    title = 'B Marker',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnBscene',
                    shouldClose = false
                },  {
                    id = 'cscene',
                    title = 'C Marker',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnCscene',
                    shouldClose = false
                }, 
                {
                    id = 'deleteobject',
                    title = 'Remove object',
                    icon = '#delete',
                    functiontype = 'client',
                    functionName = 'police:client:deleteObject',
                    shouldClose = false
                }
            },
        }, {
            id = 'mdt',
            title = 'MDT',
            icon = '#mdw',
            functiontype = 'command',
            functionName = 'mdt',
            shouldClose = true
        },
        {
            id = 'checkvin',
            title = 'Check VIN',
            icon = '#enkelband',
            functiontype = 'client',
            functionName = 'qb-police:client:checkvin',
            shouldClose = true
        }
    },
    ["justice"] = {
        {
            id = 'joblist',
            title = 'Jobs List',
            icon = '#list',
            functiontype = 'client',
            functionName = 'qb-joblist:client:showmenu',
            shouldClose = false
        },
        {
            id = 'anklettablet',
            title = 'Anklet Tablet',
            icon = '#mdw',
            functiontype = 'client',
            functionName = 'cuff:client:showElectronicCuffTrackMenu',
            shouldClose = false
        },
        {
            id = 'recordbodycam',
            title = 'Record Bodycam',
            icon = '#camera',
            functiontype = 'server',
            functionName = 'spy-bodycam:server:recordcam',
            shouldClose = false
        },
        {
            id = 'radarplate',
            title = 'Radar Plate',
            icon = '#roadcirclecheck',
            functiontype = 'client',
            functionName = 'police:client:checkradarplate',
            shouldClose = false
        },
        {
            id = 'panicbut',
            title = 'Panic Alert',
            icon = '#panic',
            functiontype = 'client',
            functionName = 'qb-dispatch:client:panic',
            shouldClose = true
        },
        {
            id = 'radiochannel',
            title = 'Radio',
            icon = '#wifi',
            items = {
                {
                    id = 'radiochecker',
                    title = 'Check Emergency Freqs',
                    icon = '#wifi',
                    functiontype = 'server',
                    functionName = 'qb-radiochecker:server:getEmergencyFreqs',
                    shouldClose = false
                },
                {
                    id = 'radiofreq1',
                    title = '1',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 1',
                    shouldClose = false
                },
                {
                    id = 'radiofreq2',
                    title = '2',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 2',
                    shouldClose = false
                },
                {
                    id = 'radiofreq3',
                    title = '3',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 3',
                    shouldClose = false
                },
                {
                    id = 'radiofreq4',
                    title = '4',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 4',
                    shouldClose = false
                },
                {
                    id = 'radiofreq5',
                    title = '5',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 5',
                    shouldClose = false
                },
                {
                    id = 'radiofreq6',
                    title = '6',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 6',
                    shouldClose = false
                },
                {
                    id = 'radiofreq7',
                    title = '7',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 7',
                    shouldClose = false
                },
                {
                    id = 'radiofreq8',
                    title = '8',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 8',
                    shouldClose = false
                },
                {
                    id = 'radiofreq9',
                    title = '9',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 9',
                    shouldClose = false
                },
            }
        }, {
         id = 'safestash',
            title = 'Gun Rack',
            icon = '#job',
            functiontype = 'client',
            functionName = 'police:client:openstashSafe',
            shouldClose = true
        }, {
            id = 'getkey',
            title = 'Get Key',
            icon = '#givekey',
            functiontype = 'client',
            functionName = 'police:client:getkey',
            shouldClose = true
        }, {
            id = 'policeobjects',
            title = 'Objects',
            icon = '#object',
            items = {
                {
                    id = 'spawnpion',
                    title = 'Cone',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnCone',
                    shouldClose = false
                }, {
                    id = 'spawnpionred',
                    title = 'Red Cone',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnRedCone',
                    shouldClose = false
                },  {
                    id = 'spawnpionblue',
                    title = 'Blue Cone',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnBlueCone',
                    shouldClose = false
                }, {
                    id = 'spawnhek',
                    title = 'Barrier',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnBarrier',
                    shouldClose = false
                }, {
                    id = 'spawnschotten',
                    title = 'Road Closed',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnRoadSign',
                    shouldClose = false
                },  {
                    id = 'spawnscreen',
                    title = 'Screen',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnScreen',
                    shouldClose = false
                },  {
                    id = 'spawntent',
                    title = 'Tent',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnTent',
                    shouldClose = false
                }, {
                    id = 'spawnverlichting',
                    title = 'Lighting',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnLight',
                    shouldClose = false
                },  {
                    id = 'ascene',
                    title = 'A Marker',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnAscene',
                    shouldClose = false
                },  {
                    id = 'bscene',
                    title = 'B Marker',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnBscene',
                    shouldClose = false
                },  {
                    id = 'cscene',
                    title = 'C Marker',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnCscene',
                    shouldClose = false
                }, 
                {
                    id = 'deleteobject',
                    title = 'Remove object',
                    icon = '#delete',
                    functiontype = 'client',
                    functionName = 'police:client:deleteObject',
                    shouldClose = false
                }
            },
        }, {
            id = 'mdt',
            title = 'MDT',
            icon = '#mdw',
            functiontype = 'command',
            functionName = 'mdt',
            shouldClose = true
        },
        {
            id = 'checkvin',
            title = 'Check VIN',
            icon = '#enkelband',
            type = 'client',
            event = 'qb-police:client:checkvin',
            shouldClose = true
        }
    },
    ["goverment"] = {
        {
            id = 'joblist',
            title = 'Jobs List',
            icon = '#list',
            functiontype = 'client',
            functionName = 'qb-joblist:client:showmenu',
            shouldClose = false
        },
        {
            id = 'panicbut',
            title = 'Panic Alert',
            icon = '#panic',
            functiontype = 'client',
            functionName = 'qb-dispatch:client:panic',
            shouldClose = true
        },
        {
            id = 'radiochannel',
            title = 'Radio',
            icon = '#wifi',
            items = {
                {
                    id = 'radiofreq1',
                    title = '1',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 1',
                    shouldClose = false
                },
                {
                    id = 'radiofreq2',
                    title = '2',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 2',
                    shouldClose = false
                },
                {
                    id = 'radiofreq3',
                    title = '3',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 3',
                    shouldClose = false
                },
                {
                    id = 'radiofreq4',
                    title = '4',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 4',
                    shouldClose = false
                },
                {
                    id = 'radiofreq5',
                    title = '5',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 5',
                    shouldClose = false
                },
                {
                    id = 'radiofreq6',
                    title = '6',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 6',
                    shouldClose = false
                },
                {
                    id = 'radiofreq7',
                    title = '7',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 7',
                    shouldClose = false
                },
                {
                    id = 'radiofreq8',
                    title = '8',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 8',
                    shouldClose = false
                },
                {
                    id = 'radiofreq9',
                    title = '9',
                    icon = '#wifi',
                    functiontype = 'command',
                    functionName = 'rjoin 9',
                    shouldClose = false
                },
            }
        },
        {
            id = 'policeobjects',
            title = 'Objects',
            icon = '#object',
            items = {
                {
                    id = 'spawnpion',
                    title = 'Cone',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnCone',
                    shouldClose = false
                }, {
                    id = 'spawnpionred',
                    title = 'Red Cone',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnRedCone',
                    shouldClose = false
                },  {
                    id = 'spawnpionblue',
                    title = 'Blue Cone',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnBlueCone',
                    shouldClose = false
                }, {
                    id = 'spawnhek',
                    title = 'Barrier',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnBarrier',
                    shouldClose = false
                }, {
                    id = 'spawnschotten',
                    title = 'Road Closed',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnRoadSign',
                    shouldClose = false
                },  {
                    id = 'spawnscreen',
                    title = 'Screen',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnScreen',
                    shouldClose = false
                },  {
                    id = 'spawntent',
                    title = 'Tent',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnTent',
                    shouldClose = false
                }, {
                    id = 'spawnverlichting',
                    title = 'Lighting',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnLight',
                    shouldClose = false
                },  {
                    id = 'ascene',
                    title = 'A Marker',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnAscene',
                    shouldClose = false
                },  {
                    id = 'bscene',
                    title = 'B Marker',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnBscene',
                    shouldClose = false
                },  {
                    id = 'cscene',
                    title = 'C Marker',
                    icon = '#object',
                    functiontype = 'client',
                    functionName = 'police:client:spawnCscene',
                    shouldClose = false
                }, 
                {
                    id = 'deleteobject',
                    title = 'Remove object',
                    icon = '#delete',
                    functiontype = 'client',
                    functionName = 'police:client:deleteObject',
                    shouldClose = false
                },
            },
        }
    },
}

Config.TrunkClasses = {
    [0] = {allowed = true, x = 0.0, y = -1.5, z = 0.0}, -- Coupes
    [1] = {allowed = true, x = 0.0, y = -2.0, z = 0.0}, -- Sedans
    [2] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- SUVs
    [3] = {allowed = true, x = 0.0, y = -1.5, z = 0.0}, -- Coupes
    [4] = {allowed = true, x = 0.0, y = -2.0, z = 0.0}, -- Muscle
    [5] = {allowed = true, x = 0.0, y = -2.0, z = 0.0}, -- Sports Classics
    [6] = {allowed = true, x = 0.0, y = -2.0, z = 0.0}, -- Sports
    [7] = {allowed = true, x = 0.0, y = -2.0, z = 0.0}, -- Super
    [8] = {allowed = false, x = 0.0, y = -1.0, z = 0.25}, -- Motorcycles
    [9] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Off-road
    [10] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Industrial
    [11] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Utility
    [12] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Vans
    [13] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Cycles
    [14] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Boats
    [15] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Helicopters
    [16] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Planes
    [17] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Service
    [18] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Emergency
    [19] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Military
    [20] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Commercial
    [21] = {allowed = true, x = 0.0, y = -1.0, z = 0.25} -- Trains
}