local JoinCoolDown = {}

-- Event Handler

AddEventHandler('chatMessage', function(_, _, message)
    if string.sub(message, 1, 1) == '/' then
        CancelEvent()
        return
    end
end)

AddEventHandler('playerDropped', function(reason)
    local src = source
    if not QBCore.Players[src] then return end
    local Player = QBCore.Players[src]
    local ped = GetPlayerPed(src)
    local pcoords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    local vehicletext = ''
    local vehiculoPed = GetVehiclePedIsIn(ped, false)
    if vehiculoPed ~= 0 then
        vehicletext = '\n Vehicle: '..GetEntityModel(vehiculoPed)
    end
    TriggerEvent('qb-log:server:CreateLog', 'disconnect', 'Dropped', 'red', GetPlayerName(src) .. ' ( <@' .. string.gsub(Player.PlayerData.discord, 'discord:', '') .. '> | '..src..' )\n '..Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname..'  ('..Player.PlayerData.citizenid..')\n Reason: ' .. reason..'\n Coords: '..pcoords..'\n Heading: '..heading..vehicletext)
    Player.Functions.Save()
    QBCore.Player_Buckets[Player.PlayerData.discord] = nil
    if QBCore.Player_Permissions[Player.PlayerData.discord] ~= nil then
        QBCore.Player_Permissions[Player.PlayerData.discord] = nil
    end
    QBCore.Players[src] = nil
    if JoinTimes[src] then
        JoinTimes[src] = nil
    end
end)

-- Player Connecting

local function onPlayerConnecting(name, setKickReason, deferrals)
    local src = source
    local discord = QBCore.Functions.GetIdentifier(src, 'discord')
    local token = GetNumPlayerTokens(src)
    deferrals.defer()
    Wait(0)

    deferrals.update(string.format(Lang:t('info.checking_ident'), name))
    Wait(500)

    if not token or token == 0 or token < 0 or token == "null" or token == "**Invalid**" or not discord then
        deferrals.done(Lang:t('error.no_valid_cl'))
        CancelEvent()
        return
    end

    Wait(500)

    if JoinCoolDown[discord] == nil then
        JoinCoolDown[discord] = os.time()
    elseif os.time() - JoinCoolDown[discord] < 15 then
        deferrals.done(Lang:t('error.dont_spam'))
        CancelEvent()
        return
    else
        JoinCoolDown[discord] = nil
    end

    Wait(500)

    if QBCore.Functions.IsIdentifierDublicate(discord) then
        deferrals.done(Lang:t('error.duplicate_identifer'))
        CancelEvent()
        return
    end

    deferrals.update(Lang:t('info.checking_ban'))

    local isBanned, Reason = IsPlayerBanned(src)
    if isBanned then
        print(Reason)
    end
    Wait(2000)

    if isBanned then
        deferrals.done(Reason)
        CancelEvent()
        return
    end

    deferrals.update(Lang:t('info.join_server'))

    Wait(1000)

    deferrals.done()
end

AddEventHandler('playerConnecting', onPlayerConnecting)

-- Callbacks

RegisterNetEvent('QBCore:Server:TriggerCallback', function(name, ...)
    local src = source
    QBCore.Functions.TriggerCallback(name, src, function(...)
        TriggerClientEvent('QBCore:Client:TriggerCallback', src, name, ...)
    end, ...)
end)

-- Player

RegisterNetEvent('QBCore:UpdatePlayer', function(hungerRate, thirstRate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local newHunger = Player.PlayerData.metadata['hunger'] - hungerRate
    local newThirst = Player.PlayerData.metadata['thirst'] - thirstRate
    if newHunger <= 0 then
        newHunger = 0
    end
    if newThirst <= 0 then
        newThirst = 0
    end
    Player.Functions.SetMetaData('thirst', newThirst)
    Player.Functions.SetMetaData('hunger', newHunger)
    TriggerClientEvent('hud:client:UpdateNeeds', src, newHunger, newThirst)
end)

RegisterNetEvent('QBCore:Server:SetMetaData', function(meta, data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if meta == 'hunger' or meta == 'thirst' then
        if data > 100 then
            data = 100
        end
    end
    if Player then
        Player.Functions.SetMetaData(meta, data)
    end
    TriggerClientEvent('hud:client:UpdateNeeds', src, Player.PlayerData.metadata['hunger'], Player.PlayerData.metadata['thirst'])
end)

RegisterNetEvent('QBCore:ToggleDuty', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if Player.PlayerData.job.onduty then
        Player.Functions.SetJobDuty(false)
        TriggerClientEvent('QBCore:Notify', src, Lang:t('info.off_duty'))
    else
        Player.Functions.SetJobDuty(true)
        TriggerClientEvent('QBCore:Notify', src, Lang:t('info.on_duty'))
    end
    TriggerClientEvent('QBCore:Client:SetDuty', src, Player.PlayerData.job.onduty)
end)

-- Vehicle

RegisterNetEvent('QBCore:server:DeleteVehicle', function(VehNetId)
    local vehicle = NetworkGetEntityFromNetworkId(VehNetId)
    if vehicle and DoesEntityExist(vehicle) then
        DeleteEntity(vehicle)
    end
end)

-- Items

RegisterNetEvent('QBCore:Server:RemoveItem', function(itemName, amount, slot)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.RemoveItem(itemName, amount, slot)
end)

RegisterNetEvent('QBCore:Server:AddItem', function(itemName, amount, slot,info)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.AddItem(itemName, amount, slot,info)
end)


-- Has Item Callback (can also use client function - QBCore.Functions.HasItem(item))

QBCore.Functions.CreateCallback('QBCore:HasItem', function(source, cb, items, amount, withbackpack, noQuality)
    cb(QBCore.Functions.HasItem(source, items, amount, withbackpack, noQuality))
end)

-- Auto Restart

RegisterNetEvent('txAdmin:events:scheduledRestart', function(eventData)
    if eventData.secondsRemaining == 60 then
        for k in pairs(QBCore.Players) do
            DropPlayer(k, 'Scheduled Restart')
        end
    end
    if eventData.secondsRemaining == (5*60) then
        TriggerEvent('qb-weathersync:server:restartweather')
    end
    if eventData.secondsRemaining == (2*60) then
        TriggerEvent('qb-weathersync:server:restartweatherblackout')
    end
end)

RegisterNetEvent('QBCore:server:AddVehicle', function(mods, vehicle, plate)
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') then
        if vehicle.model and QBCore.Shared.Vehicles[vehicle.model] then
            local Player = QBCore.Functions.GetPlayer(src)
            local result = MySQL.query.await('SELECT plate FROM player_vehicles WHERE plate = ?', { plate })
            if result[1] == nil then
                MySQL.insert('INSERT INTO player_vehicles (citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?)', {
                    Player.PlayerData.citizenid,
                    vehicle.model,
                    vehicle.hash,
                    json.encode(mods),
                    plate,
                    0
                })
                TriggerClientEvent('QBCore:Notify', src, 'Added', 'success', 5000)
            else
                TriggerClientEvent('QBCore:Notify', src, 'This Plate Has Been Taken', 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', src, 'This Vehicle is not Available in Shared', 'error')
        end
    end
end)

RegisterNetEvent('inventory:server:closedinv', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local changed = false
    local maxSlot = Player.PlayerData.metadata["backpack"] and (QBConfig.Player.BackPackSlot + QBConfig.Player.MaxInvSlots) or QBConfig.Player.MaxInvSlots
    for i = 1, maxSlot, 1 do
        if Player.PlayerData.items[i] and Player.PlayerData.items[i].name and Player.PlayerData.items[i].amount <= 0 then
            Player.PlayerData.items[i] = nil
            if not changed then
                changed = true
            end
        end
    end
    if changed then
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)