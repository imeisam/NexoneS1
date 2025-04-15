local UsingItem = false
local bndamount = 0

RegisterNetEvent('hospital:client:UseIfaks', function(slot)
    if UsingItem then QBCore.Functions.Notify('Do not Spam', 'error') return end
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("use_ifaks", Lang:t('progress.ifaks'), 3000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
        animDict = "items@clear@custom_anim",
		anim = "bandage",
		flags = 49,
    }, {}, {}, function() -- Done
        UsingItem = true
        StopAnimTask(ped, "anim@amb@business@weed@weed_inspecting_high_dry@", "weed_inspecting_high_base_inspector", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "ifaks", 1, slot)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["ifaks"], "remove")
        TriggerEvent('izzy-healthsystem:client:ifak')
        CreateThread(function()
            local doHealth = true
            local healthadd = 0
            local temphelth=0
            while doHealth do
                temphelth=GetEntityHealth(ped) + 10
                if temphelth>200 then
                    temphelth=200
                end
                SetEntityHealth(ped, temphelth)
                healthadd = healthadd + 25
                if GetEntityHealth(ped) == GetEntityMaxHealth(ped) then
                    doHealth = false
                    UsingItem = false
                end
                if healthadd >= 60 then
                    doHealth = false
                    UsingItem = false
                end
                Wait(1000)
            end
        end)
    end, function() -- Cancel
        StopAnimTask(ped, "anim@amb@business@weed@weed_inspecting_high_dry@", "weed_inspecting_high_base_inspector", 1.0)
        QBCore.Functions.Notify(Lang:t('error.canceled'), "error")
    end)
end)

RegisterNetEvent('hospital:client:UseOxy', function(slot)
    if UsingItem then QBCore.Functions.Notify('Do not Spam', 'error') return end
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("use_oxy", 'using Oxy..', 3000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mp_suicide",
		anim = "pill",
		flags = 49,
    }, {}, {}, function() -- Done
        UsingItem = true
        StopAnimTask(ped, "mp_suicide", "pill", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "oxy", 1, slot)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["oxy"], "remove")
        TriggerEvent('hospital:client:resetDamage')
        CreateThread(function()
            local doHealth = true
            local healthadd = 0
            while doHealth do
                SetEntityHealth(ped, GetEntityHealth(ped) + 5)
                healthadd = healthadd + 5
                if GetEntityHealth(ped) == GetEntityMaxHealth(ped) then
                    doHealth = false
                    UsingItem = false
                end
                if healthadd >= 35 then
                    doHealth = false
                    UsingItem = false
                end
                Wait(1000)
            end
        end)
    end, function() -- Cancel
        StopAnimTask(ped, "mp_suicide", "pill", 1.0)
        QBCore.Functions.Notify(Lang:t('error.canceled'), "error")
    end)
end)

RegisterNetEvent('hospital:client:UseGause', function(slot)
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("use_gause", 'using Gause..', 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "anim@amb@business@weed@weed_inspecting_high_dry@",
		anim = "weed_inspecting_high_base_inspector",
		flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "anim@amb@business@weed@weed_inspecting_high_dry@", "weed_inspecting_high_base_inspector", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "gauze", 1, slot)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["gauze"], "remove")
        local temphelth=GetEntityHealth(ped) + 10
        if temphelth>200 then
            temphelth=200
        end
        SetEntityHealth(ped,temphelth )
    end, function() -- Cancel
        StopAnimTask(ped, "anim@amb@business@weed@weed_inspecting_high_dry@", "weed_inspecting_high_base_inspector", 1.0)
        QBCore.Functions.Notify(Lang:t('error.canceled'), "error")
    end)
end)

RegisterNetEvent('hospital:client:UseBandage', function(slot)
    local ped = PlayerPedId()
    finishuse=true
    if GetEntityHealth(ped)<200  then
      
        CreateThread(function()
            while finishuse do 
                 TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3, 'bandage', 0.05)
                 Wait(1000)
             end
        end)
      
       
    QBCore.Functions.Progressbar("use_bandage", 'using Bandage..', 7000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "items@clear@custom_anim",
		anim = "bandage",
		flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "items@clear@custom_anim", "bandage", 1.0)
        finishuse=false
            TriggerServerEvent("QBCore:Server:RemoveItem", "bandage", 1, slot)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["bandage"], "remove")
           local health=GetEntityHealth(ped)
             if health+20>200 then
                health=200
             else
                health=health+20
            end
            SetEntityHealth(ped,health)
     
   
    end, function() -- Cancel
        finishuse=false
        StopAnimTask(ped, "items@clear@custom_anim", "bandage", 1.0)
        QBCore.Functions.Notify(Lang:t('error.canceled'), "error")
    end)
else
    QBCore.Functions.Notify("You are Now Right...", "error")  
end
end)

RegisterNetEvent('hospital:client:UseMedkit', function(slot)
    if UsingItem then QBCore.Functions.Notify('Do not Spam', 'error') return end
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("use_medkit", Lang:t('progress.medkit'), 3000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
        animDict = "items@clear@custom_anim",
		anim = "bandage",
		flags = 49,
    }, {}, {}, function() -- Done
        UsingItem = true
        StopAnimTask(ped, "anim@amb@business@weed@weed_inspecting_high_dry@", "weed_inspecting_high_base_inspector", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "medkit", 1, slot)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["medkit"], "remove")
        TriggerEvent('izzy-healthsystem:client:medkit')
        CreateThread(function()
            local doHealth = true
            local healthadd = 0
            local temphelth=0
            while doHealth do
                temphelth=GetEntityHealth(ped) + 25
                if temphelth>200 then
                    temphelth=200
                end
                SetEntityHealth(ped,temphelth )
                healthadd = healthadd + 25
                if GetEntityHealth(ped) == GetEntityMaxHealth(ped) then
                    doHealth = false
                    UsingItem = false
                end
                if healthadd >= 60 then
                    doHealth = false
                    UsingItem = false
                end
                Wait(1000)
            end
        end)
    end, function() -- Cancel
        StopAnimTask(ped, "anim@amb@business@weed@weed_inspecting_high_dry@", "weed_inspecting_high_base_inspector", 1.0)
        QBCore.Functions.Notify(Lang:t('error.canceled'), "error")
    end)
end)