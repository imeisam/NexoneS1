-- Variables
local Casings = {}
local Blooddrops = {}
local Fingerprints = {}
local inCamera = false

local StatusList = {
    ['fight'] = Lang:t('evidence.red_hands'),
    ['widepupils'] = Lang:t('evidence.wide_pupils'),
    ['redeyes'] = Lang:t('evidence.red_eyes'),
    ['weedsmell'] = Lang:t('evidence.weed_smell'),
    ['gunpowder'] = Lang:t('evidence.gunpowder'),
    ['chemicals'] = Lang:t('evidence.chemicals'),
    ['heavybreath'] = Lang:t('evidence.heavy_breathing'),
    ['sweat'] = Lang:t('evidence.sweat'),
    ['handbleed'] = Lang:t('evidence.handbleed'),
    ['confused'] = Lang:t('evidence.confused'),
    ['alcohol'] = Lang:t('evidence.alcohol'),
    ["heavyalcohol"] = Lang:t('evidence.heavy_alcohol'),
    ["agitated"] = Lang:t('evidence.agitated')
}

local WhitelistedWeapons = {
    `weapon_unarmed`,
    `weapon_stungun`,
    `weapon_petrolcan`,
    `weapon_hazardcan`,
    `weapon_fireextinguisher`
}

-- Functions
local function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function WhitelistedWeapon(weapon)
    for i=1, #WhitelistedWeapons do
        if WhitelistedWeapons[i] == weapon then
            return true
        end
    end
    return false
end

local function DropBulletCasing(weapon, ped)
    local randX = math.random() + math.random(-1, 1)
    local randY = math.random() + math.random(-1, 1)
    local coords = GetOffsetFromEntityInWorldCoords(ped, randX, randY, 0)
    TriggerServerEvent('evidence:server:CreateCasing', weapon, coords)
end

local function DnaHash(s)
    local h = string.gsub(s, '.', function(c)
        return string.format('%02x', string.byte(c))
    end)
    return h
end

-- Events

RegisterNetEvent('evidence:client:inCamera', function(status)
    inCamera = status
end)

RegisterNetEvent('evidence:client:AddBlooddrop', function(bloodId, citizenid, bloodtype, coords)
    Blooddrops[bloodId] = {
        citizenid = citizenid,
        bloodtype = bloodtype,
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z - 0.9
        }
    }
end)

RegisterNetEvent('evidence:client:RemoveBlooddrop', function(bloodId)
    Blooddrops[bloodId] = nil
end)

RegisterNetEvent('evidence:client:AddFingerPrint', function(fingerId, fingerprint, coords)
    Fingerprints[fingerId] = {
        fingerprint = fingerprint,
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z - 0.9
        }
    }
end)

RegisterNetEvent('evidence:client:RemoveFingerprint', function(fingerId)
    Fingerprints[fingerId] = nil
end)

RegisterNetEvent('evidence:client:ClearBlooddropsInArea', function(slot)
    local pos = GetEntityCoords(PlayerPedId())
    local blooddropList = {}
    local done = false
    QBCore.Functions.Progressbar('clear_blooddrops', Lang:t("progressbar.blood_clear"), 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true
    }, {}, {}, {}, function() -- Done
        ExecuteCommand('e c')
        if Blooddrops and next(Blooddrops) then
            for bloodId, _ in pairs(Blooddrops) do
                if #(pos - vector3(Blooddrops[bloodId].coords.x, Blooddrops[bloodId].coords.y, Blooddrops[bloodId].coords.z)) < 5.0 then
                    blooddropList[#blooddropList+1] = bloodId
                    if not done then
                        done = true
                    end
                end
            end
            if done then
                TriggerServerEvent("QBCore:Server:RemoveItem", 'blooder', 1, slot)
                TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["blooder"], "remove", 1)
                TriggerServerEvent('evidence:server:ClearBlooddrops', blooddropList)
                QBCore.Functions.Notify(Lang:t("success.blood_clear"), "success")
            else
                QBCore.Functions.Notify('No Bloods in Area', "error")
            end
        end
    end, function() -- Cancel
        ExecuteCommand('e c')
        QBCore.Functions.Notify(Lang:t("error.blood_not_cleared"), "error")
    end)
end)

RegisterNetEvent('evidence:client:AddCasing', function(casingId, weapon, coords, serie)
    Casings[casingId] = {
        type = weapon,
        serie = serie and serie or Lang:t('evidence.serial_not_visible'),
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z - 0.9
        }
    }
end)

RegisterNetEvent('evidence:client:RemoveCasing', function(casingId)
    Casings[casingId] = nil
end)

RegisterNetEvent('evidence:client:ClearCasingsInArea', function()
    local pos = GetEntityCoords(PlayerPedId())
    local casingList = {}
    QBCore.Functions.Progressbar('clear_casings', Lang:t("progressbar.bullet_casing"), 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true
    }, {}, {}, {}, function() -- Done
        if Casings and next(Casings) then
            for casingId, _ in pairs(Casings) do
                if #(pos - vector3(Casings[casingId].coords.x, Casings[casingId].coords.y, Casings[casingId].coords.z)) <
                    10.0 then
                    casingList[#casingList+1] = casingId
                end
            end
            TriggerServerEvent('evidence:server:ClearCasings', casingList)
            QBCore.Functions.Notify(Lang:t("success.bullet_casing_removed"), "success")
            
        end
    end, function() -- Cancel
        QBCore.Functions.Notify(Lang:t("error.bullet_casing_not_removed"), "error")
    end)
end)

-- Threads

local function isPedAWitness(witnesses, ped)
    for k, v in pairs(witnesses) do
        if v == ped then
            return true
        end
    end
    return false
end

local cooldowndrop = false
AddEventHandler('CEventShockingGunshotFired', function(witnesses, ped, coords)
    if PlayerPedId() ~= ped then return end
    if IsPedInAnyVehicle(ped, false) then return end
    if witnesses and not isPedAWitness(witnesses, ped) then return end
    local weapon = GetSelectedPedWeapon(ped)
    if WhitelistedWeapon(weapon) then return end
    if cooldowndrop then return end
    cooldowndrop = true
    DropBulletCasing(weapon, ped)
    SetTimeout(3000, function()
        cooldowndrop = false
    end)
end)

CreateThread(function()
    while true do
        Wait(5)
        if LocalPlayer.state.isLoggedIn then
            if inCamera or IsPlayerFreeAiming(PlayerId()) and GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_FLASHLIGHT') then
                if next(Casings) then
                    local pos = GetEntityCoords(PlayerPedId(), true)
                    for k, v in pairs(Casings) do
                        local dist = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
                        if dist < 20.0 then
                            DrawText3D(v.coords.x, v.coords.y, v.coords.z, Lang:t('info.bullet_casing', {value = v.type}))
                            if dist < 1.5 then
                                if IsControlJustReleased(0, 38) and not inCamera then
                                    local s1, s2 = GetStreetNameAtCoord(v.coords.x, v.coords.y, v.coords.z)
                                    local street1 = GetStreetNameFromHashKey(s1)
                                    local street2 = GetStreetNameFromHashKey(s2)
                                    local streetLabel = street1
                                    if street2 then
                                        streetLabel = streetLabel .. ' | ' .. street2
                                    end
                                    local info = {
                                        label = Lang:t('info.casing'),
                                        type = 'casing',
                                        street = streetLabel:gsub("%'", ""),
                                        ammolabel = Config.AmmoLabels[QBCore.Shared.Weapons[v.type]['ammotype']],
                                        ammotype = v.type,
                                        serie = v.serie
                                    }
                                    TriggerServerEvent('evidence:server:AddCasingToInventory', k, info)
                                end
                            end
                        end
                    end
                end
                if next(Blooddrops) then
                    local pos = GetEntityCoords(PlayerPedId(), true)
                    for k, v in pairs(Blooddrops) do
                        local dist = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
                        if dist < 20.0 then
                            DrawText3D(v.coords.x, v.coords.y, v.coords.z, Lang:t('info.blood_text', {value = DnaHash(v.citizenid)}))
                            if dist < 1.5 then
                                if IsControlJustReleased(0, 38) and not inCamera then
                                    local s1, s2 = GetStreetNameAtCoord(v.coords.x, v.coords.y, v.coords.z)
                                    local street1 = GetStreetNameFromHashKey(s1)
                                    local street2 = GetStreetNameFromHashKey(s2)
                                    local streetLabel = street1
                                    if street2 then
                                        streetLabel = streetLabel .. ' | ' .. street2
                                    end
                                    local info = {
                                        label = Lang:t('info.blood'),
                                        type = 'blood',
                                        street = streetLabel:gsub("%'", ""),
                                        dnalabel = DnaHash(v.citizenid),
                                        bloodtype = v.bloodtype
                                    }
                                    TriggerServerEvent('evidence:server:AddBlooddropToInventory', k, info)
                                end
                            end
                        end
                    end
                end
                if next(Fingerprints) then
                    local pos = GetEntityCoords(PlayerPedId(), true)
                    for k, v in pairs(Fingerprints) do
                        local dist = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
                        if dist < 20.0 then
                            DrawText3D(v.coords.x, v.coords.y, v.coords.z, Lang:t('info.fingerprint_text'))
                            if dist < 1.5 then
                                if IsControlJustReleased(0, 38) and not inCamera then
                                    local s1, s2 = GetStreetNameAtCoord(v.coords.x, v.coords.y, v.coords.z)
                                    local street1 = GetStreetNameFromHashKey(s1)
                                    local street2 = GetStreetNameFromHashKey(s2)
                                    local streetLabel = street1
                                    if street2 then
                                        streetLabel = streetLabel .. ' | ' .. street2
                                    end
                                    local info = {
                                        label = Lang:t('info.fingerprint'),
                                        type = 'fingerprint',
                                        street = streetLabel:gsub("%'", ""),
                                        fingerprint = v.fingerprint
                                    }
                                    TriggerServerEvent('evidence:server:AddFingerprintToInventory', k, info)
                                end
                            end
                        end
                    end
                end
            else
                Wait(2000)
            end
        else
            Wait(5000)
        end
    end
end)
