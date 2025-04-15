local QBCore = exports['qb-core']:GetCoreObject()
local mdtrrole = {
	['ambulance'] = {dep=1,role=24},
	['police'] = {dep=0,role=48},
	['justice'] = {dep=2,role=45},
	['lawyer'] = {dep=3,role=52},
	['goverment'] = {dep=4,role=54},
}

-- Get Employees
QBCore.Functions.CreateCallback('qb-bossmenu:server:GetEmployees', function(source, cb)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local jobname = Player.PlayerData.job.name
	if not Player.PlayerData.job.isboss and not Player.PlayerData.job.ismanager and not QBCore.Functions.HasDivision(src, 'hc') and not QBCore.Functions.HasDivision(src, 'hr') then return end
	local employees = {}
	local players = MySQL.query.await("SELECT * FROM `multijobs` WHERE `jobdata` LIKE '%".. jobname .."%'", {})
	if players[1] ~= nil then
		for _, value in pairs(players) do
			local jobdata = json.decode(value.jobdata)
			if QBCore.Shared.Jobs[jobname].grades[tostring(jobdata[jobname].grade)] then
				local isOnline = QBCore.Functions.GetPlayerByCitizenId(value.citizenid)
				if isOnline then
					employees[#employees+1] = {
						empSource = isOnline.PlayerData.citizenid,
						grade = {
							level = jobdata[jobname].grade,
							name = QBCore.Shared.Jobs[jobname].grades[tostring(jobdata[jobname].grade)].name
						},
						name = isOnline.PlayerData.charinfo.firstname .. ' ' .. isOnline.PlayerData.charinfo.lastname,
						activeJob = isOnline.PlayerData.job.name,
						online = true
					}
				else
					local player = MySQL.query.await('SELECT * FROM players WHERE citizenid = ? LIMIT 1', {value.citizenid})
					if player[1] ~= nil then
						employees[#employees+1] = {
							empSource = value.citizenid,
							grade = {
								level = jobdata[jobname].grade,
								name = QBCore.Shared.Jobs[jobname].grades[tostring(jobdata[jobname].grade)].name
							},
							name = json.decode(player[1].charinfo).firstname .. ' ' .. json.decode(player[1].charinfo).lastname,
							activeJob = json.decode(player[1].job).name,
							online = false
						}
					end
				end
			end
		end
		table.sort(employees, function(a, b)
            return a.grade.level > b.grade.level
        end)
	end
	cb(employees)
end)

-- Get Division
QBCore.Functions.CreateCallback('qb-bossmenu:server:GetDivision', function(source, cb, cid)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if not Player.PlayerData.job.isboss and not Player.PlayerData.job.ismanager and not QBCore.Functions.HasDivision(src, 'hc') and not QBCore.Functions.HasDivision(src, 'hr') then return end
	local jobdiv = {}
	local xTarget = QBCore.Functions.GetPlayerByCitizenId(cid)
	if xTarget then
		if xTarget.PlayerData.job.name ~= Player.PlayerData.job.name then return end
		for i,v in pairs(QBCore.Shared.Jobs[xTarget.PlayerData.job.name].division) do
			
			table.insert(jobdiv,{
				name = i,
				state = QBCore.Functions.HasDivision(xTarget.PlayerData.source, i)
			})
		end
	end

	cb(jobdiv)
end)

QBCore.Commands.Add("addmdtaccess", "Add MDT Access", {{name="cid", help='Target Citizen Id'},{name="job", help='Job'}}, true, function(source, args)
    local cid = args[1]
	local job = args[2]
	TriggerEvent('qb-bossmenu:server:mdtaccess', cid, job)
end, "dev")

QBCore.Commands.Add("removemdtaccess", "Remove MDT Access", {{name="cid", help='Target Citizen Id'}}, true, function(source, args)
    local cid = args[1]
	TriggerEvent('qb-bossmenu:server:mdttakeaccess', cid)
end, "dev")

AddEventHandler('qb-bossmenu:server:mdtaccess', function(cid, job)
	exports['nxo_mdt']:CreateOfficer({stateid = cid},'None provided', 'None provided', 'None provided', '', mdtrrole[job].dep, 0, {mdtrrole[job].role})
end)

AddEventHandler('qb-bossmenu:server:mdttakeaccess', function(cid)
	exports['nxo_mdt']:DeleteOfficer({stateid = cid})
end)

RegisterNetEvent('qb-bossmenu:server:ManageEmployeeDivision', function(data)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if not Player.PlayerData.job.isboss and not Player.PlayerData.job.ismanager and not QBCore.Functions.HasDivision(src, 'hc') and not QBCore.Functions.HasDivision(src, 'hr') then return end
	local xTarget = QBCore.Functions.GetPlayerByCitizenId(data.cid)
	if xTarget then
		if xTarget.PlayerData.job.name ~= Player.PlayerData.job.name then return end
		if data.state then
			xTarget.Functions.AddDivision(data.name)
			TriggerEvent("qb-log:server:CreateLog", "bossmenu", "Add Division", "green", Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname..' successfully added '..xTarget.PlayerData.charinfo.firstname.." "..xTarget.PlayerData.charinfo.lastname.." to "..data.name.." division (" .. Player.PlayerData.job.label .. ")")
		else
			xTarget.Functions.RemoveDivision(data.name)
			TriggerEvent("qb-log:server:CreateLog", "bossmenu", "Remove Division", "remove", Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname..' successfully removed '..xTarget.PlayerData.charinfo.firstname.." "..xTarget.PlayerData.charinfo.lastname.." from "..data.name.." division (" .. Player.PlayerData.job.label .. ")")
		end
	end
	TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
end)

-- Grade Change
RegisterNetEvent('qb-bossmenu:server:GradeUpdate', function(data)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if not Player.PlayerData.job.isboss and not Player.PlayerData.job.ismanager and not QBCore.Functions.HasDivision(src, 'hc') and not QBCore.Functions.HasDivision(src, 'hr') then return end
	local Employee = QBCore.Functions.GetPlayerByCitizenId(data.cid)
	if Employee then
		if Employee.PlayerData.job.name ~= Player.PlayerData.job.name then return end
		if Employee.Functions.SetJob(Player.PlayerData.job.name, data.grade) then
			TriggerClientEvent('QBCore:Notify', src, "Sucessfulluy promoted!", "success")
			TriggerClientEvent('QBCore:Notify', Employee.PlayerData.source, "You have been promoted to" ..data.gradename..".", "success")
			TriggerEvent("qb-log:server:CreateLog", "bossmenu", "Grade Update", "green", Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname..' successfully update grade of '..Employee.PlayerData.charinfo.firstname.." "..Employee.PlayerData.charinfo.lastname.." to "..data.gradename.." (" .. Player.PlayerData.job.label .. ")")
		else
			TriggerClientEvent('QBCore:Notify', src, "Promotion grade does not exist.", "error")
		end
	end
	TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
end)

-- Fire Employee
RegisterNetEvent('qb-bossmenu:server:FireEmployee', function(target)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if not Player.PlayerData.job.isboss and not Player.PlayerData.job.ismanager and not QBCore.Functions.HasDivision(src, 'hc') and not QBCore.Functions.HasDivision(src, 'hr') then return end
	local Employee = QBCore.Functions.GetPlayerByCitizenId(target)
	if Employee then
		if target ~= Player.PlayerData.citizenid then
			TriggerClientEvent('QBCore:Notify', src, "Employee fired!", "success")
			TriggerClientEvent('QBCore:Notify', Employee.PlayerData.source , "You have been fired from "..Player.PlayerData.job.label.."! Good luck.", "error")
			TriggerEvent('qb-multijob:server:removeJob', target, Player.PlayerData.job.name)
			TriggerEvent("qb-log:server:CreateLog", "bossmenu", "Job Fire", "red", Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. ' successfully fired ' .. Employee.PlayerData.charinfo.firstname .. " " .. Employee.PlayerData.charinfo.lastname .. " (" .. Player.PlayerData.job.label .. ")")
			TriggerEvent('qb-bossmenu:server:mdttakeaccess',  Employee.PlayerData.citizenid)
		else
			TriggerClientEvent('QBCore:Notify', src, "You can\'t fire yourself", "error")
		end
	else
		local player = MySQL.query.await('SELECT * FROM players WHERE citizenid = ? LIMIT 1', { target })
		if player[1] ~= nil then
			TriggerClientEvent('QBCore:Notify', src, "Employee fired!", "success")
			TriggerEvent('qb-multijob:server:removeJob', target, Player.PlayerData.job.name)
			TriggerEvent("qb-log:server:CreateLog", "bossmenu", "Job Fire", "red", Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. ' successfully fired ' .. json.decode(player[1].charinfo).firstname .. ' ' .. json.decode(player[1].charinfo).lastname .. " (" .. Player.PlayerData.job.name .. ")")
			TriggerEvent('qb-bossmenu:server:mdttakeaccess', player[1].citizenid)
		else
			TriggerClientEvent('QBCore:Notify', src, "Can not Find Player in Database!", "error")
		end
	end
	TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
end)

-- Recruit Player
RegisterNetEvent('qb-bossmenu:server:HireEmployee', function(recruit)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if not Player.PlayerData.job.isboss and not Player.PlayerData.job.ismanager and not QBCore.Functions.HasDivision(src, 'hr') and not QBCore.Functions.HasDivision(src, 'hc') then return end
	local Target = QBCore.Functions.GetPlayer(recruit)
	if Target then
		
		if Target.Functions.SetJob(Player.PlayerData.job.name, 0) then
			if mdtrrole[Player.PlayerData.job.name] then
				TriggerEvent('qb-bossmenu:server:mdtaccess',Target.PlayerData.citizenid,Player.PlayerData.job.name)
			end
			TriggerClientEvent('QBCore:Notify', src, "You hired "..Target.PlayerData.charinfo.firstname..' '..Target.PlayerData.charinfo.lastname, "success")
			TriggerClientEvent('QBCore:Notify', Target.PlayerData.source , "You were hired as "..Player.PlayerData.job.label, "success")
			TriggerEvent('qb-log:server:CreateLog', 'bossmenu', 'Recruit', "lightgreen", (Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname).. " successfully recruited " .. (Target.PlayerData.charinfo.firstname .. ' ' .. Target.PlayerData.charinfo.lastname) .. ' (' .. Player.PlayerData.job.label .. ')')
		end
	end
	TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
end)

-- Get closest player sv
QBCore.Functions.CreateCallback('qb-bossmenu:getplayers', function(source, cb)
	local src = source
	local players = {}
	local PlayerPed = GetPlayerPed(src)
	local pCoords = GetEntityCoords(PlayerPed)
	for _, v in pairs(QBCore.Functions.GetPlayers()) do
		local targetped = GetPlayerPed(v)
		local tCoords = GetEntityCoords(targetped)
		local dist = #(pCoords - tCoords)
		if PlayerPed ~= targetped and dist < 10 then
			local ped = QBCore.Functions.GetPlayer(v)
			players[#players+1] = {
				id = v,
				coords = GetEntityCoords(targetped),
				name = ped.PlayerData.charinfo.firstname .. " " .. ped.PlayerData.charinfo.lastname,
				citizenid = ped.PlayerData.citizenid,
				sources = GetPlayerPed(ped.PlayerData.source),
				sourceplayer = ped.PlayerData.source
			}
		end
	end
		table.sort(players, function(a, b)
			return a.name < b.name
		end)
	cb(players)
end)