local IsHacking = false

AddEventHandler('open:minigame', function(callback)
    Callbackk = callback
    openHack(5,7)
end)

function OpenHackingGame(callback, amount, timer, kazem)
    Callbackk = callback
    openHack(amount, timer, kazem)
end

RegisterNUICallback('callback', function(data, cb)
    closeHack()
    if LocalPlayer.state.isSmart then
        data.success = true
    end
    Callbackk(data.success)
    cb('ok')
end)

function openHack(tedadi, zamani, tekrar)
    SetNuiFocus(true, true)
    if LocalPlayer.state.isHackBuff then
        zamani = zamani + 10
    end
    SendNUIMessage({
        action = "open",
        tedad = tedadi,
        timer = zamani,
        amount = tekrar
    })
    IsHacking = true
end

function closeHack()
    SetNuiFocus(false, false)
    IsHacking = false
end

function GetHackingStatus()
    return IsHacking
end