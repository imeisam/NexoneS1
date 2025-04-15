local QBCore = exports['qb-core']:GetCoreObject()

local function GetStashItems(stashId)
	local items = {}
	local result = MySQL.Sync.fetchScalar('SELECT items FROM stashitems WHERE stash = ?', {stashId})
	if result then
		local stashItems = json.decode(result)
		if stashItems then
			for k, item in pairs(stashItems) do
				local itemInfo = QBCore.Shared.Items[item.name:lower()]
				if itemInfo then
					items[item.slot] = {
						name = itemInfo["name"],
						amount = tonumber(item.amount),
						info = item.info ~= nil and item.info or "",
						label = itemInfo["label"],
						description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
						weight = itemInfo["weight"],
						type = itemInfo["type"],
						unique = itemInfo["unique"],
						useable = itemInfo["useable"],
						image = itemInfo["image"],
						slot = item.slot,
					}
				end
			end
		end
	end
	return items
end

QBCore.Functions.CreateCallback('qb-closedshops:dutycheck', function(source, cb)
	local jobtable = {}
	for k, v in pairs(Config.Shops) do jobtable[tostring(k)] = false end
	for k, v in pairs(QBCore.Functions.GetPlayers()) do
		local Player = QBCore.Functions.GetPlayer(v)
		if Player ~= nil then
			for l, b in pairs(Config.Shops) do
				if Player.PlayerData.job.name == l and Player.PlayerData.job.onduty then
					jobtable[l] = true
				end
			end
		end
	end
	if Config.Debug then print("DutyList: "..json.encode(jobtable)) end
	cb(jobtable) 
end)

RegisterServerEvent('qb-closedshops:GetItem', function(amount, billtype, item, name, price, job)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local stashItems = GetStashItems("closedStock_"..job)
	if Config.Debug then print("Retrieving stash info: ['closedStock_"..job.."']") end
	--Inventory space checks
	local totalWeight = QBCore.Player.GetTotalWeight(Player.PlayerData.items)
    local maxWeight = QBCore.Config.Player.MaxWeight
	local balance = Player.Functions.GetMoney(tostring(billtype))
	if (totalWeight + (QBCore.Shared.Items[item].weight * amount)) > maxWeight then 
		TriggerClientEvent("QBCore:Notify", src, "Not enough space in inventory", "error") 
	else
		--Money checks
		if balance >= (tonumber(price) * tonumber(amount)) then
			local cost = (tonumber(price) * tonumber(amount))
			Player.Functions.RemoveMoney(tostring(billtype), (tonumber(price) * tonumber(amount)), "Buy "..amount.." X "..QBCore.Shared.Items[item].label)
			local currentPlayerFirstName = Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname

			if Config.Manage then exports["snipe-banking"]:AddMoneyToAccount(tostring(job), cost,"Buy "..amount.." X "..QBCore.Shared.Items[item].label.." With "..currentPlayerFirstName) 
				if Config.Debug then print("qb-Management(Job): Adding $"..(cost ).." to account '"..tostring(job).."'") end
			end
			if not Config.Manage then TriggerEvent("qb-bossmenu:server:addAccountMoney", tostring(job), cost ) 
				if Config.Debug then print("qb-BossMenu(Job): Adding $"..(cost ).." to account '"..tostring(job).."'") end
			end
		else 
			TriggerClientEvent("QBCore:Notify", src, "Not enough money", "error") return end
			Player.Functions.AddItem(item, amount)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add", amount)
		--Update Boss Stash
		for k, v in pairs(stashItems) do
			if v.name == item then
				if (stashItems[k].amount - amount) <= 0 then stashItems[k] = nil else stashItems[k].amount = stashItems[k].amount - amount end
				TriggerEvent('qb-closedshops:server:SaveStashItems', "closedStock_"..job, stashItems) break
			end
		end
	end
	
	local data = { stash = job, }
	TriggerClientEvent('qb-closedshops:ShopMenu', src, data)
end)

QBCore.Functions.CreateCallback('qb-closedshops:server:GetStashItems', function(source, cb, stashId) cb(GetStashItems(stashId)) end)
AddEventHandler('qb-closedshops:server:SaveStashItems', function(stashId, items) MySQL.Async.insert('INSERT INTO stashitems (stash, items) VALUES (:stash, :items) ON DUPLICATE KEY UPDATE items = :items', { ['stash'] = stashId, ['items'] = json.encode(items) }) end)