-- Variables
local FingerPrintSessionId = nil
local inBoat = false

local function loadAnimDict(dict) -- interactions, job,
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end

local function GetClosestPlayer() -- interactions, job, tracker
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())

    for i = 1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = #(pos - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end

local function openFingerprintUI()
    SendNUIMessage({
        type = "fingerprintOpen"
    })
    SetNuiFocus(true, true)
end

function closeMenuFull()
    exports['qb-menu']:closeMenu()
end

--NUI Callbacks
RegisterNUICallback('closeFingerprint', function(_, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

--Events
RegisterNetEvent('police:client:showFingerprint', function(playerId)
    openFingerprintUI()
    FingerPrintSessionId = playerId
end)

RegisterNetEvent('police:client:checkradarplate', function(plate)
    TriggerServerEvent('police:server:checkradarplate',plate)
end)

RegisterNetEvent('police:client:showFingerprintId', function(fid)
    SendNUIMessage({
        type = "updateFingerprintId",
        fingerprintId = fid
    })
    PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
end)

RegisterNUICallback('doFingerScan', function(_, cb)
    TriggerServerEvent('police:server:showFingerprintId', FingerPrintSessionId)
    cb("ok")
end)

RegisterNetEvent('police:client:EvidenceStash', function(data)
    if data and data.location then
        local keyboard = exports['qb-input']:ShowInput({
            header = "Incident ID",
            submitText = "Confirm",
            inputs = {
                {
                    type = 'text',
                    isRequired = true,
                    text = "Enter Incident ID",
                    name = 'input',
                }
            }
        })
        if keyboard and keyboard.input then
            TriggerServerEvent("inventory:server:OpenInventory", "stash", 'PoliceEvidence_'..keyboard.input..'_'..data.location, {
                maxweight = 300000,
                slots = 100,
            })
        end
    end
end)

RegisterNetEvent('police:target:Stash', function(data)
    if data and data.location then
        local inv = {maxweight = 5000000, slots = 300}
        if data.shared then
            TriggerServerEvent("inventory:server:OpenInventory", "stash", 'policestash_'..data.location, inv)
        else
            local keyboard = exports['qb-input']:ShowInput({
                header = "Stash ID",
                submitText = "Confirm",
                inputs = {
                    {
                        type = 'text',
                        isRequired = true,
                        text = "Enter Stash ID",
                        name = 'input',
                    }
                }
            })
            if keyboard and keyboard.input then
                TriggerServerEvent("inventory:server:OpenInventory", "stash", 'policestash_p_'..keyboard.input..data.location, inv)
            end
        end
    end
end)

-- Toggle Duty in an event.
RegisterNetEvent('qb-policejob:ToggleDuty', function()
    TriggerServerEvent("QBCore:ToggleDuty")
end)

RegisterNetEvent('qb-police:client:scanFingerPrint', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("police:server:showFingerprint", playerId)
    else
        TriggerEvent('police:client:showFingerprint')
    end
end)

RegisterNetEvent('qb-police:client:openArmoury', function()
    if onDuty then
        TriggerEvent("nxo-shop:client:openshopname","policearmory")
    else
        QBCore.Functions.Notify('You Are OffDuty', 'error')
    end
end)

RegisterNetEvent('qb-police:client:spawnBoat', function()
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        local veh = GetVehiclePedIsIn(PlayerPedId())
        if GetEntityModel(veh) == GetHashKey(Config.PoliceBoat) then
            QBCore.Functions.Progressbar("del_boat", "Deleting Boat ...", 5000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function()
                QBCore.Functions.DeleteVehicle(veh)
            end, function()
                QBCore.Functions.Notify("Canceled..", "error")
            end)
        end
    else
        local coords = GetEntityCoords(PlayerPedId())
        local heading = GetEntityHeading(PlayerPedId())
        QBCore.Functions.Progressbar("spawn_boat", "Spawning Boat ...", math.random(6000, 10000), false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
            QBCore.Functions.SpawnVehicle(Config.PoliceBoat, function(veh)
                SetEntityHeading(veh, heading)
                exports['qb-fuel']:SetFuel(veh, 100.0)
                TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', QBCore.Functions.GetPlate(veh))
                SetVehicleEngineOn(veh, true, true)
            end, coords, true)
        end, function()
            QBCore.Functions.Notify("Canceled..", "error")
        end)
    end
end)

-- Target

AddEventHandler("police:target:openStash", function(data)
    if data and data.location then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "policestash_"..QBCore.Functions.GetPlayerData().citizenid..data.location, {maxweight = 100000, slots = 50})
    end
end)

AddEventHandler('police:target:checkStash', function(data)
    if data and data.location then
        local keyboard = exports['qb-input']:ShowInput({
            header = "Citizen ID",
            submitText = "Confirm",
            inputs = {
                {
                    type = 'text',
                    isRequired = true,
                    text = "Enter Citizen ID",
                    name = 'input',
                }
            }
        })
        if keyboard and keyboard.input then
            TriggerServerEvent("inventory:server:OpenInventory", "stash", 'policestash_'..keyboard.input..data.location, {maxweight = 100000, slots = 50})
        end
    end
end)

CreateThread(function()
    local model = GetHashKey('s_m_y_cop_01')
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    local function SakhtAbbas(coords)
        local ped = CreatePed(4, model, coords.x, coords.y, coords.z-1, coords.w, false, false)
        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        return ped
    end

    exports['qb-interact']:AddInteraction({
        coords =  vector3(-1094.98, -837.54, 3.68),
        distance = 3.0,
        interactDst = 1.5, 
        id = "pd-armory1",
        name = "pd-armory1",
        groups = {
            ['police'] = 0, 
        },
        options = {
            {
                label = "Armory",
                event =  "qb-police:client:openArmoury",
                args = {}
            },
            {
                label = "Counter",
                action = function(entity, coords, args)

                    TriggerServerEvent("inventory:server:OpenInventory", "stash", "armorystash1", {maxweight = 100000, slots =10})
                end,
                args = {}
            },  
        }
    })
    exports['qb-interact']:AddInteraction({
        coords =  vector3(609.20538330078, 18.900959014893, 82.839309692383),
        distance = 3.0,
        interactDst = 1.5, 
        id = "pd-armory2",
        name = "pd-armory2",
        groups = {
            ['police'] = 0, 
        },
        options = {
            {
                label = "Armory",
                event =  "qb-police:client:openArmoury",
                args = {}
            },
           
        }
    })

   
    for k,v in pairs(Config.Locations["evidence"]) do
        SakhtAbbas(v)
        exports['qb-target']:AddBoxZone("PoliceEVD_"..k, vector3(v.x,v.y,v.z), 1.5, 1.5, {
            name = "PoliceEVD_"..k,
            heading = 0,
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        }, {
            options = {
                {
                    type = "client",
                    event = "police:client:EvidenceStash",
                    icon = "fas fa-box-open",
                    label = "Evidence Locker",
                    job = "police",
                    location = k
                },
            },
            distance = 1.5
        })
    end

    for k,v in pairs(Config.Locations["duty"]) do
        exports['qb-interact']:AddInteraction({
            coords =v,
            distance = 3.0,
            interactDst = 1.5, 
            id = "PoliceDuty"..k,
            name = "PoliceDuty"..k,
            groups = {
                ['police'] = 0, 
            },
            options = {
                {
                    label = "Sign In",
                    event = "qb-policejob:ToggleDuty",
                    args = {}
                },
               
            }
        })
    end
end)

CreateThread(function()
   
    for k,v in pairs(Config.Locations["stash"]) do
        exports['qb-target']:AddBoxZone("PoliceStash_"..k, v.coords, 1.5, 1.5, {
            name = "PoliceStash_"..k,
            heading = 0,
            debugPoly = false,
            minZ = v.coords.z - 1,
            maxZ = v.coords.z + 1,
        }, {
            options = {
                {
                    type = "client",
                    event = "police:target:Stash",
                    icon = "fas fa-box-open",
                    label = "Stash",
                    job = "police",
                    location = k,
                    shared = v.shared,
                    canInteract = function()
                        if v.division then
                            if  QBCore.Functions.GetPlayerData().job.isboss or QBCore.Functions.HasDivision('hc') or QBCore.Functions.HasDivision(v.division) then
                                return true
                            else
                                return false
                            end
                        else
                            return true
                        end
                    end
                },
            },
            distance = 1.5
        })
    end
    armorystash={vector3(462.41357421875, -995.31506347656, 30.689266204834)}
    for k,v in pairs(armorystash) do
        exports['qb-interact']:AddInteraction({
            coords =v,
            distance = 1.5,
            interactDst = 1.0, 
            id ="armorystash"..k,
            name = "armorystash"..k, 
            groups = {
                ['police'] = 0, 
            },
            options = {
                {
                    label = "Counter",
                    action = function(entity, coords, args)
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "armorystash"..k, {maxweight = 100000, slots =10})
                    end,
                    args = {}
                },
            }
        })
    end
   
    armorysafestash={vector3(-1093.4278564453, -834.791015625, 3.6824142932892),vector3(462.45220947266, -1000.903503418, 30.689287185669)}
    for k,v in pairs(armorysafestash) do
        exports['qb-interact']:AddInteraction({
            coords =v,
            distance = 1.0,
            interactDst = 1.0, 
            id ="armorysafestash"..k,
            name = "armorysafestash"..k, 
            groups = {
                ['police'] = 0, 
            },
            options = {
                {
                    label = "Armory Safe Stash",
                    action = function(entity, coords, args)
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "armorysafestash"..k, {maxweight = 500000, slots =25})
                    end,
                    args = {},
                    canInteract = function() return QBCore.Functions.HasDivision('fa') end
                },
            }
        })
    end

    for k,v in pairs(Config.Locations["trashevidence"]) do
        for i,j in ipairs(v) do
            exports['qb-interact']:AddInteraction({
                coords =j,
                distance = 2.0,
                interactDst = 1.5, 
                id ="trashevidence"..k.."-"..i,
                name = "trashevidence"..k.."-"..i, 
                groups = {
                    ['police'] = 0, 
                },
                options = {
                    {
                        label = "Trash Evidence",
                        action = function(entity, coords, args)
                            TriggerServerEvent("inventory:server:OpenInventory", "stash", "trashevidence"..k.."_"..i, {maxweight = 100000, slots =10})
                        end,
                        args = {}
                    },
                }
            })
        end
    end

    for k,v in pairs(Config.Locations["clothes"]) do
        for i,j in ipairs(v) do
            exports['qb-interact']:AddInteraction({
                coords =j,
                distance = 2.0,
                interactDst = 2.0, 
                id ="PoliceClothes_"..k..i,
                name = "PoliceClothes_"..k..i, 
                groups = {
                    ['police'] = 0, 
                },
                options = {
                    {
                        label = "Personal Stash",
                        action = function(entity, coords, args)
                            TriggerServerEvent("inventory:server:OpenInventory", "stash", "policepersonalstash_"..k.." "..QBCore.Functions.GetPlayerData().citizenid, {maxweight = 100000, slots =30})
                        end,
                        args = {}
                    },
                    {
                        label = "Outfit",
                        event = "lvs_clothing:client:openOutfit",
                        args = {}
                    },
                      {
                    label = "Police Outfit",
                    event = "qb-smallresources:client:joboutfits",
                    args = {}
                     },
                    {
                        label = "Change Clothes",
                        event = "lvs_clothing:client:OpenClothingShop",
                        args = {}
                    },
                }
            })

            -- exports['qb-target']:AddBoxZone("PoliceClothes_"..k..i, j, 2.5, 2.5, {
            --     name = "PoliceClothes_"..k..i,
            --     heading = 0,
            --     debugPoly = false,
            --     minZ = j.z - 1,
            --     maxZ = j.z + 1,
            -- }, {
            --     options = {
            --         {
            --             type = "client",
            --             event = "qb-clothing:client:openJob",
            --             icon = "fas fa-tshirt",
            --             label = "Change Clothes",
            --             job = "police",
            --         },
            --         {
            --             type = "client",
            --             event = "police:target:openStash",
            --             icon = "fas fa-box-open",
            --             label = "Personal Locker",
            --             job = "police",
            --             location = k,
            --         },
            --         {
            --             type = "client",
            --             event = "police:target:checkStash",
            --             icon = "fas fa-box-open",
            --             label = "Check Stash",
            --             job = "police",
            --             location = k,
            --             canInteract = function() return QBCore.Functions.GetPlayerData().job.isboss or QBCore.Functions.HasDivision('hc') or QBCore.Functions.HasDivision('fa') end,
            --         },
            --     },
            --     distance = 2.5
            -- })
        end
    end
    for k,v in ipairs(Config.Locations["fingerprint"]) do
        exports['qb-target']:AddBoxZone("PoliceFinger_"..k, v, 1.0, 1.0, {
            name = "PoliceFinger_"..k,
            heading = 0,
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        }, {
            options = {
                {
                    type = "client",
                    event = "qb-police:client:scanFingerPrint",
                    icon = "fas fa-door-open",
                    label = "Finger Print",
                    job = "police",
                },
            },
            distance = 1.5
        })
    end
    for k,v in ipairs(Config.Locations["badge"]) do
        exports['qb-target']:AddBoxZone("PoliceBadge_"..k, v, 1.5, 1.5, {
            name = "PoliceBadge_"..k,
            heading = 0,
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        }, {
            options = {
                {
                    type = "client",
                    event = "qb-policebadge:client:badge",
                    icon = "fa fa-clipboard",
                    label = "Take Badge",
                    job = "police",
                },
            },
            distance = 1.5
        })
    end
    for k, v in pairs(Config.Locations["fingerprint"]) do
        exports['qb-target']:AddBoxZone("PoliceDNA_"..k, vector3(v.x, v.y, v.z), 2, 1, {
            name = "PoliceDNA_"..k,
            heading = 0,
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        }, {
            options = {
                {
                    type = "client",
                    event = "police:target:getDNA",
                    icon = "fas fa-door-open",
                    label = "Get DNA Test",
                    job = "police",
                },
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    local boatZones = {}
    for k, v in pairs(Config.Locations["boat"]) do
        boatZones[#boatZones+1] = BoxZone:Create(
            vector3(vector3(v.x, v.y, v.z)), 30, 30, {
            name="boatCombo"..k,
            debugPoly = false,
            minZ = v.z - 10,
            maxZ = v.z + 10,
        })
    end
    local boatCombo = ComboZone:Create(boatZones, {name = "boatCombo", debugPoly = false})
    boatCombo:onPlayerInOut(function(isPointInside)
        if isPointInside then
            inBoat = true
            if LocalPlayer.state.isLoggedIn and (PlayerJob.name == "police" or PlayerJob.name == "justice" or PlayerJob.name == "ambulance") then
                if IsPedInAnyVehicle(PlayerPedId(), false) then
                    exports['qb-core']:DrawText(Lang:t('info.store_boat'), 'left','E')
                else
                    exports['qb-core']:DrawText(Lang:t('info.take_boat'), 'left','E')
                end
                CreateThread(function()
                    while inBoat do
                        Wait(10)
                        if IsControlJustReleased(0, 38) then
                            inBoat = false
                            exports['qb-core']:HideText()
                            TriggerEvent("qb-police:client:spawnBoat")
                        end
                    end
                end)
            end
        else
            inBoat = false
            exports['qb-core']:HideText()
        end
    end)
end)

RegisterNetEvent('inventory:client:closedinv', function()
   TriggerEvent("hud:client:showcompass",QBCore.Functions.HasItem('compass'))
end)