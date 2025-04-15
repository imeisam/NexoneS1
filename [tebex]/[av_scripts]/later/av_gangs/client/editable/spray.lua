local busy = false

function applySpray() -- Apply Spray
    if busy then return end
    lib.requestAnimDict("anim@scripted@freemode@postertag@graffiti_spray@male@")
    lib.requestModel(`prop_cs_spray_can`, 10000)
    local prop = CreateObject(`prop_cs_spray_can`, GetEntityCoords(cache.ped), true, true, true)
    AttachEntityToEntity(prop, cache.ped, GetPedBoneIndex(cache.ped, 28422), 0.0, 0.0, 0.0700, 0.0017365, 0.0, 0.0, true, true, false, false, 1, true)
    sendDispatch('apply')
    local progress1 = progressBar("anim@scripted@freemode@postertag@graffiti_spray@male@", "shake_can_male", 15000)
    if progress1 then
        ClearPedTasks(cache.ped)
        lib.requestAnimDict("anim@scripted@freemode@postertag@graffiti_spray@male@")
        local progress2 = progressBar("anim@scripted@freemode@postertag@graffiti_spray@male@", "spray_can_var_01_male", Config.PlaceSprayTime * 1000)
        ClearPedTasks(cache.ped)
        DeleteObject(prop)
        SetModelAsNoLongerNeeded(`prop_cs_spray_can`)
        busy = false
        return progress2
    else
        ClearPedTasks(cache.ped)
        DeleteObject(prop)
        SetModelAsNoLongerNeeded(`prop_cs_spray_can`)
        busy = false
        return false
    end
end

function removeSpray(gang, identifier) -- Remover function
    if PlayerGang then
        local gangOnline = lib.callback.await('av_gangs:getOnline', false, gang, "removeSpray")
        if gangOnline >= Config.MinMembersForRemover then
            sendDispatch('removing')
            local res = progressBar("amb@world_human_maid_clean@", "base", Config.RemoveSprayTime * 1000)
            if res then
                TriggerServerEvent('av_gangs:removeGraffiti', gang, identifier)
            end
        else
            TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['not_enough_enemies'],"error")
        end
    else
        TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['not_gang_remover'],"error")
    end
end

function progressBar(dict, anim, duration)
    local waiting = true
    local res = false
    if lib[Config.ProgressType]({
        duration = duration,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
        },
        anim = {
            dict = dict,
            clip = anim,
            flag = 1,
        },
        prop = {
        },
    }) then
        if not exports['av_laptop']:isDead() then
            res = true
            waiting = false
        end
    else
        waiting = false
    end
    while waiting do Wait(50) end
    return res
end