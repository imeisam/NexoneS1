local blacklisted = { -- Here you can blacklist players from creating new ads
    ['identiifer123'] = true
}

function isBlacklisted(identifier)
    return blacklisted[identifier]
end

function isAdmin(source)
    return exports['av_laptop']:getPermission(source,Config.AdminLevel)
end