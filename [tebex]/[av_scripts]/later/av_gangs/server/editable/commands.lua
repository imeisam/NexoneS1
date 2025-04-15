RegisterCommand(Config.AdminCommand, function(source,_)
    local src = source
    local hasPermissions = exports['av_laptop']:getPermission(src, Config.AdminLevel)
    if hasPermissions then
        TriggerClientEvent('av_gangs:openAdmin',src)
    else
        TriggerClientEvent("av_laptop:notification",src,Lang['app_title'],Lang['not_admin'], 'error')
    end
end)

RegisterCommand(Config.ShellCommand, function(source,args)
    local model = args[1]
    local src = source
    local hasPermissions = exports['av_laptop']:getPermission(src, Config.AdminLevel)
    if hasPermissions and model then
        TriggerClientEvent('av_gangs:testShell', source, model)
    end
end)