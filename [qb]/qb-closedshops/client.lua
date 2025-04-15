local QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = {}
local bossroles = {}
local peds = {}

CreateThread(function()
	for k, v in pairs(QBCore.Shared.Jobs) do
		for l, b in pairs(QBCore.Shared.Jobs[tostring(k)].grades) do
			if QBCore.Shared.Jobs[tostring(k)].grades[l].isboss == true then
				if bossroles[tostring(k)] ~= nil then
					if bossroles[tostring(k)][tostring(k)] > tonumber(l) then bossroles[tostring(k)] = { [tostring(k)] = tonumber(l) } end
				else bossroles[tostring(k)] = { [tostring(k)] = tonumber(l) }
				end
			end
		end
	end
end)

CreateThread(function()
	for k, v in pairs(Config.Shops) do
		exports['qb-target']:AddBoxZone("ClosedShop-['"..k.."']", Config.Shops[k].location, 1.5, 1.5, {
			name="ClosedShop-['"..k.."']",
			heading = Config.Shops[k].heading,
			debugPoly=Config.Debug,
			minZ=Config.Shops[k].location.z-0.9,
			maxZ=Config.Shops[k].location.z+0.8
		}, { options = { 
				{ event = "qb-closedshops:ShopMenu", icon = "fas fa-shop", label = "Browse Shop", stash = k }, 
				{ event = "qb-closedshops:Stash", icon = "fas fa-archive", label = "Access Stock", stash = k, job = bossroles[k] },
				}, 
			distance = 2.0
		})
		if Config.Debug then print("Creating Ped for store: ['"..k.."']") end
		RequestModel(Config.Shops[k].ped)
		while not HasModelLoaded(Config.Shops[k].ped) do Citizen.Wait(1) end
		if not peds[k] then peds[k] = CreatePed(5, Config.Shops[k].ped, Config.Shops[k].location.x, Config.Shops[k].location.y, Config.Shops[k].location.z-1.03, Config.Shops[k].heading, false, true) end
		SetEntityInvincible(peds[k], true)
		SetBlockingOfNonTemporaryEvents(peds[k], true)
		FreezeEntityPosition(peds[k], true)
	end
end)

RegisterNetEvent('qb-closedshops:ShopMenu', function(data)
	QBCore.Functions.TriggerCallback('qb-closedshops:dutycheck', function(DutyTable)
		if DutyTable[data.stash] then QBCore.Functions.Notify('Job is Online', 'error') return end
		local ped = PlayerPedId()
		local p = promise.new() QBCore.Functions.TriggerCallback('qb-closedshops:server:GetStashItems', function(cb) p:resolve(cb) end, "closedStock_"..data.stash)
		local StashItems = Citizen.Await(p)
		if Config.Debug then print("Retrieving stash info: ['closedStock_"..data.stash.."']") end
		for k, v in pairs(Config.Shops[data.stash].itemlist) do	for l, b in pairs(StashItems) do if b.name == k then item = true end end end
		if not item then TriggerEvent("QBCore:Notify", "Shop Closed, out of stock", "error") else
			local ShopMenu = {}
			local ShopBuild = {}
			ShopMenu[#ShopMenu + 1] = { header = QBCore.Shared.Jobs[data.stash].label, isMenuHeader = true }
			ShopMenu[#ShopMenu + 1] = { icon = "fas fa-circle-xmark", header = "", txt = "Close", params = { event = "qb-shops:CloseMenu" } }
			for k, v in pairs(StashItems) do
				if ShopBuild[v.name] == nil then ShopBuild[v.name] = { name = v.name, image = v.image, label = v.label, amount = v.amount }
				elseif ShopBuild[v.name] ~= nil then ShopBuild[v.name].amount = ShopBuild[v.name].amount + v.amount end
			end
			for k, v in pairs(ShopBuild) do
				if Config.Shops[data.stash].itemlist[v.name] then
					if QBCore.Shared.Items[v.name] then
						local text = "Available: x"..v.amount.."<br>Cost: $"..Config.Shops[data.stash].itemlist[v.name]
						ShopMenu[#ShopMenu + 1] = { icon = v.name, header = v.label, txt = text, params = { event = "qb-closedshops:Charge", 
						args = { item = v.name, stash = data.stash, cost = Config.Shops[data.stash].itemlist[v.name], max = v.amount } } }
						text, setheader = nil
					else print("Can't create menu entry: '"..v.name.."' - Not found in items.lua") end
				end
			end
			exports['qb-menu']:openMenu(ShopMenu)
		end
	end)
end)

RegisterNetEvent('qb-closedshops:Stash', function(data)
	TriggerServerEvent("inventory:server:OpenInventory", "stash", "closedStock_"..data.stash, { maxweight = 10000000, slots = 100, }) 
end)

RegisterNetEvent('qb-closedshops:Charge', function(data)
	local settext = "- Confirm Purchase -<br><br>Available: "..data.max.."<br> Cost per item: $"..data.cost.."<br><br>- Payment Type -"
	local input = {}
	input[#input+1] = { type = 'radio', name = 'billtype', text = settext, options = { { value = "cash", text = "Cash" }, { value = "bank", text = "Card" } } }
	if not QBCore.Shared.Items[data.item].unique then
		input[#input+1] = { type = 'number', isRequired = true, name = 'amount', text = 'Amount to buy' }
	end
	local img = QBCore.Shared.Items[data.item].image
	if string.find(img, "http") then else img = "nui://"..Config.img..img end
	local dialog = exports['qb-input']:ShowInput(
	{ header = "<center><p><img src="..img.." width=100px onerror='this.onerror=null; this.remove();'></p>"..QBCore.Shared.Items[data.item].label, submitText = "Pay",
	inputs = input
	})
	if dialog then
		if QBCore.Shared.Items[data.item].unique then dialog.amount = 1 end
		if not dialog.amount then return end
		local amo = dialog.amount if string.find(tostring(amo), "-") then amo = string.gsub(tostring(amo), "-", "") dialog.amount = tonumber(amo) end
		if tonumber(dialog.amount) > tonumber(data.max) then TriggerEvent("qb-closedshops:Charge", data) TriggerEvent("QBCore:Notify", "Not enough stock", "error") return else
			TriggerServerEvent('qb-closedshops:GetItem', dialog.amount, dialog.billtype, data.item, data.name, data.cost, data.stash)
			RequestAnimDict('amb@prop_human_atm@male@enter')
			while not HasAnimDictLoaded('amb@prop_human_atm@male@enter') do Wait(1) end
			if HasAnimDictLoaded('amb@prop_human_atm@male@enter') then 
			TaskPlayAnim(PlayerPedId(), 'amb@prop_human_atm@male@enter', "enter", 1.0,-1.0, 1500, 1, 1, true, true, true) end
		end
	end
end)

AddEventHandler('onResourceStop', function(resource) if resource ~= GetCurrentResourceName() then return end
	for k, v in pairs(Config.Shops) do exports['qb-target']:RemoveZone("ClosedShop-['"..k.."']") end
	for k, v in pairs(peds) do DeletePed(peds[k]) end
end)