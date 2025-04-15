local QBCore = exports['qb-core']:GetCoreObject()
local LoadSQL = false

QBCore.Functions.CreateCallback('re2-vault:server:createStorage', function(source,cb,data)
	local src = source
    local storages= MySQL.Sync.fetchAll('SELECT storagename,storage_location FROM vaults WHERE citizenid = ? And storagename = ? AND storage_location = ?',{data.cid,data.storagename,data.storagelocation})
    if next(storages) then
        return cb(false)
    else
        local timeinday = data.days * 86400
        local endtime = tonumber(os.time() + timeinday)
        local storage = MySQL.Sync.execute('INSERT INTO vaults (`citizenid`, `password`, `storagename`,`storage_location`,`storage_size`,`expirerent`) VALUES (?, ?, ?, ?, ?,?)',{data.cid,data.password,data.storagename,data.storagelocation,data.storagesize,endtime})
        return cb(true)
    end
    
end)

QBCore.Functions.CreateCallback('re2-vault:server:fetchStorage', function(source,cb,data)
    
	local src = source
    local cid = string.lower('%'..data.cid..'%')
    local storages= MySQL.Sync.fetchAll('SELECT id,citizenid,storagename,storage_location,storage_size,expirerent FROM vaults WHERE (LOWER(citizenid) like ? OR LOWER(holders) like ? ) AND storage_location = ? ',{cid,cid,data.storagelocation})
    if next(storages) then
        local timeTable = os.date('*t', storages[1].expirerent)
        storages[1].expire=timeTable['year'].." / "..timeTable['month'].." / " ..timeTable['day'] 
        return cb(storages)
    else
        return cb(false)
    end
    
end)

QBCore.Functions.CreateCallback('re2-vault:server:addday', function(source,cb,data)
	local src = source
    local storages= MySQL.Sync.fetchAll('SELECT id,citizenid,storagename,storage_location,storage_size,expirerent FROM vaults WHERE  id = ? ',{data.storagelocation})
    if next(storages) then
        local timeinday = data.days * 86400
        local endtime = tonumber(storages[1].expirerent + timeinday)
        MySQL.Async.execute('update vaults set expirerent=? where id=? ',{endtime,data.storagelocation})
        return cb(storages)
    else
        return cb(false)
    end
    
end)

QBCore.Functions.CreateCallback('re2-vault:server:fetchStoragejob', function(source,cb,data)
	local src = source
    local storages= MySQL.Sync.fetchAll('SELECT id,citizenid,storagename,storage_location,storage_size,expirerent FROM vaults WHERE  storage_location = ? ',{data.storagelocation})
    if next(storages) then
        local timeTable = os.date('*t', storages[1].expirerent)
        storages[1].expire=timeTable['year'].." / "..timeTable['month'].." / ".. timeTable['day']
        return cb(storages)
    else
        return cb(false)
    end
    
end)

QBCore.Functions.CreateCallback('re2-vault:server:fetchStorageinlocation', function(source,cb,data)
	local src = source
    local storages= MySQL.Sync.fetchAll('SELECT id,citizenid,storagename,storage_location,storage_size FROM vaults WHERE storage_location = ? ',{data.storagelocation})
    if next(storages) then
        return cb(storages)
    else
        return cb(false)
    end
end)
QBCore.Functions.CreateCallback('re2-vault:server:fetchStorageinlocationbycid', function(source,cb,data)
	local src = source
    local storages= MySQL.Sync.fetchAll("SELECT id,citizenid,storagename,storage_location,storage_size FROM vaults WHERE storage_location = ? and (citizenid=? or holders like '%"..data.cid.."%')",{data.storagelocation,data.cid})
    if next(storages) then
        return cb(storages)
    else
        return cb(false)
    end
end)

QBCore.Functions.CreateCallback('re2-vault:server:getstoragemember', function(source,cb,data)
	local src = source
   
    local storage= MySQL.Sync.fetchAll('SELECT holders FROM vaults WHERE id = ?',{data.id})
    if next(storage) then
        storage[1].members={}
        local holders=json.decode(storage[1].holders)
        for k, v in pairs(holders) do
            local chname= MySQL.Sync.fetchAll('SELECT charinfo FROM players WHERE citizenid = ?',{v})
            charinf=json.decode(chname[1].charinfo)
            storage[1].members[#storage[1].members+1]={cid=v,name=charinf.firstname..' '..charinf.lastname}
        end
        return cb(storage[1])
    else
        return cb(false)
    end
end)

QBCore.Functions.CreateCallback('re2-vault:server:checkThePassword', function(source,cb,data)
	local src = source
    local storage= MySQL.Sync.fetchAll('SELECT id,citizenid,storagename,storage_location,storage_size FROM vaults WHERE id = ? And password = ? ',{data.id,data.password})
    if next(storage) then
        return cb(storage)
    else
        return cb(false)
    end
end)

QBCore.Functions.CreateCallback('re2-vault:server:checkThePasswordjob', function(source,cb,data)
	local src = source
    local storage= MySQL.Sync.fetchAll('SELECT id,citizenid,storagename,storage_location,storage_size FROM vaults WHERE id = ? ',{data.id})
    if next(storage) then
        return cb(storage)
    else
        return cb(false)
    end
end)

QBCore.Functions.CreateCallback('re2-vault:server:addMember', function(source,cb,data)
	local src = source
    local holders
    local storage= MySQL.Sync.fetchAll('SELECT id,citizenid,storagename,storage_location,storage_size,holders FROM vaults WHERE id = ? ',{data.id})
    if next(storage) then
        if storage[1].holders then
           holders =json.decode(storage[1].holders)
        else
            holders= {}
        end

        table.insert(holders,data.citizenid)
        MySQL.Async.execute("UPDATE vaults SET `holders`=:holders WHERE `id`=:id LIMIT 1", {
            holders = json.encode(holders),
            id = data.id
        }, function(r)
            if r then
                return cb(r)
            end
        end)
    else
        return cb(false)
    end
    
end)
QBCore.Functions.CreateCallback('re2-vault:server:changePassword', function(source,cb,data)
	local src = source
    local storage= MySQL.Sync.fetchAll('SELECT id,citizenid,storagename,storage_location,storage_size,holders FROM vaults WHERE id = ? ',{data.id})
    if next(storage) then
        MySQL.Async.execute("UPDATE vaults SET `password`=:password WHERE `id`=:id LIMIT 1", {
            password = data.password,
            id = data.id
        }, function(r)
            if r then
                return cb(r)
            end
        end)
    else
        return cb(false)
    end
    
end)


QBCore.Functions.CreateCallback('re2-vault:server:removeMember', function(source,cb,data)
	local src = source
    local holders
    local storage= MySQL.Sync.fetchAll('SELECT id,citizenid,storagename,storage_location,storage_size,holders FROM vaults WHERE id = ? ',{data.id})
    if next(storage) then
        local temHolders={}
        if storage[1].holders then
           holders =json.decode(storage[1].holders)
        else
            holders= {}
        end

        for k, v in pairs(holders) do
            if v ~= data.citizenid then
                table.insert(temHolders,v)
            end
        end
        MySQL.Async.execute("UPDATE vaults SET `holders`=:holders WHERE `id`=:id LIMIT 1", {
            holders = json.encode(temHolders),
            id = data.id
        }, function(r)
            if r then
                return cb(r)
            end
        end)
    else
        return cb(false)
    end
    
end)

QBCore.Functions.CreateCallback('re2-vault:server:addCapacity', function(source,cb,data)
	local src = source
    local holders
    local storage= MySQL.Sync.fetchAll('SELECT id,citizenid,storagename,storage_location,storage_size,holders FROM vaults WHERE id = ? ',{data.id})
    if next(storage) then
        local storage_size = storage[1].storage_size + Config.StorageAddStep
        MySQL.Async.execute("UPDATE vaults SET `storage_size`=:storage_size WHERE `id`=:id LIMIT 1", {
            storage_size = storage_size,
            id = data.id
        }, function(r)
            if r then
                return cb(r)
            end
        end)
    else
        return cb(false)
    end
    
end)


RegisterServerEvent('re2-vault:server:removeMoney')
AddEventHandler('re2-vault:server:removeMoney', function(price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveMoney('bank', price, "buy-storage")
end)


MySQL.ready(function()
	LoadSQL = true
end)

CreateThread(function()
    while not LoadSQL do
        Wait(1000)
    end
    while true do
        local sqlresult = MySQL.Sync.fetchAll('SELECT id,expirerent,storage_location FROM vaults', {})
        local currentTime = os.time()
        for _, row in pairs(sqlresult) do
            local timeInDB = tonumber(row.expirerent)
            if currentTime > timeInDB then
                MySQL.Sync.execute('DELETE FROM vaults WHERE id = ?', {row.id})
                MySQL.Sync.execute("DELETE FROM stashitems WHERE stash = 'PStorage_"..row.storage_location.."'", {})
                
            end
        end
        Wait(3600000)
    end
end)