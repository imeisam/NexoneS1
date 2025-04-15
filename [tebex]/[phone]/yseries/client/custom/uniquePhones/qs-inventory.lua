CreateThread(function()
    if Config.Item.Inventory ~= "qs-inventory" then return end

    ---Function to get all items a player has with a specific name
    ---@param name string
    ---@return table items
    local function getItemsByName(name)
        local items = {}
        local inventory = exports['qs-inventory']:getUserInventory()
        for _, item in pairs(inventory) do
            if item?.name == name then
                items[#items + 1] = item
            end
        end

        return items
    end

    --- Get all sim card items from a player's inventory
    ---@return table
    function GetSimCardItems()
        local simCardItems = {}

        local cards = getItemsByName(Config.Sim.ItemName)
        for i = 1, #cards do
            local card = cards[i]

            if card and (not card.info?.cardId or not card.info?.simNumber) then
                local simCardDetails = lib.callback.await('yseries:server:generate-sim-card-details')
                if not simCardDetails then debugPrint('Failed to generate or seed sim card details') end

                lib.callback.await('yseries:server:assign-item-metadata', false, card, simCardDetails)

                card.info.cardId = simCardDetails.cardId
                card.info.simNumber = simCardDetails.simNumber
            end

            if card.info and card.info.cardId and card.info.simNumber then
                simCardItems[#simCardItems + 1] = {
                    id = card.info.cardId,
                    number = card.info.simNumber,
                }
            end
        end

        return simCardItems
    end

    -- If unique phones are not enabled or not required, do not execute the rest of the code.
    if not Config.Item.UniquePhones or not Config.Item.Require then return end

    function HasImeiIdentifier(imei)
        -- Iterate over each item name in the list of usable items
        for _, itemName in ipairs(Config.UseableItems) do
            local phones = getItemsByName(itemName) -- Get items by current name
            -- Check each phone for the specified IMEI
            for i = 1, #phones do
                local phone = phones[i]
                if phone and phone.info and phone.info.imei == imei then
                    return true
                end
            end
        end

        return false
    end

    function GetImeiFromItem(item)
        return item?.info?.imei
    end

    RegisterNetEvent("yseries:use-phone-item", function(phoneItem)
        local active = SetupPhone(phoneItem)

        if active then
            ToggleOpen(true)
        end
    end)

    RegisterNetEvent('yseries:phone-item-added', function()
        debugPrint('Phone item added')
    end)

    RegisterNetEvent('yseries:phone-item-removed', function()
        Wait(500)

        if Config.Item.UniquePhones and CurrentPhoneImei and not HasImeiIdentifier(CurrentPhoneImei) then
            PhoneDropped()

            local _phoneImei = CurrentPhoneImei

            RemovePrimaryPhone(PlayerData.identifier, CurrentPhoneImei)

            if not HasPrimaryPhone then
                debugPrint('Removed primary phone item with imei: ' .. _phoneImei)
            else
                debugPrint('Could not remove primary phone item with imei: ' .. _phoneImei)
            end
        end
    end)
end)
