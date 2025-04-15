
QBCore = exports[config.core]:GetCoreObject()
local lift={}
local frame={}

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
     for k,v in pairs( lift) do
      object=GetClosestObjectOfType(config.lift[k].coord.x,config.lift[k].coord.y,config.lift[k].coord.z,3.0,GetHashKey("samlift_jackframe"))
      object1=GetClosestObjectOfType(config.lift[k].coord.x,config.lift[k].coord.y,config.lift[k].coord.z,3.0,GetHashKey("samlift_leg"))
       DeleteObject(object)
       DeleteObject(object1)
     end
   
    end
end)

RegisterNetEvent('sam-lift:client:liftup', function(data)

Citizen.CreateThread(function()
   QBCore.Functions.TriggerCallback('sam-lift:server:getliftspeed', function(liftspeed)
    TriggerServerEvent("sam-lift:server:stoplift",data)
    local liftid=data.liftid
    Wait(100)
    config.lift[liftid].stop=true
 
    config.lift[liftid].stop=false
    local tempz=0
    object=GetClosestObjectOfType(config.lift[liftid].coord.x,config.lift[liftid].coord.y,config.lift[liftid].coord.z,3.0,GetHashKey("samlift_jackframe"))
    local coord=GetEntityCoords(object)
    tempz=coord.z
   while tempz< config.lift[liftid].coord.z+2 and not  config.lift[liftid].stop do
   coord=GetEntityCoords(object)
   tempz=coord.z+liftspeed
    SetEntityCoords( object,config.lift[liftid].coord.x,config.lift[liftid].coord.y,tempz)
    Wait(10)
    end
    config.lift[liftid].stop =true
      end,data.liftid)

    end)
end)

RegisterNetEvent('sam-lift:client:liftdown', function(data)
Citizen.CreateThread(function()
  QBCore.Functions.TriggerCallback('sam-lift:server:getliftspeed', function(liftspeed)
    TriggerServerEvent("sam-lift:server:stoplift",data)
    local liftid=data.liftid
    object=GetClosestObjectOfType(config.lift[liftid].coord.x,config.lift[liftid].coord.y,config.lift[liftid].coord.z,3.0,GetHashKey("samlift_jackframe"))
config.lift[liftid].stop=true
Wait(100)
    config.lift[liftid].stop=false
    local tempz=0
    local coord=GetEntityCoords(object)
    tempz=coord.z
       while tempz>config.lift[liftid].coord.z and not config.lift[liftid].stop do
       coord=GetEntityCoords(object)
       tempz=coord.z-liftspeed
        SetEntityCoords( object,config.lift[liftid].coord.x,config.lift[liftid].coord.y,tempz)
        Wait(10)
        end
        config.lift[liftid].stop=true
           end,data.liftid)
        end)
    end)

    RegisterNetEvent('sam-lift:client:liftstop', function(data,player)
      PlayerData = QBCore.Functions.GetPlayerData()
      if PlayerData.source~=player then
        config.lift[data.liftid].stop=true
      end
      
    end)

    RegisterNetEvent('sam-lift:client:liftstopeye', function(data)
      config.lift[data.liftid].stop=true
      TriggerServerEvent("sam-lift:server:stoplift",data)
    end)

    

 