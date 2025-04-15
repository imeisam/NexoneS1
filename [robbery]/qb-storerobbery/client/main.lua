local QBCore = exports['qb-core']:GetCoreObject()
 currentRegister   = 0
local currentSafe = 0
local CurrentCops = 0
 openingDoor = false
local inSafe = false

local function checkSafeCan()
    local pos = GetEntityCoords(PlayerPedId())
    for safe,_ in pairs(Config.Safes) do
        local dist = GetDistanceBetweenCoords(pos, Config.Safes[safe].x, Config.Safes[safe].y, Config.Safes[safe].z)
        if dist < 5 then
            if not Config.Safes[safe].robbed then
                return true
            end
        end
    end
    return false
end

local function setupRegister()
    QBCore.Functions.TriggerCallback('qb-storerobbery:server:getRegisterStatus', function(Registers)
        Config.Registers = Registers
    end)
end

local function setupSafes()
    QBCore.Functions.TriggerCallback('qb-storerobbery:server:getSafeStatus', function(Safes)
        Config.Safes = Safes
    end)
end

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(100)
    end
end

local function LockpickDoorAnim(time)
    time = time / 1000
    loadAnimDict("veh@break_in@0h@p_m_one@")
    TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds" ,3.0, 3.0, -1, 16, 0, false, false, false)
    openingDoor = true
    CreateThread(function()
        while openingDoor do
            TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Wait(2000)
            time = time - 2
            if time <= 0 then
                openingDoor = false
                StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
            end
        end
    end)
end

CreateThread(function()
    Wait(1000)
    setupRegister()
    setupSafes()
end)

CreateThread(function()
    exports['qb-target']:AddTargetModel({'prop_till_01',}, {
        options = {
        {
            icon = 'fa-solid fa-screwdriver',
            label = 'Rob Register',
            action = function(entity)
                if IsPedAPlayer(entity) then return false end
                QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                    if result then
                        TriggerEvent('qb-storerobbery:Lockpick')
                    else
                        QBCore.Functions.Notify('You Do Not Have Lockpick', 'error')
                    end
                end, 'lockpick')
            end,
            canInteract = function(entity, distance, data)
                local ped = PlayerPedId()
                local pos = GetEntityCoords(ped)
                local sani = GetClosestObjectOfType(pos, 2.0, GetHashKey('prop_till_01'), false)
                if DoesEntityExist(sani) then
                    local ped = PlayerPedId()
                    local pos = GetEntityCoords(ped)
                    for k, v in pairs(Config.Registers) do
                        local dist = #(pos - Config.Registers[k][1].xyz)
                        if dist <= 1 then
                            return true
                        end
                    end
                end
            end,
            },
        },
        distance = 2.5,
    })
end)

CreateThread(function()
    for safe,_ in ipairs(Config.Safes) do
        currentSafe = safe
        exports["qb-target"]:AddCircleZone("StoreSafe"..safe, vector3(Config.Safes[safe].x, Config.Safes[safe].y, Config.Safes[safe].z), 0.80, {
            name="StoreSafe"..safe,
            useZ=true,
            }, {
                options = {
                    {
                        action = function(entity)
                            TriggerEvent('qb-storerobbery:client:safe', safe)
                        end,
                        canInteract = function()
                            return checkSafeCan()
                        end,
                        icon = "fas fa-clipboard",
                        label = "Open Safe",
                    },
                },
                distance = 1.5
            }
        )
    end
end)

RegisterNetEvent('police:SetCopCount', function(amount,amounthigh)
    CurrentCops = amount
end)

RegisterNetEvent('qb-storerobbery:client:setRegisterStatus', function(batch, val)
    Config.Registers[batch].robbed = val
end)

RegisterNetEvent('qb-storerobbery:client:setSafeStatus', function(safe, bool)
    Config.Safes[safe].robbed = bool
end)

RegisterNetEvent('qb-storerobbery:Lockpick', function()
    for k, v in pairs(Config.Registers) do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local dist = #(pos - Config.Registers[k][1].xyz)
        if dist <= 1 then
            if Config.Registers[k].robbed then
                QBCore.Functions.Notify("Cashier is Empty", "error")
            else
                if exports["qb-smallresources"]:getdevelopermode() or  CurrentCops >=2 then
                    QBCore.Functions.TriggerCallback('qb-storerobbery:server:getregistercooldown', function(result)
                        if result then
                            exports['qb-dispatch']:StoreRobbery(0)
                            local success = exports['nxo-MiniGames']:lockpicking(12,4,20000)
                            if not success then return end
                            local station,zarib=exports['qb-policejob']:getpolicestation()
                            waititme=(#(pos-station.xyz)*zarib)*1200
                            TriggerServerEvent("inventory:server:breakItem", "lockpick", 15)
                            QBCore.Functions.Progressbar("search_register", "Opening The Register..", waititme, false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {
                                animDict = "veh@break_in@0h@p_m_one@",
                                anim = "low_force_entry_ds",
                                flags = 16,
                            }, {}, {}, function()
                                currentRegister = k
                                TriggerServerEvent('qb-storerobbery:server:finishLockpick')
                                if currentRegister ~= 0 then
                                    TriggerServerEvent('qb-storerobbery:server:setRegisterStatus', currentRegister)
                                end
                                openingDoor = false
                                currentRegister = 0
                            end, function()

                            end)
                        else
                            QBCore.Functions.Notify("Not Allow this time...", "error")
                            return
                        end
                    end)

                  
                else
                    QBCore.Functions.Notify("Not Enough Police", "error")
                end
                break
            end
        end
    end
end)

RegisterNetEvent('qb-storerobbery:client:safe', function(currentSafe)
    if not Config.Safes[currentSafe].robbed then
        if exports["qb-smallresources"]:getdevelopermode() or  CurrentCops >=4 then
            if exports['qb-cooldown']:isCooldown() then
                QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                    if result then
                        if math.random(1, 100) <= 50 then
                            TriggerServerEvent('hud:Server:GainStress', math.random(5,8))
                        end
                      
                            if exports['qb-cooldown']:isCooldown() then
                                TriggerServerEvent("inventory:server:breakItem", "safe_cracker", 34)
                                local success = exports['bd-minigames']:PinCracker(4, 60)
                                if success then
                                    exports['qb-dispatch']:Safecracker(Config.Safes[currentSafe].camId)

                                    TriggerServerEvent("qb-cooldown:server:startglobaltimeout", 30)
                                    local ped = PlayerPedId()
                                    local pos = GetEntityCoords(ped)
                                    local station,zarib=exports['qb-policejob']:getpolicestation()
                                    local time=(#(pos-station.xyz)*zarib)*1000
                                    time=time+180000
                                    LockpickDoorAnim(time)
                                    QBCore.Functions.Progressbar("opening_safe", "Opening Safe..", time, false, true, {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    }, {
                                        animDict = "veh@break_in@0h@p_m_one@",
                                        anim = "low_force_entry_ds",
                                        flags = 16,
                                    }, {}, {}, function()
                                        openingDoor = false
                                        ClearPedTasks(PlayerPedId())
                                        TriggerServerEvent('qb-storerobbery:server:SafeReward')
                                        TriggerServerEvent("qb-storerobbery:server:setSafeStatus", currentSafe)
                                    end, function()
                                        openingDoor = false
                                        ClearPedTasks(PlayerPedId())
                                    end)
                                end
                            end
                       
                    else
                        QBCore.Functions.Notify("You Are Missing An Item", "error")
                    end
                end, "safe_cracker")
            end
        else
            QBCore.Functions.Notify("Not enough police", "error")
        end
    else
        QBCore.Functions.Notify("Safe Is Robbed", "error")
    end
end)