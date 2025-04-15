-- How to use
-- CircuitGame('x', 'y', 'scale', 'tamanho do jogo em vmin', '1.ogg', function()
--     run something
-- end)

-- parameters
-- x = position on screen
-- y = position on screen
-- scale = game size on screen in scale (Normally 1.0)
-- sound_name = audio name + format (example 1.ogg)

-- example
-- TriggerEvent("Mx::StartMinigameElectricCircuit", '50%', '92%', '1.0', '30vmin', '1.ogg', function()
--     print("Oops, I hit the code and ran something")
-- end)

-- /startgame 50% 50% 1.0 30vmin 1.ogg

CallBackFunction = nil


RegisterNetEvent('Mx::StartMinigameElectricCircuit')
AddEventHandler('Mx::StartMinigameElectricCircuit', function(x, y, scale, size_game, sound_name, Callback)
    CircuitGame(x, y, scale, size_game, sound_name, Callback)
end)

function CircuitGame(x, y, scale, size_game, sound_name, Callback)
    SetNuiFocus(true,true)
    SendNUIMessage({
        ui = 'ui',
        NuiOpen = true,
        x = x,
        y = y,
        scale = scale,
        size_game = size_game,
        sound_name = sound_name,
        name_resource = GetCurrentResourceName()
    })
    CallBackFunction = Callback
end

RegisterNUICallback('electric_circuit_completed', function(data, cb)
    CloseNui()
    CallBackFunction(data)
    cb('ok')
end)

RegisterNUICallback('CloseNui', function(data, cb)
    local ped = PlayerPedId()
    ClearPedTasks(ped)
    CloseNui()
    cb('ok')
end)

function CloseNui()
    SetNuiFocus(false, false)
    SendNUIMessage({
        ui = 'ui',
        NuiOpen = false,
    })
end