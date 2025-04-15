local spawnPoints = {}

AddEventHandler('getMapDirectives', function(add)
    add('spawnpoint', function(state, model)
        return function(opts)
            local x, y, z, heading

            local s, e = pcall(function()
                if opts.x then
                    x = opts.x
                    y = opts.y
                    z = opts.z
                else
                    x = opts[1]
                    y = opts[2]
                    z = opts[3]
                end

                x = x + 0.0001
                y = y + 0.0001
                z = z + 0.0001

                heading = opts.heading and (opts.heading + 0.01) or 0

                addSpawnPoint({
                    x = x, y = y, z = z,
                    heading = heading,
                    model = model
                })


                if not tonumber(model) then
                    model = GetHashKey(model)
                end

                state.add('xyz', { x, y, z })
                state.add('model', model)
            end)
            if not s then
                Citizen.Trace(e .. "\n")
            end
        end
    end, function(state, arg)
        for i, sp in ipairs(spawnPoints) do
            if sp.x == state.xyz[1] and sp.y == state.xyz[2] and sp.z == state.xyz[3] and sp.model == state.model then
                table.remove(spawnPoints, i)
                return
            end
        end
    end)
end)

local spawnNum = 1

function addSpawnPoint(spawn)
    -- validate the spawn (position)
    if not tonumber(spawn.x) or not tonumber(spawn.y) or not tonumber(spawn.z) then
        error("invalid spawn position")
    end

    -- heading
    if not tonumber(spawn.heading) then
        error("invalid spawn heading")
    end

    -- model (try integer first, if not, hash it)
    local model = spawn.model

    if not tonumber(spawn.model) then
        model = GetHashKey(spawn.model)
    end

    -- is the model actually a model?
    if not IsModelInCdimage(model) then
        error("invalid spawn model")
    end

    -- is is even a ped?
    -- not in V?
    --[[if not IsThisModelAPed(model) then
        error("this model ain't a ped!")
    end]]

    -- overwrite the model in case we hashed it
    spawn.model = model

    -- add an index
    spawn.idx = spawnNum
    spawnNum = spawnNum + 1

    -- all OK, add the spawn entry to the list
    table.insert(spawnPoints, spawn)
    return spawn.idx
end

local function freezePlayer(id, freeze)
    local player = id
    SetPlayerControl(player, not freeze, false)

    local ped = GetPlayerPed(player)

    if not freeze then
        if not IsEntityVisible(ped) then
            SetEntityVisible(ped, true)
        end

        if not IsPedInAnyVehicle(ped) then
            SetEntityCollision(ped, true)
        end

        FreezeEntityPosition(ped, false)
        SetPlayerInvincible(player, false)
    else
        if IsEntityVisible(ped) then
            SetEntityVisible(ped, false)
        end

        SetEntityCollision(ped, false)
        FreezeEntityPosition(ped, true)
        SetPlayerInvincible(player, true)

        if not IsPedFatallyInjured(ped) then
            ClearPedTasksImmediately(ped)
        end
    end
end


function spawnPlayer()
    Citizen.CreateThread(function()
        local spawnIdx = GetRandomIntInRange(1, #spawnPoints + 1)
        local spawn

        if type(spawnIdx) == 'table' then
            spawn = spawnIdx
        else
            spawn = spawnPoints[spawnIdx]
        end

        if not spawn.skipFade then
            DoScreenFadeOut(500)

            while not IsScreenFadedOut() do
                Citizen.Wait(0)
            end
        end

        if not spawn then
            Citizen.Trace("tried to spawn at an invalid spawn index\n")
            return
        end

        freezePlayer(PlayerId(), true)

        if spawn.model then
            RequestModel(spawn.model)

            while not HasModelLoaded(spawn.model) do
                RequestModel(spawn.model)
                Wait(0)
            end

            SetPlayerModel(PlayerId(), spawn.model)

            SetModelAsNoLongerNeeded(spawn.model)

            if N_0x283978a15512b2fe then
				N_0x283978a15512b2fe(PlayerPedId(), true)
            end
        end

        local ped = PlayerPedId()

        SetEntityCoordsNoOffset(ped, spawn.x, spawn.y, spawn.z, false, false, false, true)
        NetworkResurrectLocalPlayer(spawn.x, spawn.y, spawn.z, spawn.heading, true, true, false)


        ClearPedTasksImmediately(ped)
        RemoveAllPedWeapons(ped)
        ClearPlayerWantedLevel(PlayerId())

        -- ShutdownLoadingScreen()

        if IsScreenFadedOut() then
            DoScreenFadeIn(500)

            while not IsScreenFadedIn() do
                Citizen.Wait(0)
            end
        end

        freezePlayer(ped, false)

        TriggerEvent('playerSpawned', spawn)
    end)
end

AddEventHandler('onClientMapStart', function()
    spawnPlayer()
end)