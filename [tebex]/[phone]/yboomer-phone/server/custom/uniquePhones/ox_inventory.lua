CreateThread(function()
    if Config.Item.Inventory ~= "ox_inventory" or not Config.Item.UniquePhones or not Config.Item.Require then return end

    ---Function to get all phone items a player has in their inventory
    ---@param source number
    ---@return table items
    local function getPhoneItems(source)
        local items = {}
        for _, itemName in ipairs(Config.UseableItems) do
            local foundItems = exports.ox_inventory:Search(source, "slots", itemName)
            for i = 1, #foundItems do
                if foundItems[i] then
                    items[#items + 1] = foundItems[i]
                end
            end
        end
        return items
    end

    ---Function to check if a player has a phone with a specific number
    ---@param source any
    ---@param imei string
    ---@return boolean
    function HasImeiIdentifier(source, imei)
        debugPrint("Checking if " .. source .. " has a boomer phone item with imei: ", imei)

        local phones = getPhoneItems(source) -- Retrieve all phone items

        for i = 1, #phones do
            local phone = phones[i]
            if phone and phone.metadata and phone.metadata.imei == imei then
                debugPrint("Boomer Phone with imei " .. imei .. " found")
                return true
            end
        end

        debugPrint("Boomer Phone with imei " .. imei .. " not found")
        return false
    end

    lib.callback.register('yboomer:server:generate-phone-imei', function(source, phoneItem)
        local item = exports.ox_inventory:GetSlot(source, phoneItem.slot)

        local newImei = GenerateUniqueIdentifier()

        if not item then return nil end
        if item.metadata then
            item.metadata.imei = newImei
        else
            item.metadata = { imei = newImei }
        end

        exports.ox_inventory:SetMetadata(source, item.slot, item.metadata)

        return newImei
    end)
end)
