exports('Notify', function(message, color, time)
    SendNUIMessage({runProgress = true, colorsent = color, textsent = message, fadesent = time})
end)