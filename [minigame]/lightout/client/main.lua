local resultReceived = false
local p = nil

RegisterNUICallback('callback', function(data, cb)
    SetNuiFocus(false, false)
    resultReceived = true
    if data.success then
        p:resolve(true)
    else
        if LocalPlayer.state.isSmart then
            p:resolve(true)
        else
            p:resolve(false)
        end
    end
    p = nil
    cb('ok')
end)


local function hacking(cb, mode, time)
    if mode < 4 then
        mode = 4
    end
    resultReceived = false
    p = promise.new()
    if LocalPlayer.state.isHackBuff then
        time = time + 10
    end
    SendNUIMessage({
        action = 'open',
        time = time,
        mode = mode,
    })
    SetNuiFocus(true, true)
    local result = Citizen.Await(p)
    cb(result)
end

exports("hacking", hacking)