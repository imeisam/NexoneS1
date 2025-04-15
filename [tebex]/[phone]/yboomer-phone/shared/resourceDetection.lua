-- ========================= --
--- Framework Normalization ---
-- ========================= --
if (Config.Framework == 'auto' and GetResourceState('qbx_core') == 'started') or Config.Framework == 'qbox' then
    Config.Framework = 'qbox'
elseif (Config.Framework == 'auto' and GetResourceState('qb-core') == 'started') or Config.Framework == 'qb' then
    Config.Framework = 'qb'
elseif (Config.Framework == 'auto' and GetResourceState('es_extended') == 'started') or Config.Framework == 'esx' then
    Config.Framework = 'esx'
elseif Config.Framework == 'standalone' then
    print(
        "^6[YBoomer] ^1[INFO]^7: shared:resourceDetection.lua: You are using the standalone framework. Make sure to implement the functions in `(client/server)/custom/frameworks/standalone.lua`.")
else
    print(
        "^6[YBoomer] ^1[WARNING]^7: shared:resourceDetection.lua: No framework resource found. Make sure to install one of the supported frameworks or set the Config.Framework to \'standalone\'.")
end
-- ========================= --
--- Framework Normalization ---
-- ========================= --

-- ========================= --
--- Inventory Detection ---
-- ========================= --
if Config.Item.Inventory == 'auto' then
    debugPrint('Auto-detecting inventory option...')

    --- A list of supported inventories by default. Do not change this list unless you know what you are doing.
    local inventories = {
        'ox_inventory',
        'qb-inventory',
        'lj-inventory',
        'ps-inventory',
        'codem-inventory',
        'core_inventory',
        'qs-inventory',
        'tgiann-inventory',
    }

    for i = 1, #inventories do
        if GetResourceState(inventories[i]):find('start') then
            Config.Item.Inventory = inventories[i]
            break
        end
    end

    if Config.Item.Inventory == 'auto' then
        print("^6[YBoomer] ^1[WARNING]^7: shared:resourceDetection.lua: No inventory resource found. Certain features may not work.")

        Config.Item.UniquePhones = false

        return
    end

    debugPrint('Auto-detected inventory option: ' .. Config.Item.Inventory)
end
-- ===================== --
--- Inventory Detection ---
-- ===================== --
