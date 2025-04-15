local QBCore = exports['qb-core']:GetCoreObject()

local usb = {}
local safeAttempts = Config.Safe.attempts

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        if Config.Inventory == 'ox' then
            local data = Config.WasherInventory
            for id, stash in pairs(Config.LaundryMachines) do
                exports.ox_inventory:ClearInventory('laundromat_'..id)
                Wait(100)
                exports.ox_inventory:RegisterStash('laundromat_'..id, data.label, 1, data.weight, nil, nil, stash.coords)
            end
        else
            local data = Config.WasherInventory
            for id, stash in pairs(Config.LaundryMachines) do
                MySQL.Async.fetchAll('SELECT * FROM stashitems WHERE stash = @stash', {
                    ['@stash'] = 'laundromat_'..id
                }, function(result)
                    if result[1] == nil then
                        MySQL.Async.insert('INSERT INTO stashitems (stash, items) VALUES (@stash, @items)', {
                            ['@stash'] = 'laundromat_'..id,
                            ['@items'] = json.encode({})
                        })
                    end
                end)
            end
        end
    end
end)

----------------------
----------------------
-- STATE EVENTS ------
----------------------
----------------------

RegisterNetEvent('nyx-laundromat:updateoxlocks', function(doorId, state)
    local doorLock = exports.ox_doorlock:getDoorFromName(doorId)
    if doorLock then
        exports.ox_doorlock:setDoorState(doorLock.id, state)
    else
        print('Door not found...ensure to run sql file to add doors to the database')
    end
end)

RegisterNetEvent('nyx-laundromat:setbusystate', function(id, state)
    TriggerClientEvent('nyx-laundromat:setbusystate', -1, id, state)
end)

RegisterNetEvent('nyx-laundromat:setcutstate', function(id, state)
    TriggerClientEvent('nyx-laundromat:setcutstate', -1, id, state)
end)

RegisterNetEvent('nyx-laundromat:openstate', function(id, state)
    TriggerClientEvent('nyx-laundromat:openstate', -1, id, state)
end)

RegisterNetEvent('nyx-laundromat:minusattempts', function()
    TriggerClientEvent('nyx-laundromat:minusattempts', -1, 1)
end)

RegisterNetEvent('nyx-laundromat:resetattempts', function()
    TriggerClientEvent('nyx-laundromat:resetattempts', -1, safeAttempts)
end)

----------------------
----------------------
-- END STATE EVENTS --
----------------------
----------------------

RegisterNetEvent('nyx-laundromat:togglealarm', function(id, trigger, coords)
    if trigger then
        TriggerEvent('chHyperSound:play', id, 'security_alarm', true, coords, 80.0, -1)
    else
        TriggerEvent('chHyperSound:stop', id, -1)
    end
end)

function CheckJobs(Player)
    for key, jobName in pairs(Config.PoliceJobs) do
        if Player.PlayerData.job.name == jobName then
            return true
        end
    end
end

function SetStashItem(amount)
	local items = {}
    local itemInfo = QBCore.Shared.Items[Config.WasherRewards.item:lower()]
    items[1] = {
        name = itemInfo["name"],
        amount = tonumber(amount),
        info = {},
        label = itemInfo["label"],
        description = itemInfo["description"] and itemInfo["description"] or "",
        weight = itemInfo["weight"],
        type = itemInfo["type"],
        unique = itemInfo["unique"],
        useable = itemInfo["useable"],
        image = itemInfo["image"],
        slot = 1,
    }
    return items
end

function GetRandomUsb()
    local totalChance = 0
    for _, item in ipairs(Config.Usb.item) do
        totalChance = totalChance + item.chance
    end

    local chance = math.random(1, totalChance)
    local itemChance = 0
    for _, item in ipairs(Config.Usb.item) do
        itemChance = itemChance + item.chance
        if chance <= itemChance then
            return item.name
        end
    end

    return nil
end

function GetCopCount()
    return CurrentCops >= Config.PoliceNeeded
end
RegisterNetEvent('police:SetCopCount', function(amount,amounthigh)
    CurrentCops = amount
end)
lib.callback.register('nyx-laundromat:hasenoughcops', function(source)
    return CurrentCops >= Config.PoliceNeeded
end)

RegisterNetEvent('nyx-laundromat:setupwasherinteracts', function(bool)
    if not bool then return end
    for id, data in pairs(Config.LaundryMachines) do
        local amount = math.random(Config.WasherRewards.amount.min, Config.WasherRewards.amount.max)
        if Config.Inventory == 'ox' then
            exports.ox_inventory:AddItem('laundromat_'..id, Config.WasherRewards.item, amount)
        else
            MySQL.Async.insert('INSERT INTO stashitems (stash, items) VALUES (:stash, :items) ON DUPLICATE KEY UPDATE items = :items', {
                ['stash'] = 'laundromat_'..id,
                ['items'] = json.encode(SetStashItem(amount))
            })
        end
    end

    for _, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if CheckJobs(Player) then
                TriggerClientEvent('nyx-laundromat:setuprestorepower', Player.PlayerData.source)
            end
        end
    end

    TriggerClientEvent('nyx-laundromat:setupwasherinteracts', -1, bool)
end)

RegisterNetEvent('nyx-laundromat:setupofficeinteracts', function(bool)
    if not bool then return end
    
    local netId = nil
    local usbChance = math.random(1, 100)
    
    if usbChance <= Config.Usb.usbchance then
        local hash = `hei_prop_hst_usb_drive`
        local coords = Config.Usb.coords
        local usb = CreateObject(hash, coords.x, coords.y, coords.z, true, true, true)
        if DoesEntityExist(usb) then
            Wait(100)
            netId = NetworkGetNetworkIdFromEntity(usb)
            usb = {netId = netId, object = usb}
        else
            print("Failed to create USB object.")
        end
    end
    
    TriggerClientEvent('nyx-laundromat:setupofficeinteracts', -1, bool, netId)
end)


RegisterNetEvent('nyx-laundromat:takeusb', function()
    if not usb and not usb.netId then return end
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    local object = NetworkGetEntityFromNetworkId(usb.netId)
    DeleteEntity(object)
    Wait(100)
    if not DoesEntityExist(object) then
        usb = {}
        local usbItem = GetRandomUsb()
        if Config.Inventory == 'ox' then
            local success = exports.ox_inventory:AddItem(PlayerId, usbItem, 1)
            if success then
                TriggerClientEvent('QBCore:Notify', PlayerId, 'You found a usb drive', 'success')
            end
        else
            Player.Functions.AddItem(usbItem, 1, false)
        end
    end
end)

lib.callback.register('nyx-laundromat:removedgenusb', function(source, data)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    local removed = false
    if Config.Inventory == 'ox' then
        if exports.ox_inventory:RemoveItem(PlayerId, data.requireditem, 1) then
            removed = true
        end
    else
        if Player.Functions.RemoveItem(data.requireditem, 1, false) then
            TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[data.requireditem], 'remove')
            removed = true
        end
    end
    return removed
end)

RegisterNetEvent('nyx-laundromat:givesafepayout', function (powerCut, safeState)
    if not powerCut and not safeState then return end
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    local safeCoords = Config.Safe.coords
    local playerCoords = GetEntityCoords(GetPlayerPed(PlayerId))
    local distance = #(playerCoords - safeCoords)
    if distance <= 6.0 then
        local metadata = { worth = 1, }
        local item = Config.Safe.reward.item
        local amount = math.random(Config.Safe.reward.amount.min, Config.Safe.reward.amount.max)
        local disc=""
        if Config.Inventory == 'ox' then
            local success, response = exports.ox_inventory:AddItem(PlayerId, item, amount, metadata)
            if not success then
                TriggerClientEvent('QBCore:Notify', PlayerId, 'Inventory seems full', 'error', 6000)
            end
        else
            Player.Functions.AddItem(item, amount, false, metadata)
            TriggerClientEvent('inventory:client:ItemBox', PlayerId,  QBCore.Shared.Items[item], 'add', amount)
            local chance=math.random(1,100)
            if chance<=30 then
                Player.Functions.AddItem('laptopg', amount)
                TriggerClientEvent('inventory:client:ItemBox', PlayerId,  QBCore.Shared.Items['laptopg'], 'add')
                disc= QBCore.Shared.Items['laptopg'].label
            elseif chance<=50 then
                Player.Functions.AddItem('cardg', amount)
                TriggerClientEvent('inventory:client:ItemBox', PlayerId,  QBCore.Shared.Items['cardg'], 'add')
                disc= QBCore.Shared.Items['cardg'].label
            end
            
        TriggerEvent('qb-log:server:CreateLog', 'lundermat', 'Laundromat Robbery', 'green', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.citizenid .. ') |\n Loot: '..amount..' X - '..QBCore.Shared.Items[item].label..' - \n'..disc)

        end
    else
        DropPlayer(PlayerId, 'Error')
    end
end)