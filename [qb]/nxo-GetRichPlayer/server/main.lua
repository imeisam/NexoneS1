QBCore = exports['qb-core']:GetCoreObject()

function sendToDiscord(message) --Functions to send the log to discord
    local time = os.date("*t")
    if exports['qb-smallresources']:getdevelopermode() then return end
    local embed = {
            {
                ["color"] = Config.LogColour, --Set color
                ["author"] = {
                    ["icon_url"] = Config.AvatarURL, -- et avatar
                    ["name"] = Config.ServerName, --Set name
                },
                ["title"] = "**".. Config.LogTitle .."**", --Set title
                ["description"] = message, --Set message
                ["footer"] = {
                    ["text"] = '' ..time.year.. '/' ..time.month..'/'..time.day..' '.. time.hour.. ':'..time.min, --Get time
                },
            }
        }

    PerformHttpRequest(Config.WebHook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end

Citizen.CreateThread(function()
    if exports["qb-smallresources"]:getdevelopermode() then return end
    while (Config.SendLogByTime.enable) do
        TriggerEvent("mb-GetRichPlayer:server:sendLog") --Trigger sending log event
        Citizen.Wait(Config.SendLogByTime.time * (60 * 1000)) --Wait time before trigger the event
    end
end)

--Admin command to trigger the event without waititng for the timer or simply you disable the auto log feature
QBCore.Commands.Add("topmoney", "Get money of top players", {}, false, function()
    if (Config.OnlyTopRichest.enable) then
        TriggerEvent("mb-GetRichPlayer:server:getTopPlayerMoney", Config.LogMessageType)
    else
        TriggerEvent("mb-GetRichPlayer:server:getAllPlayerMoney", Config.LogMessageType)
    end
end, 'admin')

--Event for TOP RICHEST ONLY
RegisterNetEvent("mb-GetRichPlayer:server:getTopPlayerMoney", function(type)
    if (type == "full") then
        local topRichestPlayers = MySQL.Sync.fetchAll("SELECT concat(JSON_VALUE(charinfo, '$.firstname'),' ', JSON_VALUE(charinfo, '$.lastname'))  as name, `citizenid`, JSON_VALUE(money, '$.bank')+JSON_VALUE(money, '$.paycheck') AS `total_money`, `money`, `citizenid`  FROM `players`  ORDER BY `total_money` DESC LIMIT ?", {Config.OnlyTopRichest.top})
        local resultWithLicense = ''

        for _, v in pairs(topRichestPlayers) do
            resultWithLicense = resultWithLicense .. "`" .. _ .. "." .. Lang:t("message.top_with_license", {name = topRichestPlayers[_]["name"], citizenid = topRichestPlayers[_]["citizenid"], license = topRichestPlayers[_]["license"], money = topRichestPlayers[_]["money"], totalMoney = topRichestPlayers[_]["total_money"]})
        end

        sendToDiscord(resultWithLicense) --Send log to discord
    elseif (type == "standard") then
        local topRichestPlayers = MySQL.Sync.fetchAll("SELECT concat(JSON_VALUE(charinfo, '$.firstname'),' ', JSON_VALUE(charinfo, '$.lastname'))  as name, `citizenid`, JSON_VALUE(money, '$.bank')+JSON_VALUE(money, '$.paycheck') AS `total_money`, `money`, `citizenid`  FROM `players`  ORDER BY `total_money` DESC LIMIT ?", {Config.OnlyTopRichest.top})
        local resultWithoutLicense = ''

        for _, v in pairs(topRichestPlayers) do
            resultWithoutLicense = resultWithoutLicense .. "`" .. _ .. "." .. Lang:t("message.top_without_license", {name = topRichestPlayers[_]["name"], citizenid = topRichestPlayers[_]["citizenid"], money = topRichestPlayers[_]["money"], totalMoney = topRichestPlayers[_]["total_money"]})
        end

        sendToDiscord(resultWithoutLicense) --Send log to discord
    else
        local topRichestPlayers = MySQL.Sync.fetchAll("SELECT concat(JSON_VALUE(charinfo, '$.firstname'),' ', JSON_VALUE(charinfo, '$.lastname'))  as name, `citizenid`, JSON_VALUE(money, '$.bank')+JSON_VALUE(money, '$.paycheck') AS `total_money` FROM `players`  ORDER BY `total_money` DESC LIMIT ?", {Config.OnlyTopRichest.top})
        local shortMsg = ''

        for _, v in pairs(topRichestPlayers) do
            shortMsg = shortMsg .. "`" .. _ .. "." .. Lang:t("message.short_top_message", {name = topRichestPlayers[_]["name"], citizenid = topRichestPlayers[_]["citizenid"], totalMoney = topRichestPlayers[_]["total_money"]})
        end

        sendToDiscord(shortMsg) --Send log to discord
    end
end)

--Event for ALL PLAYER
RegisterNetEvent("mb-GetRichPlayer:server:getAllPlayerMoney", function(type)
    if (type == "full") then
        local topRichestPlayers = MySQL.Sync.fetchAll("SELECT concat(JSON_VALUE(charinfo, '$.firstname'),' ', JSON_VALUE(charinfo, '$.lastname'))  as name, `citizenid`, JSON_VALUE(money, '$.bank')+JSON_VALUE(money, '$.paycheck') AS `total_money`, `money`, `citizenid` FROM `players` GROUP BY `citizenid` ORDER BY `total_money` DESC")
        local resultWithLicense = ''

        for _, v in pairs(topRichestPlayers) do
            resultWithLicense = resultWithLicense .. "`" .. _ .. "." .. Lang:t("message.top_with_license", {name = topRichestPlayers[_]["name"], citizenid = topRichestPlayers[_]["citizenid"], license = topRichestPlayers[_]["license"], money = topRichestPlayers[_]["money"], totalMoney = topRichestPlayers[_]["total_money"]})
        end

        sendToDiscord(resultWithLicense) --Send log to discord
    elseif (type == "standard") then
        local topRichestPlayers = MySQL.Sync.fetchAll("SELECT concat(JSON_VALUE(charinfo, '$.firstname'),' ', JSON_VALUE(charinfo, '$.lastname'))  as name, `citizenid`, JSON_VALUE(money, '$.bank')+JSON_VALUE(money, '$.paycheck') AS `total_money`, `money`, `citizenid` FROM `players` GROUP BY `citizenid` ORDER BY `total_money` DESC")
        local resultWithoutLicense = ''

        for _, v in pairs(topRichestPlayers) do
            resultWithoutLicense = resultWithoutLicense .. "`" .. _ .. "." .. Lang:t("message.top_without_license", {name = topRichestPlayers[_]["name"], citizenid = topRichestPlayers[_]["citizenid"], money = topRichestPlayers[_]["money"], totalMoney = topRichestPlayers[_]["total_money"]})
        end

        sendToDiscord(resultWithoutLicense) --Send log to discord
    else
        local topRichestPlayers = MySQL.Sync.fetchAll("SELECT concat(JSON_VALUE(charinfo, '$.firstname'),' ', JSON_VALUE(charinfo, '$.lastname'))  as name, `citizenid`, JSON_VALUE(money, '$.bank')+JSON_VALUE(money, '$.paycheck') AS `total_money`, `money`, `citizenid` FROM `players` GROUP BY `citizenid` ORDER BY `total_money` DESC")
        local shortMsg = ''

        for _, v in pairs(topRichestPlayers) do
            shortMsg = shortMsg .. "`" .. _ .. "." .. Lang:t("message.short_top_message", {name = topRichestPlayers[_]["name"], citizenid = topRichestPlayers[_]["citizenid"], totalMoney = topRichestPlayers[_]["total_money"]})
        end

        sendToDiscord(shortMsg) --Send log to discord
    end
end)

--Auto send log to discord
RegisterNetEvent("mb-GetRichPlayer:server:sendLog", function()
    if (Config.OnlyTopRichest.enable) then
        TriggerEvent("mb-GetRichPlayer:server:getTopPlayerMoney", Config.LogMessageType)
    else
        TriggerEvent("mb-GetRichPlayer:server:getAllPlayerMoney", Config.LogMessageType)
    end
end)