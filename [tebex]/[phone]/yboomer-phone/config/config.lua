Config = Config or {}

Config.DebugPrint = false  -- Print debug messages to console

Config.Framework = 'auto' --auto | --qbox | --qb | --esx | --standalone
--[[
    Supported frameworks:
        * esx: es_extended, https://github.com/esx-framework/esx-legacy
        * qbox: qbx_core, https://github.com/qbox-project/qbx_core
        * qb: qb-core, https://github.com/qbcore-framework/qb-core
        * standalone: no framework, note that framework specific apps will not work unless you implement the functions in `standalone.lua`. - vMenu basic support included.
--]]

Config.Item = {}

-- If *true, an item will be required to use the phone.
Config.Item.Require = true

-- If *true - `Config.UseableItems` will be registered as useable items.
-- If *false - You will be able to use the phone only with the Keybind(*default: `F1`) - config.keybinds.lua.
-- This will be ignored if `Config.Item.Require` is *false or `Config.Item.UniquePhones` is *true.
Config.Item.Useable = false

-- IMPORTANT: Follow the instruction in our documentation to configure Unique Phones.
-- https://docs.yseries.live/unique-phones
Config.Item.UniquePhones = true

-- The inventory you use. This is required for `Unique Phones` or `Useable Items` to work.
-- IGNORE IF YOU HAVE Config.Item.UniquePhones = *false.
Config.Item.Inventory = 'auto'
--[[
    Supported:
        * ox_inventory - https://github.com/overextended/ox_inventory - Recommended
        * qb-inventory - https://github.com/qbcore-framework/qb-inventory
        * lj-inventory - https://github.com/loljoshie/lj-inventory
        * ps-inventory - https://github.com/Project-Sloth/ps-inventory
        * codem-inventory - https://codem.tebex.io/package/5900973
        * core_inventory - https://www.c8re.store/package/5121548
--]]

-- The items that will be registered as useable items in `server/custom/functions/useableItems.lua`
-- If you're using `ox_inventory` you need to manually add the items in your `items.lua` file.
Config.UseableItems = { "yboomer_black", }

-- ============================= --
--- RECOMENDED TO LEAVE AS TRUE ---
-- ============================= --
Config.CheckForUpdates = true
