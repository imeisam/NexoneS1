-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

--Customize notifications
RegisterNetEvent('wasabi_crutch:notify', function(title, desc, style, icon)
    -- lib.notify({
    --     title = title,
    --     description = desc,
    --     duration = 3500,
    --     type = style,
    --     icon = (icon or false)
    -- })

    TriggerEvent("QBCore:Notify", desc, style)
end)

-- Custom Car lock
AddCarKeys = function(plate) -- Edit carlock function to implement custom carlock
    TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
end

