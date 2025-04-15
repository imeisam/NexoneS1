local coords = {}

RegisterNetEvent('qb-radiochecker:client:sendRadioFreqs', function(data)
    coords = {}
    for k,v in pairs(data) do
        coords[k] = v.coords
        data[k].coords = k
    end
    SendNUIMessage({
        type = "OPEN",
        data = {
           radiodata = data,
        }
    })
    SetNuiFocus(true,true)
end)

RegisterNUICallback("close", function() 
	SetNuiFocus(false, false)
end)

RegisterNUICallback("marklocation", function(data)
    TriggerEvent('qb-radiochecker:client:CreatetBlip', coords[data.coord])
end)

RegisterNetEvent('qb-radiochecker:client:CreatetBlip', function(coords)
    local zoneBlip = AddBlipForRadius(coords.x, coords.y, coords.z, 1000.0)
    SetBlipSprite(zoneBlip, 1)
    SetBlipColour(zoneBlip, 6)
    SetBlipAlpha(zoneBlip, 255)
    local fadeDuration = 50000
    local fadeSteps = 100
    local fadeInterval = fadeDuration / fadeSteps
    local currentAlpha = 114
    local alphaDecrement = 255 / fadeSteps
    local function fadeBlip()
        if currentAlpha > 0 then
            currentAlpha = currentAlpha - alphaDecrement
            if currentAlpha < 0 then currentAlpha = 0 end
            SetBlipAlpha(zoneBlip, math.floor(currentAlpha))
            SetTimeout(fadeInterval, fadeBlip)
        else
            RemoveBlip(zoneBlip)
        end
    end
    fadeBlip()
end)