CreateThread(function()
    if Config.Framework ~= 'qbox' then return end

    debugPrint("YBoomer:QBX:Loading Framework")

    while not LocalPlayer.state.isLoggedIn do Wait(500) end

    debugPrint("YBoomer:QBX:Framework loaded")

    local QBXPlayerData = exports.qbx_core:GetPlayerData()

    PlayerData = { identifier = QBXPlayerData.citizenid }

    local function onPlayerLoggedIn()
        -- * Query yphone_holders to find if there are any phones for the player.
        -- * If there are, set the current phone imei to the first one and load the phone data.
        local phoneImei = lib.callback.await('yboomer:server:get-primary-phone', false, Imei(PlayerData.identifier))
        if phoneImei then
            debugPrint('Found phone for player: ', PlayerData.identifier, ' with imei: ', phoneImei)

            DataLoaded = false
            LoadPhoneData(Imei(phoneImei))
        else
            debugPrint('onPlayerLoggedIn: No phone found for player: ', PlayerData.identifier)
        end
    end

    if LocalPlayer.state.isLoggedIn then
        debugPrint("Phone:QBX:Player loaded")
        QBXPlayerData = exports.qbx_core:GetPlayerData()

        onPlayerLoggedIn()
    end

    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        QBXPlayerData = exports.qbx_core:GetPlayerData()

        PlayerData = { identifier = QBXPlayerData.citizenid, }

        onPlayerLoggedIn()
    end)

    RegisterNetEvent('qbx_core:client:playerLoggedOut', function()
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
            return false -- If none of the items were found
        end
    end

    -- * Send a notification to a player.
    function Notify(messageData)
        lib.notify(messageData)
    end
end)
