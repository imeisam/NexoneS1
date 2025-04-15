-- READ THE DOCS BEFORE USING THIS SCRIPT: https://docs.av-scripts.com/
-- Add your webhook for logs in server/editable/_webhook.lua

Config = {}
Config.Debug = true
Config.AdminLevel = "admin" -- Level needed to delete ads
Config.App = {
    name = "marketplace",
    label = "Marketplace", -- You can rename the app by editing this field
    isEnabled = function()
        return true
    end
}

function dbug(...)
    if Config.Debug then print ('^3[DEBUG]^7', ...) end
end