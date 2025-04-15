local currentNote = 0

RegisterNetEvent("qb-notes:client:openNote", function(info, slot)
    currentNote = slot
    local text = info.text or ''
    TriggerEvent('animations:client:EmoteCommandStart', {"notepad"})
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "open",
        text = text
    })
end)

RegisterNUICallback("DropNote", function(data, cb)
    TriggerServerEvent("qb-notes:server:saveNote", data.text, currentNote)
end)

RegisterNUICallback("CloseNotepad", function(data, cb)
    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    SetNuiFocus(false, false)
end)