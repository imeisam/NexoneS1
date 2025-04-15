local QBCore = exports['qb-core']:GetCoreObject()
local max = 64

QBCore.Functions.CreateCallback('qb-scoreboard:server:GetScoreboardData', function(_, cb)
    local totalPlayers = 0
    local policeCount = 0
    local medicCount = 0
    for _, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if v then
            totalPlayers = totalPlayers + 1
        end
    end
    -- if totalPlayers > 8 and totalPlayers <= 15 then
    --     totalPlayers = totalPlayers + 3
    -- elseif totalPlayers > 15 and totalPlayers <= 20 then
    --     totalPlayers = totalPlayers + 5
    -- elseif totalPlayers > 20 and totalPlayers <= 27 then
    --     totalPlayers = totalPlayers + 6
    -- elseif totalPlayers > 20 and totalPlayers <= 27 then
    --     totalPlayers = totalPlayers + 7
    -- elseif totalPlayers > 27
    --     totalPlayers = totalPlayers + 8
    -- end
    -- if totalPlayers > max then
    --     totalPlayers = max
    -- end
    cb(max, totalPlayers)
end)