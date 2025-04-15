local QBCore = exports['qb-core']:GetCoreObject()
local shutterspeed=0.004
local stop={}
-- RegisterCommand("shutterup", function()
--     shuttermove(1,"up")
-- end)
-- RegisterCommand("shutterdown", function()
--     shuttermove(1,"down")
-- end)
-- RegisterCommand("shutterstop", function()
--     stop=true
-- end)
CreateThread(function()
    for k, v in ipairs(Config.shutter) do
    exports['qb-interact']:AddInteraction({
        coords =v.interactcoord,
        distance =1.5,
        interactDst = 1.0,
        id = "shutterinteract_"..k,
        name ="shutterinteract_"..k,
        options ={
            {
                canInteract = function(entity) 
                    if QBCore.Functions.GetPlayerData().job.name==v.job then
                       return true
                    end
                      return false
                end,
                action = function()
                        shuttermove(k,"up")
                end,
                label = "Goto Up Shutter",
            },
            {
                canInteract = function(entity) 
                    if QBCore.Functions.GetPlayerData().job.name==v.job then
                       return true
                    end
                      return false
                end,
                action = function()
                    stop[k]=true
                end,
                label = "Stop Shutter",
            },
            {
                canInteract = function(entity) 
                    if QBCore.Functions.GetPlayerData().job.name==v.job then
                       return true
                    end
                      return false
                end,
                action = function()
                    shuttermove(k,"down")
                end,
                label = "Goto Down Shutter",
            },
        }
    })
    end
    end)

    function shuttermove(index,status)
        CreateThread(function()
            stop[index]=true
            Wait(100)
            local stopz=Config.shutter[index].upz
            local objectcoord=Config.shutter[index].startcoord
            local object=GetClosestObjectOfType(Config.shutter[index].startcoord.x,Config.shutter[index].startcoord.y,Config.shutter[index].startcoord.z,2.0,`3dp_snrbuns_shutter`)
            local tempz=GetEntityCoords(object).z
            stop[index]=false
            if status =="up" then
                while stopz>=tempz and not stop[index] do
                    tempz=tempz+shutterspeed
                     SetEntityCoords( object,objectcoord.x,objectcoord.y,tempz)
                     Wait(10)
               end
            else
                while objectcoord.z<=tempz and not stop[index] do
                    tempz=tempz-shutterspeed
                     SetEntityCoords( object,objectcoord.x,objectcoord.y,tempz)
                     Wait(10)
               end
            end
        end)
       
    end