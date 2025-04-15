
CreateThread(function()

 for k,v in pairs(config.lift) do
 
     exports['qb-target']:AddBoxZone("samift_"..k,v.eyetarget.coord, v.eyetarget.w,  v.eyetarget.h, {
                name ="samift_"..k,
                heading =v.eyetarget.heading,
                debugPoly = false,
                minZ =v.eyetarget.minZ,
                maxZ =v.eyetarget.maxZ,
            }, {
                options = {
                    {
                        type = "client",
                        icon = "fa fa-clipboard",
                        event = "sam-lift:client:liftup",
                        label = "Move Up",
                        liftid=k,
                    },
                     {
                        type = "client",
                        icon = "fa fa-clipboard",
                        event = "sam-lift:client:liftstopeye",
                        label = "Stop",
                        liftid=k,
                    },
                       {
                        type = "client",
                        icon = "fa fa-clipboard",
                        event = "sam-lift:client:liftdown",
                        label = "Move Down",
                        liftid=k,

                    },
                     
                       {
                        type = "client",
                        icon = "fa fa-clipboard",
                        event = "sam-lift:client:changspeed",
                        label = "Change Speed",
                        liftid=k,

                    }
                },
                distance = v.eyetarget.distance
            })
 end
end)

    RegisterNetEvent('sam-lift:client:changspeed', function(data)
     local dialog = exports['qb-input']:ShowInput({
        header ="Change Speed",
        submitText ="Change",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'speed',
                text ="Speed 1 to 30"
            },
          
        }
    })
    if dialog then
        if dialog.speed>30 then
            dialog.speed=30 
        end
        TriggerServerEvent("sam-lift:server:setliftspeed",data.liftid,dialog.speed/1000)
    end

    end)
   