local DB_TABLES = { users = "identifier" }
local hasDonePreloading = {}
local QBCore = exports['qb-core']:GetCoreObject()
local function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end
local function RegisterCallback(name, cb)
    RegisterNetEvent(name, function(id, args)
        local src = source
        local eventName = "0r-multichar:triggerCallback:" .. id
        CreateThread(function()
            local result = cb(src, table.unpack(args))
            TriggerClientEvent(eventName, src, result)
        end)
    end)
end

local function loadHouseData(src)
    -- local HouseGarages = {}
    -- local Houses = {}
    -- local result = MySQL.query.await('SELECT * FROM houselocations', {})
    -- if result[1] ~= nil then
    --     for _, v in pairs(result) do
    --         local owned = false
    --         if tonumber(v.owned) == 1 then
    --             owned = true
    --         end
    --         local garage = v.garage ~= nil and json.decode(v.garage) or {}
    --         Houses[v.name] = {
    --             coords = json.decode(v.coords),
    --             owned = owned,
    --             price = v.price,
    --             locked = true,
    --             adress = v.label,
    --             tier = v.tier,
    --             garage = garage,
    --             decorations = {},
    --         }
    --         HouseGarages[v.name] = {
    --             label = v.label,
    --             takeVehicle = garage,
    --         }
    --     end
    -- end
    -- TriggerClientEvent("qb-garages:client:houseGarageConfig", src, HouseGarages)
    -- TriggerClientEvent("qb-houses:client:setHouseConfig", src, Houses)
end
local function GiveStarterItems(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    for k, v in pairs(QBCore.Shared.StarterItems) do
        Player.Functions.AddItem(v.item, v.amount)
    end
end

RegisterServerEvent("setplayerbucket", function(bucket)
    local src = source
    -- print("bucket is set to", bucket)
    SetPlayerRoutingBucket(src, bucket)
end)
RegisterNetEvent('nxo-multicharacter:server:loadUserData', function(cData)
    local src = source
    
    if QBCore.Player.Login(src, cData.citizenid) then
        loadHouseData(src)
        -- TriggerClientEvent('qb-spawn:client:choose:spawn', src)
        
        -- TriggerClientEvent('qb-spawn:client:setupSpawns', src,cData,false)
        -- Wait(1000)
        TriggerClientEvent('qb-spawn:client:choose:spawn', src)
        -- TriggerClientEvent('qb-spawn:client:openUI', src,true)
	end
end)

QBCore.Functions.CreateCallback("nxo-multicharacter:server:getSkin", function(_, cb, cid)
    local result = MySQL.query.await('SELECT * FROM playerskins WHERE citizenid = ? AND active = ?', {cid, 1})
    if result[1] ~= nil then
        cb(json.decode(result[1].skin))
    else
        cb(nil)
    end
end)
RegisterServerEvent("0r-multicharacter:saveappearance", function(skin)
    local src = source
    -- if Config.Framework == 'esx' then
	-- 	local xPlayer = ESX.GetPlayerFromId(src)
    --     -- -- print(xPlayer)
	-- 	MySQL.query.await('UPDATE users SET skin = ? WHERE identifier = ?', {json.encode(skin), xPlayer.identifier})
	-- else
	-- 	local Player = QBCore.Functions.GetPlayer(src)
	-- 	if skin.model ~= nil and skin ~= nil then
	-- 		-- TODO: Update primary key to be citizenid so this can be an insert on duplicate update query
	-- 		MySQL.query('DELETE FROM playerskins WHERE citizenid = ?', { Player.PlayerData.citizenid }, function()
	-- 			MySQL.insert('INSERT INTO playerskins (citizenid, model, skin, active) VALUES (?, ?, ?, ?)', {
	-- 				Player.PlayerData.citizenid,
	-- 				skin.model,
	-- 				json.encode(skin),
	-- 				1
	-- 			})
	-- 		end)
	-- 	end
	-- end
	return true
end) -- only used on fivemappearance character creator

-- local function GiveStarterItems(source)
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)

--     for _, v in pairs(QBCore.Shared.StarterItems) do
--         local info = {}
--         if v.item == "id_card" then
--             info.citizenid = Player.PlayerData.citizenid
--             info.firstname = Player.PlayerData.charinfo.firstname
--             info.lastname = Player.PlayerData.charinfo.lastname
--             info.birthdate = Player.PlayerData.charinfo.birthdate
--             info.gender = Player.PlayerData.charinfo.gender
--             info.nationality = Player.PlayerData.charinfo.nationality
--         elseif v.item == "driver_license" then
--             info.firstname = Player.PlayerData.charinfo.firstname
--             info.lastname = Player.PlayerData.charinfo.lastname
--             info.birthdate = Player.PlayerData.charinfo.birthdate
--             info.type = "Class C Driver License"
--         end
--         Player.Functions.AddItem(v.item, v.amount, false, info)
--     end
-- end



AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
    Wait(1000) -- 1 second should be enough to do the preloading in other resources
    hasDonePreloading[Player.PlayerData.source] = true
end)

AddEventHandler('esx:playerLoaded', function(source)
	Wait(1000) -- 1 second should be enough to do the preloading in other resources
    hasDonePreloading[source] = true
end)

AddEventHandler('QBCore:Server:OnPlayerUnload', function(src)
    hasDonePreloading[src] = false
end)

-- RegisterCommand("addslot", function(source)
--     local src = source
--     local license = getPlayerIdentifier(src)
--     local slots = {}
--     local unlockedSlots = MySQL.query.await("SELECT * FROM 0r_unlockedslots WHERE license = ?", { license })
--     if unlockedSlots[1] ~= nil then
--         slots = json.decode(unlockedSlots[1].slots)
--         table.insert(slots, #slots + 1)
--         MySQL.Async.execute("UPDATE 0r_unlockedslots SET slots = ? WHERE license = ?", { json.encode(slots), license })
--     else
--         MySQL.Async.execute("INSERT INTO 0r_unlockedslots (license, slots) VALUES (?, ?)",
--             { license, json.encode({ 1 }) })
--     end

--     TriggerClientEvent("QBCore:Notify", src, "You have successfully added a slot!", "success")
-- end)



RegisterServerEvent("player:join", function()
    local src = source
    local license = QBCore.Functions.GetIdentifier(src, 'discord')
    -- -- -- -- print("license: " .. license)
    SetPlayerRoutingBucket(source,math.random(99,999))
    local plyChars = {}
    local availableSlots = {}

    -- if Config.LockedSlotsIsPaid and not Config.LockedSlotsAllowedPlayers[license] then
    --     local unlockedSlots = MySQL.query.await("SELECT * FROM 0r_unlockedslots WHERE license = ?", { license })
    --     if unlockedSlots[1] ~= nil then
    --         -- -- -- -- print("no nil found something")
    --         availableSlots = json.decode(unlockedSlots[1].slots)
    --     end
    -- end
    -- -- -- print(Config.Framework, "framework")
    TriggerEvent("nxo-multicharacter:server:loadsitecharacter", src)

        MySQL.query('SELECT * FROM players WHERE discord = ?', { license }, function(result)
            for i = 1, (#result), 1 do
                result[i].charinfo = json.decode(result[i].charinfo)
                result[i].money = json.decode(result[i].money)
                result[i].job = json.decode(result[i].job)
                plyChars[#plyChars + 1] = result[i]
            end
            TriggerClientEvent("0r-multicharacter:client:setChars", src, plyChars, availableSlots)
        end)
   
end)

AddEventHandler('nxo-multicharacter:server:loadsitecharacter', function(source)
    local src = source
    local discord = QBCore.Functions.GetIdentifier(src, 'discord')
    local chars = MySQL.query.await('SELECT * FROM players WHERE discord = ?', {discord})
    local res = {}
    PerformHttpRequest('https://nxone.ir/express/user?discord='..string.sub(discord, 9), function(err, back, headers)
        if err == 200 then
            back = json.decode(back)
            local found=false
            if back and back.characters then
            for k,v in pairs(back.characters) do
                found = false
                for j,l in pairs(chars) do
                  local info = json.decode(l.charinfo)
                    if string.lower(info.firstname) == string.lower(v.firstName) and string.lower(info.lastname) == string.lower(v.lastName) then
                        found = true
                    end
                end
                if not found then
                    res[#res+1]={firstname=firstToUpper(v.firstName),lastname=firstToUpper(v.lastName)}
                end
            end
            TriggerClientEvent('nxo-multicharacter:client:loadsitecharacter', src,res)
            end
        end
    end, "GET", "", {Authorization='Bearer vqbkmUmGLlxDIUVvgjS1iB1LjQiXjvyf'})
end)

local function deleteCharacter(source, charid)
    local identifier = ("%s%s:%s"):format(Config.Prefix, charid, ESX.GetIdentifier(source))
    local query = "DELETE FROM %s WHERE %s = ?"
    local queries = {}
    local count = 0

    for table, column in pairs(DB_TABLES) do
        count = count + 1
        queries[count] = {query = query:format(table, column), values = {identifier}}
    end

    MySQL.transaction(queries, function(result)
        if result then
            -- -- -- -- print(("[^2INFO^7] Player ^5%s %s^7 has deleted a character ^5(%s)^7"):format(GetPlayerName(source), source, identifier))
            --get esx chars
            MySQL.query('SELECT * FROM users WHERE identifier LIKE ?', { "%"..license }, function(result)
                -- -- -- -- print("result: " .. json.encode(result))
                for i = 1, (#result), 1 do
                    local accounts = json.decode(result[i].accounts)
                    local job, grade = result[i].job or "unemployed", tostring(result[i].job_grade)
                    if ESX.DoesJobExist(job, grade) then
                        grade = job ~= "unemployed" and ESX.Jobs[job].grades[grade].label or ""
                        job = ESX.Jobs[job].label
                    else
                        job = ESX.Jobs["unemployed"].label
                        grade = ""
                    end
                    result[i].cid = i
                    result[i].citizenid = i
                    result[i].charinfo = {
                        citizenid = i,
                        firstname = result[i].firstname,
                        lastname = result[i].lastname,
                        birthdate = result[i].dateofbirth,
                        sex = result[i].sex,
                        nationality = "N/A",
                    }
                    result[i].money = {cash = accounts.money, bank = accounts.bank}
                    result[i].job = {
                        label = job,
                        grade = {
                            name = grade,
                        },
                    }
                    plyChars[#plyChars + 1] = result[i]
                end
                TriggerClientEvent("0r-multicharacter:client:setChars", source, plyChars, availableSlots)
            end)
            return true
        end

        error("\n^1Transaction failed while trying to delete "..identifier.."^0")
    end)
end


RegisterNetEvent("0r-multicharacter:server:deleteCharacter", function(data)
    local src = source
    local cid = data.citizenid
    -- -- -- print(cid, 238)
    if cid then
        if Config.Framework == "esx" then
            local formatData = ("%s:"):format(Config.Prefix..cid)
            -- -- -- print(formatData)
            local identifier = formatData..ESX.GetIdentifier(source)
            -- -- -- print(identifier)
            local data = MySQL.query.await('SELECT * FROM users WHERE identifier LIKE ?', {'%'..identifier..'%'})
            for k,v in pairs(data) do
                local id = tonumber(string.sub(v.identifier, #Config.Prefix+1, string.find(v.identifier, ':')-1))
                -- -- -- print(id, cid, type(id), type(cid))
                if id == cid then
                    MySQL.query.await('DELETE FROM `users` WHERE `identifier` = ?', {v.identifier})
                    break
                end
            end

        else
            local license = QBCore.Functions.GetIdentifier(src, 'license')
            local result = MySQL.query.await('SELECT * FROM players WHERE license = ?', {license})
            for i = 1, (#result), 1 do
                if result[i].citizenid == cid then
                    -- -- -- print("deleting", src, result[i].citizenid)
                    -- QBCore.Player.DeleteCharacter(src, result[i].citizenid)
                    TriggerClientEvent('QBCore:Notify', src, 'Character Deleted' , "success")
                    break
                end
            end
        end
    else
        return
    end
end)

RegisterNetEvent('0resmon-multicharacter:createCharacter', function(data,has)
    local src = source
    -- local newData = {}
    -- newData.cid = data.cid or 1
    -- newData.charinfo = data 
    
    -- SetPlayerRoutingBucket(src,0)
    -- if Config.Framework == "qb" then
    --     if QBCore.Player.Login(src, false, newData) then
    --         repeat
    --             Wait(10)
    --         until hasDonePreloading[src]
    --         QBCore.Commands.Refresh(src)
    --         loadHouseData(src)
    --         GiveStarterItems(src)
    --         if GetResourceState('qb-apartments') == 'started' and Config.UseApartment then
    --             local randbucket = (GetPlayerPed(src) .. math.random(1,999))
    --             SetPlayerRoutingBucket(src, randbucket)
    --             -- -- -- print('^2[qb-core]^7 '..GetPlayerName(src)..' has successfully loaded!')
    --             QBCore.Commands.Refresh(src)
    --             loadHouseData(src)
    --             TriggerClientEvent("0r-multicharacter:client:closeNUI", src)
    --             TriggerClientEvent('apartments:client:setupSpawnUI', src, newData)
    --             GiveStarterItems(src)
    --         else
    --             -- -- -- print('^2[qb-core]^7 '..GetPlayerName(src)..' has successfully loaded!')
    --             QBCore.Commands.Refresh(src)
    --             loadHouseData(src)
    --             TriggerClientEvent("0r-multicharacter:client:closeNUIdefault", src)
    --             GiveStarterItems(src)
    --         end
    --     end
    -- else
    --     local identifier = getPlayerIdentifier(src)
    --     local esxData = {
    --         firstname = data.firstname,
    --         lastname = data.lastname,
    --         dateofbirth = data.birthdate,
    --         height = data.height,
    --         sex = data.gender
    --     }
    --     -- local skin = Config.DefaultSkin[tonumber(data.gender)]
    --     -- skin.sex = tonumber(data.gender)
    --     -- MySQL.update("UPDATE users SET skin = @skin WHERE identifier LIKE @identifier", {
    --     --     ["@skin"] = json.encode(skin),
    --     --     ["@identifier"] = "%"..identifier,
    --     -- })
    --     ESX.Players[identifier] = true
    --     TriggerClientEvent("0r-multicharacter:esx:setPlayerData", src, data)
    --     -- -- -- print(Config.Prefix..newData.cid)
    --     -- -- -- print(json.encode(esxData))
    --     TriggerEvent('esx:onPlayerJoined', src, Config.Prefix..newData.cid, esxData)
    --     SetPlayerRoutingBucket(src,0)

    --     -- -- -- -- print('^2[ESX]^7 ' .. newData.cid .. ' has successfully loaded!')
    --     -- -- -- -- print("%"..identifier, formattedString)

    --     -- if Config.SkipSelection then
    --     --     TriggerClientEvent('0r-multicharacter:client:openSpawnSelector', src, newData)
    --     -- end
    -- end

    local src = source
    if has then
        if QBCore.Player.Login(src, data.citizenid) then
            loadHouseData(src)
            TriggerClientEvent("0r-multicharacter:client:closeNUIdefault", src)
        end
    else
        local firstname = string.lower(data.firstname)
        local lastname = string.lower(data.lastname)
        local discord = QBCore.Functions.GetIdentifier(src, 'discord')
        local waitLoading = true
        local esmeshHast = false
        PerformHttpRequest('https://nxone.ir/express/user?discord='..string.sub(discord, 9), function(err, back, headers)
            if err == 200 then
                back = json.decode(back)
                for k,v in pairs(back.characters) do
                    if firstname == v.firstName and lastname == v.lastName then
                        esmeshHast = true
                        break
                    end
                end
            end
            waitLoading = false
        end, "GET", "", {Authorization='Bearer vqbkmUmGLlxDIUVvgjS1iB1LjQiXjvyf'})
        while waitLoading do
            Wait(500)
        end

        if esmeshHast then
            local ghablanSakhte = false
            local names = {}
            local chars = MySQL.query.await('SELECT * FROM players WHERE discord = ?', {discord})
            if chars[1] then
                for k,v in pairs(chars) do
                    local charinfo = json.decode(v.charinfo)
                    names[#names+1] = {firstname=charinfo.firstname,lastname=charinfo.lastname}
                end
            end
            for k,v in pairs(names) do
                if firstToUpper(firstname) == v.firstname and firstToUpper(lastname) == v.lastname then
                    ghablanSakhte = true
                    break
                end
            end
            if not ghablanSakhte then
                TriggerClientEvent('QBCore:Notify', src, 'Welcome to NexOne , Please Read /help and server rules first. Have Fun :)', 'success')
                local newData = {}
                newData.charinfo = data
                newData.charinfo.firstname = firstToUpper(firstname)
                newData.charinfo.lastname = firstToUpper(lastname)
                TriggerEvent('qb-log:server:CreateLog', 'newchar', 'New Character', 'green', GetPlayerName(src)..' ('..src..')\n'..discord..' | <@' .. string.gsub(discord, 'discord:', '') .. '>\n'..firstToUpper(firstname)..' '..firstToUpper(lastname)..'\n'..newData.charinfo.birthdate..'\n'..newData.charinfo.nationality..'\nGender: '..newData.charinfo.gender)
                if QBCore.Player.Login(src, false, newData) then
                    -- loadHouseData(src)
                    TriggerClientEvent("0r-multicharacter:client:closeNUIdefault", src)
                    GiveStarterItems(src)
                end
            else
                TriggerClientEvent('qb-multicharacter:client:chooseChar', src)
                TriggerClientEvent('QBCore:Notify', src, 'Your Character is Already Setuped', 'error')
            end
        else
            TriggerClientEvent('qb-multicharacter:client:chooseChar', src)
            TriggerClientEvent('QBCore:Notify', src, 'Your Character is not Created in Site', 'error')
        end
    end
end)


function GetPlayerFromId(src)
	self = {}
	self.src = src
	if Config.framework == 'esx' then
		return ESX.GetPlayerFromId(self.src)
	elseif Config.framework == 'qb' then
		xPlayer = QBCore.Functions.GetPlayer(self.src)
		xPlayer.identifier = xPlayer.citizenid
		if not xPlayer then return end
		return xPlayer
	end
end

LoadPlayer = function(source)
	-- local source = source
	-- local ts = 0
	-- while not GetPlayerFromId(source) and ts < 1000 do ts = ts + 1 Wait(0) end
	-- local ply = Player(source).state
	-- local identifier = GetPlayerFromId(source).identifier
	-- if identifier then
	-- 	ply:set('identifier',GetPlayerFromId(source).identifier,true)
	-- end
	-- return true
end

AddEventHandler('onResourceStop', function(name)
    if name == GetCurrentResourceName() then
        if Config.Framework == "esx" then
            -- -- print("resourcestop")
            for k, v in pairs(GetPlayers()) do
                v = tonumber(v)
                TriggerEvent("esx:playerLogout", v)
                ESX.Players[v] = nil
         
            end
        else
            for k, v in pairs(GetPlayers()) do
                v = tonumber(v)
                local player = QBCore.Functions.GetPlayer(v)
                if player then
                    QBCore.Player.Logout(player)
                end
            end
        end
    end
end)

RegisterCommand("forcelog", function(source)
    TriggerEvent("esx:playerLogout", source)
end, true)


RegisterNetEvent("0r-multicharacter:server:loadUserData", function(cData)
    local src = source
    SetPlayerRoutingBucket(src,0)
    if Config.Framework == "esx" then
        ESX.Players[src] = true
        TriggerEvent('esx:onPlayerJoined', src, ("%s%s"):format(Config.Prefix, cData.citizenid))
       
        -- LoadPlayer(source)
        -- TriggerEvent('esx:onPlayerJoined', src, ("%s%s"):format(Config.Prefix, cData.citizenid))
        Wait(500)
        -- -- -- print(json.encode(cData, {indent = true}))
        if Config.SkipSelection then
            local coords = json.decode(cData.position)
            TriggerClientEvent('0r-multicharacter:client:spawnLastLocation', src, coords, cData)
        else
            -- if Config.UseSpawnSelector then
                TriggerClientEvent("qb-spawn:client:openUI", src, true, json.decode(cData.position))
                TriggerClientEvent('qb-spawn:client:setupSpawns', src, cData, false, nil)
            -- end
        end

    else
        if QBCore.Player.Login(src, cData.citizenid) then
            repeat
                Wait(10)
            until hasDonePreloading[src]
            -- -- -- -- print('^2[qb-core]^7 ' .. GetPlayerName(src) .. ' (Citizen ID: ' .. cData.citizenid ..
                -- ') has successfully loaded!')
            QBCore.Commands.Refresh(src)
            loadHouseData(src)
            if Config.SkipSelection then
                local coords = json.decode(cData.position)
                -- -- -- print("coords", coords)
                TriggerClientEvent('0r-multicharacter:client:spawnLastLocation', src, coords, cData)
            else
                if GetResourceState('qb-apartments') == 'started' then
                    TriggerClientEvent('apartments:client:setupSpawnUI', src, cData, coords)
                else
                    local player = QBCore.Functions.GetPlayer(src)
                    -- TriggerClientEvent('qb-spawn:client:setupSpawns', src, cData, false, nil)
                    -- TriggerClientEvent('qb-spawn:client:openUI', src, true, coords)
                  
           
                end
            end
            TriggerEvent("qb-log:server:CreateLog", "joinleave", "Loaded", "green",
                "**" ..
                GetPlayerName(src) ..
                "** (<@" ..
                (QBCore.Functions.GetIdentifier(src, 'discord'):gsub("discord:", "") or "unknown") ..
                "> |  ||" ..
                (QBCore.Functions.GetIdentifier(src, 'ip') or 'undefined') ..
                "|| | " ..
                (QBCore.Functions.GetIdentifier(src, 'license') or 'undefined') ..
                " | " .. cData.citizenid .. " | " .. src .. ") loaded..")
        end
    end
end)


CreateThread(function()
    Wait(1000)
    if Config.Framework == "esx" then
        ESX.RegisterServerCallback('0r-multicharacter:server:getSkin', function(source, cb, cid)
            -- local identifier = getPlayerIdentifier(source)
            -- -- -- -- print("cid: " .. cid)
            local identifier = ESX.GetIdentifier(source)
            local id = ("%s%s:%s"):format(Config.Prefix, cid, identifier)
            -- -- -- print("id: " .. id)
            local result = MySQL.query.await("SELECT sex, skin FROM users WHERE identifier LIKE ?", { id })
            if result[1] ~= nil then
                -- -- -- print(json.encode(result[1]))
                -- -- -- print("nil de?il")
                skin = result[1].skin and json.decode(result[1].skin) or {}
                sex = tonumber(result[1].sex)
                cb(sex, skin)
            else
                -- -- -- print("nil kanka")
                cb(nil, nil)
            end
        end)
    
        ESX.RegisterServerCallback('0r-multicharacter:server:checkCode', function(source, cb, data)
            local code = data[1]
            local cid = data[2]
            -- local xPlayer = ESX.GetPlayerFromId(source)
            local license = ESX.GetIdentifier(source)
    
            local result = MySQL.query.await('SELECT * FROM auth_codes WHERE transaction = ?', { code })
            if result[1] ~= nil then
                MySQL.query.await('DELETE FROM auth_codes WHERE transaction = ?', { code })
                local slots = {}
                local unlockedSlots = MySQL.query.await("SELECT * FROM 0r_unlockedslots WHERE license = ?", { license })
                if unlockedSlots[1] ~= nil then
                    slots = json.decode(unlockedSlots[1].slots)
                    table.insert(slots, tonumber(cid))
                    MySQL.query.await("UPDATE 0r_unlockedslots SET slots = ? WHERE license = ?", { json.encode(slots), license })
                else
                    MySQL.query.await("INSERT INTO 0r_unlockedslots (license, slots) VALUES (?, ?)",
                        { license, json.encode({ tonumber(cid) }) })
                end
                cb(true)
            else
                cb(false)
            end
        end)
    
    elseif Config.Framework == "qb" then
        -- -- -- print("callbacks creating")
        QBCore.Functions.CreateCallback("0r-multicharacter:server:getSkin", function(_, cb, cid)
            -- -- -- print("citizenid test", cid)
            local result = MySQL.query.await('SELECT * FROM playerskins WHERE citizenid = ? AND active = ?', { cid, 1 })
            if result[1] ~= nil then
                cb(result[1].model, json.decode(result[1].skin))
            else
                cb(nil)
            end
        end)
        
        QBCore.Functions.CreateCallback('qb-spawn:server:getOwnedHouses', function(_, cb, cid)
            if cid ~= nil then
                -- local houses = MySQL.query.await('SELECT * FROM player_houses WHERE citizenid = ?', { cid })
                -- if houses[1] ~= nil then
                --     cb(houses)
                -- else
                    cb({})
                -- end
            else
                cb({})
            end
        end)
        
        QBCore.Functions.CreateCallback("0r-multicharacter:server:checkCode", function(source, cb, data)
            local code = data[1]
            local cid = data[2]
            local license = QBCore.Functions.GetIdentifier(source, 'license')
            local result = MySQL.query.await('SELECT * FROM auth_codes WHERE transaction = ?', { code })
            -- -- -- -- print(result[1])
            if result[1] ~= nil then
                -- Burada transaction sütunu üzerinden silme i?lemi yap?l?yor
                MySQL.query.await('DELETE FROM auth_codes WHERE transaction = ?', { code })
                -- insert or update slots
                local slots = {}
                local unlockedSlots = MySQL.query.await("SELECT * FROM 0r_unlockedslots WHERE license = ?", { license })
                if unlockedSlots[1] ~= nil then
                    slots = json.decode(unlockedSlots[1].slots)
                    table.insert(slots, tonumber(cid))
                    MySQL.query.await("UPDATE 0r_unlockedslots SET slots = ? WHERE license = ?", { json.encode(slots), license })
                else
                    MySQL.query.await("INSERT INTO 0r_unlockedslots (license, slots) VALUES (?, ?)",
                        { license, json.encode({ tonumber(cid) }) })
                end
                cb(true)
            else
                cb(false)
            end
        end)
    end
end)



RegisterCommand("buylockedslot", function(source, args)
    local src = source
    local transactionId = args[1]
    if transactionId == nil then
        return
    end
    MySQL.Async.execute("INSERT INTO auth_codes (transaction) VALUES (?)", { transactionId })
end)


-- QBCore.Functions.CreateCallback("qb-multicharacter:server:setupCharacters", function(source, cb)
--     local license = QBCore.Functions.GetIdentifier(source, 'license')
--     local plyChars = {}
--     MySQL.query('SELECT * FROM players WHERE license = ?', {license}, function(result)
--         for i = 1, (#result), 1 do
--             result[i].charinfo = json.decode(result[i].charinfo)
--             result[i].money = json.decode(result[i].money)
--             result[i].job = json.decode(result[i].job)
--             plyChars[#plyChars+1] = result[i]
--         end
--         cb(plyChars)
--     end)
-- end)