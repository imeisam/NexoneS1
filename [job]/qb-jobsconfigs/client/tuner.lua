QBCore = exports['qb-core']:GetCoreObject()
local tunerrentveh={
    'penumbra','gbdominatorgsx','ardent','gbschwartzers','gbsentinelgts',
}
local spawncoord=vector4(937.2578125, -1025.5101318359, 40.36877822876, 272.0632019043)
CreateThread(function()
    local model = GetHashKey('mp_f_bennymech_01')
    RequestModel(model)
    while not HasModelLoaded(model) do 
        Wait(10)
    end
    local ped = CreatePed(0,model,941.55603027344, -1021.3300170898, 39.972236633301, 280.16537475586, false, false)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_LEANING', 0, true)

    exports['qb-target']:AddTargetEntity(ped, {
        options = {
            {
                type = "client",
                event = "qb-jobs:client:tunergetrentvehicle",
                icon = "fas fa-vehicle",
                label = "Get Rental Race Car",
                job = {['tuner']=3},
            },
        },
        distance = 2.5
    })
end)

RegisterNetEvent('qb-jobs:client:tunergetrentvehicle', function(bannername)
    local op={}

    if IsAnyVehicleNearPoint(spawncoord.x, spawncoord.y, spawncoord.z, 3.0) then
        QBCore.Functions.Notify("Vehicle Spot is occupied", "error", 4500)
        return
    end

    for k, v in pairs(tunerrentveh) do
      op[#op+1]={text  = QBCore.Shared.Vehicles[v].name, value = v}
    end

    local dialog = exports['qb-input']:ShowInput({
        header = "Get Rental Vehicle Race",
        submitText = "Get Vehicle",
        inputs ={
            {
                type = 'number',
                isRequired = true,
                name = 'stateid',
                text = 'State ID'
            },
           {
                text = "Vehicle",
                name = "vehicle", 
                type = "select", 
                options =op,
            }
        },
    })
  
    if dialog then
        TriggerServerEvent("qb-jobs:server:rentvehicle",dialog.vehicle,dialog.stateid)
    end
end)

RegisterNetEvent('qb-jobs:client:rentvehicle', function(veh,stateid,plate)
    print(veh,stateid,plate)
    QBCore.Functions.SpawnVehicle(veh, function(vehicle)
        SetVehicleNumberPlateText(vehicle, plate)
        SetEntityHeading(vehicle, spawncoord.w)
        TriggerServerEvent("qb-vehiclekeys:server:AcquireVehicleKeys", plate)
        SetVehicleDirtLevel(vehicle, 0.0)
        local modTypes = {11, 12, 13, 15, 16}
        SetVehicleModKit(vehicle, 0)
        for _, modType in ipairs(modTypes) do
            local maxMod = GetNumVehicleMods(vehicle, modType) - 1
            SetVehicleMod(vehicle, modType, maxMod, false)
        end
        ToggleVehicleMod(vehicle, 18, true)

        exports['qb-fuel']:SetFuel(vehicle, 100.0)
    end, spawncoord, true)
end)