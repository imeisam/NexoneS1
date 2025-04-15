local QBCore = exports['qb-core']:GetCoreObject()
local isLoaded = false

-- Function to shutdown loading screen
local function ShutdownLoad()
    if not isLoaded then
        isLoaded = true
        DoScreenFadeIn(1000)
        ShutdownLoadingScreen()
        ShutdownLoadingScreenNui()
    end
end

-- Event handler for when player is loaded
RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    ShutdownLoad()
end)

-- Event handler for spawn manager
AddEventHandler('playerSpawned', function()
    ShutdownLoad()
end)

-- Event handler for base events
AddEventHandler('onClientGameTypeStart', function()
    ShutdownLoad()
end)

-- Wait for the game to be fully loaded
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        
        local players = GetActivePlayers()
        if #players > 0 then
            if not isLoaded then
                isLoaded = true
                ShutdownLoadingScreen()
                ShutdownLoadingScreenNui()
                break
            end
        end
    end
end)

-- Handle loading screen progress
Citizen.CreateThread(function()
    local startTime = GetGameTimer()
    local loadingStages = {0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0}
    local currentStage = 1

    while not isLoaded do
        Citizen.Wait(50)
        
        -- Calculate progress based on time elapsed
        local currentTime = GetGameTimer()
        local timeDiff = currentTime - startTime
        
        if currentStage <= #loadingStages and timeDiff > (currentStage * 1000) then
            SendLoadingScreenMessage({
                eventName = 'loadProgress',
                loadFraction = loadingStages[currentStage]
            })
            currentStage = currentStage + 1
        end
    end
end)

-- Backup timer to force shutdown
Citizen.CreateThread(function()
    Citizen.Wait(Config.LoadingScreenDuration)
    if not isLoaded then
        ShutdownLoad()
    end
end) 