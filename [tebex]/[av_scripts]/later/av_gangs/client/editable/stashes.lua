RegisterNetEvent('av_gangs:stash', function(data)
    local type = data['type'] or ''
    local identifier = data['identifier']
    local stashName = identifier..type
    local gang = data['gang']
    local interiorType = data['interiorType']
    local productType = data['productType']
    debug("av_gangs:stash StashName: "..stashName)
    debug("av_gangs:stash: (type, gang, interiorType, productType, identifier)")
    debug(type, gang, interiorType, productType, identifier)
    if not type or not gang or not identifier then return end
    local res = lib.callback.await("av_gangs:getStash", false, gang, interiorType, identifier)
--    debug(type, Lang[type])
--    debug(json.encode(res, {indent = true}))
    local info = res['info']
    if info and info['stash'] then
        local slots = info['stash']['default']['slots']
        local weight = info['stash']['default']['weight']
        if res['level'] and res['level'] > 0 then
            slots = info['stash']['slots'][res['level']]
            weight = info['stash']['weight'][res['level']]
        end
        if lib.progressBar({
            duration = 3000,
            label = Lang['opening'],
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
                move = true,
            },
            anim = {
                dict = 'missheistfbisetup1',
                clip = 'hassle_intro_loop_f'
            },
            prop = {
            },
        }) then 
            exports['av_laptop']:openStash(stashName, Lang[type], weight, slots, true)
        end
    else
        print("^3[WARNING] Property "..identifier.." doesn't exist anymore.")
    end
end)