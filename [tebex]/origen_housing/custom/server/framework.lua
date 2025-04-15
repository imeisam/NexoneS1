Framework.GetIdentifier = function(source)
    local src = source

    if Config.Framework == 'qb-core' then 
        local Player = Framework.Functions.GetPlayer(source)
        if not Player then return end
        return Player.PlayerData.citizenid
    elseif Config.Framework == 'esx' then 
        local Player = Framework.GetPlayerFromId(source)
        if not Player then return end
        return Player.getIdentifier()
    end
end

Framework.GetPlayerName = function(source)
    if Config.Framework == 'qb-core' then 
        local Player = Framework.Functions.GetPlayer(source)
        if not Player then return end
        return Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    elseif Config.Framework == 'esx' then 
        local Player = Framework.GetPlayerFromId(source)
        if not Player then return end
        return Player.getName()
    end
end

Framework.GetPlayerJob = function(source)
    if Config.Framework == 'qb-core' then 
        local Player = Framework.Functions.GetPlayer(source)
        if not Player then return end
        return Player.PlayerData.job
    elseif Config.Framework == 'esx' then 
        local Player = Framework.GetPlayerFromId(source)
        if not Player then return end
        local job = Player.getJob()
        return {
            name = job.name,
            grade = {
                name = job.grade_name,
                level = job.grade,
            }
        }
    end
end

Framework.GetMoney = function(source, paymentMethod)
    if not paymentMethod or not Config.PaymentMethods[paymentMethod] then
        paymentMethod = Config.DefaultPaymentMethod
    end

    if Config.Framework == 'qb-core' then 
        local Player = Framework.Functions.GetPlayer(source)
        if not Player then return end
        return Player.Functions.GetMoney(paymentMethod)
    elseif Config.Framework == 'esx' then 
        paymentMethod = paymentMethod == 'cash' and 'money' or paymentMethod
        local Player = Framework.GetPlayerFromId(source)
        if not Player then return end
        return Player.getAccount(paymentMethod).money
    end
end

Framework.RemoveMoney = function(source, amount, paymentMethod)
    if not paymentMethod or not Config.PaymentMethods[paymentMethod] then
        paymentMethod = Config.DefaultPaymentMethod
    end

    if Config.Framework == 'qb-core' then 
        local Player = Framework.Functions.GetPlayer(source)
        if not Player then return end
        Player.Functions.RemoveMoney(paymentMethod, amount)
    elseif Config.Framework == 'esx' then 
        paymentMethod = paymentMethod == 'cash' and 'money' or paymentMethod
        local Player = Framework.GetPlayerFromId(source)
        if not Player then return end
        Player.removeAccountMoney(paymentMethod, amount)
    end
end

Framework.Removeitem = function(source, itemName, amount)
    if Config.Framework == 'qb-core' then
        local Player = Framework.Functions.GetPlayer(source)
        if not Player then return end
        Player.Functions.RemoveItem(itemName, amount)
    elseif Config.Framework == 'esx' then 
        local Player = Framework.GetPlayerFromId(source)
        if not Player then return end
        Player.removeInventoryItem(itemName, amount)
    end
end

Framework.GetGroup = function(source)
    if Config.Framework == 'qb-core' then 
        local group = Framework.Functions.GetPermission(source)
        return group
    elseif Config.Framework == 'esx' then 
        local Player = Framework.GetPlayerFromId(source)
        return Player.getGroup()
    end
end

Framework.CreateUseableItem = function(...)
    if Config.Framework == 'qb-core' then
        Framework.Functions.CreateUseableItem(...)
    elseif Config.Framework == 'esx' then
        Framework.RegisterUsableItem(...)
    end
end