local QBCore = exports['qb-core']:GetCoreObject()
local decyitem=10

local function HackNotif(state)
    if state then
        QBCore.Functions.Notify("Hacker", 'success')
    else
        QBCore.Functions.Notify("Noob", 'error')
    end
end
CreateThread(function()
local location ={
    vector3(1130.1280517578, -474.07818603516, 71.90258026123),
    vector3(1129.8627929688, -475.09384155273, 71.90258026123),
    vector3(1129.6225585938, -475.83932495117, 71.90258026123),
    vector3(1129.5322265625, -476.58380126953, 71.90258026123),
    vector3(211.28561401367, -1510.390625, 29.294555664062),--clicklovers1
    vector3(210.70027160645, -1510.8880615234, 29.294555664062),--clicklovers1
}

for k, v in ipairs(location) do

    exports['qb-interact']:AddInteraction({
        coords = v,
        distance =2.5,
        interactDst = 1.5,
        id = "gamenet"..k,
        name ="gamenet"..k,
        options ={
            
            {
                canInteract = function()
                  return QBCore.Functions.HasItem("gamenent_ticket",nil,true) 
                end,
                action = function()
                    TriggerServerEvent("inventory:server:breakItem", "gamenent_ticket", decyitem)
                    local success = exports["five-repairkit"]:Minigame(4)
                    HackNotif(success)
                end,
                label = "Game 1",
            },
            {
                canInteract = function()
                  return QBCore.Functions.HasItem("gamenent_ticket",nil,true) 
                end,
                action = function()
                    TriggerServerEvent("inventory:server:breakItem", "gamenent_ticket", decyitem)
                    local success=exports['nxo-MiniGames']:lockpicking(12,4,40000)
                    HackNotif(success)
                end,
                label = "Game 2",
            },
            {
                canInteract = function()
                  return QBCore.Functions.HasItem("gamenent_ticket",nil,true) 
                end,
                action = function()
                    TriggerServerEvent("inventory:server:breakItem", "gamenent_ticket", decyitem)
                    local success = exports['bd-minigames']:PinCracker(4, 60)
                    HackNotif(success)
                end,
                label = "Game 3",
            },
            {
                canInteract = function()
                  return QBCore.Functions.HasItem("gamenent_ticket",nil,true) 
                end,
                action = function()
                    TriggerServerEvent("inventory:server:breakItem", "gamenent_ticket", decyitem)
                    success=exports['nxo-MiniGames']:alphabet(20,20000)
                    HackNotif(success)
                end,
                label = "Game 4",
            },
            {
                canInteract = function()
                  return QBCore.Functions.HasItem("gamenent_ticket",nil,true) 
                end,
                action = function()
                    TriggerServerEvent("inventory:server:breakItem", "gamenent_ticket", decyitem)
                    success=exports['nxo-MiniGames']:words(2, 60000)
                    HackNotif(success)
                end,
                label = "Game 5",
            },
        }
    })

end
  

end)