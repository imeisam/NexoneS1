local QBCore = exports['qb-core']:GetCoreObject()


local activeHosts = {}

local playersInGame = {}


local activeGames = {}
local playerPositions = {}


RegisterNetEvent('bg-SnakesandLadders:server:CreateHost', function()
    local src = source
    
    if playersInGame[src] then
        TriggerClientEvent('QBCore:Notify', src, "You are already in a game!", "error")
        return
    end

    if not activeHosts[src] then
        activeHosts[src] = {
            hostId = src,
            players = {src},
            gameStarted = false,
            currentTurn = 1, 
            lastRoll = nil 
        }
        playersInGame[src] = src 
        TriggerClientEvent('bg-SnakesandLadders:client:JoinedHost', src, src)
        -- TriggerClientEvent('bg-SnakesandLadders:client:ReceiveHosts', -1, activeHosts)
    end
end)


RegisterNetEvent('bg-SnakesandLadders:server:GetHosts', function()
    local src = source
    TriggerClientEvent('bg-SnakesandLadders:client:ReceiveHosts', src, activeHosts)
end)


RegisterNetEvent('bg-SnakesandLadders:server:GetPlayerSlots', function()
    local src = source
    if not activeHosts[src] then return end
    
    local players = {}
    for _, playerId in ipairs(activeHosts[src].players) do
        local player = QBCore.Functions.GetPlayer(playerId)
        if player then
            table.insert(players, {
                id = playerId,
                name = player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname
            })
        end
    end
    
    TriggerClientEvent('bg-SnakesandLadders:client:UpdatePlayerSlots', src, players)
end)


function UpdateHostSlots(hostId)
    if not activeHosts[hostId] then return end
    
    local players = {}
    for _, playerId in ipairs(activeHosts[hostId].players) do
        local player = QBCore.Functions.GetPlayer(playerId)
        if player then
            table.insert(players, {
                id = playerId,
                name = player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname
            })
        end
    end
    
    TriggerClientEvent('bg-SnakesandLadders:client:UpdatePlayerSlots', hostId, players)
end


RegisterNetEvent('bg-SnakesandLadders:server:JoinHost', function(hostId)
    local src = source
    
    
    if src == hostId then
        TriggerClientEvent('QBCore:Notify', src, "You cannot join your own game!", "error")
        return
    end
    
    
    if playersInGame[src] then
        TriggerClientEvent('QBCore:Notify', src, "You are already in a game!", "error")
        return
    end

    if activeHosts[hostId] and not activeHosts[hostId].gameStarted then
        
        if #activeHosts[hostId].players >= 8 then
            TriggerClientEvent('QBCore:Notify', src, "This game is full! Maximum 8 players allowed.", "error")
            return
        end
        
        table.insert(activeHosts[hostId].players, src)
        playersInGame[src] = hostId 
        UpdateHostSlots(hostId)
        TriggerClientEvent('bg-SnakesandLadders:client:JoinedHost', src, hostId)
        -- TriggerClientEvent('bg-SnakesandLadders:client:ReceiveHosts', -1, activeHosts)
    end
end)


RegisterNetEvent('bg-SnakesandLadders:server:StartGame', function()
    local src = source
    if activeHosts[src] then
        activeHosts[src].gameStarted = true
        activeHosts[src].currentTurn = 1 
        for _, playerId in ipairs(activeHosts[src].players) do
            TriggerClientEvent('bg-SnakesandLadders:client:GameStarted', playerId)
        end
        
        TriggerClientEvent('bg-SnakesandLadders:client:YourTurn', activeHosts[src].players[1])
    end
end)


RegisterNetEvent('bg-SnakesandLadders:server:RollDice', function()
    local src = source
    for hostId, hostData in pairs(activeHosts) do
        if hostData.gameStarted then
            
            if hostData.players[hostData.currentTurn] == src then
                local diceRoll = math.random(1, 6)
                hostData.lastRoll = diceRoll
                
                
                for _, playerId in ipairs(hostData.players) do
                    TriggerClientEvent('bg-SnakesandLadders:client:ShowDiceRoll', playerId, src, diceRoll)
                end
                
                
                if diceRoll ~= 6 then
                    hostData.currentTurn = hostData.currentTurn + 1
                    if hostData.currentTurn > #hostData.players then
                        hostData.currentTurn = 1
                    end
                    
                    TriggerClientEvent('bg-SnakesandLadders:client:YourTurn', hostData.players[hostData.currentTurn])
                else
                    
                    TriggerClientEvent('bg-SnakesandLadders:client:YourTurn', src)
                end
                return
            end
        end
    end
    TriggerClientEvent('QBCore:Notify', src, "It's not your turn!", "error")
end)


RegisterNetEvent('bg-SnakesandLadders:server:LeaveHost', function()
    local src = source
    for hostId, hostData in pairs(activeHosts) do
        for i, playerId in ipairs(hostData.players) do
            if playerId == src then
                table.remove(hostData.players, i)
                playersInGame[src] = nil 
                UpdateHostSlots(hostId)
                if #hostData.players == 0 or src == hostId then
                    
                    activeHosts[hostId] = nil
                    
                    for _, pid in ipairs(hostData.players) do
                        playersInGame[pid] = nil
                        TriggerClientEvent('bg-SnakesandLadders:client:EndGame', pid)
                    end
                end
                TriggerClientEvent('bg-SnakesandLadders:client:ReceiveHosts', -1, activeHosts)
                TriggerClientEvent('bg-SnakesandLadders:client:LeaveHost', src)
                return
            end
        end
    end
end)
    

AddEventHandler('playerDropped', function()
    local src = source
    if activeHosts[src] then
        for _, playerId in ipairs(activeHosts[src].players) do
            playersInGame[playerId] = nil
            TriggerClientEvent('bg-SnakesandLadders:client:EndGame', playerId)
        end
        activeHosts[src] = nil
        TriggerClientEvent('bg-SnakesandLadders:client:ReceiveHosts', -1, activeHosts)
    else
        
        for hostId, hostData in pairs(activeHosts) do
            for i, playerId in ipairs(hostData.players) do
                if playerId == src then
                    table.remove(hostData.players, i)
                    playersInGame[src] = nil
                    TriggerClientEvent('bg-SnakesandLadders:client:ReceiveHosts', -1, activeHosts)
                    return
                end
            end
        end
    end
end)


RegisterNetEvent('bg-SnakesandLadders:server:GameEnd', function()
    local src = source
    print("Game End event received from player:", src) 
    
    local hostId = playersInGame[src]
    print("Host ID:", hostId) 
    
    if not hostId or not activeHosts[hostId] then 
        print("Invalid host or game not found") 
        return 
    end
    
    
    local players = {}
    for _, playerId in ipairs(activeHosts[hostId].players) do
        local player = QBCore.Functions.GetPlayer(playerId)
        if player then
            table.insert(players, {
                id = playerId,
                name = player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname,
                position = playerPositions[playerId] or 0
            })
            print("Added player to ranking - ID:", playerId, "Position:", playerPositions[playerId] or 0) 
        end
    end
    
    
    table.sort(players, function(a, b)
        return (a.position or 0) > (b.position or 0)
    end)
    
    
    local topPlayers = {
        players[1],
        players[2],
        players[3]
    }
    print("Top players calculated:", json.encode(topPlayers)) 
    
    
    for _, playerId in ipairs(activeHosts[hostId].players) do
        print("Sending game end event to player:", playerId) 
        TriggerClientEvent('bg-SnakesandLadders:client:GameEnd', playerId, topPlayers)
    end
    
    
    SetTimeout(8000, function()
        print("Cleaning up game data") 
        for _, playerId in ipairs(activeHosts[hostId].players) do
            playersInGame[playerId] = nil
        end
        activeHosts[hostId] = nil
        TriggerClientEvent('bg-SnakesandLadders:client:ReceiveHosts', -1, activeHosts)
    end)
end)


RegisterNetEvent('bg-SnakesandLadders:server:UpdatePosition', function(position)
    local src = source
    playerPositions[src] = position
end)


RegisterNetEvent('bg-SnakesandLadders:server:RequestPlayerSlots', function()
    local src = source
    if activeHosts[src] then 
        TriggerClientEvent('bg-SnakesandLadders:client:ReceivePlayerSlots', src, activeHosts[src].players)
    end
end)
