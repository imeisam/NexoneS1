Config = {}

-- if you have renamed your qb-core, es_extended, event names, make sure to change them. Based on this information your framework will be detected.
Config.FrameworkTriggers = {
    ["qb"] = {
        ResourceName = "qb-core",
        PlayerLoaded = "QBCore:Client:OnPlayerLoaded",
        PlayerUnload = "QBCore:Client:OnPlayerUnload",
        OnJobUpdate = "QBCore:Client:OnJobUpdate",
        OnGangUpdate = "QBCore:Client:OnGangUpdate",
    },
    ["esx"] = {
        ResourceName = "es_extended",
        PlayerLoaded = "esx:playerLoaded",
        PlayerUnload = "esx:playerDropped",
        OnJobUpdate = "esx:setJob",
        OnPlayerUnload = "esx:onPlayerLogout",
    }
}

Config.Notify = "qb" -- qb || ox || esx || okok

-- ONLY FOR ESX, THIS IS BY DEFAULT SET TO TRU IF YOU ARE USING QBCore
Config.JobAccounts = true -- If you want to use job accounts inside my banking, set this to true

-- char id for ESX and citizenid for QBCore
Config.DefaultIdentifier = "00000" -- set the identifier for the player to whom the loans should be transferred when a player who has given out loans deletes their character


Config.Options = "target" -- target || drawtext (if draw text, it will show draw text ui using lib or if you select target, it will be target based. Code is open in client/open/cl_locations.lua)
Config.BankConfig = "default" -- gabz || default (If you use some other banks, make sure to create a file in locations folder and put the file name here!!)
Blips = {
    unique_blips = false, -- this will create each blip which will show individually in the side bar. If you see flashing side bar due to the high number of blips, set this to false.
    blip_scale = 0.7,
    blip_sprite = 108,
    generic_blip_label = "Bank", -- only shows if you set unique_blips to false
    generic_blip_color = 2 -- only shows if you set unique_blips to false
}

Config.ATMModels = {
    -- `prop_fleeca_atm`,
    `prop_atm_01`,
    `prop_atm_02`,
    `prop_atm_03`,
   
}
Config.FleecaATMcoords={
    vector3(147.57284545898, -1036.0505371094, 29.535556030273),
    vector3(146.0223236084, -1035.486328125, 29.591565322876),
    vector3(-1206.1138916016, -325.15338134766, 38.08175201416),
    vector3(-1205.3530273438, -326.64514160156, 38.08175201416),
}

Config.AllowLoans = false -- Do you want evenyone to see the loans tab in the bank.

Config.AnyOneCanCreateLoans = false -- set to true if you want any to create loans, if you set this to false, make sure to change the job names in Config.LoanJobs
Config.LoanJobs = { -- job with grade. If you want to add more jobs, just add the job name and grade. For example, ["police"] = 0, ["judge"] = 0. Anyone with grade mentioned and above can create loans. This logic can be changed in cl_loans_customise
    ["justice"] = 4,
}

-- this is the place from which only the manage UI will open. So for example, you can put this in the police station or cityhall from where police/judges can freeze/flag accounts.
Config.ManagementLocations = {
    vector3(449.32, -969.86, 30.69)
}

Config.SupervisorJobs = { -- jobs that can manage the accounts like freeze/manage/export transactions for anyone
    ["police"] = 4,
    ["justice"] = 3,
}

Config.Dispatch = "other" -- cd || ps || moz || other (if you select other, you will have to add your own dispatch alert from the function SendPoliceAlertForFlaggedAccount() in client/open/cl_customise.lua)

Config.Progress = "qb" -- "ox" || "qb"

-- ONLY FOR ESX
-- if you have any job that starts with off, make sure to add it here. For example, if you have a job called office, you can add it here and it will be shown in the job list.
-- I have added clause for off duty jobs and I neglect all the jobs that start with off, so if you have any job that starts with off, make sure to add it here.
-- do not add off duty jobs here (eg .offpolice)
Config.WhitelistJobsThatStartWithOff = {
    ["office"] = true 
}

-- DO NOT TOUCH THIS!!!!

for k, v in pairs(Config.FrameworkTriggers) do
    if GetResourceState(v.ResourceName) == "started" then
        Config.Framework = k
        break
    end
end
