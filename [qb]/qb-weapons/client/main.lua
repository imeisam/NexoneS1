-- Variables
local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData, CurrentWeaponData, MultiplierAmount, HasArmed, anim = {}, {}, 0, false, false

-- Handlers

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

AddEventHandler('onKeyDown', function(key)
    if key == 'r' and HasArmed then
        local ped = PlayerPedId()
        local weapon = GetSelectedPedWeapon(ped)
        if QBCore.Shared.Weapons[weapon] and QBCore.Shared.Weapons[weapon]["ammotype"] then
            local total = GetAmmoInPedWeapon(ped, weapon)
            if total == 0 or (IsPedInAnyVehicle(PlayerPedId()) and total == 1) then
                local clip = (string.gsub(string.lower(QBCore.Shared.Weapons[weapon]["ammotype"]), 'ammo_', ''))..'_clip'
                if not Config.MaxAmmoClip[clip] then return end
                TriggerServerEvent('qb-weapons:server:reloadClip', clip, total)
            end
        end
    end
end)

-- Events

RegisterNetEvent('weapons:client:SetCurrentWeapon', function(data)
    if data then
        CurrentWeaponData = data
        if not HasArmed then
            HasArmed = true
            QualityLoop()
            AmountLoop()
        end
    else
        HasArmed = false
        CurrentWeaponData = {}
    end
end)

RegisterNetEvent('weapon:client:AddAmmo', function(type, maxAmmo, itemData)
    local ped = PlayerPedId()
    local weapon = GetSelectedPedWeapon(ped)
    if QBCore.Shared.Weapons[weapon] and CurrentWeaponData then
        if QBCore.Shared.Weapons[weapon]["name"] ~= "weapon_unarmed" and QBCore.Shared.Weapons[weapon]["ammotype"] == type:upper() then
            local total = GetAmmoInPedWeapon(ped, weapon)
            if total < maxAmmo then
                QBCore.Functions.Progressbar("taking_bullets", Lang:t('info.loading_bullets'), 1200, false, true, {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    AddAmmoToPed(ped,weapon,1)
                    TaskReloadWeapon(ped)
                    TriggerServerEvent("weapons:server:AddWeaponAmmo", CurrentWeaponData, total + 1)
                    TriggerServerEvent('QBCore:Server:RemoveItem', itemData.name, 1, itemData.slot)
                end, function()
                    QBCore.Functions.Notify(Lang:t('error.canceled'), "error")
                end)
            else
                QBCore.Functions.Notify(Lang:t('error.max_ammo'), "error")
            end
        else
            QBCore.Functions.Notify(Lang:t('error.no_weapon'), "error")
        end
    else
        QBCore.Functions.Notify(Lang:t('error.no_weapon'), "error")
    end
end)

RegisterNetEvent('weapon:client:UseClip', function(type, itemData)
    local ped = PlayerPedId()
    local weapon = GetSelectedPedWeapon(ped)
    if QBCore.Shared.Weapons[weapon] and CurrentWeaponData then
        if QBCore.Shared.Weapons[weapon]["name"] ~= "weapon_unarmed" and QBCore.Shared.Weapons[weapon]["ammotype"] == type:upper() then
            QBCore.Functions.Progressbar("taking_bullets", Lang:t('info.loading_bullets'), 750, false, true, {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function()
                local ammoAdd = itemData.info.ammo or 0
                TriggerServerEvent('qb-weapons:server:useClip', itemData.slot, tonumber(GetAmmoInPedWeapon(ped, weapon)), CurrentWeaponData, ammoAdd)
                SetAmmoInClip(ped, weapon, 0)
                SetPedAmmo(ped, weapon, ammoAdd)
            end, function()
                QBCore.Functions.Notify(Lang:t('error.canceled'), "error")
            end)
        else
            QBCore.Functions.Notify(Lang:t('error.no_weapon'), "error")
        end
    else
        QBCore.Functions.Notify(Lang:t('error.no_weapon'), "error")
    end
end)

AddEventHandler('qb-inventory:client:combine', function(azName, beName, data)
    if not Config.MaxAmmoClip[beName] then return end
    if HasArmed then return end
    if anim then return end
    anim = true
    TriggerServerEvent('weapons:server:combineAmmo', data.az.slot, data.be.slot)
end)

RegisterNetEvent('weapons:client:ReloadAnimation', function(time)
    if not anim then return end
    anim = true
    if time > 6000 then
        time = 8000
    elseif time > 4000 then
        time = 6000
    elseif time > 2000 then
        time = 4000
    else
        time = 2000
    end
    RequestAnimDict("items@clear@custom_anim")
    while not HasAnimDictLoaded("items@clear@custom_anim") do
        Wait(5)
    end
    local model = GetHashKey('w_pi_pistol50_mag1')
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(5)
    end
    local prop = CreateObject(model, 1.0, 1.0, 1.0, true, true, false)
    AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.09, 0.022, -0.1, -90.0, 70.0, 0.0, 0, 1, 0, 1, 0, 1)
    SetEntityCompletelyDisableCollision(prop, false, true)	
    SetEntityNoCollisionEntity(prop, true, false)
    SetModelAsNoLongerNeeded(model)
    CreateThread(function()
        while anim do
            TaskPlayAnim(PlayerPedId(), "items@clear@custom_anim", "reloading", 8.0, 8.0, -1, 50, 0, false, false, true)
            Wait(500)
        end
    end)
    CreateThread(function()
        for i=1,time/2000,1 do
            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3, 'reload', 0.3)
            Wait(2000)
        end
    end)
    QBCore.Functions.Progressbar("taking_bullets", Lang:t('info.loading_bullets'), time + 500, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        anim = false
        DeleteEntity(prop)
        ClearPedTasks(PlayerPedId())
    end)
end)

-- Threads

CreateThread(function()
    SetWeaponsNoAutoswap(true)
end)

function QualityLoop()
    CreateThread(function()
        while HasArmed do
            local ped = PlayerPedId()
            local idle = 1
            if (IsPedArmed(ped, 7) == 1 and (IsControlJustReleased(0, 24) or IsDisabledControlJustReleased(0, 24))) or IsPedShooting(PlayerPedId()) then
                local weapon = GetSelectedPedWeapon(ped)
                local ammo = GetAmmoInPedWeapon(ped, weapon)
                TriggerServerEvent("weapons:server:UpdateWeaponAmmo", CurrentWeaponData, tonumber(ammo))
                if MultiplierAmount > 0 then
                    TriggerServerEvent("weapons:server:UpdateWeaponQuality", CurrentWeaponData, MultiplierAmount)
                    MultiplierAmount = 0
                end
            end
            Wait(idle)
        end
    end)
end

function AmountLoop()
    CreateThread(function()
        while HasArmed do
            local ped = PlayerPedId()
            if CurrentWeaponData and next(CurrentWeaponData) then
                if IsPedShooting(ped) or IsControlJustPressed(0, 24) then
                    local weapon = GetSelectedPedWeapon(ped)
                    if weapon and weapon ~= 0 and QBCore.Shared.Weapons[weapon] then
                        local ammo = GetAmmoInPedWeapon(ped, weapon)
                        if QBCore.Shared.Weapons[weapon]["name"] == "weapon_pipebomb" then
                            TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_pipebomb", 1)
                        elseif QBCore.Shared.Weapons[weapon]["name"] == "weapon_molotov" then
                            TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_molotov", 1)
                        elseif QBCore.Shared.Weapons[weapon]["name"] == "weapon_stickybomb" then
                            TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_stickybomb", 1)
                        elseif QBCore.Shared.Weapons[weapon]["name"] == "weapon_grenade" then
                            TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_grenade", 1)
                        elseif QBCore.Shared.Weapons[weapon]["name"] == "weapon_bzgas" then
                            TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_bzgas", 1)
                        elseif QBCore.Shared.Weapons[weapon]["name"] == "weapon_proxmine" then
                            TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_proxmine", 1)
                        elseif QBCore.Shared.Weapons[weapon]["name"] == "weapon_ball" then
                            TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_ball", 1)
                        elseif QBCore.Shared.Weapons[weapon]["name"] == "weapon_smokegrenade" then
                            TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_smokegrenade", 1)
                        elseif QBCore.Shared.Weapons[weapon]["name"] == "weapon_flare" then
                            TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_flare", 1)
                        elseif QBCore.Shared.Weapons[weapon]["name"] == "weapon_cash" then
                            TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_cash", 1)
                        elseif QBCore.Shared.Weapons[weapon]["name"] == "weapon_shoe" then
                            TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_shoe", 1)
                        else
                            if ammo > 0 then
                                MultiplierAmount = MultiplierAmount + 1
                            end
                        end
                    end
                end
            end
            Wait(1)
        end
    end)
end

CreateThread(function()
    while true do
        Wait(5000)
        if LocalPlayer.state.isLoggedIn then
            if IsPedShooting(PlayerPedId()) and GetAmmoInPedWeapon(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId())) > 30 then
                TriggerServerEvent('qb-weapons:server:MaxAmmo')
                return
            end
        end
    end
end)