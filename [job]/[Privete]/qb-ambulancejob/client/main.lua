QBCore = exports['qb-core']:GetCoreObject()

local getOutDict = 'switch@franklin@bed'
local getOutAnim = 'sleep_getup_rubeyes'
local bedOccupying = nil
local bedOccupyingData = nil
local closestBed = nil
local cam = nil
local hunger = 100
local thirst = 100
inBedDict = "anim@gangops@morgue@table@"
inBedAnim = "body_search"
isInHospitalBed = false
isDead = false
InLaststand = false
healAnimDict = "mini@cpr@char_a@cpr_str"
healAnim = "cpr_pumpchest"

-- Functions

local function GetAvailableBed(bedId,checkinname)
    local pos = GetEntityCoords(PlayerPedId())
    local retval = nil
    if bedId == nil then
        for k, _ in pairs(Config.Locations["beds"]) do
            if checkinname==Config.Locations["beds"][k].checkin then
            if not Config.Locations["beds"][k].taken then
                if #(pos - vector3(Config.Locations["beds"][k].coords.x, Config.Locations["beds"][k].coords.y, Config.Locations["beds"][k].coords.z)) < 200 then
                    retval = k
                end
            end
        end
        end
    else
        if not Config.Locations["beds"][bedId].taken then
            if #(pos - vector3(Config.Locations["beds"][bedId].coords.x, Config.Locations["beds"][bedId].coords.y, Config.Locations["beds"][bedId].coords.z))  < 200 then
                retval = bedId
            end
        end
    end
    return retval
end

local function SetClosestBed()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil
    for k, _ in pairs(Config.Locations["beds"]) do
        local dist2 = #(pos - vector3(Config.Locations["beds"][k].coords.x, Config.Locations["beds"][k].coords.y, Config.Locations["beds"][k].coords.z))
        if current then
            if dist2 < dist then
                current = k
                dist = dist2
            end
        else
            dist = dist2
            current = k
        end
    end
    if current ~= closestBed and not isInHospitalBed then
        closestBed = current
    end
end

local function loadAnimDict(dict)
	while(not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Wait(1)
	end
end



local function SetBedCam()
    isInHospitalBed = true
    local player = PlayerPedId()

    DoScreenFadeOut(1000)

    while not IsScreenFadedOut() do
        Wait(100)
    end

	if IsPedDeadOrDying(player) then
		local pos = GetEntityCoords(player, true)
		NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z, GetEntityHeading(player), true, false)
    end

    SetEntityCoords(player, bedOccupyingData.coords.x, bedOccupyingData.coords.y, bedOccupyingData.coords.z + 0.02)
    Wait(500)
    FreezeEntityPosition(player, true)

    loadAnimDict(inBedDict)

    TaskPlayAnim(player, inBedDict , inBedAnim, 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
    SetEntityHeading(player, bedOccupyingData.coords.w)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    AttachCamToPedBone(cam, player, 31085, 0, 1.0, 1.0 , true)
    SetCamFov(cam, 90.0)
    local heading = GetEntityHeading(player)
    heading = (heading > 180) and heading - 180 or heading + 180
    SetCamRot(cam, -45.0, 0.0, heading, 2)

    DoScreenFadeIn(1000)

    Wait(1000)
    FreezeEntityPosition(player, true)
end

local function LeaveBed()
    local player = PlayerPedId()

    RequestAnimDict(getOutDict)
    while not HasAnimDictLoaded(getOutDict) do
        Wait(0)
    end

    FreezeEntityPosition(player, false)
    SetEntityInvincible(player, false)
    SetEntityHeading(player, bedOccupyingData.coords.w + 90)
    TaskPlayAnim(player, getOutDict , getOutAnim, 100.0, 1.0, -1, 8, -1, 0, 0, 0)
    Wait(4000)
    ClearPedTasks(player)
    TriggerServerEvent('hospital:server:LeaveBed', bedOccupying)
    RenderScriptCams(0, true, 200, true, true)
    DestroyCam(cam, false)

    bedOccupying = nil
    bedOccupyingData = nil
    isInHospitalBed = false
	
    QBCore.Functions.GetPlayerData(function(PlayerData)
	if PlayerData.metadata["injail"] > 0 then
		TriggerEvent("prison:client:Enter", PlayerData.metadata["injail"])
	end
    end)
end

function RespawnPlayer()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    if IsPedInAnyVehicle(ped) then
        local veh = GetVehiclePedIsIn(ped)
        local vehseats = GetVehicleModelNumberOfSeats(GetHashKey(GetEntityModel(veh)))
        for i = -1, vehseats do
            local occupant = GetPedInVehicleSeat(veh, i)
            if occupant == ped then
                NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z + 0.5, heading, true, false)
                SetPedIntoVehicle(ped, veh, i)
            end
        end
    else
        NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z + 0.5, heading, true, false)
    end
end

-- Events

RegisterNetEvent('hospital:client:Revive', function()
    local player = PlayerPedId()
    isDead = false
    InLaststand = false
    Wait(100)
    SetEntityInvincible(player, false)
    Player(GetPlayerServerId(PlayerId())).state:set("isDead", false, true)
    LocalPlayer.state:set('isDead', false, true)
    TriggerEvent('police:client:DeEscort')
    TriggerEvent('qb-deathscreen:revive')
    if IsEntityDead(player) then
        RespawnPlayer()
    end
    SetEntityMaxHealth(player, 200)
    if exports['nxo-paintball']:IsInPaintball() then
        SetEntityHealth(player, 200)
    else
        SetEntityHealth(player, 150)
    end
   
    ClearPedBloodDamage(player)
    SetPlayerSprint(PlayerId(), true)
    if hunger < 10 then
        TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", 10)
    end
    if thirst < 10 then
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", 10)
    end
    ResetPedMovementClipset(player, 0.0)
    TriggerServerEvent("hospital:server:SetDeathStatus", false)
    TriggerServerEvent("hospital:server:SetLaststandStatus", false)
    QBCore.Functions.Notify(Lang:t('info.healthy'))
    Wait(100)
    ClearPedTasks(player)
    if isInHospitalBed then
        LeaveBed()
    end
    TriggerEvent('animation:ResettoOldWalk')
end)

RegisterNetEvent('hospital:client:KillPlayer', function()
    SetEntityHealth(PlayerPedId(), 0)
end)

RegisterNetEvent('hospital:client:SendToBed', function(id, data)
    bedOccupying = id
    bedOccupyingData = data
    SetBedCam()
    CreateThread(function ()
        Wait(5)
        QBCore.Functions.Notify(Lang:t('success.being_helped'), 'success')
        Wait(Config.AIHealTimer * 1000)
        TriggerEvent("hospital:client:Revive")
    end)
end)

RegisterNetEvent('hospital:client:SetBed', function(id, isTaken)
    Config.Locations["beds"][id].taken = isTaken
end)

RegisterNetEvent('hospital:client:SendBillEmail', function(amount)
    SetTimeout(math.random(2500, 4000), function()
        local gender = Lang:t('info.mr')
        if QBCore.Functions.GetPlayerData().charinfo.gender == 1 then
            gender = Lang:t('info.mrs')
        end
        local charinfo = QBCore.Functions.GetPlayerData().charinfo
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = Lang:t('mail.sender'),
            subject = Lang:t('mail.subject'),
            message = Lang:t('mail.message', {gender = gender, lastname = charinfo.lastname, costs = amount}),
            button = {}
        })
    end)
end)

RegisterNetEvent('hud:client:UpdateNeeds', function(newHunger, newThirst)
    hunger = newHunger
    thirst = newThirst
end)

RegisterNetEvent('hospital:client:adminHeal', function()
    local ped = PlayerPedId()
    SetEntityHealth(ped, 200)
    TriggerServerEvent('hud:server:RelieveStress', 100)
    TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", 100)
    TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", 100)
end)

RegisterNetEvent('hospital:client:Heal', function()
    local ped = PlayerPedId()
    SetEntityHealth(ped, 200)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    local ped = PlayerPedId()
    if bedOccupying then
        TriggerServerEvent("hospital:server:LeaveBed", bedOccupying)
    end
    isDead = false
    Player(GetPlayerServerId(PlayerId())).state:set("isDead", false, true)
    LocalPlayer.state:set('isDead', false, true)
    deathTime = 0
    SetPedArmour(ped, 0)
end)

-- Threads

CreateThread(function()
    for _, station in pairs(Config.Locations["stations"]) do
        local blip = AddBlipForCoord(station.coords.x, station.coords.y, station.coords.z)
        SetBlipSprite(blip, 61)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 25)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(station.label)
        EndTextCommandSetBlipName(blip)
    end
end)

RegisterNetEvent('qb-ambulancejob:checkinpatient', function(data)
    QBCore.Functions.TriggerCallback('hospital:GetOnlineDoctors', function(count,Manualcheckin)
        if (count >= Config.MinimalDoctors and not Manualcheckin[data.args.typemd]) then  
            QBCore.Functions.Notify("There are enough Doctors.Now Calling Doktors", 'error')
            TriggerEvent('qb-dispatch:client:sendEmergencyMsg',"Checking Call", "311", false,true)
        else
            local player, distance = GetClosestPlayer()
            local playerId = GetPlayerServerId(player)
            TriggerServerEvent("qb-ambulancejob:server:checkinpatient", data,playerId)
        end
    end)

  
end)
local checkin=false
RegisterNetEvent('qb-ambulancejob:checkin', function(data)
    QBCore.Functions.TriggerCallback('hospital:GetOnlineDoctors', function(count,Manualcheckin)
        if (count >= Config.MinimalDoctors and not Manualcheckin[data.args.typemd]) then  
            QBCore.Functions.Notify("There are enough Doctors.Now Calling Doktors", 'error')
            TriggerEvent('qb-dispatch:client:sendEmergencyMsg',"Checking Call", "311", false,true)
            return
        else
           if  checkin then return end
            TriggerEvent('animations:client:EmoteCommandStart', {"notepad"})
            checkin=true
            QBCore.Functions.Progressbar("hospital_checkin", Lang:t('progress.checking_in'), 2000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                local bedId = GetAvailableBed(nil,data.args.name)
                if bedId then
                    TriggerServerEvent("hospital:server:SendToBed", bedId)
                else
                    QBCore.Functions.Notify(Lang:t('error.beds_taken'), "error")
                end
                Wait(2000)
                checkin=false
            end, function() -- Cancel
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                QBCore.Functions.Notify(Lang:t('error.canceled'), "error")
                checkin=false
            end)
        end
    end)
end)

RegisterNetEvent('qb-ambulancejob:giveStretcher', function(data)
 model =GetHashKey("trump-stretcher")
 RequestModel(model)
 while not HasModelLoaded(model) do Citizen.Wait(0) end
 local vehicle = CreateVehicle(model,  data.args.coord.x,  data.args.coord.y,  data.args.coord.z, true, true)
 SetVehicleExtra(vehicle, 7,1)
 SetVehicleExtra(vehicle, 6,1)
 SetVehicleExtra(vehicle, 5,1)
 SetVehicleExtra(vehicle, 3,1)
 SetVehicleExtra(vehicle, 12,1)
 SetVehicleExtra(vehicle, 1,1)
 SetVehicleExtra(vehicle, 2,0)
 SetModelAsNoLongerNeeded(model)
 SetVehicleOnGroundProperly(vehicle)
 TriggerServerEvent('qb-vehiclekeys:server:setVehLockState', NetworkGetNetworkIdFromEntity(vehicle), 2)
end)

RegisterNetEvent('qb-ambulancejob:takeStretcher', function()
    local entity = GetClosestVehicle( GetEntityCoords(GetPlayerPed(-1)), 4.0, GetHashKey("trump-stretcher"), 70)
    DeleteVehicle(entity)
   end)

   RegisterNetEvent('qb-ambulancejob:usermri', function()
    QBCore.Functions.Notify("MRI Starting...", "success")
    TriggerServerEvent('InteractSound_SV:PlayWithinDistancebycoord',1.5, 'mri',0.6,vector3(310.53842163086, -567.71136474609, 43.267578125))
   end)

   RegisterNetEvent('qb-ambulancejob:gotocustombed', function(data)
    if bedoncustombed then  TriggerEvent('qb-ambulancejob:leavecustombed', data) return end
    bedoncustombed=true
    local player = PlayerPedId()
    -- DoScreenFadeOut(1000)
    -- while not IsScreenFadedOut() do
    --     Wait(100)
    -- end
    SetEntityCollision(player, false)
	if IsPedDeadOrDying(player) then
		local pos = GetEntityCoords(player, true)
		NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z, GetEntityHeading(player), true, false)
    end

    SetEntityCoords(player, Config.custombed[data.args.bedid].coord.x,Config.custombed[data.args.bedid].coord.y, Config.custombed[data.args.bedid].coord.z + 0.02)
    Wait(500)
    FreezeEntityPosition(player, true)
    
    loadAnimDict(inBedDict)

    TaskPlayAnim(player, inBedDict , inBedAnim, 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
    SetEntityHeading(player, Config.custombed[data.args.bedid].coord.w)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    AttachCamToPedBone(cam, player, 31085, 0, 1.0, 1.0 , true)
    SetCamFov(cam, 90.0)
    local heading = GetEntityHeading(player)
    heading = (heading > 180) and heading - 180 or heading + 180
    SetCamRot(cam, -45.0, 0.0, heading, 2)

    -- DoScreenFadeIn(1000)

    -- Wait(1000)
    FreezeEntityPosition(player, true)


    
   end)

   RegisterNetEvent('qb-ambulancejob:leavecustombed', function(data)
   
    bedoncustombed=false
    local player = PlayerPedId()
    SetEntityCollision(player, true)
    -- RequestAnimDict(getOutDict)
    -- while not HasAnimDictLoaded(getOutDict) do
    --     Wait(0)
    -- end
    FreezeEntityPosition(player, false)
    SetEntityInvincible(player, false)
    SetEntityHeading(player, Config.custombed[data.args.bedid].coord.w + 90)
    -- TaskPlayAnim(player, getOutDict , getOutAnim, 100.0, 1.0, -1, 8, -1, 0, 0, 0)
    -- Wait(4000)
    ClearPedTasks(player)
    RenderScriptCams(0, true, 200, true, true)
    DestroyCam(cam, false)
    
   end)


local bedoncustombed=false
CreateThread(function()
    for k, v in pairs(Config.custombed) do
        exports['qb-interact']:AddInteraction({
            coords =v.interactcoord,
            distance =3.0,
            interactDst =1.5, 
            id = "custombed"..k,
            name = "custombed"..k,
            options = {
                 {
                    label = "Bed",
                    event ="qb-ambulancejob:gotocustombed",
                    args = {bedid=k},
                    canInteract = function()
                        return not bedoncustombed
                    end,
                },
                {
                    label = "Leave Bed",
                    event ="qb-ambulancejob:leavecustombed",
                    args = {bedid=k},
                    canInteract = function()
                        return bedoncustombed
                    end,
                },
                
            }
        })
    end

    exports['qb-interact']:AddInteraction({
        coords =vector3(313.43344116211, -568.40679931641, 43.267578125),
        distance = 3.0,
        interactDst = 1.5, 
        id = "mri",
        name = "mri",
        groups = {
            ['ambulance'] = 0, 
        },
        options = {
             {
                label = "Use MRI",
                event ="qb-ambulancejob:usermri",
                args = {},
            },
            {
                label = "Use Printer",
                event = "qb-printer:client:openInteraction",
                args = {}
            },
        }
    })

    exports['qb-interact']:AddInteraction({
        coords =vector3(314.09637451172, -584.24456787109, 43.26762008667),
        distance = 3.0,
        interactDst = 1.5, 
        id = "mdprinter",
        name = "mdprinter",
        groups = {
            ['ambulance'] = 0, 
        },
        options = {
            {
                label = "Use Printer",
                event = "qb-printer:client:openInteraction",
                args = {}
            },
        }
    })

    
    ----spawn stretcher
    for k, v in pairs(Config.Locations["Stretcher"]) do
        exports['qb-interact']:AddInteraction({
            coords =v.coords,
            distance = 5.0,
            interactDst = 1.2, 
            id = "md-stretcher"..k,
            name = "md-stretcher"..k,
            groups = {
                ['ambulance'] = 0, 
            },
            options = {
                 {
                    label = "Take Stretcher",
                    event ="qb-ambulancejob:giveStretcher",
                    args = {coord=v.spawn},
                },
                {
                    label = "Despawn Stretcher",
                    event ="qb-ambulancejob:takeStretcher",
                    canInteract = function()
                        local entity = GetClosestVehicle( GetEntityCoords(GetPlayerPed(-1)), 4.0, GetHashKey("trump-stretcher"), 70)
                        return  DoesEntityExist(entity)
                    end,
                },
                
            }
        })
    end
    local model = GetHashKey('s_m_m_doctor_01')
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end

    for k, v in pairs(Config.Locations["checking"]) do
        if v.type and v.type=="npc" then
            local npc = CreatePed(4, model, v.coord.x, v.coord.y,v.coord.z,v.coord.w, false, true)
            SetEntityHeading(npc,  v.coord.w)
            FreezeEntityPosition(npc, true)
            SetEntityInvincible(npc, true)
            SetBlockingOfNonTemporaryEvents(npc, true)
            TaskStartScenarioInPlace(npc, "WORLD_HUMAN_CLIPBOARD", 0, true)
            SetPedKeepTask(npc, true)
            exports['qb-interact']:AddEntityInteraction({
                netId = npc,
                distance =v.distance or 3.0,
                interactDst =v.interactDst or 2.1, 
                offset = vec3(0.0, 0.0, 0.0),
                id = "checking"..k,
                name = "checking"..k,
                options = {
                     {
                        id = "checking"..k,
                        label = "Check In Self",
                        event ="qb-ambulancejob:checkin",
                        args = {name=v.name,typemd=v.type}
                    },
                }
            })

        else
            exports['qb-interact']:AddInteraction({
                coords =vector3(v.coord.x, v.coord.y, v.coord.z+0.2),
                distance =v.distance or 3.0,
                interactDst =v.interactDst or 2.1, 
                id = "checking"..k,
                name = "checking"..k,
               
                options = {
                     {
                        id = "checking"..k,
                        label = "Check In",
                        event ="qb-ambulancejob:checkin",
                        args = {name=v.name,typemd=v.type}
                    },
                    {
                        id = "checkingperson"..k,
                        label = "Check In Patient",
                        event ="qb-ambulancejob:checkinpatient",
                        args = {name=v.name,typemd=v.type},
                        canInteract = function()
                            local jobs=QBCore.Functions.GetPlayerData().job.name
                            local player, distance = GetClosestPlayer()
                            if player ~= -1 and distance < 2.5 and (jobs=="ambulance" or jobs=="police" or jobs=="goverment" or jobs=="justice") then
                               return true
                            else
                                return false
                            end
                        end,
                    },
                }
            })
        end
           
       
    end

end)