---------- [Locals] ----------

------------------------------

---------- [Functions] ----------
function PugFindPlayersByItentifier(identifier, bool)
    local players = GetPlayers()
    for _, v in ipairs(players) do
        local playerIdentifier = FWork.GetIdentifier(v)
        if playerIdentifier == identifier then
            if Config.Debug then
                print("player found:", v)
            end
            if bool then
                return v
            else
                return FWork.GetPlayerFromId(v)
            end
        end
    end
end
local function GetIdentifiers(source, idtype)
	local identifiers = GetPlayerIdentifiers(source)
	for _, identifier in pairs(identifiers) do
		if string.find(identifier, idtype) then
			return identifier
		end
	end
	return nil
end
------------------------------

---------- [Events] ----------
RegisterNetEvent("Pug:server:CreateNewBusiness", function(BusinessName)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    if Player ~= nil then
        local result = MySQL.query.await('SELECT * FROM pug_businesses', {})
        if result[1] ~= nil then
            local CanMakeJob = true
            for _, v in pairs(result) do
                if string.lower(v.job) == string.lower(BusinessName) then
                    TriggerClientEvent("Pug:client:ShowBusinessNotify", src, Config.LangT["BusinessCreatedAlready"], "error")
                    CanMakeJob = false
                    break
                end
            end
            if CanMakeJob then
                MySQL.insert.await('INSERT INTO pug_businesses (job, registers, cookstations, trays, storage, supplies, seats, trashcans, blip, duty, bossmenu, locker, animations, props, peds, zone, whiteboard, items, createditems, garage, creator) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)', {
                    BusinessName, json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}), json.encode({}), Player.PlayerData.charinfo.firstname
                })
                local result2 = MySQL.query.await('SELECT * FROM pug_businesses', {})
                if result2[1] ~= nil then
                    TriggerClientEvent("Pug:client:OpenBusinessCreatorUI",src, result2)
                    TriggerClientEvent("Pug:client:UpdateAllBsuinessData",-1, result2)
                end
            end
        else
            MySQL.insert.await('INSERT INTO pug_businesses (job, registers, cookstations, trays, storage, supplies, seats, trashcans, blip, duty, bossmenu, locker, animations, props, peds, zone, whiteboard, items, createditems, garage, creator) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)', {
                BusinessName, json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}),json.encode({}), json.encode({}), Player.PlayerData.charinfo.firstname
            })
            local result2 = MySQL.query.await('SELECT * FROM pug_businesses', {})
            if result2[1] ~= nil then
                TriggerClientEvent("Pug:client:OpenBusinessCreatorUI",src, result2)
                TriggerClientEvent("Pug:client:UpdateAllBsuinessData",-1, result2)
            end
        end
        if Framework == "ESX" then
            if GetResourceState("esx_society") ~= 'missing' then
                if GetResourceState("esx_addonaccount") ~= 'missing' then
                    local result3 = MySQL.query.await('SELECT * FROM pug_businesses', {})
                    if result3[1] ~= nil then
                        for k, _ in pairs(result3) do
                            local ThisJob = result3[k]["job"]
                            local DoesSocietyExist = MySQL.query.await('SELECT * FROM addon_account WHERE name = ?', {"society_"..ThisJob})
                            if DoesSocietyExist[1] then
                                TriggerEvent('esx_society:registerSociety', tostring(ThisJob), tostring(ThisJob), 'society_'..tostring(ThisJob), 'society_'..tostring(ThisJob), 'society_'..tostring(ThisJob), { type = 'public' })
                            else
                                MySQL.insert('INSERT INTO addon_account (name, label, shared) VALUES (?, ?, ?)', {"society_"..ThisJob, ThisJob, 1})
                                TriggerEvent('esx_society:registerSociety', tostring(ThisJob), tostring(ThisJob), 'society_'..tostring(ThisJob), 'society_'..tostring(ThisJob), 'society_'..tostring(ThisJob), { type = 'public' })
                            end
                        end
                    end
                end
            end
        end
    end
end)
RegisterNetEvent("Pug:server:AddNewFeatureLocation", function(Data)
    local src = source
    local Business = Data.Business
    local Feature = Data.Feature
	local result = MySQL.query.await('SELECT * FROM pug_businesses', {})
	if result[1] ~= nil then
        for _, v in pairs(result) do
            if string.lower(v.job) == string.lower(Business) then
                local Upgrades = {}
                if Feature == "props" then
                    local StopRunning
                    local DecodedFeatureData = json.decode(v[Feature])
                    for _, j in pairs(DecodedFeatureData) do
                        if tostring(j.Animation) == tostring(Data.Animation) then
                            if tostring(Data.Animation) == "prop_b_board_blank" or tostring(Data.Animation) == "prop_tv_flat_michael" then
                                StopRunning = tostring(Data.Animation)
                                break
                            end
                        end
                    end
                    if StopRunning then
                        TriggerClientEvent("Pug:client:ShowBusinessNotify", src, Config.LangT["AlreadyPlacedProp"].." "..StopRunning, "error")
                        return
                    end
                end
                if Feature == "blip" or Feature == "zone" then
                    Upgrades[#Upgrades+1] = Data
                    if Feature == "zone" and Data.MinZ then
                    else
                        if Feature == "zone" then
                            Upgrades = {}
                        end
                    end
                elseif Feature == "whiteboard" then
                    local DecodedFeatureData = json.decode(v[Feature])
                    if DecodedFeatureData[1] ~= nil then
                        if tostring(DecodedFeatureData[1].Prop) == tostring(Data.Prop) then
                            Upgrades[#Upgrades+1] = Data
                            if DecodedFeatureData[2] ~= nil then
                                Upgrades[#Upgrades+1] = DecodedFeatureData[2]
                            end
                        elseif DecodedFeatureData[2] ~= nil then
                            if tostring(DecodedFeatureData[2].Prop) == tostring(Data.Prop) then
                                Upgrades[#Upgrades+1] = DecodedFeatureData[1]
                                Upgrades[#Upgrades+1] = Data
                            end
                        else
                            Upgrades[#Upgrades+1] = DecodedFeatureData[1]
                            Upgrades[#Upgrades+1] = Data
                        end
                    else
                        Upgrades[#Upgrades+1] = Data
                    end
                else
                    for _, featureValue in pairs(json.decode(v[Feature])) do
                        Upgrades[#Upgrades+1] = featureValue
                    end
                    Upgrades[#Upgrades+1] = Data
                end
                MySQL.update('UPDATE pug_businesses SET '.. Feature.. ' = ? WHERE job = ?', { json.encode( Upgrades ), Business })
                Wait(500)
                local result2 = MySQL.query.await('SELECT * FROM pug_businesses', {})
                if result2[1] ~= nil then
                    if Feature == "whiteboard" then
                        for key, v in pairs(result2) do
                            if result2[key]["job"] == Business then
                                local DecodedData = json.decode(result2[key][Feature])
                                for _, j in pairs(DecodedData) do
                                    if tostring(j.Prop) == tostring(Data.Prop) then
                                        TriggerClientEvent("Pug:client:CreateAllTargetswhiteboard", -1, j, false, tostring(Data.Prop), Upgrades)
                                        break
                                    end
                                end
                            end
                        end
                    else
                        for key, v in pairs(result2) do
                            for k, _ in pairs(v) do
                                if k == "id" or k == "creator" or k == "whiteboard" then
                                else
                                    if result2[key]["job"] == Business then
                                        if k == Feature then
                                            TriggerClientEvent("Pug:client:CreateAllTargets"..k, -1, v)
                                            break
                                        end
                                    end
                                end
                            end
                        end
                        TriggerClientEvent("Pug:client:UpdateAllBsuinessData",-1, result2)
                    end
                end
            end
        end
    end
end)

local propsBeingRemoved = {}
RegisterNetEvent("Pug:server:AttemptToRemoveZone", function(Data, Bool)
    local src = source
    if Bool then
        local uniqueKey = string.format("%s-%s-(%.2f,%.2f,%.2f)",
            tostring(Data.Business),
            tostring(Data.Feature),
            (Data.Target and Data.Target.x or 0),
            (Data.Target and Data.Target.y or 0),
            (Data.Target and Data.Target.z or 0)
        )
        if propsBeingRemoved[uniqueKey] then
            print(("Skipping removal: %s is already being removed by someone."):format(uniqueKey))
            return
        end
        propsBeingRemoved[uniqueKey] = true
        CreateThread(function()
            Wait(5000) 
            propsBeingRemoved[uniqueKey] = nil
        end)
    end
    local Business = Data.Business
    local Feature = Data.Feature
    local Target = Data.Target
	local result = MySQL.query.await('SELECT * FROM pug_businesses', {})
	if result[1] ~= nil then
        local RemoveWhiteBoard
        for k, v in pairs(result) do
            if string.lower(v.job) == string.lower(Business) then
                local Upgrades = {}
                local TargetToRemnove
                for _, featureValue in pairs(json.decode(v[Feature])) do
                    local TargetCoords = vector3(featureValue.Target.x, featureValue.Target.y, featureValue.Target.z)
                    local distanceThreshold = (featureValue.Animation == "lts_prop_lts_ramp_03") and 0.9 or 0.7
                    if #(TargetCoords - vector3(Target.x, Target.y, Target.z)) <= distanceThreshold then
                        if not TargetToRemnove then
                            TargetToRemnove = TargetCoords
                            if Feature == "props" then
                                if featureValue.Animation == "prop_tv_flat_michael" or featureValue.Animation == "prop_b_board_blank" then
                                    local DecodedFeatureData = json.decode(v["whiteboard"])
                                    if DecodedFeatureData[1] ~= nil then
                                        if tostring(DecodedFeatureData[1].Prop) == tostring(featureValue.Animation) then
                                            DecodedFeatureData[1].UrlLink = "none"
                                            RemoveWhiteBoard = DecodedFeatureData[1]
                                            MySQL.update('UPDATE pug_businesses SET whiteboard = ? WHERE job = ?', { json.encode( DecodedFeatureData ), Business })
                                        elseif DecodedFeatureData[2] ~= nil then
                                            if tostring(DecodedFeatureData[2].Prop) == tostring(featureValue.Animation) then
                                                DecodedFeatureData[2].UrlLink = "none"
                                                RemoveWhiteBoard = DecodedFeatureData[2]
                                                MySQL.update('UPDATE pug_businesses SET whiteboard = ? WHERE job = ?', { json.encode( DecodedFeatureData ), Business })
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            Upgrades[#Upgrades+1] = featureValue
                        end
                    else
                        Upgrades[#Upgrades+1] = featureValue
                    end
                end
                if not TargetToRemnove then
                    TriggerClientEvent("Pug:client:ShowBusinessNotify", src, "No "..Feature..Config.LangT["NothingFound"], "error")
                    return
                end
                MySQL.update('UPDATE pug_businesses SET '.. Feature.. ' = ? WHERE job = ?', { json.encode( Upgrades ), Business })
                Wait(100)
                local result2 = MySQL.query.await('SELECT * FROM pug_businesses', {})
                if result2[1] ~= nil then
                    for key, v in pairs(result2) do
                        for k, _ in pairs(v) do
                            if k == "id" or k == "creator" or k == "whiteboard" and not RemoveWhiteBoard then
                            else
                                if result2[key]["job"] == Business then
                                    if k == Feature then
                                        TriggerClientEvent("Pug:client:CreateAllTargets"..k, -1, v)
                                        if not RemoveWhiteBoard then
                                            break
                                        end
                                    elseif RemoveWhiteBoard and k == "whiteboard" then
                                        local DecodedData = json.decode(result2[key]["whiteboard"])
                                        for _, j in pairs(DecodedData) do
                                            if tostring(j.Prop) == tostring(RemoveWhiteBoard.Prop) then
                                                TriggerClientEvent("Pug:client:CreateAllTargetswhiteboard", -1, j, false, tostring(RemoveWhiteBoard.Prop), DecodedData)
                                                break
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    TriggerClientEvent("Pug:client:UpdateAllBsuinessData",-1, result2)
                end
            end
        end
    end
end)
RegisterNetEvent("Pug:server:DeleteBusinessForever", function(Business)
    local src = source
    local Business = Business
	local result = MySQL.query.await('SELECT * FROM pug_businesses', {})
	if result[1] ~= nil then
        for k, v in pairs(result) do
            if string.lower(v.job) == string.lower(Business) then
                MySQL.query('DELETE FROM pug_businesses WHERE job="'..Business..'"')
                Wait(100)
                local result2 = MySQL.query.await('SELECT * FROM pug_businesses', {})
                TriggerClientEvent("Pug:client:UpdateAllBsuinessData",-1, result2)
                TriggerClientEvent("Pug:client:RemoveAllJobFeatures",-1, Business)
            end
        end
    end
end)

Config.FrameworkFunctions.CreateCallback('getServerTime', function(source, cb)
    local serverTime = os.time()
    cb(serverTime)
end)

Config.FrameworkFunctions.CreateCallback('Pug:server:GetESXPlayerDataBusiness', function(source, cb)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src).PlayerData
    cb(Player)
end)

RegisterNetEvent('Pug:server:BuyShopItems', function(Data)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    local item = Data.item
    local selectedQuantity = Data.selectedQuantity

    MySQL.Async.fetchAll('SELECT stocking FROM pug_businesses WHERE job = @job', {
        ['@job'] = Data.MainData.Business
    }, function(result)
        if result and #result > 0 then
            local stockingData = json.decode(result[1].stocking)
            local cost, stockQuantity = Data.cost, Data.quantity
            local MetaData = Data.MetaData
            
            if not cost or not stockQuantity then
                TriggerClientEvent('Pug:client:ShowBusinessNotify', src, 'Item not found in stock', 'error')
                return
            end

            local totalCost = cost * selectedQuantity
            local playerMoney = Player.PlayerData.money.cash
            local paymentType = "cash"

            if Framework == "QBCore" then
                paymentType = "cash"
            elseif Framework == "ESX" then
                paymentType = "money"
            end

            if playerMoney >= totalCost then
                if Framework == "QBCore" then
                    Player.RemoveMoney(paymentType, totalCost)
                elseif Framework == "ESX" then
                    Player.RemoveMoney(paymentType, totalCost)
                end

                if GetResourceState("tgiann-inventory") == 'started' then
                    exports["tgiann-inventory"]:AddItem(src, item, selectedQuantity, false, MetaData)
                elseif GetResourceState("ox_inventory") == 'started' then
                    exports.ox_inventory:AddItem(src, item, selectedQuantity, MetaData)
                elseif Config.InventoryType == "qs-inventory" then
                    exports['qs-inventory']:AddItem(src, item, selectedQuantity, false, MetaData)
                elseif Config.InventoryType == "codem-inventory" then
                    exports['codem-inventory']:AddItem(src, item, selectedQuantity)
                elseif Framework == "QBCore" then
                    Player.AddItem(item, selectedQuantity, false, MetaData)
                elseif Framework == "ESX" then
                    Player.AddItem(item, selectedQuantity)
                end

                for i, stock in pairs(stockingData[1].StockedData) do
                    if stock.item == item then
                        if stock.quantity == stockQuantity then
                            if stock.cost == cost then
                                if stockingData[1].money ~= nil then
                                    stockingData[1].money = stockingData[1].money + totalCost
                                else
                                    stockingData[1].money = totalCost
                                end
                                stock.quantity = stock.quantity - selectedQuantity
                                if stock.quantity <= 0 then
                                    table.remove(stockingData[1].StockedData, i)
                                end
                                break
                            end
                        end
                    end
                end

                local NewInfo = {
                    Business = stockingData[1].Business,
                    Feature = "stocking",
                    Target = stockingData[1].Target,
                    PedCoords = stockingData[1].PedCoords,
                    Animation = stockingData[1].Animation,
                    Heading = stockingData[1].Heading,
                    StockedData = stockingData[1].StockedData,
                    money = stockingData[1].money or 0, 
                }

                MySQL.Async.execute('UPDATE pug_businesses SET stocking = @stocking WHERE job = @job', {
                    ['@stocking'] = json.encode(stockingData),
                    ['@job'] = Data.MainData.Business
                })

                TriggerClientEvent('Pug:client:ShowBusinessNotify', src, 'You bought ' .. selectedQuantity .. ' ' .. item .. '(s) for $' .. totalCost, 'success')

                TriggerClientEvent('Pug:client:UpdateBusinessStock', src, NewInfo)
            else
                TriggerClientEvent('Pug:client:ShowBusinessNotify', src, 'You do not have enough money to buy ' .. selectedQuantity .. ' ' .. item .. '(s)', 'error')
            end
        else
            TriggerClientEvent('Pug:client:ShowBusinessNotify', src, 'Business not found', 'error')
        end
    end)
end)

RegisterNetEvent('Pug:server:SaveApplications', function(job, Info, Results)
    local src = source
    MySQL.Async.fetchAll('SELECT application FROM pug_businesses WHERE job = @job', {
        ['@job'] = job
    }, function(result)
        if result and #result > 0 then
            local Applications = json.decode(result[1].application)
            Applications = {
                Heading = Applications[1].Heading,
                Target = Applications[1].Target,
                PedCoords = Applications[1].PedCoords,
                Business = job,
                Feature = "application",
                Animation = Applications[1].Animation,
                ApplicationData = Info or {},
                TestResults = Results or {}
            }
            MySQL.Async.execute('UPDATE pug_businesses SET application = @application WHERE job = @job', {
                ['@application'] = json.encode({Applications}),
                ['@job'] = job
            })

            Wait(100)
            local result2 = MySQL.query.await('SELECT * FROM pug_businesses', {})
            if result2[1] ~= nil then
                for key, v in pairs(result2) do
                    for k, _ in pairs(v) do
                        if k == "id" or k == "creator" or k == "whiteboard" then
                        else
                            if result2[key]["job"] == job then
                                if k == "application" then
                                    TriggerClientEvent("Pug:client:CreateAllTargets"..k, -1, v)
                                    break
                                end
                            end
                        end
                    end
                end
                TriggerClientEvent("Pug:client:UpdateAllBsuinessData",-1, result2)
            end
        else
            TriggerClientEvent('Pug:client:ReceiveApplications', src, {})
        end
    end)
end)

RegisterNetEvent('Pug:Server:GetJobStats', function(Type)
    local src = source
    local jobStats = {}
    
    if Framework == "QBCore" then
        for jobName, jobData in pairs(FWork.Shared.Jobs) do
            jobStats[jobName] = {}
            for grade, gradeData in pairs(jobData.grades) do
                local count = MySQL.Sync.fetchScalar('SELECT COUNT(*) FROM players WHERE JSON_EXTRACT(job, "$.name") = @job AND JSON_EXTRACT(job, "$.grade.level") = @grade', {
                    ['@job'] = jobName,
                    ['@grade'] = tonumber(grade)
                }) or 0
                table.insert(jobStats[jobName], {grade = gradeData.name, count = count})
            end
        end

        if Type == "balance" then
            local jobNames = {}
            for jobName, _ in pairs(FWork.Shared.Jobs) do
                table.insert(jobNames, "'" .. jobName .. "'")
            end
            local bankBalances
            local jobNamesStr = table.concat(jobNames, ",")
            if GetResourceState("qbx_core") == 'started' then
                bankBalances = MySQL.Sync.fetchAll('SELECT creator, amount FROM bank_accounts_new WHERE creator IN (' .. jobNamesStr .. ')')
            else
                bankBalances = MySQL.Sync.fetchAll('SELECT account_name, account_balance FROM bank_accounts WHERE account_name IN (' .. jobNamesStr .. ')')
            end
            
            for _, row in ipairs(bankBalances) do
                local accountName
                local accountBalance
                if GetResourceState("qbx_core") == 'started' then
                    accountName = row.creator
                    accountBalance = row.amount
                else
                    accountName = row.account_name
                    accountBalance = row.account_balance
                end
                if jobStats[accountName] then
                    jobStats[accountName].bank_balance = accountBalance
                end
            end
        end
    elseif Framework == "ESX" then
        local Jobs = {}
        local jobGrades = {}

        local jobs = MySQL.query.await('SELECT * FROM jobs')
        for _, v in pairs(jobs) do
            Jobs[v.name] = v
            Jobs[v.name].grades = {}
        end

        local jobGrades = MySQL.query.await('SELECT * FROM job_grades')
        for _, v in pairs(jobGrades) do
            if Jobs[v.job_name] then
                Jobs[v.job_name].grades[tostring(v.grade)] = v
            else
                print(('[^3WARNING^7] Ignoring job grades for ^5"%s"^0 due to missing job'):format(v.job_name))
            end
        end

        for _, v in pairs(Jobs) do
            if FWork.Table.SizeOf(v.grades) == 0 then
                Jobs[v.name] = nil
                print(('[^3WARNING^7] Ignoring job ^5"%s"^0 due to no job grades found'):format(v.name))
            end
        end

        if not Jobs then
            FWork.Jobs['unemployed'] = {label = 'Unemployed', 
                grades = {
                    ['0'] = {grade = 0, label = 'Unemployed', salary = 200, skin_male = {}, skin_female = {}}
                }
            }
        else
            FWork.Jobs = Jobs
        end

        for jobName, jobData in pairs(FWork.Jobs) do
            jobStats[jobName] = {}
            for grade, gradeData in pairs(jobData.grades) do
                local count = MySQL.Sync.fetchScalar('SELECT COUNT(*) FROM users WHERE job = @job AND job_grade = @grade', {
                    ['@job'] = jobName,
                    ['@grade'] = tonumber(grade)
                }) or 0
                table.insert(jobStats[jobName], {grade = gradeData.label, count = count})
            end
        end

        if Type == "balance" then
            local jobNames = {}
            for jobName, _ in pairs(FWork.Jobs) do
                table.insert(jobNames, "'society_" .. jobName .. "'")
            end

            local jobNamesStr = table.concat(jobNames, ",")
            local bankBalances = MySQL.Sync.fetchAll('SELECT account_name, money FROM addon_account_data WHERE account_name IN (' .. jobNamesStr .. ')')
            
            for _, row in ipairs(bankBalances) do
                local jobName = row.account_name:sub(9) -- Remove 'society_' prefix
                if jobStats[jobName] then
                    jobStats[jobName].bank_balance = row.money
                end
            end
        end
    end

    TriggerClientEvent('receiveJobStats', src, jobStats)
end)


RegisterNetEvent("Pug:Server:SendLbPhoneMailBusiness", function(CID, emailData)
    local src = source
    local ToLbPhoneNumber = exports["lb-phone"]:GetEquippedPhoneNumber(CID)
    local ToLbPhoneEmail = exports["lb-phone"]:GetEmailAddress(tostring(ToLbPhoneNumber))
    exports["lb-phone"]:SendMail({
        to = ToLbPhoneEmail,
        subject = emailData.subject,
        sender = emailData.sender,
        message = emailData.message,
    })
end)

local function GetPlayerSourceByCID(cid)
    if Framework == "ESX" then
        local xPlayers = FWork.GetPlayers()
        for _, playerId in ipairs(xPlayers) do
            local xPlayer = FWork.GetPlayerFromId(playerId)
            if xPlayer then
                if tostring(FWork.GetIdentifier(playerId)) == tostring(cid) then
                    return playerId
                end
            end
        end
        return nil 
    else
        local players = FWork.Functions.GetPlayers()
        for _, playerId in ipairs(players) do
            local player = FWork.Functions.GetPlayer(playerId)
            if player then
                if tostring(player.PlayerData.citizenid) == tostring(cid) then
                    return playerId
                end
            end
        end
        return nil
    end
end

RegisterNetEvent("Pug:Server:SendOkPhoneMailBusiness", function(CID, emailData)
    local src = source
    local OtherPlayerSource = GetPlayerSourceByCID(CID)
    if OtherPlayerSource then
        local imei = exports.okokPhone:getImeiFromSource(tonumber(OtherPlayerSource))
        if not imei then return end
        local PlayerEmail = MySQL.prepare.await("SELECT email FROM okokphone_phones WHERE imei = ? LIMIT 1", {imei})
        if not PlayerEmail then return end
        local SenderImei = exports.okokPhone:getImeiFromSource(src)
        if not SenderImei then return end
        local SenderEmail = MySQL.prepare.await("SELECT email FROM okokphone_phones WHERE imei = ? LIMIT 1", {SenderImei})
        if not SenderEmail then return end
        local email = {
            sender = SenderEmail,
            recipients = {PlayerEmail},
            subject = emailData.subject,
            body = emailData.message,
        }
        exports.okokPhone:sendEmail(email)
    end
end)

RegisterNetEvent('Pug:server:CollectShopMoney', function(Data)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    if Framework == "QBCore" then
        local BossPlayer = FWork.Functions.GetPlayer(src)
        if not BossPlayer.PlayerData.job.isboss then
            TriggerClientEvent('Pug:client:ShowBusinessNotify', src, 'You need the boss rank to remove this money', 'error')
            return 
        end
    elseif Framework == "ESX" then
        local xPlayer = FWork.GetPlayerFromId(src)
        if not xPlayer.job.grade_name == 'boss' then
            TriggerClientEvent('Pug:client:ShowBusinessNotify', src, 'You need the boss rank to remove this money', 'error')
            return 
        end
    end
    
    local ThisJob = Data.args.job


    MySQL.Async.fetchAll('SELECT stocking FROM pug_businesses WHERE job = @job', {
        ['@job'] = ThisJob
    }, function(result)
        if result and #result > 0 then
            local stockingData = json.decode(result[1].stocking)
            local collectedMoney = 0
            if stockingData[1].money ~= nil then
                collectedMoney = collectedMoney + stockingData[1].money
            end


            if collectedMoney > 0 then
                if Framework == "ESX" then
                    Player.AddMoney('money', collectedMoney)
                else
                    Player.AddMoney('cash', collectedMoney)
                end


                local NewInfo = {
                    Business = stockingData[1].Business,
                    Feature = "stocking",
                    Target = stockingData[1].Target,
                    PedCoords = stockingData[1].PedCoords,
                    Animation = stockingData[1].Animation,
                    Heading = stockingData[1].Heading,
                    StockedData = stockingData[1].StockedData,
                    money = 0,
                }


                MySQL.Async.execute('UPDATE pug_businesses SET stocking = @stocking WHERE job = @job', {
                    ['@stocking'] = json.encode(stockingData),
                    ['@job'] = ThisJob
                })
                TriggerEvent('qb-log:server:CreateLog', 'business-stocked-money', "business stocked money", 'green',  GetPlayerName(src).." collected $".. collectedMoney .. " from "..ThisJob.." stocking stash")

                TriggerClientEvent('Pug:client:ShowBusinessNotify', src, 'You have collected $' .. collectedMoney .. ' from the shop', 'success')


                TriggerClientEvent('Pug:client:UpdateBusinessStock', src, NewInfo)
            else
                TriggerClientEvent('Pug:client:ShowBusinessNotify', src, 'There is no money to collect from the shop', 'error')
            end
        else
            TriggerClientEvent('Pug:client:ShowBusinessNotify', src, 'Business not found', 'error')
        end
    end)
end)










RegisterNetEvent("Pug:server:AttemptToEditStation", function(Data)
    local src = source
    local Business = Data.Business
    local Feature = Data.Feature
    local Target = Data.Target
	local result = MySQL.query.await('SELECT * FROM pug_businesses', {})
	if result[1] ~= nil then
        for k, v in pairs(result) do
            if string.lower(v.job) == string.lower(Business) then
                local Upgrades = {}
                local TargetToEdit
                for _, featureValue in pairs(json.decode(v[Feature])) do
                    local TargetCoords = vector3(featureValue.Target.x,featureValue.Target.y,featureValue.Target.z)
                    if #(TargetCoords - vector3(Target.x, Target.y, Target.z)) <= 0.7 then
                        if not TargetToEdit then
                            TargetToEdit = featureValue
                        else
                            Upgrades[#Upgrades+1] = featureValue
                        end
                    else
                        Upgrades[#Upgrades+1] = featureValue
                    end
                end
                if not TargetToEdit then
                    TriggerClientEvent("Pug:client:ShowBusinessNotify", src, "No "..Feature..Config.LangT["NothingFound"], "error")
                    return
                end
                if Feature == "cookstations" then
                    TriggerClientEvent("Pug:client:EditCraftingStation",src, TargetToEdit)
                elseif Feature == "supplies" then
                    TriggerClientEvent("Pug:client:EditSuppliesStation",src, TargetToEdit)
                end
            end
        end
    end
end)
RegisterServerEvent('Pug:server:NewGivBusinessItemAfterHacks', function(bool, item, amount, info)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
	if bool then
        if GetResourceState("tgiann-inventory") == 'started' then
            exports["tgiann-inventory"]:AddItem(src, item, amount or 1, false, info)
        elseif GetResourceState("ox_inventory") == 'started' then
            exports.ox_inventory:AddItem(src, item, amount or 1, info)
        else
            Player.AddItem(item, amount or 1, false, info)
        end
        if Framework == "QBCore" then
		    TriggerClientEvent('inventory:client:ItemBox', src, FWork.Shared.Items[item], "add", amount or 1)
        end
    else
        if GetResourceState("tgiann-inventory") == 'started' then
            exports["tgiann-inventory"]:RemoveItem(src, item, amount or 1)
        elseif GetResourceState("ox_inventory") == 'started' then
            exports.ox_inventory:RemoveItem(src, item, amount or 1, info)
        else
            Player.RemoveItem(item, amount or 1)
        end
        if Framework == "QBCore" then
		    TriggerClientEvent('inventory:client:ItemBox', src, FWork.Shared.Items[item], "remove", amount or 1)
        end
	end
end)

RegisterServerEvent('Pug:server:GivBusinessItem', function(bool, item, amount, info)
    local src = source
    MySQL.Async.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        GetPlayerName(src),
        GetIdentifiers(src, 'license'),
        GetIdentifiers(src, 'discord'),
        GetIdentifiers(src, 'ip'),
        "BANNED BY PUG | Reach out to staff to appeal. - Tell them to reach out to pug with the ban message. Tried to give himself "..amount.."x "..item,
        2145913200,
        'Business'
    })
    DropPlayer(src, "BANNED BY PUG | Reach out to staff to appeal. - Tell them to reach out to pug with the ban message. Tried to give himself "..amount.."x "..item)
end)
RegisterServerEvent('Pug:server:CreateNewServerItem', function(ItemInfo)
    local src = source
    if Config.DontRequireURLImages then
        if not ItemInfo.Weight then ItemInfo.Weight = 0 end
        local ItemWeight = math.ceil(ItemInfo.Weight * 1000)

        local Success = exports[Config.CoreName]:AddItem(ItemInfo.Item, {
            name = ItemInfo.Item,
            label = ItemInfo.Label,
            weight = ItemWeight,
            type = 'item',
            image = tostring(ItemInfo.Item..".png"),
            unique = ItemInfo.Unique,
            useable = true,
            shouldClose = true,
            combinable = false,
            description = ItemInfo.Description
        })
        Wait(1000)
        if Success then
            if ItemInfo.Type == "neither" then
            else
                FWork.Functions.CreateUseableItem(ItemInfo.Item, function(source, item)
                    local src = source
                    TriggerClientEvent("Pug:client:ConsumeItem", src, ItemInfo)
                end)
            end
            local Upgrades = {}
            Upgrades[#Upgrades+1] = ItemInfo
            local result = MySQL.query.await('SELECT * FROM pug_businesses', {})
            if result[1] ~= nil then
                for k, v in pairs(result) do
                    local ThisJob = result[k]["job"]
                    if ThisJob == ItemInfo.Job then
                        for u, i in pairs(json.decode(result[k]["createditems"])) do
                            Upgrades[#Upgrades+1] = i
                        end
                    end
                end
            end
            MySQL.update('UPDATE pug_businesses SET createditems = ? WHERE job = ?', { json.encode( Upgrades ), ItemInfo.Job })

            local Player = Config.FrameworkFunctions.GetPlayer(src)
            if Player ~= nil then
                Player.AddItem(ItemInfo.Item, 1)
                if Framework == "QBCore" then
                    TriggerClientEvent('inventory:client:ItemBox', src, FWork.Shared.Items[ItemInfo.Item], "add", 1)
                end
                TriggerClientEvent("Pug:client:ShowBusinessNotify", src, "Now restart your inventory.", "success")
            end
        else
            local Player = Config.FrameworkFunctions.GetPlayer(src)
            if Player ~= nil then
                Player.AddItem(ItemInfo.Item, 1)
                if Framework == "QBCore" then
                    TriggerClientEvent('inventory:client:ItemBox', src, FWork.Shared.Items[ItemInfo.Item], "add", 1)
                end
                TriggerClientEvent("Pug:client:ShowBusinessNotify", src, "Now restart your inventory.", "success")
            end
        end
    else
        PerformHttpRequest(ItemInfo.Image, function(statusCode, data, headers)
            if statusCode == 200 then
                
                local DownloadDirectory = Config.inventoryImagesDirectoryPath
                local filePath = DownloadDirectory .. "pug-"..ItemInfo.Item..".png"

                local file = io.open(filePath, "wb")
                if file ~= nil then
                    file:write(data)
                    file:close()
                    
                    local ItemWeight = math.ceil(ItemInfo.Weight * 1000)
                    local Success = exports[Config.CoreName]:AddItem(ItemInfo.Item, {
                        name = ItemInfo.Item,
                        label = ItemInfo.Label,
                        weight = ItemWeight,
                        type = 'item',
                        image = tostring("pug-"..ItemInfo.Item..".png"),
                        unique = ItemInfo.Unique,
                        useable = true,
                        shouldClose = true,
                        combinable = false,
                        description = ItemInfo.Description
                    })
                    Wait(1000)
                    if Success then
                        if ItemInfo.Type == "neither" then
                        else
                            FWork.Functions.CreateUseableItem(ItemInfo.Item, function(source, item)
                                local src = source
                                TriggerClientEvent("Pug:client:ConsumeItem", src, ItemInfo)
                            end)
                        end
                        local Upgrades = {}
                        Upgrades[#Upgrades+1] = ItemInfo
                        local result = MySQL.query.await('SELECT * FROM pug_businesses', {})
                        if result[1] ~= nil then
                            for k, v in pairs(result) do
                                local ThisJob = result[k]["job"]
                                if ThisJob == ItemInfo.Job then
                                    for u, i in pairs(json.decode(result[k]["createditems"])) do
                                        Upgrades[#Upgrades+1] = i
                                    end
                                end
                            end
                        end
                        MySQL.update('UPDATE pug_businesses SET createditems = ? WHERE job = ?', { json.encode( Upgrades ), ItemInfo.Job })
                        local Player = Config.FrameworkFunctions.GetPlayer(src)
                        if Player ~= nil then
                            Player.AddItem(ItemInfo.Item, 1)
                            if Framework == "QBCore" then
                                TriggerClientEvent('inventory:client:ItemBox', src, FWork.Shared.Items[ItemInfo.Item], "add", 1)
                            end
                            TriggerClientEvent("Pug:client:ShowBusinessNotify", src, "Now restart your inventory.", "success")
                        end
                    else
                        local Player = Config.FrameworkFunctions.GetPlayer(src)
                        if Player ~= nil then
                            Player.AddItem(ItemInfo.Item, 1)
                            if Framework == "QBCore" then
                                TriggerClientEvent('inventory:client:ItemBox', src, FWork.Shared.Items[ItemInfo.Item], "add", 1)
                            end
                        end
                        TriggerClientEvent("Pug:client:ShowBusinessNotify", src, "Now restart your inventory.", "success")
                    end
                else
                    TriggerClientEvent("Pug:client:ShowBusinessNotify", src, "[ERROR] ".. DownloadDirectory.. " Directory incorrect. Please adjust the Config.inventoryImagesDirectoryPath in your config.", "error")
                    print("[^1ERROR^7] ^3".. DownloadDirectory.. " ^7Directory incorrect. Please adjust the ^4Config.inventoryImagesDirectoryPath ^7in your config.")
                end
            else
                TriggerClientEvent("Pug:client:ShowBusinessNotify", src, "[ERROR] Invalid image link or your firewall protection on your server is blocking the link from being reached to the netowrk.", "error")
                print("[^1ERROR^7] ^1Invalid image link or your firewall protection on your server is blocking the link from being reached to the netowrk.")
            end
        end, "GET", "", {})
    end
end)

CreateThread(function()
    CreateDataBaseIfDoesNotExist()
    if Framework == "QBCore" then
        local result = MySQL.query.await('SELECT * FROM pug_businesses', {})
        if result[1] ~= nil then
            for _, v in pairs(result) do
                local DecodedFeatureData = json.decode(v["createditems"])
                for _, j in pairs(DecodedFeatureData) do
                    local ImageName = tostring("pug-"..j.Item..".png")
                    if Config.DontRequireURLImages then
                        ImageName = tostring(j.Item..".png")
                    end
                    local Success = exports[Config.CoreName]:AddItem(j.Item, {
                        name = j.Item,
                        label = j.Label,
                        weight = math.ceil(j.Weight * 1000),
                        type = 'item',
                        image = ImageName,
                        unique = j.Unique,
                        useable = true,
                        shouldClose = true,
                        combinable = false,
                        description = j.Description
                    })
                    if j.Type == "neither" then
                    else
                        FWork.Functions.CreateUseableItem(j.Item, function(source, item)
                            local src = source
                            TriggerClientEvent("Pug:client:ConsumeItem", src, j)
                        end)
                    end
                end
            end
        end
    end
end)
RegisterNetEvent("Pug:server:RemoveCustomBusinessitem", function(Data)
    local result = MySQL.query.await('SELECT * FROM pug_businesses', {})
    if result[1] ~= nil then
        local Upgrades = {}
        for k, v in pairs(result) do
            local ThisJob = result[k]["job"]
            if ThisJob == Data.Job then
                local DecodedFeatureData = json.decode(v["createditems"])
                for _, j in pairs(DecodedFeatureData) do
                    if j.Item == Data.Item then
                        local DownloadDirectory = Config.inventoryImagesDirectoryPath
                        local filePath = DownloadDirectory .. "pug-"..Data.Item..".png"
                        os.remove(filePath)

                        for _, v in pairs(FWork.Functions.GetPlayers()) do
                            local Player = FWork.Functions.GetPlayer(v)
                            if Player ~= nil then
                                local ItemAmount
                                if Config.InventoryType == "ox_inventory" then
                                    local ox_inventory = exports.ox_inventory
                                    ItemAmount = ox_inventory:GetItem(v, Data.Item, false, true)
                                elseif Config.InventoryType == "codem-inventory" then
                                    --local ox_inventory = exports.ox_inventory
                                    --ItemAmount = ox_inventory:GetItem(v, Data.Item, false, true)
                                    ItemAmount = exports['codem-inventory']:GetItemsTotalAmount(v, Data.Item)
                                else
                                    local item1 = GetItemByName(v, Data.Item)
                                    if item1 ~= nil then 
                                        ItemAmount = item1.amount
                                    end
                                end
                                if ItemAmount then
                                    Player.Functions.RemoveItem(Data.Item, ItemAmount)
                                end
                            end
                        end
                        Wait(1000)
                        exports[Config.CoreName]:RemoveItem(Data.Item)
                    else
                        Upgrades[#Upgrades+1] = j
                    end
                end
            end
        end
        MySQL.update('UPDATE pug_businesses SET createditems = ? WHERE job = ?', { json.encode( Upgrades ), Data.Job })
    end
end)
------------------------------

---------- [Callbacks] ----------
Config.FrameworkFunctions.CreateCallback('Pug:serverCB:GetBusinessData', function(source, cb)
	local result = MySQL.query.await('SELECT * FROM pug_businesses', {})
	if result[1] ~= nil then
		cb(result)
	else
		cb(false)
	end
end)
Config.FrameworkFunctions.CreateCallback('Pug:serverCB:GetNearbyCusomers', function(source, cb, PlyCoords)
    local src = source
    local ClosestPlayerData = {}
    for k, v in pairs(Config.FrameworkFunctions.GetPlayers()) do
        local Distance = #(GetEntityCoords(GetPlayerPed(v)) - PlyCoords)
        if Distance < 15.0 then
            local Player = Config.FrameworkFunctions.GetPlayer(v)
            if Player then
                if Config.Input == "ox_lib" then
                    ClosestPlayerData[#ClosestPlayerData+1] = { value = tonumber(v), label = Config.FrameworkFunctions.GetPlayer(v).PlayerData.charinfo.firstname.." | ID: ("..v..")"  }
                else
                    ClosestPlayerData[#ClosestPlayerData+1] = { value = tonumber(v), text = Config.FrameworkFunctions.GetPlayer(v).PlayerData.charinfo.firstname.." | ID: ("..v..")"  }
                end
            end
        end
    end
	cb(ClosestPlayerData) 
end)
Config.FrameworkFunctions.CreateCallback('Pug:server:GetUpdatedCoreDataBusinessCreator', function(source, cb)
	cb(FWork)
end)
------------------------------

---------- [Commands] ----------
if Framework == "QBCore" then
	FWork.Commands.Add(Config.BusinessMenuCommand, "Create business menu", {}, false, function(source, args)
		local src = source
		local result = MySQL.query.await('SELECT * FROM pug_businesses', {})
		if result[1] ~= nil then
			TriggerClientEvent("Pug:client:OpenBusinessCreatorUI",src, result)
		else
			TriggerClientEvent("Pug:client:OpenBusinessCreatorUI",src, false)
		end
	end,"admin")
    FWork.Commands.Add(Config.ViewAllCreatedItemsCommand, "View or remove and created item", {}, false, function(source, args)
		local src = source
		local result = MySQL.query.await('SELECT * FROM pug_businesses', {})
		if result[1] ~= nil then
			TriggerClientEvent("Pug:client:ViewCreatedItemsMenu",src, result)
		end
	end,"admin")
else
	FWork.RegisterCommand(Config.BusinessMenuCommand, 'admin', function(xPlayer, args)
		local src = xPlayer.source
		local result = MySQL.query.await('SELECT * FROM pug_businesses', {})
		if result[1] ~= nil then
			TriggerClientEvent("Pug:client:OpenBusinessCreatorUI",src, result)
		else
			TriggerClientEvent("Pug:client:OpenBusinessCreatorUI",src, false)
		end
	end, true, {help = 'Create business menu', validate = true, arguments = {} })
    FWork.RegisterCommand(Config.ViewAllCreatedItemsCommand, 'admin', function(xPlayer, args)
		local src = xPlayer.source
		local result = MySQL.query.await('SELECT * FROM pug_businesses', {})
		if result[1] ~= nil then
			TriggerClientEvent("Pug:client:ViewCreatedItemsMenu",src, result)
		end
	end, true, {help = 'View or remove and created item', validate = true, arguments = {} })
end
------------------------------

--// FRAMEWORK STUFF //--
if Framework == "ESX" then
    Config.FrameworkFunctions.CreateCallback('Pug:serverESX:GetItemESXBusinessCreator', function(source, cb, item, amount)
        local retval = false
        local Player = FWork.GetPlayerFromId(source)
        local PlayerItem = Player.getInventoryItem(item)
        local Cost = amount or 1
        if PlayerItem then
            if PlayerItem.count >= Cost then
                retval = true
            end
        end
        cb(retval)
    end)
elseif Framework == "QBCore" then
    local function GetFirstSlotByItem(items, itemName)
        if not items then return nil end
        for slot, item in pairs(items) do
            if item.name:lower() == itemName:lower() then
                return tonumber(slot)
            end
        end
        return nil
    end
    function GetItemByName(source, item)
        local Player = Config.FrameworkFunctions.GetPlayer(source)
        item = tostring(item):lower()
        local slot = GetFirstSlotByItem(Player.PlayerData.items, item)
        return Player.PlayerData.items[slot]
    end
    Config.FrameworkFunctions.CreateCallback('Pug:serverESX:GetItemQBCoreBusinessCreator', function(source, cb, items, amount)
        local src = source
        if Config.InventoryType == "ox_inventory" then
            local ox_inventory = exports.ox_inventory
            if ox_inventory:GetItem(src, items, false, true) >= amount then
                cb(true)
            else
                cb(false)
            end
        elseif Config.InventoryType == "codem-inventory" then
            if exports['codem-inventory']:GetItemsTotalAmount(src,items) >= amount then
                cb(true)
            else
                cb(false)
            end
        else
            local retval = false
            local isTable = type(items) == 'table'
            local isArray = isTable and table.type(items) == 'array' or false
            local totalItems = #items
            local count = 0
            local kvIndex = 2
            if amount == 'hidden' then
                amount = 1
            end
            if isTable and not isArray then
                totalItems = 0
                for _ in pairs(items) do totalItems += 1 end
                kvIndex = 1
            end
            if isTable then
                for k, v in pairs(items) do
                    local itemKV = {k, v}
                    local item = GetItemByName(src, itemKV[kvIndex])
                    if item and ((amount and item.amount >= amount) or (not isArray and item.amount >= v) or (not amount and isArray)) then
                        count += 1
                    end
                end
                if count == totalItems then
                    retval = true
                end
            else 
                local item = GetItemByName(src, items)
                if item and (not amount or (item and amount and item.amount >= amount)) then
                    retval = true
                end
            end
            cb(retval)
        end
    end)
end

RegisterServerEvent('Pug:Server:BanBusinessPlayer', function(Message)
    local src = source
    -- MySQL.Async.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
    --     GetPlayerName(src),
    --     GetIdentifiers(src, 'license'),
    --     GetIdentifiers(src, 'discord'),
    --     GetIdentifiers(src, 'ip'),
    --     Message,
    --     2145913200,
    --     'Business'
    -- })
    DropPlayer(src, Message)
end)

local function tableExists(tableName)
    local result = MySQL.query.await('SHOW TABLES LIKE @tableName', {['@tableName'] = tableName})
    return result[1] ~= nil
end

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        CreateThread(function()
            CreateDataBaseIfDoesNotExist()
            local result = MySQL.query.await('SELECT * FROM pug_businesses', {})
            if result[1] ~= nil then
                for k, v in pairs(result) do
                    local ThisJob = result[k]["job"]
                    for u, i in pairs(json.decode(result[k]["trashcans"])) do
                        local TargetName = ThisJob..u.."trashcans"
                        local stashExists = false
                        local inventoriesExists = tableExists('inventories')
                        
                        if Config.InventoryType == "ox_inventory" and Framework == "ESX" or Config.InventoryType == "ox_inventory" and GetResourceState("qbx_core") == 'started' then
                            local stashCheck = MySQL.query.await('SELECT * FROM ox_inventory WHERE name=@name', {['@name'] = TargetName})
                            if stashCheck[1] ~= nil then
                                stashExists = true
                            end
                        elseif Config.InventoryType == "codem-inventory" then
                            local stashCheck = MySQL.query.await('SELECT * FROM codem_new_stash WHERE stashname=@stashname', {['@stashname'] = TargetName})
                            if stashCheck[1] ~= nil then
                                stashExists = true
                            end
                        elseif Config.InventoryType == "qs-inventory" then
                            local stashCheck = MySQL.query.await('SELECT * FROM inventory_stash WHERE stash=@stash', {['@stash'] = TargetName})
                            if stashCheck[1] ~= nil then
                                stashExists = true
                            end
                        else
                            if inventoriesExists then
                                local stashCheck = MySQL.query.await('SELECT * FROM inventories WHERE identifier=@identifier', {['@identifier'] = TargetName})
                                if stashCheck[1] ~= nil then
                                    stashExists = true
                                end
                            else
                                local stashCheck = MySQL.query.await('SELECT * FROM stashitems WHERE stash=@stash', {['@stash'] = TargetName})
                                if stashCheck[1] ~= nil then
                                    stashExists = true
                                end
                            end
                        end
                        
                        if stashExists then
                            if Config.InventoryType == "ox_inventory" and Framework == "ESX" or Config.InventoryType == "ox_inventory" and GetResourceState("qbx_core") == 'started' then
                                MySQL.query('DELETE FROM ox_inventory WHERE name=@name', {['@name'] = TargetName})
                            elseif Config.InventoryType == "codem-inventory" then
                                MySQL.query('DELETE FROM codem_new_stash WHERE stashname=@stashname', {['@stashname'] = TargetName})
                            elseif Config.InventoryType == "qs-inventory" then
                                MySQL.query('DELETE FROM inventory_stash WHERE stash=@stash', {['@stash'] = TargetName})
                            else
                                if inventoriesExists then
                                    MySQL.query('DELETE FROM inventories WHERE identifier=@identifier', {['@identifier'] = TargetName})
                                else
                                    MySQL.query('DELETE FROM stashitems WHERE stash=@stash', {['@stash'] = TargetName})
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)

RegisterNetEvent('Pug:Server:SetUpdateMetaDataBusiness', function(meta, data)
    local src = source
    local Player = FWork.Functions.GetPlayer(src)
    if not Player then return end
    if meta == 'hunger' or meta == 'thirst' then
        if data > 100 then
            data = 100
        end
    end
    Player.Functions.SetMetaData(meta, data)
    TriggerClientEvent('hud:client:UpdateNeeds', src, Player.PlayerData.metadata['hunger'], Player.PlayerData.metadata['thirst'])
end)
------------------------------

---------- [OX_INVENTORY SHOP SUPPORT] ----------
local ShopsCreated = {}
RegisterNetEvent("Pug:server:BusinessOxShopOpen", function(Shop)
    if Config.InventoryType == "codem-inventory" then
        TriggerEvent("codem-inventory:openshop", Shop.label)
    elseif Config.InventoryType == "ox_inventory" then
        -- if not ShopsCreated[Shop.label] then
            ShopsCreated[Shop.label] = true
            exports.ox_inventory:RegisterShop(Shop.label,{ 
                name = Shop.label,
                inventory = Shop.items
            })
        -- end
    end
end)
------------------------------

---------- [OX_INVENTORY STASH SUPPORT] ----------
local StashCreated = {}
RegisterNetEvent("Pug:server:BusinessOxStashOpen", function(StashName, Slots, Space)
    if not StashCreated[StashName] then
        StashCreated[StashName] = true
        exports.ox_inventory:RegisterStash(
            StashName, 
            StashName, 
            Slots, 
            Space
        )
    end
end)
------------------------------

---------- [OX_INVENTORY TRASH CAN SUPPORT] ----------
RegisterNetEvent("Pug:server:BusinessOxTrashCanOpen", function(StashName, Slots, Space)
    local src = source
    local mystash = exports.ox_inventory:CreateTemporaryStash({
        label = StashName,
        slots = tonumber(Slots),
        maxWeight = tonumber(Space),
    })
    TriggerClientEvent('ox_inventory:openInventory', src, 'stash', mystash)
end)
------------------------------

-- QBCORE 2024 UPDATE INVENTORY COMPATIBILITY
RegisterNetEvent('Pug:Server:OpenStash', function(TargetName, MaxWeight, Slots)
    local src = source
    exports[Config.InventoryType]:OpenInventory(src, TargetName, {
        maxweight = MaxWeight,
        slots = Slots,
    })
end)
RegisterNetEvent('Pug:Server:OpenShop', function(TargetName, FinalItemsShopOpening)
    local src = source
    local playerPed = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(playerPed)
    exports[Config.InventoryType]:CreateShop({
        name = TargetName,
        label = TargetName,
        slots = #FinalItemsShopOpening,
        coords = playerCoords,
        items = FinalItemsShopOpening.items,
    })
    exports[Config.InventoryType]:OpenShop(src, TargetName)
end)

-- AUTO SQL
function CreateDataBaseIfDoesNotExist()
    while GetResourceState("es_extended") ~= 'started' and GetResourceState("qb-core") ~= 'started' do Wait(1000) end
    local businessTable = 'pug_businesses'

    local success, result = pcall(MySQL.scalar.await, ('SELECT 1 FROM `%s` LIMIT 1'):format(businessTable))
    
    if not success then
        MySQL.query([[
            CREATE TABLE IF NOT EXISTS `pug_businesses` (
                `id` int(11) NOT NULL AUTO_INCREMENT,
                `job` varchar(50) DEFAULT NULL,
                `registers` text DEFAULT NULL,
                `cookstations` text DEFAULT NULL,
                `trays` text DEFAULT NULL,
                `storage` text DEFAULT NULL,
                `supplies` text DEFAULT NULL,
                `seats` text DEFAULT NULL,
                `trashcans` text DEFAULT NULL,
                `blip` text DEFAULT NULL,
                `duty` text DEFAULT NULL,
                `bossmenu` text DEFAULT NULL,
                `locker` text DEFAULT NULL,
                `animations` text DEFAULT NULL,
                `props` text DEFAULT NULL,
                `peds` text DEFAULT NULL,
                `zone` text DEFAULT NULL,
                `whiteboard` text DEFAULT NULL,
                `garage` text DEFAULT NULL,
                `items` text DEFAULT NULL,
                `createditems` text DEFAULT NULL,
                `creator` text DEFAULT NULL,
                `clothing` text DEFAULT '[]',
                `stocking` text DEFAULT '[]',
                `elevator` text DEFAULT '[]',
                `application` text DEFAULT '[]',
                `menuimage` text DEFAULT '[]',
                PRIMARY KEY (`id`)
            ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;
        ]])
    else
        
        result = MySQL.query.await(('SHOW COLUMNS FROM `%s`'):format(businessTable))
        
        if result then
            local columns = {
                clothing = false,
                stocking = false,
                elevator = false,
                application = false,
                menuimage = false
            }
            
            
            for i = 1, #result do
                local column = result[i]
                if columns[column.Field] ~= nil then
                    columns[column.Field] = true
                end
            end
            
           
            for column, exists in pairs(columns) do
                if not exists then
                    MySQL.query(('ALTER TABLE `%s` ADD COLUMN `%s` TEXT DEFAULT \'[]\''):format(businessTable, column))
                end
            end
        end
    end
end