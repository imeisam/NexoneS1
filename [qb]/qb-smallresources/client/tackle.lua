local TackleCD = false
local QBCore = exports['qb-core']:GetCoreObject()

local function TackleAnim()
    local ped = PlayerPedId()
    if not Player(GetPlayerServerId(PlayerId())).state['isDead'] and not Player(GetPlayerServerId(PlayerId())).state['isCuffed'] and not IsPedRagdoll(ped) then
        if not HasAnimDictLoaded("swimming@first_person@diving") then
            RequestAnimDict("swimming@first_person@diving")
            while not HasAnimDictLoaded("swimming@first_person@diving") do
                Wait(10)
            end
        end
        if IsEntityPlayingAnim(ped, "swimming@first_person@diving", "dive_run_fwd_-45_loop", 3) then
            ClearPedTasksImmediately(ped)
        else
            TaskPlayAnim(ped, "swimming@first_person@diving", "dive_run_fwd_-45_loop" ,3.0, 3.0, -1, 49, 0, false, false, false)
            Wait(250)
            ClearPedTasksImmediately(ped)
            SetPedToRagdoll(ped, 150, 150, 0, false, false, false)
        end
    end
end

AddEventHandler('onKeyDown', function(key)
    if key == 'lmenu' then
        local ped = PlayerPedId()
        if IsControlPressed(0, 21) and not IsPedInAnyVehicle(ped, false) and not TackleCD then
            TackleCD = true
            local closestPlayer, distance = QBCore.Functions.GetClosestPlayer()
            if distance ~= -1 and distance < 2 and GetEntitySpeed(ped) > 2.5 then
                TriggerServerEvent("tackle:server:TacklePlayer", GetPlayerServerId(closestPlayer))
            end
            TackleAnim()
            SetTimeout(10000, function()
                TackleCD = false
            end)
        end
    end
end)

RegisterNetEvent('tackle:client:GetTackled', function()
    if math.random(1, 100) >= 95 then return end
    if Player(GetPlayerServerId(PlayerId())).state['isDead'] then return end
    SetPedToRagdoll(PlayerPedId(), math.random(1000, 6000), math.random(1000, 6000), 0, false, false, false)
end)