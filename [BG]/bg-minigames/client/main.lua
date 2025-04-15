local QBCore = exports['qb-core']:GetCoreObject()
local isPlaying = false
local lastAttempt = 0

-- Function to start the minigame
function StartMinigame(difficulty)
    if isPlaying then return end
    if (GetGameTimer() - lastAttempt) < (Config.Cooldown * 60000) then
        QBCore.Functions.Notify('You need to wait before trying again!', 'error')
        return
    end

    isPlaying = true
    lastAttempt = GetGameTimer()
    
    -- Send to UI
    SendNUIMessage({
        action = "startMinigame",
        difficulty = difficulty,
        time = Config.Difficulty[difficulty].time
    })
    SetNuiFocus(true, true)
end

-- NUI Callbacks
RegisterNUICallback('minigameResult', function(data, cb)
    SetNuiFocus(false, false)
    isPlaying = false
    
    if data.success then
        TriggerServerEvent('minigame:reward', data.difficulty)
    else
        QBCore.Functions.Notify('You failed!', 'error')
    end
    
    cb('ok')
end)

-- Example command to test the minigame
RegisterCommand('bgtestminigame', function(source, args)
    local difficulty = args[1] or 'Easy'
    if Config.Difficulty[difficulty] then
        StartMinigame(difficulty)
    else
        QBCore.Functions.Notify('Invalid difficulty! Use Easy, Medium, or Hard', 'error')
    end
end) 