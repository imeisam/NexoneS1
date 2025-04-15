local QBCore = exports['qb-core']:GetCoreObject()
local scoreboardOpen = false
local getdata = false
local max, players = 0, 0

local function DrawText3D(x, y, z, text)
	SetTextScale(0.6, 0.6)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(213, 0, 0, 255)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
end

local function GetPlayers()
    local players = {}
    local activePlayers = GetActivePlayers()
    for i = 1, #activePlayers do
        local player = activePlayers[i]
        local ped = GetPlayerPed(player)
        if DoesEntityExist(ped) then
            players[#players+1] = player
        end
    end
    return players
end

local function GetPlayersFromCoords(coords, distance)
    local players = GetPlayers()
    local closePlayers = {}
	coords = coords or GetEntityCoords(PlayerPedId())
    distance = distance or  5.0
    for i = 1, #players do
        local player = players[i]
		local target = GetPlayerPed(player)
		local targetCoords = GetEntityCoords(target)
		local targetdistance = #(targetCoords - vector3(coords.x, coords.y, coords.z))
		if targetdistance <= distance and IsEntityVisible(target) then
            closePlayers[#closePlayers+1] = player
		end
    end

    return closePlayers
end

local function DrawIds()
    while scoreboardOpen do
        for _, player in pairs(GetPlayersFromCoords(GetEntityCoords(PlayerPedId()), 10.0)) do
            local playerId = GetPlayerServerId(player)
            local playerPed = GetPlayerPed(player)
            local playerCoords = GetEntityCoords(playerPed)
            loop = 0
            DrawText3D(playerCoords.x, playerCoords.y, playerCoords.z + 1.0, playerId)
        end
        Wait(loop)
    end
end

local function CloseScoreboard()
    if scoreboardOpen then
        SendNUIMessage({
            action = "close",
        })
        scoreboardOpen = false
    end
end

local function OpenScoreboard()
    SetTimeout(10000, function()
        CloseScoreboard()
    end)
    TriggerServerEvent('qb-log:server:CreateLog', 'scorboard', 'OpenScoreboard', 'red', '**' .. QBCore.Functions.GetPlayerData().charinfo.firstname .. ' ' .. QBCore.Functions.GetPlayerData().charinfo.lastname .. '**')
    SendNUIMessage({
        action = "open",
        players = players,
        maxPlayers = max,
    })
    scoreboardOpen = true
    DrawIds()
end

AddEventHandler('onKeyDown', function(key)
    if key == 'home' then
        if scoreboardOpen then
            CloseScoreboard()
        else
            if getdata then
                OpenScoreboard()
            else
                QBCore.Functions.TriggerCallback('qb-scoreboard:server:GetScoreboardData', function(MAX, PLAYERS)
                    max, players = MAX, PLAYERS
                    getdata = true
                    SetTimeout(30000, function()
                        getdata = false
                    end)
                    OpenScoreboard()
                end)
            end
        end
    end
end)