local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    Effect = CreateAudioSubmix('megaphone')
    SetAudioSubmixEffectRadioFx(Effect, 0)
    SetAudioSubmixEffectParamInt(Effect, 0, GetHashKey('default'), 1)
    SetAudioSubmixEffectParamFloat(Effect, 0, GetHashKey('freq_low'), 300.0)
    SetAudioSubmixEffectParamFloat(Effect, 0, GetHashKey('freq_hi'), 3000.0)
    SetAudioSubmixEffectParamFloat(Effect, 0, GetHashKey('rm_mod_freq'), 100.0)
    SetAudioSubmixEffectParamFloat(Effect, 0, GetHashKey('rm_mix'), 0.1)
    SetAudioSubmixEffectParamFloat(Effect, 0, GetHashKey('fudge'), 0.7)
    SetAudioSubmixEffectParamFloat(Effect, 0, GetHashKey('o_freq_lo'), 300.0)
    SetAudioSubmixEffectParamFloat(Effect, 0, GetHashKey('o_freq_hi'), 3000.0)
    AddAudioSubmixOutput(Effect, 0)
    QBCore.Functions.TriggerCallback('qb-megaphone:server:getSubmixs', function(Players)
        if Players ~= nil and #Players > 0 then
            for k,v in ipairs(Players) do
                MumbleSetSubmixForServerId(k, Effect)
            end
        end
    end)
end)

RegisterNetEvent('qb-megaphone:client:updateSubmix', function(state, plySrc)
    if state then
        -- MumbleSetVolumeOverrideByServerId(plySrc, 0.75)
        MumbleSetSubmixForServerId(plySrc, Effect)
    else
        -- MumbleSetVolumeOverrideByServerId(plySrc, -1.0)
        MumbleSetSubmixForServerId(plySrc, -1)
    end
end)
