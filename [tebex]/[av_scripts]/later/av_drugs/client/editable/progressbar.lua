function progressBar(dict, anim, duration, prop, flag, blendIn, blendOut, disableWalk)
    local waiting = true
    local res = false
    if lib[Config.ProgressType]({
        duration = duration or 10000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = disableWalk and not disableWalk or false,
            car = true,
        },
        anim = {
            dict = dict or false,
            clip = anim or false,
            flag = flag or 1,
            blendIn = blendIn or 3.0,
            blendOut = blendOut or 1.0,
        },
        prop = prop or {},
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