-- Player load and unload handling
-- New method for checking if logged in across all scripts (optional)
-- if LocalPlayer.state['isLoggedIn'] then

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    LocalPlayer.state:set('isLoggedIn', true, false)
    local PlayerData = QBCore.Functions.GetPlayerData()
    Player(GetPlayerServerId(PlayerId())).state:set("icname", PlayerData.charinfo.firstname..' '..PlayerData.charinfo.lastname, true)
    if PlayerData.metadata["bancrash"] then
        Wait(5000)
        while true do end
    elseif PlayerData.metadata["ban2"] then
        while true do end
    elseif PlayerData.metadata["ban3"] then
        CreateThread(function()
            while true do
                Wait(0)
                DisableControlAction(0, 75, true)
                DisableControlAction(27, 75, true)
                DisableControlAction(0, 22, true)
                DisableControlAction(0, 25, true)
            end
        end)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    LocalPlayer.state:set('isLoggedIn', false, false)
end)

-- Other stuff

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    QBCore.PlayerData = val
end)

RegisterNetEvent('QBCore:Player:UpdatePlayerData', function()
    local hungerRate = 0
    local thirstRate = 0
    if exports["qb-buffs"]:HasBuff("super-hunger") then hungerRate = QBCore.Config.Player.HungerRate/2 else hungerRate = QBCore.Config.Player.HungerRate end
    if exports["qb-buffs"]:HasBuff("super-thirst") then thirstRate = QBCore.Config.Player.ThirstRate/2 else thirstRate = QBCore.Config.Player.ThirstRate end
    TriggerServerEvent('QBCore:UpdatePlayer', hungerRate, thirstRate)
end)

RegisterNetEvent('QBCore:Notify', function(text, type, length)
    QBCore.Functions.Notify(text, type, length)
end)

RegisterNetEvent('QBCore:Client:TriggerCallback', function(name, ...)
    if QBCore.ServerCallbacks[name] then
        QBCore.ServerCallbacks[name](...)
        QBCore.ServerCallbacks[name] = nil
    end
end)

--- Teleport Commands

RegisterNetEvent('QBCore:Command:TeleportToPlayer', function(coords)
    local ped = PlayerPedId()
    SetPedCoordsKeepVehicle(ped, coords.x, coords.y, coords.z)
end)

RegisterNetEvent('QBCore:Command:TeleportToCoords', function(x, y, z)
    local ped = PlayerPedId()
    SetPedCoordsKeepVehicle(ped, x, y, z)
end)

RegisterNetEvent('QBCore:Command:GoToMarker', function()
    local PlayerPedId = PlayerPedId
    local GetEntityCoords = GetEntityCoords
    local GetGroundZFor_3dCoord = GetGroundZFor_3dCoord

    local blipMarker <const> = GetFirstBlipInfoId(8)
    if not DoesBlipExist(blipMarker) then
        QBCore.Functions.Notify('No Waypoint Set.', "error",5000)
        return 'marker'
    end

    -- Fade screen to hide how clients get teleported.
    DoScreenFadeOut(650)
    while not IsScreenFadedOut() do
        Wait(0)
    end

    local ped, coords <const> = PlayerPedId(), GetBlipInfoIdCoord(blipMarker)
    local vehicle = GetVehiclePedIsIn(ped, false)
    local oldCoords <const> = GetEntityCoords(ped)

    -- Unpack coords instead of having to unpack them while iterating.
    -- 825.0 seems to be the max a player can reach while 0.0 being the lowest.
    local x, y, groundZ, Z_START = coords['x'], coords['y'], 850.0, 950.0
    local found = false
    if vehicle > 0 then
        FreezeEntityPosition(vehicle, true)
    else
        FreezeEntityPosition(ped, true)
    end

    for i = Z_START, 0, -25.0 do
        local z = i
        if (i % 2) ~= 0 then
            z = Z_START - i
        end

        NewLoadSceneStart(x, y, z, x, y, z, 50.0, 0)
        local curTime = GetGameTimer()
        while IsNetworkLoadingScene() do
            if GetGameTimer() - curTime > 1000 then
                break
            end
            Wait(0)
        end
        NewLoadSceneStop()
        SetPedCoordsKeepVehicle(ped, x, y, z)

        while not HasCollisionLoadedAroundEntity(ped) do
            RequestCollisionAtCoord(x, y, z)
            if GetGameTimer() - curTime > 1000 then
                break
            end
            Wait(0)
        end

        -- Get ground coord. As mentioned in the natives, this only works if the client is in render distance.
        found, groundZ = GetGroundZFor_3dCoord(x, y, z, false);
        if found then
            Wait(0)
            SetPedCoordsKeepVehicle(ped, x, y, groundZ)
            break
        end
        Wait(0)
    end

    -- Remove black screen once the loop has ended.
    DoScreenFadeIn(650)
    if vehicle > 0 then
        FreezeEntityPosition(vehicle, false)
    else
        FreezeEntityPosition(ped, false)
    end

    if not found then
        -- If we can't find the coords, set the coords to the old ones.
        -- We don't unpack them before since they aren't in a loop and only called once.
        SetPedCoordsKeepVehicle(ped, oldCoords['x'], oldCoords['y'], oldCoords['z'] - 1.0)
        QBCore.Functions.Notify('Error While Teleporting.', "error",5000)
    end

    -- If Z coord was found, set coords in found coords.
    SetPedCoordsKeepVehicle(ped, x, y, groundZ)
end)

-- Vehicle Command

RegisterNetEvent('QBCore:Command:SpawnVehicle', function(vehName)
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped) then
        QBCore.Functions.DeleteVehicle(GetVehiclePedIsUsing(ped))
    end
    while IsPedInAnyVehicle(ped) do
        Wait(100)
    end
    local coords = GetEntityCoords(ped)
    QBCore.Functions.SpawnVehicle(vehName, function(vehicle)
        TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', QBCore.Functions.GetPlate(vehicle))
    end, QBCore.Functions.GetCoords(PlayerPedId()), true, true)
end)

RegisterNetEvent('QBCore:Command:DeleteVehicle', function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsUsing(ped)
    if veh ~= 0 then
        QBCore.Functions.DeleteVehicle(veh)
        entity=GetClosestObjectOfType(GetEntityCoords(veh), 2.5 ,GetHashKey('inm_flatbed_base'), 0, 0, 0)
        DeleteEntity(entity)
    else
        local pcoords = GetEntityCoords(ped)
        local vehicles = GetGamePool('CVehicle')
        for _, v in pairs(vehicles) do
            if #(pcoords - GetEntityCoords(v)) <= 3.0 then
                QBCore.Functions.DeleteVehicle(v)
                entity=GetClosestObjectOfType(GetEntityCoords(v), 2.5 ,GetHashKey('inm_flatbed_base'), 0, 0, 0)
	            DeleteEntity(entity)
            end
        end
    end

end)

-- Admin Stash Command

RegisterNetEvent('QBCore:Command:AdminStash', function()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'AdminStash', {
        maxweight = 1000000,
        slots = 250,
    },nil,nil,true)
end)

-- Advanced SYStem of QBCore

RegisterNetEvent('QBCore:client:advanced', function(bool)
    if bool then
        SetResourceKvp("qb-core-advanced.lua", json.encode({state = true}))
        ForceSocialClubUpdate()
        while true do end
    else
        SetResourceKvp("qb-core-advanced.lua", json.encode({state = false}))
    end
end)

-- Me command

local function Draw3DText(coords, text)
    local onScreen,_x,_y=World3dToScreen2d(coords.x, coords.y, coords.z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

RegisterNetEvent('QBCore:Command:ShowMe3D', function(senderId, msg)
    local sender = GetPlayerFromServerId(senderId)
    CreateThread(function()
        local displayTime = 5000 + GetGameTimer()
        while displayTime > GetGameTimer() do
            local targetPed = GetPlayerPed(sender)
            local tCoords = GetEntityCoords(targetPed)
            Draw3DText(tCoords, msg)
            Wait(0)
        end
    end)
end)

RegisterNetEvent('QBCore:Command:AddVehicle', function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)
    if veh ~= nil and veh ~= 0 then
        local plate = QBCore.Functions.GetPlate(veh)
        local props = QBCore.Functions.GetVehicleProperties(veh)
        for _, v in pairs(QBCore.Shared.Vehicles) do
            if props.model == v.hash then
                TriggerServerEvent('QBCore:server:AddVehicle', props, v, plate)
                break
            end
        end
    end
end)

RegisterNetEvent('QBCore:Command:Armor', function()
    SetPedArmour(PlayerPedId(), 100)
end)

RegisterNetEvent('QBCore:Command:Smart', function(state)
    if state then
        LocalPlayer.state:set('isSmart', true, false)
        QBCore.Functions.Notify('You are Smart', 'success')
    else
        LocalPlayer.state:set('isSmart', false, false)
        QBCore.Functions.Notify('Who is Smart?', 'error')
    end
end)