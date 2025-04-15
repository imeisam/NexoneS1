local price=0
RegisterNetEvent('qb-printer:client:UseDocument', function(ItemData)
    local DocumentUrl = ItemData.info.url ~= nil and ItemData.info.url or false
    SendNUIMessage({
        action = "open",
        url = DocumentUrl
    })
    SetNuiFocus(true, false)
end)

RegisterNUICallback('SaveDocument', function(data, cb)
    if data.url then
        TriggerServerEvent('qb-printer:server:SaveDocument', data.url,price)
    end
    cb('ok')
end)

RegisterNUICallback('CloseDocument', function(_, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNetEvent('qb-printer:client:openInteraction',function(p)
    if p and p.args then
        price=p.args.price
    else
        price=0
    end
    SendNUIMessage({
        action = "start"
    })
    SetNuiFocus(true, true)
end)
