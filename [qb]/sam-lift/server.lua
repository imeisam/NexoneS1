QBCore = exports[config.core]:GetCoreObject()
local isrun= false

QBCore.Functions.CreateCallback('sam-lift:server:getliftspeed', function(source, cb,liftid)
   cb( config.lift[liftid].speed)
end)

RegisterNetEvent('sam-lift:server:setliftspeed', function(liftid,speed)
    config.lift[liftid].speed=speed
end)
 function LoadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(5)
    end
  end

CreateThread(function()
    local lift={}
    local frame={}
     for k,v in pairs(config.lift) do
         lift[k]= CreateObjectNoOffset(GetHashKey('samlift_leg'),vector3(v.coord.x,v.coord.y,v.coord.z),true, true, false)
         SetEntityHeading(lift[k], v.coord.w)
         FreezeEntityPosition(lift[k], true)
          frame[k]={}
          frame[k].coord=vector3(v.coord.x,v.coord.y,v.coord.z)
          frame[k].speed=v.speed
          Wait(100)
          frame[k].object= CreateObjectNoOffset(GetHashKey('samlift_jackframe'),vector3(v.coord.x,v.coord.y,v.coord.z), true, true, false)
         SetEntityHeading(frame[k].object,v.coord.w)
         FreezeEntityPosition(frame[k].object, true)
      end

end)

RegisterNetEvent('sam-lift:server:stoplift', function(data)
   player= QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('sam-lift:client:liftstop', -1,data,source)
end)