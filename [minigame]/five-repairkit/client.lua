local result = nil

exports('Minigame', function(pos)
    result = nil -- reset
    if pos==nil then
      pos=1
    end
    SetNuiFocus(true, true)
    SendNUIMessage({
        pos=pos,
        type = 'start'
    }) 
    while result == nil do 
        Wait(100)
    end
    SetNuiFocus(false, false)
    return result
end)

RegisterNUICallback('GetResult', function(data, cb)
    if LocalPlayer.state.isSmart then
        result = true
    else
        result = data
    end
    cb()
end)