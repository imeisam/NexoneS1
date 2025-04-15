-- Variables
local CuffCooldown = false
local CuffAmount = 0
local CuffBuff = false
local isEscorting = false
local SearchRadial = nil
local EscortRadial = nil
local grabRadial = nil
local MaskRadial = nil
local InVehRadial = nil
local OutVehRadial = nil

-- Functions

exports('IsHandcuffed', function()
    return isHandcuffed
end)

function DoCuffWhile(type)
    while isHandcuffed do
        Wait(1)
        -- DisableControlAction(0, 21, true) -- Attack
        DisableControlAction(0, 24, true) -- Attack
        DisableControlAction(0, 257, true) -- Attack 2
        DisableControlAction(0, 25, true) -- Aim
        DisableControlAction(0, 263, true) -- Melee Attack 1
        DisableControlAction(0, 45, true) -- Reload
        DisableControlAction(0, 22, true) -- Jump
        DisableControlAction(0, 44, true) -- Cover
        DisableControlAction(0, 37, true) -- Inventory
        DisableControlAction(0, 23, true) -- Also 'enter'?
        DisableControlAction(0, 73, true) -- Disable clearing animation
        DisableControlAction(2, 36, true) -- Disable going stealth
        DisableControlAction(0, 264, true) -- Disable melee
        DisableControlAction(0, 257, true) -- Disable melee
        DisableControlAction(0, 140, true) -- Disable melee
        DisableControlAction(0, 141, true) -- Disable melee
        DisableControlAction(0, 142, true) -- Disable melee
        DisableControlAction(0, 143, true) -- Disable melee
        DisableControlAction(0, 75, true)  -- Disable exit vehicle
        DisableControlAction(27, 75, true) -- Disable exit vehicle
        if type==0 then
            if not IsEntityPlayingAnim(GetPlayerPed(-1), "anim@move_m@prisoner_cuffed", "idle", 49) then
                TaskPlayAnim(GetPlayerPed(-1), 'anim@move_m@prisoner_cuffed', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
            end
        else
            if not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 1) then
                TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
            end
        end
      
    end
end

local function loadAnimDict(dict) -- interactions, job,
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

local function GetCuffedAnimation(idPlayer)
    local ped = PlayerPedId()
    local cuffer = GetPlayerPed(GetPlayerFromServerId(idPlayer))
    local heading = GetEntityHeading(cuffer)
    CreateThread(function()
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "Cuff", 0.2)
        loadAnimDict("mp_arrest_paired")
        SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(cuffer, 0.0, 0.45, 0.0))
        Wait(100)
        SetEntityHeading(ped, heading)
        TaskPlayAnim(ped, "mp_arrest_paired", "crook_p2_back_right", 3.0, 3.0, -1, 32, 0, 0, 0, 0 ,true, true, true)
        Citizen.Wait(3760)
        ClearPedTasks(ped)
    end)
end
local cuffsprop
local function GetCuffed(type)
    if cuffsprop then 
        DeleteEntity(cuffsprop)
        cuffsprop = nil
     end
     
     cuffsprop = CreateObject(GetHashKey("ba_prop_battle_cuffs"), GetEntityCoords(PlayerPedId()), true, true, true);
     local networkId = ObjToNet(cuffsprop)
     SetNetworkIdExistsOnAllMachines(networkId, true)
     SetNetworkIdCanMigrate(networkId, false)
     NetworkSetNetworkIdDynamic(networkId, true)
    if type==0 then
        loadAnimDict('anim@move_m@prisoner_cuffed')
        TaskPlayAnim(GetPlayerPed(-1), 'anim@move_m@prisoner_cuffed', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
        AttachEntityToEntity(cuffsprop, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 60309), -0.058, 0.005, 0.090, 290.0, 95.0, 120.0, true, false, false, false, 0, true);

    else
       
        loadAnimDict('mp_arresting')
        TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
        Wait(500)
        AttachEntityToEntity(cuffsprop, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 60309), -0.055, 0.06, 0.04, 265.0, 155.0, 80.0, true, false, false, false, 0, true);

    end
  
    isHandcuffed = true
    Player(GetPlayerServerId(PlayerId())).state:set("isCuffed", true, true)
    TriggerEvent('inventory:client:Close')
    DoCuffWhile(type)
end

local function CuffMe(playerId, data,type)
    TriggerServerEvent("police:server:SetHandcuff", playerId, data)
    if GetSelectedPedWeapon(PlayerPedId()) ~= `WEAPON_UNARMED` then
        TriggerEvent('weapons:client:SetCurrentWeapon', nil)
    end
    GetCuffed(type)
end

-- Events

RegisterNetEvent('ring:client:cuff', function(state)
    CuffBuff = state
end)

RegisterNetEvent('qb-radialmenu:client:onRadialmenuOpen', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    local nearVeh = false
    if not IsPedInAnyVehicle(PlayerPedId(), false) and player ~= -1 and distance < 2.5 then
        if not SearchRadial then
            SearchRadial = exports['qb-radialmenu']:AddOption({
                id = 'stealplayer',
                title = 'Rob',
                icon = '#search',
                functiontype = 'client',
                functionName = 'police:client:SearchPlayer',
                shouldClose = true
            }, SearchRadial)
        end
        if not EscortRadial then
            EscortRadial = exports['qb-radialmenu']:AddOption({
                id = 'escort',
                title = 'Escort',
                icon = '#escort',
                functiontype = 'client',
                functionName = 'police:client:EscortPlayer',
                shouldClose = true
            }, EscortRadial)
        end
        local player, distance = QBCore.Functions.GetClosestPlayer()
        -- if not grabRadial and not Player(GetPlayerServerId(player)).state['isDead'] then
        --     grabRadial = exports['qb-radialmenu']:AddOption({
        --         id = 'grab',
        --         title = 'Grab',
        --         icon = '#escort',
        --         functiontype = 'client',
        --         functionName = 'grab:client:grab',
        --         shouldClose = true
        --     }, grabRadial)
        -- end
        if not MaskRadial then
            MaskRadial = exports['qb-radialmenu']:AddOption({
                id = 'mask',
                title = 'Remove Mask',
                icon = '#mask',
                functiontype = 'client',
                functionName = 'police:client:RemoveMask',
                shouldClose = true
            }, MaskRadial)
        end
        local vehicle, dist =  QBCore.Functions.GetClosestVehicle()
        if DoesEntityExist(vehicle) and dist <= 3.5 then
            nearVeh = true
            if not InVehRadial then
                InVehRadial = exports['qb-radialmenu']:AddOption({
                    id = 'playerinvehicle',
                    title = 'Put In Vehicle',
                    icon = '#inveh',
                    functiontype = 'client',
                    functionName = 'police:client:PutPlayerInVehicle',
                    shouldClose = true
                }, InVehRadial)
            end
            if not OutVehRadial then
                OutVehRadial = exports['qb-radialmenu']:AddOption({
                    id = 'playeroutvehicle',
                    title = 'Take Out Vehicle',
                    icon = '#outveh',
                    functiontype = 'client',
                    functionName = 'police:client:SetPlayerOutVehicle',
                    shouldClose = true
                }, OutVehRadial)
            end
        end
    else
        if SearchRadial then
            exports['qb-radialmenu']:RemoveOption(SearchRadial)
            SearchRadial = nil
        end
        if EscortRadial then
            exports['qb-radialmenu']:RemoveOption(EscortRadial)
            EscortRadial = nil
        end
        if grabRadial then
            exports['qb-radialmenu']:RemoveOption(grabRadial)
            grabRadial = nil
        end
        if MaskRadial then
            exports['qb-radialmenu']:RemoveOption(MaskRadial)
            MaskRadial = nil
        end
    end
    if not nearVeh then
        if InVehRadial then
            exports['qb-radialmenu']:RemoveOption(InVehRadial)
            InVehRadial = nil
        end
        if OutVehRadial then
            exports['qb-radialmenu']:RemoveOption(OutVehRadial)
            OutVehRadial = nil
        end
    end
end)

RegisterNetEvent('police:client:doCuffAnim', function(state)
    local ped = PlayerPedId()
    if state then
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "Cuff", 0.2)
            loadAnimDict("mp_arrest_paired")
            TaskPlayAnim(ped, "mp_arrest_paired", "cop_p2_back_right", 3.0, 3.0, -1, 48, 0, 0, 0, 0)
            Wait(3500)
            TaskPlayAnim(ped, "mp_arrest_paired", "exit", 3.0, 3.0, -1, 48, 0, 0, 0, 0)
    else
       
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "Uncuff", 0.2)
        loadAnimDict('mp_arresting')
        TaskPlayAnim(ped, "mp_arresting", "a_uncuff", 3.0, 3.0, -1, 48, 0, 0, 0, 0)
        Wait(1500)
        TaskPlayAnim(ped, "mp_arresting", "exit", 3.0, 3.0, -1, 48, 0, 0, 0, 0)
    end
end)

RegisterNetEvent('police:client:PutInVehicle', function()
    local ped = PlayerPedId()
    if isHandcuffed or isEscorted then
        local vehicle, dist =  QBCore.Functions.GetClosestVehicle()
        if DoesEntityExist(vehicle) and dist <= 3.5 then
            local maxseat = GetVehicleMaxNumberOfPassengers(vehicle)
			for i = maxseat - 1, 0, -1 do
                if IsVehicleSeatFree(vehicle, i) then
                    isEscorted = false
                    TriggerEvent('hospital:client:isEscorted', isEscorted)
                    ClearPedTasks(ped)
                    DetachEntity(ped, true, false)
                    Wait(100)
                    SetPedIntoVehicle(ped, vehicle, i)
                    return
                end
            end
		end
    end
end)

RegisterNetEvent('police:client:SearchPlayer', function()
    if IsPedInAnyVehicle(PlayerPedId(), false) then return end
    local player, distance = QBCore.Functions.GetClosestPlayer()
    local playerPed = GetPlayerPed(player)
    if player ~= -1 and distance < 2.5 and not IsPedInAnyVehicle(playerPed) then
        local playerId = GetPlayerServerId(player)
        if PlayerJob and (PlayerJob.name == 'police' or PlayerJob.name == 'justice') and onDuty then
            TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", playerId)
            TriggerServerEvent("police:server:SearchPlayer", playerId)
        else
            if IsEntityPlayingAnim(playerPed, "missminuteman_1ig_2", "handsup_base", 3) or Player(playerId).state['isDead'] or Player(playerId).state['isCuffed'] then
                QBCore.Functions.Progressbar("robbing_player", 'Rob..', math.random(2000, 3000), false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "random@shop_robbery",
                    anim = "robbery_action_b",
                    flags = 16,
                }, {}, {}, function() -- Done
                    local plyCoords = GetEntityCoords(playerPed)
                    local pos = GetEntityCoords(PlayerPedId())
                    if #(pos - plyCoords) < 2.5 then
                        if IsEntityPlayingAnim(playerPed, "missminuteman_1ig_2", "handsup_base", 3) or Player(playerId).state['isDead'] or Player(playerId).state['isCuffed'] then
                            TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", playerId)
                            TriggerServerEvent("police:server:SearchPlayer", playerId)
                        else
                            QBCore.Functions.Notify(Lang:t("error.not_cuffed_dead"), "error")
                        end
                    else
                        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
                    end
                    StopAnimTask(PlayerPedId(), "random@shop_robbery", "robbery_action_b", 1.0)
                end, function() -- Cancel
                    StopAnimTask(PlayerPedId(), "random@shop_robbery", "robbery_action_b", 1.0)
                end)
            else
                QBCore.Functions.Notify(Lang:t("error.not_cuffed_dead"), "error")
            end
        end
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
    end
end)

RegisterNetEvent('police:client:RemoveMask', function()
    if IsPedInAnyVehicle(PlayerPedId(), false) then return end
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerPed = GetPlayerPed(player)
        local playerId = GetPlayerServerId(player)
        if IsEntityPlayingAnim(playerPed, "missminuteman_1ig_2", "handsup_base", 3) or Player(playerId).state['isDead'] or Player(playerId).state['isCuffed'] then
            TriggerServerEvent("police:server:RemoveMask", playerId)
        else
            QBCore.Functions.Notify(Lang:t("error.not_cuffed_dead"), "error")
        end
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
    end
end)

RegisterNetEvent('police:client:PutPlayerInVehicle', function()
    if IsPedInAnyVehicle(PlayerPedId(), false) then return end
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        local playerPed = GetPlayerPed(player)
        if not isHandcuffed and not isEscorted then
            if Player(playerId).state['isDead'] or Player(playerId).state['isCuffed'] then
                local vehicle, dist =  QBCore.Functions.GetClosestVehicle()
                if DoesEntityExist(vehicle) and dist <= 3.5 and GetVehicleDoorLockStatus(vehicle)==2 then
                    QBCore.Functions.Notify("Vehivle is Locked", "error")
                    return
                end
                QBCore.Functions.Progressbar("putin", "Put In ..", math.random(4000, 6000), false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function()
                    if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(playerPed)) > 5 then QBCore.Functions.Notify("Far..", "error") return end
                    TriggerServerEvent("police:server:PutPlayerInVehicle", playerId)
                end, function() -- Cancel
                    QBCore.Functions.Notify("Canceled..", "error")
                end)
            end
        end
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
    end
end)

RegisterNetEvent('police:client:SetPlayerOutVehicle', function()
    if IsPedInAnyVehicle(PlayerPedId(), false) then return end
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 3.0 then
        local playerId = GetPlayerServerId(player)
        local playerPed = GetPlayerPed(player)
        if not isHandcuffed and not isEscorted and IsPedInAnyVehicle(playerPed) then
            if Player(playerId).state['isDead'] or Player(playerId).state['isCuffed'] then
                local vehicle, dist =  QBCore.Functions.GetClosestVehicle()
                if DoesEntityExist(vehicle) and dist <= 3.5 and GetVehicleDoorLockStatus(vehicle)==2 then
                    QBCore.Functions.Notify("Vehivle is Locked", "error")
                    return
                end
                QBCore.Functions.Progressbar("putout", "Put Out ..", math.random(4000, 6000), false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function()
                    if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(playerPed)) > 5 then QBCore.Functions.Notify("Far..", "error") return end
                    TriggerServerEvent("police:server:EscortPlayer", playerId)
                end, function() -- Cancel
                    QBCore.Functions.Notify("Canceled..", "error")
                end)
                TriggerServerEvent("police:server:SetPlayerOutVehicle", playerId)
            end
        end
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
    end
end)

RegisterNetEvent('police:client:EscortPlayer', function()
    if IsPedInAnyVehicle(PlayerPedId(), false) then return end
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        local playerPed = GetPlayerPed(player)
        if not isHandcuffed and not isEscorted and not IsPedInAnyVehicle(playerPed) then
            TriggerServerEvent("police:server:EscortPlayer", playerId)
        end
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
    end
end)

RegisterNetEvent('police:client:CuffPlayer', function(data)
    if not IsPedRagdoll(PlayerPedId()) and not CuffCooldown then
        local player, distance = QBCore.Functions.GetClosestPlayer()
        if player ~= -1 and distance < 1.0 then
            local playerPed = GetPlayerPed(player)
            local playerId = GetPlayerServerId(player)
            if not IsPedInAnyVehicle(playerPed) and not IsPedInAnyVehicle(PlayerPedId()) then
                CuffCooldown = true
                SetTimeout(5000, function()
                    CuffCooldown = false
                end)
                local dist = #(vector3(GetEntityHeading(PlayerPedId()),GetEntityHeading(PlayerPedId()),GetEntityHeading(PlayerPedId())) - vector3(GetEntityHeading(GetPlayerPed(player)),GetEntityHeading(GetPlayerPed(player)),GetEntityHeading(GetPlayerPed(player))) )
                if dist < 200.0 then
                    local head =GetEntityHeading(GetPlayerPed(player))
                    local playhead=0
                   if head>180 then
                    playhead=GetEntityHeading(GetPlayerPed(player))-180
                   else
                    playhead=GetEntityHeading(GetPlayerPed(player))+180
                   end
                    TriggerServerEvent("police:server:CuffPlayer", playerId, data,1,playhead)
                else 
                  
                  
                    TriggerServerEvent("police:server:CuffPlayer", playerId, data,0,999)
                end
               
            else
                QBCore.Functions.Notify(Lang:t("error.vehicle_cuff"), "error")
            end
        else
            QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
        end
    end
end)

RegisterNetEvent('police:client:UncuffPlayer', function(data)
    if not IsPedRagdoll(PlayerPedId()) and not CuffCooldown then
        local player, distance = QBCore.Functions.GetClosestPlayer()
        if player ~= -1 and distance < 1.5 then
            local playerPed = GetPlayerPed(player)
            local playerId = GetPlayerServerId(player)
            if not IsPedInAnyVehicle(playerPed) and not IsPedInAnyVehicle(PlayerPedId()) then
                CuffCooldown = true
                SetTimeout(5000, function()
                    CuffCooldown = false
                end)
                TriggerServerEvent("police:server:UncuffPlayer", playerId, data)
            else
                QBCore.Functions.Notify(Lang:t("error.vehicle_cuff"), "error")
            end
        else
            QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
        end
    end
end)

RegisterNetEvent('police:client:fixElevator', function()
    if not IsPedRagdoll(PlayerPedId()) and isEscorting then
        local player, distance = QBCore.Functions.GetClosestPlayer()
        if player ~= -1 and distance < 1.5 then
            local playerId = GetPlayerServerId(player)
            if not IsPedInAnyVehicle(GetPlayerPed(player)) and not IsPedInAnyVehicle(PlayerPedId()) then
                TriggerServerEvent("police:server:fixElevator", playerId)
            end
        else
            QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
        end
    end
end)

RegisterNetEvent('police:client:GetEscorted', function(idPlayer)
    local ped = PlayerPedId()
    if Player(GetPlayerServerId(PlayerId())).state['isDead'] or Player(GetPlayerServerId(PlayerId())).state['isCuffed'] then
        if not isEscorted then
            isEscorted = true
            local dragger = GetPlayerPed(GetPlayerFromServerId(idPlayer))
            SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(dragger, 0.0, 0.45, 0.0))
            AttachEntityToEntity(ped, dragger, 11816, 0.45, 0.45, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            TriggerServerEvent('police:server:DoEscorteStatus', idPlayer, true)
        else
            isEscorted = false
            DetachEntity(ped, true, false)
            TriggerServerEvent('police:server:DoEscorteStatus', idPlayer, false)
        end
        TriggerEvent('hospital:client:isEscorted', isEscorted)
    end
end)

RegisterNetEvent('police:client:DoEscorteStatus', function(state)
    isEscorting = state
end)

RegisterNetEvent('police:client:DeEscort', function()
    isEscorted = false
    TriggerEvent('hospital:client:isEscorted', isEscorted)
    DetachEntity(PlayerPedId(), true, false)
end)

RegisterNetEvent('police:client:GetCuffed', function(playerId, data,typecuff,policeid,playerheading)
    if not isHandcuffed then
        if CuffAmount > 3 and not CuffBuff then
            if (typecuff~=0) then
                GetCuffedAnimation(playerId)
            end
            CuffMe(playerId, data,typecuff)
        else
            QBCore.Functions.Notify('going for cuff', 'error')
            if (typecuff~=0) then
                GetCuffedAnimation(playerId)
            end
            Wait(750)
            local success = exports["five-repairkit"]:Minigame(math.random(2,3))
            if success then
                CuffAmount = CuffAmount + 1
                if CuffAmount == 3 then
                    SetTimeout(30*60*1000, function()
                        CuffAmount = 0
                        QBCore.Functions.Notify('Your Cuff Cooldown Has Been Cleared!', 'success')
                    end)
                end
                TriggerServerEvent("police:server:cuffcancel",policeid,playerheading)
            else
                CuffMe(playerId, data,typecuff)
            end
        end
    end
end)
local function GetDirectionFromRotation(rotation)
    local dm = (math.pi / 180)
    return vector3(-math.sin(dm * rotation.z) * math.abs(math.cos(dm * rotation.x)), math.cos(dm * rotation.z) * math.abs(math.cos(dm * rotation.x)), math.sin(dm * rotation.x))
end

RegisterNetEvent('police:client:cuffcancelsuspect', function(playerheading)
    if playerheading~=999 then
        SetEntityHeading(PlayerPedId(),playerheading)
    end
    loadAnimDict("melee@unarmed@streamed_variations")
    TaskPlayAnim(PlayerPedId(), "melee@unarmed@streamed_variations", "plyr_takedown_rear_lefthook", 3.0, 3.0, -1, 48, 0, 0, 0, 0)
end)
RegisterNetEvent('police:client:cuffcancelpolice', function()
    -- loadAnimDict("melee@unarmed@streamed_variations")
    -- TaskPlayAnim(PlayerPedId(), "melee@unarmed@streamed_variations", "victim_takedown_front_slap", 3.0, 3.0, -1, 48, 0, 0, 0, 0)
    ClearPedSecondaryTask(PlayerPedId())
    Wait(1000)
    SetPedToRagdoll(PlayerPedId(), 50, 50, 0, 0, 0, 0)
    local vel=GetEntityVelocity(PlayerPedId())
    local rot = GetGameplayCamRot(2)
    local dir = GetDirectionFromRotation(rot)
    SetEntityHeading(PlayerPedId(), rot.z + 90.0)
    SetEntityVelocity(PlayerPedId(), dir.x * -10, dir.y * -10, 10 * dir.z)
   
end)

RegisterNetEvent('police:client:GetUncuffed', function()
    local ped = PlayerPedId()
    if isHandcuffed then
        if cuffsprop then 
            DeleteEntity(cuffsprop)
            cuffsprop = nil
         end
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "Uncuff", 0.2)
        isHandcuffed = false
        Player(GetPlayerServerId(PlayerId())).state:set("isCuffed", false, true)
        isEscorted = false
        TriggerEvent('hospital:client:isEscorted', false)
        DetachEntity(ped, true, false)
        Wait(1000)
        ClearPedTasksImmediately(ped)
    end
end)

RegisterNetEvent('police:client:fixElevatorForMe', function(playerId)
    local ped = PlayerPedId()
    local cuffer = GetPlayerPed(GetPlayerFromServerId(playerId))
    local heading = GetEntityHeading(cuffer)
    ClearPedTasksImmediately(ped)
    SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(cuffer, 0.0, 0.45, 0.0))
	Wait(100)
	SetEntityHeading(ped, heading)
end)

RegisterNetEvent('qb-policejob:client:removemask', function()
	SetPedComponentVariation(GetPlayerPed(-1), 1, 0, 0, 1) 
end)

local vest = {item = 0, texture = 0}
RegisterCommand('v0', function()
    if (GetEntityModel(GetPlayerPed(-1)) == GetHashKey('mp_f_freemode_01') or GetEntityModel(GetPlayerPed(-1))== GetHashKey('mp_m_freemode_01')) then
        ExecuteCommand('e adjust')
        vest.item = GetPedDrawableVariation(PlayerPedId(), 9)
        vest.texture = GetPedTextureVariation(PlayerPedId(), 9)
        Wait(2000)
        SetPedComponentVariation(PlayerPedId(), 9, 0, 0, 0)
        ExecuteCommand('e c')
	end
end)
RegisterCommand('v1', function()
    if (GetEntityModel(GetPlayerPed(-1)) == GetHashKey('mp_f_freemode_01') or GetEntityModel(GetPlayerPed(-1))== GetHashKey('mp_m_freemode_01')) then
        ExecuteCommand('e adjust')
        Wait(2000)
        SetPedComponentVariation(PlayerPedId(), 9, vest.item, vest.texture, 0)
        ExecuteCommand('e c')
	end
end)