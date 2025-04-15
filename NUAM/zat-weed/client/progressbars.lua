local QBCore = nil

Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports[Config.FrameworkPseudo]:GetCoreObject()
    end
end)
--------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------SMOKE JOINT EFFECT--------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
function SmokingProgressBar(stress)
    local ped = PlayerPedId()
    -- if Config.Framework == "qb" then 
    --     QBCore.Functions.Progressbar("smoking_joint", _U("li_join"), 1500, false, true, {
    --         disableMovement = false,
    --         disableCarMovement = false,
    --         disableMouse = false,
    --         disableCombat = true,
    --     }, {}, {}, {}, function() -- Done
    --         if Config.Inventory == "qb" or  Config.Inventory == "origen" or  Config.Inventory == "ps" then
    --             TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["zatjoint"], "remove")
    --         end
    --         TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_DRUG_DEALER', 0, true)
    --         TriggerServerEvent('hud:server:RelieveStress', (stress/Config.PurityDevider))   -- <-- CHANGE THIS EVENT IF YOU WANT OTHER EFFECTS
    --     end)
    -- elseif Config.Framework == "esx" then
    --     TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_DRUG_DEALER', 0, true)
    --     ESX.Progressbar(_U("li_join"), 1500,{
    --         FreezePlayer = true, 
    --         animation ={},
    --     onFinish = function()
    --         TriggerServerEvent('hud:server:RelieveStress', (stress/Config.PurityDevider))   -- <-- CHANGE THIS EVENT IF YOU WANT OTHER EFFECTS
    --     end, onCancel = function()
    --     end
    --     })
    -- end  
    ExecuteCommand('e weed')
    QBCore.Functions.Progressbar("smoking_joint", _U("li_join"), 3500, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        ExecuteCommand('e c')
        if Config.Inventory == "qb" or  Config.Inventory == "origen" or  Config.Inventory == "ps" then
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["zatjoint"], "remove")
        end
        local currentArmor = GetPedArmour(PlayerPedId())
        if currentArmor < 100 then
            if currentArmor + stress > 100 then
                SetPedArmour(PlayerPedId(), 100)
            else
                SetPedArmour(PlayerPedId(), currentArmor + stress)
            end
        end
    end, function()
        ExecuteCommand('e c')
    end)
end
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------


function PlantingSeedProgressBar(model, ClosestPlantToTakeGeneticsFrom, result, ClosestGarden, itemInfo)
    local ped = PlayerPedId()
    RequestAnimDict('amb@medic@standing@kneel@base')
    RequestAnimDict('anim@gangops@facility@servers@bodysearch@')
    while 
        not HasAnimDictLoaded('amb@medic@standing@kneel@base') or
        not HasAnimDictLoaded('anim@gangops@facility@servers@bodysearch@')
    do 
        Wait(0) 
    end
    TaskPlayAnim(ped, 'amb@medic@standing@kneel@base', 'base', 8.0, 8.0, -1, 1, 0, false, false, false)
    TaskPlayAnim(ped, 'anim@gangops@facility@servers@bodysearch@', 'player_search', 8.0, 8.0, -1, 48, 0, false, false, false)
    if Config.Framework == "qb" then
        QBCore.Functions.Progressbar('spawn_plant', _U("pl_seed"), 2000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() 
            if ClosestPlantToTakeGeneticsFrom ~= nil then
                TriggerServerEvent("zat-weed:server:CreateObject", vector3(result.position.x, result.position.y, result.position.z), vector3(result.rotation.x, result.rotation.y, result.rotation.z), model, NetworkGetNetworkIdFromEntity(ClosestGarden), NetworkGetNetworkIdFromEntity(ClosestPlantToTakeGeneticsFrom), itemInfo.genetics)  
            else
                TriggerServerEvent("zat-weed:server:CreateObject", vector3(result.position.x, result.position.y, result.position.z), vector3(result.rotation.x, result.rotation.y, result.rotation.z), model, NetworkGetNetworkIdFromEntity(ClosestGarden), nil, itemInfo.genetics)     
            end
            ClearPedTasks(ped)
            RemoveAnimDict('amb@medic@standing@kneel@base')
            RemoveAnimDict('anim@gangops@facility@servers@bodysearch@')
        end, function() 
            ZatWeedNotify(_U("cancele"), 'error', 2500)
            TriggerServerEvent("zat-weed:server:AddItem", "zatweedseed", itemInfo)
            ClearPedTasks(ped)
            RemoveAnimDict('amb@medic@standing@kneel@base')
            RemoveAnimDict('anim@gangops@facility@servers@bodysearch@')
        end)
    elseif Config.Framework == "esx" then
        ESX.Progressbar(_U("pl_seed"), 2000,{
            FreezePlayer = true, 
            animation ={},
            onFinish = function()
                if ClosestPlantToTakeGeneticsFrom ~= nil then
                    TriggerServerEvent("zat-weed:server:CreateObject", vector3(result.position.x, result.position.y, result.position.z), vector3(result.rotation.x, result.rotation.y, result.rotation.z), model, NetworkGetNetworkIdFromEntity(ClosestGarden), NetworkGetNetworkIdFromEntity(ClosestPlantToTakeGeneticsFrom), itemInfo.genetics)  
                else
                    TriggerServerEvent("zat-weed:server:CreateObject", vector3(result.position.x, result.position.y, result.position.z), vector3(result.rotation.x, result.rotation.y, result.rotation.z), model, NetworkGetNetworkIdFromEntity(ClosestGarden), nil, itemInfo.genetics)     
                end
                ClearPedTasks(ped)
                RemoveAnimDict('amb@medic@standing@kneel@base')
                RemoveAnimDict('anim@gangops@facility@servers@bodysearch@')
            end, onCancel = function()
                ZatWeedNotify(_U("cancele"), 'error', 2500)
                TriggerServerEvent("zat-weed:server:AddItem", "zatweedseed", itemInfo)
                ClearPedTasks(ped)
                RemoveAnimDict('amb@medic@standing@kneel@base')
                RemoveAnimDict('anim@gangops@facility@servers@bodysearch@')
            end
        })
    end
end

function HarvestingProgressBar(data, netId)
    local ped = PlayerPedId()
    TaskTurnPedToFaceEntity(ped, data.entity, 1.0)
    Wait(1500)

    RequestAnimDict('amb@medic@standing@kneel@base')
    RequestAnimDict('anim@gangops@facility@servers@bodysearch@')
    while 
        not HasAnimDictLoaded('amb@medic@standing@kneel@base') or
        not HasAnimDictLoaded('anim@gangops@facility@servers@bodysearch@')
    do 
        Wait(0) 
    end
    TaskPlayAnim(ped, 'amb@medic@standing@kneel@base', 'base', 8.0, 8.0, -1, 1, 0, false, false, false)
    TaskPlayAnim(ped, 'anim@gangops@facility@servers@bodysearch@', 'player_search', 8.0, 8.0, -1, 48, 0, false, false, false)

    if Config.Framework == "qb" then
        QBCore.Functions.Progressbar('harvest_plant', _U("pl_harv"), 8500, false, true, {
            disableMovement = true, 
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
            TriggerServerEvent('zat-weed:server:HarvestPlant', netId)
            ClearPedTasks(ped)
            RemoveAnimDict('amb@medic@standing@kneel@base')
            RemoveAnimDict('anim@gangops@facility@servers@bodysearch@')
        end, function()
            ZatWeedNotify(_U("cancele"), 'error', 2500)
            ClearPedTasks(ped)
            RemoveAnimDict('amb@medic@standing@kneel@base')
            RemoveAnimDict('anim@gangops@facility@servers@bodysearch@')
        end)
    elseif Config.Framework == "esx" then
        ESX.Progressbar(_U("pl_harv"), 8500,{
            FreezePlayer = true, 
            animation ={},
        onFinish = function()
            TriggerServerEvent('zat-weed:server:HarvestPlant', netId)
            ClearPedTasks(ped)
            RemoveAnimDict('amb@medic@standing@kneel@base')
            RemoveAnimDict('anim@gangops@facility@servers@bodysearch@')
        end, onCancel = function()
            ZatWeedNotify(_U("cancele"), 'error', 2500)
            ClearPedTasks(ped)
            RemoveAnimDict('amb@medic@standing@kneel@base')
            RemoveAnimDict('anim@gangops@facility@servers@bodysearch@')
        end
        })
    end
end

function CloningProgressBar(data, netId)
    local ped = PlayerPedId()
    TaskTurnPedToFaceEntity(ped, data.entity, 1.0)
    Wait(1500)

    RequestAnimDict('amb@medic@standing@kneel@base')
    RequestAnimDict('anim@gangops@facility@servers@bodysearch@')
    while 
        not HasAnimDictLoaded('amb@medic@standing@kneel@base') or
        not HasAnimDictLoaded('anim@gangops@facility@servers@bodysearch@')
    do 
        Wait(0) 
    end
    TaskPlayAnim(ped, 'amb@medic@standing@kneel@base', 'base', 8.0, 8.0, -1, 1, 0, false, false, false)
    TaskPlayAnim(ped, 'anim@gangops@facility@servers@bodysearch@', 'player_search', 8.0, 8.0, -1, 48, 0, false, false, false)
    if Config.Framework == "qb" then
        QBCore.Functions.Progressbar('cloning_plant', _U("pl_clon"), 8500, false, true, {
            disableMovement = true, 
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
            TriggerServerEvent("zat-weed:server:ClonePlant", netId)
            ClearPedTasks(ped)
            RemoveAnimDict('amb@medic@standing@kneel@base')
            RemoveAnimDict('anim@gangops@facility@servers@bodysearch@')
        end, function()
            ZatWeedNotify(_U("cancele"), 'error', 2500)
            ClearPedTasks(ped)
            RemoveAnimDict('amb@medic@standing@kneel@base')
            RemoveAnimDict('anim@gangops@facility@servers@bodysearch@')
        end)  
    elseif Config.Framework == "esx" then
        ESX.Progressbar(_U("pl_clon"), 8500,{
            FreezePlayer = true, 
            animation ={},
        onFinish = function()
            TriggerServerEvent("zat-weed:server:ClonePlant", netId)
            ClearPedTasks(ped)
            RemoveAnimDict('amb@medic@standing@kneel@base')
            RemoveAnimDict('anim@gangops@facility@servers@bodysearch@')
        end, onCancel = function()
            ZatWeedNotify(_U("cancele"), 'error', 2500)
            ClearPedTasks(ped)
            RemoveAnimDict('amb@medic@standing@kneel@base')
            RemoveAnimDict('anim@gangops@facility@servers@bodysearch@')
        end
        })
    end
end

function FillingWaterProgressBar(ped, created_object)
    if Config.Framework == "qb" then
        QBCore.Functions.Progressbar('filling_water', _U("fi_wate"), 6000, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'weapon@w_sp_jerrycan',
            anim = 'fire',
            flags = 1,
        }, {}, {}, function()
            TriggerServerEvent("zat-weed:server:GiveWaterBottleFull")
            ClearPedTasks(ped)
            DeleteEntity(created_object)

        end, function()
            ClearPedTasks(ped)
            DeleteEntity(created_object)
            ZatWeedNotify(_U("cancele"), 'error', 2500)
        end)
    elseif Config.Framework == "esx" then
        ESX.Progressbar(_U("fi_wate"), 6000,{
            FreezePlayer = true, 
            animation ={
                type = "anim",
                dict = "weapon@w_sp_jerrycan", 
                lib ="fire"
            },
        onFinish = function()
            TriggerServerEvent("zat-weed:server:GiveWaterBottleFull")
            ClearPedTasks(ped)
            DeleteEntity(created_object)
        end, onCancel = function()
            ClearPedTasks(ped)
            DeleteEntity(created_object)
            ZatWeedNotify(_U("cancele"), 'error', 2500)
        end
        })
    end
end

function RollingProgressBar(itemInfo)
    local ped = PlayerPedId()
    TaskStartScenarioInPlace(ped, 'PROP_HUMAN_PARKING_METER', 0, true)
    if Config.Framework == "qb" then
        QBCore.Functions.Progressbar('roll_plant', _U("rol_joi"), 6000, false, true, {
            disableMovement = true, 
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
            TriggerServerEvent('zat-weed:server:AddItem', "zatjoint", itemInfo, 5)
            ClearPedTasks(PlayerPedId())
        end, function()
            ZatWeedNotify(_U("cancele"), 'error', 2500)
            ClearPedTasks(PlayerPedId())
        end)
    elseif Config.Framework == "esx" then
        ESX.Progressbar(_U("rol_joi"), 6000,{
            FreezePlayer = true, 
            animation ={},
            onFinish = function()
                TriggerServerEvent('zat-weed:server:AddItem', "zatjoint", itemInfo, 5)
                ClearPedTasks(PlayerPedId())
        end, onCancel = function()
            ZatWeedNotify(_U("cancele"), 'error', 2500)
            ClearPedTasks(PlayerPedId())
        end
        })
    end
end

function BrickingProgressBar(itemInfo)
    local ped = PlayerPedId()
    TaskStartScenarioInPlace(ped, 'PROP_HUMAN_PARKING_METER', 0, true)
    if Config.Framework == "qb" then
        QBCore.Functions.Progressbar('brick_plant', _U("mak_bri"), 10000, false, true, {
            disableMovement = true, 
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
            TriggerServerEvent('zat-weed:server:AddItem', "zatpackedweed", itemInfo)
            ClearPedTasks(PlayerPedId())
        end, function()
            ZatWeedNotify(_U("cancele"), 'error', 2500)
            ClearPedTasks(PlayerPedId())
        end)
    elseif Config.Framework == "esx" then
        ESX.Progressbar(_U("mak_bri"), 10000,{
            FreezePlayer = true, 
            animation ={},
            onFinish = function()
                TriggerServerEvent('zat-weed:server:AddItem', "zatpackedweed", itemInfo)
                ClearPedTasks(PlayerPedId())
        end, onCancel = function()
            ZatWeedNotify(_U("cancele"), 'error', 2500)
            ClearPedTasks(PlayerPedId())
        end
        })
    end
end

function FertilizingProgressBar(entity)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local model = `prop_tool_rake`
    TaskTurnPedToFaceEntity(ped, entity, 1.0)
    Wait(1500)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end
    local created_object = CreateObject(model, coords.x, coords.y, coords.z, true, true, true)
    AttachEntityToEntity(created_object, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, -0.0300, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
    if Config.Framework == "qb" then
        QBCore.Functions.Progressbar('weedplanting_fertilize', _U("fer_pla"), 6000, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'anim@amb@drug_field_workers@rake@male_a@base',
            anim = 'base',
            flags = 1,
        }, {}, {}, function()
            TriggerServerEvent("zat-weed:server:GiveFertilizer", NetworkGetNetworkIdFromEntity(entity))
            ClearPedTasks(ped)
            DeleteEntity(created_object)

        end, function()
            ClearPedTasks(ped)
            DeleteEntity(created_object)
            ZatWeedNotify(_U("cancele"), 'error', 2500)
        end)
    elseif Config.Framework == "esx" then
        ESX.Progressbar(_U("fer_pla"), 6000,{
            FreezePlayer = true, 
            animation ={
                type = "anim",
                dict = "anim@amb@drug_field_workers@rake@male_a@base", 
                lib ="base"
            },
        onFinish = function()
            TriggerServerEvent("zat-weed:server:GiveFertilizer", NetworkGetNetworkIdFromEntity(entity))
            ClearPedTasks(ped)
            DeleteEntity(created_object)
        end, onCancel = function()
            ClearPedTasks(ped)
            DeleteEntity(created_object)
            ZatWeedNotify(_U("cancele"), 'error', 2500)
        end
        })
    end
end

function FillingWaterSetupProgressBar(entity)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local model = `prop_water_bottle`
    TaskTurnPedToFaceEntity(ped, entity, 1.0)
    Wait(1500)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end
    local created_object = CreateObject(model, coords.x, coords.y, coords.z, true, true, true)
    AttachEntityToEntity(created_object, ped, GetPedBoneIndex(ped, 28422), 0.4, 0.1, 0.0, 90.0, 180.0, 0.0, true, true, false, true, 1, true)
    if Config.Framework == "qb" then
        QBCore.Functions.Progressbar('weedplanting_water', _U("fil_wat"), 6000, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'weapon@w_sp_jerrycan',
            anim = 'fire',
            flags = 1,
        }, {}, {}, function()
            TriggerServerEvent("zat-weed:server:GiveWater", NetworkGetNetworkIdFromEntity(entity))
            ClearPedTasks(ped)
            DeleteEntity(created_object)
        end, function()
            ClearPedTasks(ped)
            DeleteEntity(created_object)
            ZatWeedNotify(_U("cancele"), 'error', 2500)
        end)
    elseif Config.Framework == "esx" then
        ESX.Progressbar(_U("fil_wat"), 6000,{
            FreezePlayer = true, 
            animation ={
                type = "anim",
                dict = "weapon@w_sp_jerrycan", 
                lib ="fire"
            },
        onFinish = function()
            TriggerServerEvent("zat-weed:server:GiveWater", NetworkGetNetworkIdFromEntity(entity))
            ClearPedTasks(ped)
            DeleteEntity(created_object)
        end, onCancel = function()
            ClearPedTasks(ped)
            DeleteEntity(created_object)
            ZatWeedNotify(_U("cancele"), 'error', 2500)
        end
        })
    end
end


