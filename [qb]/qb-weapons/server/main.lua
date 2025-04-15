local QBCore = exports['qb-core']:GetCoreObject()

-- Functions

local function IsWeaponBlocked(WeaponName)
    local retval = false
    for _, name in pairs(Config.DurabilityBlockedWeapons) do
        if name == WeaponName then
            retval = true
            break
        end
    end
    return retval
end

-- Events

RegisterNetEvent('qb-weapons:server:MaxAmmo', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        TriggerEvent('qb-log:server:CreateLog', 'anticheat', Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname.." ("..Player.PlayerData.citizenid..' | '..src..")", 'white', 'Ammo More than 30', true)
    end
end)

RegisterNetEvent("weapons:server:UpdateWeaponAmmo", function(CurrentWeaponData, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    amount = tonumber(amount)
    if CurrentWeaponData then
        if Player.PlayerData.items[CurrentWeaponData.slot] then
            Player.PlayerData.items[CurrentWeaponData.slot].info.ammo = amount
        end
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)

RegisterNetEvent('weapons:server:UpdateWeaponQuality', function(data, RepeatAmount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local WeaponData = QBCore.Shared.Weapons[GetHashKey(data.name)]
    local WeaponSlot = Player.PlayerData.items[data.slot]
    local DecreaseAmount =0-- 0.15
    if WeaponSlot then
        if not IsWeaponBlocked(WeaponData.name) then
            if WeaponSlot.info.quality then
                for _ = 1, RepeatAmount, 1 do
                    if WeaponSlot.info.quality - DecreaseAmount > 0 then
                        WeaponSlot.info.quality = WeaponSlot.info.quality - DecreaseAmount
                    else
                        WeaponSlot.info.quality = 0
                        TriggerClientEvent('inventory:client:UseWeapon', src, data)
                        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.weapon_broken_need_repair'), "error")
                        break
                    end
                end
            else
                WeaponSlot.info.quality = 100
                for _ = 1, RepeatAmount, 1 do
                    if WeaponSlot.info.quality - DecreaseAmount > 0 then
                        WeaponSlot.info.quality = WeaponSlot.info.quality - DecreaseAmount
                    else
                        WeaponSlot.info.quality = 0
                        TriggerClientEvent('inventory:client:UseWeapon', src, data)
                        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.weapon_broken_need_repair'), "error")
                        break
                    end
                end
            end
        end
    end
    Player.Functions.SetInventory(Player.PlayerData.items)
end)

RegisterNetEvent("weapons:server:AddWeaponAmmo", function(CurrentWeaponData, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    amount = tonumber(amount)
    if CurrentWeaponData then
        if Player.PlayerData.items[CurrentWeaponData.slot] then
            Player.PlayerData.items[CurrentWeaponData.slot].info.ammo = amount
        end
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)

RegisterNetEvent('weapons:server:combineAmmo', function(fromSlot, toSlot)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local inventory = Player.PlayerData.items
    local ammo = inventory[fromSlot]
    local clip = inventory[toSlot]
    if not ammo or not clip then TriggerClientEvent("weapons:client:finishAnimReload", src) return end
    local maxAmmo = Config.MaxAmmoClip[clip.name]
    if not maxAmmo then TriggerClientEvent("weapons:client:finishAnimReload", src) return end
    local count = ammo.amount
    if clip.info.ammo + count > maxAmmo then
        local must = (clip.info.ammo + count) - maxAmmo
        count = count - must
    end
    local afterMinus = ammo.amount - count
    if afterMinus > 0 then
        inventory[fromSlot].amount = afterMinus
    else
        inventory[fromSlot] = nil
    end
    inventory[toSlot].info.ammo = clip.info.ammo + count
    Player.Functions.SetInventory(inventory)
    TriggerClientEvent('weapons:client:ReloadAnimation', src, count * 300)
end)

RegisterNetEvent('qb-weapons:server:useClip', function(slot, ammo, CurrentWeaponData, wammo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local inventory = Player.PlayerData.items
    local clip = inventory[slot]
    if not clip then return end
    local maxAmmo = Config.MaxAmmoClip[clip.name]
    if not maxAmmo then return end
    if CurrentWeaponData and inventory[CurrentWeaponData.slot] then
        if inventory[CurrentWeaponData.slot].info.clip then
            inventory[slot].info.ammo = ammo
        else
            inventory[slot] = nil
            inventory[CurrentWeaponData.slot].info.clip = clip.name
        end
        inventory[CurrentWeaponData.slot].info.ammo = wammo
        Player.Functions.SetInventory(inventory)
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
			if itemInfo and Config.MaxAmmoClip[itemData.name] and itemData.info.ammo and itemData.info.ammo > 0 then
                local myInv = Player.PlayerData.items
                myInv[item.slot].info.ammo = 0
                Player.Functions.SetInventory(myInv)
                Wait(100)
                local name = string.gsub(itemData.name,'clip','ammo')
                Player.Functions.AddItem(name, itemData.info.ammo)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[name], 'add', itemData.info.ammo)
			end
		end
	end
end)

RegisterNetEvent('qb-weapons:server:reloadClip', function(itemName, vehicle)
    local src = source
    if not itemName then return end
    if not Config.MaxAmmoClip[itemName] then return end
	local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local checkAmmo = 0
    if vehicle and vehicle == 1 then
        checkAmmo = 1
    end
    for i=1, QBCore.Config.Player.MaxInvSlots do
        if Player.PlayerData.items[i] and Player.PlayerData.items[i].name == itemName and Player.PlayerData.items[i].info.ammo and Player.PlayerData.items[i].info.ammo > checkAmmo then
            TriggerClientEvent('weapon:client:UseClip', src, 'AMMO_'..string.upper(string.gsub(itemName, '_clip', '')), Player.PlayerData.items[i])
            break
        end
    end
end)

-- Items

-- AMMO
QBCore.Functions.CreateUseableItem('pistol_clip', function(source, item)
    TriggerClientEvent('weapon:client:UseClip', source, 'AMMO_PISTOL', item)
end)

QBCore.Functions.CreateUseableItem('rifle_clip', function(source, item)
    TriggerClientEvent('weapon:client:UseClip', source, 'AMMO_RIFLE', item)
end)

QBCore.Functions.CreateUseableItem('smg_clip', function(source, item)
    TriggerClientEvent('weapon:client:UseClip', source, 'AMMO_SMG', item)
end)

QBCore.Functions.CreateUseableItem('shotgun_ammo', function(source, item)
    TriggerClientEvent('weapon:client:AddAmmo', source, 'AMMO_SHOTGUN', 8, item)
end)

QBCore.Functions.CreateUseableItem('snp_ammo', function(source, item)
    TriggerClientEvent('weapon:client:AddAmmo', source, 'AMMO_SNIPER', 1, item)
end)

QBCore.Functions.CreateUseableItem('taser_ammo', function(source, item)
    TriggerClientEvent('weapon:client:AddAmmo', source, 'AMMO_TASER', 1, item)
end)