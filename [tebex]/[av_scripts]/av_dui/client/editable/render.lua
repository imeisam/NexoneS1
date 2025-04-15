renderMe = true

CreateThread(function()
    Wait(1000)
    local kvpValue = GetResourceKvpInt('renderMe')
    print(renderMe, kvpValue)
    if not kvpValue or kvpValue == 0 then return end
    if kvpValue > 5 then
        renderMe = true    
    end
    if kvpValue == 5 then
        renderMe = false
    end
end)

RegisterCommand("dui", function()
    renderMe = not renderMe
    local value = 5
    if renderMe then 
        value = 99
        TriggerEvent('av_laptop:notification', "Sprays", "Render ON", "success")
    else
        TriggerEvent('av_laptop:notification', "Sprays", "Render OFF", "error")
    end
    SetResourceKvpInt('renderMe', value)
end)