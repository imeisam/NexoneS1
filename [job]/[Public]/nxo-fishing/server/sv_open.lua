function ShowItemBoxItem(Item, type, amount, src)
    if Framework == "QBCore" then
        TriggerClientEvent('inventory:client:ItemBox', src, FWork.Shared.Items[Item], type, amount or 1)
    end
end
function GetFishingRep(Player)
    if Framework == "QBCore" then
        if Player.PlayerData.metadata["fishingrep"] ~= nil then
            return Player.PlayerData.metadata["fishingrep"]
        else
            Player.Functions.SetMetaData("fishingrep", 0)
            Player.Functions.Save()
            return 0
        end
    elseif Framework == "ESX" then
        local CitizenId = Player.PlayerData.citizenid
        local Result = MySQL.query.await('SELECT * FROM pug_fishing WHERE citizenid = ?', {CitizenId})
        if Result[1] then
            return Result[1].fishingrep
        else
            return 0
        end
    end
end
function SetNewFishingRep(Player, NewRep)
    if Framework == "QBCore" then
        Player.Functions.SetMetaData("fishingrep", NewRep)
    elseif Framework == "ESX" then
        local CitizenId = Player.PlayerData.citizenid
        local Result = MySQL.query.await('SELECT * FROM pug_fishing WHERE citizenid = ?', {CitizenId})
        if Result[1] then
            MySQL.update('UPDATE pug_fishing SET fishingrep = ? WHERE citizenid = ?', { NewRep, CitizenId })
        else
            MySQL.insert.await('INSERT INTO pug_fishing (citizenid, fishingrep) VALUES (?,?)', {
                CitizenId, NewRep
            })
        end
    end
end
function PugFindPlayersByItentifier(identifier)
    local players = GetPlayers()
    for _, v in ipairs(players) do
        local playerIdentifier = FWork.GetIdentifier(v)
        if playerIdentifier == identifier then
            if Config.Debug then
                print("player found:", v)
            end
            return v
        end
    end
end
function SVAddItem(src, Item, Amount, info, Player)
    if Config.InventoryType == "ox_inventory" then
        exports.ox_inventory:AddItem(src, Item, Amount, info)
    else
        Player.AddItem(Item, Amount, false, info)
    end
end

local function SVHasItem(src, Item)
    if Framework == "ESX" then
        local Player = FWork.GetPlayerFromId(src)
        return Player.getInventoryItem(Item)
    else
        return Config.FrameworkFunctions.GetItemByName(src, Item, 1)
    end
end
local function SVHasItemCount(src, Item)
    if Framework == "ESX" then
        local Player = FWork.GetPlayerFromId(src)
        local PlayerItem = Player.getInventoryItem(Item)
        if PlayerItem then
            return PlayerItem.count
        else
            return 0
        end
    else
        local PlayerItem = Config.FrameworkFunctions.GetItemByName(src, Item, 1)
        if PlayerItem then
            return PlayerItem.amount
        else
            return 0
        end
    end
end
local function ShowItemLable(Item)
    if Framework == "QBCore" then
        if FWork.Shared.Items[Item] then
            return FWork.Shared.Items[Item].label
        else
            return Item
        end
    else
        return Item
    end
end
if Framework == "QBCore" then
    FWork.Functions.CreateUseableItem("fishingrod", function(source, item)
        local src = source
        TriggerClientEvent("Pug:client:StartFishing", src, item.name)
    end)
    FWork.Functions.CreateUseableItem("fishingrod2", function(source, item)
        local src = source
        TriggerClientEvent("Pug:client:StartFishing", src, item.name)
    end)
    FWork.Functions.CreateUseableItem("fishingrod3", function(source, item)
        local src = source
        TriggerClientEvent("Pug:client:StartFishing", src, item.name)
    end)
    FWork.Functions.CreateUseableItem("fishinglure", function(source, item)
        local src = source
        TriggerClientEvent("Pug:client:StartFishing", src, item.name)
    end)
    FWork.Functions.CreateUseableItem("fishinglure2", function(source, item)
        local src = source
        TriggerClientEvent("Pug:client:StartFishing", src, item.name)
    end)
    FWork.Functions.CreateUseableItem(Config.ChestItem, function(source, item)
        local src = source
        TriggerClientEvent("Pug:client:OpenTreasureChest", src, item.name)
    end)
    FWork.Functions.CreateUseableItem("bottlemap", function(source, item)
        local src = source
        local Player = Config.FrameworkFunctions.GetPlayer(src)
        Player.RemoveItem(item.name, 1)
        TriggerClientEvent("Pug:client:Openbottlemap", src, item.name)
    end)
    FWork.Functions.CreateUseableItem("treasuremap", function(source, item)
        local src = source
        TriggerClientEvent("Pug:client:UseTreasureMap", src, item.name)
    end)
elseif Framework == "ESX" then
    FWork.RegisterUsableItem("fishingrod", function(source, item)
		local src = source
        if Config.InventoryType == "qs-inventory" then
		    TriggerClientEvent("Pug:client:StartFishing", src, item.name)
        else
            TriggerClientEvent("Pug:client:StartFishing", src, item)
        end
	end)
    FWork.RegisterUsableItem("fishingrod2", function(source, item)
		local src = source
        if Config.InventoryType == "qs-inventory" then
		    TriggerClientEvent("Pug:client:StartFishing", src, item.name)
        else
            TriggerClientEvent("Pug:client:StartFishing", src, item)
        end
	end)
    FWork.RegisterUsableItem("fishingrod3", function(source, item)
		local src = source
        if Config.InventoryType == "qs-inventory" then
		    TriggerClientEvent("Pug:client:StartFishing", src, item.name)
        else
            TriggerClientEvent("Pug:client:StartFishing", src, item)
        end
	end)
    FWork.RegisterUsableItem("fishinglure", function(source, item)
		local src = source
        if Config.InventoryType == "qs-inventory" then
		    TriggerClientEvent("Pug:client:StartFishing", src, item.name)
        else
            TriggerClientEvent("Pug:client:StartFishing", src, item)
        end
	end)
    FWork.RegisterUsableItem("fishinglure2", function(source, item)
		local src = source
        if Config.InventoryType == "qs-inventory" then
		    TriggerClientEvent("Pug:client:StartFishing", src, item.name)
        else
            TriggerClientEvent("Pug:client:StartFishing", src, item)
        end
	end)
    FWork.RegisterUsableItem(Config.ChestItem, function(source, item)
		local src = source
		TriggerClientEvent("Pug:client:OpenTreasureChest", src, item)
	end)
    FWork.RegisterUsableItem("bottlemap", function(source, item)
        local src = source
        local Player = Config.FrameworkFunctions.GetPlayer(src)
        Player.RemoveItem(item, 1)
        if Config.InventoryType == "qs-inventory" then
		    TriggerClientEvent("Pug:client:Openbottlemap", src, item.name)
        else
            TriggerClientEvent("Pug:client:Openbottlemap", src, item)
        end
	end)
    FWork.RegisterUsableItem("treasuremap", function(source, item)
        local src = source
        if Config.InventoryType == "qs-inventory" then
		    TriggerClientEvent("Pug:client:UseTreasureMap", src, item.name)
        else
            TriggerClientEvent("Pug:client:UseTreasureMap", src, item)
        end
	end)
end

RegisterNetEvent("Pug:Server:GiveFishingRep", function(rep)
	local src = source
    local Player
    if Framework == "QBCore" then
        Player = FWork.Functions.GetPlayer(src)
    else
        Player = Config.FrameworkFunctions.GetPlayer(src)
    end
	local NewRep = (GetFishingRep(Player) + rep)
    SetNewFishingRep(Player, NewRep)
	TriggerClientEvent('Pug:client:FishingNotify', src, '+'..rep..Translations.error.success, 'success')
end)

if Framework == "ESX" then
    Config.FrameworkFunctions.CreateCallback('Pug:server:GetItemFishingESX', function(source, cb, item, amount)
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
    function GetInventoryItemsESX(source)
		if source then
			local src = source
			local Player = FWork.GetPlayerFromId(src)
			return Player.inventory
		end
    end
else
    local function GetFirstSlotByItem(items, itemName)
        if not items then return nil end
        for slot, item in pairs(items) do
            if item.name:lower() == itemName:lower() then
                return tonumber(slot)
            end
        end
        return nil
    end
    local function GetItemByName(source, item)
        local Player = Config.FrameworkFunctions.GetPlayer(source)
        item = tostring(item):lower()
        local slot = GetFirstSlotByItem(Player.PlayerData.items, item)
        return Player.PlayerData.items[slot]
    end
    Config.FrameworkFunctions.CreateCallback('Pug:server:FishingGetITemQBCore', function(source, cb, items, amount)
        if Config.FishingItemCheck then
            local src = source
            local retval = false
            local hasitem = FWork.Functions.HasItem(src, items, amount)
            if hasitem then
                retval = true
            end
            Wait(50)
            cb(retval)
        elseif Config.InventoryType == "ox_inventory" then
            local src = source
            local ox_inventory = exports.ox_inventory
            if ox_inventory:GetItem(src, items, false, true) >= 1 then
                cb(true)
            else
                cb(false)
            end
        else
            local src = source
            local retval = false
            local Player = Config.FrameworkFunctions.GetPlayer(src)
            if not Player then return false end
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
            else -- Single item as string
                local item = GetItemByName(src, items)
                if item and (not amount or (item and amount and item.amount >= amount)) then
                    retval = true
                end
            end
            cb(retval)
        end
    end)
end

Config.FrameworkFunctions.CreateCallback('Pug:ServerCB:CanCraftRod', function(source, cb, item)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    if Framework == "QBCore" then
        Player = FWork.Functions.GetPlayer(src)
    else
        Player = Config.FrameworkFunctions.GetPlayer(src)
    end
    if Config.FishingItemCheck then
        local cash = Player.PlayerData.money.cash
        if cash >= Config.CraftRods[item].price then
            local hasitem1 = FWork.Functions.HasItem(src, Config.CraftRods[item].item1, 1)
            if hasitem1 then
                local hasitem2 = FWork.Functions.HasItem(src, Config.CraftRods[item].item2, 1)
                if hasitem2 then
                    local CurrentFishingRep = GetFishingRep(Player)
                    if CurrentFishingRep >= Config.CraftRods[item].repRequired then
                        cb(true)
                    else
                        TriggerClientEvent('Pug:client:FishingNotify', src, 'You are missing '.. Config.CraftRods[item].repRequired - CurrentFishingRep..' Fisshing rep', 'error')
                        cb(false)
                    end
                else
                    TriggerClientEvent('Pug:client:FishingNotify', src, 'You are missing a '.. ShowItemLable(Config.CraftRods[item].item2), 'error')
                    cb(false)
                end
            else
                TriggerClientEvent('Pug:client:FishingNotify', src, 'You are missing a '.. ShowItemLable(Config.CraftRods[item].item1), 'error')
                cb(false)
            end
        else
            TriggerClientEvent('Pug:client:FishingNotify', src, 'You are missing $'.. Config.CraftRods[item].price - cash, 'error')
            cb(false)
        end
    elseif Config.InventoryType == "ox_inventory" then
        local cash = Player.PlayerData.money.cash
        if cash >= Config.CraftRods[item].price then
            local ox_inventory = exports.ox_inventory
            if ox_inventory:GetItem(src, Config.CraftRods[item].item1, false, true) >= 1 then
                if ox_inventory:GetItem(src, Config.CraftRods[item].item2, false, true) >= 1 then
                    local CurrentFishingRep = GetFishingRep(Player)
                    if CurrentFishingRep >= Config.CraftRods[item].repRequired then
                        cb(true)
                    else
                        TriggerClientEvent('Pug:client:FishingNotify', src, 'You are missing '.. Config.CraftRods[item].repRequired - CurrentFishingRep..' Fisshing rep', 'error')
                        cb(false)
                    end
                else
                    TriggerClientEvent('Pug:client:FishingNotify', src, 'You are missing a '.. ShowItemLable(Config.CraftRods[item].item2), 'error')
                    cb(false)
                end
            else
                TriggerClientEvent('Pug:client:FishingNotify', src, 'You are missing a '.. ShowItemLable(Config.CraftRods[item].item1), 'error')
                cb(false)
            end
        else
            TriggerClientEvent('Pug:client:FishingNotify', src, 'You are missing $'.. Config.CraftRods[item].price - cash, 'error')
            cb(false)
        end
    else
        local item1 = Config.CraftRods[item].item1
        local item2 = Config.CraftRods[item].item2
        local cash = Player.PlayerData.money.cash
        if cash >= Config.CraftRods[item].price then
            if SVHasItem(src,item1) then
                local Item1Count = SVHasItemCount(src,item1)
                if Item1Count >= Config.CraftRods[item].item1Amount then
                    if SVHasItem(src,item2) then
                        local Item2Count = SVHasItemCount(src,item2)
                        if Item2Count >= Config.CraftRods[item].item2Amount then
                            local CurrentFishingRep = GetFishingRep(Player)
                            if CurrentFishingRep >= Config.CraftRods[item].repRequired then
                                cb(true)
                            else
                                TriggerClientEvent('Pug:client:FishingNotify', src, 'You are missing '.. Config.CraftRods[item].repRequired - CurrentFishingRep..' Fisshing rep', 'error')
                                cb(false)
                            end
                        else
                            TriggerClientEvent('Pug:client:FishingNotify', src, 'You are missing '.. Config.CraftRods[item].item2Amount - Item2Count..'x '..ShowItemLable(Config.CraftRods[item].item2), 'error')
                            cb(false)
                        end
                    else
                        TriggerClientEvent('Pug:client:FishingNotify', src, 'You are missing a '.. ShowItemLable(Config.CraftRods[item].item2), 'error')
                        cb(false)
                    end
                else
                    TriggerClientEvent('Pug:client:FishingNotify', src, 'You are missing '.. Config.CraftRods[item].item1Amount - Item1Count..'x '..ShowItemLable(Config.CraftRods[item].item1), 'error')
                    cb(false)
                end
            else
                TriggerClientEvent('Pug:client:FishingNotify', src, 'You are missing a '.. ShowItemLable(Config.CraftRods[item].item1), 'error')
                cb(false)
            end
        else
            TriggerClientEvent('Pug:client:FishingNotify', src, 'You are missing $'.. Config.CraftRods[item].price - cash, 'error')
            cb(false)
        end
    end
end)
Config.FrameworkFunctions.CreateCallback('Pug:ServerCB:SellGems', function(source, cb, item)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    if Config.FishingItemCheck then
        local XPlayer = FWork.Functions.GetPlayer(src)
        local hasitem = XPlayer.Functions.GetItemsByName(item)
        if hasitem ~= nil then
            local hasitemAmount = 0
            for _, v in ipairs(hasitem) do
                hasitemAmount = hasitemAmount + v.amount
            end
            local GemsAmount = hasitemAmount
            local amount = math.ceil(GemsAmount * math.random(Config.SellGems[item].pricemin,Config.SellGems[item].pricemax))
            Player.AddMoney('cash', amount, "buy-item")
            Player.RemoveItem(item, GemsAmount)
            TriggerClientEvent('Pug:client:FishingNotify', src, Translations.success.soldfish.. GemsAmount..'x '..ShowItemLable(item)..' for $'..amount, 'success')
            cb(true)
        else
            cb(false)
        end
    elseif Config.InventoryType == "ox_inventory" then
        local ox_inventory = exports.ox_inventory
        if ox_inventory:GetItem(src, item, false, true) ~= nil then
            if ox_inventory:GetItem(src, item, false, true) >= 1 then
                local HasAmout = ox_inventory:GetItem(src, item, false, true)
                local amount = HasAmout * math.random(Config.SellGems[item].pricemin,Config.SellGems[item].pricemax)
                Player.AddMoney('cash', amount, "buy-item")
                Player.RemoveItem(item, HasAmout)
                TriggerClientEvent('Pug:client:FishingNotify', src, Translations.success.soldfish.. HasAmout..'x '..ShowItemLable(item)..' for $'..amount, 'success')
                cb(true)
            else
                cb(false)
            end
        else
            cb(false)
        end
    else
        if SVHasItem(src,item) then
            local GemsAmount = SVHasItemCount(src, item)
            local amount = GemsAmount * math.random(Config.SellGems[item].pricemin,Config.SellGems[item].pricemax)
            Player.AddMoney('cash', amount, "buy-item")
            Player.RemoveItem(item, GemsAmount)
            TriggerClientEvent('Pug:client:FishingNotify', src, Translations.success.soldfish.. GemsAmount..'x '..ShowItemLable(item)..' for $'..amount, 'success')
            cb(true)
        else
            cb(false)
        end
    end
end)
Config.FrameworkFunctions.CreateCallback('Pug:ServerCB:SellFish', function(source, cb, item)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    if Config.FishingItemCheck then
        local XPlayer = FWork.Functions.GetPlayer(src)
        local hasitem = XPlayer.Functions.GetItemsByName(item)
        if hasitem ~= nil then
            local hasitemAmount = 0
            for _, v in ipairs(hasitem) do
                hasitemAmount = hasitemAmount + v.amount
            end
            local GemsAmount = hasitemAmount
            local amount = math.ceil(GemsAmount * math.random(Config.SellFishies[item].pricemin,Config.SellFishies[item].pricemax))
            Player.AddMoney('cash', amount, "buy-item")
            Player.RemoveItem(item, GemsAmount)
            TriggerClientEvent('Pug:client:FishingNotify', src, Translations.success.soldfish.. GemsAmount..'x '..ShowItemLable(item)..' for $'..amount, 'success')
            cb(true)
        else
            cb(false)
        end
    elseif Config.InventoryType == "ox_inventory" then
        local ox_inventory = exports.ox_inventory
        if ox_inventory:GetItem(src, item, false, true) ~= nil then
            if ox_inventory:GetItem(src, item, false, true) >= 1 then
                local HasAmout = ox_inventory:GetItem(src, item, false, true)
                local amount = HasAmout * math.random(Config.SellFishies[item].pricemin,Config.SellFishies[item].pricemax)
                Player.AddMoney('cash', amount, "buy-item")
                Player.RemoveItem(item, HasAmout)
                TriggerClientEvent('Pug:client:FishingNotify', src, Translations.success.soldfish.. HasAmout..'x '..ShowItemLable(item)..' for $'..amount, 'success')
                cb(true)
            else
                cb(false)
            end
        else
            cb(false)
        end
    else
        if SVHasItem(src,item) then
            local GemsAmount = SVHasItemCount(src, item)
            local amount = GemsAmount * math.random(Config.SellFishies[item].pricemin,Config.SellFishies[item].pricemax)
            Player.AddMoney('cash', amount, "buy-item")
            Player.RemoveItem(item, GemsAmount)
            TriggerClientEvent('Pug:client:FishingNotify', src, Translations.success.soldfish.. GemsAmount..'x '..ShowItemLable(item)..' for $'..amount, 'success')
            cb(true)
        else
            cb(false)
        end
    end
end)

RegisterServerEvent('Pug:server:FishingRemoveMoeny')
AddEventHandler('Pug:server:FishingRemoveMoeny', function(amount)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    Player.RemoveMoney('cash', amount, "buy-item")
end)

RegisterServerEvent('Pug:server:ToggleFish', function(bool, fish, amnt)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
	if fish then
        if bool then
            if amnt then
                if Config.InventoryType == "ox_inventory" then
                    if exports.ox_inventory:CanCarryItem(src, fish, amnt) then
                        SVAddItem(src, fish, amnt, false, Player)
                    else
                        TriggerClientEvent('Pug:client:FishingNotify', src, "Your pockets are full", 'error')
                    end
                else
                    Player.AddItem(fish, amnt)
                end
            else
                if Config.InventoryType == "ox_inventory" then
                    if exports.ox_inventory:CanCarryItem(src, fish, 1) then
                        SVAddItem(src, fish, 1, false, Player)
                    else
                        TriggerClientEvent('Pug:client:FishingNotify', src, "Your pockets are full", 'error')
                    end
                else
                    Player.AddItem(fish, 1)
                end
            end
            ShowItemBoxItem(fish, "add", amnt, src)
        else
            if amnt then
                Player.RemoveItem(fish, amnt)
            else
                Player.RemoveItem(fish, 1)
            end
            ShowItemBoxItem(fish, "remove", amnt, src)
        end
	end
end)

RegisterNetEvent("Pug:server:RemoveFishingRedp", function(Amount)
	local src = source
    local Player
    if Framework == "QBCore" then
        Player = FWork.Functions.GetPlayer(src)
    else
        Player = Config.FrameworkFunctions.GetPlayer(src)
    end
	local NewRep = (GetFishingRep(Player) - Amount)
    SetNewFishingRep(Player, NewRep)
	TriggerClientEvent('Pug:client:FishingNotify', src, '-'..Amount.." fishing rep", 'error')
end)

-- rewards table for opening a Treasure chest
RegisterServerEvent('Pug:server:GiveChestItems', function(type)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
	local itemsfound = false
    local emerald = math.random(1,100)
    local diamond = math.random(1,100)
    local ruby = math.random(1,100)
    local sapphire = math.random(1,100)
    local captainskull = math.random(1,100)
    local chestkey = math.random(1,100)
    local rolex = math.random(1,100)
    local diamondring = math.random(1,100)
    local tresurbottle = math.random(1,100)
    local yllowdiamond = math.random(1,100)
    local pistol = math.random(1,100)
    local cash = math.random(1,100)
    local lure1 = math.random(1,100)
    local lure2 = math.random(1,100)
    local chance = 10
    if emerald <= 30 then
        TriggerClientEvent('animations:client:EmoteCommandStart', src, {"pickup"})
        Wait(1000)
		itemsfound = true
        local given = math.random(1,4)
        SVAddItem(src, 'emerald', given, false, Player)
        ShowItemBoxItem("emerald", "add", given, src)
    end
    if diamond <= 30 then
        TriggerClientEvent('animations:client:EmoteCommandStart', src, {"pickup"})
        Wait(1000)
		itemsfound = true
        local given = math.random(1,4)
        SVAddItem(src, 'diamond', given, false, Player)
        ShowItemBoxItem("diamond", "add", given, src)
    end
    if ruby <= 30 then
        TriggerClientEvent('animations:client:EmoteCommandStart', src, {"pickup"})
        Wait(1000)
		itemsfound = true
        local given = math.random(1,4)
        SVAddItem(src, 'ruby', given, false, Player)
        ShowItemBoxItem("ruby", "add", given, src)
    end
    if yllowdiamond <= 25 then
        TriggerClientEvent('animations:client:EmoteCommandStart', src, {"pickup"})
        Wait(1000)
		itemsfound = true
        local given = math.random(1,4)
        SVAddItem(src, 'yellow-diamond', given, false, Player)
        ShowItemBoxItem("yellow-diamond", "add", given, src)
    end
    if sapphire <= 30 then
        TriggerClientEvent('animations:client:EmoteCommandStart', src, {"pickup"})
        Wait(1000)
		temsfound = true
        local given = math.random(1,3)
        SVAddItem(src, 'sapphire', given, false, Player)
        ShowItemBoxItem("sapphire", "add", given, src)
    end
    if pistol <= 10 then
        TriggerClientEvent('animations:client:EmoteCommandStart', src, {"pickup"})
        Wait(1000)
		itemsfound = true
        SVAddItem(src, 'weapon_pistol', 1, false, Player)
        ShowItemBoxItem("weapon_pistol", "add", 1, src)
    end
    if captainskull <= 2 then
        TriggerClientEvent('animations:client:EmoteCommandStart', src, {"pickup"})
        Wait(1000)
		itemsfound = true
        SVAddItem(src, 'captainskull', 1, false, Player)
        ShowItemBoxItem("captainskull", "add", 1, src)
    end
    if chestkey <= 1 then
        TriggerClientEvent('animations:client:EmoteCommandStart', src, {"pickup"})
        Wait(1000)
		itemsfound = true
        SVAddItem(src, Config.ChestKey, 1, false, Player)
        ShowItemBoxItem(Config.ChestKey, "add", 1, src)
    end
    if rolex <= 30 then
        TriggerClientEvent('animations:client:EmoteCommandStart', src, {"pickup"})
        Wait(1000)
		itemsfound = true
        local given = math.random(1,5)
        SVAddItem(src, 'rolex', given, false, Player)
        ShowItemBoxItem("rolex", "add", given, src)
    end
    if diamondring <= 40 then
        TriggerClientEvent('animations:client:EmoteCommandStart', src, {"pickup"})
        Wait(1000)
		itemsfound = true
        local given = math.random(1,7)
        SVAddItem(src, 'diamond_ring', given, false, Player)
        ShowItemBoxItem("diamond_ring", "add", given, src)
    end
    if tresurbottle <= 1 then
        TriggerClientEvent('animations:client:EmoteCommandStart', src, {"pickup"})
        Wait(1000)
		itemsfound = true
        SVAddItem(src, 'bottlemap', 1, false, Player)
        ShowItemBoxItem("bottlemap", "add", 1, src)
    end
    if lure1 <= 4 then
        TriggerClientEvent('animations:client:EmoteCommandStart', src, {"pickup"})
        Wait(1000)
		itemsfound = true
        SVAddItem(src, 'fishinglure', 1, false, Player)
        ShowItemBoxItem("fishinglure", "add", 1, src)
    end
    if lure2 <= 1 then
        TriggerClientEvent('animations:client:EmoteCommandStart', src, {"pickup"})
        Wait(1000)
		itemsfound = true
        SVAddItem(src, 'fishinglure2', 1, false, Player)
        ShowItemBoxItem("fishinglure2", "add", 1, src)
    end
    if type == 'found' then -- if the chest opened was through finding it wile using the treasure map 
        chance = 55
    end
    if cash <= chance then
        TriggerClientEvent('animations:client:EmoteCommandStart', src, {"pickup"})
        Wait(1000)
		itemsfound = true
        Player.AddMoney('cash', math.random(500,3500))
    end
    if type == 'found' then -- loot table for if the chest opened was through finding it wile using the treasure map 
        local brain = math.random(1,500)
        if brain == 1 then
            TriggerClientEvent('animations:client:EmoteCommandStart', src, {"pickup"})
            Wait(1000)
            itemsfound = true
            SVAddItem(src, Config.SuperRareitem, 1, false, Player)
            ShowItemBoxItem(Config.SuperRareitem, "add", 1, src)
        end
        RandomizeChestLocation()
    end
	if not itemsfound then
		TriggerClientEvent('Pug:client:FishingNotify', src, Translations.error.empty_chest, 'error')
	end
    TriggerClientEvent("Pug:client:DeleteOpenChest", src)
end)

if Framework == "QBCore" then
    FWork.Commands.Add("fishrep", "Check your reputation", {}, false, function(source, args)
        local Player = FWork.Functions.GetPlayer(source)
        local fishing = GetFishingRep(Player)
        TriggerClientEvent('Pug:client:FishingNotify', Player.PlayerData.source, "Fishing reputation is "..fishing)
    end)
else
    FWork.RegisterCommand('fishrep', "admin", function(xPlayer, args, showError)
        local Player = Config.FrameworkFunctions.GetPlayer(xPlayer.source)
        local fishing = GetFishingRep(Player)
        TriggerClientEvent('Pug:client:FishingNotify', xPlayer.source, "Fishing reputation is "..fishing)
    end,"admin")
end

-- Credits to ΛII#0007 for this
RegisterNetEvent("pug-fishing:server:OpenShop", function()
    exports.ox_inventory:RegisterShop('fishingshop',{ 
        name = 'Fish Market',
        inventory = {
            { name = 'fishingrod', price = 0 },
            { name = 'fishingbait', price = 0 },
            { name = 'fishicebox', price = 0 },
            { name = 'diving_gear', price = 0 },
            { name = 'diving_fill', price = 0 },
        },
    })
end)

-- QBCORE ITEMS ADDING
local Items = {
    ['fishingrod'] 			 		 = {['name'] = 'fishingrod', 					['label'] = 'Fishing Rod', 				['weight'] = 5000, 		['type'] = 'item', 		['image'] = 'fishingrod.png', 			['unique'] = true, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A fishing rod for adventures with friends!!'},
    ['fishingrod2'] 			 		 = {['name'] = 'fishingrod2', 					['label'] = 'Skilled Fishing Rod', 				['weight'] = 5000, 		['type'] = 'item', 		['image'] = 'betterrod.png', 			['unique'] = true, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'This rod is better than most, but not the best.'},
    ['fishingrod3'] 			 		 = {['name'] = 'fishingrod3', 					['label'] = 'Professional Rod', 				['weight'] = 5000, 		['type'] = 'item', 		['image'] = 'bestrod.png', 			['unique'] = true, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'S+ tier fishing rod!!'},
    ['fishinglure'] 			     = {['name'] = 'fishinglure', 					['label'] = 'Fishing Lure', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'beginnerlure.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A colorful lure'},
    ['fishinglure2'] 			     = {['name'] = 'fishinglure2', 					['label'] = 'Pro Fishing Lure', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'betterlure.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A realistic lure'},
    ['skill-reel'] 			     = {['name'] = 'skill-reel', 					['label'] = 'Skill Fishing Reel', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'skill-reel.png', 			['unique'] = true, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A skilled fishing reel.'},
    ['pro-reel'] 			     = {['name'] = 'pro-reel', 					['label'] = 'Pro Fishing Reel', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pro-reel.png', 			['unique'] = true, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A professional fishing reel.'},
    ['fishingbait'] 			     = {['name'] = 'fishingbait', 					['label'] = 'Fish Bait', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'wormbait.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Worm bait!'},

    -- fish
    ['killerwhale'] 			     = {['name'] = 'killerwhale', 			     	['label'] = 'Killer Whale',        ['weight'] = 7000,      ['type'] = 'item',      ['image'] = 'killerwhalemeat.png',      ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'This is a whole ass Shamu.'},
    ['stingraymeat'] 			     = {['name'] = 'stingraymeat', 				    ['label'] = 'Stingray',            ['weight'] = 2000,      ['type'] = 'item',      ['image'] = 'stingraymeat.png',         ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Stingray Meat'},
    ['tigershark'] 			         = {['name'] = 'tigershark', 			     	['label'] = 'Tigershark',          ['weight'] = 7000,      ['type'] = 'item',      ['image'] = 'tigershark.png',       ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'There are bigger sharks but this is still impressive..'},
    ['catfish'] 			         = {['name'] = 'catfish', 				        ['label'] = 'Catfish',                  ['weight'] = 3000,      ['type'] = 'item',      ['image'] = 'catfish.png',              ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'A Catfish'},
    ["fish"] 						= {["name"] = "fish",  	     				["label"] = "Fish",	 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "fish.png", 		["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   	["combinable"] = nil,   ["description"] = "A fish", ['hunger'] = math.random(40, 50) },
    ['salmon'] 			             = {['name'] = 'salmon', 				        ['label'] = 'Salmon',                   ['weight'] = 2000,      ['type'] = 'item',      ['image'] = 'salmon.png',               ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'A Salmon Fish'},
    ['largemouthbass'] 			     = {['name'] = 'largemouthbass', 				['label'] = 'Largemouth Bass',          ['weight'] = 3000,      ['type'] = 'item',      ['image'] = 'largemouthbass.png',       ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Fish for Fishing.'},
    ['goldfish'] 			         = {['name'] = 'goldfish', 			        	['label'] = 'Goldfish',                 ['weight'] = 2000,      ['type'] = 'item',      ['image'] = 'goldfish.png',             ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'A Goldfish... I wonder how he got there...'},
    ['redfish'] 			         = {['name'] = 'redfish', 			        	['label'] = 'Redfish',                  ['weight'] = 2000,      ['type'] = 'item',      ['image'] = 'redfish.png',              ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'One fish two fish...'},
    ['bluefish'] 			         = {['name'] = 'bluefish', 			        	['label'] = 'Bluefish',                 ['weight'] = 1000,      ['type'] = 'item',      ['image'] = 'bluefish.png',             ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'One fish two fish redfish...'},
    ['stripedbass'] 			     = {['name'] = 'stripedbass', 			        ['label'] = 'Striped Bass',             ['weight'] = 1000,      ['type'] = 'item',      ['image'] = 'stripedbass.png',          ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'A Striped Bass'},
    ['rainbowtrout'] 			     = {['name'] = 'rainbowtrout', 			        ['label'] = 'Rainbow Trout',             ['weight'] = 1000,      ['type'] = 'item',      ['image'] = 'rainbow-trout.png',          ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'A colorful Trout'},
    ['gholfish'] 			     = {['name'] = 'gholfish', 			        ['label'] = 'Ghol',             ['weight'] = 1000,      ['type'] = 'item',      ['image'] = 'ghol-fish.png',          ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'A big Ghol'},
    ['codfish'] 			     = {['name'] = 'codfish', 			        ['label'] = 'Cod',             ['weight'] = 3000,      ['type'] = 'item',      ['image'] = 'codfish.png',          ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'A cody fish'},
    ['eelfish'] 			     = {['name'] = 'eelfish', 			        ['label'] = 'Eel',             ['weight'] = 4000,      ['type'] = 'item',      ['image'] = 'eelfish.png',          ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'An eel.. pretty useless.'},
    ['swordfish'] 			     = {['name'] = 'swordfish', 			        ['label'] = 'Sword Fish',             ['weight'] = 3000,      ['type'] = 'item',      ['image'] = 'swordfish.png',          ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'This has a giant ass needle for a face.'},
    ['tuna-fish'] 			     = {['name'] = 'tuna-fish', 			        ['label'] = 'Tuna',             ['weight'] = 2000,      ['type'] = 'item',      ['image'] = 'tuna-fish.png',          ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Chicken of the sea, but fucking massive.'},

    -- chest items
    ['chestkey'] 			     = {['name'] = 'chestkey', 			        ['label'] = 'Key',             ['weight'] = 1000,      ['type'] = 'item',      ['image'] = 'chestkey.png',          ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'A gold key.'},
    ['treasurechest'] 			     = {['name'] = 'treasurechest', 			        ['label'] = 'Treasure Chest',             ['weight'] = 5000,      ['type'] = 'item',      ['image'] = 'treasurechest.png',          ['unique'] = true,     ['useable'] = true,     ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Ye, Treasure mighty.'},
    ['bottlemap'] 			     = {['name'] = 'bottlemap', 			        ['label'] = 'Treasure Bottle',             ['weight'] = 1000,      ['type'] = 'item',      ['image'] = 'bottlemap.png',          ['unique'] = true,     ['useable'] = true,     ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'looks very old.'},
    ['treasuremap'] 			     = {['name'] = 'treasuremap', 			        ['label'] = 'Treasure Map',             ['weight'] = 500,      ['type'] = 'item',      ['image'] = 'treasuremap.png',          ['unique'] = true,     ['useable'] = true,     ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'This could lead somewhere...'},
    ["diamond"] 					 = {["name"] = "diamond", 			  	  	  	["label"] = "Diamond", 					["weight"] = 3000, 		["type"] = "item", 		["image"] = "diamond.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Shiny Diamond"},
    ["emerald"] 					 = {["name"] = "emerald", 			  	  	  	["label"] = "Emerald", 					["weight"] = 3000, 		["type"] = "item", 		["image"] = "emerald.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Emerald"},
    ["sapphire"] 			 		 = {["name"] = "sapphire", 						["label"] = "Sapphire", 				["weight"] = 2000, 		["type"] = "item", 		["image"] = "sapphire.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,	   	["combinable"] = nil,   ["description"] = "Gems are truly, truly, truly outrageous."},
    ["ruby"]						 = {["name"] = "ruby", 							["label"] = "Ruby", 					["weight"] = 2000, 		["type"] = "item", 		["image"] = "ruby.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,	   	["combinable"] = nil,   ["description"] = "Gems are truly, truly, truly outrageous."},
    ['yellow-diamond']               = {['name'] = 'yellow-diamond',                ['label'] = 'Canary Diamond',                     ['weight'] = 3000,         ['type'] = 'item',         ['image'] = 'yellow-diamond.png',                 ['unique'] = false,         ['useable'] = true,     ['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Yellow is truly, truly, truly gorgeous..'},
    ["captainskull"]						 = {["name"] = "captainskull", 							["label"] = "Captain Skull", 					["weight"] = 4000, 		["type"] = "item", 		["image"] = "captainskull.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,	   	["combinable"] = nil,   ["description"] = "An old skull of a captain!"},

}
CreateThread(function()
    Wait(4000)
    while GetResourceState("es_extended") ~= 'started' and GetResourceState("qb-core") ~= 'started' do Wait(1000) end
    Wait(5000)
    if Framework == "QBCore" then
        if GetResourceState("qbx_core") ~= 'started' then 
            for _, v in pairs(Items) do
                exports[Config.CoreName]:AddItem(v.name, {
                    name = v.name,
                    label = v.label,
                    weight = v.weight,
                    type = 'item',
                    image = v.image,
                    unique = v.unique,
                    useable = v.useable,
                    shouldClose = v.shouldClose,
                    combinable = v.combinable,
                    description = v.description,
                })
            end
        end
    end
end)
