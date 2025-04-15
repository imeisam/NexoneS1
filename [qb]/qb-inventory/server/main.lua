-- Variables
local QBCore = exports['qb-core']:GetCoreObject()
local Trunks = {}
local Gloveboxes = {}
local Stashes = {}
local ShopItems = {}
local Searchs = {}
local Drops = {}
local PickUps = {}
local NewDrops = {}
local PickupId = 0
local SoloPickUps = {}
local ThrownWeapons = {}
local WaitForCoordsThrow = {}
local isdrop=false


-- Functions
local function GetImage(name, info)
	if info and info.image then
		return info.image
	else
		local itemInfo = QBCore.Shared.Items[name]
		if itemInfo then
			return "images/"..itemInfo.image
		end
	end
	return ''
end

local function ImageFormat(items)
	for k, item in pairs(items) do
		item.image = GetImage(item.name, item.info)
	end
	return items
end

local function GenerateSerieText(item)
	local itemInfo = QBCore.Shared.Items[item.name]
	if itemInfo then
		if itemInfo.type == 'weapon' and item.info and item.info.serie then
			return ' SN: '..item.info.serie..' '
		end
	end
	return ''
end

local function recipeContains(recipe, fromItem)
	for k, v in pairs(recipe.accept) do
		if v == fromItem.name then
			return true
		end
	end

	return false
end

local function IsVehicleOwned(plate)
    local result = MySQL.Sync.fetchScalar('SELECT 1 from player_vehicles WHERE plate = ?', {plate})
    if result then return true else return false end
end

-- Shop Items
local function SetupShopItems(shop, shopItems)
	local items = {}
	if shopItems and next(shopItems) then
		for k, item in pairs(shopItems) do
			local itemInfo = QBCore.Shared.Items[item.name:lower()]
			if itemInfo then
				items[item.slot] = {
					name = itemInfo["name"],
					amount = tonumber(item.amount),
					info = item.info or {},
					label = itemInfo["label"],
					description = itemInfo["description"] or "",
					weight = itemInfo["weight"],
					type = itemInfo["type"],
					unique = itemInfo["unique"],
					useable = itemInfo["useable"],
					price = item.price,
					image = GetImage(item.name, item.info),
					slot = item.slot,
				}
			end
		end
	end
	return items
end

-- Stash Items
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
						info = item.info or {},
						label = itemInfo["label"],
						description = itemInfo["description"] or "",
						weight = item.weight or itemInfo["weight"],
						type = itemInfo["type"],
						unique = itemInfo["unique"],
						useable = itemInfo["useable"],
						image = GetImage(item.name, item.info),
						slot = item.slot,
					}
				end
			end
		end
	end
	return items
end
exports("GetStashItems", GetStashItems)

local function SaveStashItems(stashId, items)
	if Stashes[stashId].label ~= "Stash-None" then
		if items then
			if not Stashes[stashId].NoSave then
				for slot, item in pairs(items) do
					item.description = nil
				end
				MySQL.Async.insert('INSERT INTO stashitems (stash, items) VALUES (:stash, :items) ON DUPLICATE KEY UPDATE items = :items', {
					['stash'] = stashId,
					['items'] = json.encode(items)
				})
			end
			Stashes[stashId].isOpen = false
		end
	end
end
exports("SaveStashItems", SaveStashItems)

function SaveStashByID(id)
	if Stashes[id] and Stashes[id].items then
		SaveStashItems(id, Stashes[id].items)
	end
end
exports('SaveStashById', SaveStashByID)

local function AddToStash(stashId, slot, otherslot, itemName, amount, info, weight)
	local amount = tonumber(amount)
	local ItemData = QBCore.Shared.Items[itemName]
	if not ItemData.unique then
		if Stashes[stashId].items[slot] and Stashes[stashId].items[slot].name == itemName then
			Stashes[stashId].items[slot].amount = Stashes[stashId].items[slot].amount + amount
		else
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Stashes[stashId].items[slot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info or {},
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = weight or itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = GetImage(itemName, info),
				slot = slot,
			}
		end
	else
		if Stashes[stashId].items[slot] and Stashes[stashId].items[slot].name == itemName then
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Stashes[stashId].items[otherslot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info or {},
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = weight or itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = GetImage(itemName, info),
				slot = otherslot,
			}
		else
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Stashes[stashId].items[slot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info or {},
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = weight or itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = GetImage(itemName, info),
				slot = slot,
			}
		end
	end
end
exports('addStashItem', AddToStash)

local function RemoveFromStash(stashId, slot, itemName, amount)
	local amount = tonumber(amount)
	if Stashes[stashId].items[slot] ~= nil and Stashes[stashId].items[slot].name == itemName then
		if Stashes[stashId].items[slot].amount > amount then
			Stashes[stashId].items[slot].amount = Stashes[stashId].items[slot].amount - amount
		else
			Stashes[stashId].items[slot] = nil
			if next(Stashes[stashId].items) == nil then
				Stashes[stashId].items = {}
			end
		end
	else
		Stashes[stashId].items[slot] = nil
		if Stashes[stashId].items == nil then
			Stashes[stashId].items[slot] = nil
		end
	end
end
exports('RemoveFromStash', RemoveFromStash)

local function SetItemData(source, itemName, key, val)
	if not itemName or not key then return false end
	local Player = QBCore.Functions.GetPlayer(source)
	if not Player then return end
	local item = Player.Functions.GetItemByName(source, itemName)
	if not item then return false end
	item[key] = val
	Player.PlayerData.items[item.slot] = item
	Player.Functions.SetInventory(Player.PlayerData.items)
	return true
end exports('SetItemData', SetItemData)

function WipeStash(id)
	Stashes[id] = {}
	Stashes[id].items = {}
	SaveStashItems(id, Stashes[id].items)
end
exports("WipeStash", WipeStash)

exports('AddItem', function(source, item, amount, slot, info)
	local Player = QBCore.Functions.GetPlayer(source)
	if not Player then return false end
	return Player.Functions.AddItem(item, amount, slot, info)
end)

exports('RemoveItem', function(source, item, amount, slot)
	local Player = QBCore.Functions.GetPlayer(source)
	if not Player then return false end
	return Player.Functions.RemoveItem(item, amount, slot)
end)

exports('HasItem', function(source, item, amount)
	return QBCore.Functions.HasItem(source, item, amount)
end)

-- Trunk items
local function GetVehicleItems(plate)
	return Trunks[plate]
end exports('GetVehicleItems', GetVehicleItems)

local function GetOwnedVehicleItems(plate)
	local items = {}
	local result = MySQL.Sync.fetchScalar('SELECT items FROM trunkitems WHERE plate = ?', {plate})
	if result then
		local trunkItems = json.decode(result)
		if trunkItems then
			for k, item in pairs(trunkItems) do
				local itemInfo = QBCore.Shared.Items[item.name:lower()]
				if itemInfo then
					items[item.slot] = {
						name = itemInfo["name"],
						amount = tonumber(item.amount),
						info = item.info or {},
						label = itemInfo["label"],
						description = itemInfo["description"] or "",
						weight = item.weight or itemInfo["weight"],
						type = itemInfo["type"],
						unique = itemInfo["unique"],
						useable = itemInfo["useable"],
						image = GetImage(item.name, item.info),
						slot = item.slot,
					}
				end
			end
		end
	end
	return items
end exports('GetOwnedVehicleItems', GetOwnedVehicleItems)

local function SaveOwnedVehicleItems(plate, items)
	if Trunks[plate].label ~= "Trunk-None" then
		if items ~= nil then
			for slot, item in pairs(items) do
				item.description = nil
			end
			MySQL.Async.insert('INSERT INTO trunkitems (plate, items) VALUES (:plate, :items) ON DUPLICATE KEY UPDATE items = :items', {
				['plate'] = plate,
				['items'] = json.encode(items)
			})
			Trunks[plate].isOpen = false
		end
	end
end

local function AddToTrunk(plate, slot, otherslot, itemName, amount, info, weight)
	local amount = tonumber(amount)
	local ItemData = QBCore.Shared.Items[itemName]

	if not ItemData.unique then
		if Trunks[plate].items[slot] ~= nil and Trunks[plate].items[slot].name == itemName then
			Trunks[plate].items[slot].amount = Trunks[plate].items[slot].amount + amount
		else
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Trunks[plate].items[slot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info or {},
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = weight or itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = GetImage(itemName, info),
				slot = slot,
			}
		end
	else
		if Trunks[plate].items[slot] ~= nil and Trunks[plate].items[slot].name == itemName then
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Trunks[plate].items[otherslot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info or {},
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = weight or itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = GetImage(itemName, info),
				slot = otherslot,
			}
		else
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Trunks[plate].items[slot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info or "",
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = weight or itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = GetImage(itemName, info),
				slot = slot,
			}
		end
	end
end

local function RemoveFromTrunk(plate, slot, itemName, amount)
	if Trunks[plate].items[slot] ~= nil and Trunks[plate].items[slot].name == itemName then
		if Trunks[plate].items[slot].amount > amount then
			Trunks[plate].items[slot].amount = Trunks[plate].items[slot].amount - amount
		else
			Trunks[plate].items[slot] = nil
			if next(Trunks[plate].items) == nil then
				Trunks[plate].items = {}
			end
		end
	else
		Trunks[plate].items[slot]= nil
		if Trunks[plate].items == nil then
			Trunks[plate].items[slot] = nil
		end
	end
end

function addTrunkItems(plate, items)
	Trunks[plate] = {}
	Trunks[plate].label = "Trunk-"..plate
	Trunks[plate].items = items
end
exports('addTrunkItems', addTrunkItems)

-- Glovebox items
local function GetVehicleGloveboxItems(plate)
	return Gloveboxes[plate]
end exports('GetVehicleGloveboxItems', GetVehicleGloveboxItems)

local function GetOwnedVehicleGloveboxItems(plate)
	local items = {}
	local result = MySQL.Sync.fetchScalar('SELECT items FROM gloveboxitems WHERE plate = ?', {plate})
	if result then
		local gloveboxItems = json.decode(result)
		if gloveboxItems then
			for k, item in pairs(gloveboxItems) do
				local itemInfo = QBCore.Shared.Items[item.name:lower()]
				if itemInfo then
					items[item.slot] = {
						name = itemInfo["name"],
						amount = tonumber(item.amount),
						info = item.info or {},
						label = itemInfo["label"],
						description = itemInfo["description"] or "",
						weight = item.weight or itemInfo["weight"],
						type = itemInfo["type"],
						unique = itemInfo["unique"],
						useable = itemInfo["useable"],
						image = GetImage(item.name, item.info),
						slot = item.slot,
					}
				end
			end
		end
	end
	return items
end exports('GetOwnedVehicleGloveboxItems', GetOwnedVehicleGloveboxItems)

local function SaveOwnedGloveboxItems(plate, items)
	if Gloveboxes[plate].label ~= "Glovebox-None" then
		if items ~= nil then
			for slot, item in pairs(items) do
				item.description = nil
			end
			MySQL.Async.insert('INSERT INTO gloveboxitems (plate, items) VALUES (:plate, :items) ON DUPLICATE KEY UPDATE items = :items', {
				['plate'] = plate,
				['items'] = json.encode(items)
			})
			Gloveboxes[plate].isOpen = false
		end
	end
end

local function AddToGlovebox(plate, slot, otherslot, itemName, amount, info, weight)
	local amount = tonumber(amount)
	local ItemData = QBCore.Shared.Items[itemName]

	if not ItemData.unique then
		if Gloveboxes[plate].items[slot] ~= nil and Gloveboxes[plate].items[slot].name == itemName then
			Gloveboxes[plate].items[slot].amount = Gloveboxes[plate].items[slot].amount + amount
		else
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Gloveboxes[plate].items[slot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info or {},
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = weight or itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = GetImage(itemName, info),
				slot = slot,
			}
		end
	else
		if Gloveboxes[plate].items[slot] ~= nil and Gloveboxes[plate].items[slot].name == itemName then
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Gloveboxes[plate].items[otherslot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info or {},
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = weight or itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = GetImage(itemName, info),
				slot = otherslot,
			}
		else
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Gloveboxes[plate].items[slot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info or {},
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = weight or itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = GetImage(itemName, info),
				slot = slot,
			}
		end
	end
end

local function RemoveFromGlovebox(plate, slot, itemName, amount)
	if Gloveboxes[plate].items[slot] ~= nil and Gloveboxes[plate].items[slot].name == itemName then
		if Gloveboxes[plate].items[slot].amount > amount then
			Gloveboxes[plate].items[slot].amount = Gloveboxes[plate].items[slot].amount - amount
		else
			Gloveboxes[plate].items[slot] = nil
			if next(Gloveboxes[plate].items) == nil then
				Gloveboxes[plate].items = {}
			end
		end
	else
		Gloveboxes[plate].items[slot]= nil
		if Gloveboxes[plate].items == nil then
			Gloveboxes[plate].items[slot] = nil
		end
	end
end

-- Drop items

local function AddToDrop(dropId, slot, otherslot, itemName, amount, info, weight)
	local amount = tonumber(amount)
	local ItemData = QBCore.Shared.Items[itemName]
	if not ItemData.unique then
		if Drops[dropId].items[slot] and Drops[dropId].items[slot].name == itemName then
			Drops[dropId].items[slot].amount = Drops[dropId].items[slot].amount + amount
		else
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Drops[dropId].items[slot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info or {},
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = weight or itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = GetImage(itemName, info),
				slot = slot,
			}
		end
	else
		if Drops[dropId].items[slot] and Drops[dropId].items[slot].name == itemName then
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Drops[dropId].items[otherslot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info or {},
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = weight or itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = GetImage(itemName, info),
				slot = otherslot,
			}
		else
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Drops[dropId].items[slot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info or {},
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = weight or itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = GetImage(itemName, info),
				slot = slot,
			}
		end
	end
end

local function RemoveFromDrop(dropId, slot, itemName, amount)
	local amount = tonumber(amount)
	if Drops[dropId].items[slot] ~= nil and Drops[dropId].items[slot].name == itemName then
		if Drops[dropId].items[slot].amount > amount then
			Drops[dropId].items[slot].amount = Drops[dropId].items[slot].amount - amount
		else
			Drops[dropId].items[slot] = nil
			if next(Drops[dropId].items) == nil then
				Drops[dropId].items = {}
			end
		end
	else
		Drops[dropId].items[slot] = nil
		if Drops[dropId].items == nil then
			Drops[dropId].items[slot] = nil
		end
	end
end

local function CreateDropId(bsn)
	local id = math.random(10000, 99999)
	local dropid = tonumber(bsn..id)
	while Drops[dropid] ~= nil do
		id = math.random(10000, 99999)
		dropid = tonumber(bsn..id)
	end
	return dropid
end

local function CreateNewDrop(source, fromSlot, toSlot, itemAmount)
	local Player = QBCore.Functions.GetPlayer(source)
	local itemData = Player.Functions.GetItemBySlot(fromSlot)
	if Player.Functions.RemoveItem(itemData.name, itemAmount, itemData.slot) then
		TriggerClientEvent("inventory:client:CheckWeapon", source, itemData.slot)
		local itemInfo = QBCore.Shared.Items[itemData.name:lower()]
		local dropid = CreateDropId(Player.PlayerData.citizenid)
		NewDrops[source] = dropid
		Drops[dropid] = {}
		Drops[dropid].items = {}
		Drops[dropid].items[toSlot] = {
			name = itemInfo["name"],
			amount = itemAmount,
			info = itemData.info or {},
			label = itemInfo["label"],
			description = itemInfo["description"] or "",
			weight = itemData.weight or itemInfo["weight"],
			type = itemInfo["type"],
			unique = itemInfo["unique"],
			useable = itemInfo["useable"],
			image = GetImage(itemData.name, itemData.info),
			slot = toSlot
		}
		isdrop=true
		TriggerEvent("qb-smallresources:server:isdrop",source)
		TriggerEvent("qb-log:server:CreateLog", "drop", "New Item Drop", "red", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..source.."*) dropped new item; name: **"..itemData.name.."**, amount: **" .. itemAmount .. "**"..GenerateSerieText(itemData))
	else
		TriggerClientEvent("QBCore:Notify", source, "You don't have this item!", "error")
	end
end

local function ConvertQuality(item, currentTime)
	local StartDate = item.info.created
    local DecayRate = Config.Decays[item.name] or 0
    if DecayRate > 0 then
		local TimeExtra = math.ceil((60 * 60 * 24 * 1 * DecayRate))
		local percentDone = 100 - math.ceil((((currentTime - StartDate) / TimeExtra) * 100))
		if percentDone < 0 then
			percentDone = 0
		end
		return percentDone
	else
		return item.info.quality
	end
end

local function DecayItems(items)
	local currentTime = os.time()
	for _, item in pairs(items) do
		if Config.Decays[item.name] then
			if item.info then
				if type(item.info) ~= "table" then
					item.info = {}
				end
				if not item.info.created then
					item.info.created = currentTime
				end
				if not item.info.quality then
					item.info.quality = 100
				end
			else
				local info = {quality = 100, created = currentTime}
				item.info = info
			end
			item.info.quality = ConvertQuality(item, currentTime)
		end
	end
	return items
end

-- Events
RegisterNetEvent("inventory:server:breakItem", function(item, damage, slot)
	local src = source
	QBCore.Player.DecayItem(src, item, damage, slot)
end)

RegisterNetEvent('inventory:server:OpenInventory', function(name, id, other, newLabel, NoSave, cuffallow)
	local src = source
	local ply = Player(src)
	local Player = QBCore.Functions.GetPlayer(src)
	local newItems = DecayItems(Player.PlayerData.items)
	Player.Functions.SetInventory(newItems)
	if not ply.state.inv_busy then
		if name and id then
			local secondInv = {}
			if name == "stash" then
				if Stashes[id] then
					if Stashes[id].isOpen then
						local Target = QBCore.Functions.GetPlayer(Stashes[id].isOpen)
						if not Target then
							Stashes[id].isOpen = false
						end
					end
				end
				local maxweight = other and other.maxweight or 50000
				local slots = other and other.slots or 8
				secondInv.name = "stash-"..id
				secondInv.label = newLabel or "Stash"
				secondInv.maxweight = maxweight
				secondInv.inventory = {}
				secondInv.slots = slots
				if Stashes[id] and Stashes[id].isOpen then
					secondInv.name = "none-inv"
					secondInv.label = "None"
					secondInv.maxweight = 0
					secondInv.inventory = {}
					secondInv.slots = 0
				else
					local stashItems = GetStashItems(id)
					if next(stashItems) then
						secondInv.inventory = stashItems
						Stashes[id] = {}
						Stashes[id].items = stashItems
						Stashes[id].isOpen = src
						Stashes[id].label = secondInv.label
						Stashes[id].NoSave = NoSave
					else
						Stashes[id] = {}
						Stashes[id].items = {}
						Stashes[id].isOpen = src
						Stashes[id].label = secondInv.label
						Stashes[id].NoSave = NoSave
					end
				end
				TriggerClientEvent('inventory:client:setCurrentTarget', src, {type='stash',id=id})
			elseif name == "trunk" then
				local fakeplate = exports['qb-smallresources']:HasFakePlate(id)
				if fakeplate.bool then id = fakeplate.plate end
				if Trunks[id] then
					if Trunks[id].isOpen then
						local Target = QBCore.Functions.GetPlayer(Trunks[id].isOpen)
						if not Target then
							Trunks[id].isOpen = false
						end
					end
				end
				secondInv.name = "trunk-"..id
				secondInv.label = "Trunk"
				secondInv.maxweight = other.maxweight or 0
				secondInv.slots = other.slots or 0
				secondInv.inventory = {}
				if Trunks[id] and Trunks[id].isOpen then
					secondInv.name = "none-inv"
					secondInv.label = "None"
					secondInv.maxweight = 0
					secondInv.inventory = {}
					secondInv.slots = 0
				else
					if id then
						local ownedItems = GetOwnedVehicleItems(id)
						if IsVehicleOwned(id) and next(ownedItems) then
							secondInv.inventory = ownedItems
							Trunks[id] = {}
							Trunks[id].items = ownedItems
							Trunks[id].isOpen = src
							Trunks[id].label = secondInv.label
						elseif Trunks[id] and not Trunks[id].isOpen then
							secondInv.inventory = Trunks[id].items
							Trunks[id].isOpen = src
							Trunks[id].label = secondInv.label
						else
							Trunks[id] = {}
							Trunks[id].items = {}
							Trunks[id].isOpen = src
							Trunks[id].label = secondInv.label
						end
						TriggerClientEvent('inventory:client:setCurrentTarget', src, {type='trunk',id=id})
					end
				end
			elseif name == "glovebox" then
				local fakeplate = exports['qb-smallresources']:HasFakePlate(id)
				if fakeplate.bool then id = fakeplate.plate end
				if Gloveboxes[id] then
					if Gloveboxes[id].isOpen then
						local Target = QBCore.Functions.GetPlayer(Gloveboxes[id].isOpen)
						if not Target then
							Gloveboxes[id].isOpen = false
						end
					end
				end
				secondInv.name = "glovebox-"..id
				secondInv.label = "Glovebox"
				secondInv.maxweight = other and other.maxweight or 0
				secondInv.inventory = {}
				secondInv.slots = other and other.slots or 0
				if Gloveboxes[id] and Gloveboxes[id].isOpen then
					secondInv.name = "none-inv"
					secondInv.label = "None"
					secondInv.maxweight = 0
					secondInv.inventory = {}
					secondInv.slots = 0
				else
					local ownedItems = GetOwnedVehicleGloveboxItems(id)
					if Gloveboxes[id] and not Gloveboxes[id].isOpen then
						secondInv.inventory = Gloveboxes[id].items
						Gloveboxes[id].isOpen = src
						Gloveboxes[id].label = secondInv.label
					elseif IsVehicleOwned(id) and next(ownedItems) then
						secondInv.inventory = ownedItems
						Gloveboxes[id] = {}
						Gloveboxes[id].items = ownedItems
						Gloveboxes[id].isOpen = src
						Gloveboxes[id].label = secondInv.label
					else
						Gloveboxes[id] = {}
						Gloveboxes[id].items = {}
						Gloveboxes[id].isOpen = src
						Gloveboxes[id].label = secondInv.label
					end
					TriggerClientEvent('inventory:client:setCurrentTarget', src, {type='glovebox',id=id})
				end
			elseif name == "shop" then
				if ShopItems[id] then
					if ShopItems[id].isOpen then
						local Target = QBCore.Functions.GetPlayer(ShopItems[id].isOpen)
						if not Target then
							ShopItems[id].isOpen = false
						end
					end
				end
				if ShopItems[id] and not ShopItems[id].isOpen then
					secondInv.name = "itemshop-"..id
					secondInv.label = other.label
					secondInv.maxweight = 900000
					secondInv.inventory = SetupShopItems(id, other.items)
					ShopItems[id] = {}
					ShopItems[id].items = other.items
					ShopItems[id].isOpen = src
					secondInv.slots = #other.items
					TriggerClientEvent('inventory:client:setCurrentTarget', src, {type='shop',id=id})
				else
					secondInv.name = "none-inv"
					secondInv.label = "None"
					secondInv.maxweight = 100000
					secondInv.inventory = {}
					secondInv.slots = 0
				end
			elseif name == "otherplayer" then
				local OPOpen = false
				local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(id))
				if OtherPlayer then
					if Searchs[tonumber(id)] then
						local Target = QBCore.Functions.GetPlayer(Searchs[tonumber(id)])
						if not Target then
							Searchs[tonumber(id)] = nil
						end
					end
					if not Searchs[tonumber(id)] then
						secondInv.name = "otherplayer-"..id
						secondInv.label = "Player"
						secondInv.maxweight = QBCore.Config.Player.MaxWeight
						secondInv.inventory = ImageFormat(OtherPlayer.PlayerData.items)
						secondInv.slots = OtherPlayer.PlayerData.metadata.backpack and (QBCore.Config.Player.BackPackSlot + QBCore.Config.Player.MaxInvSlots) or QBCore.Config.Player.MaxInvSlots
						Searchs[tonumber(id)] = src
						TriggerClientEvent('inventory:client:setCurrentTarget', src, {type='player',id=tonumber(id)})
						OPOpen = true
					end
				end
				if not OPOpen then
					secondInv.name = "none-inv"
					secondInv.label = "None"
					secondInv.maxweight = 100000
					secondInv.inventory = {}
					secondInv.slots = 0
				end
			elseif name == "drop" then
				if Drops[id] then
					if Drops[id].isOpen then
						local Target = QBCore.Functions.GetPlayer(Drops[id].isOpen)
						if not Target then
							Drops[id].isOpen = false
						end
					end
				end
				if Drops[id] and not Drops[id].isOpen then
					secondInv.name = id
					secondInv.label = "Ground"
					secondInv.maxweight = 100000
					secondInv.inventory = Drops[id].items
					secondInv.slots = 15
					Drops[id].isOpen = src
					Drops[id].label = secondInv.label
					TriggerClientEvent('inventory:client:setCurrentTarget', src, {type='drop',id=id})
				else
					secondInv.name = "none-inv"
					secondInv.label = "None"
					secondInv.maxweight = 100000
					secondInv.inventory = {}
					secondInv.slots = 0
				end
			end
			if secondInv then
				secondInv.inventory = DecayItems(secondInv.inventory)
			end
			TriggerClientEvent("inventory:client:OpenInventory", src, ImageFormat(newItems), secondInv,cuffallow)
		else
			TriggerClientEvent("inventory:client:OpenInventory", src, ImageFormat(newItems),nil,cuffallow)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, 'Not Accessible', 'error')
	end
end)

AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
    TriggerClientEvent('qb-inventory:client:loadpickups', Player.PlayerData.source, PickUps, SoloPickUps, ThrownWeapons)
end)

RegisterNetEvent('inventory:server:SaveInventory', function(data)
	local src = source
	if not data or not data.type or not data.id then return end
	local type = data.type
	local id = data.id
	if type == "trunk" then
		if Trunks[id].isOpen and Trunks[id].isOpen == src then
			if IsVehicleOwned(id) then
				SaveOwnedVehicleItems(id, Trunks[id].items)
			else
				Trunks[id].isOpen = false
			end
		end
	elseif type == "glovebox" then
		if Gloveboxes[id].isOpen and Gloveboxes[id].isOpen == src then
			if (IsVehicleOwned(id)) then
				SaveOwnedGloveboxItems(id, Gloveboxes[id].items)
			else
				Gloveboxes[id].isOpen = false
			end
		end
	elseif type == "stash" then
		if Stashes[id].isOpen and Stashes[id].isOpen == src then
			SaveStashItems(id, Stashes[id].items)
		end
	elseif type == "player" then
		if Searchs[id] and Searchs[id] == src then
			Searchs[id] = nil
		end
	elseif type == "shop" then
		if ShopItems[id] and ShopItems[id].isOpen and ShopItems[id].isOpen == src then
			ShopItems[id] = nil
		end
	elseif type == "drop" then
		if Drops[id] and Drops[id].isOpen and Drops[id].isOpen == src then
			Drops[id].isOpen = false
			if Drops[id].items == nil or next(Drops[id].items) == nil then
				Drops[id] = nil
				PickUps[id] = nil
				TriggerClientEvent("qb-inventory:client:removepickup", -1, id)
			end
		end
	end
	TriggerEvent("av_scripts:inventorySaved", src, type, id)
end)

RegisterNetEvent('inventory:server:SaveDrop', function(coords)
	local src = source
	if NewDrops[src] then
		local dropid = NewDrops[src]
		NewDrops[src] = nil
		local SlotCount = 0
		for k,v in pairs(Drops[dropid].items) do
			SlotCount = SlotCount + 1
		end
		if SlotCount == 0 then
			Drops[dropid] = nil
		else
			PickUps[dropid] = coords
			TriggerClientEvent('qb-inventory:client:newpickup', -1, dropid, PickUps[dropid])
		end
	end
end)

RegisterNetEvent('qb-inventory:server:dropSoloItem', function(data)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local slot = data.item.slot
	if not slot then return end
    local coords = data.coords
	local heading = data.heading
    local item = Player.PlayerData.items[slot]
	local count = tonumber(data.amount)
	if not count or count <= 0 and count > item.amount then
		count = item.amount
	end
    if Player.Functions.RemoveItem(item.name, count, slot) then
        TriggerClientEvent('qb-inventory:client:pickupAnim', src)
		TriggerClientEvent("inventory:client:CheckWeapon", src, slot)
        SetTimeout(2000, function()
			local pickupId = PickupId + 1
			PickupId = pickupId
			local object = Config.Objects[item.name] or 'prop_paper_bag_01'
			SoloPickUps[pickupId] = {
				coords = coords,
				heading = heading,
				object = object,
				count = count,
				item = item
			}
			TriggerClientEvent('qb-inventory:client:dropSoloItem', -1, pickupId, object, coords, heading, item.label, count)
        end)
    end
end)

AddEventHandler('qb-inventory:system:dropSoloItem', function(data)
	local pickupId = PickupId + 1
	PickupId = pickupId
	local object = Config.Objects[data.item.name] or 'prop_paper_bag_01'
	SoloPickUps[pickupId] = {
		coords = data.coords,
		heading = data.heading,
		object = object,
		count = data.amount,
		item = data.item
	}
	TriggerClientEvent('qb-inventory:client:dropSoloItem', -1, pickupId, object, data.coords, data.heading, data.item.label, data.amount)
end)

RegisterNetEvent('qb-inventory:server:onPickUp', function(id)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local pickup = SoloPickUps[id]
	if pickup then
        if Player.Functions.AddItem(pickup.item.name, pickup.count, nil, pickup.item.info, pickup.item.weight, true) then
			SoloPickUps[id]	= nil
			TriggerClientEvent('qb-inventory:client:pickupAnim', src)
			TriggerClientEvent('qb-inventory:clinet:removeSoloPickup', -1, id)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[pickup.item.name], 'add', pickup.count, GetImage(pickup.item.name, pickup.item.info))
		else
			TriggerClientEvent('QBCore:Notify', src, 'You Do Not Have Enough Space!', 'error')
		end
	end
end)

RegisterNetEvent('qb-inventory:server:ThrowItem', function(vorodi)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local data = vorodi.data
    local slot = data.item.slot
	if not slot then return end
    local item = Player.PlayerData.items[slot]
	if not item then return end
	if QBCore.Shared.Items[item.name] and (Config.ThrowAllow[item.name] or QBCore.Shared.Items[item.name].type == 'weapon') then
		if Player.Functions.RemoveItem(item.name,vorodi.data.amount, slot) then
			item.amount=vorodi.data.amount
			WaitForCoordsThrow[vorodi.net_id] = {id = src, data = item}
		end
	end
end)

RegisterNetEvent('qb-inventory:server:ThrowSetCoords', function(id, coords)
	local src = source
    if WaitForCoordsThrow[id] and WaitForCoordsThrow[id].id == src then
		ThrownWeapons[id] = {data = WaitForCoordsThrow[id].data, coords = coords}
		TriggerClientEvent('qb-inventory:client:ThrowItem', -1, id, coords)
		WaitForCoordsThrow[id] = nil
	end
end)

RegisterNetEvent('qb-inventory:server:onThrowPickUp', function(id)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local throw = ThrownWeapons[id]
	if throw then
        if Player.Functions.AddItem(throw.data.name, throw.data.amount, nil, throw.data.info, throw.data.weight, true) then
			ThrownWeapons[id] = nil
			DeleteEntity(NetworkGetEntityFromNetworkId(id))
			TriggerClientEvent('qb-inventory:client:pickupAnim', src)
			TriggerClientEvent('qb-inventory:clinet:removeThrowPickup', -1, id)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[throw.data.name], 'add', 1, GetImage(throw.data.name, throw.data.info))
		else
			TriggerClientEvent('QBCore:Notify', src, 'You Do Not Have Enough Space!', 'error')
		end
	end
end)

RegisterNetEvent('inventory:server:UseItemSlot', function(slot)
	local src = source
	if not slot or slot > 5 then return end
	if Searchs[src] then
		local sTarget = QBCore.Functions.GetPlayer(Searchs[src])
		if not sTarget then
			Searchs[src] = nil
		end
	end
	if Searchs[src] then return end
	local Player = QBCore.Functions.GetPlayer(src)
	if not Player then return end
	local itemData = Player.Functions.GetItemBySlot(slot)
	if itemData then
		local itemInfo = QBCore.Shared.Items[itemData.name]
		if itemInfo then
			if itemData.type == "weapon" then
				if itemData.info.quality then
					if itemData.info.quality > 0 then
						TriggerClientEvent("inventory:client:UseWeapon", src, itemData)
					else
						TriggerClientEvent("QBCore:Notify", src, "You can't use this item", "error")
					end
				else
					TriggerClientEvent("inventory:client:UseWeapon", src, itemData)
				end
			elseif itemData.useable then
				if itemData.info.quality then
					if itemData.info.quality > 0 then
						QBCore.Functions.UseItem(src, itemData)
					else
						TriggerClientEvent("QBCore:Notify", src, "You can't use this item", "error")
					end
				else
					QBCore.Functions.UseItem(src, itemData)
				end
			end
		end
	end
end)

RegisterNetEvent('inventory:server:UseItem', function(inventory, item)
	local src = source
	if Searchs[src] then
		local sTarget = QBCore.Functions.GetPlayer(Searchs[src])
		if not sTarget then
			Searchs[src] = nil
		end
	end
	if Searchs[src] then return end
	local Player = QBCore.Functions.GetPlayer(src)
	if not Player then return end
	if inventory == "player" or inventory == "hotbar" then
		local itemData = Player.Functions.GetItemBySlot(item.slot)
		if itemData then
			if item.slot > QBCore.Config.Player.MaxInvSlots then return end
			local itemInfo = QBCore.Shared.Items[itemData.name]
			if itemInfo then
				if itemData.type ~= "weapon" or itemData.name == 'weapon_shoe' then
					if itemData.info.quality then
						if itemData.info.quality <= 0 then
							TriggerClientEvent("QBCore:Notify", src, "You can't use this item", "error")
							return
						end
					end
						
					QBCore.Functions.UseItem(src, itemData)

				end
			end
		end
	end
end)

RegisterNetEvent('inventory:server:RemoveClip', function(inventory, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if inventory == "player" or inventory == "hotbar" then
		local itemData = Player.Functions.GetItemBySlot(item.slot)
		if itemData then
			if item.slot > QBCore.Config.Player.MaxInvSlots then return end
			local itemInfo = QBCore.Shared.Items[itemData.name]
			if itemInfo then
				if itemData.type == "weapon" then
					local myInv = Player.PlayerData.items
					if myInv[item.slot].info.clip then
						local ammo = myInv[item.slot].info.ammo
						local clip = myInv[item.slot].info.clip
						myInv[item.slot].info.clip = false
						myInv[item.slot].info.ammo = 0
						Player.Functions.SetInventory(myInv)
						TriggerClientEvent('qb-inventory:client:removeClip', src, item.slot)
						Wait(100)
						Player.Functions.AddItem(clip, 1, nil, {ammo=ammo}, nil, true)
						TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[clip], 'add')
					else
						TriggerClientEvent("QBCore:Notify", src, "Your weapon does not have any clip!", "error")
					end
				end
			end
		end
	end
end)

RegisterNetEvent('inventory:server:SetInventoryData', function(fromInventory, toInventory, fromSlot, toSlot, fromAmount, toAmount)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	fromSlot = tonumber(fromSlot)
	toSlot = tonumber(toSlot)

	if (fromInventory == "player" or fromInventory == "hotbar") and QBCore.Shared.SplitStr(toInventory, "-")[1] == "itemshop" then
		return
	end
	if QBCore.Shared.SplitStr(fromInventory, "-")[1] == "itemshop" and QBCore.Shared.SplitStr(toInventory, "-")[1] == "itemshop" then
		return
	end

	if fromInventory == "player" or fromInventory == "hotbar" then
		local fromItemData = Player.Functions.GetItemBySlot(fromSlot)
		local fromAmount = tonumber(fromAmount) ~= nil and tonumber(fromAmount) or fromItemData.amount
		if fromItemData ~= nil and fromItemData.amount >= fromAmount then
			if toInventory == "player" or toInventory == "hotbar" then
				local MyOldInventory = Player.PlayerData.items
				local toItemData = Player.Functions.GetItemBySlot(toSlot)
				if Player.Functions.RemoveItem(fromItemData.name, fromAmount, fromSlot) then
					TriggerClientEvent("inventory:client:CheckWeapon", src, fromSlot)
					if toItemData ~= nil then
						local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
						if toItemData.name ~= fromItemData.name then
							Player.Functions.RemoveItem(toItemData.name, toAmount, toSlot)
							Player.Functions.AddItem(toItemData.name, toAmount, fromSlot, toItemData.info, toItemData.weight)
						end
					end
					if not Player.Functions.AddItem(fromItemData.name, fromAmount, toSlot, fromItemData.info, fromItemData.weight) then
						Player.Functions.SetInventory(MyOldInventory)
					end
				end
			elseif QBCore.Shared.SplitStr(toInventory, "-")[1] == "otherplayer" then
				local playerId = tonumber(QBCore.Shared.SplitStr(toInventory, "-")[2])
				local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
				if OtherPlayer then
					local MyOldInventory = Player.PlayerData.items
					local TargetOldInventory = OtherPlayer.PlayerData.items
					local toItemData = OtherPlayer.Functions.GetItemBySlot(toSlot)
					if Player.Functions.RemoveItem(fromItemData.name, fromAmount, fromSlot) then
						TriggerClientEvent("inventory:client:CheckWeapon", src, fromSlot)
						if toItemData ~= nil then
							local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
							local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
							if toItemData.name ~= fromItemData.name then
								OtherPlayer.Functions.RemoveItem(itemInfo["name"], toAmount, fromSlot)
								Player.Functions.AddItem(toItemData.name, toAmount, fromSlot, toItemData.info, toItemData.weight)
								TriggerEvent("qb-log:server:CreateLog", "robbing", "Swapped Item", "orange", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | *"..src.."*) swapped item; name: **"..itemInfo["name"].."**, amount: **" .. toAmount .. "** "..GenerateSerieText(toItemData).."with name: **" .. fromItemData.name .. "**, amount: **" .. fromAmount.. "** "..GenerateSerieText(fromItemData).."with player: **".. OtherPlayer.PlayerData.charinfo.firstname..' '..OtherPlayer.PlayerData.charinfo.lastname .. "** (citizenid: *"..OtherPlayer.PlayerData.citizenid.."* | id: *"..OtherPlayer.PlayerData.source.."*)")
							end
						else
							local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
							TriggerEvent("qb-smallresources:server:isdrop")
							TriggerEvent("qb-log:server:CreateLog", "robbing", "Dropped Item", "red", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | *"..src.."*) dropped new item; name: **"..itemInfo["name"].."**, amount: **" .. fromAmount .. "** "..GenerateSerieText(fromItemData).."to player: **".. OtherPlayer.PlayerData.charinfo.firstname..' '..OtherPlayer.PlayerData.charinfo.lastname .. "** (citizenid: *"..OtherPlayer.PlayerData.citizenid.."* | id: *"..OtherPlayer.PlayerData.source.."*)")
						end
						local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
						if OtherPlayer.Functions.AddItem(itemInfo["name"], fromAmount, toSlot, fromItemData.info, fromItemData.weight) then
							TriggerClientEvent('inventory:client:ItemBox', playerId, itemInfo, 'add', fromAmount)
						else
							Player.Functions.SetInventory(MyOldInventory)
							OtherPlayer.Functions.SetInventory(TargetOldInventory)
						end
					end
				end
			elseif QBCore.Shared.SplitStr(toInventory, "-")[1] == "trunk" then
				local plate = QBCore.Shared.SplitStr(toInventory, "-")[2]
				local toItemData = Trunks[plate].items[toSlot]
				local MyOldInventory = Player.PlayerData.items
				local TargetOldInventory = Trunks[plate].items
				local Done = false
				if Player.Functions.RemoveItem(fromItemData.name, fromAmount, fromSlot) then
					TriggerClientEvent("inventory:client:CheckWeapon", src, fromSlot)
					if toItemData ~= nil then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
						if toItemData.name ~= fromItemData.name then
							RemoveFromTrunk(plate, fromSlot, itemInfo["name"], toAmount)
							if Player.Functions.AddItem(toItemData.name, toAmount, fromSlot, toItemData.info, toItemData.weight) then
								Done = true
								TriggerEvent("qb-log:server:CreateLog", "trunk", "Swapped Item", "orange", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) swapped item; name: **"..itemInfo["name"].."**, amount: **" .. toAmount .. "** "..GenerateSerieText(toItemData).."with name: **" .. fromItemData.name .. "**, amount: **" .. fromAmount .. "** "..GenerateSerieText(fromItemData).."- plate: *" .. plate .. "*")
							end
						end
					else
						Done = true
						local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
						TriggerEvent("qb-smallresources:server:isdrop")
						TriggerEvent("qb-log:server:CreateLog", "trunk", "Dropped Item", "red", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) dropped new item; name: **"..itemInfo["name"].."**, amount: **" .. fromAmount .. "** "..GenerateSerieText(fromItemData).."- plate: *" .. plate .. "*")
					end
					if Done then
						local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
						AddToTrunk(plate, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info, fromItemData.weight)
					else
						Player.Functions.SetInventory(MyOldInventory)
						Trunks[plate].items = TargetOldInventory
					end
				end
			elseif QBCore.Shared.SplitStr(toInventory, "-")[1] == "glovebox" then
				local plate = QBCore.Shared.SplitStr(toInventory, "-")[2]
				local toItemData = Gloveboxes[plate].items[toSlot]
				local MyOldInventory = Player.PlayerData.items
				local TargetOldInventory = Gloveboxes[plate].items
				local Done = false
				if Player.Functions.RemoveItem(fromItemData.name, fromAmount, fromSlot) then
					TriggerClientEvent("inventory:client:CheckWeapon", src, fromSlot)
					if toItemData ~= nil then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
						if toItemData.name ~= fromItemData.name then
							RemoveFromGlovebox(plate, fromSlot, itemInfo["name"], toAmount)
							if Player.Functions.AddItem(toItemData.name, toAmount, fromSlot, toItemData.info, toItemData.weight) then
								Done = true
								TriggerEvent("qb-log:server:CreateLog", "glovebox", "Swapped Item", "orange", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) swapped item; name: **"..itemInfo["name"].."**, amount: **" .. toAmount .. "** "..GenerateSerieText(toItemData).."with name: **" .. fromItemData.name .. "**, amount: **" .. fromAmount .. "** "..GenerateSerieText(fromItemData).."- plate: *" .. plate .. "*")
							end
						end
					else
						Done = true
						local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
						TriggerEvent("qb-smallresources:server:isdrop")
						TriggerEvent("qb-log:server:CreateLog", "glovebox", "Dropped Item", "red", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) dropped new item; name: **"..itemInfo["name"].."**, amount: **" .. fromAmount .. "** "..GenerateSerieText(fromItemData).."- plate: *" .. plate .. "*")
					end
					if Done then
						local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
						AddToGlovebox(plate, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info, fromItemData.weight)
					else
						Player.Functions.SetInventory(MyOldInventory)
						Gloveboxes[plate].items = TargetOldInventory
					end
				end
			elseif QBCore.Shared.SplitStr(toInventory, "-")[1] == "stash" then
				local stashId = QBCore.Shared.SplitStr(toInventory, "-")[2]
				local toItemData = Stashes[stashId].items[toSlot]
				local policeEvd = false
				if string.find(stashId, 'PoliceEvidence_') then
					policeEvd = string.gsub(stashId, 'PoliceEvidence_', '')
				end
				local MyOldInventory = Player.PlayerData.items
				local TargetOldInventory = Stashes[stashId].items
				local Done = false
				if Player.Functions.RemoveItem(fromItemData.name, fromAmount, fromSlot) then
					TriggerClientEvent("inventory:client:CheckWeapon", src, fromSlot)
					if toItemData ~= nil then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
						if toItemData.name ~= fromItemData.name then
							RemoveFromStash(stashId, toSlot, itemInfo["name"], toAmount)
							if Player.Functions.AddItem(toItemData.name, toAmount, fromSlot, toItemData.info, toItemData.weight) then
								Done = true
								TriggerEvent("qb-log:server:CreateLog", "stash", "Swapped Item", "orange", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) swapped item; name: **"..itemInfo["name"].."**, amount: **" .. toAmount .. "** "..GenerateSerieText(toItemData).."with name: **" .. fromItemData.name .. "**, amount: **" .. fromAmount .. "** "..GenerateSerieText(fromItemData).."- stash: *" .. stashId .. "*")
								if policeEvd then
									TriggerEvent("qb-log:server:CreateLog", "pdevidence", "Swapped Item", "orange", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** swapped item; name: **"..itemInfo["name"].."**, amount: **" .. toAmount .. "** "..GenerateSerieText(toItemData).."with name: **" .. fromItemData.name .. "**, amount: **" .. fromAmount .. "** "..GenerateSerieText(fromItemData).."- stash: *" .. policeEvd .. "*")
								end
							end
						end
					else
						Done = true
						local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
						TriggerEvent("qb-smallresources:server:isdrop")
						TriggerEvent("qb-log:server:CreateLog", "stash", "Dropped Item", "red", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) dropped new item; name: **"..itemInfo["name"].."**, amount: **" .. fromAmount .. "** "..GenerateSerieText(fromItemData).."- stash: *" .. stashId .. "*")
						if policeEvd then
							TriggerEvent("qb-log:server:CreateLog", "pdevidence", "Dropped Item", "red", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** dropped new item; name: **"..itemInfo["name"].."**, amount: **" .. fromAmount .. "** "..GenerateSerieText(fromItemData).."- stash: *" .. policeEvd .. "*")
						end
					end
					if Done then
						local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
						AddToStash(stashId, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info, fromItemData.weight)
					else
						Player.Functions.SetInventory(MyOldInventory)
						Stashes[stashId].items = TargetOldInventory
					end
				end
			else
				-- drop
				toInventory = tonumber(toInventory)
				if toInventory == nil or toInventory == 0 and not NewDrops[src] then
					CreateNewDrop(src, fromSlot, toSlot, fromAmount)
				else
					if toInventory == nil or toInventory == 0 then
						toInventory = NewDrops[src]
					end
					local toItemData = Drops[toInventory].items[toSlot]
					local MyOldInventory = Player.PlayerData.items
					local TargetOldInventory = Drops[toInventory].items
					local Done = false
					if Player.Functions.RemoveItem(fromItemData.name, fromAmount, fromSlot) then
						TriggerClientEvent("inventory:client:CheckWeapon", src, fromSlot)
						if toItemData ~= nil then
							local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
							local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
							if toItemData.name ~= fromItemData.name then
								RemoveFromDrop(toInventory, toSlot, itemInfo["name"], toAmount)
								if Player.Functions.AddItem(toItemData.name, toAmount, fromSlot, toItemData.info, toItemData.weight) then
									Done = true
									TriggerEvent("qb-log:server:CreateLog", "drop", "Swapped Item", "orange", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) swapped item; name: **"..itemInfo["name"].."**, amount: **" .. toAmount .. "** "..GenerateSerieText(toItemData).."with name: **" .. fromItemData.name .. "**, amount: **" .. fromAmount .. "** "..GenerateSerieText(fromItemData).."- dropid: *" .. toInventory .. "*")
								end
							end
						else
							Done = true
							local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
							TriggerEvent("qb-smallresources:server:isdrop")
							TriggerEvent("qb-log:server:CreateLog", "drop", "Dropped Item", "red", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) dropped new item; name: **"..itemInfo["name"].."**, amount: **" .. fromAmount .. "** "..GenerateSerieText(fromItemData).."- dropid: *" .. toInventory .. "*")
						end
						if Done then
							local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
							AddToDrop(toInventory, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info, fromItemData.weight)
						else
							Player.Functions.SetInventory(MyOldInventory)
							Drops[toInventory].items = TargetOldInventory
						end
					end
				end
			end
		else
			TriggerClientEvent("QBCore:Notify", src, "You don\'t have this item!", "error")
		end
	elseif QBCore.Shared.SplitStr(fromInventory, "-")[1] == "otherplayer" then
		local playerId = tonumber(QBCore.Shared.SplitStr(fromInventory, "-")[2])
		local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
		if OtherPlayer then
			local fromItemData = OtherPlayer.Functions.GetItemBySlot(fromSlot)
			local fromAmount = tonumber(fromAmount) ~= nil and tonumber(fromAmount) or fromItemData.amount
			if fromItemData ~= nil and fromItemData.amount >= fromAmount then
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				if toInventory == "player" or toInventory == "hotbar" then
					local toItemData = Player.Functions.GetItemBySlot(toSlot)
					local MyOldInventory = OtherPlayer.PlayerData.items
					local TargetOldInventory = Player.PlayerData.items
					if OtherPlayer.Functions.RemoveItem(itemInfo["name"], fromAmount, fromSlot) then
						TriggerClientEvent("inventory:client:CheckWeapon", OtherPlayer.PlayerData.source, fromSlot)
						if toItemData ~= nil then
							local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
							local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
							if toItemData.name ~= fromItemData.name then
								Player.Functions.RemoveItem(toItemData.name, toAmount, toSlot)
								OtherPlayer.Functions.AddItem(itemInfo["name"], toAmount, fromSlot, toItemData.info, toItemData.weight)
								TriggerEvent("qb-log:server:CreateLog", "robbing", "Swapped Item", "orange", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) swapped item; name: **"..toItemData.name.."**, amount: **" .. toAmount .. "** "..GenerateSerieText(toItemData).."with item; **"..fromItemData.name.."**, amount: **" .. fromAmount .. "** "..GenerateSerieText(fromItemData).."from player: **".. OtherPlayer.PlayerData.charinfo.firstname..' '..OtherPlayer.PlayerData.charinfo.lastname .. "** (citizenid: *"..OtherPlayer.PlayerData.citizenid.."* | *"..OtherPlayer.PlayerData.source.."*)")
							else
								TriggerEvent("qb-log:server:CreateLog", "robbing", "Stacked Item", "orange", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) stacked item; name: **"..toItemData.name.."**, amount: **" .. fromAmount .. "** from player: **".. OtherPlayer.PlayerData.charinfo.firstname..' '..OtherPlayer.PlayerData.charinfo.lastname .. "** (citizenid: *"..OtherPlayer.PlayerData.citizenid.."* | *"..OtherPlayer.PlayerData.source.."*)")
							end
						else
							TriggerEvent("qb-log:server:CreateLog", "robbing", "Retrieved Item", "green", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) took item; name: **"..fromItemData.name.."**, amount: **" .. fromAmount .. "** "..GenerateSerieText(fromItemData).."from player: **".. OtherPlayer.PlayerData.charinfo.firstname..' '..OtherPlayer.PlayerData.charinfo.lastname .. "** (citizenid: *"..OtherPlayer.PlayerData.citizenid.."* | *"..OtherPlayer.PlayerData.source.."*)")
						end
						if Player.Functions.AddItem(fromItemData.name, fromAmount, toSlot, fromItemData.info, fromItemData.weight) then
							TriggerClientEvent('inventory:client:ItemBox', playerId, itemInfo, 'remove', fromAmount)
						else
							Player.Functions.SetInventory(TargetOldInventory)
							OtherPlayer.Functions.SetInventory(MyOldInventory)
						end
					end
				else
					local toItemData = OtherPlayer.PlayerData.items[toSlot]
					local MyOldInventory = OtherPlayer.PlayerData.items
					if OtherPlayer.Functions.RemoveItem(itemInfo["name"], fromAmount, fromSlot) then
						if toItemData ~= nil then
							local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
							local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
							if toItemData.name ~= fromItemData.name then
								local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
								OtherPlayer.Functions.RemoveItem(itemInfo["name"], toAmount, toSlot)
								OtherPlayer.Functions.AddItem(itemInfo["name"], toAmount, fromSlot, toItemData.info, toItemData.weight)
							end
						end
						local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
						if not OtherPlayer.Functions.AddItem(itemInfo["name"], fromAmount, toSlot, fromItemData.info, fromItemData.weight) then
							OtherPlayer.Functions.SetInventory(MyOldInventory)
						end
					end
				end
			else
				TriggerClientEvent("QBCore:Notify", src, "Item doesn\'t exist??", "error")
			end
		end
	elseif QBCore.Shared.SplitStr(fromInventory, "-")[1] == "trunk" then
		local plate = QBCore.Shared.SplitStr(fromInventory, "-")[2]
		local fromItemData = Trunks[plate].items[fromSlot]
		local fromAmount = tonumber(fromAmount) ~= nil and tonumber(fromAmount) or fromItemData.amount
		if fromItemData ~= nil and fromItemData.amount >= fromAmount then
			local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = Player.Functions.GetItemBySlot(toSlot)
				local MyOldInventory = Trunks[plate].items
				local TargetOldInventory = Player.PlayerData.items
				RemoveFromTrunk(plate, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						Player.Functions.RemoveItem(toItemData.name, toAmount, toSlot)
						AddToTrunk(plate, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info, toItemData.weight)
						TriggerEvent("qb-log:server:CreateLog", "trunk", "Swapped Item", "orange", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) swapped item; name: **"..toItemData.name.."**, amount: **" .. toAmount .. "** "..GenerateSerieText(toItemData).."with item; name: **"..fromItemData.name.."**, amount: **" .. fromAmount .. "** "..GenerateSerieText(fromItemData).."-plate: *" .. plate .. "*")
					else
						TriggerEvent("qb-log:server:CreateLog", "trunk", "Stacked Item", "orange", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) stacked item; name: **"..toItemData.name.."**, amount: **" .. fromAmount .. "** from plate: *" .. plate .. "*")
					end
				else
					TriggerEvent("qb-log:server:CreateLog", "trunk", "Received Item", "green", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) received item; name: **"..fromItemData.name.."**, amount: **" .. fromAmount.. "** "..GenerateSerieText(fromItemData).."-plate: *" .. plate .. "*")
				end
				if not Player.Functions.AddItem(fromItemData.name, fromAmount, toSlot, fromItemData.info, fromItemData.weight) then
					Player.Functions.SetInventory(TargetOldInventory)
					Trunks[plate].items = MyOldInventory
				end
			else
				local toItemData = Trunks[plate].items[toSlot]
				RemoveFromTrunk(plate, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						RemoveFromTrunk(plate, toSlot, itemInfo["name"], toAmount)
						AddToTrunk(plate, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info, toItemData.weight)
					end
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				AddToTrunk(plate, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info, fromItemData.weight)
			end
		else
			TriggerClientEvent("QBCore:Notify", src, "Item doesn\'t exist??", "error")
		end
	elseif QBCore.Shared.SplitStr(fromInventory, "-")[1] == "glovebox" then
		local plate = QBCore.Shared.SplitStr(fromInventory, "-")[2]
		local fromItemData = Gloveboxes[plate].items[fromSlot]
		local fromAmount = tonumber(fromAmount) ~= nil and tonumber(fromAmount) or fromItemData.amount
		if fromItemData ~= nil and fromItemData.amount >= fromAmount then
			local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = Player.Functions.GetItemBySlot(toSlot)
				local MyOldInventory = Gloveboxes[plate].items
				local TargetOldInventory = Player.PlayerData.items
				RemoveFromGlovebox(plate, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						Player.Functions.RemoveItem(toItemData.name, toAmount, toSlot)
						AddToGlovebox(plate, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info, toItemData.weight)
						TriggerEvent("qb-log:server:CreateLog", "glovebox", "Swapped", "orange", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src..")* swapped item; name: **"..toItemData.name.."**, amount: **" .. toAmount .. "** "..GenerateSerieText(toItemData).."with item; name: **"..fromItemData.name.."**, amount: **" .. fromAmount .. "** "..GenerateSerieText(fromItemData).."-plate: *" .. plate .. "*")
					else
						TriggerEvent("qb-log:server:CreateLog", "glovebox", "Stacked Item", "orange", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) stacked item; name: **"..toItemData.name.."**, amount: **" .. fromAmount .. "** from plate: *" .. plate .. "*")
					end
				else
					TriggerEvent("qb-log:server:CreateLog", "glovebox", "Received Item", "green", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) received item; name: **"..fromItemData.name.."**, amount: **" .. fromAmount.. "** "..GenerateSerieText(fromItemData).."-plate: *" .. plate .. "*")
				end
				if not Player.Functions.AddItem(fromItemData.name, fromAmount, toSlot, fromItemData.info, fromItemData.weight) then
					Player.Functions.SetInventory(TargetOldInventory)
					Gloveboxes[plate].items = MyOldInventory
				end
			else
				local toItemData = Gloveboxes[plate].items[toSlot]
				RemoveFromGlovebox(plate, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						RemoveFromGlovebox(plate, toSlot, itemInfo["name"], toAmount)
						AddToGlovebox(plate, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info, toItemData.weight)

					end
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				AddToGlovebox(plate, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info, fromItemData.weight)
			end
		else
			TriggerClientEvent("QBCore:Notify", src, "Item doesn\'t exist??", "error")
		end
	elseif QBCore.Shared.SplitStr(fromInventory, "-")[1] == "stash" then
		local stashId = QBCore.Shared.SplitStr(fromInventory, "-")[2]
		local fromItemData = Stashes[stashId].items[fromSlot]
		local fromAmount = tonumber(fromAmount) ~= nil and tonumber(fromAmount) or fromItemData.amount
		local policeEvd = false
		if string.find(stashId, 'PoliceEvidence_') then
			policeEvd = string.gsub(stashId, 'PoliceEvidence_', '')
		end
		if fromItemData ~= nil and fromItemData.amount >= fromAmount then
			local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = Player.Functions.GetItemBySlot(toSlot)
				local MyOldInventory = Stashes[stashId].items
				local TargetOldInventory = Player.PlayerData.items
				RemoveFromStash(stashId, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						Player.Functions.RemoveItem(toItemData.name, toAmount, toSlot)
						AddToStash(stashId, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info, toItemData.weight)
						TriggerEvent("qb-log:server:CreateLog", "stash", "Swapped Item", "orange", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) swapped item; name: **"..toItemData.name.."**, amount: **" .. toAmount .. "** "..GenerateSerieText(toItemData).."with item; name: **"..fromItemData.name.."**, amount: **" .. fromAmount .. "** "..GenerateSerieText(fromItemData).."-stash: *" .. stashId .. "*")
						if policeEvd then
							TriggerEvent("qb-log:server:CreateLog", "pdevidence", "Swapped Item", "orange", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** swapped item; name: **"..toItemData.name.."**, amount: **" .. toAmount .. "** "..GenerateSerieText(toItemData).."with item; name: **"..fromItemData.name.."**, amount: **" .. fromAmount .. "** "..GenerateSerieText(fromItemData).."-stash: *" .. policeEvd .. "*")
						end
					else
						TriggerEvent("qb-log:server:CreateLog", "stash", "Stacked Item", "orange", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) stacked item; name: **"..toItemData.name.."**, amount: **" .. fromAmount .. "** from stash: *" .. stashId .. "*")
						if policeEvd then
							TriggerEvent("qb-log:server:CreateLog", "pdevidence", "Stacked Item", "orange", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** stacked item; name: **"..toItemData.name.."**, amount: **" .. fromAmount .. "** from stash: *" .. policeEvd .. "*")
						end
					end
				else
					TriggerEvent("qb-log:server:CreateLog", "stash", "Received Item", "green", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) received item; name: **"..fromItemData.name.."**, amount: **" .. fromAmount.. "** "..GenerateSerieText(fromItemData).."-stash: *" .. stashId .. "*")
					if policeEvd then
						TriggerEvent("qb-log:server:CreateLog", "pdevidence", "Received Item", "green", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** received item; name: **"..fromItemData.name.."**, amount: **" .. fromAmount.. "** "..GenerateSerieText(fromItemData).."-stash: *" .. policeEvd .. "*")
					end
				end
				if not Player.Functions.AddItem(fromItemData.name, fromAmount, toSlot, fromItemData.info, fromItemData.weight) then
					Player.Functions.SetInventory(TargetOldInventory)
					Stashes[stashId].items = MyOldInventory
				end
			else
				local toItemData = Stashes[stashId].items[toSlot]
				RemoveFromStash(stashId, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						RemoveFromStash(stashId, toSlot, itemInfo["name"], toAmount)
						AddToStash(stashId, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info, toItemData.weight)
					end
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				AddToStash(stashId, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info, fromItemData.weight)
			end
		else
			TriggerClientEvent("QBCore:Notify", src, "Item doesn\'t exist??", "error")
		end
	elseif QBCore.Shared.SplitStr(fromInventory, "-")[1] == "itemshop" then
		local shopType = QBCore.Shared.SplitStr(fromInventory, "-")[2]
		local itemData = ShopItems[shopType].items[fromSlot]
		local itemInfo = QBCore.Shared.Items[itemData.name:lower()]
		local bankBalance = Player.PlayerData.money["bank"]
		local price = tonumber((itemData.price*fromAmount))

		if Player.Functions.RemoveMoney("cash", price, "unkown-itemshop-bought-item") then
			Player.Functions.AddItem(itemData.name, fromAmount, toSlot, itemData.info)
			TriggerClientEvent('QBCore:Notify', src, itemInfo["label"] .. " bought!", "success")
			if string.find(shopType, 'policearmory') then
				TriggerEvent("qb-log:server:CreateLog", "pdarmory", "Shop item bought", "green", "**"..Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname .. "** bought a " .. itemInfo["label"] .. " for $"..price..GenerateSerieText(itemData))
			elseif string.find(shopType, 'justicearmory') then
				TriggerEvent("qb-log:server:CreateLog", "dojarmory", "Shop item bought", "green", "**"..Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname .. "** bought a " .. itemInfo["label"] .. " for $"..price..GenerateSerieText(itemData))
			elseif string.find(shopType, 'hospital') then
				TriggerEvent("qb-log:server:CreateLog", "mdarmory", "Shop item bought", "green", "**"..Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname .. "** bought a " .. itemInfo["label"] .. " for $"..price..GenerateSerieText(itemData))
			else
				TriggerEvent("qb-log:server:CreateLog", "shops", "Shop item bought", "green", "**"..Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** bought a " .. itemInfo["label"] .. " for $"..price..GenerateSerieText(itemData))
			end
		elseif bankBalance >= price then
			Player.Functions.RemoveMoney("bank", price, "unkown-itemshop-bought-item")
			Player.Functions.AddItem(itemData.name, fromAmount, toSlot, itemData.info)
			TriggerClientEvent('QBCore:Notify', src, itemInfo["label"] .. " bought!", "success")
			if string.find(shopType, 'policearmory') then
				TriggerEvent("qb-log:server:CreateLog", "pdarmory", "Shop item bought", "green", "**"..Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname.. "** bought a " .. itemInfo["label"] .. " for $"..price..GenerateSerieText(itemData))
			elseif string.find(shopType, 'justicearmory') then
				TriggerEvent("qb-log:server:CreateLog", "dojarmory", "Shop item bought", "green", "**"..Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname.. "** bought a " .. itemInfo["label"] .. " for $"..price..GenerateSerieText(itemData))
			elseif string.find(shopType, 'hospital') then
				TriggerEvent("qb-log:server:CreateLog", "mdarmory", "Shop item bought", "green", "**"..Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname .. "** bought a " .. itemInfo["label"] .. " for $"..price..GenerateSerieText(itemData))
			else
				TriggerEvent("qb-log:server:CreateLog", "shops", "Shop item bought", "green", "**"..Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** bought a " .. itemInfo["label"] .. " for $"..price..GenerateSerieText(itemData))
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "You don\'t have enough cash..", "error")
		end
	else
		-- drop
		if fromInventory == nil or fromInventory == 0 then
			fromInventory = NewDrops[src]
		end
		if not fromInventory then return end
		fromInventory = tonumber(fromInventory)
		local fromItemData = Drops[fromInventory].items[fromSlot]
		local fromAmount = tonumber(fromAmount) ~= nil and tonumber(fromAmount) or fromItemData.amount
		if fromItemData ~= nil and fromItemData.amount >= fromAmount then
			local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = Player.Functions.GetItemBySlot(toSlot)
				local MyOldInventory = Drops[fromInventory].items
				local TargetOldInventory = Player.PlayerData.items
				RemoveFromDrop(fromInventory, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						Player.Functions.RemoveItem(toItemData.name, toAmount, toSlot)
						AddToDrop(fromInventory, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info, toItemData.weight)
						TriggerEvent("qb-log:server:CreateLog", "drop", "Swapped Item", "orange", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) swapped item; name: **"..toItemData.name.."**, amount: **" .. toAmount .. "** "..GenerateSerieText(toItemData).."with item; name: **"..fromItemData.name.."**, amount: **" .. fromAmount .. "** "..GenerateSerieText(fromItemData).."-dropid: *" .. fromInventory .. "*")
					else
						TriggerEvent("qb-log:server:CreateLog", "drop", "Stacked Item", "orange", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) stacked item; name: **"..toItemData.name.."**, amount: **" .. fromAmount .. "** - from dropid: *" .. fromInventory .. "*")
					end
				else
					TriggerEvent("qb-log:server:CreateLog", "drop", "Received Item", "green", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) received item; name: **"..fromItemData.name.."**, amount: **" .. fromAmount.. "** "..GenerateSerieText(fromItemData).."-dropid: *" .. fromInventory .. "*")
				end
				if not Player.Functions.AddItem(fromItemData.name, fromAmount, toSlot, fromItemData.info, fromItemData.weight) then
					Player.Functions.SetInventory(TargetOldInventory)
					Drops[fromInventory].items = MyOldInventory
				end
			else
				local toItemData = Drops[fromInventory].items[toSlot]
				RemoveFromDrop(fromInventory, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						RemoveFromDrop(fromInventory, toSlot, itemInfo["name"], toAmount)
						AddToDrop(fromInventory, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info, toItemData.weight)
					end
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				AddToDrop(fromInventory, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info, fromItemData.weight)
			end
		else
			TriggerClientEvent("QBCore:Notify", src, "Item doesn't exist??", "error")
		end
	end
end)

RegisterNetEvent('qb-inventory:server:useBackPack', function(slot)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
	if Searchs[src] then
		local sTarget = QBCore.Functions.GetPlayer(Searchs[src])
		if not sTarget then
			Searchs[src] = nil
		end
	end
	if Searchs[src] then return end
	if not Player.PlayerData.metadata.backpack then
		local itemData = Player.Functions.GetItemBySlot(slot)
		if Player.Functions.RemoveItem('backpack', 1, slot) then
			for k,v in pairs(itemData.info.items) do
				Player.Functions.AddItem(v.name, v.amount, v.slot, v.info, v.weight)
			end
			Player.Functions.SetMetaData('backpack', true)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['backpack'], 'remove')
		end
	end
end)

RegisterNetEvent('qb-inventory:server:removeBackPack', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
	if Searchs[src] then
		local sTarget = QBCore.Functions.GetPlayer(Searchs[src])
		if not sTarget then
			Searchs[src] = nil
		end
	end
	if Searchs[src] then return end
	if Player.PlayerData.metadata.backpack then
		local isFree = false
		for i=1, QBCore.Config.Player.MaxInvSlots do
			if not Player.PlayerData.items[i] then
				isFree = true
				break
			end
		end
		if isFree then
			Player.Functions.SetMetaData('backpack', false)
			local inventory = Player.PlayerData.items
			local items = {}
			for i=1, QBCore.Config.Player.BackPackSlot do
				local slot = i + QBCore.Config.Player.MaxInvSlots
				if Player.PlayerData.items[slot] then
					items[slot] = Player.PlayerData.items[slot]
				end
				inventory[slot] = nil
			end
			Player.Functions.SetInventory(inventory)
			Player.Functions.AddItem('backpack', 1, nil, {items = items}, QBCore.Player.GetTotalWeight(items))
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['backpack'], 'add')
		else
			TriggerClientEvent('QBCore:Notify', src, 'You Do Not Have Enough Space!', 'error')
		end
	else
		TriggerClientEvent('QBCore:Notify', src, 'You Do Not Have Backpack', 'error')
	end
end)

RegisterNetEvent('qb-inventory:server:GiveItem', function(target, slot, amount)
	if not target or not slot then return end
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Target = QBCore.Functions.GetPlayer(target)
    if Target then
		local item = Player.PlayerData.items[slot]
		if not amount then amount = item.amount end
		if amount <= item.amount then
			if Player.Functions.RemoveItem(item.name, amount, slot) then
				if Target.Functions.AddItem(item.name, amount, nil, item.info, item.weight, true) then
					TriggerClientEvent('inventory:client:ItemBox', target, QBCore.Shared.Items[item.name], 'add', amount, GetImage(item.name, item.info))
					TriggerClientEvent("qb-inventory:client:giveAnim", src)
					TriggerClientEvent("qb-inventory:client:giveAnim", target)
					TriggerClientEvent("inventory:client:CheckWeapon", src, slot)
				else
					Player.Functions.AddItem(item.name, amount, slot, item.info, item.weight)
					TriggerClientEvent('QBCore:Notify', src, 'Target Does Not Have Enough Space!', 'error')
					TriggerClientEvent('QBCore:Notify', target, 'You Do Not Have Enough Space!', 'error')
				end
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "You Do Not Have Enough Item!", 'error')
		end
    end
end)

-- callback

QBCore.Functions.CreateCallback('qb-inventory:server:GetStashItems', function(source, cb, stashId)
	cb(GetStashItems(stashId))
end)

-- Item

QBCore.Functions.CreateUseableItem("backpack", function(source, item)
	local Player = QBCore.Functions.GetPlayer(source)
	if not Player.PlayerData.metadata.backpack then
		TriggerClientEvent('qb-inventory:client:useBackPack', source, item.slot)
	else
		TriggerClientEvent('QBCore:Notify', source, 'You Already Have Backpack', 'error')
	end
end)

-- command

QBCore.Commands.Add("sethp", "Set Health of Item", {{name="slot", help='Slot Number of Item'},{name="hp", help='Amount of Quality'}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if not Player then return end
	local slot = tonumber(args[1])
	if not slot or slot < 1 or slot > QBCore.Config.Player.MaxInvSlots then return end
	local hp = tonumber(args[2])
	if not hp or hp < 0 or hp > 100 then return end
    local invs = Player.PlayerData.items[slot]
    invs.info.quality = hp
    invs.info.created = os.time()
    Player.Functions.SetInventory(Player.PlayerData.items)
end, "god")

QBCore.Commands.Add("resetinv", "Reset Inventory", {{name="type", help="stash/trunk/glovebox"},{name="id/plate", help="ID of stash or license plate"}}, true, function(source, args)
	local invType = args[1]:lower()
	table.remove(args, 1)
	local invId = table.concat(args, " ")
	if invType ~= nil and invId ~= nil then
		if invType == "trunk" then
			if Trunks[invId] ~= nil then
				Trunks[invId].isOpen = false
			end
		elseif invType == "glovebox" then
			if Gloveboxes[invId] ~= nil then
				Gloveboxes[invId].isOpen = false
			end
		elseif invType == "stash" then
			if Stashes[invId] ~= nil then
				Stashes[invId].isOpen = false
			end
		else
			TriggerClientEvent('QBCore:Notify', source,  "Not a valid type..", "error")
		end
	else
		TriggerClientEvent('QBCore:Notify', source,  "Arguments not filled out correctly..", "error")
	end
end, "dev")

AddEventHandler("onResourceStop", function(name) 
    if (GetCurrentResourceName() ~= name) then return end
    for k,v in pairs(ThrownWeapons) do 
        DeleteEntity(NetworkGetEntityFromNetworkId(k))
    end
end)