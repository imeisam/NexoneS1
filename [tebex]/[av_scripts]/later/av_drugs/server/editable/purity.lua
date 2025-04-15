-- Receives player identifier (just in case u need it), table drug, input formula and xp
function calculatePurity(identifier,drug,input,xp) -- used for tables
    dbug('calculatePurity()', identifier, drug)
    local sum = 0
    local playerXP = xp or 0
    if input and next(input) then
        for k, v in pairs(input) do
            dbug(v['key'], v['value'])
            sum += v['value'] or 0
        end
    end
    if sum < 0 then sum = 1 end
    dbug("input sum: "..sum)
    local level = math.floor(playerXP / 100 * 10)
    dbug("playerLevel: "..level)
    local product = sum * level
    local result = (product % 100) + 1
    if playerXP >= 100 and result == 1 then
       return 100 
    end
    return math.floor(result)
end

function calculateLabPurity(identifier,drug,input,xp) -- used for labs
    dbug('calculateLabPurity()', identifier, drug)
    local sum = 0
    local labXP = xp or 0
    if input and next(input) then
        for k, v in pairs(input) do
            dbug(v['key'], v['value'])
            sum += v['value'] or 0
        end
    end
    if sum < 0 then sum = 1 end
    dbug("input sum: "..sum)
    local level = math.floor(labXP / 100 * 10)
    dbug("labLevel: "..level)
    local product = sum * level
    local result = (product % 100) + 1
    if labXP >= 100 and result == 1 then
       return 100 
    end
    return math.floor(result)
end

-- Made for testing only
-- CreateThread(function()
--     while true do
--         local xp = 10
--         local res = calculatePurity('abc123',"moonshine_still",{math.random(1,10),math.random(1,10),math.random(1,10), math.random(1,10), math.random(-10,-1)},xp)
--         if res >= 100 then print("^2"..res) else print('^1'..res) end
--         Wait(1)
--     end
-- end)