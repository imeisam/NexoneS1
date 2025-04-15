QBCore.Players = {}
QBCore.Player = {}
JoinTimes = {}

local function GetCash(Items)
    local count = 0
    for i=1, QBConfig.Player.MaxInvSlots do
        local data = Items[i]
        if data and data.name == 'cash' then
            count = count + data.amount
        end
    end
    return count
end

function QBCore.Player.Login(source, citizenid, newData)
    if source and source ~= '' then
        if citizenid then
            local discord = QBCore.Functions.GetIdentifier(source, 'discord')
            local PlayerData = MySQL.prepare.await('SELECT * FROM players where citizenid = ?', { citizenid })
            if PlayerData and discord == PlayerData.discord then
                PlayerData.money = json.decode(PlayerData.money)
                PlayerData.job = json.decode(PlayerData.job)
                PlayerData.position = json.decode(PlayerData.position)
                PlayerData.metadata = json.decode(PlayerData.metadata)
                PlayerData.charinfo = json.decode(PlayerData.charinfo)
                if PlayerData.gang then
                    PlayerData.gang = json.decode(PlayerData.gang)
                else
                    PlayerData.gang = {}
                end
                QBCore.Player.CheckPlayerData(source, PlayerData)
            else
                DropPlayer(source, 'You Have Been Kicked For Exploitation')
            end
        else
            QBCore.Player.CheckPlayerData(source, newData)
        end
        return true
    else
        QBCore.ShowError(GetCurrentResourceName(), 'ERROR QBCORE.PLAYER.LOGIN - NO SOURCE GIVEN!')
        return false
    end
end

function QBCore.Player.DeleteCharacter(source, citizenid)
    exports["snipe-banking"]:DeleteCharacter(citizenid) --added
    local discord = QBCore.Functions.GetIdentifier(source, 'discord')
    local result = MySQL.scalar.await('SELECT discord FROM players where citizenid = ?', { citizenid })
    if discord == result then
        local query = "DELETE FROM %s WHERE citizenid = ?"
        local tableCount = #playertables
        local queries = table.create(tableCount, 0)

        for i = 1, tableCount do
            local v = playertables[i]
            queries[i] = {query = query:format(v.table), values = { citizenid }}
        end

        MySQL.transaction(queries, function(result2)
            if result2 then
                TriggerEvent('qb-log:server:CreateLog', 'joinleave', 'Character Deleted', 'red', '**' .. GetPlayerName(source) .. '** ' .. discord .. ' deleted **' .. citizenid .. '**..')
            end
        end)
    else
        DropPlayer(source, Lang:t("info.exploit_dropped"))
        TriggerEvent('qb-log:server:CreateLog', 'anticheat', 'Anti-Cheat', 'white', GetPlayerName(source) .. ' Has Been Dropped For Character Deletion Exploit', true)
    end
end

local function applyDefaults(playerData, defaults)
    for key, value in pairs(defaults) do
        if type(value) == 'function' then
            if key == "money" then
                local moneyTypes = value()
                if not playerData[key] then
                    playerData[key] = moneyTypes
                else
                    for account, balance in pairs(moneyTypes) do
                        playerData[key][account] = playerData[key][account] or balance
                    end
                end
            else
                playerData[key] = playerData[key] or value()
            end
        elseif type(value) == 'table' then
            playerData[key] = playerData[key] or {}
            applyDefaults(playerData[key], value)
        else
            playerData[key] = playerData[key] or value
        end
    end
end


function QBCore.Player.CheckPlayerData(source, Data)
    JoinTimes[source] = os.time()
    local PlayerData = {}
    PlayerData.source = source
    PlayerData.citizenid = Data.citizenid or QBCore.Player.CreateCitizenId()
    PlayerData.discord = Data.discord or QBCore.Functions.GetIdentifier(source, 'discord')
    PlayerData.name = GetPlayerName(source)
    PlayerData.money = {}
    for moneytype, startamount in pairs(QBCore.Config.Money.MoneyTypes) do
        PlayerData.money[moneytype] = math.ceil(Data.money and Data.money[moneytype] or startamount)
    end
    -- Charinfo
    PlayerData.charinfo = {}
    PlayerData.charinfo.firstname = Data.charinfo and Data.charinfo.firstname or 'Firstname'
    PlayerData.charinfo.lastname = Data.charinfo and Data.charinfo.lastname or 'Lastname'
    PlayerData.charinfo.birthdate = Data.charinfo and Data.charinfo.birthdate or '00-00-0000'
    PlayerData.charinfo.gender = Data.charinfo and Data.charinfo.gender or 0
    PlayerData.charinfo.nationality = Data.charinfo and Data.charinfo.nationality or 'American'
    PlayerData.charinfo.phone = Data.charinfo and Data.charinfo.phone or QBCore.Functions.CreatePhoneNumber()
    -- Metadata
    PlayerData.metadata = {}
    PlayerData.metadata["timePlay"] = Data.metadata and Data.metadata["timePlay"] or 0
    PlayerData.metadata["backpack"] = Data.metadata and Data.metadata["backpack"] or false
    PlayerData.metadata["health"] = Data.metadata and Data.metadata["health"] or 100
    PlayerData.metadata["armor"]  = Data.metadata and Data.metadata["armor"] or 0
    PlayerData.metadata["carslot"]  = Data.metadata and Data.metadata["carslot"] or 2
    PlayerData.metadata['hunger'] = Data.metadata and Data.metadata['hunger'] or 100
    PlayerData.metadata['thirst'] = Data.metadata and Data.metadata['thirst'] or 100
    PlayerData.metadata['stress'] = Data.metadata and Data.metadata['stress'] or 0
    PlayerData.metadata['isdead'] = Data.metadata and Data.metadata['isdead'] or false
    PlayerData.metadata['inlaststand'] = Data.metadata and Data.metadata['inlaststand'] or false
    PlayerData.metadata["ban2"] = Data.metadata and Data.metadata["ban2"] or false
    PlayerData.metadata["ban3"] = Data.metadata and Data.metadata["ban3"] or false
    PlayerData.metadata["bancrash"] = Data.metadata and Data.metadata["bancrash"] or false
    PlayerData.metadata["phonecase"] = Data.metadata and Data.metadata["phonecase"] or {model="scrlt_iphone14max_03",case=nil}
    PlayerData.metadata["commandbinds"] = exports['qb-keybinds']:setupBinds(Data.metadata)
    PlayerData.metadata['gooni'] = Data.metadata and Data.metadata['gooni'] or false
    PlayerData.metadata['phonering'] = Data.metadata and Data.metadata['phonering'] or false
    PlayerData.metadata['incomingring'] = Data.metadata and Data.metadata['incomingring'] or false
    PlayerData.metadata['ishandcuffed'] = Data.metadata and Data.metadata['ishandcuffed'] or false
    PlayerData.metadata['cuffquality'] = Data.metadata and Data.metadata['cuffquality'] or 0
    PlayerData.metadata['injail'] = Data.metadata and Data.metadata['injail'] or 0
    PlayerData.metadata['jailitems'] = Data.metadata and Data.metadata['jailitems'] or {}
    PlayerData.metadata['phone'] = Data.metadata and Data.metadata['phone'] or {}
    PlayerData.metadata['bloodtype'] = Data.metadata and Data.metadata['bloodtype'] or QBCore.Config.Player.Bloodtypes[math.random(1, #QBCore.Config.Player.Bloodtypes)]
    PlayerData.metadata['inapartment'] = Data.metadata and Data.metadata['inapartment'] or false
    PlayerData.metadata['callsign'] = Data.metadata and Data.metadata['callsign'] or '000'
    PlayerData.metadata['fingerprint'] = Data.metadata and Data.metadata['fingerprint'] or QBCore.Player.CreateFingerId()
    if Data.metadata and Data.metadata['licences'] then
        local Licenses = {}
        for k,v in pairs(QBConfig.Server.Licenses) do
            Licenses[k] = Data.metadata['licences'][k] or false
        end
        PlayerData.metadata['licences'] = Licenses
    else
        PlayerData.metadata['licences'] = QBConfig.Server.Licenses
    end
    PlayerData.metadata['healthsystem'] = Data.metadata and Data.metadata['healthsystem'] or nil
    -- Job
    if Data.job and Data.job.name and not QBCore.Shared.Jobs[Data.job.name] then Data.job = nil end
    PlayerData.job = {}
    PlayerData.job.name = Data.job and Data.job.name or 'unemployed'
    PlayerData.job.label = QBCore.Shared.Jobs[PlayerData.job.name].label
    PlayerData.job.onduty = Data.job and Data.job.onduty or true
    PlayerData.job.type = QBCore.Shared.Jobs[PlayerData.job.name].category or 'none'
    PlayerData.job.grade = {}
    PlayerData.job.grade.level = Data.job and ((Data.job.grade.level and QBCore.Shared.Jobs[PlayerData.job.name].grades[tostring(Data.job.grade.level)]) and Data.job.grade.level) or 0
    PlayerData.job.grade.name = QBCore.Shared.Jobs[PlayerData.job.name].grades[tostring(PlayerData.job.grade.level)].name
    PlayerData.job.isboss = QBCore.Shared.Jobs[PlayerData.job.name].grades[tostring(PlayerData.job.grade.level)].isboss or false
    PlayerData.job.ismanager = QBCore.Shared.Jobs[PlayerData.job.name].grades[tostring(PlayerData.job.grade.level)].ismanager or false
    PlayerData.job.salary = QBCore.Shared.Jobs[PlayerData.job.name].grades[tostring(PlayerData.job.grade.level)].salary or 0
    PlayerData.job.dep = QBCore.Shared.Jobs[PlayerData.job.name].grades[tostring(PlayerData.job.grade.level)].dep or PlayerData.job.name
    if Data.job and Data.job.divs and QBCore.Shared.Jobs[PlayerData.job.name].division then
        local divisions = {}
        for k,v in pairs(QBCore.Shared.Jobs[PlayerData.job.name].division) do
            divisions[k] = Data.job.divs[k] or nil
        end
        PlayerData.job.divs = divisions
    else
        PlayerData.job.divs = {}
    end
    -- Gang
    if Data.gang and Data.gang.name and not QBCore.Shared.Gangs[Data.gang.name] then Data.gang = nil end
    PlayerData.gang = {}
    PlayerData.gang.name = Data.gang and Data.gang.name or 'none'
    PlayerData.gang.label = QBCore.Shared.Gangs[PlayerData.gang.name].label
    PlayerData.gang.grade = {}
    PlayerData.gang.grade.level = Data.gang and ((Data.gang.grade.level and QBCore.Shared.Gangs[PlayerData.gang.name].grades[tostring(Data.gang.grade.level)]) and Data.gang.grade.level) or 0
    PlayerData.gang.grade.name = QBCore.Shared.Gangs[PlayerData.gang.name].grades[tostring(PlayerData.gang.grade.level)].name
    PlayerData.gang.isboss = QBCore.Shared.Gangs[PlayerData.gang.name].grades[tostring(PlayerData.gang.grade.level)].isboss or false
    -- Inventory
    PlayerData.items = {}
    if Data.inventory then
        local inventory = json.decode(Data.inventory)
        local maxSlot = PlayerData.metadata["backpack"] and (QBConfig.Player.BackPackSlot + QBConfig.Player.MaxInvSlots) or QBConfig.Player.MaxInvSlots
        if next(inventory) then
            for _, item in pairs(inventory) do
                if item then
                    local itemInfo = QBCore.Shared.Items[item.name:lower()]
                    if itemInfo then
                        if item.slot <= maxSlot then
                            PlayerData.items[item.slot] = {
                                name = itemInfo['name'],
                                amount = item.amount,
                                info = item.info,
                                label = itemInfo['label'],
                                description = itemInfo['description'],
                                weight = item.weight or itemInfo['weight'],
                                type = itemInfo['type'],
                                unique = itemInfo['unique'],
                                useable = itemInfo['useable'],
                                image = itemInfo['image'],
                                shouldClose = itemInfo['shouldClose'],
                                slot = item.slot,
                                combinable = itemInfo['combinable']
                            }
                        end
                    end
                end
            end
        end
    end
    -- Position
    PlayerData.position = Data.position or QBConfig.DefaultSpawn
    -- Insert Into Database
    if not Data.citizenid then
        local inventory = QBCore.Player.SaveInventory(PlayerData)
        MySQL.query('INSERT INTO players (`citizenid`, `discord`, `money`, `charinfo`, `job`, `gang`, `position`, `metadata`, `inventory`, `firstJoin`) VALUES (@citizenid, @discord, @money, @charinfo, @job, @gang, @position, @metadata, @inventory, @firstJoin);',
        {
            citizenid = PlayerData.citizenid,
            discord = PlayerData.discord,
            money = json.encode(PlayerData.money),
            charinfo = json.encode(PlayerData.charinfo),
            job = json.encode(PlayerData.job),
            gang = json.encode(PlayerData.gang),
            position = json.encode(pcoords),
            metadata=json.encode(PlayerData.metadata),
            inventory = inventory,
            firstJoin = os.date("%x")
        }, function(e)
            QBCore.ShowSuccess(GetCurrentResourceName(), PlayerData.citizenid .. ' PLAYER CREATED!')
        end)
    end
    -- Functions
    QBCore.Player.CreatePlayer(PlayerData)
    -- Log
    TriggerEvent('qb-log:server:CreateLog', 'join', 'Player Joined', 'green', GetPlayerName(PlayerData.source)..' ('..source..')\n'..PlayerData.discord..' | <@' .. string.gsub(PlayerData.discord, 'discord:', '') .. '>\n'..PlayerData.charinfo.firstname..' '..PlayerData.charinfo.lastname..'  ('..PlayerData.citizenid..')\nSteam: '..QBCore.Functions.GetIdentifier(PlayerData.source, 'steam')..'\nRockstar: '..QBCore.Functions.GetIdentifier(PlayerData.source, 'license')..'\nLive: '..QBCore.Functions.GetIdentifier(PlayerData.source, 'live')..'\nXbox: '..QBCore.Functions.GetIdentifier(PlayerData.source, 'xbl')..'\nIP: '..QBCore.Functions.GetIdentifier(PlayerData.source, 'ip'))
end

-- On player logout

function QBCore.Player.Logout(source)
    -- local src = source
    -- if not QBCore.Players[src] then return end
    -- local Player = QBCore.Players[src]
    -- Player.Functions.Save()
    -- QBCore.Player_Buckets[Player.PlayerData.discord] = nil
    -- if QBCore.Player_Permissions[Player.PlayerData.discord] ~= nil then
    --     QBCore.Player_Permissions[Player.PlayerData.discord] = nil
    -- end
    -- QBCore.Players[src] = nil
    -- if JoinTimes[src] then
    --     JoinTimes[src] = nil
    -- end
    -- TriggerClientEvent('QBCore:Client:OnPlayerUnload', source)
    -- TriggerEvent('QBCore:Server:OnPlayerUnload', source)
    DropPlayer(source, 'You Have Been Logged Out')
end


-- Create a new character
-- Don't touch any of this unless you know what you are doing
-- Will cause major issues!

function QBCore.Player.CreatePlayer(PlayerData)
    local self = {}
    self.Functions = {}
    self.PlayerData = PlayerData

    function self.Functions.UpdatePlayerData()
        TriggerClientEvent('QBCore:Player:SetPlayerData', self.PlayerData.source, self.PlayerData)
    end

    function self.Functions.SetJob(job, grade, divs, dontUpdate)
        job = job:lower()
        grade = tostring(grade) or '0'
        if not QBCore.Shared.Jobs[job] then return false end
        local divChanged = false
        if self.PlayerData.job.name ~= job then
            divChanged = true
            self.PlayerData.job.divs = {}
        end
        if divChanged then
            self.PlayerData.job.divs = divs
        end
        self.PlayerData.job.name = job
        self.PlayerData.job.label = QBCore.Shared.Jobs[job].label
        if self.PlayerData.job.name=='police' or self.PlayerData.job.name=='ambulance' or self.PlayerData.job.name=='justice' then
            self.PlayerData.job.onduty = true
        else
            self.PlayerData.job.onduty = false
        end
        
        self.PlayerData.job.type = QBCore.Shared.Jobs[job].category or 'none'
        if QBCore.Shared.Jobs[job].grades[grade] then
            local jobgrade = QBCore.Shared.Jobs[job].grades[grade]
            self.PlayerData.job.grade = {}
            self.PlayerData.job.grade.name = jobgrade.name
            self.PlayerData.job.grade.level = tonumber(grade)
            self.PlayerData.job.isboss = jobgrade.isboss or false
            self.PlayerData.job.ismanager = jobgrade.ismanager or false
            self.PlayerData.job.salary = jobgrade.salary or 0
            self.PlayerData.job.dep = QBCore.Shared.Jobs[self.PlayerData.job.name].grades[tostring(self.PlayerData.job.grade.level)].dep or self.PlayerData.job.name
            self.PlayerData.job.divs = self.PlayerData.job.divs
        else
            self.PlayerData.job.grade = {}
            self.PlayerData.job.grade.name = 'No Grade'
            self.PlayerData.job.grade.level = 0
            self.PlayerData.job.isboss = false
            self.PlayerData.job.ismanager = false
            self.PlayerData.job.salary = 0
            self.PlayerData.job.dep = self.PlayerData.job.name
            self.PlayerData.job.divs = {}
        end
        self.Functions.UpdatePlayerData()
        TriggerEvent('QBCore:Server:OnJobUpdate', self.PlayerData.source, self.PlayerData.job, dontUpdate)
        TriggerClientEvent('QBCore:Client:OnJobUpdate', self.PlayerData.source, self.PlayerData.job)
        MySQL.update('UPDATE players SET `job` = @job WHERE citizenid = @citizenid',
        {
            citizenid = self.PlayerData.citizenid,
            job = json.encode(self.PlayerData.job),
        }, function(rowsChanged)
            QBCore.ShowSuccess(GetCurrentResourceName(), PlayerData.citizenid .. ' PLAYER JOB UPDATED!')
        end)
        return true
    end

    function self.Functions.AddDivision(division)
        if not QBCore.Shared.Jobs[self.PlayerData.job.name].division[division] then return false end
        local divisions = {}
        if self.PlayerData.job.divs~=nil then
             divisions =self.PlayerData.job.divs
        end
      
        divisions[division] = true
		self.PlayerData.job.divs = divisions
		self.Functions.SetJob(self.PlayerData.job.name, self.PlayerData.job.grade.level)
	end

	function self.Functions.RemoveDivision(division)
        local divisions = {}
        if self.PlayerData.job.divs~=nil then
             divisions =self.PlayerData.job.divs
        end
        divisions[division] = nil
		self.PlayerData.job.divs = divisions
		self.Functions.SetJob(self.PlayerData.job.name, self.PlayerData.job.grade.level)
	end

    function self.Functions.SetGang(gang, grade)
        gang = gang:lower()
        grade = tostring(grade) or '0'
        if not QBCore.Shared.Gangs[gang] then return false end
        self.PlayerData.gang.name = gang
        self.PlayerData.gang.label = QBCore.Shared.Gangs[gang].label
        if QBCore.Shared.Gangs[gang].grades[grade] then
            local ganggrade = QBCore.Shared.Gangs[gang].grades[grade]
            self.PlayerData.gang.grade = {}
            self.PlayerData.gang.grade.name = ganggrade.name
            self.PlayerData.gang.grade.level = tonumber(grade)
            self.PlayerData.gang.isboss = ganggrade.isboss or false
        else
            self.PlayerData.gang.grade = {}
            self.PlayerData.gang.grade.name = 'No Grade'
            self.PlayerData.gang.grade.level = 0
            self.PlayerData.gang.isboss = false
        end
        self.Functions.UpdatePlayerData()
        TriggerEvent('QBCore:Server:OnGangUpdate', self.PlayerData.source, self.PlayerData.gang)
        TriggerClientEvent('QBCore:Client:OnGangUpdate', self.PlayerData.source, self.PlayerData.gang)
        MySQL.update('UPDATE players SET `gang` = @gang WHERE citizenid = @citizenid',
        {
            citizenid = self.PlayerData.citizenid,
            gang = json.encode(self.PlayerData.gang),
        }, function(rowsChanged)
            QBCore.ShowSuccess(GetCurrentResourceName(), PlayerData.citizenid .. ' PLAYER GANG UPDATED!')
        end)
        return true
    end

    function self.Functions.SetJobDuty(onDuty)
        self.PlayerData.job.onduty = onDuty
        self.Functions.UpdatePlayerData()
    end

    function self.Functions.SetMetaData(meta, val)
        if not meta then return end
        meta = meta:lower()
        self.PlayerData.metadata[meta] = val
        self.Functions.UpdatePlayerData()
    end

    function self.Functions.SetCharinfo(key, val)
        if not key then return end
        self.PlayerData.charinfo[key] = val
        self.Functions.UpdatePlayerData()
    end

    function self.Functions.AddMoney(moneytype, amount, reason,log)
        reason = reason or 'unknown'
        moneytype = moneytype:lower()
        amount = tonumber(amount)
        if amount < 0 then return end
        if moneytype == 'cash' then return self.Functions.AddCash(amount) end
        if amount > 100000 then
            TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'AddMoney', 'lightgreen', '**' .. self.PlayerData.charinfo.firstname..' '..self.PlayerData.charinfo.lastname .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') added, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype] .. ' reason: ' .. reason, true)
        else
            TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'AddMoney', 'lightgreen', '**' .. self.PlayerData.charinfo.firstname..' '..self.PlayerData.charinfo.lastname .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') added, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype] .. ' reason: ' .. reason)
        end
        if not self.PlayerData.money[moneytype] then return false end
        self.PlayerData.money[moneytype] = self.PlayerData.money[moneytype] + amount
        self.Functions.UpdatePlayerData()
        TriggerClientEvent('QBCore:Client:OnMoneyChange', self.PlayerData.source, moneytype, amount,'add', reason)
        TriggerEvent('QBCore:Server:OnMoneyChange', self.PlayerData.source, moneytype, amount,'add', reason,log)
        TriggerClientEvent('hud:client:OnMoneyChange', self.PlayerData.source, moneytype, amount, false)
        return true
    end

    function self.Functions.RemoveMoney(moneytype, amount, reason,log)
        reason = reason or 'unknown'
        moneytype = moneytype:lower()
        amount = tonumber(amount)
        amount= math.round(amount)
        if amount < 0 then return end
        if moneytype == 'cash' then return self.Functions.RemoveCash(amount) end
        if amount > 100000 then
            TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'RemoveMoney', 'red', '**' .. self.PlayerData.charinfo.firstname..' '..self.PlayerData.charinfo.lastname .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') removed, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype] .. ' reason: ' .. reason, true)
        else
            TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'RemoveMoney', 'red', '**' .. self.PlayerData.charinfo.firstname..' '..self.PlayerData.charinfo.lastname .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') removed, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype] .. ' reason: ' .. reason)
        end
        if not self.PlayerData.money[moneytype] then return false end
        for _, mtype in pairs(QBCore.Config.Money.DontAllowMinus) do
            if mtype == moneytype then
                if (self.PlayerData.money[moneytype] - amount) < 0 then
                    return false
                end
            end
        end
        self.PlayerData.money[moneytype] = self.PlayerData.money[moneytype] - amount
        self.Functions.UpdatePlayerData()
        TriggerClientEvent('QBCore:Client:OnMoneyChange', self.PlayerData.source, moneytype, amount,'remove', reason,log)
        TriggerEvent('QBCore:Server:OnMoneyChange', self.PlayerData.source, moneytype, amount,'remove', reason,log)
        TriggerClientEvent('hud:client:OnMoneyChange', self.PlayerData.source, moneytype, amount, true)
        return true
    end

    function self.Functions.SetMoney(moneytype, amount, reason)
        reason = reason or 'unknown'
        moneytype = moneytype:lower()
        amount = tonumber(amount)
        if not self.PlayerData.money[moneytype] then return false end
        self.PlayerData.money[moneytype] = amount
        self.Functions.UpdatePlayerData()
        TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'SetMoney', 'green', '**' .. self.PlayerData.charinfo.firstname..' '..self.PlayerData.charinfo.lastname .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') set, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype] .. ' reason: ' .. reason)
        return true
    end

    function self.Functions.GetMoney(moneytype)
        if not moneytype then return false end
        moneytype = moneytype:lower()
        if moneytype == 'cash' then return self.Functions.GetCash() end
        return self.PlayerData.money[moneytype]
    end

    function self.Functions.AddCash(amount)
        if not amount then return false end
        self.Functions.AddItem('cash', amount)
        return true
    end

    function self.Functions.RemoveCash(amount)
        if not amount then return false end
        local count = 0
        local kodoma = {}
        for i=1, QBConfig.Player.MaxInvSlots do
            local data = self.PlayerData.items[i]
            if data and data.name == 'cash' then
                count = count + data.amount
                kodoma[i] = data.amount
            end
        end
        if count >= amount then
            local tamoom = false
            local myInv = self.PlayerData.items
            for k,v in pairs(kodoma) do
                local data = self.PlayerData.items[k]
                if data and data.name == 'cash' then
                    if data.amount > amount then
                        myInv[k].amount = data.amount - amount
                        tamoom = true
                        break
                    else
                        amount = amount - data.amount
                        myInv[k] = nil
                        if amount == 0 then
                            tamoom = true
                            break
                        end
                    end
                end
            end
            if tamoom then
                self.Functions.SetInventory(myInv)
                return true
            else
                return false
            end
        else
            return false
        end
    end

    function self.Functions.GetCash()
        return GetCash(self.PlayerData.items)
    end

    function self.Functions.AddItem(item, amount, slot, info, weight, bereKhali)
        local itemInfo = QBCore.Shared.Items[item:lower()]
        if not itemInfo then
            TriggerClientEvent('QBCore:Notify', self.PlayerData.source, Lang:t('error.item_not_exist'), 'error')
            return
        end
        local totalWeight = QBCore.Player.GetTotalWeight(self.PlayerData.items)
        local vazn = weight or itemInfo.weight
        amount = tonumber(amount)
        slot = tonumber(slot) or QBCore.Player.GetFirstSlotByItem(self.PlayerData.items, item)
        if not info or type(info) == 'string' then
            info = {}
        end
        if (item == 'mask' or item == 'weapon_shoe') and not info.number then
            info = {number = 1, color = 1}
        elseif (item == 'lockpick' or item == 'advancedlockpick' or item == 'lighter' or item == 'cigar_box' or item == 'cold_tablets' or item == 'fishingrod' or item == 'handcuffs' or item == 'cuff_keys') and not info.quality then
            info = {quality = 100,}
        elseif (item == 'id_card' or item == 'driver_license' or item == 'weaponlicense') and not info.firstname then
            info = {}
            info.firstname = self.PlayerData.charinfo.firstname
            info.lastname = self.PlayerData.charinfo.lastname
            info.birthdate = self.PlayerData.charinfo.birthdate
            info.gender = self.PlayerData.charinfo.gender
            info.nationality = self.PlayerData.charinfo.nationality
            info.citizenid = self.PlayerData.citizenid
        elseif item == 'jerrycan' and not info.gasamount then
            info = {gasamount = 0}
        elseif item == 'foodcontainer' and not info.id then
            info = {id = math.random(1, 999999)}
        elseif item == 'diving_gear' and not info.oxygen then
            info = {oxygen = 1000}
        elseif item == 'emsbag' and not info.id then
            info = {id = math.random(1, 999999)}
        elseif item == 'backpack' and not info.items then
            info = {items = {}}
        elseif (item == 'pistol_clip' or item == 'rifle_clip' or item == 'smg_clip') and not info.ammo then
            info = {ammo = 0}
        elseif item == 'pdradio' and not info.serie then
            info = {serie = self.PlayerData.job.label..math.random(11,1000)..self.PlayerData.citizenid..math.random(11,1000)}
        elseif item == "fishinglure" and not info.uses then
            info = {uses = 1000}
        elseif item == "fishinglure2" and not info.uses then
            info = {uses = 1500}
        elseif item == 'zatps' and not info.type then
            info = { type = "RIASROC-RM750X", performance = 100}
        elseif item == 'zatmb' and not info.type then
            info = { type = "ETYBAGIG-B650E", performance = 100}
        elseif item == 'zatcpu' and not info.type then
            info = { type = "NEZYR7-7950", performance = 100}
        elseif item == 'zatgpu' and not info.type then
            info = { type = "XTR-4090", performance = 100, hz = 2.4}
        elseif itemInfo['type'] == 'weapon' and not info.serie and not info.quality then
            info = {
                serie = 'Unknown',
                quality = 100,
                clip = false,
                ammo = 0
            }
        end
        
        if not info.created then
            info.created = os.time()
        end

        local dropAmount = amount
        if (totalWeight + (vazn * amount)) <= QBCore.Config.Player.MaxWeight then
            if (slot and self.PlayerData.items[slot]) and (self.PlayerData.items[slot].name:lower() == item:lower()) and not itemInfo['unique'] and not bereKhali then
				self.PlayerData.items[slot].amount = self.PlayerData.items[slot].amount + amount
                self.Functions.UpdatePlayerData()
                TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'AddItem', 'green', '**' .. self.PlayerData.charinfo.firstname..' '..self.PlayerData.charinfo.lastname .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** got item: [slot:' .. slot .. '], itemname: ' .. self.PlayerData.items[slot].name .. ', added amount: ' .. amount .. ', new total amount: ' .. self.PlayerData.items[slot].amount)
                return true
			elseif ((not itemInfo['unique'] and slot) or slot and not self.PlayerData.items[slot]) and not bereKhali then
                self.PlayerData.items[slot] = { name = itemInfo['name'], amount = amount, info = info, label = itemInfo['label'], description = itemInfo['description'] or '', weight = vazn, type = itemInfo['type'], unique = itemInfo['unique'], useable = itemInfo['useable'], image = itemInfo['image'], shouldClose = itemInfo['shouldClose'], slot = slot, combinable = itemInfo['combinable'] }
                self.Functions.UpdatePlayerData()
                TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'AddItem', 'green', '**' .. self.PlayerData.charinfo.firstname..' '..self.PlayerData.charinfo.lastname .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** got item: [slot:' .. slot .. '], itemname: ' .. self.PlayerData.items[slot].name .. ', added amount: ' .. amount .. ', new total amount: ' .. self.PlayerData.items[slot].amount)
                return true
            elseif not itemInfo['unique'] then
                for i = 1, QBConfig.Player.MaxInvSlots, 1 do
					if not self.PlayerData.items[i] then
                        self.PlayerData.items[i] = { name = itemInfo['name'], amount = amount, info = info, label = itemInfo['label'], description = itemInfo['description'] or '', weight = vazn, type = itemInfo['type'], unique = itemInfo['unique'], useable = itemInfo['useable'], image = itemInfo['image'], shouldClose = itemInfo['shouldClose'], slot = i, combinable = itemInfo['combinable'] }
                        self.Functions.UpdatePlayerData()
                        TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'AddItem', 'green', '**' .. self.PlayerData.charinfo.firstname..' '..self.PlayerData.charinfo.lastname .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** got item: itemname: ' .. itemInfo['name'] .. ', added amount: ' .. amount)
                        return true
                    end
				end
			else
				for i = 1, QBConfig.Player.MaxInvSlots, 1 do
					if not self.PlayerData.items[i] then
                        if dropAmount > 0 then
						    dropAmount = dropAmount - 1
                            self.PlayerData.items[i] = { name = itemInfo['name'], amount = 1, info = info, label = itemInfo['label'], description = itemInfo['description'] or '', weight = vazn, type = itemInfo['type'], unique = itemInfo['unique'], useable = itemInfo['useable'], image = itemInfo['image'], shouldClose = itemInfo['shouldClose'], slot = i, combinable = itemInfo['combinable'] }
					    else
                            break
                        end
                    end
				end
                self.Functions.UpdatePlayerData()
                TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'AddItem', 'green', '**' .. self.PlayerData.charinfo.firstname..' '..self.PlayerData.charinfo.lastname .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** got item: itemname: ' .. itemInfo['name'] .. ', added amount: ' .. dropAmount)
                if dropAmount == 0 then
					return true
				end
			end
        end
        local coord = GetEntityCoords(GetPlayerPed(self.PlayerData.source))
        TriggerEvent('qb-inventory:system:dropSoloItem', {coords=vector3(coord.x,coord.y,coord.z-1), heading=0, amount=dropAmount, item={name=itemInfo['name'],amount=dropAmount,info=info,label=itemInfo['label'],description=itemInfo['description'],weight=vazn,type=itemInfo['type'],unique =itemInfo['unique'],useable=itemInfo['useable'],image=itemInfo['image'],shouldClose=itemInfo['shouldClose'],slot=1,combinable=itemInfo['combinable']}})
        return true
    end

    function self.Functions.RemoveItem(item, amount, slot)
        amount = tonumber(amount)
        slot = tonumber(slot)
        if slot then
            if self.PlayerData.items[slot].amount > amount then
                self.PlayerData.items[slot].amount = self.PlayerData.items[slot].amount - amount
                self.Functions.UpdatePlayerData()
                TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'RemoveItem', 'red', '**' .. self.PlayerData.charinfo.firstname..' '..self.PlayerData.charinfo.lastname .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** lost item: [slot:' .. slot .. '], itemname: ' .. self.PlayerData.items[slot].name .. ', removed amount: ' .. amount .. ', new total amount: ' .. self.PlayerData.items[slot].amount)
                return true
            elseif self.PlayerData.items[slot].amount == amount then
                self.PlayerData.items[slot] = nil
                self.Functions.UpdatePlayerData()
                TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'RemoveItem', 'red', '**' .. self.PlayerData.charinfo.firstname..' '..self.PlayerData.charinfo.lastname .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** lost item: [slot:' .. slot .. '], itemname: ' .. item .. ', removed amount: ' .. amount .. ', item removed')
                return true
            end
        else
            local slots = QBCore.Player.GetSlotsByItem(self.PlayerData.items, item)
            local amountToRemove = amount
            if slots then
                for _, _slot in pairs(slots) do
                    if self.PlayerData.items[_slot].amount > amountToRemove then
                        self.PlayerData.items[_slot].amount = self.PlayerData.items[_slot].amount - amountToRemove
                        self.Functions.UpdatePlayerData()
                        TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'RemoveItem', 'red', '**' .. self.PlayerData.charinfo.firstname..' '..self.PlayerData.charinfo.lastname .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** lost item: [slot:' .. _slot .. '], itemname: ' .. self.PlayerData.items[_slot].name .. ', removed amount: ' .. amount .. ', new total amount: ' .. self.PlayerData.items[_slot].amount)
                        return true
                    elseif self.PlayerData.items[_slot].amount == amountToRemove then
                        self.PlayerData.items[_slot] = nil
                        self.Functions.UpdatePlayerData()
                        TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'RemoveItem', 'red', '**' .. self.PlayerData.charinfo.firstname..' '..self.PlayerData.charinfo.lastname .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** lost item: [slot:' .. _slot .. '], itemname: ' .. item .. ', removed amount: ' .. amount .. ', item removed')
                        return true
                    end
                end
            end
        end
        return false
    end

    function self.Functions.SetInventory(items)
        self.PlayerData.items = items
        self.Functions.UpdatePlayerData()
        TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'SetInventory', 'blue', '**' .. self.PlayerData.charinfo.firstname..' '..self.PlayerData.charinfo.lastname .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** items set: ' .. json.encode(items))
    end

    function self.Functions.ClearInventory()
        self.PlayerData.items = {}
        self.Functions.UpdatePlayerData()
        TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'ClearInventory', 'red', '**' .. self.PlayerData.charinfo.firstname..' '..self.PlayerData.charinfo.lastname .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** inventory cleared')
    end

    function self.Functions.GetItemByName(item)
        item = tostring(item):lower()
        local slot = QBCore.Player.GetFirstSlotByItem(self.PlayerData.items, item)
        return self.PlayerData.items[slot]
    end

    function self.Functions.GetItemsByName(item)
        item = tostring(item):lower()
        local items = {}
        local slots = QBCore.Player.GetSlotsByItem(self.PlayerData.items, item)
        for _, slot in pairs(slots) do
            if slot then
                items[#items+1] = self.PlayerData.items[slot]
            end
        end
        return items
    end

    function self.Functions.GetItemBySlot(slot)
        slot = tonumber(slot)
        return self.PlayerData.items[slot]
    end

    function self.Functions.Save()
        QBCore.Player.Save(self.PlayerData.source, self.PlayerData)
    end

    QBCore.Players[self.PlayerData.source] = self

    -- At this point we are safe to emit new instance to third party resource for load handling
    TriggerEvent('QBCore:Server:PlayerLoaded', self)
    self.Functions.UpdatePlayerData()

    -- Admin Permissions
    if QBShared.Permissions[self.PlayerData.discord] then
        QBCore.Player_Permissions[self.PlayerData.discord] = QBShared.Permissions[self.PlayerData.discord]
    end
    QBCore.Commands.Refresh(self.PlayerData.source)
end

-- Save player info to database (make sure citizenid is the primary key in your database)

local function disp_time(time)
    local days = math.floor(time/86400)
    local remaining = time % 86400
    local hours = math.floor(remaining/3600)
    remaining = remaining % 3600
    local minutes = math.floor(remaining/60)
    remaining = remaining % 60
    local seconds = remaining
    if (hours < 10) then
      hours = "0" .. tostring(hours)
    end
    if (minutes < 10) then
      minutes = "0" .. tostring(minutes)
    end
    if (seconds < 10) then
      seconds = "0" .. tostring(seconds)
    end
    return tostring(days)..':'..hours..':'..minutes..':'..seconds
  end

function QBCore.Player.Save(source, PlayerData)
    local ped = GetPlayerPed(source)
    local pcoords = GetEntityCoords(ped)
    local inventory = QBCore.Player.SaveInventory(PlayerData)
    if JoinTimes[source] then
        local tp = os.time() - JoinTimes[source]
        PlayerData.metadata.timePlay = tp + PlayerData.metadata.timePlay
        local discordid = string.gsub(PlayerData.discord, 'discord:', '')
        local cash = GetCash(PlayerData.items)
        TriggerEvent('qb-log:server:CreateLog', 'timeplay', 'TimePlay', 'green', PlayerData.name..' ('..source..') \n'..discordid..' | <@'..discordid..'> \n'..PlayerData.charinfo.firstname..' '..PlayerData.charinfo.lastname..' ('..PlayerData.citizenid..') \nPhone: '..PlayerData.charinfo.phone..'\nNationality: '..PlayerData.charinfo.nationality..'\nJob: '..PlayerData.job.label..' | '..PlayerData.job.grade.name..' \nGang: '..PlayerData.gang.label..' | '..PlayerData.gang.grade.name..'\nCash: $'..cash..' \nBank: $'..PlayerData.money.bank..' \nPaycheck: $'..PlayerData.money.paycheck..' \nTimePlay: '..disp_time(tp)..' \nAll: '..disp_time(PlayerData.metadata.timePlay))
        if PlayerData.job.name == 'police' then
            TriggerEvent('qb-log:server:CreateLog', 'pdtime', PlayerData.charinfo.firstname..' '..PlayerData.charinfo.lastname, 'blue', 'Grade: '..PlayerData.job.grade.name..' \nTimePlay: '..disp_time(tp)..' \nAll: '..disp_time(PlayerData.metadata.timePlay))
        elseif PlayerData.job.name == 'ambulance' then
            TriggerEvent('qb-log:server:CreateLog', 'mdtime', PlayerData.charinfo.firstname..' '..PlayerData.charinfo.lastname, 'blue', 'Grade: '..PlayerData.job.grade.name..' \nTimePlay: '..disp_time(tp)..' \nAll: '..disp_time(PlayerData.metadata.timePlay))
        end
    end
    MySQL.update('UPDATE players SET `money` = @money, `charinfo` = @charinfo, `job` = @job, `gang` = @gang, `position` = @position, `metadata` = @metadata, `inventory` = @inventory, `lastPlay` = @lastPlay WHERE citizenid = @citizenid',
    {
        citizenid = PlayerData.citizenid,
        money = json.encode(PlayerData.money),
        charinfo = json.encode(PlayerData.charinfo),
        job = json.encode(PlayerData.job),
        gang = json.encode(PlayerData.gang),
        position = json.encode(pcoords),
        metadata = json.encode(PlayerData.metadata),
        inventory = inventory,
        lastPlay = os.date("%x")
    }, function(rowsChanged)
        QBCore.ShowSuccess(GetCurrentResourceName(), PlayerData.citizenid .. ' PLAYER SAVED!')
    end)
end

function QBCore.Player.SaveInventory(PlayerData)
    local items = PlayerData.items
    local ItemsJson = {}
    if items and next(items) then
        for slot, item in pairs(items) do
            if items[slot] then
                ItemsJson[#ItemsJson+1] = {
                    name = item.name,
                    amount = item.amount,
                    info = item.info,
                    type = item.type,
                    weight = item.weight,
                    slot = slot,
                }
            end
        end
        return json.encode(ItemsJson)
    else
        return '[]'
    end
end

-- Util Functions

function QBCore.Player.GetTotalWeight(items)
    local weight = 0
    if not items then return 0 end
    for _, item in pairs(items) do
        weight += item.weight * item.amount
    end
    return tonumber(weight)
end

function QBCore.Player.GetSlotsByItem(items, itemName)
    local slotsFound = {}
    if not items then return slotsFound end
    for slot, item in pairs(items) do
        if item.name:lower() == itemName:lower() then
            slotsFound[#slotsFound+1] = slot
        end
    end
    return slotsFound
end

function QBCore.Player.GetFirstSlotByItem(items, itemName)
    if not items then return nil end
    for slot, item in pairs(items) do
        if item.name:lower() == itemName:lower() then
            return tonumber(slot)
        end
    end
    return nil
end

function QBCore.Player.SetWeight(src, slot, weight)
    if not slot or not weight then return false end
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        local inventory = Player.PlayerData.items
        if slot ~= nil then
            local usedItem = inventory[slot]
            if usedItem ~= nil then
                usedItem.weight = weight
                inventory[slot] = usedItem
                Player.Functions.SetInventory(inventory)
                return true
            end
        end
    end
    return false
end

function QBCore.Player.DecayItem(src, itemName, damage, slotSend)
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        local inventory = Player.PlayerData.items
        local slot = slotSend or QBCore.Player.GetFirstSlotByItem(inventory, itemName)
        if slot ~= nil then
            local usedItem = inventory[slot]
            if type(usedItem.info) ~= 'table' then
                usedItem.info = {}
            end
            if usedItem.info.quality == nil then
                usedItem.info.quality = 100
            end
            usedItem.info.quality = usedItem.info.quality - damage
            if usedItem.info.quality < 0 then
                usedItem.info.quality = 0
            end
            inventory[slot] = usedItem
            Player.Functions.SetInventory(inventory)
            return true
        end
    end
    return false
end

function QBCore.Player.RepairItem(src, itemName, slotSend)
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        local inventory = Player.PlayerData.items
        local slot = slotSend or QBCore.Player.GetFirstSlotByItem(inventory, itemName)
        if slot ~= nil then
            local usedItem = inventory[slot]
            if type(usedItem.info) ~= 'table' then
                usedItem.info = {}
            end
            usedItem.info.quality = 100
            usedItem.info.created = os.time()
            if usedItem.name == 'zatps' or usedItem.name == 'zatmb' or usedItem.name == 'zatcpu' or usedItem.name == 'zatgpu' then
                usedItem.info.performance = 100
            end
            inventory[slot] = usedItem
            Player.Functions.SetInventory(inventory)
            return true
        end
    end
    return false
end

function QBCore.Player.SetItemInfo(source, itemName, val, slotSend)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        local inventory = Player.PlayerData.items
        local slot = slotSend or QBCore.Player.GetFirstSlotByItem(inventory, itemName)
        if slot ~= nil then
            local usedItem = inventory[slot]
            if type(usedItem.info) ~= 'table' then
                usedItem.info = {}
            end
            usedItem.info = val
            inventory[slot] = usedItem
            Player.Functions.SetInventory(inventory)
            return true
        end
    end
    return false
end

function QBCore.Player.CreateCitizenId()
    local UniqueFound = false
    local CitizenId = nil
    while not UniqueFound do
        CitizenId = tostring(QBCore.Shared.RandomInt(5))
        local result = MySQL.prepare.await('SELECT COUNT(*) as count FROM players WHERE citizenid = ?', { CitizenId })
        local result2 = MySQL.prepare.await('SELECT COUNT(*) as count FROM playerskins WHERE citizenid = ?', { CitizenId })
        if result == 0 and result2 == 0 then
            UniqueFound = true
        end
    end
    return CitizenId
end

function QBCore.Functions.CreatePhoneNumber()
    local UniqueFound = false
    local PhoneNumber = nil
    while not UniqueFound do
        PhoneNumber = math.random(100,999) .. '555' .. math.random(1000,9999)
        local query = '%' .. PhoneNumber .. '%'
        local result = MySQL.prepare.await('SELECT COUNT(*) as count FROM players WHERE charinfo LIKE ?', { query })
        if result == 0 then
            UniqueFound = true
        end
    end
    return PhoneNumber
end

function QBCore.Player.CreateFingerId()
    local UniqueFound = false
    local FingerId = nil
    while not UniqueFound do
        FingerId = tostring(QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(1) .. QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(4))
        local query = '%' .. FingerId .. '%'
        local result = MySQL.prepare.await('SELECT COUNT(*) as count FROM `players` WHERE `metadata` LIKE ?', { query })
        if result == 0 then
            UniqueFound = true
        end
    end
    return FingerId
end

function QBCore.Player.CreateSerialNumber()
    local UniqueFound = false
    local SerialNumber = nil
    while not UniqueFound do
        SerialNumber = math.random(11111111, 99999999)
        local query = '%' .. SerialNumber .. '%'
        local result = MySQL.prepare.await('SELECT COUNT(*) as count FROM players WHERE metadata LIKE ?', { query })
        if result == 0 then
            UniqueFound = true
        end
    end
    return SerialNumber
end

