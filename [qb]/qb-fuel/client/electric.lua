
    -- Variables   
    local QBCore = exports['qb-core']:GetCoreObject()
    HoldingElectricNozzle = false
    local RefuelPossible = false
    local RefuelPossibleAmount = 0 
    local RefuelCancelled = false
    local RefuelPurchaseType = 'bank'
    refuelingelectic=false
   
    function GetFuel(vehicle)
        return DecorGetFloat(vehicle, Config.FuelDecor)
    end

    AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
        if Config.PumpHose then
            Rope = nil
        end
        exports['qb-target']:AddTargetModel(Config.chargermodel, {
            options = {
                {
                    type = "client",
                    event = "cdn-fuel:client:grabelectricnozzle",
                    icon = "fas fa-bolt",
                    label = 'grab electric nozel',
                    canInteract = function()
                        if not IsHoldingElectricNozzle() and not IsPedInAnyVehicle(PlayerPedId()) then
                            return true
                        else
                            return false
                        end
                    end
                },
                {
                    type = "server",
                    event = "qb-fuel:server:buybattry",
                    icon = "fas fa-bolt",
                    label = 'Buy Vehicle Battery($'..Config.vehiclebatterybuy..')',
                    canInteract = function()
                        if not IsHoldingElectricNozzle() and not IsPedInAnyVehicle(PlayerPedId()) then
                            return true
                        else
                            return false
                        end
                    end
                },
                
                {
                    type = "client",
                    event = "cdn-fuel:client:returnnozzle",
                    icon = "fas fa-hand",
                    label = 'return nozel',
                    canInteract = function()
                        if IsHoldingElectricNozzle() and not refuelingelectic then
                            return true
                        else
                            return false
                        end
                    end
                },
            },
            distance =2.0
        })
    end)
  

    function SetFuel(vehicle, fuel)
        if type(fuel) == 'number' and fuel >= 0 and fuel <= 100 then
            SetVehicleFuelLevel(vehicle, fuel + 0.0)
            DecorSetFloat(vehicle, Config.FuelDecor, GetVehicleFuelLevel(vehicle))
        end
    end
    
    function IsPlayerNearVehicle()
        if Config.FuelDebug then
            print("Checking if player is near a vehicle!")
        end
        local vehicle = GetClosestVehicle()
        local closestVehCoords = GetEntityCoords(vehicle)
        if #(GetEntityCoords(PlayerPedId(), closestVehCoords)) > 3.0 then
            return true
        end
        return false
    end

    
    -- Start
    AddEventHandler('onResourceStart', function(resource)
        if resource == GetCurrentResourceName() then
            Wait(100)
            DeleteObject(ElectricNozzle)
            HoldingElectricNozzle = false
        end
    end)

    -- Functions
    function IsHoldingElectricNozzle()
        return HoldingElectricNozzle
    end exports('IsHoldingElectricNozzle', IsHoldingElectricNozzle)

    function SetElectricNozzle(state)
        if state == "putback" then
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "putbackcharger", 0.4)
            Wait(250)
            if Config.FuelTargetExport then exports[Config.TargetResource]:AllowRefuel(false, true) end
            DeleteObject(ElectricNozzle)
            HoldingElectricNozzle = false
            if Config.PumpHose == true then
                RopeUnloadTextures()
                DeleteRope(Rope)
            end
        elseif state == "pickup" then    
            TriggerEvent('cdn-fuel:client:grabelectricnozzle')
            HoldingElectricNozzle = true
        else
            if Config.FuelDebug then print("State is not valid, it must be pickup or putback.") end
        end
    end exports('SetElectricNozzle', SetElectricNozzle)

    -- Events
  
        RegisterNetEvent('cdn-electric:client:OpenContextMenu', function(total, fuelamounttotal, purchasetype)
            lib.registerContext({
                id = 'electricconfirmationmenu',
                title = Lang:t("menu_purchase_station_header_1")..math.ceil(total)..Lang:t("menu_purchase_station_header_2"),
                options = {
                    {
                        title = Lang:t("menu_purchase_station_confirm_header"),
                        description = Lang:t("menu_electric_accept"),
                        icon = "fas fa-check-circle",
                        arrow = false, -- puts arrow to the right
                        event = 'cdn-fuel:client:electric:ChargeVehicle',
                        args = {
                            fuelamounttotal = fuelamounttotal,
                            purchasetype = purchasetype,
                        }
                    },
                    {
                        title = Lang:t("menu_header_close"),
                        description = Lang:t("menu_refuel_cancel"),
                        icon = "fas fa-times-circle",
                        arrow = false, -- puts arrow to the right
                        onSelect = function()
                            lib.hideContext()
                          end,
                    },
                },
            })
            lib.showContext('electricconfirmationmenu')
        end)
 

        RegisterNetEvent('qb-fuel:client:battery', function()
            local vehicle = GetClosestVehicle()
            if not vehicle then return  end
            if not iselectric(GetEntityModel(vehicle)) then
                QBCore.Functions.Notify("This Vehicle Not Electirc", 'error', 7500)
                return
            end
            local ped =PlayerPedId()
            local doorid=4
            local bones="hood"
            local distance=2.5
            local hood = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle,bones))
            local hoodexist = not ((hood == vector3(0, 0, 0)) or IsVehicleDoorDamaged(vehicle, doorid))
            if not hoodexist then hood = GetEntityCoords(vehicle) distance = 2.5 end
            if #(GetEntityCoords(ped) - hood) < distance then
                return 
            end
            local fuel= GetFuel(vehicle)
             if fuel>=100 then
                QBCore.Functions.Notify("This Vehicle is Full Charge", 'error', 7500)
                    return 
             end
             TriggerEvent('animations:client:EmoteCommandStart', {"mechanic2"})
            QBCore.Functions.Progressbar("charge-car", "Changing Battery..", 20000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function()
                TriggerServerEvent("QBCore:Server:RemoveItem", "vehiclebattery", 1)
                TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["vehiclebattery"], "remove")

                if fuel+20>100 then
                    fuel=100
                else
                    fuel=fuel+20
                end
                 SetFuel(vehicle, fuel)
                 TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            end, function()
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            end, "fas fa-charging-station")

        end)  

        
    RegisterNetEvent('cdn-fuel:client:electric:FinalMenu', function(purchasetype)
        local money = nil
        if purchasetype == "bank" then money = QBCore.Functions.GetPlayerData().money['bank'] elseif purchasetype == 'cash' then money = QBCore.Functions.GetCash() end
        FuelPrice = (1 * Config.ElectricChargingPrice)
        local vehicle = GetClosestVehicle()

        -- Police Discount Math --
    --    if false then-- if Config.EmergencyServicesDiscount['enabled'] == true and (Config.EmergencyServicesDiscount['emergency_vehicles_only'] == false or (Config.EmergencyServicesDiscount['emergency_vehicles_only'] == true and GetVehicleClass(vehicle) == 18)) then
    --         local discountedJobs = Config.EmergencyServicesDiscount['job']
    --         local plyJob = QBCore.Functions.GetPlayerData().job.name
    --         local shouldRecieveDiscount = false

    --         if type(discountedJobs) == "table" then
    --             for i = 1, #discountedJobs, 1 do
    --                 if plyJob == discountedJobs[i] then
    --                     shouldRecieveDiscount = true
    --                     break
    --                 end
    --             end
    --         elseif plyJob == discountedJobs then
    --             shouldRecieveDiscount = true
    --         end

    --         if shouldRecieveDiscount == true and not QBCore.Functions.GetPlayerData().job.onduty and Config.EmergencyServicesDiscount['ondutyonly'] then
    --             QBCore.Functions.Notify(Lang:t("you_are_discount_eligible"), 'primary', 7500)
	-- 			shouldRecieveDiscount = false
	-- 		end

    --         if shouldRecieveDiscount then
    --             local discount = Config.EmergencyServicesDiscount['discount']
    --             if discount > 100 then
    --                 discount = 100
    --             else
    --                 if discount <= 0 then discount = 0 end
    --             end
    --             if discount ~= 0 then
    --                 if discount == 100 then
    --                     FuelPrice = 0
    --                     if Config.FuelDebug then
    --                         print("Your discount for Emergency Services is set @ "..discount.."% so fuel is free!")
    --                     end
    --                 else
    --                     discount = discount / 100
    --                     FuelPrice = FuelPrice - (FuelPrice*discount)

    --                     if Config.FuelDebug then
    --                         print("Your discount for Emergency Services is set @ "..discount.."%. Setting new price to: $"..FuelPrice)
    --                     end
    --                 end
    --             else
    --                 if Config.FuelDebug then
    --                     print("Your discount for Emergency Services is set @ "..discount.."%. It cannot be 0 or < 0!")
    --                 end
    --             end
    --         end
    --     end

        local curfuel = GetFuel(vehicle)
        local finalfuel
        if curfuel < 10 then finalfuel = string.sub(curfuel, 1, 1) else finalfuel = string.sub(curfuel, 1, 2) end
        local maxfuel = (100 - finalfuel - 1)
        local wholetankcost = (FuelPrice * maxfuel)
        local wholetankcostwithtax = math.ceil((wholetankcost) + GlobalTax(wholetankcost))
        if Config.FuelDebug then print("Attempting to open Input with the total: $"..wholetankcostwithtax.." at $"..FuelPrice.." / L".." Maximum Fuel Amount: "..maxfuel) end
       
            Electricity = exports['qb-input']:ShowInput({
                header = "Select the Amount of Fuel<br>Current Price: $" ..
                FuelPrice .. " / KWh <br> Current Charge: " .. finalfuel .. " KWh <br> Full Charge Cost: $" ..
                wholetankcostwithtax .. "",
                submitText = "Insert Charger",
                inputs = {{
                    type = 'number',
                    isRequired = true,
                    name = 'amount',
                    text = 'The Battery Can Hold ' .. maxfuel .. ' More KWh.'
                }}
            })
            if Electricity then
                if not Electricity.amount then print("Electricity.amount is invalid!") return end
                if not HoldingElectricNozzle then QBCore.Functions.Notify("No Have a Nozzel Charge", 'error', 7500) return end
                if (Electricity.amount + finalfuel) >= 100 then
                    QBCore.Functions.Notify("Charge Is a Full", "error")
                else
                    if GlobalTax(Electricity.amount * FuelPrice) + (Electricity.amount * FuelPrice) <= money then
                        TriggerServerEvent('cdn-fuel:server:electric:OpenMenu', Electricity.amount, IsInGasStation(), false, purchasetype, FuelPrice)
                    else
                        QBCore.Functions.Notify("not enough money", 'error', 7500)
                    end
                end
            end
       
    end)
    function IsInGasStation()
        return true
    end
    RegisterNetEvent('cdn-fuel:client:electric:SendMenuToServer', function()
        local vehicle = GetClosestVehicle()
        local vehModel = GetEntityModel(vehicle)
        local vehiclename = string.lower(GetDisplayNameFromVehicleModel(vehModel))
        AwaitingElectricCheck = false
        FoundElectricVehicle = true
        :: ChargingMenu :: 
        if not AwaitingElectricCheck then if Config.FuelDebug then print("Attempting to go to Charging Menu") end end
        if not AwaitingElectricCheck and FoundElectricVehicle then
            local CurFuel = GetVehicleFuelLevel(vehicle)
            local playercashamount = QBCore.Functions.GetCash()
            if not IsHoldingElectricNozzle() then QBCore.Functions.Notify(Lang:t("electric_no_nozzle"), 'error', 7500)  return end
            if CurFuel < 95 then
                
                    exports['qb-menu']:openMenu({
                        {
                            header ="Electronic Charge Station",
                            isMenuHeader = true,
                            icon = "fas fa-bolt",
                        },
                        {
                            header ="Cash",
                            txt = "Amount: ".. playercashamount,
                            icon = "fas fa-usd",
                            params = {
                                event = "cdn-fuel:client:electric:FinalMenu",
                                args = 'cash',
                            }
                        },
                        {
                            header = "Bank",
                            txt = "Pay With Bank",
                            icon = "fas fa-credit-card",
                            params = {
                                event = "cdn-fuel:client:electric:FinalMenu",
                                args = 'bank',
                            }
                        },
                        {
                            header = "Close",
                            txt = "Cancel Charge",
                            icon = "fas fa-times-circle",
                            params = {
                                event = "qb-menu:closeMenu",
                            }
                        },
                    })
                
            else
                QBCore.Functions.Notify("Allready is Full", 'error')
            end
        else
            if Config.FuelDebug then print("Checking") end
            if AwaitingElectricCheck then
                if Config.ElectricVehicles[vehiclename] and Config.ElectricVehicles[vehiclename].isElectric then
                    AwaitingElectricCheck = false
                    FoundElectricVehicle = true
                    if Config.FuelDebug then print("^2"..current.. "^5 has been found. It ^2matches ^5the Player's Vehicle: ^2"..vehiclename..". ^5This means charging will be allowed.") end
                    Wait(50)
                    goto ChargingMenu -- Attempt to go to the charging menu, now that we have found that there was an electric vehicle.
                else
                    FoundElectricVehicle = false
                    AwaitingElectricCheck = false
                    Wait(50)
                    if Config.FuelDebug then print("^2An electric vehicle^5 has NOT been found. ^5This means charging will not be allowed.") end
                    goto ChargingMenu -- Attempt to go to the charging menu, now that we have not found that there was an electric vehicle.
                end

                -- for i = 1, #Config.ElectricVehicles do
                --     if AwaitingElectricCheck then
                --         if Config.FuelDebug then print(i) end
                --         local current = joaat(Config.ElectricVehicles[i])
                --         if Config.FuelDebug then print("^5Current Search: ^2"..current.." ^5Player's Vehicle: ^2"..vehiclename) end
                --         if current == vehiclename then
                --             AwaitingElectricCheck = false
                --             FoundElectricVehicle = true
                --             if Config.FuelDebug then print("^2"..current.. "^5 has been found. It ^2matches ^5the Player's Vehicle: ^2"..vehiclename..". ^5This means charging will be allowed.") end
                --             Wait(50)
                --             goto ChargingMenu -- Attempt to go to the charging menu, now that we have found that there was an electric vehicle.
                --         elseif i == #Config.ElectricVehicles then
                --             FoundElectricVehicle = false
                --             AwaitingElectricCheck = false
                --             Wait(50)
                --             if Config.FuelDebug then print("^2An electric vehicle^5 has NOT been found. ^5This means charging will not be allowed.") end
                --             goto ChargingMenu -- Attempt to go to the charging menu, now that we have not found that there was an electric vehicle.
                --         end
                --     else
                --         if Config.FuelDebug then print('Search ended..') end
                --     end
                -- end
            else
                QBCore.Functions.Notify("Vehicle is not Electronic", 'error', 7500)
            end
        end
    end)

    RegisterNetEvent('cdn-fuel:client:electric:ChargeVehicle', function(data)


        local retval =	GetWorldPositionOfEntityBone(entity , boneIndex )



        if Config.FuelDebug then print("Charging Vehicle") end
        if not Config.RenewedPhonePayment then 
            purchasetype = data.purchasetype 
        elseif data.purchasetype == "cash" then 
            purchasetype = "cash"
        else
            purchasetype =data.purchasetype
        end
        if Config.FuelDebug then print("Purchase Type: "..purchasetype) end
        if not Config.RenewedPhonePayment then 
            amount = data.fuelamounttotal 
        elseif data.purchasetype == "cash" then
            amount = data.fuelamounttotal
        elseif data.purchasetype == "bank" then
            amount = data.fuelamounttotal
        elseif not data.fuelamounttotal then
            amount = RefuelPossibleAmount 
        end
        if not HoldingElectricNozzle then return end
        amount = tonumber(amount)
        if amount < 1 then return end
        if amount < 10 then fuelamount = string.sub(amount, 1, 1) else fuelamount = string.sub(amount, 1, 2) end
        local FuelPrice = (Config.ElectricChargingPrice * 1)
        local vehicle = GetClosestVehicle()

        local refillCost = (fuelamount * FuelPrice) + GlobalTax(fuelamount*FuelPrice)
        local vehicle = GetClosestVehicle()
        local ped = PlayerPedId()
        local time = amount * Config.RefuelTime
        if amount < 10 then time = 10 * Config.RefuelTime end
        local vehicleCoords = GetEntityCoords(vehicle)
        if IsInGasStation() then
            if IsPlayerNearVehicle() then
                RequestAnimDict(Config.RefuelAnimationDictionary)
                while not HasAnimDictLoaded('timetable@gardener@filling_can') do Wait(100) end
                if GetIsVehicleEngineRunning(vehicle) and Config.VehicleBlowUp then
                    local Chance = math.random(1, 100)
                    if Chance <= Config.BlowUpChance then
                        AddExplosion(vehicleCoords, 5, 50.0, true, false, true)
                        return
                    end
                end
                local bootBoneIndex = GetEntityBoneIndexByName(vehicle --[[ Entity ]], 'boot' --[[ string ]])
				local vehBootCoords = GetWorldPositionOfEntityBone(vehicle --[[ Entity ]],  joaat(bootBoneIndex)--[[ integer ]])
				TaskTurnPedToFaceCoord(PlayerPedId(), vehBootCoords, 500)
				Wait(500)

                TaskPlayAnim(ped, Config.RefuelAnimationDictionary, Config.RefuelAnimation, 8.0, 1.0, -1, 1, 0, 0, 0, 0)
                refuelingelectic = true
                Refuelamount = 0
             
                TriggerServerEvent("InteractSound_SV:PlayOnSource", "charging", 0.3)
                
                    QBCore.Functions.Progressbar("charge-car", "Charging..", time, false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {}, {}, {}, function()
                        refuelingelectic = false
                        StopAnimTask(ped, Config.RefuelAnimationDictionary, Config.RefuelAnimation, 3.0, 3.0, -1, 2, 0, 0, 0, 0)
                        TriggerServerEvent("InteractSound_SV:PlayOnSource", "chargestop", 0.4)

                      
                        
                        -- if not Config.RenewedPhonePayment or purchasetype == 'cash' then TriggerServerEvent('cdn-fuel:server:PayForFuel', refillCost, purchasetype, FuelPrice, true) end
                        local curfuel = GetFuel(vehicle)
                        local finalfuel = (curfuel + fuelamount)

                        if finalfuel > 99 and finalfuel < 100 then
                            finalfuel=100-curfuel
                        else
                            finalfuel=fuelamount
                        end
                        fuelmoney=(finalfuel*FuelPrice) + GlobalTax(finalfuel*FuelPrice)
                        if data.purchasetype=='bank' then
                            money = QBCore.Functions.GetPlayerData().money['bank'] 
                        elseif data.purchasetype=='cash' then
                            money = QBCore.Functions.GetCash()
                        end
                        if money<fuelmoney  then  QBCore.Functions.Notify("not enough money", "error") return end
                      
                        SetFuel(vehicle, curfuel+finalfuel)
                        TriggerServerEvent("cdn-fuel:server:PayForFuel", fuelamount,data.purchasetype,fuelmoney,true)

                        local playercashamount = QBCore.Functions.GetCash()


                        if Config.RenewedPhonePayment then
                            RefuelCancelled = true
                            RefuelPossibleAmount = 0
                            RefuelPossible = false
                        end
                      
                    end, function()
                        refuelingelectic = false
                        Cancelledrefuel = true
                        StopAnimTask(ped, Config.RefuelAnimationDictionary, Config.RefuelAnimation, 3.0, 3.0, -1, 2, 0, 0, 0, 0)
                        TriggerServerEvent("InteractSound_SV:PlayOnSource", "chargestop", 0.4)
                    end, "fas fa-charging-station")
               
            end
        else return end
    end)

    function LoadAnimDict(dict)
        while (not HasAnimDictLoaded(dict)) do
            RequestAnimDict(dict)
            Wait(5)
        end
    end

    function GetClosestPump(coords, isElectric)
       
            local pump = nil
            local pumpCoords
            for i = 1, #Config.chargermodel, 1 do
                local currentPumpModel = Config.chargermodel[i]
                pump = GetClosestObjectOfType(coords.x, coords.y, coords.z,1.0, joaat(currentPumpModel), true, true, true)
                pumpCoords = GetEntityCoords(pump)
                if pump ~= 0 then break end
            end
            return pumpCoords, pump
       
    end
    -- CreateThread(function()
    --     local boness = {
    --         "petroltank",
    --         "petroltank_l",
    --         "petroltank_r",
    --         "wheel_rf",
    --         "wheel_rr",
    --         "petrolcap ",
    --         "seat_dside_r",
    --         "engine",
    --     }
    
    --     exports['qb-target']:AddTargetBone(boness, {
    --         options = {
    --             {
    --                 type = "client",
    --                 event = "cdn-fuel:client:electric:SendMenuToServer",
    --                 icon = "fas fa-gas-pump",
    --                 label = "Insert Nozzle",
    --                 canInteract = function()
    --                     local vehicle = QBCore.Functions.GetClosestVehicle()

    --                     if iselectric(GetEntityModel(vehicle)) and  HoldingElectricNozzle then
                           
    --                         return true
    --                     end
    --                 end
    --             }
    --         },
    --         distance = 1.5,
    --     })
    -- end)

    
    RegisterNetEvent('cdn-fuel:client:grabelectricnozzle', function()
        local ped = PlayerPedId()
        if HoldingElectricNozzle then return end
        LoadAnimDict("anim@am_hold_up@male")
        TaskPlayAnim(ped, "anim@am_hold_up@male", "shoplift_high", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "pickupnozzle", 0.4)
        Wait(300)
        StopAnimTask(ped, "anim@am_hold_up@male", "shoplift_high", 1.0)
        ElectricNozzle = CreateObject(joaat('electric_nozzle'), 1.0, 1.0, 1.0, true, true, false)
        local lefthand = GetPedBoneIndex(ped, 18905)
        AttachEntityToEntity(ElectricNozzle, ped, lefthand, 0.24, 0.10, -0.052 --[[FWD BWD]], -45.0 --[[ClockWise]], 120.0 --[[Weird Middle Axis]], 75.00 --[[Counter Clockwise]], 0, 1, 0, 1, 0, 1)
        local grabbedelectricnozzlecoords = GetEntityCoords(ped)
        HoldingElectricNozzle = true
        if Config.PumpHose == true then
            local pumpCoords, pump = GetClosestPump(grabbedelectricnozzlecoords, true)
            RopeLoadTextures()
            while not RopeAreTexturesLoaded() do
                Wait(0)
                RopeLoadTextures()
            end
            while not pump do
                Wait(0)
            end
            Rope = AddRope(pumpCoords.x, pumpCoords.y, pumpCoords.z, 0.0, 0.0, 0.0, 3.0,3, 1000.0, 0.0, 1.0, false, false, false, 1.0, true)
            while not Rope do
                Wait(0)
            end
            ActivatePhysics(Rope)
            Wait(100)
            local nozzlePos = GetEntityCoords(ElectricNozzle)
            nozzlePos = GetOffsetFromEntityInWorldCoords(ElectricNozzle, -0.005, 0.185, -0.05)
            AttachEntitiesToRope(Rope, pump, ElectricNozzle, pumpCoords.x, pumpCoords.y, pumpCoords.z+1.0, nozzlePos.x, nozzlePos.y, nozzlePos.z, 5.0, false, false, nil, nil)
        end
        CreateThread(function()
            while HoldingElectricNozzle do
                local currentcoords = GetEntityCoords(ped)
                local dist = #(grabbedelectricnozzlecoords - currentcoords)
                -- if not TargetCreated then if Config.FuelTargetExport then exports[Config.TargetResource]:AllowRefuel(true, true) end end
                TargetCreated = true
                if dist > 6 then
                    -- if TargetCreated then if Config.FuelTargetExport then exports[Config.TargetResource]:AllowRefuel(false, true) end end
                    TargetCreated = true
                    HoldingElectricNozzle = false
                    DeleteObject(ElectricNozzle)
                    QBCore.Functions.Notify("Remove Electric Nozel", 'error')
                    if Config.PumpHose == true then
                        RopeUnloadTextures()
                        DeleteRope(Rope)
                    end
                end
                Wait(2500)
            end
        end)
    end)    

    RegisterNetEvent('cdn-fuel:client:electric:RefuelMenu', function()
      
            if not RefuelPossible then 
                TriggerEvent('cdn-fuel:client:electric:SendMenuToServer')
            else 
               
                    if not Cancelledrefuel and not RefuelCancelled then
                        if RefuelPossibleAmount then
                            local purchasetype = "bank"
                            local fuelamounttotal = tonumber(RefuelPossibleAmount)
                            if Config.FuelDebug then print("Attempting to charge vehicle.") end
                            TriggerEvent('cdn-fuel:client:electric:ChargeVehicle', purchasetype, fuelamounttotal)
                        else
                            QBCore.Functions.Notify("You have to charge more than 0KW!", 'error', 7500)
                        end
                    end
               
            end
      
    end)

   
        RegisterNetEvent('cdn-fuel:client:electric:phone:PayForFuel', function(amount)
            FuelPrice = Config.ElectricChargingPrice
            
            -- Police Discount Math --
            -- if Config.EmergencyServicesDiscount['enabled'] == true then
            --     local discountedJobs = Config.EmergencyServicesDiscount['job']
            --     local plyJob = QBCore.Functions.GetPlayerData().job.name
            --     local shouldRecieveDiscount = false

            --     if type(discountedJobs) == "table" then
            --         for i = 1, #discountedJobs, 1 do
            --             if plyJob == discountedJobs[i] then
            --                 shouldRecieveDiscount = true
            --                 break
            --             end
            --         end
            --     elseif plyJob == discountedJobs then
            --         shouldRecieveDiscount = true
            --     end

            --     if shouldRecieveDiscount == true and not QBCore.Functions.GetPlayerData().job.onduty and Config.EmergencyServicesDiscount['ondutyonly'] then
            --         QBCore.Functions.Notify(Lang:t("you_are_discount_eligible"), 'primary', 7500)
            --         shouldRecieveDiscount = false
            --     end

            --     if shouldRecieveDiscount then
            --         local discount = Config.EmergencyServicesDiscount['discount']
            --         if discount > 100 then 
            --             discount = 100 
            --         else 
            --             if discount <= 0 then discount = 0 end
            --         end
            --         if discount ~= 0 then
            --             if discount == 100 then
            --                 FuelPrice = 0
            --                 if Config.FuelDebug then
            --                     print("Your discount for Emergency Services is set @ "..discount.."% so fuel is free!")
            --                 end
            --             else
            --                 discount = discount / 100
            --                 FuelPrice = FuelPrice - (FuelPrice*discount)

            --                 if Config.FuelDebug then
            --                     print("Your discount for Emergency Services is set @ "..discount.."%. Setting new price to: $"..FuelPrice)
            --                 end
            --             end
            --         else
            --             if Config.FuelDebug then
            --                 print("Your discount for Emergency Services is set @ "..discount.."%. It cannot be 0 or < 0!")
            --             end
            --         end
            --     end
            -- end
            local cost = amount * FuelPrice
            local tax = GlobalTax(cost)
            local total = math.ceil(cost + tax)
            local success = exports['yseries']:PhoneNotification("Electric Charge","Electric Charge "..total, 'fas fa-bolt', '#9f0e63', "NONE", 'fas fa-check-circle', 'fas fa-times-circle')
            if success then
                if QBCore.Functions.GetPlayerData().money['bank'] <= (GlobalTax(amount) + amount) then
                    QBCore.Functions.Notify("not enough money in bank", "error")
                else

                    args = {
                        fuelamounttotal = amount,
                        purchasetype = RefuelPurchaseType,
                    }
                    RefuelPossible = true
                    RefuelPossibleAmount = amount
                    RefuelPurchaseType = "bank"
                    RefuelCancelled = false
                    TriggerEvent('cdn-fuel:client:electric:ChargeVehicle',args)
                    -- TriggerServerEvent('cdn-fuel:server:PayForFuel', total, "bank", FuelPrice, true)
                   
                end
            end
        end)
 

    -- Threads
    -- if Config.ElectricChargerModel then
    --     CreateThread(function()
    --         RequestModel('electric_charger')
    --         while not HasModelLoaded('electric_charger') do
    --             Wait(50)
    --         end

    --         if Config.FuelDebug then
    --             print("Electric Charger Model Loaded!")
    --         end

    --         for i = 1, #Config.GasStations do
    --             if Config.GasStations[i].electricchargercoords ~= nil then
    --                 if Config.FuelDebug then print(i) end
    --                 local heading = Config.GasStations[i].electricchargercoords[4] - 180
    --                 Config.GasStations[i].electriccharger = CreateObject('electric_charger', Config.GasStations[i].electricchargercoords.x, Config.GasStations[i].electricchargercoords.y, Config.GasStations[i].electricchargercoords.z, false, true, true)
    --                 if Config.FuelDebug then print("Created Electric Charger @ Location #"..i) end
    --                 SetEntityHeading(Config.GasStations[i].electriccharger, heading)
    --                 FreezeEntityPosition(Config.GasStations[i].electriccharger, 1)
    --             end	
    --         end
    --     end)
    -- end

    -- Resource Stop

    AddEventHandler('onResourceStop', function(resource)
        if resource == GetCurrentResourceName() then
            for i = 1, #Config.GasStations do
                if Config.GasStations[i].electricchargercoords ~= nil then
                    DeleteEntity(Config.GasStations[i].electriccharger)
                    if IsHoldingElectricNozzle() then DeleteEntity(ElectricNozzle) end
                end	
            end

            if Config.PumpHose then
                RopeUnloadTextures()
                DeleteObject(Rope)
            end
        end
    end)


    RegisterNetEvent('cdn-fuel:client:returnnozzle', function()
            holdingnozzle = false
            TargetCreated = false
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "putbacknozzle", 0.4)
            Wait(250)
            -- if Config.FuelTargetExport then exports[Config.TargetResource]:AllowRefuel(false) end
            DeleteObject(ElectricNozzle)
            HoldingElectricNozzle = false
        if Config.PumpHose then
            RopeUnloadTextures()
            DeleteRope(Rope)
        end
    end)

  