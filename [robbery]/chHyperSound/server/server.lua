--
-- Setup
--

if Config.AllowFromClient then
    RegisterNetEvent('chHyperSound:play')
    RegisterNetEvent('chHyperSound:playOnEntity')
    RegisterNetEvent('chHyperSound:stop')
end

--
-- Events
--

AddEventHandler('chHyperSound:play', function(soundId, soundName, isLooped, location, maxDistance, targetId)
    if not maxDistance then
        maxDistance = Config.DefaultDistance
    end

    if not targetId then
        targetId = -1
    end

    TriggerClientEvent('__chHyperSound:play', targetId, soundId, soundName, isLooped, location, maxDistance)
end)

AddEventHandler('chHyperSound:playOnEntity', function(entityNetId, soundId, soundName, isLooped, maxDistance, targetId)
    if not maxDistance then
        maxDistance = Config.DefaultDistance
    end

    if not targetId then
        targetId = -1
    end

    TriggerClientEvent('__chHyperSound:playOnEntity', targetId, entityNetId, soundId, soundName, isLooped, maxDistance)
end)

AddEventHandler('chHyperSound:stop', function(soundId, targetId)
    if not targetId then
        targetId = -1
    end

    TriggerClientEvent('__chHyperSound:stop', targetId, soundId)
end)

AddEventHandler('chHyperSound:increaseVolume', function(soundId, targetId)
    if not targetId then
        targetId = -1
    end

    TriggerClientEvent('__chHyperSound:increaseVolume', targetId, soundId)
end)

AddEventHandler('chHyperSound:decreaseVolume', function(soundId, targetId)
    if not targetId then
        targetId = -1
    end

    TriggerClientEvent('__chHyperSound:decreaseVolume', targetId, soundId)
end)

AddEventHandler('chHyperSound:filterSound', function(soundId, filterName, targetId)
    if not targetId then
        targetId = -1
    end

    TriggerClientEvent('__chHyperSound:filterSound', targetId, soundId, filterName)
end)

AddEventHandler('chHyperSound:removeFilter', function(soundId, targetId)
    if not targetId then
        targetId = -1
    end

    TriggerClientEvent('__chHyperSound:filterSound', targetId, soundId, 'normal')
end)