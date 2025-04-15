local soundmix = false

local function EnableSubmix()
    SetAudioSubmixEffectRadioFx(0, 0)
    SetAudioSubmixEffectParamInt(0, 0, `default`, 1)
    SetAudioSubmixEffectParamFloat(0, 0, `freq_low`, 400.0)
    SetAudioSubmixEffectParamFloat(0, 0, `freq_hi`, 7500.0)
    SetAudioSubmixEffectParamFloat(0, 0, `fudge`, 0.5)
    SetAudioSubmixEffectParamFloat(0, 0, `rm_mix`, 19.0)
end

local function DisableSubmix()
    SetAudioSubmixEffectRadioFx(0, 0)
    SetAudioSubmixEffectParamInt(0, 0, `enabled`, 0)
end

AddEventHandler("baseevents:enteredVehicle", function(pCurrentVehicle)
    local vehmodel = GetEntityModel(pCurrentVehicle)
    if IsThisModelAHeli(vehmodel) or IsThisModelAPlane(vehmodel) then
        if not soundmix then
            EnableSubmix()
            soundmix = true
        end
    end
end)

AddEventHandler("baseevents:leftVehicle", function()
    if soundmix then
        DisableSubmix()
        soundmix = false
    end
end)