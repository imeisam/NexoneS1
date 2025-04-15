local QBCore = exports['qb-core']:GetCoreObject()

lib.callback.register('nyx-exchange:hasenoughcops', function(source)
    local copsOnDuty = 0
    for _, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if CheckJobs(Player) then
                copsOnDuty = copsOnDuty + 1
            end
        end
    end
    print(copsOnDuty)
    return copsOnDuty >= Config.PoliceNeeded
end)


RegisterNetEvent('nyx-exchange:togglealarm', function(id, trigger, coords)
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

RegisterNetEvent('nyx-exchange:server:DeleteObject', function(netId)
    local object = NetworkGetEntityFromNetworkId(netId)
	DeleteEntity(object)
end)


RegisterNetEvent('nyx-exchange:server:SetTrollyBusy', function(index, state)
    Config.trollys.trolly[index].taken = state
    TriggerClientEvent('nyx-exchange:client:SetTrollyBusy', -1, index, state)
end)


RegisterNetEvent('nyx-exchange:server:setbusystate', function(id, state)
    if id == 'generator' then
        Config.PowerLocations[id].isBusy = state
    elseif id == 'alarm' then
        Config.PowerLocations[id].isBusy = state
    elseif id == 'doorhack' then
        Config.PowerLocations[id].isBusy = state
    else
        Config.LaundryMachines[id].isBusy = state
    end
    print('here is the states', id,state)
    TriggerClientEvent('nyx-exchange:client:setbusystate', -1, id, state)
end)


RegisterNetEvent('nyx-exchange:givetrollyreward', function ()
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    local metadata = { worth = 1, }
    local item = Config.reward.reward.item
    local amount = math.random(Config.reward.reward.amount.min, Config.reward.reward.amount.max)
    if Config.Inventory == 'ox' then
        local success, response = exports.ox_inventory:AddItem(PlayerId, item, amount, metadata)
        if not success then
            TriggerClientEvent('QBCore:Notify', PlayerId, 'Inventory seems full', 'error', 6000)
        end
    else
        Player.Functions.AddItem(item, amount, false, metadata)
        TriggerClientEvent('inventory:client:ItemBox', PlayerId,  QBCore.Shared.Items[item], 'add', amount)
    end
end)