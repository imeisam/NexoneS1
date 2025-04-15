local inVeh = false

local function EnableShuff()
    while inVeh do
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped)
        if IsPedInAnyVehicle(ped, false) then
            if GetPedInVehicleSeat(veh, false, 0) == ped then
                if GetIsTaskActive(ped, 165) then
                    SetPedIntoVehicle(ped, veh, 0)
                    SetPedConfigFlag(ped, 184, true)
                end
            end
        end
        Wait(5)
    end
end

AddEventHandler("baseevents:enteredVehicle", function()
    inVeh = true
    EnableShuff()
end)

AddEventHandler("baseevents:leftVehicle", function()
    inVeh = false
end)