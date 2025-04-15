QBConfig = {}

QBConfig.DefaultSpawn = vector4(-1035.71, -2731.87, 12.86, 0.0)
QBConfig.UpdateInterval = 5 -- how often to update player data in minutes
QBConfig.StatusInterval = 5000 -- how often to check hunger/thirst status in milliseconds

QBConfig.Money = {}
QBConfig.Money.MoneyTypes = {['paycheck'] = 0, ['bank'] =5000, ['gne'] =0, ['cosmo'] =0} -- ['type'] = startamount - Add or remove money types for your server (for ex. ['blackmoney'] = 0), remember once added it will not be removed from the database!
QBConfig.Money.DontAllowMinus = {'paycheck', 'bank', 'gne', 'cosmo'} -- Money that is not allowed going in minus

QBConfig.Player = {}
QBConfig.Player.MaxWeight = 100000 -- Max weight a player can carry (written in grams)
QBConfig.Player.MaxInvSlots = 20 -- Max inventory slots for a player
QBConfig.Player.BackPackSlot = 30 -- Max Backpack slots for a player
QBConfig.Player.HungerRate = 4.2 -- Rate at which hunger goes down.
QBConfig.Player.ThirstRate = 3.8 -- Rate at which thirst goes down.
QBConfig.Player.Bloodtypes = {
    "A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-",
}

QBConfig.Server = {} -- General server config
QBConfig.Server.Discord = "https://discord.gg/th8r3Tnq2z" -- Discord invite link
QBConfig.Server.Licenses = {  -- Player Licenses
    ['driver'] = true,
    ['air'] = false,
    ['boat'] = false,
    ['weapon'] = false,
    ['hunting'] = false
}