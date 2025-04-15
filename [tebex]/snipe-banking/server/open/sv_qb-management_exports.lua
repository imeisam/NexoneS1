local function exportHandler(exportName, func)
    AddEventHandler(('__cfx_export_qb-management_%s'):format(exportName), function(setCB)
        setCB(func)
    end)
end

exportHandler("GetAccount", function(account)
    if not jobGangAccounts[account] then
        return false
    end
    return jobGangAccounts[account]
end)

exportHandler("AddMoney", function(account, amount)
    if not amount then
        return false
    end
    if not jobGangAccounts[account] then
        return false
    end
    jobGangAccounts[account] = jobGangAccounts[account] + amount
    return true
end)

exportHandler("RemoveMoney", function(account, amount)
    if not amount then
        return false
    end
    if not jobGangAccounts[account] then
        return false
    end
    if jobGangAccounts[account] >= amount then
        jobGangAccounts[account] = jobGangAccounts[account] - amount
        return true
    else
        return false
    end
end)

exportHandler("GetGangAccount", function(account)
    if not jobGangAccounts[account] then
        return false
    end
    return jobGangAccounts[account]
end)

exportHandler("AddGangMoney", function(account, amount)
    if not amount then
        return false
    end
    if not jobGangAccounts[account] then
        return false
    end
    jobGangAccounts[account] = jobGangAccounts[account] + amount
    return true
end)

exportHandler("RemoveGangMoney", function(account, amount)
    if not amount then
        return false
    end
    if not jobGangAccounts[account] then
        return false
    end
    if jobGangAccounts[account] >= amount then
        jobGangAccounts[account] = jobGangAccounts[account] - amount
        return true
    else
        return false
    end
end)