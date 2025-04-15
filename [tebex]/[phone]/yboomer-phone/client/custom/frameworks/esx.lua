CreateThread(function()
    if Config.Framework ~= "esx" then return end

    debugPrint("Phone:ESX:Loading Framework")

    OnPlayerLoadedEvent = "esx:playerLoaded"
    OnPlayerUnloadedEvent = "esx:onPlayerLogout"
    OnJobUpdateEvent = "esx:setJob"

    PlayerData = {}

    local export, Framework = pcall(function() return exports.es_extended:getSharedObject() end)

    if not export then
        while not Framework do
            TriggerEvent("esx:getSharedObject", function(obj)
                Framework = obj
            end)

            Wait(500)
        end
    end

    CreateThread(function()
        while Framework.GetPlayerData().job == nil do
            Wait(100)
        end

        PlayerData = Framework.GetPlayerData()
    end)

    RegisterNetEvent(OnPlayerLoadedEvent, function(xPlayer)
        PlayerData = xPlayer

        Framework.PlayerLoaded = true

        local phoneImei = lib.callback.await('yboomer:server:get-primary-phone', false, Imei(PlayerData.identifier))
        if phoneImei then
            debugPrint('Found phone for player: ', PlayerData.identifier, ' with imei: ', phoneImei)

            DataLoaded = false
            LoadPhoneData(phoneImei)
        else
            debugPrint('OnPlayerLoadedEvent: No phone found for player: ', PlayerData.identifier)
        end
    end)

    RegisterNetEvent(OnPlayerUnloadedEvent, function()
        TriggerServerEvent('yseries:server:cleanup')

        PlayerData.identifier = nil

        ToggleOpen(false)
        HasPrimaryPhone = false

        SendUIAction('main:reset-phone-ui') -- TODO: Impelemnt this event in the UI
    end)

    while not Framework.PlayerLoaded do Wait(500) end

    debugPrint("Phone:ESX:Framework loaded")

    -- * Check if a player has a phone item.
    function HasPhoneItem(phoneImei)
        if not Config.Item.Require then
            return true
        end

        -- Check for unique phone IMEI in the inventory if required
        if GetResourceState("ox_inventory") == "started" then
            if Config.Item.UniquePhones and phoneImei then
                return HasImeiIdentifier(phoneImei)
            else
                -- Iterate through Config.UseableItems to check each one in the inventory
                for _, itemName in ipairs(Config.UseableItems) do
                    if (exports.ox_inventory:Search("count", itemName) or 0) > 0 then
                        return true
                    end
                end
            end
        else
            -- Fallback for other inventory systems not using ox_inventory
            local inventory = Framework.GetPlayerData()?.inventory
            if not inventory then
                print("^6[YSERIES] ^3[Warning]^0: Unsupported inventory, tell the inventory author to add support for it.")
                return false
            end

            for _, item in ipairs(inventory) do
                if lib.table.contains(Config.UseableItems, item.name) and item.count > 0 then
                    return true
                end
            end
        end

        return false
    end

    -- * Send a notification to a player.
    function Notify(messageData)
        lib.notify(messageData)
    end
end)
