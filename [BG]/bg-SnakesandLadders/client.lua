local QBCore = exports['qb-core']:GetCoreObject()
local diceText = {}
local canRollDice = false
local isInGame = false
local currentHost = nil
local gameStarted = false
local isMyTurn = false
local turnIndicator = nil
local isPlayerMoving = false


local isRollCooldown = false

local boardPositions = {
    vector3(-1725.54, 159.08, 64.55), 
    vector3(-1726.98, 157.91, 64.55),
    vector3(-1728.34, 156.83, 64.55),
    vector3(-1729.87, 155.8, 64.55),
    vector3(-1731.41, 154.58, 64.55),
    vector3(-1733.04, 153.51, 64.55),
    vector3(-1734.48, 152.36, 64.55),
    vector3(-1736.02, 151.34, 64.55),
    vector3(-1737.7, 150.22, 64.55),
    vector3(-1739.13, 149.36, 64.55),
    vector3(-1737.97, 147.83, 64.55),
    vector3(-1736.53, 148.87, 64.55),
    vector3(-1735.09, 150.02, 64.55),
    vector3(-1733.59, 150.98, 64.55),
    vector3(-1731.9, 151.94, 64.55),
    vector3(-1730.38, 153.16, 64.55),
    vector3(-1728.84, 154.3, 64.55),
    vector3(-1727.45, 155.35, 64.55),
    vector3(-1725.9, 156.48, 64.55),
    vector3(-1724.33, 157.51, 64.55),
    vector3(-1723.24, 155.95, 64.55),
    vector3(-1724.78, 154.79, 64.55),
    vector3(-1726.28, 153.76, 64.55),
    vector3(-1727.86, 152.62, 64.55),
    vector3(-1729.41, 151.62, 64.55),
    vector3(-1730.9, 150.5, 64.55),
    vector3(-1732.4, 149.45, 64.55),
    vector3(-1733.88, 148.41, 64.55),
    vector3(-1735.51, 147.2, 64.55),
    vector3(-1736.98, 146.14, 64.55),
    vector3(-1735.9, 144.64, 64.55),
    vector3(-1734.48, 145.71, 64.55),
    vector3(-1732.92, 147.01, 64.55),
    vector3(-1731.43, 147.91, 64.55),
    vector3(-1729.81, 148.99, 64.55),
    vector3(-1728.26, 149.95, 64.55),
    vector3(-1726.81, 151.2, 64.55),
    vector3(-1725.3, 152.21, 64.55),
    vector3(-1723.62, 153.43, 64.55),
    vector3(-1722.26, 154.43, 64.55),
    vector3(-1721.17, 152.92, 64.55),
    vector3(-1722.67, 151.77, 64.55),
    vector3(-1724.21, 150.66, 64.55),
    vector3(-1725.71, 149.65, 64.55),
    vector3(-1727.2, 148.55, 64.55),
    vector3(-1728.69, 147.4, 64.55),
    vector3(-1730.24, 146.57, 64.55),
    vector3(-1731.85, 145.44, 64.55),
    vector3(-1733.4, 144.27, 64.55),
    vector3(-1734.79, 143.31, 64.55),
    vector3(-1733.78, 141.86, 64.55),
    vector3(-1732.38, 142.79, 64.55),
    vector3(-1730.73, 143.9, 64.55),
    vector3(-1729.23, 144.82, 64.55),
    vector3(-1727.63, 145.88, 64.55),
    vector3(-1726.06, 146.98, 64.55),
    vector3(-1724.52, 148.13, 64.55),
    vector3(-1722.98, 149.15, 64.55),
    vector3(-1721.48, 150.19, 64.55),
    vector3(-1720.06, 151.27, 64.55),
    vector3(-1719.01, 149.85, 64.55),
    vector3(-1720.44, 148.69, 64.55),
    vector3(-1721.99, 147.66, 64.55),
    vector3(-1723.49, 146.56, 64.55),
    vector3(-1725.11, 145.49, 64.55),
    vector3(-1726.57, 144.41, 64.55),
    vector3(-1728.12, 143.37, 64.55),
    vector3(-1729.68, 142.35, 64.55),
    vector3(-1731.17, 141.2, 64.55),
    vector3(-1732.68, 140.1, 64.55),
    vector3(-1731.54, 138.66, 64.55),
    vector3(-1730.25, 139.71, 64.55),
    vector3(-1728.59, 140.85, 64.55),
    vector3(-1727.03, 141.91, 64.55),
    vector3(-1725.5, 142.9, 64.55),
    vector3(-1724.0, 143.97, 64.55),
    vector3(-1722.41, 145.01, 64.55),
    vector3(-1720.89, 146.01, 64.55),
    vector3(-1719.4, 147.21, 64.55),
    vector3(-1717.8, 148.28, 64.55),
    vector3(-1716.91, 147.06, 64.55),
    vector3(-1718.29, 145.63, 64.55),
    vector3(-1719.95, 144.5, 64.55),
    vector3(-1721.34, 143.59, 64.55),
    vector3(-1722.89, 142.37, 64.55),
    vector3(-1724.45, 141.43, 64.55),
    vector3(-1726.16, 140.21, 64.55),
    vector3(-1727.49, 139.15, 64.55),
    vector3(-1729.05, 138.19, 64.55),
    vector3(-1730.6, 137.06, 64.55),
    vector3(-1729.47, 135.59, 64.55),
    vector3(-1727.99, 136.59, 64.55),
    vector3(-1726.46, 137.87, 64.55),
    vector3(-1725.03, 138.85, 64.55),
    vector3(-1723.36, 140.05, 64.55),
    vector3(-1721.98, 140.95, 64.55),
    vector3(-1720.36, 142.12, 64.55),
    vector3(-1718.8, 143.05, 64.55),    
    vector3(-1717.37, 144.35, 64.55),
    vector3(-1715.89, 145.23, 64.55),
}

local snakesAndLadders = {
    { start = 2, endPos = 38 },  
    { start = 8, endPos = 31 },  
    { start = 7, endPos = 14 },  
    { start = 15, endPos = 26 },  
    { start = 16, endPos = 6 }, 
    { start = 21, endPos = 42 }, 
    { start = 28, endPos = 84 }, 
    { start = 36, endPos = 44 }, 
    { start = 46, endPos = 25 }, 
    { start = 49, endPos = 11 }, 
    { start = 51, endPos = 67 }, 
    { start = 62, endPos = 19 }, 
    { start = 64, endPos = 60 }, 
    { start = 74, endPos = 53 }, 
    { start = 78, endPos = 98 }, 
    { start = 71, endPos = 91 }, 
    { start = 78, endPos = 94 }, 
    { start = 89, endPos = 68 }, 
    { start = 92, endPos = 88 }, 
    { start = 95, endPos = 75 }, 
    { start = 87, endPos = 94 }, 
    { start = 99, endPos = 80 }, 
}

local particleDicts = {
    snake = "core",
    ladder = "core",
    dice = "core"
}

local particleNames = {
    snake = "exp_grd_flame_lod",
    ladder = "exp_grd_flame_lod",
    dice = "exp_grd_flame_lod"
}

local soundEffects = {
    snake = "Lose_1st", "GTAO_FM_Events_Soundset",
    ladder = "Win_1st", "GTAO_FM_Events_Soundset",
    dice = "DICE_ROLL", "HUD_AWARDS"
}


function PlayParticleEffect(dict, name, coords, duration)
    RequestNamedPtfxAsset(dict)
    while not HasNamedPtfxAssetLoaded(dict) do
        Wait(10)
    end
    
    UseParticleFxAssetNextCall(dict)
    local particle = StartParticleFxLoopedAtCoord(name, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    SetParticleFxLoopedAlpha(particle, 0.8)
    SetParticleFxLoopedColour(particle, 1.0, 1.0, 1.0, 0)
    
    SetTimeout(duration, function()
        StopParticleFxLooped(particle, 0)
        RemoveParticleFx(particle, 0)
        RemoveNamedPtfxAsset(dict)
    end)
end


function PlaySoundEffect(soundName, soundSet)
    if soundName == "DICE_ROLL" then
        TriggerEvent("InteractSound_CL:PlayOnOne", "dice", 0.4)
    elseif soundName == "Lose_1st" then
        TriggerEvent("InteractSound_CL:PlayOnOne", "snake", 0.4)
    elseif soundName == "Win_1st" then
        TriggerEvent("InteractSound_CL:PlayOnOne", "ladder", 0.4)
    else
        PlaySoundFrontend(-1, soundName, soundSet, true)
    end
end


function ShowDiceRollAbovePlayer(playerId, number)
    diceText[playerId] = number

    SetTimeout(3000, function()
        diceText[playerId] = nil
    end)
end


CreateThread(function()
    while true do
        Wait(0)
        for playerId, number in pairs(diceText) do
            local ped = GetPlayerPed(GetPlayerFromServerId(playerId))
            if DoesEntityExist(ped) then
                local coords = GetEntityCoords(ped) + vector3(0, 0, 1.1)
                local playerCoords = GetEntityCoords(PlayerPedId())
                local distance = #(coords - playerCoords)
                
    
                if distance < 30.0 then

                    DrawRect(coords.x, coords.y + 0.02, 0.15, 0.05, 0, 0, 0, 150)

                    DrawRect(coords.x, coords.y + 0.02, 0.15, 0.002, 255, 255, 255, 255)
                    DrawRect(coords.x, coords.y + 0.02, 0.15, 0.002, 255, 255, 255, 255)
                    DrawRect(coords.x - 0.075, coords.y + 0.02, 0.002, 0.05, 255, 255, 255, 255)
                    DrawRect(coords.x + 0.075, coords.y + 0.02, 0.002, 0.05, 255, 255, 255, 255)
                    

                    DrawText3D(coords.x, coords.y, coords.z, "🎲 " .. number .. "/6")
                end
            end
        end
    end
end)


function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end


CreateThread(function()
    while true do
        Wait(0)
        if canRollDice and isMyTurn and isInGame and not isRollCooldown then
            if IsControlJustReleased(0, 38) then 
                isRollCooldown = true 
                RollDice()
            end
        end
    end
end)

local lastValidPositionIndex = 1 


function GetClosestBoardIndex()
    local playerPos = GetEntityCoords(PlayerPedId())
    local closestIndex = 1
    local closestDist = #(playerPos - boardPositions[1])

    for i = 2, #boardPositions do
        local dist = #(playerPos - boardPositions[i])
        if dist < closestDist then
            closestIndex = i
            closestDist = dist
        end
    end

    return closestIndex
end


function MovePlayer(steps)
    local player = PlayerPedId()
    isPlayerMoving = true 

    
    if lastValidPositionIndex == nil then
        lastValidPositionIndex = GetClosestBoardIndex()
    end

    local nextIndex = lastValidPositionIndex + steps

    
    if nextIndex > 100 then
        QBCore.Functions.Notify("❌ You need the exact number to reach 100!", "error")
        
        RequestAnimDict("anim@mp_player_intselfiewank")
        while not HasAnimDictLoaded("anim@mp_player_intselfiewank") do
            Wait(100)
        end
        TaskPlayAnim(player, "anim@mp_player_intselfiewank", "idle_a", 8.0, -8, 1500, 49, 0, false, false, false)
        isPlayerMoving = false 
        return 
    end

    local targetPos = boardPositions[nextIndex]

    PlayDiceAnimation()

    SetTimeout(1000, function()
        
        local moveSpeed = 1.0
        
        local stopDistance = 0.5
        
        
        TaskGoStraightToCoord(player, targetPos.x, targetPos.y, targetPos.z, moveSpeed, -1, 0.0, stopDistance)

        
        CreateThread(function()
            while true do
                Wait(100)
                local playerCoords = GetEntityCoords(player)
                local distance = #(playerCoords - targetPos)
                
                
                if distance < stopDistance then
                    ClearPedTasks(player)

                    
                    for _, v in pairs(snakesAndLadders) do
                        if v.start == nextIndex then
                            local newIndex = v.endPos
                            local newPos = boardPositions[newIndex]

                            if newIndex > nextIndex then
                                QBCore.Functions.Notify("⬆️ You landed on a Ladder! Moving to tile " .. newIndex .. "!", "success")
                                
                                TriggerEvent("InteractSound_CL:PlayOnOne", "ladder", 0.4)
                                
                                PlayParticleEffect(particleDicts.ladder, particleNames.ladder, playerCoords, 2000)
                            else
                                QBCore.Functions.Notify("⬇️ You landed on a Snake! Moving to tile " .. newIndex .. "!", "error")
                                
                                TriggerEvent("InteractSound_CL:PlayOnOne", "snake", 0.4)
                                
                                PlayParticleEffect(particleDicts.snake, particleNames.snake, playerCoords, 2000)
                            end
                            
                            
                            TaskGoStraightToCoord(player, newPos.x, newPos.y, newPos.z, moveSpeed, -1, 0.0, stopDistance)
                            
                            
                            CreateThread(function()
                                while true do
                                    Wait(100)
                                    local playerCoords = GetEntityCoords(player)
                                    local distance = #(playerCoords - newPos)
                                    
                                    if distance < stopDistance then
                                        ClearPedTasks(player)
                                        lastValidPositionIndex = newIndex
                                        canRollDice = true
                                        
                                        TriggerServerEvent('bg-SnakesandLadders:server:UpdatePosition', newIndex)
                                        
                                        RequestAnimDict("perlenfuchs@ballerina_1")
                                        while not HasAnimDictLoaded("perlenfuchs@ballerina_1") do
                                            Wait(100)
                                        end
                                        TaskPlayAnim(player, "perlenfuchs@ballerina_1", "perlenfuchs@ballerina_1", 8.0, -8, -1, 1, 0, false, false, false)
                                        QBCore.Functions.Notify("🎲 Press [E] to roll the dice.", "primary")
                                        isPlayerMoving = false 
                                        return
                                    end
                                end
                            end)
                            return
                        end
                    end

                    QBCore.Functions.Notify("🚶 You moved to tile " .. nextIndex .. "!", "success")
                    lastValidPositionIndex = nextIndex
                    canRollDice = true
                    
                    TriggerServerEvent('bg-SnakesandLadders:server:UpdatePosition', nextIndex)

                    
                    if nextIndex == 100 then
                        QBCore.Functions.Notify("🏆 Congratulations! You've reached the finish line!", "success")
                        
                        TriggerServerEvent('bg-SnakesandLadders:server:GameEnd', GetPlayerServerId(PlayerId()))
                    else
                        
                        RequestAnimDict("perlenfuchs@ballerina_1")
                        while not HasAnimDictLoaded("perlenfuchs@ballerina_1") do
                            Wait(100)
                        end
                        TaskPlayAnim(player, "perlenfuchs@ballerina_1", "perlenfuchs@ballerina_1", 8.0, -8, -1, 1, 0, false, false, false)
                        QBCore.Functions.Notify("🎲 Press [E] to roll the dice.", "primary")
                    end

                    isPlayerMoving = false 
                    return
                end
            end
        end)
    end)
end


function ShowTurnIndicator()
    if turnIndicator then
        turnIndicator = nil
    end
    
    
    local turnColors = {
        {r = 255, g = 0, b = 128},   
        {r = 255, g = 0, b = 255},   
        {r = 128, g = 0, b = 255},   
        {r = 0, g = 128, b = 255},   
        {r = 0, g = 255, b = 255},   
        {r = 0, g = 255, b = 128},   
        {r = 255, g = 255, b = 0},   
        {r = 255, g = 128, b = 0}    
    }
    
    local colorIndex = 1
    local lastColorChange = 0
    local colorInterval = 100 
    
    turnIndicator = CreateThread(function()
        while isMyTurn do
            Wait(0)
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            
            
            local currentTime = GetGameTimer()
            if currentTime - lastColorChange >= colorInterval then
                colorIndex = colorIndex + 1
                if colorIndex > #turnColors then
                    colorIndex = 1
                end
                lastColorChange = currentTime
            end
            
            
            local pulse = math.abs(math.sin(GetGameTimer() / 200)) * 0.3 + 0.7
            local color = turnColors[colorIndex]
            local r = math.floor(color.r * pulse)
            local g = math.floor(color.g * pulse)
            local b = math.floor(color.b * pulse)
            
            
            for i = -1, 1 do
                for j = -1, 1 do
                    if i ~= 0 or j ~= 0 then
                        SetTextScale(0.5, 0.5)
                        SetTextFont(4)
                        SetTextProportional(1)
                        SetTextColour(0, 0, 0, 200)
                        SetTextEntry("STRING")
                        SetTextCentre(1)
                        AddTextComponentString("🎲 YOUR TURN! 🎲")
                        SetDrawOrigin(coords.x, coords.y, coords.z + 1.0, 0)
                        DrawText(i * 0.001, j * 0.001)
                        ClearDrawOrigin()
                    end
                end
            end
            
            
            SetTextScale(0.5, 0.5)
            SetTextFont(4)
            SetTextProportional(1)
            SetTextColour(r, g, b, 255)
            SetTextEntry("STRING")
            SetTextCentre(1)
            AddTextComponentString("🎲 YOUR TURN! 🎲")
            SetDrawOrigin(coords.x, coords.y, coords.z + 1.0, 0)
            DrawText(0.0, 0.0)
            ClearDrawOrigin()
        end
    end)
end


RegisterNetEvent('bg-SnakesandLadders:client:YourTurn', function()
    isMyTurn = true
    canRollDice = true
    ShowTurnIndicator()
    QBCore.Functions.Notify("🎲 It's your turn! Press [E] to roll the dice.", "primary")
    PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
end)


RegisterNetEvent("bg-SnakesandLadders:client:ShowDiceRoll", function(playerId, number)
    ShowDiceRollAbovePlayer(playerId, number)
    
    
    if playerId == GetPlayerServerId(PlayerId()) then
        PlayDiceAnimation()
        SetTimeout(1500, function()
            MovePlayer(number)
        end)
    end
end)


function GetClosestBoardIndex(playerPos)
    local closestIndex = 1
    local minDist = 99999.0

    for i, pos in ipairs(boardPositions) do
        local dist = #(playerPos - pos)
        if dist < minDist then
            minDist = dist
            closestIndex = i
        end
    end

    return closestIndex
end

RegisterNetEvent("qb_snakesladders:showDiceRoll", function(playerId, number)
    ShowDiceRollAbovePlayer(playerId, number)
end)


function PlayDiceAnimation()
    local player = PlayerPedId()
    local coords = GetEntityCoords(player)
    
    
    TriggerEvent("InteractSound_CL:PlayOnOne", "dice", 0.4)
    
    
    PlayParticleEffect(particleDicts.dice, particleNames.dice, coords, 1000)
    
    RequestAnimDict("anim@mp_player_intselfiewank")
    while not HasAnimDictLoaded("anim@mp_player_intselfiewank") do
        Wait(100)
    end
    TaskPlayAnim(player, "anim@mp_player_intselfiewank", "idle_a", 8.0, -8, 1500, 49, 0, false, false, false)
end
local startPed = nil
local pedModel = "a_m_m_business_01" 
local pedCoords = vector4(-1724.76, 163.33, 64.66, 126.19)


CreateThread(function()
    Wait(5000) 
    SpawnStartPed()
end)


function SpawnStartPed()
    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do
        Wait(100)
    end

    startPed = CreatePed(4, pedModel, pedCoords.x, pedCoords.y, pedCoords.z - 1.0, 0.0, false, true)
    SetEntityInvincible(startPed, true)
    SetBlockingOfNonTemporaryEvents(startPed, true)
    FreezeEntityPosition(startPed, true)

    
    exports['qb-target']:AddTargetEntity(startPed, {
        options = {
            {
                label = "🎲 Snakes & Ladders Menu",
                icon = "fas fa-play",
                action = function()
                    OpenGameMenu()
                end
            }
        },
        distance = 2.5
    })
end


function IsHost()
    local playerServerId = GetPlayerServerId(PlayerId())
    return currentHost ~= nil and currentHost == playerServerId
end


function OpenGameMenu()
    
    local elements = {
        {
            header = "🎲 Snakes & Ladders Menu",
            isMenuHeader = true
        }
    }

    
    if currentHost then
        if IsHost() then
            
            table.insert(elements, {
                header = "👥 Player Slots",
                txt = "Current players in the game",
                isMenuHeader = true
            })
            
            
            TriggerServerEvent('bg-SnakesandLadders:server:RequestPlayerSlots')
        end
        
        table.insert(elements, {
            header = "Leave Game",
            txt = "Leave the current game session",
            params = {
                event = "bg-SnakesandLadders:client:LeaveHost"
            }
        })
    else
        
        table.insert(elements, {
            header = "Create Host",
            txt = "Create a new game session",
            params = {
                event = "bg-SnakesandLadders:client:CreateHost"
            }
        })
        
        table.insert(elements, {
            header = "Join Host",
            txt = "Join an existing game session",
            params = {
                event = "bg-SnakesandLadders:client:JoinHost"
            }
        })
    end

    exports['qb-menu']:openMenu(elements)
end


RegisterNetEvent('bg-SnakesandLadders:client:CreateHost', function()
    TriggerServerEvent('bg-SnakesandLadders:server:CreateHost')
end)


RegisterNetEvent('bg-SnakesandLadders:client:JoinHost', function()
    TriggerServerEvent('bg-SnakesandLadders:server:GetHosts')
end)


RegisterNetEvent('bg-SnakesandLadders:client:ReceiveHosts', function(hosts)
    local elements = {
        {
            header = "🎲 Available Hosts",
            isMenuHeader = true
        }
    }
    
    for hostId, hostData in pairs(hosts) do
        table.insert(elements, {
            header = "Host #" .. hostId,
            txt = "Players: " .. #hostData.players,
            params = {
                event = "bg-SnakesandLadders:client:JoinSpecificHost",
                args = {
                    hostId = hostId
                }
            }
        })
    end
    
    
    table.insert(elements, {
        header = "Back",
        txt = "Return to main menu",
        params = {
            event = "bg-SnakesandLadders:client:OpenMainMenu"
        }
    })
    
    exports['qb-menu']:openMenu(elements)
end)


RegisterNetEvent('bg-SnakesandLadders:client:JoinSpecificHost', function(data)
    TriggerServerEvent('bg-SnakesandLadders:server:JoinHost', data.hostId)
end)


RegisterNetEvent('bg-SnakesandLadders:client:JoinedHost', function(hostId)
    currentHost = hostId
    QBCore.Functions.Notify("Successfully joined host #" .. hostId, "success")
    Wait(100)
    OpenGameMenu()
end)


RegisterNetEvent('bg-SnakesandLadders:client:OpenMainMenu', function()
    OpenGameMenu()
end)


function StartGame()
    local player = PlayerPedId()
    SetEntityCoords(player, boardPositions[1].x, boardPositions[1].y, boardPositions[1].z)
    QBCore.Functions.Notify("🎲 Game started! Press [E] to roll the dice.", "primary")
    canRollDice = true
    isInGame = true
    lastValidPositionIndex = 1 
end


RegisterNetEvent('bg-SnakesandLadders:client:GameStarted', function()
    gameStarted = true
    StartGame()
end)


RegisterNetEvent('bg-SnakesandLadders:client:LeaveHost', function()
    if currentHost then
        TriggerServerEvent('bg-SnakesandLadders:server:LeaveHost')
        currentHost = nil
        gameStarted = false
        isInGame = false
        canRollDice = false
        lastValidPositionIndex = 1
        isMyTurn = false 
        if turnIndicator then
            turnIndicator = nil
        end
        
        diceText = {}
        QBCore.Functions.Notify("You have left the game", "error")
        SetEntityCoords(PlayerPedId(), pedCoords.x, pedCoords.y, pedCoords.z)
        OpenGameMenu()
        isRollCooldown = false 
    end
end)


local podiumPositions = {
    vector4(-1721.0, 138.07, 64.66, 34.18), 
    vector4(-1719.92, 138.83, 64.66, 35.25), 
    vector4(-1722.23, 137.15, 64.66, 33.93), 
}

local spectatorPositions = {
    vector4(-1723.63, 141.07, 64.55, 211.35),
    vector4(-1722.31, 142.03, 64.55, 211.5),
    vector4(-1721.07, 143.11, 64.55, 209.74),
    vector4(-1723.91, 143.44, 64.55, 213.54),
    vector4(-1725.44, 142.43, 64.55, 212.32),
}


local winnerAnimations = {
    first = {dict = "divined@tdances@new", anim = "dtdance21"},
    second = {dict = "anim@arena@celeb@flat@solo@no_props@", anim = "angry_clap_a_player_a"},
    third = {dict = "anim@mp_player_intupperface_palm", anim = "idle_a"},
    spectator = {dict = "amb@world_human_cheering@male_a", anim = "base"}
}


function PlayWinnerAnimation(ped, position, particleDict, particleName)
    local selectedAnim
    
    if position == 1 then
        selectedAnim = winnerAnimations.first
        
        CreateThread(function()
            while isInGame do
                PlayParticleEffect(particleDict, particleName, GetEntityCoords(ped), 1000)
                Wait(1000)
            end
        end)
    elseif position == 2 then
        selectedAnim = winnerAnimations.second
        
        CreateThread(function()
            while isInGame do
                PlayParticleEffect(particleDict, particleName, GetEntityCoords(ped), 1000)
                Wait(1500)
            end
        end)
    elseif position == 3 then
        selectedAnim = winnerAnimations.third
        
        CreateThread(function()
            while isInGame do
                PlayParticleEffect(particleDict, particleName, GetEntityCoords(ped), 1000)
                Wait(2000)
            end
        end)
    else
        selectedAnim = winnerAnimations.spectator
    end
    
    
    RequestAnimDict(selectedAnim.dict)
    while not HasAnimDictLoaded(selectedAnim.dict) do
        Wait(100)
    end
    
    
    
    
    
    
    TaskPlayAnim(ped, selectedAnim.dict, selectedAnim.anim, 8.0, -8.0, -1, 51, 0, false, false, false)
    RemoveAnimDict(selectedAnim.dict)
end


RegisterNetEvent('bg-SnakesandLadders:client:GameEnd', function(topPlayers)
    local player = PlayerPedId()
    local playerServerId = GetPlayerServerId(PlayerId())
    local isTopPlayer = false
    local playerPosition = nil
    local coords = GetEntityCoords(player)
    
    if topPlayers then
        for i, topPlayer in ipairs(topPlayers) do
            if topPlayer and topPlayer.id == playerServerId then
                isTopPlayer = true
                playerPosition = i
                break
            end
        end
    end
    
    if isTopPlayer then
        SetEntityCoords(player, podiumPositions[playerPosition].x, podiumPositions[playerPosition].y, podiumPositions[playerPosition].z)
        SetEntityHeading(player, podiumPositions[playerPosition].w)
        
        Wait(500) 
        
        
        if playerPosition == 1 then
            PlayWinnerAnimation(player, 1, "core", "td_blood_throat")
            QBCore.Functions.Notify("🏆 Congratulations! You are the WINNER!", "success")
            
            TriggerEvent("InteractSound_CL:PlayOnOne", "winner", 0.5)
        elseif playerPosition == 2 then
            PlayWinnerAnimation(player, 2, "core", "td_blood_throat")
            QBCore.Functions.Notify("🥈 Amazing! You got second place!", "success")
            
            TriggerEvent("InteractSound_CL:PlayOnOne", "winner", 0.5)
        elseif playerPosition == 3 then
            PlayWinnerAnimation(player, 3, "core", "td_blood_throat")
            QBCore.Functions.Notify("🥉 Well done! You got third place!", "success")
            
            TriggerEvent("InteractSound_CL:PlayOnOne", "winner", 0.5)
        end
    else
        
        local spectatorIndex = 1
        for i, pos in ipairs(spectatorPositions) do
            if not IsAnyPlayerAtPosition(pos) then
                spectatorIndex = i
                break
            end
        end
        SetEntityCoords(player, spectatorPositions[spectatorIndex].x, spectatorPositions[spectatorIndex].y, spectatorPositions[spectatorIndex].z)
        SetEntityHeading(player, spectatorPositions[spectatorIndex].w)
        
        Wait(500) 
        
        
        PlayWinnerAnimation(player, 0, "core", "ent_sht_steam")
        TriggerEvent("InteractSound_CL:PlayOnOne", "winner", 0.5)
    end
    
    
    QBCore.Functions.Notify("🏆 Game Over! Top 3 players:", "primary")
    if topPlayers then
        for i, topPlayer in ipairs(topPlayers) do
            if topPlayer then
                QBCore.Functions.Notify(i .. ". " .. topPlayer.name .. " (Position: " .. topPlayer.position .. ")", "success")
            end
        end
    end
    
    
    SetTimeout(7000, function()
        canRollDice = false
        isInGame = false
        gameStarted = false
        isMyTurn = false
        if turnIndicator then
            turnIndicator = nil
        end
        diceText = {}
        
        
        ClearPedTasks(PlayerPedId())
        
        
        SetEntityCoords(PlayerPedId(), pedCoords.x, pedCoords.y, pedCoords.z)
        
        QBCore.Functions.Notify("🏁 Game ended! Thanks for playing!", "primary")
        OpenGameMenu()
        isRollCooldown = false 
    end)
end)


local function IsAnyPlayerAtPosition(pos)
    local players = GetActivePlayers()
    for _, player in ipairs(players) do
        local ped = GetPlayerPed(player)
        local coords = GetEntityCoords(ped)
        local distance = #(vector3(pos.x, pos.y, pos.z) - coords)
        if distance < 1.0 then
            return true
        end
    end
    return false
end

local cam = nil
local isCamActive = false


local boardCenter = vector3(-1728.0145263672, 147.78463745117, 79.309295654297) 

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        
        if IsControlPressed(0, 246) then 
            if not isCamActive and isInGame then 
                local playerPed = PlayerPedId()

                
                local playerCoords = GetEntityCoords(playerPed)

                
                cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
                SetCamCoord(cam, boardCenter.x, boardCenter.y, boardCenter.z) 
                SetCamRot(cam, -90.0, 0.0, -145.0, 2) 
                SetCamActive(cam, true)
                RenderScriptCams(true, true, 500, true, true)

                isCamActive = true
            end
        else
            if isCamActive then
                
                RenderScriptCams(false, true, 500, true, true)
                DestroyCam(cam, false)
                cam = nil

                isCamActive = false
            end
        end
    end
end)

































RegisterNetEvent('bg-SnakesandLadders:client:StartGame', function()
    if IsHost() then
        TriggerServerEvent('bg-SnakesandLadders:server:StartGame')
    else
        QBCore.Functions.Notify("Only the host can start the game!", "error")
    end
end)


RegisterNetEvent('bg-SnakesandLadders:client:ReceivePlayerSlots', function(players)
    if not IsHost() then return end
    
    local elements = {
        {
            header = "🎲 Snakes & Ladders Menu",
            isMenuHeader = true
        },
        {
            header = "👥 Player Slots",
            txt = "Current players in the game",
            isMenuHeader = true
        }
    }
    
    
    for i = 1, 8 do
        local playerId = players[i]
        if playerId then
            
            local Player = QBCore.Functions.GetPlayerData()
            local isCurrentTurn = playerId == GetPlayerServerId(PlayerId()) and isMyTurn
            local playerName = "Player " .. playerId 
            
            
            if playerId == GetPlayerServerId(PlayerId()) then
                playerName = Player.charinfo.firstname .. " " .. Player.charinfo.lastname
            end
            
            table.insert(elements, {
                header = "Slot " .. i .. " - " .. playerName .. (isCurrentTurn and " (Current Turn)" or ""),
                txt = "ID: " .. playerId,
                isMenuHeader = true
            })
        else
            table.insert(elements, {
                header = "Slot " .. i .. " - Empty",
                txt = "Waiting for player...",
                isMenuHeader = true
            })
        end
    end
    
    
    if not gameStarted then
        table.insert(elements, {
            header = "Start Game",
            txt = "Start the game for all players",
            params = {
                event = "bg-SnakesandLadders:client:StartGame"
            }
        })
    end
    
    table.insert(elements, {
        header = "Leave Game",
        txt = "Leave the current game session",
        params = {
            event = "bg-SnakesandLadders:client:LeaveHost"
        }
    })
    
    exports['qb-menu']:openMenu(elements)
end)


RegisterNetEvent('bg-SnakesandLadders:client:UpdatePlayerSlots', function(players)
    
    if IsHost() then
        TriggerServerEvent('bg-SnakesandLadders:server:RequestPlayerSlots')
    end
end)


function RollDice()
    if not isInGame then
        QBCore.Functions.Notify("You are not in a game!", "error")
        isRollCooldown = false
        return
    end
    
    if not isMyTurn then
        QBCore.Functions.Notify("It's not your turn!", "error")
        isRollCooldown = false
        return
    end
    
    if not canRollDice then
        QBCore.Functions.Notify("You cannot roll the dice right now!", "error")
        isRollCooldown = false
        return
    end

    if isPlayerMoving then
        QBCore.Functions.Notify("Wait for the current player to finish their turn!", "error")
        isRollCooldown = false
        return
    end
    
    
    canRollDice = false
    
    
    local countdown = 3
    local countdownThread = CreateThread(function()
        while countdown > 0 do
            
            QBCore.Functions.Notify("Rolling dice in " .. countdown .. "...", "primary")
            
            
            if countdown == 3 then
                TriggerEvent("InteractSound_CL:PlayOnOne", "countdown1", 0.4)
            elseif countdown == 2 then
                TriggerEvent("InteractSound_CL:PlayOnOne", "countdown1", 0.4)
            elseif countdown == 1 then
                TriggerEvent("InteractSound_CL:PlayOnOne", "countdown1", 0.4)
            end
            Wait(1000)
            countdown = countdown - 1
        end
        
        
        TriggerEvent("InteractSound_CL:PlayOnOne", "countdown1", 0.6)
        PlayParticleEffect(particleDicts.dice, particleNames.dice, GetEntityCoords(PlayerPedId()), 1000)
        
        
        ClearPedTasks(PlayerPedId())
        
        
        isMyTurn = false
        TriggerServerEvent('bg-SnakesandLadders:server:RollDice', GetGameTimer())
        
        
        SetTimeout(5000, function()
            isRollCooldown = false
        end)
    end)
end


RegisterCommand('testendgame', function()
    if not isInGame then
        QBCore.Functions.Notify("You must be in a game to use this command!", "error")
        return
    end

    
    local player = PlayerPedId()
    SetEntityCoords(player, boardPositions[99].x, boardPositions[99].y, boardPositions[99].z)
    lastValidPositionIndex = 99
    
    
    TriggerServerEvent('bg-SnakesandLadders:server:UpdatePosition', 99)
    
    QBCore.Functions.Notify("🎲 Teleported to position 99! Roll the dice to test end game.", "success")
    canRollDice = true
end, false)

TriggerEvent('chat:addSuggestion', '/testendgame', 'Teleport to position 99 to test end game sequence')



local function CreateGameBlip()
    local blip = AddBlipForCoord(-1721.0, 138.07, 64.66) 
    SetBlipSprite(blip, 266) 
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 24) 
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Snakes & Ladders") 
    EndTextCommandSetBlipName(blip)
    return blip
end


CreateThread(function()
    local gameBlip = CreateGameBlip()
end)
