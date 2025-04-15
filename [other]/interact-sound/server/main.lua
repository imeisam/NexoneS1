local Spam = {}

RegisterNetEvent('InteractSound_SV:PlayOnSource', function(soundFile, soundVolume)
    TriggerClientEvent('InteractSound_CL:PlayOnOne', source, soundFile, soundVolume)
end)

RegisterNetEvent('InteractSound_SV:PlayWithinDistance', function(maxDistance, soundFile, soundVolume)
    local src = source
    if soundFile == 'reload' then
        TriggerClientEvent('InteractSound_CL:PlayWithinDistance', -1, GetEntityCoords(GetPlayerPed(src)), 3, soundFile, soundVolume)
    else
        -- if Spam[src] then return end
        -- Spam[src] = true
        local DistanceLimit = 200
        if maxDistance < DistanceLimit then
            TriggerClientEvent('InteractSound_CL:PlayWithinDistance', -1, GetEntityCoords(GetPlayerPed(src)), maxDistance, soundFile, soundVolume)
        else
            print(('[interact-sound] [^3WARNING^7] %s attempted to trigger InteractSound_SV:PlayWithinDistance over the distance limit ' .. DistanceLimit):format(GetPlayerName(src)))
        end
        -- SetTimeout(10000, function()
        --     Spam[src] = nil
        -- end)
    end
end)

RegisterNetEvent('InteractSound_SV:PlayWithinDistancebycoord', function(maxDistance, soundFile, soundVolume,coord)
    local src = source
    if soundFile == 'reload' then
        TriggerClientEvent('InteractSound_CL:PlayWithinDistance', -1, coord, 3, soundFile, soundVolume)
    else
        local DistanceLimit = 200
        if maxDistance < DistanceLimit then
            TriggerClientEvent('InteractSound_CL:PlayWithinDistance', -1, coord, maxDistance, soundFile, soundVolume)
        else
            print(('[interact-sound] [^3WARNING^7] %s attempted to trigger InteractSound_SV:PlayWithinDistance over the distance limit ' .. DistanceLimit):format(GetPlayerName(src)))
        end
    end
end)

RegisterNetEvent('InteractSound_SV:PlayRony', function(soundFile, soundVolume)
    local src = source
    TriggerClientEvent('InteractSound_CL:PlayRony', -1, GetEntityCoords(GetPlayerPed(src)), src, soundFile, soundVolume)
end)

RegisterNetEvent('InteractSound_SV:StopSoundRony', function()
    TriggerClientEvent('InteractSound_CL:StopSoundRony', -1)
end)