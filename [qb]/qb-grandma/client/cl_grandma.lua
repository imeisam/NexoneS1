local QBCore = exports['qb-core']:GetCoreObject()
local grandma = nil

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

function GrandmaSit()
    loadAnimDict("timetable@reunited@ig_10")        
    TaskPlayAnim(grandma, "timetable@reunited@ig_10", "base_amanda", 8.0, 1.0, -1, 01, 0, 0, 0, 0)
end

function SpawnGrandma()
    RequestModel(GetHashKey('ig_mrs_thornhill'))
    while not HasModelLoaded(GetHashKey('ig_mrs_thornhill')) do
        Wait(0)
    end
    grandma = CreatePed(0, GetHashKey('ig_mrs_thornhill') , Config.Coords.x,  Config.Coords.y,  Config.Coords.z,  Config.Coords.w, false, false)
    SetEntityAsMissionEntity(grandma)
    SetPedFleeAttributes(grandma, 0, 0)
    SetBlockingOfNonTemporaryEvents(grandma, true)
    SetEntityInvincible(grandma, true)
    FreezeEntityPosition(grandma, true)
    GrandmaSit()  
    exports['qb-target']:AddTargetEntity(grandma, {
        options = {
            { 
                type = "client",
                event = "qb-grandma:client:checks",
                icon = "fa-solid fa-house-medical",
                label = "Get Treated",
            },
        },
        distance = 3.0
    })
end

function DeleteGrandma()
    if grandma and DoesEntityExist(grandma) then
        DeleteEntity(grandma)
        grandma = nil
    end
end

RegisterNetEvent('qb-grandma:client:checks', function()
    local ped = PlayerPedId()
    local player = PlayerId()
    if Config.CheckDead then
        QBCore.Functions.GetPlayerData(function(PlayerData)
            if PlayerData.metadata["inlaststand"] or PlayerData.metadata["isdead"] then
                TriggerServerEvent('qb-grandma:server:checkfunds')
            else
                QBCore.Functions.Notify("You are not downed or dead.", "error")
            end
        end)
    else
        TriggerServerEvent('qb-grandma:server:checkfunds')
    end
end)

RegisterNetEvent('qb-grandma:reviveplayer', function(source)
    SetEntityCoords(PlayerPedId(), Config.Coords.x, Config.Coords.y, Config.Coords.z)
    TaskStartScenarioInPlace(grandma, "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 0, true)
    QBCore.Functions.Progressbar("grandma", "Grandma is healing your wounds..", 30000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
     }, {}, {}, {}, function()
        QBCore.Functions.TriggerCallback('qb-grandma:attemptGrandmaPayment', function(hasPaid)
            if hasPaid then
                QBCore.Functions.Notify("You feel much better now.", "success")
                TriggerEvent('hospital:client:Revive')
                ClearPedTasks(PlayerPedId())
                ClearPedTasksImmediately(grandma)
                GrandmaSit()
            else
                QBCore.Functions.Notify("You're cooked. give she cash.", "error")
                ClearPedTasks(PlayerPedId())
                ClearPedTasksImmediately(grandma)
                GrandmaSit()
            end
        end)
     end, function()
        ClearPedTasks(PlayerPedId())
        ClearPedTasksImmediately(grandma)
        GrandmaSit()
    end)
end)

AddEventHandler('onResourceStop', function(resourceName) 
	if GetCurrentResourceName() == resourceName then
        DeleteGrandma()
	end
end)

CreateThread(function()
    SpawnGrandma()
end)