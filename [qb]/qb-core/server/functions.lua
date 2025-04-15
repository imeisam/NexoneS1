QBCore.Functions = {}
QBCore.Player_Buckets = {}
QBCore.Entity_Buckets = {}
QBCore.Player_Permissions = {}

-- Getters
-- Get your player first and then trigger a function on them
-- ex: local player = QBCore.Functions.GetPlayer(source)
-- ex: local example = player.Functions.functionname(parameter)

function QBCore.Functions.GetCoords(entity)
    local coords = GetEntityCoords(entity, false)
    local heading = GetEntityHeading(entity)
    return vector4(coords.x, coords.y, coords.z, heading)
end

function QBCore.Functions.GetIdentifier(source, idtype)
    local identifiers = GetPlayerIdentifiers(source)
    for _, identifier in pairs(identifiers) do
        if string.find(identifier, idtype) then
            return identifier
        end
    end
    return 'None'
end

function QBCore.Functions.GetSource(identifier)
    for src, _ in pairs(QBCore.Players) do
        local discord = QBCore.Functions.GetIdentifier(src, 'discord')
        if identifier == discord then
            return src
        end
    end
    return 0
end

function QBCore.Functions.GetPlayer(source)
    if type(source) == 'number' then
        return QBCore.Players[source]
    else
        return QBCore.Players[QBCore.Functions.GetSource(source)]
    end
end

function QBCore.Functions.GetPlayerByCitizenId(citizenid)
    for src, _ in pairs(QBCore.Players) do
        if QBCore.Players[src].PlayerData.citizenid == citizenid then
            return QBCore.Players[src]
        end
    end
    return nil
end

function QBCore.Functions.GetPlayerByPhone(number)
    for src, _ in pairs(QBCore.Players) do
        if QBCore.Players[src].PlayerData.charinfo.phone == number then
            return QBCore.Players[src]
        end
    end
    return nil
end

function QBCore.Functions.GetPlayers()
    local sources = {}
    for k, _ in pairs(QBCore.Players) do
        sources[#sources+1] = k
    end
    return sources
end

-- Will return an array of QB Player class instances
-- unlike the GetPlayers() wrapper which only returns IDs
function QBCore.Functions.GetQBPlayers()
    return QBCore.Players
end

--- Gets a list of all on duty players of a specified job and the number
function QBCore.Functions.GetPlayersOnDuty(job)
    local players = {}
    local count = 0
    for src, Player in pairs(QBCore.Players) do
        if Player.PlayerData.job.name == job then
            if Player.PlayerData.job.onduty then
                players[#players + 1] = src
                count += 1
            end
        end
    end
    return players, count
end

-- Returns only the amount of players on duty for the specified job
function QBCore.Functions.GetDutyCount(job)
    local count = 0
    for _, Player in pairs(QBCore.Players) do
        if Player.PlayerData.job.name == job then
            if Player.PlayerData.job.onduty then
                count += 1
            end
        end
    end
    return count
end

-- Routing buckets (Only touch if you know what you are doing)

-- Returns the objects related to buckets, first returned value is the player buckets, second one is entity buckets
function QBCore.Functions.GetBucketObjects()
    return QBCore.Player_Buckets, QBCore.Entity_Buckets
end

-- Will set the provided player id / source into the provided bucket id
function QBCore.Functions.SetPlayerBucket(source --[[ int ]], bucket --[[ int ]])
    if source and bucket then
        local discord = QBCore.Functions.GetIdentifier(source, 'discord')
        SetPlayerRoutingBucket(source, bucket)
        QBCore.Player_Buckets[discord] = {id = source, bucket = bucket}
        return true
    else
        return false
    end
end

-- Will set any entity into the provided bucket, for example peds / vehicles / props / etc.
function QBCore.Functions.SetEntityBucket(entity --[[ int ]], bucket --[[ int ]])
    if entity and bucket then
        SetEntityRoutingBucket(entity, bucket)
        QBCore.Entity_Buckets[entity] = {id = entity, bucket = bucket}
        return true
    else
        return false
    end
end

-- Will return an array of all the player ids inside the current bucket
function QBCore.Functions.GetPlayersInBucket(bucket --[[ int ]])
    local curr_bucket_pool = {}
    if QBCore.Player_Buckets and next(QBCore.Player_Buckets) then
        for _, v in pairs(QBCore.Player_Buckets) do
            if v.bucket == bucket then
                curr_bucket_pool[#curr_bucket_pool + 1] = v.id
            end
        end
        return curr_bucket_pool
    else
        return false
    end
end

-- Will return an array of all the entities inside the current bucket (not for player entities, use GetPlayersInBucket for that)
function QBCore.Functions.GetEntitiesInBucket(bucket --[[ int ]])
    local curr_bucket_pool = {}
    if QBCore.Entity_Buckets and next(QBCore.Entity_Buckets) then
        for _, v in pairs(QBCore.Entity_Buckets) do
            if v.bucket == bucket then
                curr_bucket_pool[#curr_bucket_pool + 1] = v.id
            end
        end
        return curr_bucket_pool
    else
        return false
    end
end

-- Callbacks

function QBCore.Functions.CreateCallback(name, cb)
    QBCore.ServerCallbacks[name] = cb
end

function QBCore.Functions.TriggerCallback(name, source, cb, ...)
    if not QBCore.ServerCallbacks[name] then return end
    QBCore.ServerCallbacks[name](source, cb, ...)
end

-- Items

---@param item string
---@param cb function
function QBCore.Functions.CreateUseableItem(item, cb)
    QBCore.UseableItems[item] = cb
end

function QBCore.Functions.UseItem(source, item)
    if  QBCore.UseableItems[item.name] then
        QBCore.UseableItems[item.name](source, item)
    end
end

-- Paycheck

CreateThread(function()
    while true do
        Wait(15 * 60 * 1000)
        if next(QBCore.Players) then
            for _, Player in pairs(QBCore.Players) do
                if Player then
                    local payment = Player.PlayerData.job.salary
                    if payment > 0 and Player.PlayerData.job.onduty then
                        Player.Functions.AddMoney('paycheck', payment, 'Recive Paycheck')
                        TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, 'You Recived Salary $'..payment, 'success')
                    end
                end
            end
        end
    end
end)

-- Kick Player

function QBCore.Functions.Kick(source, reason, setKickReason, deferrals)
    reason = '\n' .. reason .. '\n🔸 Check our Discord for further information: ' .. QBCore.Config.Server.Discord
    if setKickReason then
        setKickReason(reason)
    end
    CreateThread(function()
        if deferrals then
            deferrals.update(reason)
            Wait(2500)
        end
        if source then
            DropPlayer(source, reason)
        end
        for _ = 0, 4 do
            while true do
                if source then
                    if GetPlayerPing(source) >= 0 then
                        break
                    end
                    Wait(100)
                    CreateThread(function()
                        DropPlayer(source, reason)
                    end)
                end
            end
            Wait(5000)
        end
    end)
end

-- Setting & Removing Permissions

function QBCore.Functions.AddPermission(source, permission)
	local Player = QBCore.Functions.GetPlayer(source)
	if Player ~= nil then
		QBCore.Player_Permissions[QBCore.Functions.GetIdentifier(source, 'discord')] = permission:lower()
        QBCore.Commands.Refresh(source)
		TriggerClientEvent('QBCore:Client:OnPermissionUpdate', source, permission)
	end
end

function QBCore.Functions.RemovePermission(source)
	local Player = QBCore.Functions.GetPlayer(source)
	if Player ~= nil then
		QBCore.Player_Permissions[QBCore.Functions.GetIdentifier(source, 'discord')] = nil
        QBCore.Commands.Refresh(source)
        TriggerClientEvent('QBCore:Client:OnPermissionUpdate', source, 'user')
	end
end

-- Checking for Permission Level

function QBCore.Functions.HasPermission(source, permission)
    local retval = false
	local discord = QBCore.Functions.GetIdentifier(source, 'discord')
	local permission = tostring(permission:lower())
	if permission == "user" then
		retval = true
	else
		if QBCore.Player_Permissions[discord] then
            local myPerm = QBCore.Player_Permissions[discord]
            local level = 0
            local need = 0
            for k,v in ipairs(QBShared.PermissionsList) do
                if v.name == permission then
                    need = k
                end
                if v.name == myPerm then
                    level = k
                end
            end
            if level >= need then
                retval = true
            end
		end
	end
	return retval
end

function QBCore.Functions.GetPermission(source)
	local retval = "user"
	local discord = QBCore.Functions.GetIdentifier(source, 'discord')
	if QBCore.Player_Permissions[discord] ~= nil then
        retval = QBCore.Player_Permissions[discord]
    end
	return retval
end

function QBCore.Functions.HasDivision(source, division)
    if QBCore.Functions.GetPlayer(source).PlayerData.job.divs then
        return QBCore.Functions.GetPlayer(source).PlayerData.job.divs[division]
    else
        return nil
    end
end

-- Check if player is banned

function QBCore.Functions.IsPlayerBanned(plicense)
    local result = MySQL.single.await('SELECT * FROM bans WHERE license = ?', {plicense})
    if not result then return false end
    if os.time() < result.expire then
        local timeTable = os.date('*t', tonumber(result.expire))
        return true, 'You have been banned from the server:\n' .. result.reason .. '\nYour ban expires ' .. timeTable.day .. '/' .. timeTable.month .. '/' .. timeTable.year .. ' ' .. timeTable.hour .. ':' .. timeTable.min .. '\n'
    else
        MySQL.query('DELETE FROM bans WHERE id = ?', {result.id})
    end
    return false
end

-- Check for duplicate Identifiers

function QBCore.Functions.IsIdentifierDublicate(dis)
    local players = GetPlayers()
    for _, player in pairs(players) do
        local discord = QBCore.Functions.GetIdentifier(player, 'discord')
        if dis == discord then
            return true
        end
    end
    return false
end

-- Utility functions

function QBCore.Functions.HasItem(source, item, amount, withbackpack, noQuality)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return false end
    if type(item) ~= 'string' then return end
    if not amount then amount = 1 end
    local count = 0
    local max = QBConfig.Player.MaxInvSlots
    if withbackpack then
        max = QBConfig.Player.BackPackSlot + QBConfig.Player.MaxInvSlots
    end
    for i=1, max do
        local data = Player.PlayerData.items[i]
        if data then
            if data.name == item and (noQuality or not data.info.quality or data.info.quality > 0) then
                count = count + data.amount
            end
        end
    end
    if amount <= count then
        return true
    else
        return false
    end
end

function QBCore.Functions.Notify(source, text, type, length)
    TriggerClientEvent('QBCore:Notify', source, text, type, length)
end

local subtype={}
RegisterNetEvent('qb-core:client:getsub', function(subname)
    local src = source
    subtype[src] = subname
end)

function QBCore.Functions.Getsub(src)
    return subtype[src]
end