local QBCore = exports['qb-core']:GetCoreObject()
config={}
CreateThread(function()
    QBCore.Functions.TriggerCallback("nxo-handeling:server:getdata", function(data)
       config=data
    end)
end)

RegisterNetEvent('baseevents:enteredVehicle', function( CurrentVehicle, CurrentSeat, currentName, currentClass, currentModel)
    local ped = PlayerPedId()
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(CurrentVehicle)):lower()
    local pedseat = GetPedInVehicleSeat(CurrentVehicle,-1)
    if config[model] then
        if pedseat==ped then
            SetVehicleHandlingFloat(CurrentVehicle, 'CHandlingData', 'fBrakeForce', config[model].fBrakeForce)
            SetVehicleHandlingField(CurrentVehicle, 'CHandlingData', 'fInitialDriveForce',config[model].fInitialDriveForce)
            SetVehicleHandlingField(CurrentVehicle, 'CHandlingData', 'fDriveInertia',config[model].fDriveInertia)
        end
    end
	
end)