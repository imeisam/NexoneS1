-- READ THE DOCS BEFORE USING THIS SCRIPT: https://docs.av-scripts.com/
Config = {}
Config.Debug = false
Config.App = {
    name = "darkmarket",
    label = "Dark Market", -- You can rename the app by editing this field
    isEnabled = function()
        if exports['av_laptop']:hasJob("police") then -- u can use job name or job type
            return false
        end
        return (exports['av_laptop']:WiFi() == "tuner")
    end
}
Config.MoneyAccounts = { -- Money accounts used to buy items
    {name = "cosmo", label = "GNE", icon = "fa-brands fa-ethereum"},
    {name = "bank", label = "Bank", icon = "fa-solid fa-wallet"},
}

--[[
    This is just an EXAMPLE on how to fill the metadata field:
    If u don't want metadata just leave it empty: metadata = {}
    {name = "drug_package", label = "Drug Ingredients", metadata = {purity = "100%", strain = "AV Scripts"}, category = "drugs", stock = 5, price = 1, account = "cosmo", accountLabel = "Cosmo"},
]]

Config.Categories = {
    ['hacker'] = { 
        label = "Hacker", -- category label, how the player will see it in laptop
        canAccess = function() -- do a client side check here, true/false if the player can access the category
            if exports['av_laptop']:getJob().name == "police" then
                return false
            end
            return true
        end,
        items = {
            {name = "race_dongle", label = "Race Dongle", metadata = {}, stock = 20, price = 1500, account = "bank", accountLabel = "Bank"},
            {name = "vpn", label = "VPN", metadata = {}, stock = 5, price = 7000, account = "bank", accountLabel = "Bank"},
            {name = "fake_plate", label = "Fake Plate", metadata = {}, stock = 5, price = 15, account = "cosmo", accountLabel = "GNE"},
            {name = "transponder", label = "Transponder", metadata = {}, stock = 5, price = 4000, account = "bank", accountLabel = "Bank"},
            {name = "hacking_device", label = "Hacking Device", metadata = {}, stock = 5, price = 15, account = "cosmo", accountLabel = "GNE"},
        }
    }, 
    ["drugs"] = { 
        label = "Drugs", -- category label, how the player will see it in laptop
        canAccess = function() -- do a client side check here, true/false if the player can access the category
            if exports['av_laptop']:getJob().name == "police" then
                return false
            end
            if GetResourceState('av_gangs') ~= "started" then
                return false
            end
            local gang = exports['av_gangs']:getGang()
            if gang and gang['name'] then -- If is member of any gang can access
                return true
            end
            return false
        end,
        items = {
            {name = "water", label = "Water", metadata = {}, category = "drugs", stock = 5, price = 1, account = "cosmo", accountLabel = "Cosmo"},
        }
    },
    ["weapons"] = { 
        label = "Weapons", -- category label, how the player will see it in laptop
        canAccess = function() -- do a client side check here, true/false if the player can access the category
            if exports['av_laptop']:getJob().name == "police" then
                return false
            end
            if GetResourceState('av_gangs') ~= "started" then
                return false
            end
            local gang = exports['av_gangs']:getGang()
            if gang and gang['name'] == "ballas" then -- If is member of Ballas gang can access
                return true
            end
            return false
        end,
        items = {
            {name = "weapon_pistol", label = "Pistol", metadata = {}, category = "weapons", stock = 5, price = 5000, account = "cosmo", accountLabel = "Cosmo"},
        }
    },
}