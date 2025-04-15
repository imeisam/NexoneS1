-- i recommend to NOT change the command name. it will make easier for people to use this command
-- when ever is this library.. so please keep this command name on "streamermode" command
RegisterCommand("streamermode", function()
    disableMusic = not disableMusic
    TriggerEvent("xsound:streamerMode", disableMusic)
    if disableMusic then
        TriggerEvent('QBCore:Notify', config.Messages["streamer_on"], 'success')
        for k, v in pairs(soundInfo) do
            Destroy(v.id)
        end
    else
        TriggerEvent('QBCore:Notify', config.Messages["streamer_off"], 'error')
    end
end)
