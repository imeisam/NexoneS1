if Config.Options == "drawtext" then
-- creating bank points
    local textShown = false
    local textShown1 = false
    local ATMCoords = nil
    local NearbyModel = false
    CreateThread(function()
        for k, v in pairs(Locations) do
            local point = lib.points.new({
                coords = v.coords,
                distance = 1.5,
            })
            
            function point:onEnter()
                textShown1 = true
                exports['qb-core']:DrawText(Locales["open_bank_text"],'',"E")
                -- lib.showTextUI(Locales["open_bank_text"])
            end
            
            function point:onExit()
                textShown1 = false
                -- lib.hideTextUI()
                exports['qb-core']:HideText()
            end

            function point:nearby()
                if IsControlJustPressed(0, 38) then
                    DoProgress(true)
                end
                if bankOpen and textShown1 then
                    -- lib.hideTextUI()
                    exports['qb-core']:HideText()
                    textShown1 = false
                elseif not bankOpen and not textShown1 then
                    exports['qb-core']:DrawText(Locales["open_bank_text"],'',"E")
                    -- lib.showTextUI(Locales["open_bank_text"])
                    textShown1 = true
                end
            end
        end
    end)



    CreateThread(function()
        while true do
            local PlayerCoords = GetEntityCoords(PlayerPedId())
            local modelFound = false
            for k, v in pairs(Config.ATMModels) do
                if type(v) ~= "number" then
                    v = joaat(v)
                end
                ATM = GetClosestObjectOfType(PlayerCoords, 2.0, v, false, false, false)
                if ATM ~= 0 then
                    ATMCoords = GetEntityCoords(ATM)
                    if not ATMOpen then
                        if #(PlayerCoords - ATMCoords) < 1.3 then
                            NearbyModel = true
                            modelFound = true
                        else 
                            NearbyModel = false
                        end 
                    else
                        NearbyModel = false
                    end
                end
            end
            if not modelFound then
                NearbyModel = false
            end
            Wait(500)
        end
    end)

    --- Check for keypresses when nearby a dumpster.
    CreateThread(function()
        while true do
            local WaitTime = 350
            if NearbyModel then
                WaitTime = 0
                if not textShown and not ATMOpen then
                    exports['qb-core']:DrawText(Locales["open_atm_text"],'',"E")
                    -- lib.showTextUI(Locales["open_atm_text"])
                    textShown = true
                end
                if ATMOpen and textShown then
                    exports['qb-core']:HideText()
                    lib.hideTextUI()
                    textShown = false
                end
                if IsControlJustReleased(0, 38) and not ATMOpen then
                    DoProgress(false)
                end
            else
                if textShown then
                    exports['qb-core']:HideText()
                    lib.hideTextUI()
                    textShown = false
                end
            end
            Wait(WaitTime)
        end
    end)
elseif Config.Options == "target" then
    local spawnedEntity = {}
    local function SpawnPed(v)
        RequestModel(v.model)
        while not HasModelLoaded(v.model) do
            Wait(0)
        end
        local entity = CreatePed(0, GetHashKey(v.model), v.ped.x, v.ped.y, v.ped.z - 1.0, v.ped.w,  false, false)
        FreezeEntityPosition(entity, true)
        SetEntityInvincible(entity, true)
        SetBlockingOfNonTemporaryEvents(entity, true)

        exports['qb-interact']:AddInteraction({
            coords =v.interactioncoord,
            distance = 4.0,
            interactDst = 1.2, 
            name = 'bank_interaction_'..v.name,
            id ='bank_ped_'..v.name,
            options = {
                 {
                    label = Locales["target_label_open_bank"],
                    action = function()
                        DoProgress(true)
                    end,
                },
            }
        })

       

        -- exports['qb-target']:AddTargetEntity(entity, { 
        -- options = { 
        --     { 
        --         type = "client", 
        --         icon = 'fas fa-building-columns',
        --         label = Locales["target_label_open_bank"],
        --         action = function(entity)
        --             DoProgress(true)
        --         end,
        --     }
        -- },
        --     distance = 2.5, 
        -- })
        return entity
    end
    RegisterNetEvent('qb-paycheck:openbank', function()
        DoProgress(true)
    end)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)
            local pos = GetEntityCoords(PlayerPedId())
            for k, v in pairs(Locations) do
                if #(pos - vector3(v.ped.x, v.ped.y, v.ped.z)) < 50.0 then
                    if spawnedEntity[k] == nil or not DoesEntityExist(spawnedEntity[k]) then
                        spawnedEntity[k] = SpawnPed(v)
                    end
                else
                    if spawnedEntity[k] ~= nil and DoesEntityExist(spawnedEntity[k]) then
                        DeleteEntity(spawnedEntity[k])
                    end
                end
            end
        end
    end)

    for k, v in pairs(Config.ATMModels) do
        exports['qb-interact']:AddModelInteraction({
            model =v,
            offset = vector3(0.0,-0.2, 1.0), -- optional
            distance = 3.0,
            interactDst = 1.0,
            options = {
                {
                    label = Locales["target_label_open_atm"],
                    action = function()
                        DoProgress(false)
                    end,
                },
            }
        })
    end
   
    for k, v in pairs(Config.FleecaATMcoords) do
        exports['qb-interact']:AddInteraction({
            coords =v,
            distance = 3.0,
            interactDst = 1.0, 
            id = "ATM-fleeca-"..k,
            options = {
                 {
                    id = "ATM-fleeca-"..k,
                    label =  Locales["target_label_open_atm"],
                    action = function()
                        DoProgress(false)
                    end,
                },
            }
        })
    end


    for k, v in pairs(ATMLocations) do
        exports['qb-target']:AddBoxZone("snipe_bank_atm_" .. k, v, 1, 1, {
            name = "snipe_bank_atm_" .. k,
            debugPoly = false,
            heading = -20,
            minZ = v.z - 2,
            maxZ = v.z + 2,
        }, {
            options = {
                {
                    type = "client",
                    icon = "fas fa-money-bill",
                    label = Locales["target_label_open_atm"],
                    action = function(entity)
                        DoProgress(false)
                    end,
                }
            },
            distance = 1.5
        })
    end
end
