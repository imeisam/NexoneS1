local ShowBlips = false
local Blips = {}
local doAction = false
RegisterNetEvent('qb-fuel:client:toggleBlips', function()
    if doAction then return end
    ShowBlips = not ShowBlips
    if ShowBlips then
        doAction = true
        for _, gasStationCoords in ipairs(Config.GasStationsBlips) do
            local blip = AddBlipForCoord(gasStationCoords)
            SetBlipSprite(blip, 361)
            SetBlipScale(blip, 0.4)
            SetBlipColour(blip, 1)
            SetBlipDisplay(blip, 4)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Gas Station")
            EndTextCommandSetBlipName(blip)
            Blips[#Blips+1] = blip
        end
        for _, gasStationCoords in ipairs(Config.chargestationBlips) do
            local blip = AddBlipForCoord(gasStationCoords)
            SetBlipSprite(blip, 354)
            SetBlipScale(blip, 1.0)
            SetBlipColour(blip, 5)
            SetBlipDisplay(blip, 4)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Electric Charge")
            EndTextCommandSetBlipName(blip)
            Blips[#Blips+1] = blip
        end
        doAction = false
    else
        doAction = true
        for k,v in ipairs(Blips) do
            RemoveBlip(v)
        end
        Blips = {}
        doAction = false
    end
end)