-- Variables
local Casings = {}
local BloodDrops = {}
local FingerDrops = {}
local Objects = {}
local Spikes = {}
local TenSix = {}
local QBCore = exports['qb-core']:GetCoreObject()

function getpolicestation()
    return Config.policestation,0.032
end
exports("getpolicestation",getpolicestation)

-- Functions
local function UpdateBlips()
    local dutyPlayers = {}
    local players = QBCore.Functions.GetQBPlayers()
    for _, v in pairs(players) do
        if ((v.PlayerData.job.name == "police" or v.PlayerData.job.name == "ambulance" or v.PlayerData.job.name == "justice") and v.PlayerData.job.onduty and v.Functions.GetItemByName("signalradar") ~= nil) then
            local ped = GetPlayerPed(v.PlayerData.source)
            local coords = GetEntityCoords(ped)
            local heading = GetEntityHeading(ped)
            local vehiculoPed = GetVehiclePedIsIn(ped, false)
            local vehicleType = GetVehicleType(vehiculoPed)
            local blip = 1
            local label = "("..v.PlayerData.metadata["callsign"]..") "..v.PlayerData.charinfo.firstname.." "..v.PlayerData.charinfo.lastname
            if vehiculoPed ~= 0 and vehicleType == "bike" then
                blip = 348
            elseif vehiculoPed ~= 0 and vehicleType == "heli" then
                blip = 43
            elseif vehiculoPed ~= 0 and vehicleType == "automobile" then
                blip = 225
            end
            dutyPlayers[#dutyPlayers+1] = {
                source = v.PlayerData.source,
                label = label,
                job = v.PlayerData.job.dep,
                grade = v.PlayerData.job.grade.level,
                blip = blip,
                location = {
                    x = coords.x,
                    y = coords.y,
                    z = coords.z,
                    w = heading
                }
            }
        end
    end
    TriggerClientEvent("police:client:UpdateBlips", -1, dutyPlayers)
end

local function CreateBloodId()
    if BloodDrops then
        local bloodId = math.random(10000, 99999)
        while BloodDrops[bloodId] do
            bloodId = math.random(10000, 99999)
        end
        return bloodId
    else
        local bloodId = math.random(10000, 99999)
        return bloodId
    end
end

local function CreateFingerId()
    if FingerDrops then
        local fingerId = math.random(10000, 99999)
        while FingerDrops[fingerId] do
            fingerId = math.random(10000, 99999)
        end
        return fingerId
    else
        local fingerId = math.random(10000, 99999)
        return fingerId
    end
end

local function CreateCasingId()
    if Casings then
        local caseId = math.random(10000, 99999)
        while Casings[caseId] do
            caseId = math.random(10000, 99999)
        end
        return caseId
    else
        local caseId = math.random(10000, 99999)
        return caseId
    end
end

local function CreateObjectId()
    if Objects then
        local objectId = math.random(10000, 99999)
        while Objects[objectId] do
            objectId = math.random(10000, 99999)
        end
        return objectId
    else
        local objectId = math.random(10000, 99999)
        return objectId
    end
end

local function CreateSpikeId()
    if Spikes then
        local spikeId = math.random(10000, 99999)
        while Spikes[spikeId] do
            spikeId = math.random(10000, 99999)
        end
        return spikeId
    else
        local spikeId = math.random(10000, 99999)
        return spikeId
    end
end

local function GetCurrentCops()
    local amount = 0
    local amounthighrank=0
    local players = QBCore.Functions.GetQBPlayers()
    for _, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty and not TenSix[v.PlayerData.source] then
            if v.PlayerData.job.grade.level > 0 then
                amount = amount + 1
            end
            if v.PlayerData.job.grade.level >= 2 then
                amounthighrank = amounthighrank + 1
            end
        end
    end
    return amount,amounthighrank
end

local function DnaHash(s)
    local h = string.gsub(s, ".", function(c)
        return string.format("%02x", string.byte(c))
    end)
    return h
end
QBCore.Commands.Add("getcarslot", 'Get Citizen Carslot', {{name='stateid', help='Citizen ID'},}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if ((Player.PlayerData.job.name == "goverment" and Player.PlayerData.job.grade.level>=4)) then
        local xTarget = QBCore.Functions.GetPlayerByCitizenId(args[1])
        if xTarget then
            TriggerClientEvent('QBCore:Notify',src,xTarget.PlayerData.charinfo.firstname.." "..xTarget.PlayerData.charinfo.lastname.." Has a ( ".. xTarget.PlayerData.metadata['carslot'].." ) Slot Car", 'success')
        end
    end
end)
QBCore.Commands.Add("getcitizencar", 'Get Citizen car for slot', {{name='stateid', help='Citizen ID'},}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if ((Player.PlayerData.job.name == "goverment" and Player.PlayerData.job.grade.level>=4)) then
            local count=exports['qb-tax']:getcarcounttax(args[1])
            TriggerClientEvent('QBCore:Notify',src,"Citizen Has a ( ".. count.." ) Car Owner", 'success')
    end
end)

QBCore.Commands.Add("setcarslot", 'Get Citizen Carslot', {{name='stateid', help='Citizen ID'},{name='slot', help='Slot'},}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if ((Player.PlayerData.job.name == "goverment" and Player.PlayerData.job.grade.level>=4)) then
        local xTarget = QBCore.Functions.GetPlayerByCitizenId(args[1])
        if xTarget then
            local oldslot=xTarget.PlayerData.metadata['carslot']
            xTarget.Functions.SetMetaData("carslot", tonumber(args[2]))
            TriggerEvent('qb-log:server:CreateLog', 'carslot', 'Change Slot', 'red', xTarget.PlayerData.charinfo.firstname..' '..xTarget.PlayerData.charinfo.lastname .. ' (' .. xTarget.PlayerData.citizenid .. ') \n Old Slot:'..oldslot ..' \n New Slot: '..args[2]..' \n\n Change by: ' ..Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.citizenid .. ')')
            TriggerClientEvent('QBCore:Notify',src,"Car Slot Changed for "..xTarget.PlayerData.charinfo.firstname..' '..xTarget.PlayerData.charinfo.lastname, 'success')
            TriggerClientEvent('QBCore:Notify',xTarget.PlayerData.source,"Your Car Slot Change to ".. args[2], 'success')
        end
    end
end)

QBCore.Commands.Add("fine", 'Fine For Player', {{name='stateid', help='Citizen ID'},{name='amount', help='Amount'}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "justice") and Player.PlayerData.job.onduty then
        local  fine =tonumber(args[2])
        local biller = QBCore.Functions.GetPlayer(source)
        if not biller then return end
        local xTarget = QBCore.Functions.GetPlayerByCitizenId(args[1])
        if xTarget then
            local stMoney = math.ceil(xTarget.PlayerData.money.bank - fine)
            xTarget.Functions.SetMoney("bank", stMoney, "Fine")
            if biller.PlayerData.job.name == "police" then
                TriggerEvent('qb-log:server:CreateLog', 'pdfine', 'Fine', 'red', "Officer: ".. biller.PlayerData.charinfo.firstname..' '..biller.PlayerData.charinfo.lastname .. ' (' .. biller.PlayerData.metadata.callsign .. ') \n fine '..fine..'$ \n for '..xTarget.PlayerData.charinfo.firstname..' '..xTarget.PlayerData.charinfo.lastname .. ' (' .. xTarget.PlayerData.citizenid .. ')')
            end
            TriggerEvent('qb-log:server:CreateLog', 'fine', 'Fine', 'red', biller.PlayerData.charinfo.firstname..' '..biller.PlayerData.charinfo.lastname .. ' (' .. biller.PlayerData.citizenid .. ') \n fine '..fine..'$ \n for '..xTarget.PlayerData.charinfo.firstname..' '..xTarget.PlayerData.charinfo.lastname .. ' (' .. xTarget.PlayerData.citizenid .. ')')
            TriggerClientEvent('QBCore:Notify', src, '$'..fine..' fine was imposed on '..xTarget.PlayerData.charinfo.firstname..' '..xTarget.PlayerData.charinfo.lastname, 'success')
            TriggerClientEvent('QBCore:Notify', xTarget.PlayerData.source,'You have been fined $'..fine, 'error')
        else
            exports["snipe-banking"]:AddMoneyToAccount(biller.PlayerData.job.name,fine,"Fine "..args[1]..' by '..biller.PlayerData.charinfo.firstname.." "..biller.PlayerData.charinfo.lastname)
            if biller.PlayerData.job.name == "police" then
                TriggerEvent('qb-log:server:CreateLog', 'pdfine', 'Police Fine', 'red', "Officer: ".. biller.PlayerData.charinfo.firstname..' '..biller.PlayerData.charinfo.lastname .. ' (' .. biller.PlayerData.metadata.callsign .. ') \n fine '..fine..'$ for '..args[1])
            end
            TriggerEvent('qb-log:server:CreateLog', 'fine', 'Fine', 'red', biller.PlayerData.charinfo.firstname..' '..biller.PlayerData.charinfo.lastname .. ' (' .. biller.PlayerData.citizenid .. ') \n fine '..fine..'$ for '..args[1])
            TriggerClientEvent('QBCore:Notify', src, '$'..fine..' fine was imposed on '..args[1], 'error')
            MySQL.update.await("UPDATE players SET money = JSON_SET(`money`, '$.bank', JSON_UNQUOTE(JSON_EXTRACT(`money`, '$.bank')) - ?) WHERE citizenid = ?",{ fine, args[1] })
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Fire Arms Only Access...", 'error')
    end
end)

QBCore.Commands.Add("registerwep", 'Register Weapons', {{name='citizenid', help='Citizenid'},{name='serialno', help='Serial.No'}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if (Player.PlayerData.job.name == "police" or  Player.PlayerData.job.name == "justice") and (QBCore.Functions.HasDivision(src, 'fa') or QBCore.Functions.HasDivision(src, 'hc') or Player.PlayerData.job.isboss) and Player.PlayerData.job.onduty then
        local data = MySQL.query.await("SELECT * FROM drx_mdt_weapons where serial=?", {args[2]})
        if data and data[1] then
            MySQL.Async.insert('update drx_mdt_weapons set owner=? where serial=?', {args[1],args[2]})
            TriggerClientEvent('QBCore:Notify', src, "Weapon Register Successfull", 'success')
        else
            TriggerClientEvent('QBCore:Notify', src, "No Match Found...!", 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Fire Arms Only Access...", 'error')
    end
end)

QBCore.Commands.Add("callsign", 'Set Call Sign', {{name='callsign', help='callsign'}}, true, function(source, args)
    local src = source
    if args and args[1] then
        local Player = QBCore.Functions.GetPlayer(src)
        if Player.PlayerData.job.onduty then
            if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "ambualnce" or Player.PlayerData.job.name == "justice" or Player.PlayerData.job.name == "goverment" then
                Player.Functions.SetMetaData("callsign", args[1])
                TriggerClientEvent('QBCore:Notify', src, "Call Sign Set Successfull", 'success')
            end
        end
    end
end)

QBCore.Commands.Add("dispatch", 'Send Dispatch Chat', {{name='message', help='Message'}}, true, function(source, args)
    local src = source
    local msg = table.concat(args, ' ')
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.onduty then
        if Player.PlayerData.job.name == "police" then
            TriggerEvent('qb-log:server:CreateLog', 'policechat', 'Dispatch', 'blue', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.metadata["callsign"] .. ') Send: '..msg)
            for _, v in pairs(QBCore.Functions.GetPlayers()) do
                local tPlayer = QBCore.Functions.GetPlayer(v)
                if tPlayer and tPlayer.PlayerData.job.name == "police" and tPlayer.PlayerData.job.onduty then
                    TriggerClientEvent('chatMessage', v, 'Dispatch | '..Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname..'('..Player.PlayerData.metadata["callsign"]..')', 'police', msg, 'DISPATCH')
                    TriggerClientEvent('qb-policejob:client:dispatchEffect', v)
                end
            end
        elseif Player.PlayerData.job.name == "justice" then
            TriggerEvent('qb-log:server:CreateLog', 'justicechat', 'Dispatch', 'blue', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.metadata["callsign"] .. ') Send: '..msg)
            for _, v in pairs(QBCore.Functions.GetPlayers()) do
                local tPlayer = QBCore.Functions.GetPlayer(v)
                if tPlayer and tPlayer.PlayerData.job.name == "justice" and tPlayer.PlayerData.job.onduty then
                    TriggerClientEvent('chatMessage', v, 'Dispatch | '..Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname..'('..Player.PlayerData.metadata["callsign"]..')', 'police', msg, 'DISPATCH')
                    TriggerClientEvent('qb-policejob:client:dispatchEffect', v)
                end
            end
        elseif Player.PlayerData.job.name == "ambulance" then
            TriggerEvent('qb-log:server:CreateLog', 'mdchat', 'Dispatch', 'blue', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.metadata["callsign"] .. ') Send: '..msg)
            for _, v in pairs(QBCore.Functions.GetPlayers()) do
                local tPlayer = QBCore.Functions.GetPlayer(v)
                if tPlayer and tPlayer.PlayerData.job.name == "ambulance" and tPlayer.PlayerData.job.onduty then
                    TriggerClientEvent('chatMessage', v, 'Dispatch | '..Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname..'('..Player.PlayerData.metadata["callsign"]..')', 'police', msg, 'DISPATCH')
                    TriggerClientEvent('qb-policejob:client:dispatchEffect', v)
                end
            end
        end
    end
end)

QBCore.Commands.Add("dep", 'Send Dept Chat', {{name='message', help='Message'}}, true, function(source, args)
    local src = source
    local msg = table.concat(args, ' ')
    local Player = QBCore.Functions.GetPlayer(src)
    local jobname = {police='PD',ambulance='MD',justice='DOJ'}
    if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "ambulance" or Player.PlayerData.job.name == "justice") and Player.PlayerData.job.onduty then
        local coords = GetEntityCoords(GetPlayerPed(src))
        TriggerEvent('qb-log:server:CreateLog', 'cdispatch', 'Central Dispatch', 'blue', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.metadata["callsign"] .. ') Send: '..msg)
        for _, v in pairs(QBCore.Functions.GetPlayers()) do
            local tPlayer = QBCore.Functions.GetPlayer(v)
            if tPlayer and (tPlayer.PlayerData.job.name == "police" or tPlayer.PlayerData.job.name == "ambulance" or tPlayer.PlayerData.job.name == "justice" ) and tPlayer.PlayerData.job.onduty then
                TriggerClientEvent('chatMessage', v, jobname[Player.PlayerData.job.name]..' Dispatch | '..Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname..'('..Player.PlayerData.metadata["callsign"]..')', 'dispatch', msg, 'DISPATCH')
                TriggerClientEvent('qb-policejob:client:cdispatch', v, coords)
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.on_duty_police_only"), 'error')
    end
end)

QBCore.Commands.Add("10-6", "Change State of 10-6", {{name="state", help="true/false"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == 'police' then
        local state = string.lower(args[1])
        if state == 'true' then
            TenSix[src] = true
            TriggerClientEvent("QBCore:Notify", source, 'You are now 10-6')
        elseif state == 'false' then
            TenSix[src] = nil
            TriggerClientEvent("QBCore:Notify", source, 'You are now 10-8')
        else
            TriggerClientEvent("QBCore:Notify", source, 'Enter true/false', 'error')
        end
    else
        TriggerClientEvent("QBCore:Notify", source, 'No Access', 'error')
    end
end)

QBCore.Commands.Add("jail", Lang:t("commands.jail_player"), {{name = "id", help = Lang:t('info.player_id')}, {name = "time", help = Lang:t('info.jail_time')}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if (Player.PlayerData.job.dep == "marshal") and Player.PlayerData.job.onduty then
        local playerId = tonumber(args[1])
        local time = tonumber(args[2])
        if time > 0 then
            local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
            if OtherPlayer then
                local newTime = time
                local playerPed = GetPlayerPed(src)
                local targetPed = GetPlayerPed(playerId)
                local playerCoords = GetEntityCoords(playerPed)
                local targetCoords = GetEntityCoords(targetPed)
                if #(playerCoords - targetCoords) > 10 then return end
                exports['qb-jail']:jailPlayer(playerId, true, newTime)
                TriggerEvent("newspaper:jail",OtherPlayer.PlayerData.charinfo.firstname,OtherPlayer.PlayerData.charinfo.lastname, newTime)
                TriggerClientEvent("police:client:SendToJail", OtherPlayer.PlayerData.source, newTime)
                TriggerClientEvent('QBCore:Notify', src, Lang:t("info.sent_jail_for", {time = time}))
                TriggerEvent('qb-log:server:CreateLog', 'jail', 'Jail', 'red', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.citizenid .. ') \n send: '..OtherPlayer.PlayerData.charinfo.firstname..' '..OtherPlayer.PlayerData.charinfo.lastname .. ' (' .. OtherPlayer.PlayerData.citizenid .. ') \n jail for '..newTime..' month')
            else
                TriggerClientEvent('QBCore:Notify', src, 'Player ID is wrong', 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t('info.jail_time_no'), 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.on_duty_police_only"), 'error')
    end
end)

QBCore.Commands.Add("unjail", Lang:t("commands.unjail_player"), {{name = "id", help = Lang:t('info.player_id')}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "justice") and Player.PlayerData.job.onduty then
        local playerId = tonumber(args[1])
        local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
        if OtherPlayer then
            exports['qb-jail']:unJailPlayer(playerId)
            TriggerEvent('qb-log:server:CreateLog', 'jail', 'Unjail', 'green', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.citizenid .. ') unjail '..OtherPlayer.PlayerData.charinfo.firstname..' '..OtherPlayer.PlayerData.charinfo.lastname .. ' (' .. OtherPlayer.PlayerData.citizenid .. ')')
            if Player.PlayerData.job.name == "police" then
                TriggerEvent('qb-log:server:CreateLog', 'pdjail', 'Unjail', 'green', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.metadata.callsign .. ') unjail '..OtherPlayer.PlayerData.charinfo.firstname..' '..OtherPlayer.PlayerData.charinfo.lastname .. ' (' .. OtherPlayer.PlayerData.citizenid .. ')')
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.on_duty_police_only"), 'error')
    end
end)

QBCore.Commands.Add("escort", Lang:t("commands.escort"), {}, false, function(source, _)
    TriggerClientEvent("police:client:EscortPlayer", source)
end)

QBCore.Commands.Add("putin", 'Put Player in Vehicle', {}, false, function(source, _)
    TriggerClientEvent("police:client:PutPlayerInVehicle", source)
end)

QBCore.Commands.Add("putout", 'Put Player Out of Vehicle', {}, false, function(source, _)
    TriggerClientEvent("police:client:SetPlayerOutVehicle", source)
end)

QBCore.Commands.Add("rob", "Rob Player", {}, false, function(source, args)
	TriggerClientEvent("police:client:SearchPlayer", source)
end)

QBCore.Functions.CreateUseableItem('blooder', function(source, item)
    TriggerClientEvent("evidence:client:ClearBlooddropsInArea", source, item.slot)
end)

QBCore.Functions.CreateUseableItem('spike', function(source, item)
    TriggerClientEvent("police:client:startspike", source, item.slot)
end)

-- Items
QBCore.Functions.CreateUseableItem("handcuffs", function(source, item)
    TriggerClientEvent("police:client:CuffPlayer", source, item.slot)
end)

QBCore.Functions.CreateUseableItem("cuff_keys", function(source, item)
    TriggerClientEvent("police:client:UncuffPlayer", source, item.slot)
end)

-- Callbacks
QBCore.Functions.CreateCallback('police:server:isPlayerDead', function(_, cb, playerId)
    local Player = QBCore.Functions.GetPlayer(playerId)
    cb(Player.PlayerData.metadata["isdead"] or Player.PlayerData.metadata["inlaststand"])
end)

QBCore.Functions.CreateCallback('police:IsSilencedWeapon', function(source, cb, weapon)
    local Player = QBCore.Functions.GetPlayer(source)
    local itemInfo = Player.Functions.GetItemByName(QBCore.Shared.Weapons[weapon]["name"])
    local retval = false
    if itemInfo then
        if itemInfo.info and itemInfo.info.attachments then
            for k, _ in pairs(itemInfo.info.attachments) do
                if itemInfo.info.attachments[k].component == "COMPONENT_AT_AR_SUPP_02" or
                    itemInfo.info.attachments[k].component == "COMPONENT_AT_AR_SUPP" or
                    itemInfo.info.attachments[k].component == "COMPONENT_AT_PI_SUPP_02" or
                    itemInfo.info.attachments[k].component == "COMPONENT_AT_PI_SUPP" then
                    retval = true
                end
            end
        end
    end
    cb(retval)
end)

QBCore.Functions.CreateCallback('police:GetDutyPlayers', function(_, cb)
    local dutyPlayers = {}
    local players = QBCore.Functions.GetQBPlayers()
    for _, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            dutyPlayers[#dutyPlayers+1] = {
                source = v.PlayerData.source,
                label = v.PlayerData.metadata["callsign"],
                job = v.PlayerData.job.name
            }
        end
    end
    cb(dutyPlayers)
end)

QBCore.Functions.CreateCallback('police:GetCops', function(_, cb)
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for _, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    cb(amount)
end)

QBCore.Functions.CreateCallback('police:server:GetObjects', function(_, cb)
    cb(Objects, Spikes)
end)

QBCore.Functions.CreateCallback('qb-police:server:checkvin', function (source, cb, data)
    local src = source
    local veh = NetworkGetEntityFromNetworkId(data)
    local plate = GetVehicleNumberPlateText(veh)
    MySQL.query('SELECT * FROM player_vehicles WHERE plate = ? AND vinscratch = ?', {plate, 1}, function(result)
        if result[1] then
            cb(true)
        else
            cb(false)
        end
    end)
 end)

 QBCore.Commands.Add("checkplate","Check Vehicle Owner", {{name='plate', help='Plate'}}, false, function(source, args)
    if not args or not args[1] then
        TriggerClientEvent('QBCore:Notify', source, "Enter a Plate", 'error')
        return
    end
    chkplate(args[1],source)
end)
local lastradarplate=""
RegisterNetEvent('police:server:checkradarplate', function(plate)
    local src = source
    local  ped = GetPlayerPed(src)
    local vehiPed = GetVehiclePedIsIn(ped, false)
   
    if plate then 
        chkplate(plate,src)
    elseif lastradarplate and vehiPed then
     chkplate(lastradarplate,src)
    end
end)


RegisterNetEvent('police:server:setplateradar', function(plate)
    lastradarplate=plate;
end)
local function GetEntities()
	local Entities = {}
	for _, entity in pairs(GetAllVehicles()) do
        Entities[#Entities+1] = NetworkGetNetworkIdFromEntity(entity)
	end
	return Entities
end

function chkplate(plate,source)
    local Player = QBCore.Functions.GetPlayer(source)
    local veh=nil
    local Vehicles = GetEntities()
    for i=1, #Vehicles do
        local Vehicle = NetworkGetEntityFromNetworkId(Vehicles[i])
        if DoesEntityExist(Vehicle) then
            if GetVehicleNumberPlateText(Vehicle) == string.upper(plate) then
                veh=Vehicle
                break
            end
        end
    end
    local model=""
    if veh then
      model=GetEntityModel(veh)
    end
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        MySQL.query('SELECT plate,charinfo FROM player_vehicles INNER JOIN players ON players.citizenid=player_vehicles.citizenid WHERE player_vehicles.plate = ?', {plate}, function(result)
            local tex=""
            if result and result[1] then
                local char=json.decode(result[1].charinfo)
              tex='<br/>Plate: '..result[1].plate..'<br/>Owner: '..char.firstname..' '..char.lastname
            else
               tex='<br/>Plate: '..plate..'<br/>Owner: No Match Found'
            end
            TriggerClientEvent('police:checkplate', source, model,tex)
        end)
    end
   
end

-- Events

AddEventHandler('playerDropped', function()
    local src = source
    if TenSix[src] then
        TenSix[src] = nil
    end
end)

RegisterNetEvent('police:server:CuffPlayer', function(playerId, slot,typecuff,playerheading)
    local src = source
    if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(playerId))) >= 10 then return end
    local Player = QBCore.Functions.GetPlayer(src)
    local CuffedPlayer = QBCore.Functions.GetPlayer(playerId)
    if CuffedPlayer then
        if Player.PlayerData.items[slot] and Player.PlayerData.items[slot].name == 'handcuffs' then
            if not CuffedPlayer.PlayerData.metadata["ishandcuffed"] then
                TriggerClientEvent('police:client:doCuffAnim', src, true)
                TriggerClientEvent("police:client:GetCuffed", CuffedPlayer.PlayerData.source, Player.PlayerData.source, slot,typecuff,source,playerheading)
            end
        end
    end
end)

RegisterNetEvent('police:server:cuffcancel', function(policeid,playerheading)
    local src = source
  
    TriggerClientEvent('police:client:cuffcancelsuspect', src,playerheading)
    TriggerClientEvent("police:client:cuffcancelpolice",policeid)
end)

RegisterNetEvent('police:server:UncuffPlayer', function(playerId, slot)
    local src = source
    if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(playerId))) >= 10 then return end
    local Player = QBCore.Functions.GetPlayer(src)
    local CuffedPlayer = QBCore.Functions.GetPlayer(playerId)
    if CuffedPlayer then
        if Player.PlayerData.items[slot] and Player.PlayerData.items[slot].name == 'cuff_keys' then
            if CuffedPlayer.PlayerData.metadata["ishandcuffed"] then
                TriggerClientEvent('police:client:doCuffAnim', src, false)
                TriggerClientEvent("police:client:GetUncuffed", CuffedPlayer.PlayerData.source)
                Player.Functions.AddItem('handcuffs', 1, nil, {quality = CuffedPlayer.PlayerData.metadata["cuffquality"]})
                QBCore.Player.DecayItem(src, nil, 2, slot)
                CuffedPlayer.Functions.SetMetaData("ishandcuffed", false)
                CuffedPlayer.Functions.SetMetaData("cuffquality", 0)
            end
        end
    end
end)

RegisterNetEvent('police:server:fixElevator', function(playerId)
    local src = source
    if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(playerId))) >= 10 then return end
    local target = QBCore.Functions.GetPlayer(playerId)
    if target then
        TriggerClientEvent("police:client:fixElevatorForMe", target.PlayerData.source, src)
    end
end)

RegisterNetEvent('police:server:EscortPlayer', function(playerId)
    local src = source
    if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(playerId))) >= 10 then return end
    local Player = QBCore.Functions.GetPlayer(source)
    local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
    if EscortPlayer then
        if (EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] or EscortPlayer.PlayerData.metadata["inlaststand"]) then
            TriggerClientEvent("police:client:GetEscorted", EscortPlayer.PlayerData.source, Player.PlayerData.source)
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t("error.not_cuffed_dead"), 'error')
        end
    end
end)

RegisterNetEvent('police:server:DoEscorteStatus', function(playerId, state)
    local src = source
    if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(playerId))) >= 10 then return end
    TriggerClientEvent("police:client:DoEscorteStatus", playerId, state)
end)



RegisterNetEvent('police:server:RemoveMask', function(playerId)
    local src = source
    if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(playerId))) >= 10 then return end
    local Player = QBCore.Functions.GetPlayer(src)
    local Target = QBCore.Functions.GetPlayer(playerId)
    if Target then
        if (Target.PlayerData.metadata["ishandcuffed"] or Target.PlayerData.metadata["isdead"] or Target.PlayerData.metadata["inlaststand"]) then
            TriggerClientEvent("qb-policejob:client:removemask", playerId)
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t("error.not_cuffed_dead"), 'error')
        end
    end
end)

RegisterNetEvent('police:server:PutPlayerInVehicle', function(playerId)
    local src = source
    if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(playerId))) >= 10 then return end
    local Player = QBCore.Functions.GetPlayer(src)
    local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
    if EscortPlayer then
        TriggerClientEvent("police:client:PutInVehicle", EscortPlayer.PlayerData.source)
    end
end)

RegisterNetEvent('police:server:SetHandcuff', function(playerId, slot)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        Player.Functions.SetMetaData("ishandcuffed", true)
        if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(playerId))) >= 10 then return end
        local Cuffer = QBCore.Functions.GetPlayer(playerId)
        if Cuffer then
            QBCore.Player.DecayItem(playerId, nil, 2, slot)
            Cuffer = QBCore.Functions.GetPlayer(playerId)
            if Cuffer.PlayerData.items[slot] and Cuffer.PlayerData.items[slot].name == 'handcuffs' then
                Player.Functions.SetMetaData("cuffquality", Cuffer.PlayerData.items[slot].info.quality)
            end
            Cuffer.Functions.RemoveItem('handcuffs', 1, slot)
        end
    end
end)

RegisterNetEvent('police:server:SearchPlayer', function(playerId)
    local src = source
    local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
    if SearchedPlayer then
        if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(playerId))) >= 10 then return end
        TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, Lang:t("info.being_searched"))
    end
end)

RegisterNetEvent('police:server:spawnObject', function(type, x, y, z, heading)
    local src = source
    local objectId = CreateObjectId()
    Objects[objectId] = {type = type, x = x, y = y, z = z, heading = heading}
    TriggerClientEvent("police:client:spawnObject", -1, objectId, Objects[objectId])
end)

RegisterNetEvent('police:server:deleteObject', function(objectId)
    Objects[objectId] = nil
    TriggerClientEvent('police:client:removeObject', -1, objectId)
end)

RegisterNetEvent('police:server:spawnSpike', function(spawnCoords, heading)
    local src = source
    local spikeId = CreateSpikeId()
    Spikes[spikeId] = {coords = spawnCoords, heading = heading}
    TriggerClientEvent("police:client:spawnSpikeObject", -1, spikeId, Spikes[spikeId])
end)

RegisterNetEvent('police:server:removeSpike', function(spikeId)
    local src = source
    if Spikes[spikeId] then
        Spikes[spikeId] = nil
        local Player = QBCore.Functions.GetPlayer(src)
        Player.Functions.AddItem('spike', 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["spike"], "add")
        TriggerClientEvent('police:client:removeSpike', -1, spikeId)
    end
end)

RegisterNetEvent('evidence:server:CreateBloodDrop', function(citizenid, bloodtype, coords)
    local bloodId = CreateBloodId()
    BloodDrops[bloodId] = {
        dna = citizenid,
        bloodtype = bloodtype
    }
    TriggerClientEvent("evidence:client:AddBlooddrop", -1, bloodId, citizenid, bloodtype, coords)
end)

RegisterNetEvent('evidence:server:CreateFingerDrop', function(coords)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local fingerId = CreateFingerId()
    FingerDrops[fingerId] = Player.PlayerData.metadata["fingerprint"]
    TriggerClientEvent("evidence:client:AddFingerPrint", -1, fingerId, Player.PlayerData.metadata["fingerprint"], coords)
end)

RegisterNetEvent('evidence:server:ClearBlooddrops', function(blooddropList)
    if blooddropList and next(blooddropList) then
        for _, v in pairs(blooddropList) do
            TriggerClientEvent("evidence:client:RemoveBlooddrop", -1, v)
            BloodDrops[v] = nil
        end
    end
end)

RegisterNetEvent('evidence:server:AddBlooddropToInventory', function(bloodId, bloodInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, bloodInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveBlooddrop", -1, bloodId)
            BloodDrops[bloodId] = nil
        end
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.have_evidence_bag"), "error")
    end
end)

RegisterNetEvent('evidence:server:AddFingerprintToInventory', function(fingerId, fingerInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, fingerInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveFingerprint", -1, fingerId)
            FingerDrops[fingerId] = nil
        end
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.have_evidence_bag"), "error")
    end
end)

RegisterNetEvent('evidence:server:CreateCasing', function(weapon, coords)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local casingId = CreateCasingId()
    local weaponInfo = QBCore.Shared.Weapons[weapon]
    local serieNumber = nil
    if weaponInfo then
        local weaponItem = Player.Functions.GetItemByName(weaponInfo["name"])
        if weaponItem then
            if weaponItem.info and weaponItem.info ~= "" then
                serieNumber = weaponItem.info.serie
            end
        end
    end
    TriggerClientEvent("evidence:client:AddCasing", -1, casingId, weapon, coords, serieNumber)
end)

RegisterNetEvent('evidence:server:ClearCasings', function(casingList)
    if casingList and next(casingList) then
        for _, v in pairs(casingList) do
            TriggerClientEvent("evidence:client:RemoveCasing", -1, v)
            Casings[v] = nil
        end
    end
end)

RegisterNetEvent('evidence:server:AddCasingToInventory', function(casingId, casingInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, casingInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveCasing", -1, casingId)
            Casings[casingId] = nil
        end
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.have_evidence_bag"), "error")
    end
end)

RegisterNetEvent('police:server:showFingerprint', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if Player.PlayerData.job.name == "police" then
        if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(playerId))) >= 10 then return end
        TriggerClientEvent('police:client:showFingerprint', playerId, src)
        TriggerClientEvent('police:client:showFingerprint', src, playerId)
    end
end)

RegisterNetEvent('police:server:showFingerprintId', function(sessionId)
    local src = source
    if sessionId then
        if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(sessionId))) >= 10 then return end
        local Player = QBCore.Functions.GetPlayer(src)
        local fid = Player.PlayerData.metadata["fingerprint"]
        TriggerClientEvent('police:client:showFingerprintId', sessionId, fid)
        TriggerClientEvent('police:client:showFingerprintId', src, fid)
    else
        local Player = QBCore.Functions.GetPlayer(src)
        local fid = Player.PlayerData.metadata["fingerprint"]
        TriggerClientEvent('police:client:showFingerprintId', src, fid)
    end
end)

-- Threads
CreateThread(function()
    while true do
        Wait((1000 * 60) * 1)
        local curCops,curCopshigh = GetCurrentCops()
        TriggerClientEvent("police:SetCopCount", -1, curCops,curCopshigh)
        TriggerEvent('police:SetCopCount', curCops,curCopshigh)
    end
end)

CreateThread(function()
    while true do
        Wait(5000)
        UpdateBlips()
    end
end)

--Exports
function GetBusy()
    return TenSix
end
exports('GetBusy',GetBusy)

CreateThread(function()
    MySQL.query.await("DELETE FROM stashitems WHERE stash LIKE 'trashevidence%'", {})
end)