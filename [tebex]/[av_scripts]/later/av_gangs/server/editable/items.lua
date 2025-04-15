function useSpray(source,item,info)
    local src = source
    local metadata, slot = exports['av_laptop']:getMetadata(item, info)
    if metadata and metadata.gang then
        local myGang = getGang(src)
        if metadata.gang == myGang.name then
            if isExpired(metadata.expiration) then
                TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['expired'],"error")
                return
            end
            local gangData = gangs[myGang.name]
            if gangData then
                local url = gangData['logo']
                if url and string.len(url) > 5 then
                    TriggerClientEvent('av_gangs:addGraffiti',src,myGang.name,url)
                else
                    TriggerClientEvent('av_laptop:notification',src,Lang['app_title'], Lang['no_logo'], 'error')
                end
            else
                TriggerClientEvent('av_laptop:notification',src,Lang['app_title'], Lang['not_your_spray'], 'error')
            end
        else
            TriggerClientEvent('av_laptop:notification',src,Lang['app_title'], Lang['not_your_spray'], 'error')
        end
    else
        TriggerClientEvent('av_laptop:notification',src,Lang['app_title'], Lang['needs_metadata'], 'error')
    end
end

function useRemover(source,item,info)
    TriggerClientEvent('av_gangs:useCleaner', source)
end

function isExpired(expiration)
    if not expiration then return false end
    expiration = tonumber(expiration)
    local timeNow = os.time()
    return (timeNow > expiration)
end