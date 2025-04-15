local crouched = false
local isPressing = false

local function disableAction()
    Citizen.CreateThread(function()
        while isPressing do
            Citizen.Wait(5)
            DisableControlAction(0,36,true)
        end
    end)
end

AddEventHandler("onKeyDown", function(key)
	if key == "lcontrol" then
        isPressing = true
        disableAction()
		local ped = PlayerPedId()
		if IsPedOnFoot(ped) and not IsPedJumping(ped) and not IsPedFalling(ped) and not IsPedSittingInAnyVehicle(ped) and not IsPedSwimming(ped) and not IsPedSwimmingUnderWater(ped) then
            RequestAnimSet( "move_ped_crouched" )
            while not HasAnimSetLoaded("move_ped_crouched") do 
                Citizen.Wait(100)
            end 
            if crouched then 
                crouched = false
                ResetPedMovementClipset(ped, 0)
                ResetPedWeaponMovementClipset(ped)
                ResetPedStrafeClipset(ped)
                Wait(100)
                TriggerEvent('animation:ResettoOldWalk')
            elseif crouched == false then
                crouched = true 
                SetPedMovementClipset(ped, "move_ped_crouched", 0.25)
            end
		end
    end
end)

AddEventHandler("onKeyUP", function(key)
    if key == "lcontrol" and isPressing then
        isPressing = false
	end
end)