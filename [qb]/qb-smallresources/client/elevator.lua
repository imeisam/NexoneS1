local Locations = {
    
    ["lsnews"] = {
        {
            ["name"] = "Floor 1",
            ["teleport"] =vector4(-572.10906982422, -923.82843017578, 30.322061538696, 92.433906555176),
            ["button"] = vector3(-571.63397216797, -922.77288818359, 30.322086334229)
        },
        {
            ["name"] = "Ground",
            ["teleport"] =vector4(-575.97796630859, -920.23681640625, 23.777153015137, 93.510444641113),
            ["button"] = vector3(-575.61187744141, -919.22045898438, 23.777153015137)
        },
    },
    ["MD"] = {
        {
            ["name"] = "Roof",
            ["teleport"] = vector4(335.03, -1432.32, 46.51, 141.86),
            ["button"] = vector3(336.53, -1432.3, 46.51)
        },
        {
            ["name"] = "Reception",
            ["teleport"] = vector4(360.27, -1410.49, 32.43, 142.17),
            ["button"] = vector3(359.97, -1409.6, 32.43)
        },
    },
    ["FIB"] = {
        {
            ["name"] = "Parking",
            ["teleport"] = vector4(110.33, -735.6, 33.13, 338.88),
            ["button"] = vector3(109.94, -736.38, 33.13),
            ["job"] = {["police"] = 0, ["justice"] = 0}
        },
        {
            ["name"] = "Lobby",
            ["teleport"] = vector4(136.18, -761.65, 45.75, 162.2),
            ["button"] = vector3(136.65, -763.08, 45.75)
        },
        {
            ["name"] = "Office",
            ["teleport"] = vector4(136.15, -761.73, 242.15, 166.44),
            ["button"] = vector3(136.7, -763.07, 242.15)
        },
    },
    ["USM"] = {
        {
            ["name"] = "Ground",
            ["teleport"] = vector4(353.31494140625, -1593.2554931641, 29.292415618896, 50.049766540527),
            ["button"] = vector3(353.88012695312, -1593.7846679688, 29.292415618896),
            ["job"] = {["police"] = 0, ["justice"] = 0}
        },
        {
            ["name"] = "Roof",
            ["teleport"] = vector4(378.3401184082, -1601.357421875, 36.94934463501, 42.779769897461),
            ["button"] = vector3(379.02105712891, -1601.9500732422, 36.94934463501),
            ["job"] = {["police"] = 0, ["justice"] = 0}
        },
    },
    ["pillbox"] = {
        {
            ["name"] = "Roof",
            ["teleport"] =vector4(338.64303588867, -583.86053466797, 74.165580749512, 245.08102416992),
            ["button"] = vector3(338.56433105469, -583.796875, 74.165580749512),
            ["job"] = {["police"] = 0,["ambulance"] = 0, ["justice"] = 0, ["govermet"] = 0}
        },
        {
            ["name"] = "Ground",
            ["teleport"] =vector4(336.29156494141, -592.62060546875, 43.268440246582, 67.894874572754),
            ["button"] = vector3(335.12896728516, -591.31860351562, 43.268440246582),
            ["job"] = {["police"] = 0,["ambulance"] = 0, ["justice"] = 0, ["govermet"] = 0}
        },
        {
            ["name"] = "under Ground",
            ["teleport"] =vector4(323.33486938477, -583.37609863281, 28.848226547241, 248.42782592773),
            ["button"] = vector3(324.1442565918, -584.46960449219, 28.848222732544),
            ["job"] = {["police"] = 0, ["ambulance"] = 0,["justice"] = 0, ["govermet"] = 0}
        },
       
    },
    ["cityhall"] = {
        {
            ["name"] = "Lobby",
            ["teleport"] = vector4(334.55, -1652.65, 32.54, 140.35),
            ["button"] = vector3(332.82299804688, -1653.3452148438, 32.536079406738)
        },
        {
            ["name"] = "Floor 1",
            ["teleport"] = vector4(334.64, -1652.8, 38.5, 139.69),
            ["button"] = vector3(332.8747253418, -1653.2152099609, 38.501583099365)
        },
        {
            ["name"] = "Floor 2",
            ["teleport"] = vector4(334.60443115234, -1652.5771484375, 47.246215820313, 140.22450256348),
            ["button"] = vector3(332.63397216797, -1653.3034667969, 47.246215820313)
        },
        {
            ["name"] = "Floor 3",
            ["teleport"] = vector4(334.66009521484, -1652.5482177734, 54.596576690674, 140.5744934082),
            ["button"] = vector3(332.73, -1653.31, 54.6)
        },
    },
    ["mrpd"] = {
        {
            ["name"] = "Floor 3",
            ["teleport"] =vector4(464.72, -988.28, 45.22, 272.74),
            ["button"] = vector3(466.15, -989.25, 45.22),
            ["job"] = {["police"] = 0, ["justice"] = 0}
        },
        {
            ["name"] = "Floor 2",
            ["teleport"] =vector4(464.91, -988.46, 40.2, 267.44),
            ["button"] = vector3(466.15, -989.25, 40.21),
            ["job"] = {["police"] = 0, ["justice"] = 0}
        },
        {
            ["name"] = "Ground",
            ["teleport"] =vector4(464.91, -988.46, 30.69, 281.22),
            ["button"] = vector3(466.15, -989.25, 30.69),
            ["job"] = {["police"] = 0, ["justice"] = 0}
        },
        {
            ["name"] = "Floor -1",
            ["teleport"] = vector4(464.86, -988.46, 26.41, 267.28),
            ["button"] = vector3(466.16, -989.25, 26.41),
             ["job"] = {["police"] = 0, ["justice"] = 0},
        },
    },
    ["roofgardenmainpark"] = {
        {
            ["name"] = "Ground",
            ["teleport"] =vector4(271.62594604492, -1102.8701171875, 29.448884963989, 277.56799316406),
            ["button"] =vector3(271.67031860352, -1102.7506103516, 29.44891166687),
        },
        {
            ["name"] = "Roof",
            ["teleport"] =vector4(271.6545715332, -1102.7749023438, 72.187614440918, 270.81872558594),
            ["button"] = vector3(271.29315185547, -1102.6916503906, 72.172439575195),
        },
    },
}

local QBCore = exports['qb-core']:GetCoreObject()

for k, v in pairs(Locations) do
    for i, location in pairs(v) do
        exports['qb-target']:AddBoxZone(k..i, location.button, 1.0, 1.0, {
            name = k..i,
            heading = 0,
            debugPoly = false,
            minZ = location.button.z-1,
            maxZ = location.button.z+1,
        }, {
            options = {
                {
                    label = "Elevator",
                    icon = 'fa fa-clipboard',
                    action = function()
                        TriggerEvent("qb-elevator:client:showElevatorMenu", {location=k,index=i})
                    end,
                    canInteract = function()
                        if location.div then
                            return QBCore.Functions.HasDivision(location.div)
                        end
                        return true
                    end,
                    job = location.job,
                },
            },
            distance = 2
        })
    end
end

RegisterNetEvent('qb-elevator:client:showElevatorMenu', function(data)
    local Locations = Locations[data['location']]
    local Elv = {{
        header = "Elevator",
        isMenuHeader = true,
    },}
    for i, v in pairs(Locations) do
        local txt =""
        local isDisable = false
        if i == data['index'] then
            isDisable=true
        end
        local tempData= {
            header = v.name,
            disabled = isDisable,
			params = {
                isServer = false,
                event = "qb-elevator:client:teleportTo",
                args = {
                    loc = v['teleport'],
                }
            }
        }
        table.insert(Elv, tempData)
    end
    exports['qb-menu']:openMenu(Elv)
end)

RegisterNetEvent('qb-elevator:client:teleportTo', function(data)
    local ped = PlayerPedId()
    if not IsPedInAnyVehicle(ped) then
        QBCore.Functions.Progressbar("Call_The_Lift", "Wait for Elevator", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@apt_trans@elevator",
            anim = "elev_1",
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(ped, "anim@apt_trans@elevator", "elev_1", 1.0)
            DoScreenFadeOut(500)
            Wait(1000)
            SetEntityCoords(ped, data.loc.x, data.loc.y, data.loc.z, 0, 0, 0, false)
            SetEntityHeading(ped, data.loc.w)
            Wait(1000)
            TriggerEvent('police:client:fixElevator')
            DoScreenFadeIn(600)
        end, function()
            StopAnimTask(ped, "anim@apt_trans@elevator", "elev_1", 1.0)
        end)
    end
end)