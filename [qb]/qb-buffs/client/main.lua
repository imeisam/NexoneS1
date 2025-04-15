local QBCore = exports['qb-core']:GetCoreObject()

local function GetBuffs()
    -- If making multiple calls to GetBuffs we dont get a result of the 2nd call
    -- The wait seems to fix the issue
    Wait(500)
    local p = promise.new()
    QBCore.Functions.TriggerCallback('buffs:server:fetchBuffs', function(result)
        p:resolve(result)
    end)
    return Citizen.Await(p)
end

--- Method to fetch if player has buff with name and is not nil
--- @param buffName string - Name of the buff
--- @return bool
local function HasBuff(buffName)
    local buffs = GetBuffs()
    if buffs then
        return buffs[buffName] ~= nil
    end
    return false
end exports('HasBuff', HasBuff)

--- Method to fetch buff details if player has buff active
--- @param buffName string - Name of the buff
--- @return table
local function GetBuff(buffName)
    local buffData = Config.Buffs[buffName]
    -- Check if we were given a correct buff name
    if buffData == nil then
        return nil
    end

    local buffs = GetBuffs()
    local time = nil
    
    if buffs then
        time = buffs[buffName]
    end

    if time == nil then
        time = 0
    end

    if buffData.type == 'buff' then
        return {
            time = time,
            buffName = buffName,
            iconName = buffData.iconName,
            iconColor = buffData.iconColor,
            progressColor = buffData.progressColor,
            progressValue = (time * 100) / buffData.maxTime,
            type = buffData.type,
        }
    else
        return {
            time = time,
            iconColor = buffData.iconColor,
            maxTime = buffData.maxTime,
            type = buffData.type,
        }
    end
end exports('GetBuff', GetBuff)

--- Method to fetch nui details of all buffs, used when a player that had buffs
--- logged out and back in to the server
--- @return table | nil
local function GetBuffNUIData()
    local buffs = GetBuffs()

    if buffs == nil then
        return nil
    end

    local nuiData = {}

    for buffName, buffTime in pairs(buffs) do
        local buffData = Config.Buffs[buffName]

        if buffData.type == 'buff' then
            nuiData[buffName] = {
                buffName = buffName,
                display = true,
                iconName = buffData.iconName,
                iconColor = buffData.iconColor,
                progressColor = buffData.progressColor,
                progressValue = (buffTime * 100) / buffData.maxTime,
            }
        else
            nuiData[buffName] = {
                display = true,    
                enhancementName = buffName,
                iconColor = buffData.iconColor
            }
        end
    end

    return nuiData
end exports('GetBuffNUIData', GetBuffNUIData)

--- Method to add buff to player
--- @param playerID string - Player identifier
--- @param buffName string - Name of the buff
--- @return bool - Success of removing the player buff
local function AddBuff(buffName, time)
    local p = promise.new()
    QBCore.Functions.TriggerCallback('buffs:server:addBuff', function(result)
        p:resolve(result)
    end, buffName, time)
    return Citizen.Await(p)
end exports('AddBuff', AddBuff)




--- Custom Buffs, edit to your liking ---

--- Method to add stamina buff to player
--- @param time  - Time in ms the health buff will be active
--- @param value - The amount of speed boost the player will recieve
local hasStaminaBuffActive = false
local function StaminaBuffEffect(time, value)
    AddBuff("stamina", time)
    if not hasStaminaBuffActive then 
        hasStaminaBuffActive = true
        CreateThread(function()
            while exports['qb-buffs']:HasBuff("stamina") do
                Wait(1000)
            end
            hasStaminaBuffActive = false
        end)
        CreateThread(function()
            SetRunSprintMultiplierForPlayer(PlayerId(), value)
            while hasStaminaBuffActive do
                Wait(100)
                ResetPlayerStamina(PlayerId())
            end
            SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
            hasStaminaBuffActive = false
        end)
    end
end exports('StaminaBuffEffect', StaminaBuffEffect)

--- Method to add swimming buff to player
--- @param time  - Time in ms the health buff will be active
--- @param value - The amount of swimming speed boost the player will recieve
local hasSwimmingBuffActive = false
local function SwimmingBuffEffect(time, value)
    AddBuff("swimming", time)
    if not hasSwimmingBuffActive then 
        hasSwimmingBuffActive = true
        CreateThread(function()
            SetSwimMultiplierForPlayer(PlayerId(), value)
            while exports['qb-buffs']:HasBuff("swimming") do
                Wait(500)
                SetPlayerStamina(PlayerId(), GetPlayerMaxStamina(PlayerId()))
            end
            SetSwimMultiplierForPlayer(PlayerId(), 1.0)
            hasSwimmingBuffActive = false
        end)
    end
end exports('SwimmingBuffEffect', SwimmingBuffEffect)

--- Method to add xray buff to player
--- @param time  - Time in ms the xray buff will be active
local hasXrayBuffActive = false
local function AddXrayBuff(time)
    AddBuff("xray", time)
    if not hasXrayBuffActive then
        hasXrayBuffActive = true
        TriggerEvent('heli:DisableXRAY', true)
        CreateThread(function()
            while HasBuff("xray") do
                Wait(1000)
            end
            hasXrayBuffActive = false
            TriggerEvent('heli:DisableXRAY', false)
        end)
    end
end exports('AddXrayBuff', AddXrayBuff)

--- Method to add recoil buff to player
--- @param time  - Time in ms the recoil buff will be active
local hasRecoilBuffActive = false
local function RecoilBuffEffect(time)
    AddBuff("recoil", time)
    if not hasRecoilBuffActive then 
        hasRecoilBuffActive = true
        CreateThread(function()
            TriggerEvent('ring:client:recoilbuff', true)
            while exports['qb-buffs']:HasBuff("recoil") do
                Wait(500)
            end
            TriggerEvent('ring:client:recoilbuff', false)
            hasRecoilBuffActive = false
        end)
    end
end exports('RecoilBuffEffect', RecoilBuffEffect)

--- Method to add hack buff to player
--- @param time  - Time in ms the hack buff will be active
local hasHackBuffActive = false
local function HackBuffEffect(time)
    AddBuff("hacking", time)
    if not hasHackBuffActive then 
        hasHackBuffActive = true
        CreateThread(function()
            LocalPlayer.state:set('isHackBuff', true, false)
            while exports['qb-buffs']:HasBuff("hacking") do
                Wait(500)
            end
            LocalPlayer.state:set('isHackBuff', false, false)
            hasHackBuffActive = false
        end)
    end
end exports('HackBuffEffect', HackBuffEffect)

--- Method to add cuff buff to player
--- @param time  - Time in ms the cuff buff will be active
local hasCuffBuffActive = false
local function CuffBuffEffect(time)
    AddBuff("cuff", time)
    if not hasCuffBuffActive then 
        hasCuffBuffActive = true
        CreateThread(function()
            TriggerEvent('ring:client:cuff', true)
            while exports['qb-buffs']:HasBuff("cuff") do
                Wait(500)
            end
            TriggerEvent('ring:client:cuff', false)
            hasCuffBuffActive = false
        end)
    end
end exports('CuffBuffEffect', CuffBuffEffect)

--- Method to add health buff to player
--- @param time  - Time in ms the health buff will be active
--- @param value - The amount of HP the player will gain over time

local hasHealthBuffActive = false
local function AddHealthBuff(time, value)
    AddBuff("super-health", time)
    if not hasHealthBuffActive then
        hasHealthBuffActive = true
        CreateThread(function()
            while HasBuff("super-health") do
                Wait(2500)
                local currentHP = GetEntityHealth(PlayerPedId())
                if currentHP < 200 then
                    if currentHP + value > 200 then
                        SetEntityHealth(PlayerPedId(), 200)
                    else
                        SetEntityHealth(PlayerPedId(), currentHP + value)
                    end
                end
            end
            hasHealthBuffActive = false
        end)
    end
end exports('AddHealthBuff', AddHealthBuff)

--- Method to add armor buff to player
--- @param time  - Time in ms the health buff will be active
--- @param value - The amount of Armor the player will gain over time

local hasArmorBuffActive = false
local function AddArmorBuff(time, value)
    if not hasArmorBuffActive then
        AddBuff("super-armor", time)
        hasArmorBuffActive = true
        CreateThread(function()
            local timee = time
            while timee > 0 do
                Wait(1000)
                timee = timee - 1000
            end
            hasArmorBuffActive = false
        end)
        CreateThread(function()
            -- while HasBuff("super-armor") do
            while hasArmorBuffActive do
                Wait(2000)
                local currentArmor = GetPedArmour(PlayerPedId())
                if currentArmor < 50 then
                    if currentArmor + value > 50 then
                        SetPedArmour(PlayerPedId(), 50)
                    else
                        SetPedArmour(PlayerPedId(), currentArmor + value)
                    end
                end
            end
        end)
    end
end exports('AddArmorBuff', AddArmorBuff)

--- Method to add stress buff to player
--- @param time  - Time in ms the stress buff will be active
--- @param value - The amount of stress the player will lose every 5 seconds
local hasStressBuffActive = false
local function AddStressBuff(time, value)
    AddBuff("super-stress", time)
    if not hasStressBuffActive then
        hasStressBuffActive = true
        CreateThread(function()
            while HasBuff("super-stress") do
                Wait(4000)
                TriggerServerEvent("hud:server:RelieveStress", value)
            end
            hasStressBuffActive = false
        end)
    end
end exports('AddStressBuff', AddStressBuff)