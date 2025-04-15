-- READ THE DOCS BEFORE USING THIS SCRIPT: https://docs.av-scripts.com/
Config = {}
Config.Debug = false
Config.App = {
    name = "darkmarket",
    label = "Dark Market", -- You can rename the app by editing this field
    isEnabled = function()
        return true
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
            {name = "water", label = "Water", metadata = {}, category = "drugs", stock = 5, price = 1, account = "cosmo", accountLabel = "GNE"},
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
            {name = "weapon_pistol", label = "Pistol", metadata = {}, category = "weapons", stock = 5, price = 5000, account = "cosmo", accountLabel = "GNE"},
        }
    },
}