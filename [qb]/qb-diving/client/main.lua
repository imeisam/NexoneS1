local QBCore = exports['qb-core']:GetCoreObject()
local currentGear = {
    mask = 0,
    tank = 0,
    oxygen = 0,
    enabled = false
}

-- Functions

local function deleteGear()
	if currentGear.mask ~= 0 then
        DetachEntity(currentGear.mask, 0, 1)
        DeleteEntity(currentGear.mask)
		currentGear.mask = 0
    end
	if currentGear.tank ~= 0 then
        DetachEntity(currentGear.tank, 0, 1)
        DeleteEntity(currentGear.tank)
		currentGear.tank = 0
	end
    currentGear.oxygen = 0
end

local function gearAnim()
    RequestAnimDict("clothingshirt")
    while not HasAnimDictLoaded("clothingshirt") do
        Wait(0)
    end
	TaskPlayAnim(PlayerPedId(), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end

-- Events

RegisterNetEvent('qb-diving:client:UseGear', function(bool)
    local ped = PlayerPedId()
    if bool then
        if not IsPedSwimming(ped) and not IsPedInAnyVehicle(ped) then
            gearAnim()
            QBCore.Functions.TriggerCallback('qb-diving:server:RemoveGear', function(result, oxygen)
                if result then
                    QBCore.Functions.Progressbar("equip_gear", Lang:t("info.put_suit"), 5000, false, true, {}, {}, {}, {}, function() -- Done
                        deleteGear()
                        local maskModel = `p_d_scuba_mask_s`
                        local tankModel = `p_s_scuba_tank_s`
                        RequestModel(tankModel)
                        while not HasModelLoaded(tankModel) do
                            Wait(0)
                        end
                        currentGear.tank = CreateObject(tankModel, 1.0, 1.0, 1.0, 1, 1, 0)
                        local bone1 = GetPedBoneIndex(ped, 24818)
                        AttachEntityToEntity(currentGear.tank, ped, bone1, -0.25, -0.25, 0.0, 180.0, 90.0, 0.0, 1, 1, 0, 0, 2, 1)
                        currentGear.oxygen = oxygen
                        RequestModel(maskModel)
                        while not HasModelLoaded(maskModel) do
                            Wait(0)
                        end
                        currentGear.mask = CreateObject(maskModel, 1.0, 1.0, 1.0, 1, 1, 0)
                        local bone2 = GetPedBoneIndex(ped, 12844)
                        AttachEntityToEntity(currentGear.mask, ped, bone2, 0.0, 0.0, 0.0, 180.0, 90.0, 0.0, 1, 1, 0, 0, 2, 1)
                        SetEnableScuba(ped, true)
                        SetPedMaxTimeUnderwater(ped, 2000.00)
                        currentGear.enabled = true
                        ClearPedTasks(ped)
                        TriggerEvent('chatMessage', "SYSTEM", "error", Lang:t("error.take_off"))
                        Citizen.CreateThread(function()
                            while currentGear.enabled do
                                if IsPedSwimmingUnderWater(PlayerPedId()) then
                                    currentGear.oxygen = currentGear.oxygen-1
                                    if currentGear.oxygen == 60 then
                                        QBCore.Functions.Notify(Lang:t("warning.oxygen_one_minute"), 'error')
                                    elseif currentGear.oxygen == 0 then
                                        QBCore.Functions.Notify(Lang:t("warning.oxygen_running_out"), 'error')
                                        SetPedMaxTimeUnderwater(ped, 50.00)
                                    elseif currentGear.oxygen == -40 then
                                        deleteGear()
                                        SetEnableScuba(ped, false)
                                        SetPedMaxTimeUnderwater(ped, 1.00)
                                        currentGear.enabled = false
                                    end
                                end
                                Wait(1000)
                            end
                        end)
                        Citizen.CreateThread(function()
                            while currentGear.enabled do
                                if not IsPedSwimming(PlayerPedId()) and not IsPedSwimmingUnderWater(PlayerPedId()) then
                                    DisableControlAction(0, 21)
                                    DisableControlAction(0, 22)
                                end
                                Wait(5)
                            end
                        end)
                    end)
                end
            end)
        else
            QBCore.Functions.Notify(Lang:t("error.not_standing_up"), 'error')
        end
    else
        if currentGear.enabled then
            gearAnim()
            QBCore.Functions.Progressbar("remove_gear", Lang:t("info.pullout_suit"), 5000, false, true, {}, {}, {}, {}, function() -- Done
                SetEnableScuba(ped, false)
                SetPedMaxTimeUnderwater(ped, 50.00)
                currentGear.enabled = false
                TriggerServerEvent('qb-diving:server:GiveBackGear', currentGear.oxygen)
                ClearPedTasks(ped)
                deleteGear()
                QBCore.Functions.Notify(Lang:t("success.took_out"))
            end)
        else
            QBCore.Functions.Notify(Lang:t("error.not_wearing"), 'error')
        end
    end
end)