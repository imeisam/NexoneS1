CreateThread(function()
    if Config.Framework ~= 'qb' then return end

    debugPrint("Phone:QB:Loading Framework")

    local Framework = exports['qb-core']:GetCoreObject()

    while not LocalPlayer.state.isLoggedIn do Wait(500) end

    debugPrint("Phone:QB:Framework loaded")

    local QBPlayerData = Framework.Functions.GetPlayerData()

    PlayerData = { identifier = QBPlayerData.citizenid }

    local function onPlayerLoggedIn()
        -- * Query yphone_holders to find if there are any phones for the player.
        -- * If there are, set the current phone imei to the first one and load the phone data.
        local phoneImei = lib.callback.await('yboomer:server:get-primary-phone', false, Imei(PlayerData.identifier))
        if phoneImei then
            debugPrint('Found phone for player: ', PlayerData.identifier, ' with imei: ', phoneImei)

            DataLoaded = false
            LoadPhoneData(phoneImei)
        else
            debugPrint('onPlayerLoggedIn: No phone found for player: ', PlayerData.identifier)
        end
    end

    if LocalPlayer.state.isLoggedIn then
        debugPrint("Phone:QB:Player loaded")
        QBPlayerData = Framework.Functions.GetPlayerData()

        onPlayerLoggedIn()
    end

    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        QBPlayerData = Framework.Functions.GetPlayerData()

        PlayerData = { identifier = QBPlayerData.citizenid }

        onPlayerLoggedIn()
    end)

    RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
        TriggerServerEvent('yseries:server:cleanup')

        PlayerData.identifier = nil

        ToggleOpen(false)
        HasPrimaryPhone = false

        SendUIAction('main:reset-phone-ui') -- TODO: Impelemnt this event in the UI
    end)

    -- * Check if a player has any of the usable phone items.
    function HasPhoneItem(phoneImei)
        if not Config.Item.Require then
            return true
        end

        -- Check if ox_inventory is started
        if GetResourceState("ox_inventory") == "started" then
            for _, itemName in ipairs(Config.UseableItems) do
                if (exports.ox_inventory:Search("count", itemName) or 0) > 0 then
                    return true
                end
            end

            return false -- If none of the items were found
        end

        -- Check for unique phones with IMEI
        if Config.Item.UniquePhones and phoneImei then
            return HasImeiIdentifier(phoneImei)
        else
            -- Fallback for other inventory systems or if unique phone check is not required
            for _, itemName in ipairs(Config.UseableItems) do
                if Framework.Functions.HasItem(itemName) then
                    return true
                end
            end

            return false -- If none of the items were found
        end
    end

    -- * Send a notification to a player.
    function Notify(messageData)
        lib.notify(messageData)
    end
end)
