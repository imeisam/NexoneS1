local function GetAccountBalance(account)
    if not jobGangAccounts[account] then
        return false
    end
    return jobGangAccounts[account]
end

local function AddMoneyToAccount(account, amount,memo)
    if not amount then
        return false
    end
    if not jobGangAccounts[account] then
        return false
    end
    jobGangAccounts[account] = jobGangAccounts[account] + amount
    typetrans="deposit"
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local transaction_by = xPlayer.PlayerData.citizenid

    CreateJobTransactions(account, amount, memo, typetrans, transaction_by)
    return true
end

local function RemoveMoneyFromAccount(account, amount)
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
end

local function SetAccountMoney(account, amount)
    if not amount then
        return false
    end
    if not jobGangAccounts[account] then
        return false
    end
    jobGangAccounts[account] = amount
    return true
end

local function GetJobGangAccounts()
    while not jobsLoaded do
        Wait(100)
    end
    return jobGangAccounts
end

exports("GetAccountBalance", GetAccountBalance)
exports("AddMoneyToAccount", AddMoneyToAccount)
exports("RemoveMoneyFromAccount", RemoveMoneyFromAccount)
exports("SetAccountMoney", SetAccountMoney)
exports("GetJobGangAccounts", GetJobGangAccounts)



RegisterNetEvent('QBCore:Server:OnMoneyChange', function(source,typee, amount, changeType, reason,notlog)
    if notlog then return end
    src=source
    if typee=='bank' then
        local xPlayer = QBCore.Functions.GetPlayer(src)
        local identifier = xPlayer.PlayerData.citizenid
      if changeType=='remove' then
        CreatePersonalTransactions(identifier, amount, reason, "withdraw")
      else
        CreatePersonalTransactions(identifier, amount, reason, "deposit")
      end
     
    end
  end)
  