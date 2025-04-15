AddEventHandler('onKeyDown', function(key)
    if key == 'numpad9' then
        if devMode and hasAdminPerms and not IsNuiFocused() then
            ToggleNoClip()
        end
    end
end)

AddEventHandler('onKeyDown', function(key)
    if key == 'numpad1' then
        if devMode and hasAdminPerms then
            TriggerEvent("snipe-menu:client:godMode")
        end
    end
end)

AddEventHandler('onKeyDown', function(key)
    if key == 'numpad2' then
        if devMode and hasAdminPerms then
            TriggerEvent("snipe-menu:client:invisibleEffect")
        end
    end
end)

AddEventHandler('onKeyDown', function(key)
    if key == 'numpad3' then
        if devMode and hasAdminPerms then
            TriggerEvent("snipe-menu:client:toggleBlips")
        end
    end
end)

AddEventHandler('onKeyDown', function(key)
    if key == 'numpad4' then
        if devMode and hasAdminPerms then
            TriggerEvent("snipe-menu:client:toggleNames")
        end
    end
end)

AddEventHandler('onKeyDown', function(key)
    if key == 'l' then
        if devMode and hasAdminPerms then
            DeleteLaser()
        end
    end
end)

AddEventHandler('onKeyUP', function(key)
    if key == 'l' then
        if devMode and hasAdminPerms then
            stopDeleteLaser()
        end
    end
end)

RegisterNetEvent("snipe-menu:client:openmenu", function()
    OpenAdminMenu()
end)

RegisterCommand(Config.CommandName, function()
    OpenAdminMenu()
end)

RegisterNetEvent("snipe-menu:client:addkeymapping", function()
    if not hasAdminPerms then
        devMode = false
    end
end)