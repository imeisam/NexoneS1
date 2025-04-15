local testObj = nil

RegisterNetEvent('av_drugs:placeTable', function(itemName, identifier, model, slot)
    if not canPlace() then return end
    if model and IsModelValid(tonumber(model)) then
        dbug('av_drugs:placeTable', itemName, identifier, model)
        if testObj and DoesEntityExist(testObj) then
            DeleteEntity(testObj)
            SetEntityAsNoLongerNeeded(testObj)
            testObj = nil
        end
        lib.requestModel(model, 10000)
        local offset = GetEntityCoords(cache.ped) + GetEntityForwardVector(cache.ped) * 3
        testObj = CreateObject(model, offset.x, offset.y, offset.z, false, true, false)
        StopEntityFire(testObj)
        PlaceObjectOnGroundProperly(testObj)
        local data = exports['object_gizmo']:useGizmo(testObj)
        local dist = #(GetEntityCoords(cache.ped) - GetEntityCoords(testObj))
        if testObj and DoesEntityExist(testObj) then
            DeleteEntity(testObj)
            SetEntityAsNoLongerNeeded(testObj)
            testObj = nil
        end
        if dist >= 2 then
            TriggerEvent('av_laptop:notification',"ERROR", Lang['table_distance'], 'error')
            return
        end
        if data then
            local position = data['position']
            local rotation = data['rotation']
            LocalPlayer.state.busy = true
            FreezeEntityPosition(cache.ped,true)
            TaskStartScenarioInPlace(cache.ped, "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 0, true)
            local res = progressBar(false, false, Config.PlacingTime)
            FreezeEntityPosition(cache.ped,false)
            ClearPedTasks(cache.ped)
            if not res then return end
            TriggerServerEvent('av_drugs:setTable', position, rotation, itemName, identifier, model, slot)
            lib.timer(500, function()
                LocalPlayer.state.busy = false
            end, true)
        end
    else
        print("^1[ERROR] ^7Model for table "..itemName.." doesn't exist in game, this is NOT a script problem.")
        print("^1[ERROR] ^7Model for table "..itemName.." doesn't exist in game, this is NOT a script problem.")
        print("^1[ERROR] ^7Model for table "..itemName.." doesn't exist in game, this is NOT a script problem.")
    end
end)