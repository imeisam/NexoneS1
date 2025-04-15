local aiming = false
local show = false

local function Armed()
    CreateThread(function()
        while aiming do
            Wait(500)
            if IsPlayerFreeAiming(PlayerId()) then
                if not show then
                    show = true
                    SendNUIMessage("xhairShow")
                end
            else
                if show then
                    show = false
                    SendNUIMessage("xhairHide")
                end
            end
        end
    end)
end

RegisterNetEvent('weapons:client:SetCurrentWeapon', function(weapon)
    if weapon then
        if not aiming then
            aiming = true
            Armed()
        end
    else
        if aiming then
            aiming = false
            show = false
            SendNUIMessage("xhairHide")
        end
    end
end)