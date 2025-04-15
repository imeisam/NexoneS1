local QBCore = exports['qb-core']:GetCoreObject()

local Jobs = {
    ['police'] = {
        {label = 'Maverick', spawn = 'polas350', livery =5, division = 'air'},
    },
    ['justice'] = {
        {label = 'Frogger', spawn = 'frogger2', livery = 0, division = 'air'},
        {label = 'Supervolito', spawn = 'supervolito2', livery = 0, division = 'air'},
        {label = 'Buzzard', spawn = 'buzzard2', livery = 0, division = 'air'},
    },
    ['ambulance'] = {
        {label = 'EMS', spawn = 'polas350', livery = 0, division = 'air'}
    },
}

local Locations = {
    {
        coords = vector3(-1100.6668701172, -837.03607177734, 38.874565124512),--vpd
        job = true
    },
    {
        coords = vector3(476.52816772461, -1003.1749267578, 45.910820007324),--mrpd
        job = true
    },
    {
        coords = vector3(351.33261108398, -588.23522949219, 74.165580749512),--md
        job = true
    },
    {
        coords = vector3(362.86798095703, -1598.7927246094, 36.949459075928),--doj
        job = true
    },
   
    
}

CreateThread(function()
    for k,v in ipairs(Locations) do
        local Zones = {}
        Zones[1] = BoxZone:Create(v.coords, 8.5, 8.5, {
            name = k..'_helistation',
            debugPoly = false,
            heading = 0,
            minZ = v.coords.z - 2,
            maxZ = v.coords.z + 3
        })
        local inZone = false
        local Combo = ComboZone:Create(Zones, {name = k..'_helistation', debugPoly = false})
        Combo:onPlayerInOut(function(isPointInside)
            if isPointInside then
                inZone = true
                if LocalPlayer.state.isLoggedIn then
                    if v.job then
                        if Jobs[QBCore.Functions.GetPlayerData().job.name] then
                            exports['qb-core']:DrawText('Helicopter', 'left','E')
                            CreateThread(function()
                                while inZone do
                                    Wait(10)
                                    if IsControlJustPressed(0, 38) then
                                        inZone = false
                                        exports['qb-core']:HideText()
                                        if IsPedInAnyVehicle(PlayerPedId(), false) then
                                            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                                            local vehmodel = GetEntityModel(veh)
                                            if GetPedInVehicleSeat(veh, -1) == PlayerPedId() and (IsThisModelAHeli(vehmodel) or IsThisModelAPlane(vehmodel)) then
                                                local menu = {
                                                    {
                                                        header = 'Repair/Refuel',
                                                        params = {
                                                            isAction = true,
                                                            event = function()
                                                                local veh = GetVehiclePedIsIn(PlayerPedId())
                                                                FreezeEntityPosition(veh, true)
                                                                QBCore.Functions.Progressbar("repair_heli", "Repairing..", math.random(10000, 15000), false, true, {
                                                                    disableMovement = true,
                                                                    disableCarMovement = true,
                                                                    disableMouse = false,
                                                                    disableCombat = true,
                                                                }, {}, {}, {}, function()
                                                                    TriggerEvent('iens:repaira')
                                                                    Wait(500)
                                                                    exports['qb-fuel']:SetFuel(veh, 100.0)
                                                                    FreezeEntityPosition(veh, false)
                                                                end, function()
                                                                    FreezeEntityPosition(veh, false)
                                                                end)
                                                            end,
                                                        }
                                                    },
                                                    {
                                                        header = 'Delete',
                                                        params = {
                                                            isAction = true,
                                                            event = function()
                                                                local veh = GetVehiclePedIsIn(PlayerPedId())
                                                                FreezeEntityPosition(veh, true)
                                                                QBCore.Functions.Progressbar("del_heli", "Deleting Helicopter ...", math.random(10000, 15000), false, true, {
                                                                    disableMovement = true,
                                                                    disableCarMovement = true,
                                                                    disableMouse = false,
                                                                    disableCombat = true,
                                                                }, {}, {}, {}, function()
                                                                    QBCore.Functions.DeleteVehicle(veh)
                                                                end, function()
                                                                    FreezeEntityPosition(veh, false)
                                                                end)
                                                            end,
                                                        }
                                                    }
                                                }
                                                exports['qb-menu']:openMenu(menu)
                                            end
                                        else
                                            local menu = {}
                                            for k,v in ipairs(Jobs[QBCore.Functions.GetPlayerData().job.name]) do
                                                local hasAccess = false
                                                if v.division and not QBCore.Functions.GetPlayerData().job.isboss and not QBCore.Functions.HasDivision('hc') then
                                                    if QBCore.Functions.HasDivision(v.division) then
                                                        hasAccess = true
                                                    end
                                                else
                                                    hasAccess = true
                                                end
                                                if hasAccess then
                                                    menu[#menu+1] = {
                                                        header = v.label,
                                                        params = {
                                                            isAction = true,
                                                            args = v,
                                                            event = function(value)
                                                                local coords = GetEntityCoords(PlayerPedId())
                                                                local heading = GetEntityHeading(PlayerPedId())
                                                                QBCore.Functions.Progressbar("spawn_heli", "Spawning Helicopter ...", math.random(20000, 25000), false, true, {
                                                                    disableMovement = true,
                                                                    disableCarMovement = true,
                                                                    disableMouse = false,
                                                                    disableCombat = true,
                                                                }, {}, {}, {}, function()
                                                                    QBCore.Functions.SpawnVehicle(value.spawn, function(veh)
                                                                        SetVehicleLivery(veh , value.livery)
                                                                        SetVehicleMod(veh, 0, 48)
                                                                        SetEntityHeading(veh, heading)
                                                                        exports['qb-fuel']:SetFuel(veh, 100.0)
                                                                        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                                                                        TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', QBCore.Functions.GetPlate(veh))
                                                                        SetVehicleEngineOn(veh, true, true)
                                                                    end, coords, true)
                                                                end, function()
                                                                    QBCore.Functions.Notify("Canceled..", "error")
                                                                end)
                                                            end,
                                                        }
                                                    }
                                                end
                                            end
                                            exports['qb-menu']:openMenu(menu)
                                        end
                                    end
                                end
                            end)
                        end
                    else
                        exports['qb-core']:DrawText('Repair & Refuel', 'left','E')
                        CreateThread(function()
                            while inZone do
                                Wait(10)
                                if IsPedInAnyVehicle(PlayerPedId(), false) then
                                    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                                    local vehmodel = GetEntityModel(veh)
                                    if GetPedInVehicleSeat(veh, -1) == PlayerPedId() and (IsThisModelAHeli(vehmodel) or IsThisModelAPlane(vehmodel) or IsThisModelABoat(vehmodel)) then
                                        if IsControlJustPressed(0, 38) then
                                            inZone = false
                                            exports['qb-core']:HideText()
                                            FreezeEntityPosition(veh, true)
                                            QBCore.Functions.Progressbar("repair_heli", "Repairing..", math.random(20000, 30000), false, true, {
                                                disableMovement = true,
                                                disableCarMovement = true,
                                                disableMouse = false,
                                                disableCombat = true,
                                            }, {}, {}, {}, function()
                                                TriggerEvent('iens:repaira')
                                                Wait(500)
                                                exports['qb-fuel']:SetFuel(veh, 100.0)
                                                FreezeEntityPosition(veh, false)
                                            end, function()
                                                FreezeEntityPosition(veh, false)
                                            end)
                                        end
                                    end
                                end
                            end
                        end)
                    end
                end
            else
                inZone = false
                exports['qb-core']:HideText()
            end
        end)
    end
end)