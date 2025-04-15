local QBCore = exports['qb-core']:GetCoreObject()
local CurrentModel, CurrentObject, CurrentObjectType, CurrentObjectName, CurrentSpawnRange, CurrentCoords = nil, nil, nil, nil, nil, nil
local startspawn=false
local startwashed=false
local ped = PlayerPedId()
RegisterNetEvent('sam-laundrymachine:client:uselaundry', function()
     ped = PlayerPedId()
    local inVehicle = IsPedInAnyVehicle(ped, false)
    if startspawn or inVehicle then return end
    startspawn=true
    data={object=Config.closeprop,name='laundy',distance=20}
    CreateSpawnedObject(data)
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    RequestSpawnObject(Config.closeprop)
    RequestSpawnObject(Config.openprop)
    RequestSpawnObject(Config.spainprop)
    QBCore.Functions.TriggerCallback('sam-laundrymachine:server:getobject', function(data)
        for k, v in pairs(data) do
            coord=json.decode(v.coord)
            tempdata={id = v.id, model = v.model, coords =vector4(coord.x,coord.y,coord.z,coord.w),cid=v.cid}
            TriggerEvent('sam-laundrymachine:client:AddObject',tempdata)
            Wait(100)
        end
    end)
end)

CreateThread(function()
    RequestSpawnObject(Config.closeprop)
    RequestSpawnObject(Config.openprop)
    RequestSpawnObject(Config.spainprop)
    -- QBCore.Functions.TriggerCallback('sam-laundrymachine:server:getobject', function(data)
    --     for k, v in pairs(data) do
    --         coord=json.decode(v.coord)
    --         tempdata={id = v.id, model = v.model, coords =vector4(coord.x,coord.y,coord.z,coord.w),cid=v.cid}
    --         TriggerEvent('sam-laundrymachine:client:AddObject',tempdata)
    --         Wait(100)
    --     end
    -- end)
end)


 function openstash(id)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'laundry_'..id, {
        maxweight = 100000,
        slots = 2,
    })
    TriggerEvent("inventory:client:SetCurrentStash", 'laundry_'..id)
end

RegisterNetEvent('sam-laundrymachine:client:startwash', function(id,item,coord,data)
    startwashed=true
    TriggerServerEvent("sam-laundrymachine:server:startspain",coord)
    QBCore.Functions.Progressbar("do_chakosh", "Washing Money...", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
    }, {}, {}, function() -- Done
        startwashed=false
        TriggerServerEvent("sam-laundrymachine:server:stopspain",coord,data)
        TriggerServerEvent("sam-laundrymachine:server:washfinished",id,item)
        
    end, function() -- Cancel
        startwashed=false
        TriggerServerEvent("sam-laundrymachine:server:stopspain",coord,data)
        QBCore.Functions.Notify("Canceled...!", "error")
    end)
end)

RegisterNetEvent('sam-laundrymachine:client:AddObject', function(data)
    local PData = QBCore.Functions.GetPlayerData()
    if data.model==Config.openprop then
        local   obj=Config.openprop
         objsp = CreateObject(obj, data.coords.x,data.coords.y,data.coords.z, false, false, false)
         SetEntityHeading(objsp, data.coords.w)
         SetEntityCollision(objsp, true, true)
         FreezeEntityPosition(objsp, true)
         SetEntityAsMissionEntity(objsp, true, true)
         SetModelAsNoLongerNeeded(obj)
        
         exports['qb-target']:AddTargetEntity(objsp, {
             options = {
                 {
                     action = function(entity)
                        changemodellaundry(entity,Config.closeprop,data.id,obj)
                     end,
                     icon = "fas fa-cash-register",
                     label = "Close Laundry Machine",
                 },
                 {
                    action = function()
                        openstash(data.id)
                    end,
                    icon = "fas fa-cash-register",
                    label = "Open Wash Stash",
                },
                 {
                    action = function(entity)
                        removelaundry(entity,data.id,obj)
                    end,
                    icon = "fas fa-cash-register",
                    label = "Remove Laundry Machine",
                    canInteract = function()
                        return PData.citizenid==data.cid
                    end,
                },
             },
             distance = 1.5
         })

    else
           local obj=Config.closeprop
           
             objsp = CreateObject(obj, data.coords.x,data.coords.y,data.coords.z, false, false, false)
             SetEntityHeading(objsp, data.coords.w)
             SetEntityAsMissionEntity(objsp, true, true)
             SetModelAsNoLongerNeeded(obj)
             SetEntityCollision(objsp, true, true)
             FreezeEntityPosition(objsp, true)
             exports['qb-target']:AddTargetEntity(objsp, {
                 options = {
                     {
                         action = function(entity)
                            changemodellaundry(entity,Config.openprop,data.id,obj)
                         end,
                         icon = "fas fa-cash-register",
                         label = "Open Laundry Machine",
                     },
                     {
                        action = function()
                            startwash(data.id,vector4(data.coords.x,data.coords.y,data.coords.z,data.coords.w),{id=data.id,model='',cid=data.cid})
                        end,
                        icon = "fas fa-cash-register",
                        label = "Start Wash",
                    },
                     {
                        action = function(entity)
                            removelaundry(entity,data.id,obj)
                        end,
                        icon = "fas fa-cash-register",
                        label = "Remove Laundry Machine",
                        canInteract = function()
                            return PData.citizenid==data.cid
                        end,
                    },
                 },
                 distance = 1.5
             })
    end
end)


function PlaceSpawnedObject(heading)
    local finalCoords = vector4(CurrentCoords.x, CurrentCoords.y, CurrentCoords.z, heading)
    TriggerServerEvent("sam-laundrymachine:server:CreateNewObject", CurrentModel, finalCoords)
    DeleteObject(CurrentObject)
    PlacingObject = false
    CurrentObject = nil
    CurrentObjectType = nil
    CurrentObjectName = nil
    CurrentSpawnRange = nil
    CurrentCoords = nil
    CurrentModel = nil
    startspawn=false
end

function startwash(id,coord,data)
 if startwashed then return end
    TriggerServerEvent("sam-laundrymachine:server:startwash",'laundry_'..id,coord,data)
end

function changemodellaundry(entity,objname,id,lastobj)
   entitycoord= GetEntityCoords(entity)
   heading=GetEntityHeading(entity)
    TriggerServerEvent("sam-laundrymachine:server:CreateNewObject",objname,vector4(entitycoord.x,entitycoord.y,entitycoord.z,heading) ,id,lastobj)
end

function removelaundry(entity,id,lastobj)
    ExecuteCommand('e mechanic2')
    QBCore.Functions.Progressbar("do_chakosh", "Remove Laundry...", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
    }, {}, {}, function() -- Done
        ExecuteCommand('e c')
        entitycoord= GetEntityCoords(entity)
        heading=GetEntityHeading(entity)
         TriggerServerEvent("sam-laundrymachine:server:removeobject",vector4(entitycoord.x,entitycoord.y,entitycoord.z,heading) ,id,lastobj)
    end, function() -- Cancel
        ExecuteCommand('e c')
    end)

  
end

RegisterNetEvent('sam-laundrymachine:client:RemoveObject', function(model,coord)
    object1=GetClosestObjectOfType(coord.x,coord.y,coord.z,0.5,GetHashKey(model))
    DeleteObject(object1)
end)


RegisterNetEvent('sam-laundrymachine:client:spawnspain', function(coord)
    local obj=Config.spainprop

    object1=GetClosestObjectOfType(coord.x,coord.y,coord.z,0.5,GetHashKey(Config.closeprop))
    DeleteObject(object1)
    objsp = CreateObject(obj, coord.x,coord.y,coord.z, false, false, false)
    SetEntityHeading(objsp, coord.w)
    SetEntityCollision(objsp, true, true)
    FreezeEntityPosition(objsp, true)
    SetEntityAsMissionEntity(objsp, true, true)
    SetModelAsNoLongerNeeded(obj)
end)

RegisterNetEvent('sam-laundrymachine:client:backspain', function(coord,data)
    object1=GetClosestObjectOfType(coord.x,coord.y,coord.z,0.5,GetHashKey(Config.spainprop))
    DeleteObject(object1)
    data.model=Config.closeprop
    data.coords=coord
    TriggerEvent("sam-laundrymachine:client:AddObject",data)
 
end)


function CancelPlacement()
    DeleteObject(CurrentObject)
    PlacingObject = false
    CurrentObject = nil
    CurrentObjectType = nil
    CurrentObjectName = nil
    CurrentSpawnRange = nil
    CurrentCoords = nil
    startspawn=false
end

 function RequestSpawnObject(object)
    local hash = GetHashKey(object)
    RequestModel(hash)
    while not HasModelLoaded(hash) do 
        Wait(1000)
    end
end

local function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

local function Button(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end

 function setupScaleform(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    -- draw it once to set up layout
    DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 0, 0)

    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()


    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    Button(GetControlInstructionalButton(2, 152, true))
    ButtonMessage("Cancel")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    Button(GetControlInstructionalButton(2, 153, true))
    ButtonMessage("Place object")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(2)
    Button(GetControlInstructionalButton(2, 190, true))
    Button(GetControlInstructionalButton(2, 189, true))
    ButtonMessage("Rotate object")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()

    return scaleform
end

local function RotationToDirection(rotation)
	local adjustedRotation =
	{
		x = (math.pi / 180) * rotation.x,
		y = (math.pi / 180) * rotation.y,
		z = (math.pi / 180) * rotation.z
	}
	local direction =
	{
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

local function RayCastGamePlayCamera(distance)
    local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)
	local destination =
	{
		x = cameraCoord.x + direction.x * distance,
		y = cameraCoord.y + direction.y * distance,
		z = cameraCoord.z + direction.z * distance
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestSweptSphere(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, 0.2, 339, PlayerPedId(), 4))
	return b, c, e
end

 function CreateSpawnedObject(data)
    if data.object == nil then return print("Invalid Object") end
    local object = data.object
    CurrentModel = object
    CurrentObject = CreateObject(object, 1.0, 1.0, 1.0, false, false, false)
    local heading = 0.0
    SetEntityHeading(CurrentObject, 0)
    
    SetEntityAlpha(CurrentObject, 150)
    SetEntityCollision(CurrentObject, false, false)
    -- SetEntityInvincible(CurrentObject, true)
    FreezeEntityPosition(CurrentObject, true)
    PlacingObject=true
    CreateThread(function()
        form = setupScaleform("instructional_buttons")
        while PlacingObject do
            local hit, coords, entity = RayCastGamePlayCamera(20.0)
            CurrentCoords = coords

            DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)

            if hit then
                SetEntityCoords(CurrentObject, coords.x, coords.y, coords.z)
            end
            
            if IsControlJustPressed(0, 174) then
                heading = heading + 5
                if heading > 360 then heading = 0.0 end
            end
    
            if IsControlJustPressed(0, 175) then
                heading = heading - 5
                if heading < 0 then heading = 360.0 end
            end
            
            if IsControlJustPressed(0, 44) then
                CancelPlacement()
            end

            SetEntityHeading(CurrentObject, heading)
            if IsControlJustPressed(0, 38) then
                PlaceSpawnedObject(heading)
            end
            
            local inVehicle = IsPedInAnyVehicle(ped, false)

            if inVehicle then
                CancelPlacement()
            end
            Wait(1)
        end
    end)
end
