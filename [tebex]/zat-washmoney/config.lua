Config = {}

-- Framework : 
--            "qb"  : QBCORE
--            "esx" : ESX
Config.Framework = "qb"

-- INVENTORY : 
--            "qb"      : qb-inventory
--            "ox"      : ox-inventory        
--            "origen"  : origen_inventory
--            "ps"      : ps-inventory

Config.Inventory            = "qb"
Config.QBInventory          = "old" -- new
Config.WashMachinehWeight   = 4000000                               -- you can change this
Config.WashedPerSecond      = 0.5                                   -- this is how money marked bills gets washed in 1 second (The less it is, the more time it takes washing)
Config.ItemsToWash          = "banded_cash"                         -- Item To wash
Config.RewardItem           = "washedmoney"                            -- Reward Item 
Config.TaxperItemToWash     = 0                                    -- Taxes the playr 25 dollars for every item to wash.
Config.MachineProp          = "bkr_prop_prtmachine_dryer_op"        -- prop to use closed
Config.MachinePropOpen      = "bkr_prop_prtmachine_dryer_spin"      -- prop to use closed

-- If true you will get Config.ItemsTowash worth amount of the Config.RewardItem item . 
-- example : if you wash 5x markedbills with worth 5k you will get 25k of rollcash with no worth.

-- If false you will get the reward item with same worth info as the Config.ItemsTowash.
-- example : if you wash 5x markedbills with worth 5k you will get 5x rollcash with worth 5k.
Config.GetWorth = false 
