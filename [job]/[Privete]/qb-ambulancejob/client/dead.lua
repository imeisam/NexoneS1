local DeadStyle = false
local waitForDead = false
local deadAnimDict, deadAnim = nil, nil
local hold = 5
local deathTime = 0
local LaststandTime = 0
local isEscorted = false
local HoldDone = false
local unconsious = {
    [GetHashKey('WEAPON_UNARMED')] = true,
    [GetHashKey('WEAPON_BAT')] = true,
    [GetHashKey('WEAPON_NIGHTSTICK')] = true
}
local Reasons = {
    [`weapon_barbed_wire`]			= {['name'] = 'weapon_barbed_wire',			['label'] = 'Barbed Wire'},
	[`weapon_drowning`]				= {['name'] = 'weapon_drowning',			['label'] = 'Drowning'},
	[`weapon_drowning_in_vehicle`]	= {['name'] = 'weapon_drowning_in_vehicle',	['label'] = 'Drowning in a Vehicle'},
	[`weapon_bleeding`]				= {['name'] = 'weapon_bleeding',			['label'] = 'Bleeding'},
	[`weapon_electric_fence`]		= {['name'] = 'weapon_electric_fence',		['label'] = 'Electric Fence'},
	[`weapon_explosion`]			= {['name'] = 'weapon_explosion',			['label'] = 'Explosion'},
	[`weapon_fall`]					= {['name'] = 'weapon_fall',				['label'] = 'Fall'},
	[`weapon_exhaustion`]			= {['name'] = 'weapon_exhaustion',			['label'] = 'Exhaustion'},
	[`weapon_hit_by_water_cannon`]	= {['name'] = 'weapon_hit_by_water_cannon',	['label'] = 'Water Cannon'},
	[`weapon_rammed_by_car`]		= {['name'] = 'weapon_rammed_by_car',		['label'] = 'Rammed - Vehicle'},
	[`weapon_run_over_by_car`]		= {['name'] = 'weapon_run_over_by_car',		['label'] = 'Run Over - Vehicle'},
	[`weapon_heli_crash`]			= {['name'] = 'weapon_heli_crash',			['label'] = 'Heli Crash'},
	[`weapon_fire`]					= {['name'] = 'weapon_fire',				['label'] = 'Fire'},
    [`weapon_animal`]	            = {['name'] = 'weapon_animal',	            ['label'] = 'Animal'},
    [`weapon_cougar`]	            = {['name'] = 'weapon_cougar',	            ['label'] = 'Cougar'},
}

-- Functions

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

local function DrawTxt(x, y, width, height, scale, text, r, g, b, a, _)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

local function DeadFunc()
    CreateThread(function()
        hold = 5
        HoldDone = false
	    while InLaststand or isDead do
            Wait(1000)
            if InLaststand then
                LaststandTime = LaststandTime - 1
                if LaststandTime < 0 then
                    LaststandTime = 0
                end
            end
            if isDead then
                deathTime = deathTime - 1
                if deathTime < 0 then
                    deathTime = 0
                end
            end
            if (isDead and deathTime == 0) or (InLaststand and LaststandTime == 0) then
                if IsControlPressed(0, 38) and hold <= 0 and not isInHospitalBed then
                    if isDead then
                        local PlayerData = QBCore.Functions.GetPlayerData()
                        if PlayerData.metadata.injail ~= 0 then
                            TriggerEvent("qb-jail:client:PrisonRevive")
                        else
                            TriggerServerEvent("hospital:server:RespawnAtHospital")
                        end
                    elseif InLaststand then
                        TriggerEvent('hospital:client:Revive')
                    end
                    HoldDone = true
                    hold = 5
                end
                if IsControlPressed(0, 38) then
                    if hold - 1 >= 0 then
                        hold = hold - 1
                    else
                        hold = 0
                    end
                    TriggerEvent('qb-deathscreen:client:holdtime', hold)
                end
                if IsControlReleased(0, 38) then
                    hold = 5
                    TriggerEvent('qb-deathscreen:client:holdtime', hold)
                end
            end
        end
    end)
    CreateThread(function()
	    while isDead or InLaststand do
            Wait(5)
            local ped = PlayerPedId()
            DisableAllControlActions(0)
            EnableControlAction(0, 1, true)
			EnableControlAction(0, 2, true)
			EnableControlAction(0, 245, true)
            EnableControlAction(0, 38, true)
            EnableControlAction(0, 0, true)
            EnableControlAction(0, 322, true)
            EnableControlAction(0, 288, true)
            EnableControlAction(0, 213, true)
            EnableControlAction(0, 249, true)
            EnableControlAction(0, 46, true)
            EnableControlAction(0, 47, true)
            if GetEntityHealth(ped) ~= 150 then
                SetEntityHealth(ped, 150)
            end
            if IsPedInAnyVehicle(ped, false) then
                loadAnimDict("veh@low@front_ps@idle_duck")
                if not IsEntityPlayingAnim(ped, "veh@low@front_ps@idle_duck", "sit", 3) then
                    TaskPlayAnim(ped, "veh@low@front_ps@idle_duck", "sit", 1.0, 1.0, -1, 1, 0, 0, 0, 0)
                end
            else
                loadAnimDict("veh@low@front_ps@idle_duck")
                if IsEntityPlayingAnim(ped, "veh@low@front_ps@idle_duck", "sit", 3) then
                    StopAnimTask(ped, "veh@low@front_ps@idle_duck", "sit", 3)
                end
                if isInHospitalBed then
                    if not IsEntityPlayingAnim(ped, inBedDict, inBedAnim, 3) then
                        loadAnimDict(inBedDict)
                        TaskPlayAnim(ped, inBedDict, inBedAnim, 1.0, 1.0, -1, 1, 0, 0, 0, 0)
                    end
                elseif isEscorted then
                    loadAnimDict(deadAnimDict)
                    if IsEntityPlayingAnim(ped, deadAnimDict, deadAnim, 3) then
                        StopAnimTask(ped, deadAnimDict, deadAnim, 3)
                    end
                else
                    if not IsEntityPlayingAnim(ped, deadAnimDict, deadAnim, 3) then
                        loadAnimDict(deadAnimDict)
                        TaskPlayAnim(ped, deadAnimDict, deadAnim, 1.0, 1.0, -1, 1, 0, 0, 0, 0)
                    end
                end
            end
            if not HoldDone then
                if isDead then
                    if not isInHospitalBed then
                        -- if deathTime > 0 then
                        --     DrawTxt(0.94, 1.44, 1.0, 1.0, 0.6, Lang:t('info.respawn_txt', {time = math.ceil(deathTime)}), 255, 255, 255, 255)
                        -- else
                        --     DrawTxt(0.91, 1.44, 1.0, 1.0, 0.6, Lang:t('info.respawn_revive', {holdtime = hold, cost = Config.BillCost}), 255, 255, 255, 255)
                        -- end
                    end
                elseif InLaststand then
                    if LaststandTime > 0 then
                        DrawTxt(0.94, 1.44, 1.0, 1.0, 0.6, Lang:t('info.unconscious_txt', {time = math.ceil(LaststandTime)}), 255, 255, 255, 255)
                    else
                        DrawTxt(0.91, 1.44, 1.0, 1.0, 0.6, Lang:t('info.unconscious_revive', {holdtime = hold}), 255, 255, 255, 255)
                    end
                end
            end
		end
	end)
end

-- Handler

RegisterNetEvent('qb-ambulancejob:client:deadtoggle', function()
    DeadStyle = not DeadStyle
    if DeadStyle then
        QBCore.Functions.Notify('You Enable Unconsious', 'success')
    else
        QBCore.Functions.Notify('You Disable Unconsious', 'error')
    end
end)

AddEventHandler('gameEventTriggered', function(event, data)
    if event == "CEventNetworkEntityDamage" then
        local victim, attacker, victimDied, weapon = data[1], data[2], data[4], data[7]
        if not IsEntityAPed(victim) then return end
        local ped = PlayerPedId()
        if victimDied and NetworkGetPlayerIndexFromPed(victim) == PlayerId() and IsEntityDead(ped) then
            while GetEntitySpeed(ped) > 0.5 or IsPedRagdoll(ped) do Wait(10) end
            RespawnPlayer()
            TriggerEvent('inventory:client:Close')
            if not isDead and not waitForDead then
                waitForDead = true
                Player(GetPlayerServerId(PlayerId())).state:set("isDead", true, true)
                LocalPlayer.state:set('isDead', true, true)
                local playerid = NetworkGetPlayerIndexFromPed(victim)
                -- local PData = QBCore.Functions.GetPlayerData()
                -- PData.charinfo.firstname..' '..PData.charinfo.lastname..' ('..PData.citizenid..')
                local playerName = (Player(playerid).state['icname'] or GetPlayerName(playerid)) .. " " .. "("..GetPlayerServerId(playerid)..")" or Lang:t('info.self_death')
                local killerId = NetworkGetPlayerIndexFromPed(attacker)
                local killerName = (Player(killerId).state['icname'] or GetPlayerName(killerId)) .. " " .. "("..GetPlayerServerId(killerId)..")" or Lang:t('info.self_death')
                local weaponLabel = 'Unknown'
                local weaponName = 'Unknown'
                if QBCore.Shared.Weapons[weapon] then
                    weaponLabel = QBCore.Shared.Weapons[weapon].label
                    weaponName = QBCore.Shared.Weapons[weapon].name
                elseif Reasons[weapon] then
                    weaponLabel = Reasons[weapon].label
                    weaponName = Reasons[weapon].name
                end
                TriggerServerEvent("qb-log:server:CreateLog", "death", Lang:t('logs.death_log_title', {playername = playerName, playerid = GetPlayerServerId(playerid)}), "red", Lang:t('logs.death_log_message', {killername = killerName, playername = playerName, weaponlabel = weaponLabel, weaponname = weaponName}))
                TriggerEvent('weapons:client:SetCurrentWeapon', nil)
                TriggerServerEvent("InteractSound_SV:PlayOnSource", "demo", 0.1)
                if (unconsious[weapon] and not InLaststand) or DeadStyle then
                    InLaststand = true
                    waitForDead = false
                    TriggerServerEvent("hospital:server:SetDeathStatus", false)
                    TriggerServerEvent("hospital:server:SetLaststandStatus", true)
                    LaststandTime = Config.LastStandTime
                    deadAnimDict, deadAnim = "missarmenian2", "drunk_loop"
                    DeadFunc()
                else
                    InLaststand = false
                    isDead = true
                    waitForDead = false
                    TriggerEvent('qb-deathscreen:die', Config.DeathTime)
                    TriggerServerEvent("hospital:server:SetDeathStatus", true)
                    TriggerServerEvent("hospital:server:SetLaststandStatus", false)
                    deathTime = Config.DeathTime
                    deadAnimDict, deadAnim = "dead", "dead_a"
                    DeadFunc()
                end
            end
        end
    end
end)

RegisterNetEvent('hospital:client:doKillStand', function(LStand)
    Player(GetPlayerServerId(PlayerId())).state:set("isDead", true, true)
    LocalPlayer.state:set('isDead', true, true)
    if LStand then
        InLaststand = true
        isDead = false
        LaststandTime = Config.LastStandTime
        deadAnimDict, deadAnim = "missarmenian2", "drunk_loop"
        DeadFunc()
    else
        InLaststand = false
        isDead = true
        deathTime = Config.DeathTime
        deadAnimDict, deadAnim = "dead", "dead_a"
        TriggerEvent('qb-deathscreen:die', Config.DeathTime)
        DeadFunc()
    end
end)

RegisterNetEvent('hospital:client:isEscorted', function(bool)
    isEscorted = bool
end)