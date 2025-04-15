local avBusiness = false
local qbox = GetResourceState('qbx_core') == "started"
-- Get Framework Core
function getCore()
    if not Core then
        if Config.Framework == "qb" then
            return exports['qb-core']:GetCoreObject()
        elseif Config.Framework == "esx" then
            return exports['es_extended']:getSharedObject()
        end
    end
    return Core
end

-- Register Item
function registerItem(name, cb)
    if Config.Framework == "qb" then
        Core.Functions.CreateUseableItem(name, cb)
    elseif Config.Framework == "esx" then
        Core.RegisterUsableItem(name,cb)
    end
end

-- Get Player ID by identifier
function getSourceByIdentifier(identifier)
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayerByCitizenId(identifier)
        if Player then
            return Player.PlayerData.source
        end
    elseif Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromIdentifier(identifier)
        if xPlayer then
            return xPlayer.source
        end
    end
    return false
end

function getPlayerByIdentifier(identifier)
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayerByCitizenId(identifier)
        if Player then
            return Player
        end
    elseif Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromIdentifier(identifier)
        if xPlayer then
            return xPlayer
        end
    end
    return false
end

-- Save Player
function savePlayer(source)
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayer(source)
        if Player then
            Player.Functions.Save()
        end
    elseif Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(source)
        if Core.SavePlayer and xPlayer then
            Core.SavePlayer(xPlayer)
        end
    end
end

-- Get Player Permission Level
function getPermission(src, level)
    if Config.Framework == "qb" then
        -- print(src, level)
        -- print(IsPlayerAceAllowed(src, level))
        -- print(Core.Functions.HasPermission(src, level))
        if IsPlayerAceAllowed(src, level) or Core.Functions.HasPermission(src, level) then
            return true
        end
    elseif Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(src)
        return xPlayer.getGroup() == level
    end
    return false
end

-- Get Player Identifier
function getIdentifier(src)
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayer(src)
        if Player then
            return Player.PlayerData.citizenid
        end
    elseif Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(src)
        if xPlayer then
            return xPlayer.identifier
        end
    end
    return false
end

-- Get Player Object
function getPlayer(src)
    if Config.Framework == "qb" then
        return Core.Functions.GetPlayer(src)
    elseif Config.Framework == "esx" then
        return Core.GetPlayerFromId(src)
    end
end

-- Add Item to player
function addItem(src, item, amount, info, slot)
    if not src then return false end
    if Config.Inventory and Config.Inventory == "ox_inventory" then
        return exports.ox_inventory:AddItem(src, item, amount, info, slot)
    end
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayer(src)
        return Player.Functions.AddItem(item, amount, false, info)
    elseif Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(src)
        if xPlayer.canCarryItem(item, amount) then
            if Config.Inventory == "qs-inventory" then
                exports['qs-inventory']:AddItem(src, item, amount, slot, info)
            else
                xPlayer.addInventoryItem(item, amount, info)
            end
            return true
        end
    end
    return false
end

-- Remove Item from Player
function removeItem(src, item, amount, slot, metadata)
    if not src then return false end
    local amount = amount or 1
    if Config.Inventory and Config.Inventory == "ox_inventory" then
        return exports['ox_inventory']:RemoveItem(src, item, amount, metadata, slot)
    elseif Config.Inventory == "qb-inventory" and not Config.OldQBInventory then
        return exports[Config.Inventory]:RemoveItem(src, item, amount, slot)
    else
        return exports[Config.Inventory]:RemoveItem(src, item, amount, slot, metadata)
    end
end

-- Set Item metadata
function setItemMetadata(src, item, slot, metadata)
    if Config.Inventory == "ox_inventory" then
        exports['ox_inventory']:SetMetadata(src, slot, metadata)
        return
    end
    if Config.Inventory == 'qs-inventory' then
        exports['qs-inventory']:SetItemMetadata(src, slot, metadata)
        return
    end
    if Config.Inventory == "origen_inventory" then
        local name = item
        if type(name) == "table" then
            name = item.name
        end
        exports['origen_inventory']:SetItemMetadata(src, name, slot, metadata)
        return
    end
    exports[Config.Inventory]:SetItemData(src, item, 'info', metadata, slot)
end

-- Set Item Metadata in Stash, don't ask me why there's 2 exports doing (almost) exactly the same -.-
function setItemMetadataStash(stash, item, slot, metadata)
    --    print(stash, item, slot, json.encode(metadata))
    if Config.Inventory == "ox_inventory" then
        exports['ox_inventory']:SetMetadata(stash, slot, metadata)
        return
    end
end

-- Get Player money
function getMoney(src, account)
    if not src then return false end
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayer(src)
        if Config.CustomCryptos and Config.CustomCryptos[account] then
            if Player.PlayerData.metadata.crypto and Player.PlayerData.metadata.crypto[account] then
                return Player.PlayerData.metadata.crypto[account]
            else
                return false
            end
        else
            return Player.PlayerData.money[account]
        end
    elseif Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(src)
        if xPlayer and xPlayer.getAccount(account) then
            return xPlayer.getAccount(account).money
        else
            return false
        end
    end
end

-- Add Money
function addMoney(src, account, amount)
    if not src then return false end
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayer(src)
        if Config.CustomCryptos and Config.CustomCryptos[account] then
            local Crypto = Player.PlayerData.metadata.crypto
            if Crypto then
                Crypto[account] = Crypto[account] + tonumber(amount)
                Player.Functions.SetMetaData("crypto", Crypto)
            end
        else
            Player.Functions.AddMoney(account, amount)
        end
    elseif Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(src)
        xPlayer.addAccountMoney(account, amount)
    end
end

-- Add Money to Offline Player
function addMoneyOffline(identifier, account, amount)
    if Config.Framework == "qb" then
        local result = MySQL.query.await('SELECT * FROM players WHERE citizenid = ?', { identifier })
        if result and result[1] then
            local RecieverMoney = json.decode(result[1].money)
            RecieverMoney[account] = (RecieverMoney[account] + amount)
            MySQL.update.await('UPDATE players SET money = ? WHERE citizenid = ?',
                { json.encode(RecieverMoney), identifier })
        end
    elseif Config.Framework == "esx" then
        local result = MySQL.query.await('SELECT * FROM users WHERE identifier = ?', { identifier })
        if result and result[1] then
            local RecieverMoney = json.decode(result[1].accounts)
            RecieverMoney[account] = (RecieverMoney[account] + amount)
            MySQL.update.await('UPDATE users SET accounts = ? WHERE identifier = ?',
                { json.encode(RecieverMoney), identifier })
        end
    end
end

-- Remove money from player
function removeMoney(src, account, amount)
    if not src then return false end
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayer(src)
        if Config.CustomCryptos and Config.CustomCryptos[account] then
            local Crypto = Player.PlayerData.metadata.crypto
            if not Crypto or not Crypto[account] then return end
            Crypto[account] = Crypto[account] - amount
            Player.Functions.SetMetaData("crypto", Crypto)
        else
            Player.Functions.RemoveMoney(account, amount)
        end
    elseif Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(src)
        xPlayer.removeAccountMoney(account, amount)
    end
end

-- Has item?
function hasItem(src, name, amount)
    if not src then return false end
    local qty = 1
    if tonumber(amount) then
        qty = tonumber(amount)
    end
    if Config.Framework == "qb" then
        if Config.Inventory == "ox_inventory" then
            local item = exports['ox_inventory']:GetItem(src, name, nil, true)
            if item and tonumber(item) >= qty then
                return true
            end
        else
            return exports[Config.Inventory]:HasItem(src, name, qty)
        end
    elseif Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(src)
        local item = xPlayer.getInventoryItem(name)
        if item and item['count'] >= qty then
            return true
        end
    end
    return false
end

-- Get Player Job
function getJob(src)
    if not src then return false end
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayer(src)
        return Player.PlayerData.job
    elseif Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(src)
        return xPlayer.getJob()
    end
end

-- Check if player have X job or job type
function hasJob(source,job)
    if not source or not job then
        print("^3[WARNING] hasJob exports received null as argument (source, job):", source, job)
        return false
    end
    local PlayerJob = getJob(source)
    if type(job) == "string" then
        if PlayerJob and (PlayerJob.name == job or PlayerJob.type == job) then
            return true
        end
    else
        for _, name in pairs(job) do
            if PlayerJob.name == name or PlayerJob.type == name then
                return true
            end
        end
    end
    return false
end

-- Get Player Name
function getName(src)
    if not src then return false end
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayer(src)
        if Player then
            return Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
        end
    elseif Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(src)
        if xPlayer then
            return xPlayer.getName()
        end
    end
    return false
end

function getMetadata(item, info)
    if item and (item.info or item.metadata) then
        local metadata = item.info or item.metadata
        return metadata, item.slot
    end
    if info and (info.info or info.metadata) then
        local metadata = info.info or info.metadata
        return metadata, info.slot
    end
end

function getInventoryItem(source, name)
    if Config.Inventory == "ox_inventory" then
        return exports.ox_inventory:GetItem(source, name)
    end
    if Config.Inventory == "origen_inventory" then
        return exports.origen_inventory:GetItemByName(source, name)
    end
    return exports[Config.Inventory]:GetItemByName(source, name)
end

-- Get All items from Player
function GetInventoryItems(source)
    if Config.Inventory == "ox_inventory" then
        return exports['ox_inventory']:GetInventoryItems(source)
    end
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayer(source)
        if Player then
            return Player.PlayerData.items
        end
    end
    if Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(source)
        if xPlayer then
            return xPlayer.getInventory()
        end
    end
    return {}
end

-- Get all players from X job
function getJobPlayers(job)
    if Config.Framework == "qb" then
        local data = {}
        local added = {}
        local Players = Core.Functions.GetQBPlayers()
        for k, v in pairs(Players) do
            if v['PlayerData']['job']['name'] == job then
                data[#data + 1] = {
                    identifier = v['PlayerData']['citizenid'],
                    name = v.PlayerData.charinfo.firstname .. ' ' .. v.PlayerData.charinfo.lastname,
                    grade = v.PlayerData.job.grade,
                }
                added[v['PlayerData']['citizenid']] = true
            end
        end
        local Players2 = MySQL.query.await("SELECT * FROM players WHERE job LIKE '%" .. job .. "%'", {})
        for k, v in pairs(Players2) do
            if not added[v['citizenid']] then
                local Player = getPlayerByIdentifier(v['citizenid'])
                if Player then
                    if Player.PlayerData.job.name == job then
                        data[#data + 1] = {
                            identifier = v['citizenid'],
                            name = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname,
                            grade = Player.PlayerData.job.grade,
                        }
                    end
                else
                    data[#data + 1] = {
                        identifier = v['citizenid'],
                        name = json.decode(v['charinfo']).firstname .. ' ' .. json.decode(v['charinfo']).lastname,
                        grade = json.decode(v['job']).grade,
                    }
                end
            end
        end
        return data
    elseif Config.Framework == "esx" then
        local data = {}
        local Players = MySQL.query.await("SELECT * FROM users WHERE job = ?", { job })
        for k, v in pairs(Players) do
            local xPlayer = getPlayerByIdentifier(v['identifier'])
            if xPlayer then
                local job = xPlayer.getJob()
                data[#data + 1] = {
                    identifier = v['identifier'],
                    name = xPlayer.getName(),
                    grade = { name = job.grade_label, level = job.grade },
                }
            else
                if Core.Jobs and not Core.Jobs[v['job']] then
                    Core = exports['es_extended']:getSharedObject()
                end
                local jobs = Core.Jobs[v['job']]
                local myGrade = jobs['grades'][tostring(v['job_grade'])]
                data[#data + 1] = {
                    identifier = v['identifier'],
                    name = v['firstname'] .. ' ' .. v['lastname'],
                    grade = { name = myGrade['label'], level = v['job_grade'] },
                }
            end
        end
        return data
    end
end

function setJob(target, job)
    target = tonumber(target)
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayer(target)
        if Player then
            if Core.Shared.Jobs[job] then
                Player.Functions.SetJob(job, 0)
                local jobData = Core.Shared.Jobs[job]['grades']['0']
                if not jobData then
                    jobData = Core.Shared.Jobs[job]['grades'][0] or Core.Shared.Jobs[job]['grades'][1]
                end
                if jobData then
                    local info = {
                        name = jobData['name'],
                        onduty = true,
                        isboss = false,
                        payment = jobData['payment'],
                        grade = { name = jobData['name'], level = 0 }
                    }
                    MySQL.update.await('UPDATE players SET job = ? WHERE citizenid = ?',
                        { json.encode(info), Player.PlayerData.citizenid })
                    return true
                else
                    print("^3[WARNING]^7 Job "..job.." doesn't have grade 0 or 1")
                end
            end
        end
    elseif Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(target)
        if xPlayer then
            xPlayer.setJob(job, 0)
            MySQL.update.await('UPDATE users SET job = ?, job_grade = ? WHERE identifier = ?', { job, 0, xPlayer
                .identifier })
            return true
        end
    end
    return false
end

function setJobGrade(identifier, job, grade)
    local grade = grade
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayerByCitizenId(identifier)
        local jobData = Core.Shared.Jobs[job]['grades'][grade]
        if not jobData then
            grade = tonumber(grade)
            jobData = Core.Shared.Jobs[job]['grades'][grade]
        end
        if not jobData then
            print("^3[WARNING] ^7Job grade "..grade.." not found in job "..job)
            return 
        end
        if Player then
            Player.Functions.SetJob(job, grade)
        end
        local info = {
            name = job,
            onduty = true,
            isboss = jobData['isboss'],
            payment = jobData['payment'],
            grade = { name = jobData['name'], level = grade }
        }
        MySQL.update.await('UPDATE players SET job = ? WHERE citizenid = ?', { json.encode(info), identifier })
    elseif Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromIdentifier(identifier)
        if xPlayer then
            xPlayer.setJob(job, grade)
        end
        MySQL.update.await('UPDATE users SET job = ?, job_grade = ? WHERE identifier = ?', { job, grade, identifier })
    end
end

function toggleDuty(source,state)
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayer(source)
        if Player then
            Player.Functions.SetJobDuty(state)
        end
    end
end

function Discord(webhook, message)
    PerformHttpRequest(webhook, function() end, 'POST', json.encode({ username = 'AV Scripts', embeds = message }),
        { ['Content-Type'] = 'application/json' })
end

function getPhone(source)
    local phone = ""
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayer(source)
        if Player then
            phone = Player.PlayerData.charinfo.phone
        end
    elseif Config.Framework == "esx" then

    end
    return phone
end

function addToStash(name, item, count, metadata, slot)
    if Config.Inventory == "qs-inventory" then
        return exports['qs-inventory']:AddItemIntoStash(name, item, count, slot, metadata)
    end
    if Config.Inventory == "ox_inventory" then
        local success, response = exports['ox_inventory']:AddItem(name, item, count, metadata, slot)
        return success
    end
    if Config.Inventory == "origen_inventory" then
        exports[Config.Inventory]:AddStashItem(name, slot, slot, item, count, metadata)
        TriggerEvent("inventory:server:SaveInventory", "stash", name)
        return 
    end
    if Config.Inventory == "qb-inventory" and not Config.OldQBInventory then
        print(name, item, count, slot, metadata)
        local res = exports[Config.Inventory]:AddItem(name, item, count, slot, metadata, false)
        print(res)
        return res
    else
        local res = exports[Config.Inventory]:addStashItem(name, slot, slot, item, count, metadata)
        exports[Config.Inventory]:SaveStashById(name)
        return res
    end
end

function getStashItems(name)
    if Config.Inventory == "ox_inventory" then
        local inv = exports['ox_inventory']:GetInventory(name)
        if inv and inv.items then
            return inv.items
        end
    else
        if Config.Inventory == "qb-inventory" and not Config.OldQBInventory then
            local inventories = MySQL.single.await('SELECT `items` FROM `inventories` WHERE `identifier` = ?', {
                name
            })
            if inventories and inventories['items'] then
                return json.decode(inventories['items'])
            end
        else
            local items = exports[Config.Inventory]:GetStashItems(name)
            if items then
                return items
            end
        end
    end
    return false
end

-- Delete all stash items
function wipeStash(name)
    if Config.Inventory == "ox_inventory" then
        exports['ox_inventory']:ClearInventory(name)
        return
    end
    if Config.Inventory == "qs-inventory" then
        local items = getStashItems(name)
        if items and next(items) then
            for k, v in pairs(items) do
                exports['av_laptop']:removeStashItem(name, v['name'], v['amount'], nil, v['slot'])
            end
        end
        return
    end
    if Config.Inventory == "origen_inventory" then
        local name = "stash_"..name
        local exists = MySQL.single.await('SELECT `items` FROM `stashitems` WHERE `stash` = ?', {
            name
        })
        if exists and exists['items'] then
            local empty = {}
            MySQL.update.await('UPDATE `stashitems` SET `items` = ? WHERE `stash` = ?', {
                json.encode(empty), name
            })
        end
        return
    end
    return exports[Config.Inventory]:WipeStash(name)
end

-- Remove a specific item from a stash
-- Remove a specific item from a stash
function removeStashItem(inv, item, count, metadata, slot)
    if Config.Inventory == "ox_inventory" then
        exports['ox_inventory']:RemoveItem(inv, item, count, metadata, slot)
        return
    end
    if Config.Inventory == "qs-inventory" then
        exports['qs-inventory']:RemoveItemIntoStash(inv, item, count, slot)
    else
        if Config.Inventory == "qb-inventory" and not Config.OldQBInventory then
            export[Config.Inventory]:RemoveItem(inv, item, count, slot)
        else
            exports[Config.Inventory]:RemoveFromStash(inv, slot, item, count)
            Texports[Config.Inventory]:SaveStashById(inv)
        end
    end
end

-- Register new stash (needed for ox_inventory)
function registerStash(name, label, slots, weight)
    if Config.Inventory == "ox_inventory" then
        exports['ox_inventory']:RegisterStash(name, label or name, slots, weight)
        return true
    end
    if Config.Inventory == "origen_inventory" then
        exports['origen_inventory']:RegisterStash(name, {
            label = name or label,
            slots = slots or 10,
            weight = weight or 10
        })
        return true
    end
    return false
end

function canCarryItem(inventory, item, amount)
    if Config.Inventory == "ox_inventory" then
        return exports.ox_inventory:CanCarryItem(inventory, item, amount)
    end
    return true -- WIP
end

-- Is Player boss?
function isBoss(src)
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayer(src)
        return Player.PlayerData.job.isboss
    elseif Config.Framework == "esx" then
		local xPlayer = Core.GetPlayerFromId(src)
		return Config.BossGrades[xPlayer.job.grade_name]
    end
    return false
end

function getJobData(job)
    if Config.Framework == "qb" then
        return Core.Shared.Jobs[job]
    elseif Config.Framework == "esx" then
		if Core.Jobs and not Core.Jobs[job] then
            Core = exports['es_extended']:getSharedObject()
        end
        return Core.Jobs[job]
    end
    return false
end

-- Get all available grades from X job
function getJobGrades(job)
    local grades = {}
    if Config.Framework == "qb" then
        local jobData = Core.Shared.Jobs[job]
        if jobData then
            for k, v in pairs(jobData.grades) do
                grades[#grades+1] = {
                    value = tostring(k),
                    label = v.name
                }
            end
        end
    elseif Config.Framework == "esx" then
        if not Core or not Core.Jobs then
            Core = exports['es_extended']:getSharedObject()
        end
        if not Core.Jobs[job] then
            Core = exports['es_extended']:getSharedObject() -- don't ask me why, this shitty Framework gives a lot of problems -.-
        end
        if Core and Core.Jobs[job] then
            local jobData = Core.Jobs[job].grades
            for k, v in pairs(jobData) do
                grades[#grades+1] = {
                    value = k,
                    label = v.label
                }
            end
        else
            print("[ERROR] Job "..job.." doesn't exist in Core? couldn't be found in Core.Jobs table")
        end
    end
    return grades
end

-- Get all available jobs names and label (return a table with name and label)
function getAllJobs()
    if Config.Framework == "qb" then
        local allJobs = Core.Shared.Jobs
        local result = {}
        for k, v in pairs(allJobs) do
            result[#result+1] = {
                name = k,
                label = v['label']
            }
        end
        return result
    end
    if Config.Framework == "esx" then
        local allJobs = MySQL.query.await("SELECT * FROM jobs")
        local result = {}
        for k, v in pairs(allJobs) do
            result[#result+1] = {
                name = v['name'],
                label = v['label']
            }
        end
        return result
    end
    return {}
end

-- Returns society money or false
function getSociety(name)
    if not name then print('[ERROR] Function getSociety received NULL as argument') return end
    local res = MySQL.single.await('SELECT money FROM av_society WHERE job = ?', {name})
    if res and res['money'] then
        return res['money']
    else
        return false
    end
end

function addSociety(src, job, amount, name, description)
    if avBusiness then
        exports['av_business']:addMoney(name, job, amount, description)
        if GetInvokingResource() ~= "av_business" then
            exports['av_business']:addIncome(job,amount,true)
        end
    end
    local exists = getSociety(job)
    if exists then
        MySQL.update.await('UPDATE av_society SET money = (money + ?) WHERE job = ?', {amount, job})
    else
        MySQL.insert.await('INSERT INTO av_society (job, money) VALUES (?, ?)', {job, amount})
    end
end

function removeSociety(src, job, amount, name, description)
    if avBusiness then
        exports['av_business']:removeMoney(name, job, amount, description)
    end
    MySQL.update.await('UPDATE av_society SET money = (money - ?) WHERE job = ?', {amount, job})
end

function newSociety(job, label) -- Triggered when getSociety returns false in av_business:
    MySQL.insert.await('INSERT INTO av_society (job, money) VALUES (?, ?)', {job, 0})
end

function setOfflineJob(identifier, jobName)
    if Config.Framework == "qb" then
        local jobData = Core.Shared.Jobs[jobName] and Core.Shared.Jobs[jobName]['grades']['0'] or false
        if not jobData then
            jobData = Core.Shared.Jobs[jobName] and Core.Shared.Jobs[jobName]['grades'][0] or Core.Shared.Jobs[jobName] and Core.Shared.Jobs[jobName]['grades'][1]
        end
        local newJob = {
            name = jobData['name'] or "unemployed",
            onduty = true,
            isboss = false,
            payment = jobData['payment'] or 10,
            grade = { name = jobData['name'] or "Freelancer", level = 0 }
        }
        MySQL.update.await('UPDATE players SET job = ? WHERE citizenid = ?', { json.encode(newJob), identifier })
    elseif Config.Framework == "esx" then
        MySQL.update.await('UPDATE users SET job = ?, job_grade = ? WHERE identifier = ?',
            { jobName, 0, identifier })
    end
end

function itemExists(item)
    if Config.Inventory == "ox_inventory" then
        local items = exports['ox_inventory']:Items()
        return items[item]
    end
    if Config.Framework == 'qb' then
        return Core.Shared.Items[name]
    elseif Config.Framework == 'esx' then
        if Core and not Core.Items then
            Core = exports['es_extended']:getSharedObject()
        end
        return Core.Items[name]
    end
end

function getItemBySlot(source,slot)
    if Config.Inventory == "ox_inventory" then
        return exports['ox_inventory']:GetSlot(source, slot)
    end
    return exports[Config.Inventory]:GetItemBySlot(source, slot)
end

function getNumPlayersFromJob(job) -- used by /cops.lua to get online players from specific job/job type
    if not job then return end
    local amount = 0
    if type(job) == "string" then
        if alreadyCounted[job] then
            return alreadyCounted[job]
        end
    end
    if Config.Framework == "qb" then
        if type(job) == "string" then
            if qbox then
                local count, players = exports['qbx_core']:GetDutyCountType(job)
                return count
            else
                local players = Core.Functions.GetQBPlayers()
                for _, v in pairs(players) do
                    if v and (v.PlayerData.job.type == job or v.PlayerData.job.name == job) and v.PlayerData.job.onduty then
                        amount += 1
                        alreadyCounted[job] = amount
                    end
                end
            end
        else
            if qbox then
                local count, players = exports['qbx_core']:GetDutyCountType(job)
                amount += 1
                alreadyCounted[job] = amount
            else
                local players = Core.Functions.GetQBPlayers()
                for _, v in pairs(job) do
                    if qbox then
                        local count, players = exports['qbx_core']:GetDutyCountType(job)
                        amount += count
                        alreadyCounted[v] = amount
                    end
                    for _, j in pairs(players) do
                        if j and (j.PlayerData.job.type == v or j.PlayerData.job.name == v) and j.PlayerData.job.onduty then
                            amount += 1
                            alreadyCounted[v] = amount
                        end
                    end
                end
            end
        end
    elseif Config.Framework == "esx" then
        if type(job) == "string" then
            local xPlayers = Core.GetExtendedPlayers('job', job)
            amount = #xPlayers
            alreadyCounted[job] = amount
        else
            for _, v in pairs(job) do
                local xPlayers = Core.GetExtendedPlayers('job', v)
                amount += #xPlayers
                alreadyCounted[v] = amount
            end
        end
    end
    return amount
end

-- Export List
exports('getSourceByIdentifier', getSourceByIdentifier)
exports('getPlayerByIdentifier', getPlayerByIdentifier)
exports('getPermission', getPermission)
exports('getIdentifier', getIdentifier)
exports('getPlayer', getPlayer)
exports('savePlayer', savePlayer)
exports('registerItem', registerItem)
exports('addItem', addItem)
exports('removeItem', removeItem)
exports('getMoney', getMoney)
exports('addMoney', addMoney)
exports('addMoneyOffline', addMoneyOffline)
exports('removeMoney', removeMoney)
exports('hasItem', hasItem)
exports('getJob', getJob)
exports('hasJob', hasJob)
exports('getName', getName)
exports('getMetadata', getMetadata)
exports('getItem', getItem)
exports('getInventoryItem', getInventoryItem)
exports('getJobPlayers', getJobPlayers)
exports('setJob', setJob)
exports('setJobGrade', setJobGrade)
exports('toggleDuty', toggleDuty)
exports('setOfflineJob', setOfflineJob)
exports('Discord', Discord)
exports('getPhone', getPhone)
exports('canCarryItem', canCarryItem)
exports('addToStash', addToStash)
exports('getStashItems', getStashItems)
exports('wipeStash', wipeStash)
exports('removeStashItem', removeStashItem)
exports('registerStash', registerStash)
exports('isBoss', isBoss)
exports('getJobData', getJobData)
exports('getJobGrades', getJobGrades)
exports('newSociety', newSociety)
exports('removeSociety', removeSociety)
exports('addSociety', addSociety)
exports('getSociety', getSociety)
exports('getAllJobs', getAllJobs)
exports('itemExists', itemExists)
exports('getItemBySlot', getItemBySlot)
exports('getCore', getCore)
exports('setItemMetadata', setItemMetadata)
exports('getNumPlayersFromJob', getNumPlayersFromJob)
exports('getInventoryItems', GetInventoryItems)
exports('avBusiness', function() avBusiness = true end)