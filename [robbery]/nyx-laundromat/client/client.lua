local QBCore = exports['qb-core']:GetCoreObject()

local animationObjects = {}
local scenes = {}
local animStages = {
    ['intro'] = { 'action_var_01', 'action_var_01_ch_prop_ch_usb_drive01x', 'action_var_01_prop_phone_ing' },
    ['idle'] = {'hack_loop_var_01', 'hack_loop_var_01_ch_prop_ch_usb_drive01x', 'hack_loop_var_01_prop_phone_ing'},
    ['outro'] = {'success_react_exit_var_01', 'success_react_exit_var_01_ch_prop_ch_usb_drive01x', 'success_react_exit_var_01_prop_phone_ing'},
}

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        
        Wait(500)
        for key, data in pairs(Config.PowerLocations) do
            if type(data.doorids) == 'table' then
                for _, doorId in pairs(data.doorids) do
                    if Config.DoorLock == 'ox' then
                        TriggerServerEvent('nyx-laundromat:updateoxlocks', doorId, true)
                    else
                        TriggerServerEvent('qb-doorlock:server:updateState', doorId, true, false, false, true, false, false)
                    end
                end
            else
                if Config.DoorLock == 'ox' then
                    TriggerServerEvent('nyx-laundromat:updateoxlocks', data.doorids, true)
                else
                    TriggerServerEvent('qb-doorlock:server:updateState', data.doorids, true, false, false, true, false, false)
                end
            end
        end
        TriggerServerEvent('nyx-laundromat:togglealarm', 'power', false)
    end
end)
----------------------
----------------------
-- STATE EVENTS ------
----------------------
----------------------

RegisterNetEvent('nyx-laundromat:setbusystate', function(id, state)
    if id == 'generator' then
        Config.PowerLocations[id].isBusy = state
    elseif id == 'power' then
        Config.PowerLocations[id].isBusy = state
    elseif id == 'safe' then
        Config.Safe.isBusy = state
    else
        Config.LaundryMachines[id].isBusy = state
    end
end)

RegisterNetEvent('nyx-laundromat:setcutstate', function(id, state)
    Config.PowerLocations[id].cut = state
end)

RegisterNetEvent('nyx-laundromat:openstate', function(id, state)
    if id == 'safe' then
        Config.Safe.opened = state
    else
        Config.LaundryMachines[id].opened = state
    end
end)

RegisterNetEvent('nyx-laundromat:minusattempts', function(amount)
    Config.Safe.attempts = Config.Safe.attempts - amount
end)

RegisterNetEvent('nyx-laundromat:resetattempts', function(amount)
    Config.Safe.attempts = amount
    for id, data in pairs(Config.LaundryMachines) do
        exports['qb-interact']:RemoveInteraction('laundromat_machine_'..id)
    end
    exports['qb-interact']:RemoveInteraction('laundromat_safe')
    exports['qb-interact']:RemoveInteraction('laundromat_computer')

end)


RegisterNetEvent('nyx-laundromat:resetallstates', function ()
    for id, data in pairs(Config.PowerLocations) do
        if data.isBusy then
            TriggerServerEvent('nyx-laundromat:setbusystate', id, false)
        end
        if data.cut then
            TriggerServerEvent('nyx-laundromat:setcutstate', id, false)
        end
    end
    if Config.Safe.isBusy then
        TriggerServerEvent('nyx-laundromat:setbusystate', 'safe', false)
    end
    if Config.Safe.opened then
        TriggerServerEvent('nyx-laundromat:openstate', 'safe', false)
    end
    if Config.Usb.isBusy then
        TriggerServerEvent('nyx-laundromat:setbusystate', 'usb', false)
    end
    for id, data in pairs(Config.LaundryMachines) do
        if data.isBusy then
            TriggerServerEvent('nyx-laundromat:setbusystate', id, false)
        end
        if data.opened then
            TriggerServerEvent('nyx-laundromat:openstate', id, false)
        end
    end
    TriggerServerEvent('nyx-laundromat:resetattempts')
end)

----------------------
----------------------
-- END STATE EVENTS --
----------------------
----------------------

CreateThread(function()
    local generatorData = Config.PowerLocations['generator']
    exports['qb-interact']:AddInteraction({
        coords = generatorData.coords,
        distance = 1.5,
        interactDst = 1.0,
        id = 'laundromat_power_power',
        options = {
            {
                label = 'Cut Generator Power',
                action = function(entity, coords, args)
                    CutGeneratorPower('generator', generatorData)
                end,

                canInteract = function(entity, coords, args)
                    return not generatorData.isBusy and not generatorData.cut
                end,
            },
        }
    })
    local powerData = Config.PowerLocations['power']
    exports['qb-interact']:AddInteraction({
        coords = powerData.coords,
        distance = 1.5,
        interactDst = 1.0,
        id = 'laundromat_power_power',
        options = {
            {
                label = 'Cut Power',
                action = function(entity, coords, args)
                    CutPower('power', powerData)
                end,

                canInteract = function(entity, coords, args)
                    return not powerData.isBusy and not powerData.cut and generatorData.cut
                end,
            },
            {
                label = 'Restore Power',
                groups = {
                    ['police'] = 0, -- Jobname | Job grade
                    ['justice'] = 0,
                },
                action = function(entity, coords, args)
                    RestorePower()
                end,

                canInteract = function(entity, coords, args)
                    return not powerData.isBusy and powerData.cut
                end,
            },
        }
    })
    
end)

function StartPhoneAnimation(playerCoords, usbCoords)
    local animDict = 'anim_heist@hs3f@ig1_hack_keypad@arcade@male@'
    local usbHash = `ch_prop_ch_usb_drive01x`
    local phoneHash = `ch_prop_ch_phone_ing_01a`
    lib.requestAnimDict(animDict)
    
    local usbObject = CreateObject(usbHash, 0, 0, 0, true, true, true)
    local phoneObject = CreateObject(phoneHash, 0, 0, 0, true, true, true)
    animationObjects.usbObject = usbObject
    animationObjects.phoneObject = phoneObject

    TaskGoStraightToCoord(cache.ped, playerCoords.x, playerCoords.y, playerCoords.z, 1.0, 2000, playerCoords.w, 0.0)
    Wait(600)
    for _, stage in ipairs({'intro', 'idle', 'outro'}) do
        local animData = animStages[stage]
        scenes[stage] = NetworkCreateSynchronisedScene(usbCoords.x, usbCoords.y, usbCoords.z, 0.0, 0.0, playerCoords.w, 2, false, false, 1065353216, 0, 1065353216)
        NetworkAddPedToSynchronisedScene(cache.ped, scenes[stage], animDict, animData[1], 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(usbObject, scenes[stage], animDict, animData[2], 1.5, -4.0, 1)
        NetworkAddEntityToSynchronisedScene(phoneObject, scenes[stage], animDict, animData[3], 1.5, -4.0, 1)
    end

    NetworkStartSynchronisedScene(scenes['intro'])
    Wait(5000)
    NetworkStartSynchronisedScene(scenes['idle'])
    Wait(1000)
end

function FinishPhoneAnimation()
    NetworkStartSynchronisedScene(scenes['outro'])
    Wait(5000)
    
    DeleteObject(animationObjects.usbObject)
    DeleteObject(animationObjects.phoneObject)
    animationObjects = {}
end

function TriggerAlert()
    if Config.Dispatch == 'ps' then
        exports['qb-dispatch']:LaundroMat()
    elseif Config.Dispatch == 'cd' then
        local data = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = {'police'},
            coords = data.coords,
            title = '10-90 - Robbery In Progress',
            message = 'LaundroMat Robbery at '..data.street,
            flash = 0,
            unique_id = tostring(math.random(0000000,9999999)),
            blip = {
                sprite = 67,
                scale = 1.5,
                colour = 2,
                flashes = false,
                text = '911 - Robbery In Progress',
                time = (5*60*1000),
                sound = 1,
            }
        })
    end
end

function CutGeneratorPower(id, data)
    if data.requireditem ~= ''  then
        local item = nil
        if Config.Inventory == 'ox' then
            item = exports.ox_inventory:Search('count', data.requireditem) > 0
        else
            item = QBCore.Functions.HasItem(data.requireditem, 1)
        end
        if not item then
            TriggerEvent("QBCore:Notify", "You are missing something to cut the power!", "error")
            return
        end
    end

    local hasCops = lib.callback.await('nyx-laundromat:hasenoughcops', false)
    if exports["qb-smallresources"]:getdevelopermode() or (hasCops and exports['qb-cooldown']:isCooldown()) then
        if not data.isBusy and not data.cut then
            TriggerServerEvent('nyx-laundromat:setbusystate', id, true)

            local usbCoords = vector3(106.37, -1559.57, 29.88)
            local playerCoords = vector4(106.92, -1558.92, 29.42, 138.78)
            StartPhoneAnimation(playerCoords, usbCoords)
            QBCore.Functions.Progressbar("dar_main", "Hacking the Front Doors...", 10000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
              }, {}, {}, {}, function()
                TriggerServerEvent("qb-cooldown:server:startglobaltimeout", 90)
                FinishPhoneAnimation()
                TriggerAlert()
                TriggerServerEvent('nyx-laundromat:setbusystate', id, false)
                TriggerServerEvent('nyx-laundromat:setcutstate', id, true)
                Wait(500)
                TriggerServerEvent('nyx-laundromat:setupwasherinteracts', data.cut)
                TriggerServerEvent('nyx-laundromat:togglealarm', 'power', true, Config.PowerLocations['power'].coords)
                for key, doorId in pairs(data.doorids) do
                    if Config.DoorLock == 'ox' then
                        TriggerServerEvent('nyx-laundromat:updateoxlocks', doorId, false)
                    else
                        TriggerServerEvent('qb-doorlock:server:updateState', doorId, false, false, false, true, false, false)
                    end
                end

                TriggerEvent("QBCore:Notify", "Generator Power Cut!", "success")
              end, function()
                TriggerServerEvent('nyx-laundromat:setbusystate', id, false)
                TriggerEvent("QBCore:Notify", "Cancelled", "error")
            end)
        end
    else
        TriggerEvent("QBCore:Notify", "Can\'t do this right now...", "error")
    end
end

function RestorePower()
    local usbCoords = vector3(96.56, -1565.03, 30.2)
    local playerCoords = vector4(96.93, -1564.53, 29.61, 143.06)
    StartPhoneAnimation(playerCoords, usbCoords)
    QBCore.Functions.Progressbar("dar_generator", "Cutting Generator power Cables...", 4500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
      }, {}, {}, {}, function()
        FinishPhoneAnimation()
        TriggerEvent('nyx-laundromat:resetallstates')
        TriggerEvent("QBCore:Notify", "Generator Power Cut!", "success")
      end, function()
        TriggerEvent("QBCore:Notify", "Cancelled", "error")
    end)
end

RegisterNetEvent('nyx-laundromat:setupwasherinteracts', function (bool)
    if not bool then return end
    CreateThread(function()
        for id, data in pairs(Config.LaundryMachines) do
            exports['qb-interact']:AddInteraction({
                coords = data.coords,
                distance = 1.5,
                interactDst = 1.0,
                id = 'laundromat_machine_'..id,
                options = {
                    {
                        label = 'Break the Washer',
                        action = function(entity, coords, args)
                            InteractWasher(id, data)
                        end,

                        canInteract = function(entity, coords, args)
                            return not data.isBusy
                        end,
                    },
                }
            })
        end
    end)
end)

RegisterNetEvent('nyx-laundromat:setupofficeinteracts', function (bool, netId)
    if not bool then return end
    CreateThread(function()
        exports['qb-interact']:AddInteraction({
            coords = Config.Safe.coords,
            distance = 1.5,
            interactDst = 1.0,
            id = 'laundromat_safe',
            options = {
                {
                    label = 'Crack Safe',
                    action = function(entity, coords, args)
                        CrackSafe()
                    end,

                    canInteract = function(entity, coords, args)
                        return not Config.Safe.opened and not Config.Safe.isBusy
                    end,
                },
            }
        })
        --if not netId then return end
        -- exports['qb-interact']:AddInteraction({
        --     coords = Config.Usb.coords,
        --     distance = 1.5,
        --     interactDst = 1.0,
        --     id = 'laundromat_computer',
        --     options = {
        --         {
        --             label = 'Take USB',
        --             action = function(entity, coords, args)
        --                 TriggerServerEvent('nyx-laundromat:takeusb')
        --             end,

        --             canInteract = function(entity, coords, args)
        --                 return not Config.Usb.isBusy
        --             end,
        --         },
        --     }
        -- })
    end)
end)

function InteractWasher(id, data)
    if data.isBusy then return end
    if not data.opened then
        TriggerServerEvent('nyx-laundromat:setbusystate', id, true)
        
        local dict = "anim@scripted@player@mission@trn_ig1_loot@heeled@"
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(100)
        end
        TaskPlayAnim(cache.ped, dict, "loot", 8.0, -8.0, -1, 1, 0, false, false, false)

        local minigame = exports["five-repairkit"]:Minigame()
        if minigame then 
            TriggerServerEvent('nyx-laundromat:setbusystate', id, false)
            TriggerServerEvent('nyx-laundromat:openstate', id, true)
            ClearPedTasks(cache.ped)
        else
            ClearPedTasks(cache.ped)
            TriggerServerEvent('nyx-laundromat:setbusystate', id, false)
        end
    else
        if Config.Inventory == 'ox' then
            exports.ox_inventory:openInventory('stash', { id = 'laundromat_'..id})
        else
            TriggerEvent('inventory:client:SetCurrentStash', 'laundromat_'..id)
            TriggerServerEvent('inventory:server:OpenInventory', 'stash', 'laundromat_'..id, {
                maxweight = Config.WasherInventory.weight,
                slots = 1,
            })
        end
    end
end



function CutPower(id, data)
    if data.requireditem ~= '' then
        local item = nil
        if Config.Inventory == 'ox' then
            item = exports.ox_inventory:Search('count', data.requireditem) > 0
        else
            item = QBCore.Functions.HasItem(data.requireditem, 1)
        end
        if not item then
            TriggerEvent("QBCore:Notify", "You are missing something to cut the power!", "error")
            return
        end
    end
    if data.isBusy and data.cut then return end
    LocalPlayer.state.invBusy = true
    TriggerServerEvent('nyx-laundromat:setbusystate', id, true)

    local usbCoords = vector3(96.56, -1565.03, 30.2)
    local playerCoords = vector4(96.93, -1564.53, 29.61, 143.06)
    StartPhoneAnimation(playerCoords, usbCoords)
        local result = exports['nxo-MiniGames']:alphabet(20,20000)
        if result then
            local removedUsb = lib.callback.await('nyx-laundromat:removedgenusb', false, data)
            if removedUsb then
                FinishPhoneAnimation()
                LocalPlayer.state.invBusy = false
                TriggerServerEvent('nyx-laundromat:setbusystate', id, false)
                TriggerServerEvent('nyx-laundromat:setcutstate', id, true)
                Wait(500)
                TriggerServerEvent('nyx-laundromat:setupofficeinteracts', data.cut)
                TriggerServerEvent('nyx-laundromat:togglealarm', 'power', false)

                if Config.DoorLock == 'ox' then
                    TriggerServerEvent('nyx-laundromat:updateoxlocks', data.doorids, false)
                else
                    TriggerServerEvent('qb-doorlock:server:updateState', data.doorids, false, false, false, true, false, false)
                end

                TriggerEvent("QBCore:Notify", "Power Cut Alarms Disabled!", "success")
            end
        else
            FinishPhoneAnimation()
            LocalPlayer.state.invBusy = false
            TriggerServerEvent('nyx-laundromat:setbusystate', id, false)
            TriggerEvent("QBCore:Notify", "Failed to cut the power!", "error")
        end
end

function CrackSafe()
    if Config.Safe.attempts > 0 then
        local numbers = {
            [1] = math.random(0, 99), [2] = math.random(0, 99),
            [3] = math.random(0, 99), [4] = math.random(0, 99),
        }

        TriggerServerEvent('nyx-laundromat:setbusystate', 'safe', true)
        local success = exports['nxo-MiniGames']:lockpicking(12,4,20000)
        if success then
            TriggerServerEvent('nyx-laundromat:openstate', 'safe', true)
            local powerState = Config.PowerLocations['power'].cut
            local safeState = Config.Safe.opened
            TriggerServerEvent('nyx-laundromat:givesafepayout', powerState, safeState)
            TriggerEvent("QBCore:Notify", "Safe Cracked!", "success")
        else
            TriggerServerEvent('nyx-laundromat:minusattempts')
            TriggerServerEvent('nyx-laundromat:setbusystate', 'safe', false)
            TriggerEvent("QBCore:Notify", "Failed to crack the safe!", "error")
        end
    else
        TriggerEvent("QBCore:Notify", "Safe jammed!", "error")
    end
end