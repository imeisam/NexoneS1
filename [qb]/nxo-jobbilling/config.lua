Config = {}

Config.useTarget = false	    -- Use QB Target to enable the billing
Config.useCommand = false	-- Use QB Target to enable the billing
Config.useCash = false		-- Abillity to use cash for billing/ If false then Banking
Config.job={-- to bank job
    ['goverment']={com=0},
    ['police']={com=0},
    ['catcafe']={com=0.8},
    ['pawnshop']={com=0.8},
    ['gallery']={com=0.8},
    ['digitalden']={com=0.8},
    ['snrsushi']={com=0.4},
    ['snrcoffee']={com=0.8},
    ['snrbuns']={com=0.8},
    ['mechanicsh']={com=0.8},
    ['tuner']={com=0.95},
    ['hotdog']={com=0.8},
    ['snrsmoothie']={com=0.8},
    ['realestate']={com=0.8},
    ['tequilala']={com=0.8},
    ['snrpizza']={com=0.8},
    ['yellowjack']={com=0.8},
}
-- Add this in your QB-Target Init.lua and set useTraget to true

--[[
    Config.GlobalPlayerOptions = {
        options = {
            {
            type = "client",
            event = "jerzys_billing:client:openBillingMenu",
            icon = 'fas fa-phone',
            label = 'Generate a bill',
            },
        }
    }
]]--