Config = {
    ServerCallbacks = {}, -- Don't edit or change
    AutoDatabaseCreator = false, -- If you are starting the script for the first time, make this true and restart the script, after restarting, make this false otherwise you will get an error.
    TestDriveTime = 120000, -- Seconds 600000
    TeleportBackWhenTestFinishes = true, -- If false destroys the test vehicle's engine and sets it unusable again
    WarpPedToTestVehicle = false, -- If you activate it, a player will be automatically teleported to the driver's seat of a test vehicle when they pick it up.
    SalesShare = 10, -- The player making the sale receives a share of the entered amount from the sale.
    EnableSocietyAccount = true, -- Activate/deactivate management bank accounts
    VehicleShops = {
        {   
            shopname="pdm",
            ClearAreaOfNPCVehicles = true, -- If true script deletes default spawned NPC cars around the vehicle shop
            Management = {
                Enable = true,
                Job = "cardealer"
            },
            EnableStocks = true,
            AllowedCategories = {"compacts", "coupes", "Sports", "Cycles", "Motorcycles", "super", "muscle", "Vans", "SportsClassics", "utility", "Off-Road", "suvs", "sedans"},
            Coords = {
                ShowroomVehicles = vector4(-41.72537612915, -1667.30859375, 29.013441085815, 265.61517333984),
                BoughtVehicles =  vector4(-28.935346603394, -1649.4888916016, 28.808927536011, 49.50186920166),
                TestVehicles = vector4(-28.935346603394, -1649.4888916016, 28.808927536011, 49.50186920166),
                SellingPoint = vector3(-16.748506546021, -1653.4582519531, 29.365490722656)
            },
            Ped = {
                Coords = vector3(-34.48, -1666.54, 29.49)
            },
            ShowroomVehicles = {
                {coords = vector4(-23.72211265564, -1644.1153564453, 28.888875961304, 192.35095214844)},
                {coords =vector4(-33.03279876709, -1657.0511474609, 28.888671875, 189.23600769043)},
                {coords = vector4(-37.134670257568, -1660.8050537109, 28.888780593872, 188.85852050781)},
            },
            Blip = {
                Enable = false,
                coords =vector3(-23.953079223633, -1653.1247558594, 29.491344451904),
                sprite = 227,
                color = 3,
                scale = 0.8,
                text = "PDM"
            },
            Interaction = {
                Target = {
                    Enable = true,
                    Distance = 2.0,
                    Label = "Open Showroom",
                    Icon = "fa-solid fa-car",
                    Label2 = "Open Management",
                    Icon2 = "fa-solid fa-car"
                },
                Text = {
                    Enable = false,
                    Distance = 3.0,
                    Label = "[E] Open Showroom | [G] Open Management"
                },
                DrawText = {
                    Enable = false,
                    Distance = 3.0,
                    Show = function()
                        exports["qb-core"]:DrawText("Contact", "left")
                    end,
                    Hide = function()
                        exports["qb-core"]:HideText()
                    end
                }
            }
        },
        {   
            shopname="medic",
            ClearAreaOfNPCVehicles = true, -- If true script deletes default spawned NPC cars around the vehicle shop
            Testdrive=false,
            buyinhtml=true,
            Management = {
                Enable = true,
                Job = "ambulance"
            },
            EnableStocks = false,
            AllowedCategories = {"Emergency"},
            Coords = {
                ShowroomVehicles =vector4(-47.162590026855, -1098.9512939453, 25.422355651855, 169.38456726074),
                BoughtVehicles= vector4(-47.2, -1081.12, 26.73, 74.89),
                TestVehicles = vector4(-28.935346603394, -1649.4888916016, 28.808927536011, 49.50186920166),
                SellingPoint = vector3(-16.748506546021, -1653.4582519531, 29.365490722656)
            },
            Ped = {
                Coords = vector3(-55.647891998291, -1097.3215332031, 26.422323226929),
            },
            ShowroomVehicles = {
                {coords = vector4(-55.647891998291, -1097.3215332031, 26.422323226929, 28.235246658325),},
            },
            Blip = {
                Enable = false,
                coords =vector3(-23.953079223633, -1653.1247558594, 29.491344451904),
                sprite = 227,
                color = 3,
                scale = 0.8,
                text = "Emergency Shop"
            },
            Interaction = {
                Target = {
                    Enable = true,
                    Distance = 2.0,
                    Label = "Open Showroom",
                    Icon = "fa-solid fa-car",
                    Label2 = "Open Management",
                    Icon2 = "fa-solid fa-car"
                },
                Text = {
                    Enable = false,
                    Distance = 3.0,
                    Label = "[E] Open Showroom | [G] Open Management"
                },
                DrawText = {
                    Enable = false,
                    Distance = 3.0,
                    Show = function()
                        exports["qb-core"]:DrawText("Contact", "left")
                    end,
                    Hide = function()
                        exports["qb-core"]:HideText()
                    end
                }
            }
        },
        {   
            shopname="police",
            ClearAreaOfNPCVehicles = true, -- If true script deletes default spawned NPC cars around the vehicle shop
            Testdrive=false,
            buyinhtml=true,
            Management = {
                Enable = true,
                Job = "police"
            },
            EnableStocks = false,
            AllowedCategories = {"Emergency"},
            Coords = {
                ShowroomVehicles =vector4(-47.162590026855, -1098.9512939453, 25.422355651855, 169.38456726074),
                BoughtVehicles= vector4(-47.2, -1081.12, 26.73, 74.89),
                TestVehicles = vector4(-28.935346603394, -1649.4888916016, 28.808927536011, 49.50186920166),
                SellingPoint = vector3(-16.748506546021, -1653.4582519531, 29.365490722656)
            },
            Ped = {
                Coords = vector3(-55.647891998291, -1097.3215332031, 26.422323226929),
            },
            ShowroomVehicles = {
                {coords = vector4(-55.647891998291, -1097.3215332031, 26.422323226929, 28.235246658325),},
            },
            Blip = {
                Enable = false,
                coords =vector3(-23.953079223633, -1653.1247558594, 29.491344451904),
                sprite = 227,
                color = 3,
                scale = 0.8,
                text = "Police Shop"
            },
            Interaction = {
                Target = {
                    Enable = true,
                    Distance = 2.0,
                    Label = "Open Showroom",
                    Icon = "fa-solid fa-car",
                    Label2 = "Open Management",
                    Icon2 = "fa-solid fa-car"
                },
                Text = {
                    Enable = false,
                    Distance = 3.0,
                    Label = "[E] Open Showroom | [G] Open Management"
                },
                DrawText = {
                    Enable = false,
                    Distance = 3.0,
                    Show = function()
                        exports["qb-core"]:DrawText("Contact", "left")
                    end,
                    Hide = function()
                        exports["qb-core"]:HideText()
                    end
                }
            }
        },
        {   
            shopname="police",
            ClearAreaOfNPCVehicles = true, -- If true script deletes default spawned NPC cars around the vehicle shop
            Testdrive=false,
            buyinhtml=true,
            Management = {
                Enable = true,
                Job = "justice"
            },
            EnableStocks = false,
            AllowedCategories = {"Emergency","suvs"},
            Coords = {
                ShowroomVehicles =vector4(-47.162590026855, -1098.9512939453, 25.422355651855, 169.38456726074),
                BoughtVehicles =vector4(-47.2, -1081.12, 26.73, 74.89),
                TestVehicles = vector4(-28.935346603394, -1649.4888916016, 28.808927536011, 49.50186920166),
                SellingPoint = vector3(-16.748506546021, -1653.4582519531, 29.365490722656)
            },
            Ped = {
                Coords = vector3(-55.647891998291, -1097.3215332031, 26.422323226929),
            },
            ShowroomVehicles = {
                {coords = vector4(-55.647891998291, -1097.3215332031, 26.422323226929, 28.235246658325),},
            },
            Blip = {
                Enable = false,
                coords =vector3(-23.953079223633, -1653.1247558594, 29.491344451904),
                sprite = 227,
                color = 3,
                scale = 0.8,
                text = "DOJ Shop"
            },
            Interaction = {
                Target = {
                    Enable = true,
                    Distance = 2.0,
                    Label = "Open Showroom",
                    Icon = "fa-solid fa-car",
                    Label2 = "Open Management",
                    Icon2 = "fa-solid fa-car"
                },
                Text = {
                    Enable = false,
                    Distance = 3.0,
                    Label = "[E] Open Showroom | [G] Open Management"
                },
                DrawText = {
                    Enable = false,
                    Distance = 3.0,
                    Show = function()
                        exports["qb-core"]:DrawText("Contact", "left")
                    end,
                    Hide = function()
                        exports["qb-core"]:HideText()
                    end
                }
            }
        },
    }
}

-- Fuel Function
function Config.SetFuel(vehicle, fuel)
    exports['qb-fuel']:SetFuel(vehicle, fuel)
end

-- Key Function
function Config.GiveKey(plate)
    TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
end

-- HUD Function
function Config.HUD(state)
    TriggerEvent("hud:client:status",state)
    -- exports['nxo-hud']:ToggleVisible(state)
end

-- Management Function
function Config.AddManagementMoney(job, amount)
    exports['qb-management']:AddMoney(job, amount)
end