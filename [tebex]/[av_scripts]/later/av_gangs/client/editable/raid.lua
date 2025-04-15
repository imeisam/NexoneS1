local raidBlip = nil
-- Raid minigame config:
local alphabet = {
    ['0'] = {
        hand = "left",
        seconds = 8,
        blocks = 12,
    },
    ['1'] = {
        hand = "right",
        seconds = 7,
        blocks = 14,
    },
    ['2'] = {
        hand = "both",
        seconds = 7,
        blocks = 15,
    },
    ['3'] = {
        hand = "both",
        seconds = 6,
        blocks = 18,
    },
}
--[[
    - level can be 0, 1, 2 or 3 (number) depending on the property security level
    - if u are gonna replace the minigame make sure you know what you're doing, I don't provide any support to custom modifications that u make...
    - hackingGame receives if is a cop the one doing the minigame / false = is a rival gang member
    - type can be offices, warehouse or lab depending on the property type
    - gang is the gang owner of property
    - level the security level of that property
    - I know this variables aren't used by default (only level) but maybe someone can need it to do something more complex
]]

function hackingGame(isCop,type,gang,level)
    local ped = PlayerPedId()
    local difficulty = alphabet[tostring(level)]
    TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_STAND_MOBILE', -1, true)
    Citizen.Wait(3000)
    local res = exports['av_alphabet']:start(difficulty['hand'], difficulty['seconds'], difficulty['blocks'])
    ClearPedTasksImmediately(ped)
    return res
end

-- I used this command to test minigame with the different levels (0 - 3) I was able to complete them, so is not impossible...
-- RegisterCommand("hack", function()
--     local res = hackingGame(nil,nil,nil,3) -- change 3 to whatever level u want
--     print(res)
-- end)

function isCop() -- check if player at door is cop
    if not Config.Police then return false end
    local job = exports['av_laptop']:getJob().name
    local grade = exports['av_laptop']:getGrade()
    if not job or not grade then return false end
    debug("isCop(), ".."job:"..job..", grade: "..grade)
    if Config.Police[job] then
        return Config.Police[job][grade]
    end
    return false
end

function isRivalGang(gang) -- check if player at door is from a rival gang
    if not PlayerGang then return false end
    if PlayerGang and PlayerGang.name ~= gang then
        return true
    end
    return false
end

-- raid blip:
RegisterNetEvent('av_gangs:alert', function(coords, data)
    if not coords then return end
    TriggerEvent('av_laptop:notification', data['title'], data['alertText'], 'inform')
    if not raidBlip then
        raidBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(raidBlip, 84)
        SetBlipHighDetail(raidBlip, true)
        SetBlipColour(raidBlip, 1)
        SetBlipAlpha(raidBlip, 200)
        SetBlipAsShortRange(raidBlip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(data['blipText'])
        EndTextCommandSetBlipName(raidBlip)
        CreateThread(function()
            Wait(3 * 60 * 1000)
            if raidBlip and DoesBlipExist(raidBlip) then
                RemoveBlip(raidBlip)
                raidBlip = nil
            end
        end)
    end
end)

-- some extra checks before minigame
function extraChecks(gang,isCop,level)
    debug("extraChecks()", gang, isCop, level)
    local online = lib.callback.await('av_gangs:getOnline', false, gang, "raid", level)
    debug("online", online)
    if Config.MinMembersOnline and Config.MinMembersOnline > 0 then
        if online < Config.MinMembersOnline then
            debug("not enough online")
            TriggerEvent('av_laptop:notification', false, Lang['not_now'], "error")
            return false
        end
    end
    if isCop and Config.PoliceNeedsItem then
        debug("isCop and Config.PoliceNeedsItem...")
        local hasItem = exports['av_laptop']:hasItem(Config.PoliceNeedsItem, 1)
        if hasItem then
            debug("isCop and Config.PoliceNeedsItem > removeItem")
            exports['av_laptop']:removeItem(Config.PoliceNeedsItem, 1)
            return true
        else
            debug("isCop and Config.PoliceNeedsItem > no item")
            TriggerEvent('av_laptop:notification', false, Lang['no_item'], "error")
            return false
        end
    end
    if not isCop and (Config.MinLevelForRaid and Config.MinLevelForRaid > 0) then
        debug("isGang and (Config.MinLevelForRaid and Config.MinLevelForRaid > 0)...")
        local gangLevel = lib.callback.await('av_gangs:getLevel', false, gang)
        debug("gangLevel: ", gangLevel)
        if gangLevel < Config.MinLevelForRaid then
            debug("not enough gang level for raid")
            TriggerEvent('av_laptop:notification', false, Lang['not_enough_level'], "error")
            return false
        end
    end
    if not isCop and Config.GangsNeedItem then
        debug("not isCop and Config.GangsNeedItem...")
        local hasItem = exports['av_laptop']:hasItem(Config.GangsNeedItem, 1)
        debug("hasItem...", Config.GangsNeedItem)
        if hasItem then
            debug("hasItem true")
            exports['av_laptop']:removeItem(Config.GangsNeedItem, 1)
            return true
        else
            debug("hasItem false")
            TriggerEvent('av_laptop:notification', false, Lang['no_item'], "error")
            return false
        end
    end
    return true
end