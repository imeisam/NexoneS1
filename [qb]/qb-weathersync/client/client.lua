local CurrentWeather = Config.StartWeather
local lastWeather = CurrentWeather
local baseTime = Config.BaseTime
local timeOffset = Config.TimeOffset
local freezeTime = Config.FreezeTime
local blackout = Config.Blackout
local blackoutVehicle = Config.BlackoutVehicle
local disable = Config.Disabled
local lasthour
local zonename=''
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    Wait(2000)
    disable = false
    -- TriggerServerEvent('qb-weathersync:server:RequestStateSync')
end)

RegisterNetEvent('qb-weathersync:client:EnableSync', function()
    disable = false
    -- TriggerServerEvent('qb-weathersync:server:RequestStateSync')
end)
RegisterNetEvent('qb-weathersync:client:DisableSync', function()
    disable = true
    SetRainLevel(0.0)
    SetWeatherTypePersist('CLEAR')
    SetWeatherTypeNow('CLEAR')
    SetWeatherTypeNowPersist('CLEAR')
    CreateThread(function()
        while disable do
            SetRainLevel(0.0)
            SetWeatherTypePersist('CLEAR')
            SetWeatherTypeNow('CLEAR')
            SetWeatherTypeNowPersist('CLEAR')
            NetworkOverrideClockTime(23, 0, 0)
            Wait(5000)
        end
    end)
end)
local zoneblackout=false
RegisterNetEvent('qb-weathersync:client:SyncWeather', function(NewWeather, newblackout,weatherzone)
   if disable then return  end
    if zonename~='' then
        CurrentWeather=weatherzone[zonename].lastWeather
        if not zoneblackout and scriptzone then
            blackout=weatherzone[zonename].blackout
        end
    else
        if not zoneblackout and scriptzone then
            blackout = newblackout
        end
        CurrentWeather = NewWeather
    end
    
   
end)
RegisterNetEvent('qb-weathersync:client:Syncscriptzone', function(blackoutscript)
    blackout=blackoutscript
    zoneblackout=blackoutscript
end)

RegisterNetEvent('qb-weathersync:client:SyncTimereal', function(base, offset, freeze)
    if disable then return  end
   disable=true
   targethour = math.floor(((base+offset)/60)%24)
   hour=lasthour
   min=0
while hour~=targethour do
    Wait(0)
    NetworkOverrideClockTime(hour, min, 0)
    min=min+2
    
if min>=59 then
    min=0
    hour=hour+1
end
if hour>=24 then
    hour=0
end
end

disable=false
freezeTime = freeze
timeOffset = offset
baseTime = base

end)
scriptzone=""
CreateThread(function()
    local zone={}
    local scriptzone={}

    for k,v in pairs(Config.zone) do
        zone[k] = PolyZone:Create(v.coord, {
            name = 'weather_'..k,
            debugPoly = false
        })
        zone[k]:onPlayerInOut(function(isPointInside, point)
                if isPointInside then
                    TriggerServerEvent('qb-weathersync:server:RequestStateSynczoneplayer',k)
                    zonename=k
                end
        end)
       
    end
    for k,v in pairs(Config.scriptzone) do
        scriptzone[k] = PolyZone:Create(v.coord, {
            name = 'weather_script_'..k,
            debugPoly = false
        })
        scriptzone[k]:onPlayerInOut(function(isPointInside, point)
                if isPointInside then
                    TriggerServerEvent('qb-weathersync:server:RequestStateSynczonescript',k)
                    scriptzone=k
                else
                    if zonename then
                        TriggerServerEvent('qb-weathersync:server:RequestStateSynczoneplayer',zonename)
                        scriptzone=""
                        zoneblackout=false
                    end
                  
                end
        end)
       
    end

end)

RegisterNetEvent('qb-weathersync:client:SyncTime', function(base, offset, freeze)
 freezeTime = freeze
 timeOffset = offset
 baseTime = base
 end)




CreateThread(function()
    while true do
        if not disable then
            if lastWeather ~= CurrentWeather then
                lastWeather = CurrentWeather
                SetWeatherTypeOverTime(CurrentWeather, 15.0)
                Wait(15000)
            end
            Wait(100) -- Wait 0 seconds to prevent crashing.
            SetArtificialLightsState(blackout)
            SetArtificialLightsStateAffectsVehicles(blackoutVehicle)
            ClearOverrideWeather()
            ClearWeatherTypePersist()
            SetWeatherTypePersist(lastWeather)
            SetWeatherTypeNow(lastWeather)
            SetWeatherTypeNowPersist(lastWeather)
            if lastWeather == 'XMAS' then
                SetForceVehicleTrails(true)
                SetForcePedFootstepsTracks(true)
            else
                SetForceVehicleTrails(false)
                SetForcePedFootstepsTracks(false)
            end
            if lastWeather == 'RAIN' then
                SetRainLevel(0.3)
            elseif lastWeather == 'THUNDER' then
                SetRainLevel(0.5)
            else
                SetRainLevel(0.0)
            end
        else
            Wait(3000)
        end
    end
end)

CreateThread(function()
    local hour
    local minute = 0
    local second = 0        --Add seconds for shadow smoothness
    local timeIncrement = Config.RealTimeSync and 0.25 or 1
    local tick = GetGameTimer()
    
    while true do
        if not disable then
            Wait(0)
            local _, _, _, hours, minutes, _ = GetLocalTime()
            local newBaseTime = baseTime
            if tick - (Config.RealTimeSync and 500 or 22) > tick then
                second = second + timeIncrement
                tick = GetGameTimer()
            end
            if freezeTime then
                timeOffset = timeOffset + baseTime - newBaseTime
                second = 0
            end
            baseTime = newBaseTime
            if Config.RealTimeSync then
                hour = hours
                minute = minutes
            else
                hour = math.floor(((baseTime+timeOffset)/60)%24)
                if minute ~= math.floor((baseTime+timeOffset)%60) then  --Reset seconds to 0 when new minute
                    minute = math.floor((baseTime+timeOffset)%60)
                    second = 0
                end
            end
            lasthour=hour
            NetworkOverrideClockTime(hour, minute, second) --Send hour included seconds to network clock time
        else
            Wait(1000)
        end
    end
end)


RegisterNetEvent('qb-weathersync:client:weatherdialog', function()
                            inputs = {}
                            inputs[#inputs+1]= { type = 'number', isRequired = false, name = 'hours', text = 'Hours' }
                                inputs[#inputs+1]= {
                                    text = 'Zone', 
                                    name = "zone",
                                    type = "checkbox",
                                    options = {
                                        { value = "santos", text = "Losantos"},
                                        { value = "sandy", text = "Sandy" }, 
                                        { value = "paleto", text = "Paleto"} 
                                    }
                                }
                                inputs[#inputs+1]=  {
                                    text = "Weather",
                                    name = "weather", 
                                    type = "select", 
                                    options =Config.AdminWeathers,
                                }

                                inputs[#inputs+1]= {
                                    text = '',
                                    name = "op",
                                    type = "checkbox", 
                                    options = { 
                                        { value = "freezeweather", text = "Freeze Weather"}, 
                                        { value = "freeztime", text = "Freeze Time"},
                                        { value = "blackout", text = "Blackout"},
                                     
                                    } 
                                }

                                local dialog = exports['qb-input']:ShowInput({
                                    header = 'Weather Menu',
                                    submitText = "Submit",
                                    inputs =inputs
                                })

    if dialog then
        TriggerServerEvent('qb-weathersync:server:changeweather',dialog)
    end
end)

