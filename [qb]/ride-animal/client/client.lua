local QBCore = exports[Config.CoreName]:GetCoreObject()
local IsJumping = false
local RidingAnimal = false
local BaseAnimal = nil
local Marker = Config.DrawMarker
local HasControl = false
local WalkSpeed = 2.0
local RunSpeed = 3.0
local Speed, Range = WalkSpeed, 4.0
local function LoadModel(model)
    if HasModelLoaded(model) then return end
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(0)
	end
end
local function loadAnimDict(dict) -- interactions, job,
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

function CreateCamera(coords, rot, bool)
    local rota = vector3(rot.x, rot.y, rot.z)
    local CamType = "DEFAULT_SCRIPTED_CAMERA"
    if not bool then
        rota = vector3(rot.x, rot.y, rot.z * -1)
        CamType = "DEFAULT_ANIMATED_CAMERA"
    end
    local cam = CreateCam(CamType, 1)
    SetCamCoord(cam, coords)
    SetCamRot(cam, rota)
    RenderScriptCams(1, 0, 0, 1, 1)
    if not bool then
        local animDict = 'anim_heist@hs3f@ig9_vault_drill@laser_drill@'
        loadAnimDict(animDict)
        PlayCamAnim(cam, 'intro_cam', animDict, coords.x, coords.y, coords.z, rota, 0, 2)
    end
    -- Wait(GetAnimDuration(animDict, 'intro') * 1000)
    Wait(250)
    createdCamera = cam
end
function DestoryCamera()
	if createdCamera ~= 0 then
		DestroyCam(createdCamera, 0)
		RenderScriptCams(0, 0, 1, 1, 1)
		SetFocusEntity(GetPlayerPed(ped))
		ClearPedTasksImmediately(ped)
		FreezeEntityPosition(ped, false)
		DeleteObject(overlay)
		DeleteObject(board)
		handle = nil
		createdCamera = 0
	end
end

function ClosedInfo()
	local info = {
		jumping = IsJumping,
	}
	return info
end

RegisterKeyMapping('horsejump', 'Jump your horse', 'KEYBOARD', 'SPACE')
RegisterCommand("horsejump", function()
	if HasControl then
		if not IsJumping then
			local forwardVector = GetEntityForwardVector(PlayerPedId())
			forwardVector = forwardVector * 15
			if DoesEntityExist(DeerLife) then
				local force = Config.JumpForce
				if GetEntitySpeed(BaseAnimal) > Config.RunSpeed then force = Config.RunningJumpForce else force = Config.JumpForce end
				IsJumping = true
				SetPedCanRagdoll(DeerLife, false)
				ApplyForceToEntity(DeerLife,3,vector3(forwardVector.x, forwardVector.y, force),vector3(0.0, 10.0, 0.0),0,false,true,true,false,true)
			end
			Wait(1800)
			IsJumping = false
		else
			Notify(Config.TransLate.SpamJump, "error")
		end
	end
end)

local function GetOnAnimal()
	local Ped = PlayerPedId()

	FreezeEntityPosition(BaseAnimal, true)
	FreezeEntityPosition(Ped, true)

	local AnimalPosition = GetEntityCoords(BaseAnimal, false)
	SetEntityCoords(Ped, AnimalPosition.x, AnimalPosition.y, AnimalPosition.z)

	AnimalName = "Deer"
	AnimalType = 1
	XAminalOffSet = 0.0 -- Default DEER offset
	AnimalOffSet  = 0.2  -- Default DEER offset

	if NetworkGetPlayerIndexFromPed(BaseAnimal) == -1 then
		if not HasControl then
            RidingAnimal = true
			TriggerEvent("Pug:Horse:DoMainRidingHorseLoop")
            TriggerEvent("Pug:Horse:AnimationCheckLoop")
		end
	end
	
	SetCurrentPedWeapon(Ped, "weapon_unarmed", true)
	AttachEntityToEntity(Ped, BaseAnimal, GetPedBoneIndex(BaseAnimal, 0x2E28), XAminalOffSet, 0.0, -0.08, 170.0, 0.0, -90.0, false, false, false, true, 2, true)

	if AnimalType == 1  then
        loadAnimDict("amb@prop_human_seat_chair@male@generic@base")
		TaskPlayAnim(Ped, "amb@prop_human_seat_chair@male@generic@base", "base", 8.0, 1, -1, 1, 1.0, 0, 0, 0)
	elseif AnimalType == 2 or AnimalType == 3 then
        loadAnimDict("amb@prop_human_seat_chair@male@elbows_on_knees@idle_a")
		TaskPlayAnim(Ped, "amb@prop_human_seat_chair@male@elbows_on_knees@idle_a", "idle_a", 8.0, 1, -1, 1, 1.0, 0, 0, 0)
	end

	FreezeEntityPosition(BaseAnimal, false)
	FreezeEntityPosition(Ped, false)
	PlayerHasHoppedOnAnimal()
end

local function GetGroundZ(X, Y, Z)
	if tonumber(X) and tonumber(Y) and tonumber(Z) then
		local _, GroundZ = GetGroundZFor_3dCoord(X + 0.0, Y + 0.0, Z + 0.0, Citizen.ReturnResultAnyway())
		return GroundZ
	else
		return 0.0
	end
end

local function GetCoordsInfrontOfEntityWithDistance(Entity, Distance, Heading)
	local Coordinates = GetEntityCoords(Entity, false)
	local Head = (GetEntityHeading(Entity) + (Heading or 0.0)) * math.pi / 180.0
	return {x = Coordinates.x + Distance * math.sin(-1.0 * Head), y = Coordinates.y + Distance * math.cos(-1.0 * Head), z = Coordinates.z}
end

local function DoRidingLogic()
	local Ped = PlayerPedId()
	local PedCoords = GetEntityCoords(Ped, false)
	if IsPedSittingInAnyVehicle(Ped) or IsPedGettingIntoAVehicle(Ped) then
		return
	end

	local AttachedEntity = GetEntityAttachedTo(Ped)

	if (IsEntityAttached(Ped)) and (GetEntityModel(AttachedEntity) == GetHashKey("a_c_deer") or GetEntityModel(AttachedEntity) == GetHashKey("a_c_cow") 
	    or GetEntityModel(AttachedEntity) == GetHashKey("a_c_boar")) then
		local SideCoordinates = GetCoordsInfrontOfEntityWithDistance(AttachedEntity, 1.0, 90.0)
		local SideHeading = GetEntityHeading(AttachedEntity)

		SideCoordinates.z = GetGroundZ(SideCoordinates.x, SideCoordinates.y, SideCoordinates.z)

		BaseAnimal = nil
		HasControl = false
		DetachEntity(Ped, true, false)
        RidingAnimal = false
		ClearPedSecondaryTask(Ped)
		ClearPedTasksImmediately(Ped)

		AminD2 = "amb@prop_human_seat_chair@male@elbows_on_knees@react_aggressive"
		RequestAnimDict(AminD2)
		while not HasAnimDictLoaded(AminD2) do
			Citizen.Wait(0)
		end
		TaskPlayAnim(Ped, AminD2, "exit_left", 8.0, 1, -1, 0, 1.0, 0, 0, 0)
		Wait(100)
		SetEntityCoords(Ped, SideCoordinates.x, SideCoordinates.y, SideCoordinates.z)
		SetEntityHeading(Ped, SideHeading)
		ClearPedSecondaryTask(Ped)
		ClearPedTasksImmediately(Ped)
		RemoveAnimDict(AminD2)
		PlayerHoppedOffAnimal()
	else
        local PlayerPeds = {}
        if next(PlayerPeds) == nil then
            for _, player in ipairs(GetActivePlayers()) do
                local ped = GetPlayerPed(player)
                PlayerPeds[#PlayerPeds+1] = ped
            end
        end
		local closestPed, closestDistance = QBCore.Functions.GetClosestPed(PedCoords, PlayerPeds)
        if closestDistance <= 2.0 then
            if not IsPedFalling(closestPed) and not IsPedFatallyInjured(closestPed) and not IsPedDeadOrDying(closestPed) 
                and not IsPedGettingUp(closestPed) and not IsPedRagdoll(closestPed) then
                if (GetEntityModel(closestPed) == GetHashKey("a_c_deer") or GetEntityModel(closestPed) == GetHashKey("a_c_cow")
                    or GetEntityModel(closestPed) == GetHashKey("a_c_boar")) then
                    local closestPed, closestDistance = QBCore.Functions.GetClosestPed(PedCoords, PlayerPeds)
                    if IsEntityAttachedToEntity(closestPed, PlayerPedId()) then
                        return
                    end
                    if CheckIfPlayerCanHopOnAnimal() then
                        BaseAnimal = closestPed
                        GetOnAnimal()
                    end
                end
            end
        end
	end
end

RegisterKeyMapping('getonanimal', 'Get on/off your animal', 'KEYBOARD', 'E')
RegisterCommand("getonanimal", function()
	if RidingAnimal then
		DoRidingLogic()
	end
end)

local function RemovePlayer()
	-- exports['ps-ui']:Circle(function(success)
	-- 	if success then
	-- 	else
	-- 		local Ped = PlayerPedId()
	-- 		BaseAnimal = nil
	-- 		DetachEntity(Ped, true, false)
	-- 		RidingAnimal = false
	-- 		HasControl = false
	-- 		ClearPedSecondaryTask(Ped)
	-- 		ClearPedTasksImmediately(Ped)
	-- 		Wait(100)
	-- 		SetPedToRagdoll(Ped, 1500, 1500, 0, 0, 0, 0)
	-- 		TriggerEvent("Pug:animals:FellOffAnimal")
	-- 		PlayerHoppedOffAnimal()
	-- 	end
	-- end, Config.AmountOfCircles, Config.SpeedOfcircles) -- NumberOfCircles, MS
end
RegisterNetEvent("Pug:animals:RemovePlayerFromAnimal", function()
	local Ped = PlayerPedId()
	BaseAnimal = nil
	DetachEntity(Ped, true, false)
	RidingAnimal = false
	ClearPedTasksImmediately(Ped)
	ClearPedSecondaryTask(Ped)
	HasControl = false
end)
-- RegisterCommand('addh', function()
-- 	TriggerEvent("Pug:client:SpawnPersonalOwnedAnimal","a_c_deer")
-- end)
RegisterCommand(Config.WhistleCommand, function()
	local menu = {
		{
			header = Config.TransLate.CallAnimal,
			txt = "",
			icon = "fas fa-horse",
			params = {
				event = " ",
			}
		},
	}
	QBCore.Functions.TriggerCallback('Pug:server:GetPlayerAnimals', function(data)
		local menu={}
		if data then
			
			for _,v in pairs(data) do
				local name = 'horse'
				if v.animal == 'a_c_cow' then
					name = 'cow'
				end
				menu[#menu+1] = {
					header = Config.TransLate.CallAnimal,
					txt = Config.TransLate.Call..name,
					icon = "fas fa-horse",
					params = {
						event = "Pug:client:SpawnPersonalOwnedAnimal",
						args ='cow',
					}
				}
			end
			-- if DoesEntityExist(PersonalAnimal) then
			-- 	menu[#menu+1] = {
			-- 		header = Config.TransLate.DismissAnimal,
			-- 		txt = name,
			-- 		icon = "fas fa-horse",
			-- 		params = {
			-- 			event = "Pug:client:DespawnAnimal",
			-- 		}
			-- 	}
			-- end
		else
			menu[menu+1] = {
				header = Config.TransLate.NoAnimals,
				txt = "",
				params = {
					event = " ",
				}
			}
		end
	end)
	Wait(400)
	exports[Config.Menu]:openMenu(menu)
end)
RegisterNetEvent("Pug:client:DespawnAnimal", function()
	if DoesEntityExist(PersonalAnimal) then
		DeletePed(PersonalAnimal)
		TriggerEvent("FullyDeleteVehicle",PersonalAnimal)
		PersonalAnimal = nil
	end
end)
RegisterNetEvent("Pug:client:SpawnPersonalOwnedAnimal", function(AnimalType)
	print(AnimalType)
	local Ped = PlayerPedId()
	if not DoesEntityExist(PersonalAnimal) then
		local Coords = GetEntityCoords(Ped)
		LoadModel(AnimalType)
		local found, spawnPos, spawnHeading = GetClosestVehicleNodeWithHeading(Coords.x + math.random(-5, 5), Coords.y + math.random(-5, 5), Coords.z, 0, 3, 0)
		if found then

			PersonalAnimal = CreatePed(2, AnimalType, Coords, true, true)
			while not DoesEntityExist(PersonalAnimal) do Wait(100) end
			TaskTurnPedToFaceCoord(Ped, Coords)
			Wait(500)
			loadAnimDict("taxi_hail")
			TaskPlayAnim(Ped, "taxi_hail", "hail_taxi", 8.0, 8.0, 55000, 16, 0.0, 0, 0, 0)
			TriggerEvent("Pug:animals:AddTargerToAnimal",PersonalAnimal)
			AnimalBlip = AddBlipForCoord(Coords.x, Coords.y, Coords.z)
			SetBlipSprite(AnimalBlip, 1)
			SetBlipDisplay(AnimalBlip, 2)
			SetBlipScale(AnimalBlip, 0.9)
			SetBlipColour(AnimalBlip, 0)
			SetBlipAsShortRange(AnimalBlip, false)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('animal')
			EndTextCommandSetBlipName(AnimalBlip)
			SetEntityHeading(PersonalAnimal, spawnHeading)
			TaskGoToCoordAnyMeans(PersonalAnimal, Coords, 3.0, 0, 0, 786603, 0xbf800000)
			while #(GetEntityCoords(Ped) - GetEntityCoords(PersonalAnimal)) >= 4 do
				Wait(50)
				if DoesBlipExist(AnimalBlip) then
					RemoveBlip(AnimalBlip)
					AnimalBlip = AddBlipForCoord(GetEntityCoords(PersonalAnimal).x, GetEntityCoords(PersonalAnimal).y, GetEntityCoords(PersonalAnimal).z)
					SetBlipSprite(AnimalBlip, 1)
					SetBlipDisplay(AnimalBlip, 2)
					SetBlipScale(AnimalBlip, 0.9)
					SetBlipColour(AnimalBlip, 0)
					SetBlipAsShortRange(AnimalBlip, false)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString('animal')
					EndTextCommandSetBlipName(AnimalBlip)
				end
			end
			TaskGoToCoordAnyMeans(PersonalAnimal, GetEntityCoords(Ped), 1.0, 0, 0, 786603, 0xbf800000)
			if DoesBlipExist(AnimalBlip) then
				RemoveBlip(AnimalBlip)
			end
		else
			Notify(Config.TransLate.RoadNotFound, "error")
		end
	else
		if IsPedDeadOrDying(PersonalAnimal) or GetEntityHealth(PersonalAnimal) <= 1 then
			DeleteEntity(PersonalAnimal)
			TriggerEvent("Pug:client:SpawnPersonalOwnedAnimal", AnimalType)
			return
		end
		loadAnimDict("taxi_hail")
		TaskPlayAnim(Ped, "taxi_hail", "hail_taxi", 8.0, 8.0, 55000, 16, 0.0, 0, 0, 0)
		TaskGoToCoordAnyMeans(PersonalAnimal, GetEntityCoords(Ped), 3.0, 0, 0, 786603, 0xbf800000)
		SetNewWaypoint(GetEntityCoords(PersonalAnimal).x, GetEntityCoords(PersonalAnimal).y)
		Notify(Config.TransLate.AnimalMarked, "error")
	end
end)

RegisterNetEvent("Pug:client:DoRidingLogic", function(deer)
	DeerLife = deer
	DoRidingLogic()
end)
RegisterNetEvent("Pug:Horse:DoMainRidingHorseLoop", function()
	while RidingAnimal do
		Wait(100) -- this was 0 but resmon was bad

		if RidingAnimal then
			if IsControlJustPressed(1, 51) then
				DoRidingLogic()
			end
			local Ped = PlayerPedId()
			local AttachedEntity = GetEntityAttachedTo(Ped)
	
			if (not IsPedSittingInAnyVehicle(Ped) or not IsPedGettingIntoAVehicle(Ped)) and IsEntityAttached(Ped) and AttachedEntity == BaseAnimal then
				if DoesEntityExist(BaseAnimal) then
					AnimalChecksOkay = true
					
					if IsPedFalling(AttachedEntity) or IsPedFatallyInjured(AttachedEntity) or IsPedDeadOrDying(AttachedEntity) 
					or IsPedDeadOrDying(AttachedEntity) or IsPedDeadOrDying(Ped) or IsPedGettingUp(AttachedEntity) or IsPedRagdoll(AttachedEntity) then
						HasControl = false
						AnimalChecksOkay = false
						if not IsJumping then
							RemovePlayer()
						end
					end
				
					if AnimalChecksOkay then
						local LeftAxisXNormal, LeftAxisYNormal = GetControlNormal(2, 218), GetControlNormal(2, 219)
						Speed, Range = WalkSpeed, 4.0
						if IsControlPressed(0, 21) then
							Speed = RunSpeed
							Range = 8.0
						end
						if HasControl then
							SetEntityMaxSpeed(BaseAnimal, 20.0)
							if LeftAxisXNormal == -1 and IsControlPressed(0, 21) then
								LeftAxisXNormal = -0.25
							elseif LeftAxisXNormal == 1.0 and IsControlPressed(0, 21) then
								LeftAxisXNormal = 0.25
							end
							
							local LastDirection = { x = LeftAxisXNormal, y = LeftAxisYNormal }
							local GoToOffset = GetOffsetFromEntityInWorldCoords(BaseAnimal, LeftAxisXNormal * Range, LeftAxisYNormal * -1.0 * Range, 0.0)
							TaskLookAtCoord(BaseAnimal, GoToOffset.x, GoToOffset.y, GoToOffset.z, 0, 0, 2)
							
							-- Add a check to see if the "w" key is released
							local dontrun = false
							if IsControlJustReleased(0, 87) then
								dontrun = true
								-- If the "w" key is released, move the horse in the last direction it was moving
								-- and gradually slow down and stop
								local endrange = Range
								local endspeed = Speed
								local coords = GetEntityCoords(PlayerPedId())
								local forward = GetEntityForwardVector(PlayerPedId())
								local x, y, z = table.unpack(coords + forward * endrange* 5)
								TaskGoStraightToCoord(BaseAnimal, x, y, z, endspeed, 20000, 40000.0, 0.5)
								if endspeed == WalkSpeed then
									if LeftAxisXNormal == -0.25 or LeftAxisXNormal == 0.25 then
									else
										Wait(800)
									end
								else
									if LeftAxisXNormal == -0.25 or LeftAxisXNormal == 0.25 then
									else
										Wait(math.random(1400, 2000))
									end
								end
							end
							if not dontrun then
								if IsControlJustReleased(0, 21) then
									Wait(1000)
								end
								if GetEntitySpeed(BaseAnimal) < 1 and not IsControlPressed(0, 21) then
									Speed = 1.9
									TaskGoStraightToCoord(BaseAnimal, GoToOffset.x, GoToOffset.y, GoToOffset.z, 1.9, 2000, 4000.0, 0.5)
								else
									TaskGoStraightToCoord(BaseAnimal, GoToOffset.x, GoToOffset.y, GoToOffset.z, Speed, 20000, 40000.0, 0.5)
								end
								TaskGoStraightToCoord(BaseAnimal, GoToOffset.x, GoToOffset.y, GoToOffset.z, Speed, 20000, 40000.0, 0.5)
							end
							if dontrun then
								TaskLookAtCoord(BaseAnimal, LastDirection.x, LastDirection.y, GoToOffset.z, 0, 0, 2)
							end
			
							if Marker then
								DrawMarker(6, GoToOffset.x, GoToOffset.y, GoToOffset.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 255, 255, 255, 0, 0, 2, 0, 0, 0, 0)
							end
						else
							if NetworkGetPlayerIndexFromPed(BaseAnimal) == -1 then
								HasControl = true
							end
						end
					end
				end
			end
		else
			break
		end
	end
end)

RegisterNetEvent("Pug:Horse:AnimationCheckLoop", function()
    local ran = false
    while RidingAnimal do
        Wait(4)
        if RidingAnimal then
            if IsControlPressed(0, 21) then
                if not ran then
                    ran = true
					loadAnimDict("amb@prop_human_seat_chair@male@elbows_on_knees@idle_a")
                    TaskPlayAnim(PlayerPedId(), "amb@prop_human_seat_chair@male@elbows_on_knees@idle_a", "idle_a", 8.0, 1, -1, 1, 1.0, 0, 0, 0)
                end
            end
            if IsControlJustReleased(0, 21) then
                if ran then
					TaskPlayAnim(PlayerPedId(), "amb@prop_human_seat_chair@male@generic@base", "base", 8.0, 1, -1, 1, 1.0, 0, 0, 0)
                    ran = false
					for i=1, 10 do
						Wait(200)
						WalkSpeed = RunSpeed - i * 0.1
						local endrange = Range
						local endspeed = Speed
						local coords = GetEntityCoords(PlayerPedId())
						local forward = GetEntityForwardVector(PlayerPedId())
						local x, y, z = table.unpack(coords + forward * endrange* 5)
						TaskGoStraightToCoord(BaseAnimal, x, y, z, WalkSpeed, 20000, 40000.0, 0.5)
					end
					-- Wait(500)
                end
            end
        else
            break
        end
    end
end)