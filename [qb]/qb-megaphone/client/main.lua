CreateThread(function()
    for k,v in pairs(Config.MicrophoneZones) do
        local Zones = {}
        Zones[#Zones + 1] = BoxZone:Create(
            v.coords, v.length, v.width, {
                name = k..'_microphone',
                heading=v.data.heading,
                debugPoly = v.data.debugPoly,
                minZ = v.data.minZ,
                maxZ = v.data.maxZ
            }
        )

        local Combo = ComboZone:Create(Zones, {name = k..'_microphone', debugPoly = false})
        Combo:onPlayerInOut(function(isPointInside)
            if isPointInside then
                if v.effect then
                    TriggerServerEvent("qb-megaphone:server:addSubmix")
                    TriggerEvent('qb-megaphone:client:statevoice', true)
                end
                exports["pma-voice"]:overrideProximityRange(v.data.data.range, false)
            else
                exports["pma-voice"]:clearProximityOverride()
                if v.effect then
                    TriggerServerEvent("qb-megaphone:server:removeSubmix")
                    TriggerEvent('qb-megaphone:client:statevoice', false)
                end
            end
        end)
    end
end)