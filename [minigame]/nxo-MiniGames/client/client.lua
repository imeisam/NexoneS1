local hasresult=false
local result =false

function samehack(gridx,gridy,time)
    SetNuiFocus(true, true)
    SendNUIMessage({
            action= 'skillchecks:settings',
            data= {
                active= 'same',
                show= true,
                name= 'same',
                description= 'This is the same',
                gameTimeoutDuration=time,-- 30000,
    
                gridSizeX=gridx,-- 11,
                gridSizeY= gridy,--8,
            }
        })
        hasresult=false
    while not hasresult do
        Wait(5)
    end
    return result
end
exports("samehack",samehack)

function lockpicking(lock,level,time)
        SetNuiFocus(true, true)
        SendNUIMessage({
                action= 'skillchecks:settings',
                data= {
                    active= 'lockpicking',
                    show= true,
                    name= 'lockpicking',
                    description='This is the lockpicking',
                    gameTimeoutDuration= time,--20000,
                    numLocks=lock,-- 12,
                    numLevels= level,--4,
                }
            })
            hasresult=false
        while not hasresult do
            Wait(5)
        end
        return result
end
exports("lockpicking",lockpicking)

function alphabet(numkey,time)
    SetNuiFocus(true, true)
    SendNUIMessage({
            action= 'skillchecks:settings',
            data= {
                active= 'alphabet',
                show= true,
                name= 'Alphabet',
                description= 'This is the alphabet',
                gameTimeoutDuration= time,--10000,
                numKeys=numkey,-- 20,
            }
        })
        hasresult=false
    while not hasresult do
        Wait(5)
    end
    return result
end
exports("alphabet",alphabet)


function untangle(numpoint,time)
    SetNuiFocus(true, true)
    SendNUIMessage({
            action= 'skillchecks:settings',
            data= {
                active= 'untangle',
                show= true,
                name= 'untangle',
                description= 'This is the untangle',
                gameTimeoutDuration=time,-- 30000,
                numPoints =numpoint,-- 10,
            }
        })
        hasresult=false
    while not hasresult do
        Wait(5)
    end
    return result
end
exports("untangle",untangle)

function words(correction,time)
    SetNuiFocus(true, true)
    SendNUIMessage({
            action= 'skillchecks:settings',
            data= {
                active= 'words',
                show= true,
                name= 'words',
                description= 'This is the words',
                gameTimeoutDuration= time,--30000,
                requiredCorrectChoices = correction,--5,
            }
        })
        hasresult=false
    while not hasresult do
        Wait(5)
    end
    return result
end
exports("words",words)

RegisterNUICallback("skillchecks:minigameResult",function (data, cb) 
    SetNuiFocus(false, false)
    result=data.result
    if LocalPlayer.state.isSmart then
        result = true
    end
    hasresult=true
    cb("ok")
end)
