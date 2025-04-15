QBCore.Commands = {}
QBCore.Commands.List = {}

-- Register & Refresh Commands

function QBCore.Commands.Add(name, help, arguments, argsrequired, callback, permission)
    permission = permission ~= nil and permission:lower() or "user"
    QBCore.Commands.List[name:lower()] = {
		permission = permission,
		help = help,
		arguments = arguments
	}
    RegisterCommand(name, function(source, args)
        if QBCore.Functions.HasPermission(source, permission) then
            if argsrequired and #arguments ~= 0 and args[#arguments] == nil then
                TriggerClientEvent('QBCore:Notify', source, "All arguments must be filled out!", "error")
            else
                callback(source, args)
            end
        else
            TriggerClientEvent('QBCore:Notify', source, "No Access To This Command", "error")
        end
    end)
end

function QBCore.Commands.Refresh(source)
    for command, info in pairs(QBCore.Commands.List) do
		if QBCore.Functions.HasPermission(source, info.permission) then
			TriggerClientEvent('chat:addSuggestion', source, "/"..command, info.help, info.arguments)
        else
            TriggerClientEvent('chat:removeSuggestion', source, '/'..command)
		end
	end
end

-- Kick All

RegisterCommand('kickall', function(source, args)
    if source == 0 or QBCore.Functions.HasPermission(source, 'god') then
        if source > 0 then
            TriggerEvent('qb-log:server:CreateLog', 'kickall', 'Kick All', 'red', GetPlayerName(source) .. ' (' .. source .. ') Used Kickall')
        end
        local reason = args[1] or 'No reason specified'
        for k in pairs(QBCore.Players) do
            DropPlayer(k, reason)
        end
    end
end)

--- Teleport

QBCore.Commands.Add('tp', 'TP To Player or Coords', { { name = 'id/x', help = 'ID of player or X position' }, { name = 'y', help = 'Y position' }, { name = 'z', help = 'Z position' } }, false, function(source, args)
    local src = source
    if args[1] and not args[2] and not args[3] then
        local target = GetPlayerPed(tonumber(args[1]))
        if target ~= 0 then
            TriggerEvent('qb-log:server:CreateLog', 'tp', 'Teleport to Player', 'white', GetPlayerName(source) .. ' (' .. source .. ') Teleported to '..GetPlayerName(tonumber(args[1]))..' ('..args[1]..')', false)
            local coords = GetEntityCoords(target)
            TriggerClientEvent('QBCore:Command:TeleportToPlayer', source, coords)
        else
            TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
        end
    else
        if args[1] and args[2] and args[3] then
            local x = tonumber((args[1]:gsub(",",""))) + .0
            local y = tonumber((args[2]:gsub(",",""))) + .0
            local z = tonumber((args[3]:gsub(",",""))) + .0
            if x ~= 0 and y ~= 0 and z ~= 0 then
                TriggerClientEvent('QBCore:Command:TeleportToCoords', source, x, y, z)
            else
                TriggerClientEvent('QBCore:Notify', source, Lang:t('error.wrong_format'), 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', source, Lang:t('error.missing_args'), 'error')
        end
    end
end, 'admin')

QBCore.Commands.Add('tpm', 'TP To Marker', {}, false, function(source)
    TriggerClientEvent('QBCore:Command:GoToMarker', source)
end, 'admin')

-- Money

QBCore.Commands.Add('setmoney', 'Set Players Money Amount', { { name = 'id', help = 'Player ID' }, { name = 'moneytype', help = 'Type of money (bank,...)' }, { name = 'amount', help = 'Amount of money' } }, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if Player then
        TriggerEvent('qb-log:server:CreateLog', 'adminmoney', 'Set Money', 'white', GetPlayerName(source) .. ' (' .. source .. ') Set '..GetPlayerName(tonumber(args[1]))..' ('..args[1]..') '..args[2]..' to '..args[3], false)
        Player.Functions.SetMoney(tostring(args[2]), tonumber(args[3]))
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
    end
end, 'dev')

QBCore.Commands.Add('givemoney', 'Give A Player Money', { { name = 'id', help = 'Player ID' }, { name = 'moneytype', help = 'Type of money (bank,...)' }, { name = 'amount', help = 'Amount of money' } }, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if Player then
        TriggerEvent('qb-log:server:CreateLog', 'adminmoney', 'Give Money', 'white', GetPlayerName(source) .. ' (' .. source .. ') Give '..args[3]..' '..args[2]..' to '..GetPlayerName(tonumber(args[1]))..' ('..args[1]..')', false)
        Player.Functions.AddMoney(tostring(args[2]), tonumber(args[3]))
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
    end
end, 'dev')

QBCore.Commands.Add('removemoney', 'Remove A Player Money', { { name = 'id', help = 'Player ID' }, { name = 'moneytype', help = 'Type of money (bank,...)' }, { name = 'amount', help = 'Amount of money' } }, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if Player then
        TriggerEvent('qb-log:server:CreateLog', 'adminmoney', 'Remove Money', 'white', GetPlayerName(source) .. ' (' .. source .. ') Remove '..args[3]..' '..args[2]..' from '..GetPlayerName(tonumber(args[1]))..' ('..args[1]..')', false)
        if tostring(args[2]) == 'bank' then
            Player.Functions.SetMoney("bank", Player.PlayerData.money.bank - tonumber(args[3]), 'Remove Money (Admin)')
        else
            Player.Functions.RemoveMoney(tostring(args[2]), tonumber(args[3]))
        end
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
    end
end, 'dev')

QBCore.Commands.Add('removeofflinemoney', 'Remove A Offline Player Money', { { name = 'bsn', help = 'State ID' }, { name = 'moneytype', help = 'Type of money (bank,...)' }, { name = 'amount', help = 'Amount of money' } }, true, function(source, args)
    local bsn = string.upper(args[1])
    local target = QBCore.Functions.GetPlayerByCitizenId(bsn)
    if target then
        TriggerClientEvent('QBCore:Notify', source, 'Player is Online', 'error')
        return
    end
    local PlayerData = MySQL.prepare.await('SELECT * FROM players where citizenid = ?', { bsn })
    if PlayerData then
        PlayerData.money = json.decode(PlayerData.money)
        if PlayerData.money[args[2]] then
            PlayerData.money[args[2]] = PlayerData.money[args[2]] - tonumber(args[3])
            MySQL.update('UPDATE players SET money = ? WHERE citizenid = ?', {json.encode(PlayerData.money), bsn})
            TriggerClientEvent('QBCore:Notify', source, 'Done', 'success')
            TriggerEvent('qb-log:server:CreateLog', 'adminmoney', 'Remove Money', 'white', GetPlayerName(source) .. ' (' .. source .. ') Remove '..args[3]..' from BSN: '..bsn)
        else
            TriggerClientEvent('QBCore:Notify', source, 'Money type does not exist', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'BSN does not exist', 'error')
    end
end, 'dev')

-- Job

QBCore.Commands.Add('job', 'Check Your Job', {}, false, function(source, args)
    if args[1] then
        local src = source
        local msg = table.concat(args, ' ')
        local Player = QBCore.Functions.GetPlayer(src)
        if Player.PlayerData.job.onduty then
            if Player.PlayerData.job.name == "police" then
                TriggerEvent('qb-log:server:CreateLog', 'policechat', 'Police Chat', 'blue', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.metadata["callsign"] .. ') Send: '..msg)
                for _, v in pairs(QBCore.Functions.GetPlayers()) do
                    local tPlayer = QBCore.Functions.GetPlayer(v)
                    if tPlayer and tPlayer.PlayerData.job.name == "police" and tPlayer.PlayerData.job.onduty then
                        TriggerClientEvent('chatMessage', v, 'POLICE | '..Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname..'('..Player.PlayerData.metadata["callsign"]..')', 'police', msg)
                    end
                end
            elseif Player.PlayerData.job.name == "justice" then
                TriggerEvent('qb-log:server:CreateLog', 'justicechat', 'Justice Chat', 'blue', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.metadata["callsign"] .. ') Send: '..msg)
                for _, v in pairs(QBCore.Functions.GetPlayers()) do
                    local tPlayer = QBCore.Functions.GetPlayer(v)
                    if tPlayer and tPlayer.PlayerData.job.name == "justice" and tPlayer.PlayerData.job.onduty then
                        TriggerClientEvent('chatMessage', v, 'JUSTICE | '..Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname..'('..Player.PlayerData.metadata["callsign"]..')', 'police', msg)
                    end
                end
            elseif Player.PlayerData.job.name == "goverment" then
                TriggerEvent('qb-log:server:CreateLog', 'govermentchat', 'Goverment Chat', 'blue', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. ' Send: '..msg)
                for _, v in pairs(QBCore.Functions.GetPlayers()) do
                    local tPlayer = QBCore.Functions.GetPlayer(v)
                    if tPlayer and tPlayer.PlayerData.job.name == "goverment" and tPlayer.PlayerData.job.onduty then
                        TriggerClientEvent('chatMessage', v, 'Goverment | '..Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname, 'police', msg)
                    end
                end
            elseif Player.PlayerData.job.name == "ambulance" then
                TriggerEvent('qb-log:server:CreateLog', 'mdchat', 'Medical Chat', 'blue', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.metadata["callsign"] .. ') Send: '..msg)
                for _, v in pairs(QBCore.Functions.GetPlayers()) do
                    local tPlayer = QBCore.Functions.GetPlayer(v)
                    if tPlayer and tPlayer.PlayerData.job.name == "ambulance" and tPlayer.PlayerData.job.onduty then
                        TriggerClientEvent('chatMessage', v, 'Medical | '..Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname..'('..Player.PlayerData.metadata["callsign"]..')', 'police', msg)
                    end
                end
            end
            
        end
    else
        local PlayerJob = QBCore.Functions.GetPlayer(source).PlayerData.job
        TriggerClientEvent('QBCore:Notify', source, Lang:t('info.job_info', {value = PlayerJob.label, value2 = PlayerJob.grade.name, value3 = PlayerJob.onduty}))
    end
end)

-- Gang

QBCore.Commands.Add('gang', 'Check Your Gang', {}, false, function(source)
    local PlayerGang = QBCore.Functions.GetPlayer(source).PlayerData.gang
    TriggerClientEvent('QBCore:Notify', source, Lang:t('info.gang_info', {value = PlayerGang.label, value2 = PlayerGang.grade.name}))
end)

-- Vehicle

QBCore.Commands.Add('car', 'Spawn Vehicle', {{name = 'model', help = 'Model name of the vehicle'}}, true, function(source, args)
    TriggerClientEvent('QBCore:Command:SpawnVehicle', source, args[1])
    TriggerEvent('qb-log:server:CreateLog', 'spawncar', 'Spawn Vehicle', 'white', GetPlayerName(source)..' Spawned **'..args[1]..'**')
end, 'dev')

QBCore.Commands.Add('dv', 'Delete Vehicle', {}, false, function(source)
    TriggerClientEvent('QBCore:Command:DeleteVehicle', source)
end, 'admin')

QBCore.Commands.Add("fix", "Repair your vehicle", {{name = "id", help = 'Target Player ID'}}, false, function(source, args)
    if args[1] then
		local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
		if Player then
            TriggerEvent('qb-log:server:CreateLog', 'fixadmin', '**'.. GetPlayerName(source)..'**', 'white', 'Target: '..GetPlayerName(tonumber(args[1])))
            TriggerClientEvent('iens:repaira', tonumber(args[1]))
        else
            TriggerClientEvent('QBCore:Notify', source, 'Player is not Online', "error")
        end
    else
        TriggerEvent('qb-log:server:CreateLog', 'fixadmin', '**'..GetPlayerName(source)..'**', 'white', 'used fix for his car')
        TriggerClientEvent('iens:repaira', source)
    end
end, 'admin')

QBCore.Commands.Add('dvall', 'Delete All Vehicles (Only on Cheat)', {}, false, function(source)
    local vehicles = GetAllVehicles()
    for _, vehicle in ipairs(vehicles) do
        DeleteEntity(vehicle)
    end
    TriggerEvent('qb-log:server:CreateLog', 'deleteadmin', 'DV ALL', 'red', GetPlayerName(source) .. ' (' .. source .. ') Used dvall')
end, 'admin')

-- Peds

QBCore.Commands.Add('dvp', 'Delete All Peds (Only on Cheat)', {}, false, function(source)
    local peds = GetAllPeds()
    for _, ped in ipairs(peds) do
        DeleteEntity(ped)
    end
    TriggerEvent('qb-log:server:CreateLog', 'deleteadmin', 'DV Peds', 'red', GetPlayerName(source) .. ' (' .. source .. ') Used dvp')
end, 'admin')

-- Objects

QBCore.Commands.Add('dvo', 'Delete All Objects (Only on Cheat)', {}, false, function()
    local objects = GetAllObjects()
    for _, object in ipairs(objects) do
        DeleteEntity(object)
    end
    TriggerEvent('qb-log:server:CreateLog', 'deleteadmin', 'DV Objects', 'red', GetPlayerName(source) .. ' (' .. source .. ') Used dvo')
end, 'admin')

-- Smart

QBCore.Commands.Add('smart', 'Smart State', {{name = "state", help = 'true/false'}}, true, function(source, args)
    local state = false
    local text = 'Disable'
    if args[1] == 'true' then
        state = true
        text = 'Enable'
    end
    TriggerClientEvent('QBCore:Command:Smart', source, state)
    TriggerEvent('qb-log:server:CreateLog', 'smart', 'Toggle Smart', 'white', GetPlayerName(source) .. ' (' .. source .. ') '..text..' Smart State', false)
end, 'admin')

-- Item

QBCore.Commands.Add("setinfo", "Set Info of Item", {{name="slot", help='Slot Number of Item'},{name="key", help='Key'},{name="value", help='Value'}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if not Player then return end
	local slot = tonumber(args[1])
	if not slot or slot < 1 or slot > QBCore.Config.Player.MaxInvSlots then return end
    local key = args[2]
	local value = tonumber(args[3])
	if not value then value = args[3] end
    local invs = Player.PlayerData.items[slot]
    invs.info[key] = value
    Player.Functions.SetInventory(Player.PlayerData.items)
end, "admin")

-- Hospital

QBCore.Commands.Add("revive", 'Revive Player', {{name = "id", help = 'Target Player ID'}}, false, function(source, args)
	local src = source
	if args[1] then
		local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
		if Player then
            TriggerEvent('qb-log:server:CreateLog', 'revive', 'Revive Player', 'white', GetPlayerName(source) .. ' (' .. source .. ') Revive '..Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname, false)
			TriggerClientEvent('hospital:client:Revive', Player.PlayerData.source)
		else
			TriggerClientEvent('QBCore:Notify', src, 'Player is not Online', "error")
		end
	else
        TriggerEvent('qb-log:server:CreateLog', 'revive', 'Revive Self', 'white', GetPlayerName(source) .. ' (' .. source .. ') Used Self Revive', false)
		TriggerClientEvent('hospital:client:Revive', src)
	end
end, 'admin')

QBCore.Commands.Add("kill", 'Kill Player', {{name = "id", help = 'Target Player ID'}}, false, function(source, args)
	local src = source
	if args[1] then
		local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
		if Player then
            TriggerEvent('qb-log:server:CreateLog', 'killadmin', '**'.. GetPlayerName(source)..'**', 'white', 'Target: '..GetPlayerName(tonumber(args[1])))
			TriggerClientEvent('hospital:client:KillPlayer', Player.PlayerData.source)
		else
			TriggerClientEvent('QBCore:Notify', src, 'Player is not Online', "error")
		end
	else
		TriggerClientEvent('hospital:client:KillPlayer', src)
        TriggerEvent('qb-log:server:CreateLog', 'killadmin', '**'.. GetPlayerName(source)..'**', 'white', 'Target: '..GetPlayerName(source))
	end
end, "admin")

QBCore.Commands.Add("heal", 'Heal Player', {{name = "id", help = 'Target Player ID'}}, false, function(source, args)
	local src = source
	if args[1] then
		local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
		if Player then
            TriggerEvent('qb-log:server:CreateLog', 'healadmin', '**'.. GetPlayerName(source)..'**', 'white', 'Target: '..GetPlayerName(tonumber(args[1])))
			TriggerClientEvent('hospital:client:adminHeal', Player.PlayerData.source)
		else
			TriggerClientEvent('QBCore:Notify', src, 'Player is not Online', "error")
		end
	else
		TriggerClientEvent('hospital:client:adminHeal', src)
        TriggerEvent('qb-log:server:CreateLog', 'healadmin', '**'.. GetPlayerName(source)..'**', 'white', 'Target: '..GetPlayerName(source))
	end
end, 'admin')

QBCore.Commands.Add("armor", 'Armor Player', {{name = "id", help = 'Target Player ID'}}, false, function(source, args)
	local src = source
	if args[1] then
		local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
		if Player then
			TriggerClientEvent('QBCore:Command:Armor', Player.PlayerData.source)
            TriggerEvent('qb-log:server:CreateLog', 'setarmor', '**'.. GetPlayerName(source)..'**', 'white', 'Target: '..GetPlayerName(tonumber(args[1])))
		else
			TriggerClientEvent('QBCore:Notify', src, 'Player is not Online', "error")
		end
	else
		TriggerClientEvent('QBCore:Command:Armor', src)
        TriggerEvent('qb-log:server:CreateLog', 'setarmor', '**'.. GetPlayerName(source)..'**', 'white', 'Target: '..GetPlayerName(source))
	end
end, 'admin')

-- Admin Stash

QBCore.Commands.Add("adminstash", 'Open Admin Stash', {}, false, function(source, args)
	local src = source
	TriggerClientEvent('QBCore:Command:AdminStash', src)
end, 'admin')

-- Delete Character

QBCore.Commands.Add('delchar', 'Delete Character', {{name = 'BSN', help = 'Citizen Id'}}, true, function(source, args)
    local bsn = string.upper(args[1])
    local target = QBCore.Functions.GetPlayerByCitizenId(bsn)
    if target then
        TriggerClientEvent('QBCore:Notify', source, 'Player is Online, Kick Player First', 'error')
        return
    end
    local result = MySQL.scalar.await('SELECT citizenid FROM players WHERE citizenid = ?', {bsn})
    if result then
        MySQL.query('DELETE FROM players WHERE citizenid = ?', {bsn})
        TriggerEvent('qb-log:server:CreateLog', 'deletechar', 'Delete Character', 'white', GetPlayerName(source) .. ' (' .. source .. ') Delete StateID **'..bsn..'**', false)
        TriggerClientEvent('QBCore:Notify', source, 'Done', 'success')
    else
        TriggerClientEvent('QBCore:Notify', source, 'BSN does not exist', 'error')
    end
end, 'dev')

-- Delete Vehicle

QBCore.Commands.Add('delveh', 'Delete Vehicle From Database', {{name = 'plate', help = 'Plate'}}, true, function(source, args)
    local plate = string.upper(args[1])
    local result = MySQL.scalar.await('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    if result then
        MySQL.query('DELETE FROM player_vehicles WHERE plate = ?', {plate})
        TriggerEvent('qb-log:server:CreateLog', 'deleteveh', 'Delete Vehicle', 'white', GetPlayerName(source) .. ' (' .. source .. ') Delete Plate **'..plate..'**', false)
        TriggerClientEvent('QBCore:Notify', source, 'Done', 'success')
    else
        TriggerClientEvent('QBCore:Notify', source, 'BSN does not exist', 'error')
    end
end, 'dev')

-- Change Player Char Info

QBCore.Commands.Add('changename', 'Change Player Name', {{name = 'BSN', help = 'Citizen Id'}, {name = 'First Name', help = 'New First Name'}, {name = 'Last Name', help = 'New Last Name'}}, true, function(source, args)
    local bsn = string.upper(args[1])
    local firstname = args[2]
    local lastname = args[3]
    local target = QBCore.Functions.GetPlayerByCitizenId(bsn)
    if target then
        TriggerClientEvent('QBCore:Notify', source, 'Player is Online, Kick Player First', 'error')
        return
    end
    local result = MySQL.scalar.await('SELECT charinfo FROM players WHERE citizenid = ?', {bsn})
    if result then
        local charinfo = json.decode(result)
        charinfo.firstname = firstname
        charinfo.lastname = lastname
        local updated = json.encode(charinfo)
        MySQL.update('UPDATE players SET charinfo = ? WHERE citizenid = ?', {updated, bsn})
        TriggerClientEvent('QBCore:Notify', source, 'Name of '..bsn..' has been changed to '..firstname..' '..lastname, 'success')
        TriggerEvent('qb-log:server:CreateLog', 'changename', 'Change Name', 'white', GetPlayerName(source) .. ' (' .. source .. ') Changed Name of **'..bsn..'** to **'..firstname..' '..lastname..'**', false)
    else
        TriggerClientEvent('QBCore:Notify', source, 'BSN does not exist', 'error')
    end
end, 'admin')

QBCore.Commands.Add('changephone', 'Change Player Phone Number', {{name = 'BSN', help = 'Citizen Id'}, {name = 'Phone Number', help = 'New Phone Number'}}, true, function(source, args)
    local bsn = string.upper(args[1])
    local phone = args[2]
    local target = QBCore.Functions.GetPlayerByCitizenId(bsn)
    if target then
        TriggerClientEvent('QBCore:Notify', source, 'Player is Online, Kick Player First', 'error')
        return
    end
    local result = MySQL.scalar.await('SELECT charinfo FROM players WHERE citizenid = ?', {bsn})
    if result then
        local charinfo = json.decode(result)
        charinfo.phone = phone
        local updated = json.encode(charinfo)
        MySQL.update('UPDATE players SET charinfo = ? WHERE citizenid = ?', {updated, bsn})
        TriggerClientEvent('QBCore:Notify', source, 'Phone number of '..bsn..' has been changed to '..phone, 'success')
        TriggerEvent('qb-log:server:CreateLog', 'changephone', 'Change Phone Number', 'white', GetPlayerName(source) .. ' (' .. source .. ') Changed Phone Number of **'..bsn..'** to **'..phone..'**', false)
    else
        TriggerClientEvent('QBCore:Notify', source, 'BSN does not exist', 'error')
    end
end, 'admin')

-- Out of Character Chat

QBCore.Commands.Add('ooc', 'OOC Chat Message', {{name = 'message', help = 'Message to chat with'}}, true, function(source, args)
    local message = table.concat(args, ' ')
    local Players = QBCore.Functions.GetPlayers()
    local Player = QBCore.Functions.GetPlayer(source)
    local playerCoords = GetEntityCoords(GetPlayerPed(source))
    local name = Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname
    for _, v in pairs(Players) do
        if v == source then
            TriggerClientEvent('chatMessage', v, 'OOC', 'normal', message, 'OOC')
            TriggerEvent('qb-log:server:CreateLog', 'ooc', 'OOC', 'white', '**' .. name .. '** (CitizenID: ' .. Player.PlayerData.citizenid .. ' | ID: ' .. source .. ') **Message:** ' .. message, false)
        elseif #(playerCoords - GetEntityCoords(GetPlayerPed(v))) < 20.0 then
            if QBCore.Functions.HasPermission(v, 'admin') and not exports['snipe-menu']:IsToggleAdmin(v) then
                TriggerClientEvent('chatMessage', v, 'OOC | '..name..' ('..source..')', 'normal', message, 'OOC')
            else
                TriggerClientEvent('chatMessage', v, 'OOC | '..source, 'normal', message, 'OOC')
            end
        elseif QBCore.Functions.HasPermission(v, 'admin') and not exports['snipe-menu']:IsToggleAdmin(v) then
            TriggerClientEvent('chatMessage', v, 'Proxmity OOC | '..name..' ('..source..')', 'normal', message, 'OOC')
        end
    end
end)

-- Me command

QBCore.Commands.Add('me', 'Show local message', {{name = 'message', help = 'Message to respond with'}}, true, function(source, args)
    local ped = GetPlayerPed(source)
    local pCoords = GetEntityCoords(ped)
    local Player = QBCore.Functions.GetPlayer(source)
    local msg = table.concat(args, ' '):gsub('[~<].-[>~]', '')
    local Players = QBCore.Functions.GetPlayers()
    TriggerEvent('qb-log:server:CreateLog', 'me', 'Me', 'white', '**' .. GetPlayerName(source) .. '** (CitizenID: ' .. Player.PlayerData.citizenid .. ' | ID: ' .. source .. ') **Action:** ' .. msg, false)
    for i=1, #Players do
        local Player = Players[i]
        local target = GetPlayerPed(Player)
        local tCoords = GetEntityCoords(target)
        if target == ped or #(pCoords - tCoords) < 20 then
            TriggerClientEvent('QBCore:Command:ShowMe3D', Player, source, msg)
        end
    end
end)