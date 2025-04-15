if not Config.Enable then return end

local QBCore = exports['qb-core']:GetCoreObject()
local Votes = {}
for k,v in ipairs(Config.Candidates) do
    Votes[k] = 0
end

RegisterNetEvent('qb-voting:server:vote', function(kodom)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local vote = Config.Candidates[kodom]
    if not vote then return end
    if Player.PlayerData.metadata[Config.VoteMetaData] then return end
    Player.Functions.SetMetaData(Config.VoteMetaData, true)
    Votes[kodom] = Votes[kodom] + 1
    TriggerClientEvent('QBCore:Notify', src, 'You voted to '..vote, 'success')
    local allvotes = 0
    for k,v in ipairs(Config.Candidates) do
        allvotes = allvotes + Votes[k]
    end
    TriggerEvent('qb-log:server:CreateLog', 'vote', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname..' ('..Player.PlayerData.citizenid..')', 'white', 'voted to: **'..vote..'** \nCandidate Total: '..Votes[kodom]..' \nAll: '..allvotes)
end)