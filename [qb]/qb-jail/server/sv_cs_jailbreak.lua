QBCore = exports['qb-core']:GetCoreObject()
jailbreakstarted=false
QBCore.Functions.CreateCallback('qb-jail:server:started', function(source, cb)
    if jailbreakstarted then
        cb(true)
    else
        jailbreakstarted=true
        cb(false)
       
    end
   
end)

RegisterNetEvent('qb-jail:server:jailbreakactive', function()
    Config.jailbreakactive=true
end)


RegisterNetEvent('qb-jail:server:RemoveThermite', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
        
    Player.Functions.RemoveItem(Config.jailbreak[index].item,1, false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.jailbreak[index].item], "remove",1)
end)

RegisterNetEvent('qb-jail:server:RequestJailBreakRelease', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if not Config.jailbreakactive then return end
    if not isPlayerInJail(src) then return false end

    jailedPlayers[src] = nil
    Player.Functions.SetMetaData('injail', 0)

    removeFromJobGroup(src, getPlayerJobGroup(src))
    Player.Functions.SetMetaData('jailitems', {})
    TriggerClientEvent('QBCore:Notify', src, 'You successfully broke out of prison!', 'success', 4000)
end)

QBCore.Functions.CreateCallback('qb-jail:server:getCops', function(source, cb)
    cb(0)
end)

RegisterNetEvent('qb-jail:server:Lockdownalarm', function(status)
    TriggerClientEvent('qb-jail:client:Lockdownalarm', -1, status)
end)

function GetNearbyPlayers(eCoords, range)
    local data = {}
    for _, playerId in ipairs(GetPlayers()) do
        local pCoord = GetEntityCoords(GetPlayerPed(playerId))
        
        if #(pCoord - eCoords) < range then
            table.insert(data, playerId)
        end
    end
    return data
end
function TriggerParticleAtCoord(ptDict, ptName, looped, position, duration, ptID)
    for _, playerId in pairs(ptID) do
        TriggerClientEvent("particle:sync:coord", playerId, ptDict, ptName, looped, position, duration, ptID)
    end
end  

RegisterNetEvent('thermite:server:thermitefire', function(coord)
    local players = GetNearbyPlayers(coord, 100)
    -- local ptDict, ptName = "scr_fbi3", "scr_fbi3_elec_spranks"
    -- local ptDict, ptName = "scr_michael2", "scr_mich2_sprank_impact"
    -- local ptDict, ptName = "core", "ent_brk_spranking_wires"
    -- local ptDict, ptName = "scr_xs_dr", "scr_xs_dr_amp"
    local ptDict, ptName = "core", "exp_grd_grenade_smoke"
    local position = {
        coords = { { x = coord.x, y = coord.y, z = coord.z } },
        rot = { x = 0.0, y = 0.0, z = 0.0 },
        scale = 1.0,
        alpha = 10.0,
    }
    TriggerParticleAtCoord(ptDict, ptName, true, position, 15000, players)
    position.coords[1].z = position.coords[1].z + 1.0
    Wait(1000)
    TriggerParticleAtCoord(ptDict, ptName, true, position, 15000, players)
    
    TriggerClientEvent('thermite:client:thermitefire', -1, coord)
end)
