local delivery = nil
local points = {}
local busy = false

-- Create Blip on map
RegisterNetEvent('av_darkmarket:setGPS', function()
    if delivery and DoesBlipExist(delivery) then
        RemoveBlip(delivery)
    end
    local random = math.random(1,#Config.Locations)
    local blipInfo = Config.Locations[random]
    local delivery = AddBlipForCoord(blipInfo.Delivery[1], blipInfo.Delivery[2], blipInfo.Delivery[3])
    SetBlipSprite(delivery, blipInfo.BlipIcon)
    SetBlipScale(delivery, blipInfo.BlipScale)
    SetBlipDisplay(delivery, 4)
    SetBlipColour(delivery, blipInfo.BlipColor)
    SetBlipAsShortRange(delivery, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Lang['blip_text'])
    EndTextCommandSetBlipName(delivery)
end)

-- Create Zone
CreateThread(function()
    for k, v in pairs(Config.Locations) do
        local coords = v['Delivery']
        points[#points+1] = lib.points.new({
            coords = vec3(coords[1], coords[2], coords[3]),
            distance = 5,
        })
    end
    for k, v in pairs(points) do
        function v:nearby()        
            if self.currentDistance < 2 then
                if not lib.isTextUIOpen() then
                   lib.showTextUI(Lang['knock']) 
                end
                if IsControlJustReleased(0, 38) and not busy then
                    animation()
                    CreateThread(function()
                        busy = true -- prevent any type of spam to server
                        Wait(3000)
                        busy = false
                    end)
                    TriggerServerEvent("av_darkmarket:getDelivery")
                end
            end
        end
        function v:onExit()
            if lib.isTextUIOpen() then
                lib.hideTextUI()
            end
        end
    end
end)

function animation()
    local ped = PlayerPedId()
    lib.requestAnimDict("timetable@jimmy@doorknock@", 5000)
    FreezeEntityPosition(ped,true)
    TaskPlayAnim(ped, "timetable@jimmy@doorknock@", 'knockdoor_idle', 2.0, 2.0, 3000, 1, 0, true, true, true)
    FreezeEntityPosition(ped,false)
    Wait(2000)
end