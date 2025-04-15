local QBCore = exports['qb-core']:GetCoreObject()
local CurrentWeather = Config.StartWeather
local baseTime = Config.BaseTime
local timeOffset = Config.TimeOffset
local freezeTime = Config.FreezeTime
local blackout = Config.Blackout
local newWeatherTimer = Config.NewWeatherTimer

--- Is the source a client or the server
--- @param src string | number - source to check
--- @return int - source
local function getSource(src)
    return src == '' and 0 or src
end

--- Does source have permissions to run admin commands
--- @param src number - Source to check
--- @return boolean - has permission
local function isAllowedToChange(src)
    return src == 0 or QBCore.Functions.HasPermission(src, "admin") or IsPlayerAceAllowed(src, 'command')
end

--- Sets time offset based on minutes provided
--- @param minute number - Minutes to offset by
local function shiftToMinute(minute)
    timeOffset = timeOffset - (((baseTime + timeOffset) % 60) - minute)
end

--- Sets time offset based on hour provided
--- @param hour number - Hour to offset by
local function shiftToHour(hour)
    timeOffset = timeOffset - ((((baseTime + timeOffset) / 60) % 24) - hour) * 60
end

--- Triggers event to switch weather to next stage
 function nextWeatherStage()
    nextWeatherStagezone()
    if CurrentWeather == "CLEAR" or CurrentWeather == "CLOUDS" or CurrentWeather == "EXTRASUNNY" then
        CurrentWeather = (math.random(1, 5) > 2) and "CLEAR" or "OVERCAST" -- 60/40 chance
    elseif CurrentWeather == "CLEAR" or CurrentWeather == "OVERCAST" then
        local new = math.random(1, 6)
        if new == 1 then CurrentWeather = (CurrentWeather == "CLEAR") and "FOGGY" or "RAIN"
        elseif new == 2 then CurrentWeather = "CLOUDS"
        elseif new == 3 then CurrentWeather = "CLEAR"
        elseif new == 4 then CurrentWeather = "EXTRASUNNY"
        elseif new == 5 then CurrentWeather = "SMOG"
        else CurrentWeather = "FOGGY"
        end
    elseif CurrentWeather == "THUNDER" or CurrentWeather == "RAIN" then CurrentWeather = "CLEAR"
    elseif CurrentWeather == "SMOG" or CurrentWeather == "FOGGY" then CurrentWeather = "CLEAR"
    else CurrentWeather = "CLEAR"
    end
    TriggerEvent("qb-weathersync:server:RequestStateSync")
end

 function nextWeatherStagezone()

    for k,v in pairs(Config.zone) do
        if not v.freezweather then
            v.lastWeather=v.autoweather[math.random(1,#v.autoweather)]
            
            -- if (tmpstage["CLEAR"] or tmpstage["OVERCAST"]) and  (v.lastWeather == "CLEAR" or   v.lastWeather == "CLOUDS" or   v.lastWeather == "EXTRASUNNY")  then
            --     if tmpstage["CLEAR"] and tmpstage["OVERCAST"] then
            --         v.lastWeather = (math.random(1, 5) > 3) and "CLEAR" or "OVERCAST" -- 60/40 chance    
            --     elseif tmpstage["CLEAR"]  then
            --         print("asdas") v.lastWeather = "CLEAR" 
            --     elseif tmpstage["OVERCAST"]  then
            --         v.lastWeather = "OVERCAST" 
            --     end
            -- elseif  (tmpstage["CLEAR"] or tmpstage["FOGGY"] or tmpstage["RAIN"] or tmpstage["CLOUDS"] or tmpstage["CLEAR"] or tmpstage["EXTRASUNNY"] or tmpstage["SMOG"]) and  (v.lastWeather == "CLEAR" or   v.lastWeather == "OVERCAST") then
            --     local new = math.random(1, 6)
            --     print(new)
            --     if new == 1 then   
            --         if tmpstage["CLEAR"] and tmpstage["FOGGY"] and  tmpstage["RAIN"] then
            --             v.lastWeather = (  v.lastWeather == "CLEAR") and "FOGGY" or "RAIN"
            --         elseif tmpstage["FOGGY"] then
            --             v.lastWeather ="FOGGY"
            --         elseif tmpstage["RAIN"] then
            --             v.lastWeather = "RAIN"
            --         end

            --      elseif new == 2 and tmpstage["CLOUDS"] then   v.lastWeather = "CLOUDS" 
            --     elseif new == 3 and tmpstage["CLEAR"] then  print("adfdfsd")  v.lastWeather = "CLEAR"
            --     elseif new == 4 and tmpstage["EXTRASUNNY"] then   v.lastWeather = "EXTRASUNNY"
            --      elseif new == 5 and tmpstage["SMOG"] then   v.lastWeather = "SMOG"
            --     else  print("asd")  v.lastWeather ="CLEAR"
            --      end

            -- elseif   (v.lastWeather == "THUNDER" or   v.lastWeather == "RAIN" ) and tmpstage["CLEAR"]  then   v.lastWeather = "CLEAR" 
            -- elseif  ( v.lastWeather == "SMOG" or   v.lastWeather == "FOGGY") and tmpstage["CLEAR"] then   v.lastWeather = "CLEAR" 
            -- else  print("asdfdssd") v.lastWeather = "CLEAR"
            -- end

          
        end
    end
   
end

--- Switch to a specified weather type
--- @param weather string - Weather type from Config.AvailableWeatherTypes
--- @return boolean - success
local function setWeather(weather)
    local validWeatherType = false
    for _, weatherType in pairs(Config.AvailableWeatherTypes) do
        if weatherType == string.upper(weather) then
            validWeatherType = true
        end
    end
    if not validWeatherType then return false end
    CurrentWeather = string.upper(weather)
    newWeatherTimer = Config.NewWeatherTimer
    TriggerEvent('qb-weathersync:server:RequestStateSync')
    return true
end

local function setzoneWeather(zonename,weather)
    local validWeatherType = false
    for _, weatherType in pairs(Config.AvailableWeatherTypes) do
        if weatherType == string.upper(weather) then
            validWeatherType = true
        end
    end
    if not validWeatherType then return false end
    Config.zone[zonename].lastWeather = string.upper(weather)
    newWeatherTimer = Config.NewWeatherTimer
    TriggerEvent('qb-weathersync:server:RequestStateSync')
    return true
end

--- Sets sun position based on time to specified
--- @param hour number|string - Hour to set (0-24)
--- @param minute number|string `optional` - Minute to set (0-60)
--- @return boolean - success
local function setTime(hour, minute)
    local argh = tonumber(hour)
    local argm = tonumber(minute) or 0
    if argh == nil or argh > 24 then
        print(Lang:t('time.invalid'))
        return false
    end
    shiftToHour((argh < 24) and argh or 0)
    shiftToMinute((argm < 60) and argm or 0)
    print(Lang:t('time.change', {value = argh, value2 = argm}))
    -- TriggerEvent('qb-weathersync:server:RequestStateSync')

    TriggerClientEvent('qb-weathersync:client:SyncWeather', -1, CurrentWeather, blackout,Config.zone)
    TriggerClientEvent('qb-weathersync:client:SyncTimereal', -1, baseTime, timeOffset, freezeTime)
    return true
end

--- Sets or toggles blackout state and returns the state
--- @param state boolean `optional` - enable blackout?
--- @return boolean - blackout state
local function setBlackout(state)
    if state == nil then state = not blackout end
    if state then blackout = true
    else blackout = false end
    TriggerEvent('qb-weathersync:server:RequestStateSync')
    return blackout
end

local function setzoneBlackout(zonename,state)
    if state == nil then state = not Config.zone[zonename].blackout end
    if state then Config.zone[zonename].blackout = true
    else Config.zone[zonename].blackout = false end
    TriggerEvent('qb-weathersync:server:RequestStateSync')
    return Config.zone[zonename].blackout
end


--- Sets or toggles time freeze state and returns the state
--- @param state boolean `optional` - Enable time freeze?
--- @return boolean - Time freeze state
local function setTimeFreeze(state)
    if state == nil then state = not freezeTime end
    if state then freezeTime = true
    else freezeTime = false end
    TriggerEvent('qb-weathersync:server:RequestStateSync')
    return freezeTime
end

--- Sets or toggles dynamic weather state and returns the state
--- @param state boolean `optional` - Enable dynamic weather?
--- @return boolean - Dynamic Weather state
local function setDynamicWeather(state)
    if state == nil then state = not Config.DynamicWeather end
    if state then Config.DynamicWeather = true
    else Config.DynamicWeather = false end
    TriggerEvent('qb-weathersync:server:RequestStateSync')
    return Config.DynamicWeather
end

--- Retrieves the current time from worldtimeapi.org
--- @return number - Unix time
local function retrieveTimeFromApi(callback)
    Citizen.CreateThread(function()
        PerformHttpRequest("http://worldtimeapi.org/api/ip", function(statusCode, response)
            if statusCode == 200 then
                local data = json.decode(response)
                if data == nil or data.unixtime == nil then
                    callback(nil)
                else
                    callback(data.unixtime)
                end
            else
                callback(nil)
            end
        end, "GET", nil, nil)
    end)
end

RegisterNetEvent('qb-weathersync:server:changeweather', function(data)
        local tex=""   
    if data.hours~='' then
            setTime(data.hours, 0)
              tex=tex.." Time: ".. data.hours
    end
     
        for k,v in pairs(Config.zone) do
           if data[k]=='true' then
            tex=tex..'\n'..k..' - Weather: '..data.weather..' - Freez: '.. data.freezeweather .. ' - Blackout: '..data.blackout
            Config.zone[k].lastWeather=data.weather
            if data.freezeweather=='true' then
                Config.zone[k].freezweather=true
            else
                Config.zone[k].freezweather=false
            end
           
            if data.blackout=='true' then
                Config.zone[k].blackout=true
            else
                Config.zone[k].blackout=false
            end
           end
        end

        if data.freeztime=='true' then
            TriggerEvent('qb-weathersync:server:toggleFreezeTime',true)
        else
            TriggerEvent('qb-weathersync:server:toggleFreezeTime',false)
        end
        tex=tex..'\n Freez Time: '.. data.freeztime

   TriggerEvent('qb-weathersync:server:RequestStateSync')

   local src = source
   local Player = QBCore.Functions.GetPlayer(src)
   

   TriggerEvent('qb-log:server:CreateLog', 'weather', 'Change Weather', 'red', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname..' ('..Player.PlayerData.citizenid..')\n'..tex)
end)

RegisterNetEvent('qb-weathersync:server:zonebloackout', function(zonename,blackout)
    Config.zone[zonename].blackout=blackout
    TriggerClientEvent('qb-weathersync:client:SyncWeather', -1, Config.zone[zonename].lastWeather, Config.zone[zonename].blackout,Config.zone)
end)

RegisterNetEvent('qb-weathersync:server:restartweather', function()
    local weatherselect="THUNDER"
    for k,v in pairs(Config.zone) do
         Config.zone[k].lastWeather=weatherselect
     end
    TriggerClientEvent('qb-weathersync:client:SyncWeather', -1, weatherselect,false,Config.zone)
    TriggerClientEvent('qb-weathersync:client:SyncTime', -1, baseTime, timeOffset, freezeTime)
end)
RegisterNetEvent('qb-weathersync:server:restartweatherblackout', function()
    for k,v in pairs(Config.zone) do
         Config.zone[k].blackout=true
     end
    TriggerClientEvent('qb-weathersync:client:SyncWeather', -1, CurrentWeather,true,Config.zone)
    TriggerClientEvent('qb-weathersync:client:SyncTime', -1, baseTime, timeOffset, freezeTime)
end)

-- EVENTS
RegisterNetEvent('qb-weathersync:server:RequestStateSync', function()
    TriggerClientEvent('qb-weathersync:client:SyncWeather', -1, CurrentWeather, blackout,Config.zone)
    TriggerClientEvent('qb-weathersync:client:SyncTime', -1, baseTime, timeOffset, freezeTime)
end)

RegisterNetEvent('qb-weathersync:server:RequestStateSynczone', function(zonename)
    TriggerClientEvent('qb-weathersync:client:SyncWeather', -1, Config.zone[zonename].lastWeather, Config.zone[zonename].blackout,Config.zone)
    TriggerClientEvent('qb-weathersync:client:SyncTime', -1, baseTime, timeOffset, freezeTime)
end)

RegisterNetEvent('qb-weathersync:server:RequestStateSynczoneplayer', function(zonename)
    TriggerClientEvent('qb-weathersync:client:SyncWeather', source, Config.zone[zonename].lastWeather, Config.zone[zonename].blackout,Config.zone)
    TriggerClientEvent('qb-weathersync:client:SyncTime',source, baseTime, timeOffset, freezeTime)
end)

RegisterNetEvent('qb-weathersync:server:RequestStateSynczonescript', function(zonename1)
    TriggerClientEvent('qb-weathersync:client:Syncscriptzone', source, Config.scriptzone[zonename1].blackout)
end)

RegisterNetEvent('qb-weathersync:server:setWeather', function(weather)
    local src = getSource(source)
    if isAllowedToChange(src) then
        local success = setWeather(weather)
        if src > 0 then
            if (success) then TriggerClientEvent('QBCore:Notify', src, Lang:t('weather.updated'))
            else TriggerClientEvent('QBCore:Notify', src, Lang:t('weather.invalid'))
            end
        end
    end
end)

RegisterNetEvent('qb-weathersync:server:setTime', function(hour, minute)
    local src = getSource(source)
    if isAllowedToChange(src) then
        local success = setTime(hour, minute)
        if src > 0 then
            if (success) then TriggerClientEvent('QBCore:Notify', src, Lang:t('time.change', {value = hour, value2 = minute or "00"}))
            else TriggerClientEvent('QBCore:Notify', src, Lang:t('time.invalid'))
            end
        end
    end
end)

RegisterNetEvent('qb-weathersync:server:toggleBlackout', function(state)
    local src = getSource(source)
    if isAllowedToChange(src) then
        local newstate = setBlackout(state)
        if src > 0 then
            if (newstate) then TriggerClientEvent('QBCore:Notify', src, Lang:t('blackout.enabled'))
            else TriggerClientEvent('QBCore:Notify', src, Lang:t('blackout.disabled'))
            end
        end
    end
end)

RegisterNetEvent('qb-weathersync:server:toggleFreezeTime', function(state)
    local src = getSource(source)
    if isAllowedToChange(src) then
        local newstate = setTimeFreeze(state)
        if src > 0 then
            if (newstate) then TriggerClientEvent('QBCore:Notify', src, Lang:t('time.now_frozen'))
            else TriggerClientEvent('QBCore:Notify', src, Lang:t('time.now_unfrozen'))
            end
        end
    end
end)

RegisterNetEvent('qb-weathersync:server:toggleDynamicWeather', function(state)
    local src = getSource(source)
    if isAllowedToChange(src) then
        local newstate = setDynamicWeather(state)
        if src > 0 then
            if (newstate) then TriggerClientEvent('QBCore:Notify', src, Lang:t('weather.now_unfrozen'))
            else TriggerClientEvent('QBCore:Notify', src, Lang:t('weather.now_frozen'))
            end
        end
    end
end)

-- COMMANDS
QBCore.Commands.Add('freezetime', Lang:t('help.freezecommand'), {}, false, function(source)
    local newstate = setTimeFreeze()
    if source > 0 then
        if (newstate) then return TriggerClientEvent('QBCore:Notify', source, Lang:t('time.frozenc')) end
        return TriggerClientEvent('QBCore:Notify', source, Lang:t('time.unfrozenc'))
    end
    if (newstate) then return print(Lang:t('time.now_frozen')) end
    return print(Lang:t('time.now_unfrozen'))
end, 'admin')

QBCore.Commands.Add('freezeweather', Lang:t('help.freezeweathercommand'), {}, false, function(source)
    local newstate = setDynamicWeather()
    if source > 0 then
        if (newstate) then return TriggerClientEvent('QBCore:Notify', source, Lang:t('dynamic_weather.enabled')) end
        return TriggerClientEvent('QBCore:Notify', source, Lang:t('dynamic_weather.disabled'))
    end
    if (newstate) then return print(Lang:t('weather.now_unfrozen')) end
    return print(Lang:t('weather.now_frozen'))
end, 'admin')

-- QBCore.Commands.Add('weather', Lang:t('help.weathercommand'), {{name = Lang:t('help.weathertype'), help = Lang:t('help.availableweather')}}, true, function(source, args)
--     local success = setWeather(args[1])
--     if source > 0 then
--         if (success) then return TriggerClientEvent('QBCore:Notify', source, Lang:t('weather.willchangeto', {value = string.lower(args[1])})) end
--         return TriggerClientEvent('QBCore:Notify', source, Lang:t('weather.invalidc'), 'error')
--     end
--     if (success) then return print(Lang:t('weather.updated')) end
--     return print(Lang:t('weather.invalid'))
-- end, 'admin')

QBCore.Commands.Add('blackout', Lang:t('help.blackoutcommand'), {}, false, function(source)
    local newstate = setBlackout()
    if source > 0 then
        if (newstate) then return TriggerClientEvent('QBCore:Notify', source, Lang:t('blackout.enabledc')) end
        return TriggerClientEvent('QBCore:Notify', source, Lang:t('blackout.disabledc'))
    end
    if (newstate) then return print(Lang:t('blackout.enabled')) end
    return print(Lang:t('blackout.disabled'))
end, 'admin')

QBCore.Commands.Add('morning', Lang:t('help.morningcommand'), {}, false, function(source)
    setTime(9, 0)
    if source > 0 then return TriggerClientEvent('QBCore:Notify', source, Lang:t('time.morning')) end
end, 'admin')

QBCore.Commands.Add('noon', Lang:t('help.nooncommand'), {}, false, function(source)
    setTime(12, 0)
    if source > 0 then return TriggerClientEvent('QBCore:Notify', source, Lang:t('time.noon')) end
end, 'admin')

QBCore.Commands.Add('evening', Lang:t('help.eveningcommand'), {}, false, function(source)
    setTime(18, 0)
    if source > 0 then return TriggerClientEvent('QBCore:Notify', source, Lang:t('time.evening')) end
end, 'admin')

QBCore.Commands.Add('night', Lang:t('help.nightcommand'), {}, false, function(source)
    setTime(23, 0)
    if source > 0 then return TriggerClientEvent('QBCore:Notify', source, Lang:t('time.night')) end
end, 'admin')

QBCore.Commands.Add('time', Lang:t('help.timecommand'), {{ name=Lang:t('help.timehname'), help=Lang:t('help.timeh') }, { name=Lang:t('help.timemname'), help=Lang:t('help.timem') }}, true, function(source, args)
    local success = setTime(args[1], args[2])
    if source > 0 then
        if (success) then return TriggerClientEvent('QBCore:Notify', source, Lang:t('time.changec', {value = args[1] .. ':' .. (args[2] or "00")})) end
        return TriggerClientEvent('QBCore:Notify', source, Lang:t('time.invalidc'), 'error')
    end
    if (success) then return print(Lang:t('time.change', {value = args[1], value2 = args[2] or "00"})) end
    return print(Lang:t('time.invalid'))
end, 'admin')

-- THREAD LOOPS
CreateThread(function()
    local previous = 0
    local realTimeFromApi = nil
    local failedCount = 0
    local timerandom=math.random(0,23)*100000000
    while true do
        Wait(1000)
        timerandom=timerandom+1
        local newBaseTime =timerandom / Config.realtimedif + 360 --Set the server time depending of OS time
      
        if Config.RealTimeSync then
            newBaseTime = os.time(os.date("!*t")) --Set the server time depending of OS time
            if realTimeFromApi == nil then
                retrieveTimeFromApi(function(unixTime)
                    realTimeFromApi = unixTime -- Set the server time depending on real-time retrieved from API
                end)
            end
            while realTimeFromApi == nil do
                if failedCount > 10 then
                    print("Failed to retrieve real time from API, falling back to local time")
                    break
                end
                failedCount = failedCount + 1
                Wait(100)
            end
            if realTimeFromApi ~= nil then
                newBaseTime = realTimeFromApi
            end
        end
        if (newBaseTime % 60) ~= previous then --Check if a new minute is passed
            previous = newBaseTime % 60 --Only update time with plain minutes, seconds are handled in the client
            if freezeTime then
                timeOffset = timeOffset + baseTime - newBaseTime
            end
            baseTime = newBaseTime
          
        end
    end
   
end)

function GetZone(zonename)
    return Config.zone[zonename]
end

CreateThread(function()
    while true do--50000
        Wait(Config.realtimedif *1000)--Change to send every minute in game sync
        TriggerClientEvent('qb-weathersync:client:SyncTime', -1, baseTime, timeOffset, freezeTime)
    end
end)

CreateThread(function()
    while true do
        Wait(300000)
        TriggerClientEvent('qb-weathersync:client:SyncWeather', -1, CurrentWeather, blackout,Config.zone)
    end
end)

CreateThread(function()
    while true do
        newWeatherTimer = newWeatherTimer - 1
        Wait(60000)
        -- Wait((1000 * 60) * Config.NewWeatherTimer)
        if newWeatherTimer <= 0 then
            if Config.DynamicWeather then
                nextWeatherStage()
            end
            newWeatherTimer = Config.NewWeatherTimer
        end
    end
end)

-- EXPORTS
exports('nextWeatherStage', nextWeatherStage)
exports('setWeather', setWeather)
exports('setzoneWeather', setzoneWeather)
exports('setTime', setTime)
exports('GetZone', GetZone)
exports('setBlackout', setBlackout)
exports('setzoneBlackout', setzoneBlackout)
exports('setTimeFreeze', setTimeFreeze)
exports('setDynamicWeather', setDynamicWeather)
exports('getBlackoutState', function() return blackout end)
exports('getTimeFreezeState', function() return freezeTime end)
exports('getWeatherState', function() return CurrentWeather end)
exports('getzoneWeatherState', function(zonename) return Config.zone[zonename].lastWeather end)
exports('getDynamicWeather', function() return Config.DynamicWeather end)

exports('getTime', function()
    local hour = math.floor(((baseTime+timeOffset)/60)%24)
    local minute = math.floor((baseTime+timeOffset)%60)

    return hour,minute
end)


QBCore.Commands.Add('weather', 'change weather', {}, false, function(source)
    TriggerClientEvent('qb-weathersync:client:weatherdialog', source)
end, 'admin')