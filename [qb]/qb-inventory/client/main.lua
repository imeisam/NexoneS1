-- Variables
local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local PlayerJob = LocalPlayer.state.isLoggedIn and QBCore.Functions.GetPlayerData().job.dep or 'nojob'
local inInventory = false
local CurrentWeaponData = nil
local CurrentVehicle = nil
local CurrentGlovebox = nil
local CurrentTarget = nil
local isHotbar = false
local showBlur = true
local AvtiveTask = false
local nearbyPlayers = {}
local pickuploaded = false
local Pickups = {}
local SoloPickUps = {}
local bodypercent = { 
    ['HEAD'] = { percent = 0, bullets = 0, severity = false, broken = false, bleeding = false },
    ['NECK'] = { percent = 0, bullets = 0, severity = false, broken = false, bleeding = false },
    ['UPPER_BODY'] = { percent = 0, bullets = 0, severity = false, broken = false, bleeding = false },
    ['LOWER_BODY'] = { percent = 0, bullets = 0, severity = false, broken = false, bleeding = false },
    ['LARM'] = { percent = 0, bullets = 0, severity = false, broken = false, bleeding = false },
    ['RARM'] = { percent = 0, bullets = 0, severity = false, broken = false, bleeding = false },
    ['LHAND'] = { percent = 0, bullets = 0, severity = false, broken = false, bleeding = false },
    ['RHAND'] = { percent = 0, bullets = 0, severity = false, broken = false, bleeding = false },
    ['LLEG'] = { percent = 0, bullets = 0, severity = false, broken = false, bleeding = false },
    ['RLEG'] = { percent = 0, bullets = 0, severity = false, broken = false, bleeding = false },
    ['LFOOT'] = { percent = 0, bullets = 0, severity = false, broken = false, bleeding = false },
    ['RFOOT'] = { percent = 0, bullets = 0, severity = false, broken = false, bleeding = false },
    ['SPINE'] = { percent = 0, bullets = 0, severity = false, broken = false, bleeding = false },
}

exports('HasItem', function(item, amount, withbackpack)
	return QBCore.Functions.HasItem(item, amount, withbackpack)
end)

-- Functions

local function FormatWeaponAttachments(itemdata)
    local attachments = {}
    itemdata.name = itemdata.name:upper()
    if itemdata.info.attachments ~= nil and next(itemdata.info.attachments) ~= nil then
        for k, v in pairs(itemdata.info.attachments) do
            if WeaponAttachments[itemdata.name] ~= nil then
                for key, value in pairs(WeaponAttachments[itemdata.name]) do
                    if value.component == v.component then
                        item = value.item
                        attachments[#attachments+1] = {
                            attachment = key,
                            label = QBCore.Shared.Items[item].label
                        }
                    end
                end
            end
        end
    end
    return attachments
end

local function LoadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

local function OpenTrunk()
    if not TrunkAnim then
        TrunkAnim = true
        LoadAnimDict('amb@prop_human_bum_bin@idle_b')
        TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 4.0, 4.0, -1, 50, 0, false, false, false)
    end
end

local function CloseTrunk()
    LoadAnimDict('amb@prop_human_bum_bin@idle_b')
    TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "exit", 4.0, 4.0, -1, 50, 0, false, false, false)
end

local function GetDirectionFromRotation(rotation)
    local dm = (math.pi / 180)
    return vector3(-math.sin(dm * rotation.z) * math.abs(math.cos(dm * rotation.x)), math.cos(dm * rotation.z) * math.abs(math.cos(dm * rotation.x)), math.sin(dm * rotation.x))
end

local function PerformPhysics(entity)
    CreateThread(function()
        local power = 25
        FreezeEntityPosition(entity, false)
        local ped = PlayerPedId()
        local rot = GetGameplayCamRot(2)
        local dir = GetDirectionFromRotation(rot)
        SetEntityHeading(entity, rot.z + 90.0)
        SetEntityVelocity(entity, dir.x * power, dir.y * power, power * dir.z)
        Wait(2000)
        while GetEntitySpeed(entity) > 0 do
            Wait(200)
        end
        TriggerServerEvent('qb-inventory:server:ThrowSetCoords', ObjToNet(entity), GetEntityCoords(entity))
    end)
end

local function closeInventory()
    SendNUIMessage({
        action = "close",
    })
end

local function ToggleHotbar(toggle)
    if toggle then
        local items = PlayerData.items
        for i=1,5,1 do
            if items[i] then
                local itemData = QBCore.Shared.Items[items[i].name]
                if itemData then
                    items[i].image = items[i].info and items[i].info.image or 'images/'..itemData.image
                end
            end
        end
        local HotbarItems = {
            [1] = items[1],
            [2] = items[2],
            [3] = items[3],
            [4] = items[4],
            [5] = items[5]
        }
        SendNUIMessage({
            action = "toggleHotbar",
            open = true,
            items = HotbarItems
        })
    else
        SendNUIMessage({
            action = "toggleHotbar",
            open = false,
        })
    end
end


local function openAnim()
    local ped = PlayerPedId()
    LoadAnimDict('pickup_object')
    TaskPlayAnim(ped,'pickup_object', 'putdown_low', 5.0, 1.5, 1.0, 48, 0.0, 0, 0, 0)
    SetTimeout(500, function()
        StopAnimTask(ped, 'pickup_object', 'putdown_low', 1.0)
    end)
end

local function GetPlayers(onlyOtherPlayers, returnKeyValue, returnPeds)
    local players, myPlayer = {}, PlayerId()
    local active = GetActivePlayers()
    for i = 1, #active do
        local currentPlayer = active[i]
        local ped = GetPlayerPed(currentPlayer)
        if DoesEntityExist(ped) and ((onlyOtherPlayers and currentPlayer ~= myPlayer) or not onlyOtherPlayers) then
            if returnKeyValue then
                players[currentPlayer] = {entity = ped, id = GetPlayerServerId(currentPlayer)}
            else
                players[#players + 1] = returnPeds and ped or currentPlayer
            end
        end
    end
    return players
end

local function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
    local nearbyEntities = {}
    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        local playerPed = PlayerPedId()
        coords = GetEntityCoords(playerPed)
    end
    for k, v in pairs(entities) do
        local distance = #(coords - GetEntityCoords(v.entity))
        if distance <= maxDistance then
            nearbyEntities[#nearbyEntities + 1] = v.id
        end
    end
    return nearbyEntities
end

local function GetPlayersInArea(coords, maxDistance)
    return EnumerateEntitiesWithinDistance(GetPlayers(true, true), true, coords, maxDistance)
end

local function Remove3DTextPA()
    if next(nearbyPlayers) ~= nil and next(nearbyPlayers) then
        for _, id in pairs(nearbyPlayers) do
            exports['qb-interact']:RemoveGlobalPlayerInteraction("qb-inventory-give-"..id)
        end
    end
end

local function createPickup(id, coord)
	local x, y, z = table.unpack(coord)
    local model = GetHashKey('prop_paper_bag_01')
    RequestModel(model) while not HasModelLoaded(model) do Wait(2) end
    local obj = CreateObject(model,x, y, z,false,false,false)
    SetEntityAsMissionEntity(obj, true, false)
    PlaceObjectOnGroundProperly(obj)
    FreezeEntityPosition(obj, true)
    SetEntityCollision(obj, false)
    Pickups[id] = obj

    exports['qb-interact']:AddInteraction({
        coords =vector3(x, y, z - 0.75),
        distance = 5.0, 
        interactDst = 1.2,
        id = "inventory-pickup-"..id,
        name = "inventory-pickup-"..id, 
        options = {
             {
                id = "inventory-pickup-"..id, 
                label = 'Ground',
                event = "qb-inventory:client:openDrop",
                args = {id=id}
            },
        }
    })

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

local function createSoloPickup(id, object, coords, heading, label, count)
	local x, y, z = table.unpack(coords)
    local model = GetHashKey(object)
	RequestModel(model) while not HasModelLoaded(model) do Wait(2) end
    local obj = CreateObject(model,x,y,z,false,false,false)
    SetEntityHeading(obj, heading)
    PlaceObjectOnGroundProperly(obj)
    FreezeEntityPosition(obj, true)
    SetEntityCollision(obj, false)
    SoloPickUps[id] = obj

    exports['qb-interact']:AddInteraction({
        coords =vector3(x, y, z+0.2),
        distance = 5.0,
        interactDst = 1.2, 
        id = "inventory-solopickup-"..id,
        name = "inventory-solopickup-"..id,
        options = {
             {
                id = "inventory-solopickup-"..id, 
                label = count..'x '..label,
                event =  "qb-inventory:client:onPickUp",
                args = {id=id}
            },
        }
    })

end

local function CreateThoroPickup(id, coords)
    exports['qb-interact']:AddInteraction({
        coords =vector3(coords.x, coords.y, coords.z+0.2),
        distance = 5.0, 
        interactDst = 1.2, 
        id = "inventory-throwpickup-"..id, 
        name ="inventory-throwpickup-"..id, 
        options = {
             {
                id = "inventory-throwpickup-"..id,
                label ='Pickup',
                event =   "qb-inventory:client:onThrowPickUp",
                args = {id=id}
            },
        }
    })
end

-- Events

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    LocalPlayer.state:set("inv_busy", false, true)
    PlayerData = QBCore.Functions.GetPlayerData()
    PlayerJob = PlayerData.job.dep
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    LocalPlayer.state:set("inv_busy", true, true)
    PlayerJob = 'nojob'
    PlayerData = {}
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo.dep
end)

RegisterNetEvent('weapons:client:SetCurrentWeapon', function(data)
    CurrentWeaponData = data
    if not data then
        SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
        Wait(100)
        RemoveAllPedWeapons(PlayerPedId(), true)
    end
end)

RegisterNetEvent('inventory:client:ItemBox', function(itemData, type, amount, image)
    amount = amount or 1
    itemData.image = image or 'images/'..itemData.image
    SendNUIMessage({
        action = "itemBox",
        item = itemData,
        type = type,
        itemAmount = amount
    })
end)

RegisterNetEvent('inventory:client:OpenInventory', function(inventory, other,allowcuff)
    inInventory = true
    -- TriggerEvent('qb-inventory:UpdatePlayerDamage')
    local body=exports['nxo-healthsystem']:gethealthbone()

    for k,v in pairs (body) do
        bodypercent['HEAD'].percent=body['head']
        bodypercent['UPPER_BODY'].percent=body['body']
        bodypercent['RARM'].percent=body['rArm']
        bodypercent['LARM'].percent=body['lArm']
        bodypercent['RLEG'].percent=body['rLeg']
        bodypercent['LLEG'].percent=body['lLeg']
    end

   if Player(GetPlayerServerId(PlayerId())).state['isCuffed'] and (not allowcuff) then
    QBCore.Functions.Notify("Not Allow in Cuff...", "error")
        return
   end


    ToggleHotbar(false)
    if showBlur then
        TriggerScreenblurFadeIn(1000)
    end
    SetNuiFocus(true, true)
    for k, v in pairs(inventory) do
        if v.name=="jobfood" and v.info and v.info.name then
            v.label=v.info.name
        end
    end
    if other then
        for k, v in pairs(other.inventory) do
            if v.name=="jobfood" and v.info and v.info.name then
                v.label=v.info.name
            end
        end
    end
   
    SendNUIMessage({
        action = "open",
        inventory = inventory,
        slots = PlayerData.metadata.backpack and (QBCore.Config.Player.BackPackSlot + QBCore.Config.Player.MaxInvSlots) or QBCore.Config.Player.MaxInvSlots,
        other = other,
        maxweight = QBCore.Config.Player.MaxWeight,
        Ammo = {},
        clips=Config.weaponclip,
        maxammo = Config.MaximumAmmoValues,
        Name = PlayerData.charinfo.firstname .." ".. PlayerData.charinfo.lastname, 
        pName = PlayerData.charinfo.firstname .." ".. PlayerData.charinfo.lastname,
        pNumber = "" .. string.sub(PlayerData.charinfo.phone, 1, 3) .. "-" .. string.sub(PlayerData.charinfo.phone, 4, 6) .. "-" .. string.sub(PlayerData.charinfo.phone, 7),
        pCID = PlayerData.citizenid,
        pID = GetPlayerServerId(PlayerId()),
        apartment = exports['qb-apartments']:GetRoomLabel(),
        pHeadDamage = bodypercent['HEAD'].percent,
        pBodyDamage = bodypercent['UPPER_BODY'].percent,
        pRArmDamage = bodypercent['RARM'].percent,
        pLArmDamage = bodypercent['LARM'].percent,
        pRLegDamage = bodypercent['RLEG'].percent,
        pLLegDamage = bodypercent['LLEG'].percent,
        ThrowAllow=Config.ThrowAllow,
    })
end)
	
RegisterNetEvent('inventory:client:UseWeapon', function(weaponData)
    local ped = PlayerPedId()
    local weaponName = tostring(weaponData.name)
    if CurrentWeaponData and CurrentWeaponData.slot == weaponData.slot then
        TriggerEvent('weapons:client:SetCurrentWeapon', nil)
    elseif weaponName == "weapon_cash" or weaponName == "weapon_shoe" or weaponName == "weapon_stickybomb" or weaponName == "weapon_pipebomb" or weaponName == "weapon_smokegrenade" or weaponName == "weapon_flare" or weaponName == "weapon_proxmine" or weaponName == "weapon_ball"  or weaponName == "weapon_molotov" or weaponName == "weapon_grenade" or weaponName == "weapon_bzgas" then
        GiveWeaponToPed(ped, GetHashKey(weaponName), 1, false, false)
        SetPedAmmo(ped, GetHashKey(weaponName), 1)
        SetCurrentPedWeapon(ped, GetHashKey(weaponName), true)
        TriggerEvent('weapons:client:SetCurrentWeapon', weaponData)
    else
        if weaponName == "weapon_huntingrifle" then
            local HuntingZones =  {
                'CANNY',
                'CMSW',
                'CCREAK',
            }
            local inzone = false
            for k,v in pairs (HuntingZones) do
              if IsEntityInZone(PlayerPedId(),v) then
                inzone = true
              end
            end
            if not inzone then return end
        end
        local ammo = tonumber(weaponData.info.ammo or 0)
        if weaponName == "weapon_fireextinguisher" then
            ammo = 4000
        end
        SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
        Wait(100)
        RemoveAllPedWeapons(ped, true)
        Wait(100)
        GiveWeaponToPed(ped, GetHashKey(weaponName), 0, false, false)
        SetPedAmmo(ped, GetHashKey(weaponName), ammo)
        SetAmmoInClip(ped, GetHashKey(weaponName), ammo)
        SetCurrentPedWeapon(ped, GetHashKey(weaponName), true)
        if weaponData.info.attachments ~= nil then
            for _, attachment in pairs(weaponData.info.attachments) do
                GiveWeaponComponentToPed(ped, GetHashKey(weaponName), joaat(attachment.component))
            end
        end
        if weaponData.info.tint then
            SetPedWeaponTintIndex(ped, GetHashKey(weaponName), weaponData.info.tint)
        end
        TriggerEvent('weapons:client:SetCurrentWeapon', weaponData)
    end
end)

RegisterNetEvent('inventory:client:CheckWeapon', function(slot)
    if CurrentWeaponData and CurrentWeaponData.slot == slot then
        TriggerEvent('weapons:client:SetCurrentWeapon', nil, true)
    end
end)

RegisterNetEvent('qb-inventory:client:removeClip', function(slot)
    local ped = PlayerPedId()
    local weapon = GetSelectedPedWeapon(ped)
    if CurrentWeaponData and CurrentWeaponData.slot == slot then
        SetAmmoInClip(ped, weapon, 0)
        SetPedAmmo(ped, weapon, 0)
    end
end)

RegisterNetEvent('inventory:client:Close', function()
    closeInventory()
end)

RegisterNetEvent('inventory:client:setCurrentTarget', function(crr)
    CurrentTarget = crr
end)

RegisterNetEvent('qb-inventory:client:useBackPack', function(data)
    QBCore.Functions.Progressbar("use_backpack", "Backpack..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('qb-inventory:server:useBackPack', data)
    end)
end)

-- Commands

RegisterCommand('closeinv', function()
    closeInventory()
end)

AddEventHandler('onKeyDown', function(key)
    if key == 'tab' and GetVehiclePedIsTryingToEnter(PlayerPedId()) == 0 then
        if not Player(GetPlayerServerId(PlayerId())).state['isDead'] and not Player(GetPlayerServerId(PlayerId())).state['isCuffed'] and not IsPauseMenuActive() then
            if inInventory or AvtiveTask or LocalPlayer.state.inv_busy then return end
            inInventory = true
            local ped = PlayerPedId()
            local curVeh = nil
            local maxweight = 0
            local slots = 0
            CurrentVehicle = nil
            CurrentGlovebox = nil
            if IsPedInAnyVehicle(ped) then
                local vehicle = GetVehiclePedIsIn(ped, false)
                CurrentGlovebox = QBCore.Functions.GetPlate(vehicle)
                curVeh = vehicle
            else
                local vehicle, vDist = QBCore.Functions.GetClosestVehicle()
                if vehicle ~= 0 and vehicle ~= nil then
                    if GetEntityModel(vehicle) == GetHashKey('boxville7') and GetVehicleMod(vehicle, 48) == 1 then
                        local trunkpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                        if #(GetEntityCoords(ped) - trunkpos) < 2.5 then
                            if GetVehicleDoorLockStatus(vehicle) < 2 then
                                CurrentVehicle = QBCore.Functions.GetPlate(vehicle)
                                curVeh = vehicle
                            else
                                QBCore.Functions.Notify("Vehicle Locked", "error")
                            end
                        end
                    else
                        local distance = 2.0
                        local bones="boot"
                        local doorid=  Config.BackEngineVehicles[GetEntityModel(vehicle)] and 4 or 5
                        if Config.customtrunckdoor[GetEntityModel(vehicle)] then
                            doorid=Config.customtrunckdoor[GetEntityModel(vehicle)].doorid
                            bones=Config.customtrunckdoor[GetEntityModel(vehicle)].bones
                        end
                        local trunk = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle,bones))
                        local trunkExist = not ((trunk == vector3(0, 0, 0)) or IsVehicleDoorDamaged(vehicle, doorid))
                        if not trunkExist then trunk = GetEntityCoords(vehicle) distance = 3.5 end
                        if #(GetEntityCoords(ped) - trunk) <= distance then
                            if GetVehicleDoorLockStatus(vehicle) < 2 then
                                local ratio = GetVehicleDoorAngleRatio(vehicle, doorid)
                                if trunkExist and ratio > 0.0 then
                                    CurrentVehicle = QBCore.Functions.GetPlate(vehicle)
                                    curVeh = vehicle
                                else
                                    QBCore.Functions.Notify("Vehicle Trunk is Closed", "error")
                                end
                            else
                                QBCore.Functions.Notify("Vehicle Locked", "error")
                            end
                        end
                    end
                end
            end
            if CurrentVehicle then
               
                if Config.CustomTrunk[GetEntityModel(curVeh)] then
                    maxweight = Config.CustomTrunk[GetEntityModel(curVeh)].maxweight
                    slots = Config.CustomTrunk[GetEntityModel(curVeh)].slots
                elseif Config.VehiclesTrunk[GetVehicleClass(curVeh)] then
                    maxweight = Config.VehiclesTrunk[GetVehicleClass(curVeh)].maxweight
                    slots = Config.VehiclesTrunk[GetVehicleClass(curVeh)].slots
                end
                TriggerServerEvent("inventory:server:OpenInventory", "trunk", CurrentVehicle, {maxweight = maxweight, slots = slots})
                OpenTrunk()
            elseif CurrentGlovebox then
                if Config.CustomGlovebox[GetEntityModel(curVeh)] then
                    maxweight = Config.CustomGlovebox[GetEntityModel(curVeh)].maxweight
                    slots = Config.CustomGlovebox[GetEntityModel(curVeh)].slots
                elseif Config.VehiclesGlovebox[GetVehicleClass(curVeh)] then
                    maxweight = Config.VehiclesGlovebox[GetVehicleClass(curVeh)].maxweight
                    slots = Config.VehiclesGlovebox[GetVehicleClass(curVeh)].slots
                end
                TriggerServerEvent("inventory:server:OpenInventory", "glovebox", CurrentGlovebox, {maxweight = maxweight, slots = slots})
            else
                openAnim()
                TriggerServerEvent("inventory:server:OpenInventory")
            end
        end
    end
    if key=='u' then
        local body=exports['nxo-healthsystem']:gethealthbone()
        local bodyhealth={}
        for k,v in pairs (body) do
            bodyhealth['Head']=body['head']
            bodyhealth['Chest']=body['body']
            bodyhealth['RArm']=body['rArm']
            bodyhealth['LArm']=body['lArm']
            bodyhealth['RKnee']=body['rLeg']
            bodyhealth['LKnee']=body['lLeg']
        end

        SendNUIMessage({
            action = 'health',
            playerhealth = bodyhealth,
        })
        SetNuiFocus(true, true)
    end
end)

RegisterNetEvent('inventory:client:OpenFromMDT', function(name)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", name, {maxweight = 1000000, slots = 250})
end)

AddEventHandler('onKeyDown', function(key)
    if key == 'z' then
        isHotbar = not isHotbar
        if not Player(GetPlayerServerId(PlayerId())).state['isDead'] and not Player(GetPlayerServerId(PlayerId())).state['isCuffed'] and not IsPauseMenuActive() and not LocalPlayer.state.inv_busy then
            ToggleHotbar(isHotbar)
        end
    end
end)

for i = 1, 5 do
    AddEventHandler('onKeyDown', function(key)
        if key == tostring(i) then
            if not inInventory and not AvtiveTask and not Player(GetPlayerServerId(PlayerId())).state['isDead'] and not Player(GetPlayerServerId(PlayerId())).state['isCuffed'] and not IsPauseMenuActive() and not LocalPlayer.state.inv_busy then
                inInventory = true
                TriggerServerEvent("inventory:server:UseItemSlot", i)
                SetTimeout(500, function()
                    inInventory = false
                end)
            end
        end
    end)
end

RegisterNetEvent('qb-inventory:client:giveAnim', function()
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        RequestAnimDict('mp_common')
		while not HasAnimDictLoaded("mp_common") do
			Wait(7)
		end
        ClearPedSecondaryTask(PlayerPedId())
        TaskPlayAnim(PlayerPedId(), "mp_common", "givetake1_a", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
        ClearPedTasks(PlayerPedId())
    end
end)

RegisterNetEvent('qb-inventory:UpdatePlayerDamage', function(BodyParts)
	-- local GetPlayerDamage = BodyParts or exports.BC_Wounding:GetPlayerDamage()
    local GetPlayerDamage = {}
	for k, v in pairs(GetPlayerDamage) do
		if v.severity and not bodypercent[k].severity then
			bodypercent[k].percent = bodypercent[k].percent + 40
			bodypercent[k].severity = true
		end

		if not v.severity and bodypercent[k].severity then
			bodypercent[k].severity = false
			bodypercent[k].percent = bodypercent[k].percent - 40
		end

		if v.broken and not bodypercent[k].broken then
			bodypercent[k].percent = bodypercent[k].percent + 20
			bodypercent[k].broken = true
		end

		if not v.broken and bodypercent[k].broken then
			bodypercent[k].broken = false
			bodypercent[k].percent = bodypercent[k].percent - 20
		end

		if v.bleeding and not bodypercent[k].bleeding then
			bodypercent[k].percent = bodypercent[k].percent + 10
			bodypercent[k].bleeding = true
		end

		if not v.bleeding and bodypercent[k].bleeding then
			bodypercent[k].bleeding = false
			bodypercent[k].percent = bodypercent[k].percent - 10
		end

		if v.bullet and v.bullet ~= bodypercent[k].bullets then
			if v.bullet > bodypercent[k].bullets then
				local bulletCalc = math.floor(v.bullet * 10)
				bodypercent[k].percent = bodypercent[k].percent + bulletCalc
				bodypercent[k].bullets = v.bullet
			else
				local bulletCalc = math.floor(v.bullet * 10)
				bodypercent[k].percent = bodypercent[k].percent - bulletCalc
				bodypercent[k].bullets = v.bullet
			end
		end

		-- Ensure the value does not exceed 100
        if bodypercent[k].percent > 100 then
            bodypercent[k].percent = 100
		elseif bodypercent[k].percent < 0 then
			bodypercent[k].percent = 0
		end
	end
	SendNUIMessage({
		action = 'DamageCall',
		data = bodypercent
	})
end)

RegisterNetEvent('qb-inventory:resetdamageforplayer', function()
    for k, v in pairs(bodypercent) do
        v.percent = 0
        v.bullets = 0
        v.severity = false
        v.broken = false
        v.bleeding = false
    end
    SendNUIMessage({
        action = 'DamageCall',
        data = bodypercent
    })
end)

RegisterNetEvent('qb-inventory:client:GiveItem', function(data)
    if not AvtiveTask then return end
    AvtiveTask = false
    Remove3DTextPA()
    data=data.args
    TriggerServerEvent('qb-inventory:server:GiveItem', data.target, data.slot, data.amount)
end)

RegisterNetEvent('qb-inventory:client:loadpickups', function(passedPickups, passedSoloPickups, passedThrowPickups)
    if not pickuploaded then
        pickuploaded = true
        CreateThread(function()
            for id, pickup in pairs(passedPickups) do
                createPickup(id, pickup)
            end
        end)
        CreateThread(function()
            for id, pickup in pairs(passedSoloPickups) do
                createSoloPickup(id, pickup.object, pickup.coords, pickup.heading, pickup.item.label, pickup.count)
            end
        end)
        CreateThread(function()
            for id, data in pairs(passedThrowPickups) do
                CreateThoroPickup(id, data.coords)
            end
        end)
    end
end)

RegisterNetEvent('qb-inventory:client:newpickup', function(id, coord)
	createPickup(id, coord)
end)

RegisterNetEvent('qb-inventory:client:removepickup', function(id)
	if Pickups[id] then
  exports['qb-interact']:RemoveInteraction("inventory-pickup-"..id)
		DeleteObject(Pickups[id])
		Pickups[id] = nil
	end
end)

RegisterNetEvent('qb-inventory:client:openDrop', function(data)
    data=data.args
    if not inInventory and not AvtiveTask and not Player(GetPlayerServerId(PlayerId())).state['isDead'] and not Player(GetPlayerServerId(PlayerId())).state['isCuffed'] and not IsPauseMenuActive() then
        inInventory = true
        Wait(math.random(100, 300))
        TriggerServerEvent("inventory:server:OpenInventory", "drop", data.id)
    end
end)

RegisterNetEvent('qb-inventory:client:pickupAnim', function()
    RequestAnimDict("pickup_object")
    while not HasAnimDictLoaded("pickup_object") do
        Wait(1)
    end
    TaskPlayAnim(PlayerPedId(), "pickup_object", 'pickup_low', 8.0, -8.0, -1, 1, 0, false, false, false)
    Wait(2000)
    ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('qb-inventory:client:dropSoloItem', function(pickupId, object, coords, heading, label, count)
    createSoloPickup(pickupId, object, coords, heading, label, count)
end)

RegisterNetEvent('qb-inventory:client:onPickUp', function(data)
    data=data.args
    if not inInventory and not AvtiveTask and not Player(GetPlayerServerId(PlayerId())).state['isDead'] and not Player(GetPlayerServerId(PlayerId())).state['isCuffed'] and not IsPauseMenuActive() then
        Wait(math.random(100, 300))
        TriggerServerEvent("qb-inventory:server:onPickUp", data.id)
    end
end)

RegisterNetEvent('qb-inventory:clinet:removeSoloPickup', function(id)
	if SoloPickUps[id] then
        exports['qb-interact']:RemoveInteraction("inventory-solopickup-"..id)
		DeleteObject(SoloPickUps[id])
		SoloPickUps[id] = nil
	end
end)

RegisterNetEvent('qb-inventory:client:ThrowItem', function(id, coords)
    CreateThoroPickup(id, coords)
end)

RegisterNetEvent('qb-inventory:client:onThrowPickUp', function(data)
    data=data.args
    if not inInventory and not AvtiveTask and not Player(GetPlayerServerId(PlayerId())).state['isDead'] and not Player(GetPlayerServerId(PlayerId())).state['isCuffed'] and not IsPauseMenuActive() then
        Wait(math.random(100, 300))
        TriggerServerEvent("qb-inventory:server:onThrowPickUp", data.id)
    end
end)

RegisterNetEvent('qb-inventory:clinet:removeThrowPickup', function(id)
  exports['qb-interact']:RemoveInteraction("inventory-throwpickup-"..id)
end)

-- NUI

RegisterNUICallback('showBlur', function()
    showBlur = not showBlur
end)

RegisterNUICallback('Notify', function(data)
    QBCore.Functions.Notify(data.message, data.type)
end)

RegisterNUICallback('GetWeaponData', function(data, cb)
    local data = {
        WeaponData = QBCore.Shared.Items[data.weapon],
        AttachmentData = FormatWeaponAttachments(data.ItemData)
    }
    cb(data)
end)

RegisterNUICallback('RemoveAttachment', function(data, cb)
    local ped = PlayerPedId()
    local WeaponData = QBCore.Shared.Items[data.WeaponData.name]
    local label = QBCore.Shared.Items
    local Attachment = WeaponAttachments[WeaponData.name:upper()][data.AttachmentData.attachment]

    QBCore.Functions.TriggerCallback('weapons:server:RemoveAttachment', function(NewAttachments)
        if NewAttachments ~= false then
            local Attachies = {}
            RemoveWeaponComponentFromPed(ped, GetHashKey(data.WeaponData.name), GetHashKey(Attachment.component))
            for k, v in pairs(NewAttachments) do
                for wep, pew in pairs(WeaponAttachments[WeaponData.name:upper()]) do
                    if v.component == pew.component then
                        item = pew.item
                        Attachies[#Attachies+1] = {
                            attachment = pew.item,
                            label = QBCore.Shared.Items[item].label,
                        }
                    end
                end
            end
            local DJATA = {
                Attachments = Attachies,
                WeaponData = WeaponData,
            }
            cb(DJATA)
        else
            RemoveWeaponComponentFromPed(ped, GetHashKey(data.WeaponData.name), GetHashKey(Attachment.component))
            cb({})
        end
    end, data.AttachmentData, data.WeaponData)
end)

RegisterNUICallback('CombineItem', function(data)
    if QBCore.Shared.Items[data.be.name].combinable then
        local can = false
        for k,v in ipairs(QBCore.Shared.Items[data.be.name].combinable) do
            if data.az.name == v then
                can = true
                break
            end
        end
        if can then
            TriggerEvent('qb-inventory:client:combine', data.az.name, data.be.name, data)
        end
    end
end)

RegisterNUICallback("CloseInventory", function()
    TriggerServerEvent("inventory:server:closedinv")
    TriggerEvent("inventory:client:closedinv")
    if CurrentTarget ~= nil then
        TriggerServerEvent("inventory:server:SaveInventory", CurrentTarget)
        CurrentTarget = nil
    else
        local playerCoords = GetEntityCoords(PlayerPedId())
        local forward, obj = GetEntityForwardVector(PlayerPedId())
        local coords = (playerCoords + forward * 1.0)
        TriggerServerEvent("inventory:server:SaveDrop", coords)
    end
    Wait(50)
    if TrunkAnim then
        TrunkAnim = false
        CloseTrunk()
    end
    TriggerScreenblurFadeOut(1000)
    SetNuiFocus(false, false)
    Wait(700)
    inInventory = false
end)

RegisterNUICallback("UseItem", function(data)
    TriggerServerEvent("inventory:server:UseItem", data.inventory, data.item)
end)

RegisterNUICallback("SetInventoryData", function(data)
    TriggerServerEvent("inventory:server:SetInventoryData", data.fromInventory, data.toInventory, data.fromSlot, data.toSlot, data.fromAmount, data.toAmount)
end)

RegisterNUICallback("PlayDropSound", function()
    PlaySound(-1, "CLICK_BACK", "WEB_NAVIGATION_SOUNDS_PHONE", 0, 0, 1)
end)

RegisterNUICallback("PlayDropFail", function()
    PlaySound(-1, "Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds", 0, 0, 1)
end)

RegisterNUICallback('RemoveBackPack', function()
    closeInventory()
    QBCore.Functions.Progressbar("use_backpack", "Backpack..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("qb-inventory:server:removeBackPack")
    end)
end)

RegisterNUICallback('GiveItem', function(data)
    if IsPedInAnyVehicle(PlayerPedId(), false) then return end
    if data.inventory == 'player' and not AvtiveTask then
        nearbyPlayers = GetPlayersInArea(GetEntityCoords(PlayerPedId()), 5.0)
        if next(nearbyPlayers) ~= nil and next(nearbyPlayers) then
            AvtiveTask = true
            for _, id in pairs(nearbyPlayers) do
                exports['qb-interact']:addGlobalPlayerInteraction({
                    id = "qb-inventory-give-"..id, -- needed for removing interactions
                    distance =5.0, -- optional
                    interactDst = 1.3, -- optional
                    options = {
                        {
                            label = 'Give',
                            action = function(entity, t1, t2, serverId)
                                    local  data = {args={target = serverId, slot = data.item.slot, amount = data.amount}}
                                TriggerEvent("qb-inventory:client:GiveItem",data)
                              
                            end,
                        },
                    }
                })

            end
            Wait(7500)
            if AvtiveTask then
                AvtiveTask = false
                QBCore.Functions.Notify("Request timed out.", "error")
                Remove3DTextPA()
            end
        else
            QBCore.Functions.Notify("No players nearby.", "error")
        end
    end
end)

RegisterNUICallback('DropItem', function(data)
    if IsPedInAnyVehicle(PlayerPedId(), false) then return end
    if data.inventory == 'player' and not AvtiveTask then
        AvtiveTask = true
        local ModelHash = GetHashKey(Config.Objects[data.item.name] or 'prop_paper_bag_01')
        RequestModel(ModelHash)
        while not HasModelLoaded(ModelHash) do Wait(0) end
        exports['qb-core']:DrawText('Place', 'left', 'E')
        local plant = CreateObject(ModelHash, 1.0, 1.0, 1.0, 0.0, false, false)
        SetEntityCollision(plant, false, false)
        SetEntityAlpha(plant, 150, true)
        FreezeEntityPosition(plant, true)
        local ycoords = GetEntityCoords(PlayerPedId())
        ycoords=vector3(ycoords.x,ycoords.y,ycoords.z-1)
        local heading = 0.0
        while true do
            Wait(3)
            local hit, coords, entity = RayCastGamePlayCamera(10.0)
            if hit then
                if #(coords - GetEntityCoords(PlayerPedId())) < 3 then
                    ycoords = coords
                end
                SetEntityCoords(plant, ycoords.x, ycoords.y, ycoords.z)
                SetEntityHeading(plant, heading)
                if IsControlJustPressed(0, 174) then
                    heading = heading - 3.0
                end
                if IsControlJustPressed(0, 175) then
                    heading = heading + 3.0
                end
                if heading == 360.0 or heading == -360.0 then
                    heading = 0.0
                end
                if IsControlJustPressed(0, 38) then
                    exports['qb-core']:KeyPressed(38)
                    DeleteObject(plant)
                    data.coords = ycoords
                    data.heading = heading
                    TriggerEvent("qb-radio:client:checkradio")
                    TriggerServerEvent("qb-inventory:server:dropSoloItem", data)
                    AvtiveTask = false
                    return
                end
                if IsControlJustPressed(0, 202) then
                    exports['qb-core']:KeyPressed(202)
                    DeleteObject(plant)
                    AvtiveTask = false
                    return
                end
            end
        end
    end
end)

RegisterNUICallback('ThrowItem', function(data)
    if data.inventory == 'player' and not AvtiveTask then
        if QBCore.Shared.Items[data.item.name] and (Config.ThrowAllow[data.item.name] or QBCore.Shared.Items[data.item.name].type == 'weapon') then
            AvtiveTask = true
            TriggerEvent('weapons:client:SetCurrentWeapon', nil, true)
            CreateThread(function()
                RequestAnimDict("melee@thrown@streamed_core")
                while not HasAnimDictLoaded("melee@thrown@streamed_core") do
                    Wait(1)
                end
                TaskPlayAnim(PlayerPedId(), "melee@thrown@streamed_core", 'plyr_takedown_front', -8.0, 8.0, -1, 49)
                Wait(600)
                ClearPedTasks(PlayerPedId())
            end)
            Wait(580)
            local ModelHash = GetHashKey(Config.Objects[data.item.name] or 'prop_paper_bag_01')
            local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 1.0)
            RequestModel(ModelHash)
            while not HasModelLoaded(ModelHash) do
                Wait(5)
            end
            local obj = CreateObject(ModelHash, coords.x, coords.y, coords.z, true, false, true)
            SetModelAsNoLongerNeeded(ModelHash)
            SetEntityCoords(obj, coords.x, coords.y, coords.z)
            SetEntityHeading(obj, GetEntityHeading(ped) + 90.0)
            TriggerServerEvent("qb-inventory:server:ThrowItem", {data = data, net_id = ObjToNet(obj)})
            PerformPhysics(obj)
            AvtiveTask = false
        else
            QBCore.Functions.Notify("You Can Not Throw This Item!", "error")
        end
    end
end)

RegisterNUICallback("RemoveClip", function(data)
    TriggerServerEvent("inventory:server:RemoveClip", data.inventory, data.item)
end)