Custom.hasPermission = function(src, action) 
    src = tonumber(src)

    if not src or not action or not Config.Permissions[action] then
        return false, 'Source or action not found'
    end

    if Config.Job?.active then 
        local allowedJobs = Config.Job.allowed
        local job = Framework.GetPlayerJob(src)

        if 
            allowedJobs[job.name] and 
            allowedJobs[job.name][action] and 
            allowedJobs[job.name].minGrade <= job.grade.level 
        then
            return true, 'Player has job permission'
        end
    end

    local admin = IsPlayerAceAllowed(src, 'command')
    if admin then
        return true, 'Player is admin'
    end

    local group = Framework.GetGroup(src)
    if not group then
        return false, 'No group exists'
    end

    if group and type(group) == 'table' and not next(group) then
        return false, 'Table is empty'
    end

    local permissions = Config.Permissions[action]
    
    if type(group) == 'table' then
        for groupName, permission in pairs(group) do
            if permission and Utils.contains(permissions, groupName) then
                return true, 'Group exists'..groupName
            end
        end
    else
        if Utils.contains(permissions, group) then
            return true, 'Group exists'..group
        end
    end
    
    return false, 'No group exists'
end