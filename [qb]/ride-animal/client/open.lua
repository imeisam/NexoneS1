print'Pug-Animals 1.0.0'
local QBCore = exports[Config.CoreName]:GetCoreObject()
local LookingAtAnimals = false
local createdCamera = nil
local DoingTraining = false
local DoingJumpingTraining = false
local doingscene = false
local SelectedAnimal = 'a_c_deer'
local PointsEarned = 0
local ourBlip = {}
function Notify(text, status)
	QBCore.Functions.Notify(text, status)
end
function PlayerHasHoppedOnAnimal()
	-- if you want to add things to when the player has hopped on the animal
end
function PlayerHoppedOffAnimal() 
-- if you want to add things to when the player has hopped off the animal
end
function CheckIfPlayerCanHopOnAnimal()
	-- You can add more checks to if the the player should be able to get on the animal.
	-- there are already a lot of checks
	return true
end
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
local function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end
local function RandomRepIncreese(bool)
	local random = math.random(1,10)
	if bool then
		if random <= 2 then
			Notify(Config.TransLate.MinusTaiming, "success")
		end
	else
		if random <= 2 then
			Notify(Config.TransLate.PlusTaiming, "success")
		end
	end
end
local function DoEntireTrainingCleanup()
	if DoesEntityExist(HorsePed) then
		DeleteEntity(HorsePed)
	end
	DestoryCamera()
	if DoingTraining then
		DoingTraining = false
		TriggerEvent("Pug:animals:UpdatePointsUi", false)
		if DoesEntityExist(animal) then
			DeleteEntity(animal)
		end
		for _,v in pairs(Config.Day1TrainingBerricades) do
			local barricade = GetClosestObjectOfType(v.x,v.y,v.z, 10.0, GetHashKey("prop_barrier_work06a"), false, false, false)
			if barricade then
				if #(GetEntityCoords(barricade) - vector3(v.x,v.y,v.z)) < 10 then
					if DoesEntityExist(barricade) then
						DeleteEntity(barricade)
					end
				end
			end
			if DoesBlipExist(ourBlip[v.x]) then
				RemoveBlip(ourBlip[v.x])
			end
		end
	end
end
local function SelectHorseMenu()
	local bool = false
	local bool2 = true
	local bool3 = true
	local bool4 = true
	local PuchaseText = Config.TransLate.PurchaseHorse..Config.HorsePrice
	local animalprice = Config.HorsePrice
	QBCore.Functions.TriggerCallback('Pug:server:GetAnimalTable', function(data)
        if data > 0 then
			bool = true
			if data == 1 then
				bool2 = false
			elseif data == 2 then
				bool3 = false
			elseif data == 3 then
				bool4 = false
			end
		end
	end,SelectedAnimal)
	if SelectedAnimal == 'a_c_cow' then
		PuchaseText = Config.TransLate.PurchaseCow..Config.CowPrice
		animalprice = Config.CowPrice
	end
	Wait(400)
	local menu = {
		{
			header = Config.TransLate.SchoolName,
			txt = Config.TransLate.GoBack,
			params = {
				event = "Pug:client:CancleLookingAtAnimals",
			}
		},
		{
			header = Config.TransLate.Day1Training,
			disabled = bool,
			icon = "fas fa-horse",
			text = '$'..Config.TrainingPrice,
			params = {
				event = "Pug:client:DoTraining",
			}
		},
		{
			header = Config.TransLate.Day2Training,
			disabled = bool2,
			icon = "fas fa-horse",
			text = '$'..Config.TrainingPrice2,
			params = {
				event = "Pug:client:DoTrainingDay2",
			}
		},
		{
			header = Config.TransLate.Day3Training,
			disabled = bool3,
			icon = "fas fa-horse",
			text = '$'..Config.TrainingPrice3,
			params = {
				event = "Pug:client:DoTrainingDay3",
			}
		},
		{
			header = PuchaseText,
			disabled = bool4,
			icon = "fas fa-horse",
			text = '',
			params = {
				isServer = true,
				event = "Pug:server:BuyRacingAnimal",
				args = {
					animal = SelectedAnimal,
					amount = animalprice,
				}
			}
		},
		{
			header = Config.TransLate.SwapAnimal,
			disabled = false,
			icon = "fa-solid fa-arrow-rotate-left",
			text = '',
			params = {
				event = "Pug:client:SwapViewingAnimal",
			}
		}
	}
	exports[Config.Menu]:openMenu(menu)
end
local function createBlip(name, blip, coords)
    local x, y, z = table.unpack(coords)
	if DoesBlipExist(ourBlip[x]) then RemoveBlip(ourBlip[x]) ourBlip[x] = nil Wait(100) end
    ourBlip[x] = AddBlipForCoord(x, y, z)
    SetBlipSprite(ourBlip[x], blip)
    SetBlipDisplay(ourBlip[x], 2)
    SetBlipScale(ourBlip[x], 0.9)
    SetBlipColour(ourBlip[x], 0)
    SetBlipAsShortRange(ourBlip[x], false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name)
    EndTextCommandSetBlipName(ourBlip[x])
    -- return ourBlip
end
CreateThread(function()
	--==SHOOL-PED==--
	-- MainSchoolPed = Config.ScholPed
	-- LoadModel(MainSchoolPed)
	-- SchoolPed = CreatePed(2, MainSchoolPed, Config.ScholPedLoc, false, false)
	-- SetPedFleeAttributes(SchoolPed, 0, 0)
	-- SetPedDiesWhenInjured(SchoolPed, false)
	-- SetPedKeepTask(SchoolPed, true)
	-- SetBlockingOfNonTemporaryEvents(SchoolPed, true)
	-- SetEntityInvincible(SchoolPed, true)
	-- FreezeEntityPosition(SchoolPed, true)
	-- loadAnimDict("amb@world_human_aa_smoke@male@idle_a")
	-- TaskPlayAnim(SchoolPed, 'amb@world_human_aa_smoke@male@idle_a' ,'idle_c' ,8.0, -8.0, 10000, 51, 0, false, false, false)
	-- ---==SHOOL-BLIP==--
    -- local SchoolBlip = AddBlipForCoord(Config.ScholPedLoc.x, Config.ScholPedLoc.y, Config.ScholPedLoc.z)
    -- SetBlipSprite(SchoolBlip, 684)
    -- SetBlipDisplay(SchoolBlip, 3)
    -- SetBlipScale(ourSchoolBlip, 0.7)
    -- SetBlipColour(SchoolBlip, 0)
    -- SetBlipAsShortRange(SchoolBlip, false)
    -- BeginTextCommandSetBlipName("STRING")
    -- AddTextComponentString('Northern Animal School')
    -- EndTextCommandSetBlipName(SchoolBlip)
	-- --==END==--
	-- exports['qb-target']:AddBoxZone("horseschool",vector3(418.15, 6471.53, 28.81), 1, 1, {
	-- 	name="horseschool",
	-- 	heading=325,
	-- 	--debugPoly=true,
	-- 	minZ=27.81,
	-- 	maxZ=29.81,
    -- }, {
    --     options = {
    --         {
	-- 			type = "client",
    --             event = "Pug:client:AnimalSchoolMenu",
    --             icon = "fas fa-horse",
    --             label = Config.TransLate.ViewSchool,
    --         },
    --     },
    --     distance = 5.0
    -- })




	-- exports['qb-target']:AddTargetModel(GetHashKey("a_c_deer"), {
	-- 	options = {
	-- 		{
	-- 			label = 'Ride',
	-- 			icon = 'fas fa-horse',
    --             action = function(entity)
	-- 				TriggerEvent("Pug:client:DoRidingLogic",entity)
    --             end,
	-- 		}
	-- 	},
	-- 	distance = 2.0
	-- })
	-- exports['qb-target']:AddTargetModel(GetHashKey("a_c_cow"), {
	-- 	options = {
	-- 		{
	-- 			label = 'Ride',
	-- 			icon = 'fas fa-horse',
    --             action = function(entity)
	-- 				TriggerEvent("Pug:client:DoRidingLogic",entity)
    --             end,
	-- 		}
	-- 	},
	-- 	distance = 2.0
	-- })
end)
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
		if DoingTraining then
			for _,v in pairs(Config.Day1TrainingBerricades) do
				local barricade = GetClosestObjectOfType(v.x,v.y,v.z, 10.0, GetHashKey("prop_barrier_work06a"), false, false, false)
				if barricade then
					if #(GetEntityCoords(barricade) - vector3(v.x,v.y,v.z)) < 10 then
						if DoesEntityExist(barricade) then
							DeleteEntity(barricade)
						end
					end
				end
			end
			TriggerEvent("Pug:animals:UpdatePointsUi", false)
			TriggerServerEvent("Pug:server:AnimalsPlayerInstence")
		end
    end
end)
--== UNHASH THIS FOR TESTING ==--
-- RegisterCommand("horse", function()
--     local Deer = `a_c_deer`
--     LoadModel(Deer)
-- 	local SideCoordinates = GetCoordsInfrontOfEntityWithDistance(PlayerPedId(), 1.0, 90.0)
-- 	local SideHeading = GetEntityHeading(PlayerPedId())
-- 	SideCoordinates.z = GetGroundZ(SideCoordinates.x, SideCoordinates.y, SideCoordinates.z)
--     DeerLife = CreatePed(2, Deer, SideCoordinates.x,SideCoordinates.y,SideCoordinates.z, false, true)
--     SetPedFleeAttributes(DeerLife, 0, 0)
--     SetPedDiesWhenInjured(DeerLife, true)
-- 	TriggerEvent("Pug:animals:AddTargerToAnimal",DeerLife)
-- end)
RegisterNetEvent("Pug:animals:AddTargerToAnimal", function(TargetAnimal)
	exports['qb-target']:AddTargetEntity(TargetAnimal, {
		options = {
			{
				label = Config.TransLate.Ride,
				icon = 'fas fa-horse',
                action = function(entity)
					TriggerEvent("Pug:client:DoRidingLogic",entity)
                end,
			}
		},
		distance = 2.0
	})
end)
RegisterNetEvent("Pug:animals:SelectHorseMenu", function()
	SelectHorseMenu()
end)
RegisterNetEvent("Pug:client:AnimalSchoolMenu", function()
	-- FreezeEntityPosition(SchoolPed, false)
	-- loadAnimDict("gestures@m@standing@casual")
	-- TaskPlayAnim(SchoolPed, 'gestures@m@standing@casual' ,'gesture_shrug_hard' ,8.0, -8.0, 10000, 51, 0, false, false, false)
	-- TaskTurnPedToFaceCoord(SchoolPed, GetEntityCoords(PlayerPedId()))
	-- SetPedTalk(SchoolPed)
	-- PlayAmbientSpeech1(SchoolPed, 'GENERIC_HI', 'SPEECH_PARAMS_STANDARD')
	-- Wait(1200)
	-- ClearPedTasks(SchoolPed)
	-- local menu = {
	-- 	{
	-- 		header = Config.TransLate.SchoolName,
	-- 		txt = Config.TransLate.SchoolNameTxt,
	-- 		icon = "fas fa-horse",
	-- 		params = {
	-- 			event = "Pug:client:ViewHorseSchool",
	-- 		}
	-- 	},
	-- }
	-- exports[Config.Menu]:openMenu(menu)
end)
RegisterNetEvent("Pug:client:CancleLookingAtAnimals", function()
	LookingAtAnimals = false
	if DoesEntityExist(HorsePed) then
		DeleteEntity(HorsePed)
	end
	DestoryCamera()
end)
RegisterNetEvent("Pug:client:SwapViewingAnimal", function()
	if DoesEntityExist(HorsePed) then
		DeleteEntity(HorsePed)
		HorsePed = nil
	end
	if SelectedAnimal == 'a_c_cow' then
		--==HORSE-PED==--
		SelectedAnimal = 'a_c_deer'
		MainHorsePed = 'a_c_deer'
		LoadModel(MainHorsePed)
		HorsePed = CreatePed(2, MainHorsePed, Config.HorseLocation, false, false)
		while not DoesEntityExist(HorsePed) do Wait(100) end
		SetPedFleeAttributes(HorsePed, 0, 0)
		SetPedKeepTask(HorsePed, true)
		SetBlockingOfNonTemporaryEvents(HorsePed, true)
		SetEntityInvincible(HorsePed, true)
		FreezeEntityPosition(HorsePed, true)
		--==END-PEDS==--
	elseif SelectedAnimal == 'a_c_deer' then
		--==HORSE-PED==--
		SelectedAnimal = 'a_c_cow'
		MainHorsePed = 'a_c_cow'
		LoadModel(MainHorsePed)
		HorsePed = CreatePed(2, MainHorsePed, Config.HorseLocation, false, false)
		while not DoesEntityExist(HorsePed) do Wait(100) end
		SetPedFleeAttributes(HorsePed, 0, 0)
		SetPedKeepTask(HorsePed, true)
		SetBlockingOfNonTemporaryEvents(HorsePed, true)
		SetEntityInvincible(HorsePed, true)
		FreezeEntityPosition(HorsePed, true)
		--==END-PEDS==--
	end
	SelectHorseMenu()
end)

RegisterNetEvent("Pug:client:ViewHorseSchool", function()
	LookingAtAnimals = true
	--==HORSE-PED==--
	MainHorsePed = SelectedAnimal
	LoadModel(MainHorsePed)
	HorsePed = CreatePed(2, MainHorsePed, Config.HorseLocation, false, false)
	while not DoesEntityExist(HorsePed) do Wait(100) end
	SetPedFleeAttributes(HorsePed, 0, 0)
	SetPedKeepTask(HorsePed, true)
	SetBlockingOfNonTemporaryEvents(HorsePed, true)
	SetEntityInvincible(HorsePed, true)
	FreezeEntityPosition(HorsePed, true)
	--==END-PEDS==--
	SelectHorseMenu()
	CreateCamera(vector3(427.54, 6465.49, 29.20), vector3(0.0, 0.0, 140.703574), true)-- creates camera pos and rotation
	TaskTurnPedToFaceCoord(SchoolPed, vector3(417.57, 6472.0, 28.81))
	while true do
		Wait(5)
		if LookingAtAnimals then
			if IsControlJustPressed(1, 51) or IsControlJustPressed(1, 177) then
				LookingAtAnimals = false
				if DoesEntityExist(HorsePed) then
					DeleteEntity(HorsePed)
				end
				DestoryCamera()
				break
			end
		else
			break
		end
	end
	FreezeEntityPosition(SchoolPed, true)
end)
RegisterNetEvent("Pug:client:DoTraining", function()
	QBCore.Functions.TriggerCallback('Pug:server:CanDoTraining', function(bool)
        if bool then
			TriggerServerEvent("Pug:server:AnimalsPlayerInstence", true)
			local Ped = PlayerPedId()
			DoingJumpingTraining = true
			PointsEarned = 0
			LookingAtAnimals = false
			DoScreenFadeOut(500)
			Wait(500)
			if DoesEntityExist(HorsePed) then
				DeleteEntity(HorsePed)
			end
			DestoryCamera()
			local Deer = SelectedAnimal
			LoadModel(Deer)
			animal = CreatePed(2, Deer, vector3(379.16, 6525.42, 28.3), false, true)
			while not DoesEntityExist(animal) do Wait(100) end
			SetEntityHeading(animal, 91.55)
			SetPedFleeAttributes(animal, 0, 0)
			SetPedDiesWhenInjured(animal, true)
			TriggerEvent("Pug:animals:AddTargerToAnimal",animal)
			SetEntityCoords(Ped, vector4(382.59, 6518.67, 28.21, 23.94))
			SetEntityHeading(Ped, 36.83)
			TriggerEvent("Pug:HorseDisableAllControllPress", 5000)
			CreateCamera(vector3(375.64, 6521.13, 28.38), vector3(0.0, 0.0, -68.863574), true)-- creates camera pos and rotation
			TaskGoToCoordAnyMeans(Ped, vector3(379.16, 6525.42, 28.3), 1.0, 0, 0, 786603, 0xbf800000)
			Wait(1000)
			loadAnimDict("missmic4")
			TaskPlayAnim(Ped, 'missmic4' ,'michael_tux_fidget' ,8.0, -8.0, 10000, 51, 0, false, false, false)
			DoScreenFadeIn(2000)
			Wait(3000)
			DestoryCamera()
			CreateCamera(vector3(376.52, 6526.48, 29.39), vector3(0.0, 0.0, -117.595374), true)-- creates camera pos and rotation
			Wait(1500)
			DoScreenFadeOut(500)
			while not IsScreenFadedOut() do Wait(100) end
			DoingTraining = true
			TriggerEvent("Pug:horse:HandleTrainingLogic")
			TriggerEvent("Pug:client:DoRidingLogic",animal)
			DestoryCamera()
			SetEntityHeading(animal, 91.55)
			TriggerEvent("Pug:horse:CreateBarricades",1)
			Wait(1500)
			DoScreenFadeIn(1000)
			SetEntityHeading(animal, 91.55)
			TriggerEvent("Pug:animals:UpdatePointsUi", true)
			TriggerEvent("Pug:animals:HandleNegativesWhileTraining", animal)
		else
			if DoesEntityExist(HorsePed) then
				DeleteEntity(HorsePed)
			end
			DestoryCamera()
		end
	end,Config.TrainingPrice)
end)
RegisterNetEvent("Pug:HorseDisableAllControllPress", function(time)
	doingscene = true
	TriggerEvent("Pug:TimeOutKeyPressTimer",time)
	while doingscene do
		Wait(1)
		if doingscene then
			DisableAllControlActions(0)
			EnableControlAction(0, 249, true) -- Added for talking while cuffed
			EnableControlAction(0, 46, true)  -- Added for talking while cuffed
		else
			break
		end
	end
end)
RegisterNetEvent("Pug:TimeOutKeyPressTimer", function(time)
	Wait(time)
	doingscene = false
end)
RegisterNetEvent("Pug:horse:CreateBarricades", function(day)
	if day == 1 then
		for _,v in pairs(Config.Day1TrainingBerricades) do
			object = CreateObject(GetHashKey('prop_barrier_work06a'), v, false, false, false)
			SetEntityHeading(object, 87.26)
			PlaceObjectOnGroundProperly(object)
			FreezeEntityPosition(object, true)
			SetEntityInvincible(object, true)
			createBlip(v, 1, v)
		end
	end
end)
RegisterNetEvent("Pug:horse:HandleTrainingLogic", function()
	while DoingTraining do
		Wait(1)
		if DoingTraining then
			-- drawTxt("~y~ "..PointsEarned.."~w~ Points", 8,0.5,0.90,0.50,255,255,255,255)
			for _,v in pairs(Config.Day1TrainingBerricades) do
				if ClosedInfo().jumping then
					if #(GetEntityCoords(PlayerPedId()) - vector3(v.x,v.y,v.z+1)) <= 1.5 then
						local barricade = GetClosestObjectOfType(v.x,v.y,v.z, 2.0, GetHashKey("prop_barrier_work06a"), false, false, false)
						if barricade then
							if #(GetEntityCoords(barricade) - vector3(v.x,v.y,v.z)) < 2.0 then
								if GetEntitySpeed(animal) >= 3.5 then
									PlaySoundFromEntity(-1, "SELECT", PlayerPedId(), "HUD_LIQUOR_STORE_SOUNDSET", 0, 0)
									PointsEarned = PointsEarned + 1
									RandomRepIncreese()
									TriggerEvent("Pug:animals:UpdatePointsUi", true)
									Wait(700)
									if DoesEntityExist(barricade) then
										DeleteEntity(barricade)
										if DoesBlipExist(ourBlip[v.x]) then
											RemoveBlip(ourBlip[v.x])
										end
									end
								end
							end
						end
					end
				end
				local barricade = GetClosestObjectOfType(v.x,v.y,v.z, 2.0, GetHashKey("prop_barrier_work06a"), false, false, false)
				if barricade then
					if #(GetEntityCoords(barricade) - vector3(v.x,v.y,v.z)) < 2.0 then
						DrawMarker(2, v.x, v.y, v.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 255, 0, 1, 0, 0, 0, 0, 0)
					end
				end
			end
			if PointsEarned == #Config.Day1TrainingBerricades then
				DoEntireTrainingCleanup()
				DoingTraining = false
				TriggerEvent("Pug:animals:FinishTrainingScene",1, true)
				TriggerEvent("Pug:animals:UpdatePointsUi")
				Wait(700)
				Notify(Config.TransLate.CompletedTraining, "success")
				DoingJumpingTraining = false
				break
			end
		else
			DoingTraining = false
			DoingJumpingTraining = false
			TriggerEvent("Pug:animals:UpdatePointsUi")
			break
		end
	end
end)
RegisterNetEvent("Pug:animals:UpdatePointsUi", function(status)
	if status then
		exports['ps-ui']:StatusShow(Config.TransLate.DoingDay1Training, {
			"Earn ".. PointsEarned .."/"..#Config.Day1TrainingBerricades.." To complete todays training",
			-- "Points: ".. PointsEarned,
		})
	else
		exports['ps-ui']:StatusHide()
	end
end)
RegisterNetEvent("Pug:animals:HandleNegativesWhileTraining", function(MyAnimal, coords, dist)
	local Distance = dist or 550.0
	local location = coords or vector3(513.69, 6495.36, 30.04)
	local Ped = PlayerPedId()
	while DoingTraining do
		Wait(2000)
		if DoingTraining then
			local PlayerData = QBCore.Functions.GetPlayerData()
			if IsPedDeadOrDying(MyAnimal) or GetEntityHealth(MyAnimal) <= 0 or PlayerData.metadata['inlaststand'] or PlayerData.metadata['isdead'] or #(GetEntityCoords(Ped) - location) > Distance then
				DoEntireTrainingCleanup()
				DoingTraining = false
				TriggerEvent("Pug:horse:RaceBlips", true)
				TriggerEvent("Pug:animals:FinishTrainingScene")
				Wait(700)
				if #(GetEntityCoords(Ped) - location) > Distance then
					Notify(Config.TransLate.TrainingAbandoned, "error")
				else
					Notify(Config.TransLate.TrainingCanceled, "error")
				end
				break
			end
		end
	end
end)
RegisterNetEvent("Pug:animals:FinishTrainingScene", function(day, status)
	local Ped = PlayerPedId()
	DoScreenFadeOut(500)
	Wait(500)
	TriggerEvent("Pug:animals:RemovePlayerFromAnimal")
	if DoesEntityExist(HorsePed) then
		DeleteEntity(HorsePed)
	end
	DestoryCamera()
	if DoesEntityExist(animal) then
		DeleteEntity(animal)
		animal = nil
	end
	local Deer = SelectedAnimal
    LoadModel(Deer)
    SceneAnimal = CreatePed(2, Deer, vector3(436.42, 6463.34, 28.75), false, true)
	while not DoesEntityExist(SceneAnimal) do Wait(100) end
	SetEntityHeading(SceneAnimal, 184.91)
    SetPedFleeAttributes(SceneAnimal, 0, 0)
    SetPedDiesWhenInjured(SceneAnimal, true)
	SetEntityCoords(Ped, vector4(437.57, 6463.88, 28.74, 185.23))
	SetEntityHeading(Ped, 184.91)
	TriggerEvent("Pug:HorseDisableAllControllPress", 15000)
	CreateCamera(vector3(441.15, 6460.26, 28.74), vector3(0.0, 0.0, 130.630574), true)-- creates camera pos and rotation
	TaskGoToCoordAnyMeans(Ped, vector3(438.05, 6456.06, 28.74), 1.0, 0, 0, 786603, 0xbf800000)
	TaskGoStraightToCoord(SceneAnimal, vector3(437.17, 6456.23, 28.74), 1.0, 20000, 40000.0, 0.5)
	Wait(1000)
	loadAnimDict("missmic4")
	TaskPlayAnim(Ped, 'missmic4' ,'michael_tux_fidget' ,8.0, -8.0, 10000, 51, 0, false, false, false)
	DoScreenFadeIn(2000)
	Wait(7000)
	TaskTurnPedToFaceCoord(Ped, vector3(437.17, 6456.23, 28.74))
	if status then
		loadAnimDict("creatures@rottweiler@tricks@")
		TaskPlayAnim(Ped, 'creatures@rottweiler@tricks@' ,'petting_franklin' ,8.0, -8.0, 10000, 51, 0, false, false, false)
	else
		loadAnimDict("random@car_thief@agitated@idle_a")
		TaskPlayAnim(Ped, 'random@car_thief@agitated@idle_a' ,'agitated_idle_a' ,8.0, -8.0, 10000, 51, 0, false, false, false)
	end
	Wait(3000)
	DoScreenFadeOut(500)
	Wait(1000)
	ClearPedTasksImmediately(Ped)
	SetEntityHeading(Ped, 26.99)
	DestoryCamera()
	if DoesEntityExist(HorsePed) then
		DeleteEntity(HorsePed)
	end
	if DoesEntityExist(Horse) then
		DeleteEntity(Horse)
	end
	if DoesEntityExist(SceneAnimal) then
		DeleteEntity(SceneAnimal)
	end
	if DoesEntityExist(NpcAnimal) then
		DeleteEntity(NpcAnimal)
	end
	if DoesEntityExist(animal) then
		DeleteEntity(animal)
	end
	if DoesEntityExist(ArnoldNPC) then
		DeleteEntity(ArnoldNPC)
	end
	if day then
		TriggerServerEvent("Pug:server:FinishTrainingAnimal",day,SelectedAnimal)
	end
	TriggerServerEvent("Pug:server:AnimalsPlayerInstence")
	DoScreenFadeIn(2000)
end)
RegisterNetEvent("Pug:animals:FellOffAnimal", function()
	if DoingTraining then
		if DoingJumpingTraining then
			for k,v in pairs(Config.Day1TrainingBerricades) do
				if PointsEarned == k then
					object = CreateObject(GetHashKey('prop_barrier_work06a'), v, false, false, false)
					SetEntityHeading(object, 87.26)
					PlaceObjectOnGroundProperly(object)
					FreezeEntityPosition(object, true)
					SetEntityInvincible(object, true)
					createBlip(v, 1, v)
				end
			end
			if PointsEarned > 0 then
				PointsEarned = PointsEarned - 1
				TriggerEvent("Pug:animals:UpdatePointsUi", true)
				PlaySoundFromEntity(-1, "SELECT", PlayerPedId(), "HUD_LIQUOR_STORE_SOUNDSET", 0, 0)
				Notify(Config.TransLate.MinusPoints, "error")
				RandomRepIncreese(true)
			end
		end
	end
end)
--==END OF DAY 1 TRAINING==--

--== DAY TWO TRAINING==--
local horseearned = 0
RegisterNetEvent("Pug:animals:UpdatePointsUiDay2", function(status)
	if status then
		local place = 1
		if horseearned > PointsEarned then
			place = 2
		end
		exports['ps-ui']:StatusShow(Config.TransLate.DoingDay2Training, {
			Config.TransLate.BeatArnold .. PointsEarned .."/"..#Config.Day2RacePositions.." Checkpoints",
			"Position: ".. place.."/2",
		})
	else
		exports['ps-ui']:StatusHide()
	end
end)
RegisterNetEvent("Pug:client:DoTrainingDay2", function()
	QBCore.Functions.TriggerCallback('Pug:server:CanDoTraining', function(bool)
        if bool then
			TriggerServerEvent("Pug:server:AnimalsPlayerInstence", true)
			local Ped = PlayerPedId()
			PointsEarned = 0
			horseearned = 0
			LookingAtAnimals = false
			DoScreenFadeOut(500)
			Wait(500)
			if DoesEntityExist(HorsePed) then
				DeleteEntity(HorsePed)
			end
			DestoryCamera()
			local Deer = SelectedAnimal
			LoadModel(Deer)
			--PLAYER-HORSE--
			animal = CreatePed(2, Deer, vector3(386.75, 6546.46, 27.52), false, true)
			while not DoesEntityExist(animal) do wait(100) end
			SetEntityHeading(animal, 83.24)
			SetPedFleeAttributes(animal, 0, 0)
			SetPedDiesWhenInjured(animal, true)
			TriggerEvent("Pug:animals:AddTargerToAnimal",animal)
			--NPC-HORSE--
			NpcAnimal = CreatePed(2, Deer, vector3(386.63, 6548.22, 27.59), false, true)
			while not DoesEntityExist(NpcAnimal) do wait(100) end
			SetEntityHeading(NpcAnimal, 83.24)
			SetPedFleeAttributes(NpcAnimal, 0, 0)
			SetPedDiesWhenInjured(NpcAnimal, true)
			SetEntityInvincible(NpcAnimal, true)
			--NPC-PED--
			local MainSchoolPed = Config.ScholPed
			LoadModel(MainSchoolPed)
			ArnoldNPC = CreatePed(2, MainSchoolPed, vector3(386.9, 6549.12, 27.5), false, false)
			while not DoesEntityExist(ArnoldNPC) do Wait(10) end
			SetPedFleeAttributes(ArnoldNPC, 0, 0)
			SetPedDiesWhenInjured(ArnoldNPC, false)
			SetPedKeepTask(ArnoldNPC, true)
			SetBlockingOfNonTemporaryEvents(ArnoldNPC, true)
			SetEntityInvincible(ArnoldNPC, true)
			AttachEntityToEntity(ArnoldNPC, NpcAnimal, GetPedBoneIndex(NpcAnimal, 0x2E28), 0.0, 0.0, -0.08, 170.0, 0.0, -90.0, false, false, false, true, 2, true)
			loadAnimDict("amb@prop_human_seat_chair@male@generic@base")
			TaskPlayAnim(ArnoldNPC, "amb@prop_human_seat_chair@male@generic@base", "base", 8.0, 1, -1, 1, 1.0, 0, 0, 0)
			--END-CREATIONS--
			SetEntityCoords(Ped, vector3(392.42, 6545.22, 27.6))
			SetEntityHeading(Ped, 83.24)
			TriggerEvent("Pug:HorseDisableAllControllPress", 8000)
			CreateCamera(vector3(385.81, 6544.35, 28.56), vector3(0.0, 0.0, -8.663574), true)-- creates camera pos and rotation
			TaskGoToCoordAnyMeans(Ped, vector3(385.07, 6545.88, 27.53), 1.0, 0, 0, 786603, 0xbf800000)
			Wait(1000)
			loadAnimDict("missmic4")
			TaskPlayAnim(Ped, 'missmic4' ,'michael_tux_fidget' ,8.0, -8.0, 10000, 51, 0, false, false, false)
			DoScreenFadeIn(2000)
			Wait(3000)
			DestoryCamera()
			CreateCamera(vector3(380.63, 6547.01, 27.65), vector3(0.0, 0.0, -91.175374), true)-- creates camera pos and rotation
			Wait(1500)
			DoScreenFadeOut(500)
			while not IsScreenFadedOut() do Wait(100) end
			DoingTraining = true
			TriggerEvent("Pug:horse:HandleTrainingLogicDay2")
			TriggerEvent("Pug:client:DoRidingLogic",animal)
			DestoryCamera()
			SetEntityHeading(animal, 83.24)
			-- TriggerEvent("Pug:horse:RaceBlips")
			Wait(1500)
			loadAnimDict("amb@prop_human_seat_chair@male@elbows_on_knees@idle_a")
            TaskPlayAnim(ArnoldNPC, "amb@prop_human_seat_chair@male@elbows_on_knees@idle_a", "idle_a", 8.0, 1, -1, 1, 1.0, 0, 0, 0)
			DoScreenFadeIn(1000)
			SetEntityHeading(animal, 83.24)
			TriggerEvent("Pug:animals:UpdatePointsUiDay2", true)
			TriggerEvent("Pug:animals:HandleNegativesWhileTraining",animal)
		else
			if DoesEntityExist(HorsePed) then
				DeleteEntity(HorsePed)
			end
			DestoryCamera()
		end
	end,Config.TrainingPrice2)
end)
RegisterNetEvent("Pug:horse:RaceBlips", function(bool, day)
	if bool then
		if day then
			for _,v in pairs(Config.Day3RacePositions) do
				if DoesBlipExist(ourBlip[v.x]) then
					RemoveBlip(ourBlip[v.x])
				end
			end
		else
			for _,v in pairs(Config.Day2RacePositions) do
				if DoesBlipExist(ourBlip[v.x]) then
					RemoveBlip(ourBlip[v.x])
				end
			end
		end
	else
		for _,v in pairs(Config.Day2RacePositions) do
			createBlip(v, 1, v)
		end
	end
end)
RegisterNetEvent("Pug:horse:HandleTrainingLogicDay2", function()
	local set = false
	while DoingTraining do
		Wait(4)
		if DoingTraining then
			-- drawTxt("~y~ "..PointsEarned.."~w~ Points", 8,0.5,0.90,0.50,255,255,255,255)
			for k,v in pairs(Config.Day2RacePositions) do
				if #(GetEntityCoords(PlayerPedId()) - vector3(v.x,v.y,v.z)) <= 1.5 and k == (PointsEarned + 1) then
					PlaySoundFromEntity(-1, "SELECT", PlayerPedId(), "HUD_LIQUOR_STORE_SOUNDSET", 0, 0)
					PointsEarned = PointsEarned + 1
					RandomRepIncreese()
					TriggerEvent("Pug:animals:UpdatePointsUiDay2", true)
					set = false
					if DoesBlipExist(ourBlip[v.x]) then
						RemoveBlip(ourBlip[v.x])
					end
				end
				if k == (PointsEarned + 1) and not set then
					set = true
					createBlip(v, 1, v)
					if k == 1 then
						PlayAmbientSpeech1(ArnoldNPC, 'BLOCKED_GENERIC', 'SPEECH_PARAMS_STANDARD')
						TaskGoToCoordAnyMeans(NpcAnimal, vector3(v.x, v.y, v.z), 4.0, 0, 0, 786603, 0xbf800000)
					end
				end
				if #(GetEntityCoords(NpcAnimal) - vector3(v.x,v.y,v.z)) <= 2.0 and k == (horseearned + 1) then
					horseearned = horseearned + 1
					if horseearned < #Config.Day2RacePositions then
						PlayAmbientSpeech1(ArnoldNPC, 'BLOCKED_GENERIC', 'SPEECH_PARAMS_STANDARD')
						TaskGoToCoordAnyMeans(NpcAnimal, vector3(Config.Day2RacePositions[k+1].x, Config.Day2RacePositions[k+1].y, Config.Day2RacePositions[k+1].z), 4.0, 0, 0, 786603, 0xbf800000)
					else
						if horseearned > PointsEarned then
							TriggerEvent("Pug:horse:RaceBlips", true)
							DoingTraining = false
							TriggerEvent("Pug:animals:FinishTrainingScene")
							Wait(700)
							TriggerEvent("Pug:animals:UpdatePointsUiDay2", false)
							Notify(Config.TransLate.ArnoldBeatYou, "error")
						end
					end
				end
				if #(GetEntityCoords(NpcAnimal) - GetEntityCoords(PlayerPedId())) >= 50.0 and horseearned > PointsEarned then
					SetEntityMaxSpeed(SetEntityMaxSpeed(NpcAnimal, 2.0))
				else
					SetEntityMaxSpeed(SetEntityMaxSpeed(NpcAnimal, 15.0))
				end
				if k > PointsEarned then
					DrawMarker(5, v.x, v.y, v.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 4.0, 255, 255, 255, 255, 0, 1, 0, 0, 0, 0, 0)
				end
			end
			if PointsEarned == #Config.Day2RacePositions then
				DoingTraining = false
				TriggerEvent("Pug:animals:FinishTrainingScene",2, true)
				Wait(700)
				TriggerEvent("Pug:animals:UpdatePointsUiDay2", false)
				Notify(Config.TransLate.CompletedTraining, "success")
				break
			end
		else
			TriggerEvent("Pug:horse:RaceBlips", true)
			TriggerEvent("Pug:animals:UpdatePointsUiDay2", false)
			break
		end
	end
end)
RegisterNetEvent("Pug:client:DoTrainingDay3", function()
	QBCore.Functions.TriggerCallback('Pug:server:CanDoTraining', function(bool)
        if bool then
			TriggerServerEvent("Pug:server:AnimalsPlayerInstence", true)
			local Ped = PlayerPedId()
			PointsEarned = 0
			horseearned = 0
			LookingAtAnimals = false
			DoScreenFadeOut(500)
			Wait(500)
			if DoesEntityExist(HorsePed) then
				DeleteEntity(HorsePed)
			end
			DestoryCamera()
			local Deer = SelectedAnimal
			LoadModel(Deer)
			animal = CreatePed(2, Deer, vector3(424.64, 6469.17, 28.8), false, true)
			while not DoesEntityExist(animal) do Wait(100) end
			SetEntityHeading(animal, 49.1)
			SetPedFleeAttributes(animal, 0, 0)
			SetPedDiesWhenInjured(animal, true)
			TriggerEvent("Pug:animals:AddTargerToAnimal",animal)
			SetEntityCoords(Ped, vector3(414.08, 6470.86, 28.81))
			SetEntityHeading(Ped, 310.69)
			TriggerEvent("Pug:HorseDisableAllControllPress", 15000)
			CreateCamera(vector3(413.57, 6473.89, 28.81), vector3(0.0, 0.0, -95.591574), true)-- creates camera pos and rotation
			TaskGoStraightToCoord(animal, vector3(418.91, 6473.63, 28.81), 1.0, 20000, 40000.0, 0.5)
			Wait(1000)
			loadAnimDict("missmic4")
			TaskPlayAnim(Ped, 'missmic4' ,'michael_tux_fidget' ,8.0, -8.0, 10000, 51, 0, false, false, false)
			DoScreenFadeIn(2000)
			Wait(3500)
			TaskGoStraightToCoord(Ped, vector3(417.49, 6473.51, 28.81), 1.0, 20000, 40000.0, 0.5)
			Wait(3000)
			DoingTraining = true
			TriggerEvent("Pug:horse:HandleTrainingLogicDay3", animal)
			TaskTurnPedToFaceCoord(animal,vector3(418.21, 6473.09, 28.81))
			CreateCamera(vector3(418.27, 6475.15, 28.81), vector3(0.0, 0.0, 170.005374), true)-- creates camera pos and rotation
			Wait(2000)
		else
			if DoesEntityExist(HorsePed) then
				DeleteEntity(HorsePed)
			end
			DestoryCamera()
		end
	end,Config.TrainingPrice3)
end)
--==END OF DAY 3 LOGIC==--

--== DAY 4 LOGIC==-
local function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
local function ResetCrouching()
	local Player = PlayerPedId()
	SetPedMaxMoveBlendRatio(Player, 1.0)
	ResetPedMovementClipset(Player, 0.55)
	ResetPedStrafeClipset(Player)
	SetPedCanPlayAmbientAnims(Player, true)
	SetPedCanPlayAmbientBaseAnims(Player, true)
	ResetPedWeaponMovementClipset(Player)
	Wait(500)
	TriggerServerEvent('qb-walkstyles:server:walkstyles', 'get')
end
local function DisableKEyPresses()
	DisableAllControlActions(0)
	EnableControlAction(0, 249, true) -- Added for talking while cuffed
	EnableControlAction(0, 46, true)  -- Added for talking while cuffed
	EnableControlAction(1, 51, true)  -- Added for talking while cuffed
	EnableControlAction(0, 47, true)  -- Added for talking while cuffed
	EnableControlAction(0, 49, true)  -- Added for talking while cuffed
end
RegisterNetEvent("Pug:animals:UpdatePointsUiDay3", function(status,bool)
	if status then
		local place = 1
		if horseearned > PointsEarned then
			place = 2
		end
		exports['ps-ui']:StatusShow(Config.TransLate.DoingDay3Training, {
			Config.TransLate.BeatArnold .. PointsEarned .."/"..#Config.Day3RacePositions.." Checkpoints",
			"Position: ".. place.."/2",
		})
	elseif bool then
		exports['ps-ui']:StatusShow(Config.TransLate.DoingDay3Training, {
			Config.TransLate.ShowLove,
			PointsEarned.."/5",
		})
	else
		exports['ps-ui']:StatusHide()
	end
end)
RegisterNetEvent("Pug:horse:HandleTrainingLogicDay3", function(Horse)
	horseearned = 0
	Wait(1500)
	TaskTurnPedToFaceCoord(PlayerPedId(),GetEntityCoords(Horse))
	PlaySoundFromEntity(-1, "SELECT", PlayerPedId(), "HUD_LIQUOR_STORE_SOUNDSET", 0, 0)
	Notify(Config.TransLate.ShowLove, "success")
	Wait(4000)
	TriggerEvent("Pug:animals:UpdatePointsUiDay3", false, true)
	FreezeEntityPosition(Horse, true)
	PlaySoundFromEntity(-1, "SELECT", PlayerPedId(), "HUD_LIQUOR_STORE_SOUNDSET", 0, 0)
	local Ped = PlayerPedId()
	while DoingTraining do
		if DoingTraining then
			Wait(5)
			DisableKEyPresses()
			local boneIndex = GetPedBoneIndex(Horse, 0x796E)
			local x, y, z = table.unpack(GetWorldPositionOfEntityBone(Horse, boneIndex))
			DrawText3Ds(x, y, z-0.1,'[E] PET HORSE')
			if IsControlJustPressed(1, 51) then
				TaskGoToCoordAnyMeans(Ped, vector3(419.21, 6473.05, 28.81), 1.0, 0, 0, 786603, 0xbf800000)
				DestoryCamera()
				CreateCamera(vector3(418.68, 6475.44, 28.81), vector3(0.0, 0.0, 167.005374), true)-- creates camera pos and rotation
				Wait(800)
				TaskTurnPedToFaceCoord(Ped, vector3(418.52, 6473.35, 28.81))
				Wait(800)
				loadAnimDict("creatures@rottweiler@tricks@")
				TaskPlayAnim(Ped, 'creatures@rottweiler@tricks@' ,'petting_franklin' ,8.0, -8.0, 10000, 51, 0, false, false, false)
				Wait(100)
				while IsEntityPlayingAnim(Ped, "creatures@rottweiler@tricks@", "petting_franklin", 3) do Wait(5) DisableKEyPresses() end
				PlaySoundFromEntity(-1, "SELECT", PlayerPedId(), "HUD_LIQUOR_STORE_SOUNDSET", 0, 0)
				Notify(Config.TransLate.PlusTaiming, "success")
				PointsEarned = PointsEarned + 1
				TriggerEvent("Pug:animals:UpdatePointsUiDay3", false, true)
			end
			local boneIndex = GetPedBoneIndex(Horse, 0x5C01)
			local x, y, z = table.unpack(GetWorldPositionOfEntityBone(Horse, boneIndex))
			DrawText3Ds(x, y, z,'[G] CLEAN HORSE')
			if IsControlJustPressed(0, 47) then
				TaskGoToCoordAnyMeans(Ped, vector3(418.29, 6473.91, 28.81), 1.0, 0, 0, 786603, 0xbf800000)
				DestoryCamera()
				CreateCamera(vector3(416.62, 6472.51, 29.0), vector3(0.0, 0.0, -41.905374), true)-- creates camera pos and rotation
				Wait(800)
				TaskTurnPedToFaceCoord(Ped, vector3(418.52, 6473.35, 28.81))
				Wait(800)
				while not HasAnimSetLoaded('move_ped_crouched') do
					Wait(5)
					RequestAnimSet('move_ped_crouched')
				end
				SetPedMovementClipset(Ped, 'move_ped_crouched', 0.55)
				Wait(500)
				LoadModel("prop_sponge_01")
				AttachEntityToEntity("prop_sponge_01", PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.1, 0.05, 0, 80.0, 250.0, 160.0, 1, 1, 0, 1, 0, 1)
				loadAnimDict("amb@world_human_maid_clean@")
				TaskPlayAnim(Ped, 'amb@world_human_maid_clean@' ,'base' ,8.0, -8.0, 10000, 51, 0, false, false, false)
				Wait(400)
				while IsEntityPlayingAnim(Ped, "amb@world_human_maid_clean@", "base", 3) do Wait(5) DisableKEyPresses() end
				ResetCrouching()
				PlaySoundFromEntity(-1, "SELECT", PlayerPedId(), "HUD_LIQUOR_STORE_SOUNDSET", 0, 0)
				Notify(Config.TransLate.PlusTaiming, "success")
				PointsEarned = PointsEarned + 1
				TriggerEvent("Pug:animals:UpdatePointsUiDay3", false, true)
				DestoryCamera()
				CreateCamera(vector3(418.9, 6472.13, 29.31), vector3(0.0, 0.0, 26.841374), true)-- creates camera pos and rotation
			end
			local boneIndex = GetPedBoneIndex(Horse, 0x2BA6)
			local x, y, z = table.unpack(GetWorldPositionOfEntityBone(Horse, boneIndex))
			DrawText3Ds(x, y, z,'[F] FEED HORSE')
			if IsControlJustPressed(0, 49) then
				TaskGoToCoordAnyMeans(Ped, vector3(417.49, 6473.51, 28.81), 1.0, 0, 0, 786603, 0xbf800000)
				DestoryCamera()
				CreateCamera(vector3(418.27, 6475.15, 28.81), vector3(0.0, 0.0, 170.005374), true)-- creates camera pos and rotation
				Wait(800)
				TaskTurnPedToFaceCoord(Ped, vector3(418.52, 6473.35, 28.81))
				Wait(1200)
				loadAnimDict('amb@medic@standing@kneel@base')
				TaskPlayAnim(PlayerPedId(), 'amb@medic@standing@kneel@base' ,'base' ,8.0, -8.0, -1, 1, 0, false, false, false )
				loadAnimDict('anim@gangops@facility@servers@bodysearch@')
				TaskPlayAnim(PlayerPedId(), 'anim@gangops@facility@servers@bodysearch@' ,'player_search' ,8.0, -8.0, -1, 51, 0, false, false, false)
				Wait(5000)
				LoadModel("prop_food_cb_nugets")
				plantObject = CreateObject("prop_food_cb_nugets", vector3(417.92, 6473.09, 27.81), 0, 0, 0)
				FreezeEntityPosition(plantObject, true)
				SetEntityHeading(plantObject, 104.62)
				Wait(1500)
				loadAnimDict("creatures@deer@amb@world_deer_grazing@idle_a")
				TaskPlayAnim(Horse, 'creatures@deer@amb@world_deer_grazing@idle_a' ,'idle_b' ,8.0, -8.0, 10000, 51, 0, false, false, false)
				Wait(200)
				while IsEntityPlayingAnim(Horse, "creatures@deer@amb@world_deer_grazing@idle_a", "idle_b", 3) do Wait(5) DisableKEyPresses() end
				if DoesEntityExist(plantObject) then
					DeleteEntity(plantObject)
				end
				Wait(200)
				ClearPedTasks(Ped)
				Wait(700)
				PlaySoundFromEntity(-1, "SELECT", PlayerPedId(), "HUD_LIQUOR_STORE_SOUNDSET", 0, 0)
				Notify(Config.TransLate.PlusTaiming, "success")
				PointsEarned = PointsEarned + 1
				TriggerEvent("Pug:animals:UpdatePointsUiDay3", false, true)
			end
			if PointsEarned >= 4 then
				TriggerEvent("Pug:animals:UpdatePointsUiDay3")
				DoScreenFadeOut(1000)
				while not IsScreenFadedOut() do Wait(100) end
				if DoesEntityExist(Horse) then
					DeleteEntity(Horse)
				end
				DestoryCamera()
				PointsEarned = 0
				Wait(1000)
				TriggerEvent("Pug:animals:UpdatePointsUiDay3", true)
				TriggerEvent("Pug:client:DoMountChiliadRaceDay3")
				break
			end
		else
			break
		end
	end
end)

RegisterNetEvent("Pug:client:DoMountChiliadRaceDay3", function()
	local Ped = PlayerPedId()
	DoScreenFadeOut(500)
	Wait(500)
	local Deer = SelectedAnimal
	LoadModel(Deer)
	--PLAYER-HORSE--
	animal = CreatePed(2, Deer, vector3(2225.19, 5387.79, 147.82), false, true)
	while not DoesEntityExist(animal) do wait(100) end
	SetEntityHeading(animal, 29.64)
	SetPedFleeAttributes(animal, 0, 0)
	SetPedDiesWhenInjured(animal, true)
	TriggerEvent("Pug:animals:AddTargerToAnimal",animal)
	--NPC-HORSE--
	NpcAnimal = CreatePed(2, Deer, vector3(2228.15, 5388.6, 146.76), false, true)
	while not DoesEntityExist(NpcAnimal) do wait(100) end
	SetEntityHeading(NpcAnimal, 29.64)
	SetPedFleeAttributes(NpcAnimal, 0, 0)
	SetPedDiesWhenInjured(NpcAnimal, true)
	SetEntityInvincible(NpcAnimal, true)
	--NPC-PED--
	local MainSchoolPed = Config.ScholPed
	LoadModel(MainSchoolPed)
	ArnoldNPC = CreatePed(2, MainSchoolPed, vector3(2228.15, 5389.35, 146.45), false, false)
	while not DoesEntityExist(ArnoldNPC) do Wait(10) end
	SetPedFleeAttributes(ArnoldNPC, 0, 0)
	SetPedDiesWhenInjured(ArnoldNPC, false)
	SetPedKeepTask(ArnoldNPC, true)
	SetBlockingOfNonTemporaryEvents(ArnoldNPC, true)
	SetEntityInvincible(ArnoldNPC, true)
	AttachEntityToEntity(ArnoldNPC, NpcAnimal, GetPedBoneIndex(NpcAnimal, 0x2E28), 0.0, 0.0, -0.08, 170.0, 0.0, -90.0, false, false, false, true, 2, true)
	loadAnimDict("amb@prop_human_seat_chair@male@elbows_on_knees@idle_a")
    TaskPlayAnim(ArnoldNPC, "amb@prop_human_seat_chair@male@elbows_on_knees@idle_a", "idle_a", 8.0, 1, -1, 1, 1.0, 0, 0, 0)
	--END-CREATIONS--
	SetEntityCoords(Ped, vector3(2224.99, 5387.03, 147.75))
	SetEntityHeading(Ped, 83.24)
	Wait(1000)
	DoScreenFadeIn(2000)
	DoingTraining = true
	PointsEarned = 0
	TriggerEvent("Pug:horse:HandleDay3RacingLogic", NpcAnimal,ArnoldNPC)
	TriggerEvent("Pug:client:DoRidingLogic",animal)
	TriggerEvent("Pug:animals:HandleNegativesWhileTraining",animal, vector3(1389.94, 5545.98, 465.8),1500.0)
end)
RegisterNetEvent("Pug:horse:HandleDay3RacingLogic", function(NpcAnimal,ArnoldNPC)
	SetPedCanRagdoll(NpcAnimal, false)
	local set = false
	while DoingTraining do
		Wait(4)
		if DoingTraining then
			-- drawTxt("~y~ "..PointsEarned.."~w~ Points", 8,0.5,0.90,0.50,255,255,255,255)
			for k,v in pairs(Config.Day3RacePositions) do
				if #(GetEntityCoords(PlayerPedId()) - vector3(v.x,v.y,v.z)) <= 1.5 and k == (PointsEarned + 1) then
					PlaySoundFromEntity(-1, "SELECT", PlayerPedId(), "HUD_LIQUOR_STORE_SOUNDSET", 0, 0)
					PointsEarned = PointsEarned + 1
					RandomRepIncreese()
					local random = math.random(1,10)
					-- if random <= 2 then
						-- PlayAmbientSpeech1(ArnoldNPC, 'GENERIC_HI', 'SPEECH_PARAMS_STANDARD')
					-- end
					TriggerEvent("Pug:animals:UpdatePointsUiDay3", true)
					set = false
					if DoesBlipExist(ourBlip[v.x]) then
						RemoveBlip(ourBlip[v.x])
					end
				end
				if k == (PointsEarned + 1) and not set then
					set = true
					createBlip(v, 1, v)
					if k == 1 then
						SetPedTalk(ArnoldNPC)
						PlayAmbientSpeech1(ArnoldNPC, 'BLOCKED_GENERIC', 'SPEECH_PARAMS_STANDARD')
						TaskGoToCoordAnyMeans(NpcAnimal, vector3(v.x, v.y, v.z), 4.0, 0, 0, 786603, 0xbf800000)
					end
				end
				if #(GetEntityCoords(NpcAnimal) - vector3(v.x,v.y,v.z)) <= 2.0 and k == (horseearned + 1) then
					horseearned = horseearned + 1
					if horseearned < #Config.Day3RacePositions then
						SetPedTalk(ArnoldNPC)
						PlayAmbientSpeech1(ArnoldNPC, 'BLOCKED_GENERIC', 'SPEECH_PARAMS_STANDARD')
						TaskGoToCoordAnyMeans(NpcAnimal, vector3(Config.Day3RacePositions[k+1].x, Config.Day3RacePositions[k+1].y, Config.Day3RacePositions[k+1].z), 4.0, 0, 0, 786603, 0xbf800000)
					else
						if horseearned > PointsEarned then
							TriggerEvent("Pug:horse:RaceBlips", true, true)
							DoingTraining = false
							TriggerEvent("Pug:animals:FinishTrainingScene")
							Wait(700)
							TriggerEvent("Pug:animals:UpdatePointsUiDay3")
							Notify(Config.TransLate.ArnoldBeatYou, "error")
						end
					end
				end
				if #(GetEntityCoords(NpcAnimal) - GetEntityCoords(PlayerPedId())) >= 50.0 and horseearned > PointsEarned then
					SetEntityMaxSpeed(SetEntityMaxSpeed(NpcAnimal, 2.0))
				else
					SetEntityMaxSpeed(SetEntityMaxSpeed(NpcAnimal, 15.0))
				end
				if k > PointsEarned then
					DrawMarker(5, v.x, v.y, v.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 4.0, 255, 255, 255, 255, 0, 1, 0, 0, 0, 0, 0)
				end
			end
			if PointsEarned == #Config.Day3RacePositions then
				DoingTraining = false
				TriggerEvent("Pug:animals:FinishTrainingScene",3, true)
				Wait(700)
				TriggerEvent("Pug:animals:UpdatePointsUiDay3")
				Notify(Config.TransLate.CompletedTraining, "success")
				break
			end
		else
			TriggerEvent("Pug:horse:RaceBlips", true, true)
			TriggerEvent("Pug:animals:UpdatePointsUiDay3")
			break
		end
	end
end)