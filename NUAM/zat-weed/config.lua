Config = {}

-- Framework : 
--                    "qb"  : QBCORE
--                    "esx" : ESX
Config.Framework    = "qb" -- "esx"
------------------------ ONLY FOR QBCORE --------------------------
Config.FrameworkPseudo = "qb-core"


-------------------------------------------------------------------
-- Inventory : 
--                    "qb"  : QBCORE : "qb", "origen", "ps", "ox"
--                    "esx" : ESX    : only "ox"
Config.Inventory    = "qb" -- "qb", "origen", "ps", "ox" , "qs"
-----------         -------------         --------         --------
--!!!!!!!!!!!!!!!!!!!! IMPORTANT !!!!!!!!!!!!!!!!!!!!!!!!!!
-- if you use qb-inventory please check which version you 
-- are using. if it is version '2.0.0' or higher then set 
-- this value to true
Config.UseNew = false -- (if you use stashitems DB TABLE, then set it to false.)
--------------------------------------------------------------------



Config.TimeToGrow   = 180   -- Time that a plant takes to fully grow (1-100) in minutes.
Config.UpdatePlants = 15    -- Time that the server side will check Plant Data and update it. 

Config.DryIncrease  = 1      -- Increase of the dry amount each (Config.UpdatePlants) mins (without heaters and Fans).
Config.FertilizerDecay = 0.5 -- Decrease amount of the Fertilizer.
Config.WaterDecay = 0.5      -- Decrease amount of the Water.

Config.FertilizerThreshold = 45 -- Value under it, the Plant Health will decrease
Config.WaterThreshold = 45      -- Value under it, the Plant Health will decrease
Config.LightThreshold = 45      -- Value under it, the Plant Health will decrease

Config.HealthBaseDecay = {5, 10} -- The decrease amount of the Plant Health when needs are missing.(water, nutrition and lights)

Config.PurityDevider = 3        -- The Amount to devide the purity by to get the Joint ReliefStress Amount



-------------------------- PLEASE DO NOT TOUCH THIS UNLESS YOU KNOW WHAT YOU ARE DOING ---------------------
------------------------------------- ORDER OF THE PROPS IS IMPORTANT --------------------------------------

Config.FanProps = {
    [1] = "prop_fan_01",
    [2] = "v_res_fa_fan", 
    [3] = "prop_wall_vent_02"
}

Config.HeaterProps = {
    [1] = "prop_elec_heater_01",
    [2] = "prop_patio_heater_01", 
}

Config.LightProps = {
    [1] = "prop_wall_light_05a",
    [2] = "ch_prop_ch_lamp_ceiling_w_01a", 
    [3] = "h4_prop_x17_sub_lampa_small_blue"
}

Config.PlanterProps = {
    [1] = "prop_garden",
    [2] = "prop_weed_rack_xs",
    [3] = "prop_rack_dryer_s",
    [4] = "bkr_prop_weed_table_01a",
    [5] = "prop_water_setup"
}

Config.WeedProps = {
    [1] = "bkr_prop_weed_bud_01a",
    [2] = "bkr_prop_weed_med_01a",
    [3] = "bkr_prop_weed_med_01b",
    [4] = "bkr_prop_weed_lrg_01a",
    [5] = "bkr_prop_weed_lrg_01b"
}
--------------------------------------------------------------------------------------------------------------------