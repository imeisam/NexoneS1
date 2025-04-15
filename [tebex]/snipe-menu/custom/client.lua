RegisterNUICallback("clearall-chat", function(_, cb)
    TriggerServerEvent('admin:clearallChat')
end)

RegisterNUICallback("customgetplayers", function(_, cb)
    local p = promise.new()
    TriggerCallback("snipe-menu:server:fetchPlayerListCustom", function(data)
        p:resolve(data)
    end)
    local data = Citizen.Await(p)
    cb(data)
end)

RegisterNUICallback("killplayer", function(data, cb)
    TriggerServerEvent('admin:killPlayer', data.searchableDropDownkey.id)
    cb("ok")
end)

RegisterNUICallback("setwaypoint", function(data, cb)
    TriggerServerEvent('admin:setwaypoint', data.searchableDropDownkey.id)
    cb("ok")
end)

RegisterNetEvent('admin:setwaypoint', function(sentData)
    SetNewWaypoint(sentData.x, sentData.y)
end)

RegisterNUICallback("scrennshot", function(data, cb)
    TriggerServerEvent('admin:scrennshot', data.searchableDropDownkey.id)
    cb("ok")
end)

RegisterNetEvent('admin:scrennshot', function(screenwebhook)
	exports['screenshot-basic']:requestScreenshotUpload(screenwebhook, "files[]", function(data)
	end)
end)

RegisterNUICallback("putinvehicle", function(_, cb)
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("snipe-menu:server:PutPlayerInVehicle", playerId)
        cb('ok')
    else
        TriggerServerEvent("snipe-menu:server:PutPlayerInVehicle", 0)
        cb('ok')
    end
end)

RegisterNetEvent('snipe-menu:client:PutInVehicle', function()
    local ped = PlayerPedId()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    if DoesEntityExist(vehicle) then
        for i = GetVehicleMaxNumberOfPassengers(vehicle), 0, -1 do
            if IsVehicleSeatFree(vehicle, i) then
                TriggerEvent('hospital:client:isEscorted', false)
                ClearPedTasks(ped)
                DetachEntity(ped, true, false)
                Wait(100)
                SetPedIntoVehicle(ped, vehicle, i)
                return
            end
        end
    end
end)

RegisterNUICallback("deadstyle", function(_, cb)
    TriggerEvent("qb-ambulancejob:client:deadtoggle")
    cb('ok')
end)

local function LoadPlayerModel(skin)
    RequestModel(skin)
    while not HasModelLoaded(skin) do
      Wait(0)
    end
end

RegisterNetEvent('admin:client:SetModel', function(skin)
    local ped = PlayerPedId()
    local model = GetHashKey(skin)
    SetEntityInvincible(ped, true)
    if IsModelInCdimage(model) and IsModelValid(model) then
        LoadPlayerModel(model)
        SetPlayerModel(PlayerId(), model)
		SetModelAsNoLongerNeeded(model)
	end
	SetEntityInvincible(ped, false)
end)