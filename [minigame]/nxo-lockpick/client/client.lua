local Result = nil
local NUI_status = false

local function StartLockPickCircle(circles, seconds)
    if circles == nil or circles < 1 then circles = 1 end
    if seconds == nil or seconds < 1 then seconds = 10 end
    NUI_status = false
    Result = nil
    SendNUIMessage({
        action = 'start',
        value = circles,
		time = seconds,
    })
    SetNuiFocus(true, false)
    while not NUI_status do
        Wait(10)
    end
    SetNuiFocus(false, false)
    return Result
end exports("StartLockPickCircle", StartLockPickCircle)

RegisterNUICallback('fail', function(data, cb)
    Result = false
    Wait(100)
    NUI_status = true
    cb('ok')
end)

RegisterNUICallback('success', function(data, cb)
    Result = true
    Wait(100)
    NUI_status = true
    cb('ok')
end)