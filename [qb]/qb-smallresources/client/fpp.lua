local shot = false
local check = false
local check2 = false
local count = 0
local hasWeapon = false

local function FPPON()
	CreateThread(function()
		while hasWeapon do
			Wait(1)
			if IsPedDoingDriveby(PlayerPedId()) or (IsPedInAnyVehicle(PlayerPedId()) and IsPlayerFreeAiming(PlayerId())) then
				if GetFollowPedCamViewMode() == 4 and check == false then
					check = false
				else
					SetFollowVehicleCamViewMode(4)
					check = true
				end
			else
				if check == true then
					SetFollowVehicleCamViewMode(1)
					check = false
				end
			end
		end
	end)
	CreateThread(function()
		while hasWeapon do
			Wait(1)
			if IsPedShooting(PlayerPedId()) and shot == false and GetFollowPedCamViewMode() ~= 4 then
				check2 = true
				shot = true
				SetFollowVehicleCamViewMode(4)
			end
			if IsPedShooting(PlayerPedId()) and shot == true and GetFollowPedCamViewMode() == 4 then
				count = 0
			end
			if not IsPedShooting(PlayerPedId()) and shot == true then
				count = count + 1
			end
			if not IsPedShooting(PlayerPedId()) and shot == true then
				if not IsPedShooting(PlayerPedId()) and shot == true and count > 20 then
					if check2 == true then
						check2 = false
						shot = false
						SetFollowVehicleCamViewMode(1)
					end
				end
			end
		end
	end)
end

RegisterNetEvent('weapons:client:SetCurrentWeapon', function(weapon)
    if weapon then
        if not hasWeapon then
            hasWeapon = true
			if not LocalPlayer.state.isSmart then
				FPPON()
			end
        end
    else
        if hasWeapon then
            hasWeapon = false
        end
    end
end)

CreateThread(function()
	while true do
		Wait(10)
		if IsPedInAnyVehicle(PlayerPedId(),false) then
			SetUserRadioControlEnabled(false)
			SetVehRadioStation(GetVehiclePedIsIn(PlayerPedId(),true), "OFF")
			DisableControlAction(0, 14, true)
			DisableControlAction(0, 15, true)
			DisableControlAction(0, 16, true)
			DisableControlAction(0, 17, true)
			DisableControlAction(0, 99, true)
			DisableControlAction(0, 100, true)
			DisableControlAction(0, 261, true)
			DisableControlAction(0, 262, true)
		else
			Wait(500)
		end
	end
end)


CreateThread(function()
	while true do
		if (not IsPedInAnyVehicle(PlayerPedId(),false)) then
			Wait(4)
			if IsPlayerFreeAiming(PlayerPedId()) then
				DisableControlAction(0, 22, 1)
			else
				Wait(100)
			end
		else
			Wait(500)
		end
	end
end)