-- READ THE DOCS BEFORE USING THIS SCRIPT: https://docs.av-scripts.com/
-- READ THE DOCS BEFORE USING THIS SCRIPT: https://docs.av-scripts.com/
-- READ THE DOCS BEFORE USING THIS SCRIPT: https://docs.av-scripts.com/

Config = {}
Config.Debug = true
Config.DebugCommand = "debug"          -- Used to enable debug mode in the specified resource (only available for av_laptop resources)
Config.Target = "qb-target"            -- Your target script "ox_target", "qb-target", "qtarget"
Config.AdminLevel = "admin"            -- Min admin level needed to use debug command
Config.LaptopItem = "laptop"           -- The item used to open laptop
Config.HackingDeviceITem = 'decrypter' -- Item used to hack laptops.
Config.UseBattery = true               -- true/false, false will make battery infinite
Config.BossGrades = {                  -- This only applies for ESX, many ppl uses different boss grade names (boss, owner, chief, etc) add them here
    ['boss'] = true,
    ['owner'] = true,
}
Config.CustomCryptos = {               -- Only works for QBCore, if you are using metadata cryptos add them here (if u don't know what metadata cryptos are then ignore it or ask your dev but not me)
    ['crypto'] = true,
    ['gne'] = true,
}

-- Some default apps config
Config.UseTerminal = true   -- enable system terminal
Config.Documents = true -- enable system files
Config.Calculator = true -- enable calculator

exports("getFramework", function() -- don't edit/remove this
    return Config.Framework
end)

exports("getInventory", function() -- don't edit/remove this
    return Config.Inventory
end)

exports("getTarget", function() -- don't edit/remove this
    return Config.Target
end)