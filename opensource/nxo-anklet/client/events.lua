QBCore = exports['qb-core']:GetCoreObject()
animName = "" 
animDict = "" 
cuffed = false
cuffs = nil
ped = nil
rope = nil 
elrope = nil
bagliyim = false
HaveBagOnHead = false
cuval = nil
zatenbantli = false
dragStatus = {
	isDragged = false,
	carry_status = false,
	copId = 0
}
pped = nil 
tped = nil
bagliyorum = false
trackedPlayers = {}

RegisterNetEvent("cuff:client:shock")
AddEventHandler("cuff:client:shock", function()
	QBCore.Functions.Notify("You Shocked With Anklet", "info")
	local dict = "stungun@standing"
	RequestAnimDict(dict) 
	if QBCore.Functions.GetPlayerData().charinfo.gender == 0 then --male
		TriggerServerEvent("InteractSound_SV:PlayWithinDistance",4.0, "electricshockMale", 0.2)
	else
		TriggerServerEvent("InteractSound_SV:PlayWithinDistance",4.0, "electricshockFemale", 0.2)
	end
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(0)
	end

    TaskPlayAnim(GetPlayerPed(-1), dict, "damage", 8.0, 1.0, 1500, 1, 0, false, false, false)

	for i = 0, 15, 1 do 
		SetEntityHealth(GetPlayerPed(-1), GetEntityHealth(GetPlayerPed(-1)) - 1)
		Citizen.Wait(100)
	end

	SetPedToRagdoll(GetPlayerPed(-1), 4000, 4000, 0, 0, 0, 0)
end)

RegisterNetEvent('s4-cuff:drag')
AddEventHandler('s4-cuff:drag', function(cop)


    if not cop  then 
        local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
        
        if closestPlayer ~= -1 and closestDistance <= 2.0 then
            TriggerServerEvent('s4-cuff:drag', GetPlayerServerId(closestPlayer))
        else
			QBCore.Functions.Notify(Config.Lang["no_one_nearby_cuff"], "error")
        end 

        return
    end
 
    dragStatus.isDragged = not dragStatus.isDragged
    dragStatus.CopId = cop
	dragStatus.carry_status = true
end)

RegisterNetEvent('s4-cuff:client:halat')
AddEventHandler('s4-cuff:client:halat', function()
   local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()

   if closestPlayer ~= -1 and closestDistance <= 2.0 then

	bagliyorum = true

	local dict = "amb@prop_human_bum_bin@idle_a"
	RequestAnimDict(dict) 
   
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(0)
	end
   
	TaskPlayAnim(GetPlayerPed(-1), dict, "idle_a", 8.0, 1.0, 3000, 1, 0, false, false, false)

	TriggerServerEvent('s4-cuff:client:halat_baglanan', GetPlayerServerId(closestPlayer))
	TriggerEvent("s4-cuff:client:halat_baglayan")

	Wait(3000)

	bagliyorum = false
   	else
		QBCore.Functions.Notify(Config.Lang["no_one_nearby_cuff"], "error")
   	end 
end)
 
RegisterNetEvent('s4-cuff:client:halat_baglayan')
AddEventHandler('s4-cuff:client:halat_baglayan', function()
	if not IsPedSittingInAnyVehicle(PlayerPedId()) then
		return
	end

	if bagliyim == true then 
		return
	end

	local dict = "amb@prop_human_bum_bin@idle_a"
	RequestAnimDict(dict) 

	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(0)
	end

    TaskPlayAnim(GetPlayerPed(-1), dict, "idle_a", 8.0, 1.0, 1500, 1, 0, false, false, false)

	ped = GetPlayerPed(PlayerId())
	loadModel("prop_trevor_rope_01")
	loadDict("anim@heists@fleeca_bank@scope_out@return_case")
	TaskPlayAnim(GetPlayerPed(PlayerId()), "anim@heists@fleeca_bank@scope_out@return_case", "trevor_action", 2.0, 2.0, 1.5, 2, 0, false, false, false)
	Wait(2000)
	FreezeEntityPosition(GetPlayerPed(PlayerId()), true)
	elrope = CreateObject(GetHashKey("prop_trevor_rope_01"), GetPlayerPed(PlayerId()), true, true, true);

	networkId = ObjToNet(elrope)
	SetNetworkIdExistsOnAllMachines(networkId, true)
	SetNetworkIdCanMigrate(networkId, false)
	NetworkSetNetworkIdDynamic(networkId, true)

	AttachEntityToEntity(elrope, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 60309), 0.20, 0.0, 0.0, 265.0, -10.0, 100.0, true, false, false, false, 0, true);
 
	SetPedUsingActionMode(GetPlayerPed(PlayerId()), false, -1, "DEFAULT_ACTION")
	SetPedMovementClipset(GetPlayerPed(PlayerId()), 'move_ped_crouched', 0.55)
	SetPedStrafeClipset(GetPlayerPed(PlayerId()), 'move_ped_crouched_strafing')
	TaskPlayAnim(GetPlayerPed(PlayerId()), "mp_arresting", "a_uncuff", 2.0, 2.0, 1.5, 16, 0, false, false, false)
	Wait(2000)

	DeleteObject(elrope)
	FreezeEntityPosition(GetPlayerPed(PlayerId()), false)
end)

RegisterNetEvent('s4-cuff:client:halat_baglanan')
AddEventHandler('s4-cuff:client:halat_baglanan', function()
	ped = GetPlayerPed(PlayerId())
    if bagliyim == false then 
		bagliyim = true
		loadModel("prop_trevor_rope_01")
		loadDict("anim@heists@fleeca_bank@scope_out@return_case")
		loadDict("anim@amb@business@bgen@bgen_no_work@")
		TaskPlayAnim(ped, "anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_idle_nowork", 2.0, 2.0, 1.5, 2, 0, false, false, false)
		Wait(2000)
		FreezeEntityPosition(ped, true)
		Wait(2000)
		rope = CreateObject(GetHashKey("prop_trevor_rope_01"), ped, true, true, true);
		networkId = ObjToNet(rope)
		SetNetworkIdExistsOnAllMachines(networkId, true)
		SetNetworkIdCanMigrate(networkId, false)
		NetworkSetNetworkIdDynamic(networkId, true)
		AttachEntityToEntity(rope, ped, GetPedBoneIndex(GetPlayerPed(PlayerId()), 36864), 0.55, 0.09, -0.13, 265.0, -10.0, 100.0, true, false, false, false, 0, true);
	else 
		ClearPedTasks(PlayerPedId()) 
		DeleteEntity(ped)
		DeleteObject(rope)
		DeleteObject(elrope)
		DeleteEntity(tped)
		bagliyim = false
		FreezeEntityPosition(GetPlayerPed(PlayerId()), false)
		ClearPedProp(GetPlayerPed(-1), "prop_trevor_rope_01")
	end
	
end)
 
RegisterNetEvent('s4-cuff:client:cuval')
AddEventHandler('s4-cuff:client:cuval', function(bag)
	local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()

	if closestPlayer ~= -1 and closestDistance <= 2.0 then

		local dict = "amb@prop_human_bum_bin@idle_a"
		RequestAnimDict(dict) 
	
		while not HasAnimDictLoaded(dict) do
			RequestAnimDict(dict)
			Citizen.Wait(0)
		end

		TaskPlayAnim(GetPlayerPed(-1), dict, "idle_a", 8.0, 1.0, 1500, 1, 0, false, false, false)

	  	TriggerServerEvent('s4-cuff:client:cuval', GetPlayerServerId(closestPlayer))

		Wait(1500)

		if bag then 
			HaveBagOnHead = bag 
		end
	else
		QBCore.Functions.Notify(Config.Lang["no_one_nearby_cuff"], "error")
	end 
	
end)

RegisterNetEvent('s4-cuff:client:kafacuval') 
AddEventHandler('s4-cuff:client:kafacuval', function()
    local playerPed = GetPlayerPed(-1)

	if HaveBagOnHead == false then 
		cuval = CreateObject(GetHashKey("prop_money_bag_01"), 0, 0, 0, true, true, true) -- Create head bag object!
		AttachEntityToEntity(cuval, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 12844), 0.2, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- Attach object to head
		SetEntityCompletelyDisableCollision(cuval, false, true)
		SetNuiFocus(false,false)
		SendNUIMessage({action = 'open_headbag'})
		HaveBagOnHead = true
    else
		DeleteEntity(cuval)
		HaveBagOnHead = false
		SendNUIMessage({action = 'close_headbag'})
	end
end)    

RegisterNetEvent('s4-cuff:client:agzaparaa')
AddEventHandler('s4-cuff:client:agzaparaa', function()
	loadDict("anim@heists@fleeca_bank@scope_out@return_case")
	TaskPlayAnim(GetPlayerPed(PlayerId()), "anim@heists@fleeca_bank@scope_out@return_case", "trevor_action", 2.0, 2.0, 1.5, 2, 0, false, false, false)
	Wait(2000)
	FreezeEntityPosition(GetPlayerPed(PlayerId()), false)
	ClearPedTasks(PlayerPedId()) 
end)

RegisterNetEvent('s4-cuff:client:agzapara')
AddEventHandler('s4-cuff:client:agzapara', function(tip)
	DeleteEntity(ped)
	DeleteObject(rope)
	DeleteObject(elrope)
	DeleteEntity(tped)

	if zatenbantli == true then zatenbantli = false return end 

	if tip == 0 then 
		loadModel("prop_anim_cash_note_b")
		elrope = CreateObject(GetHashKey("prop_anim_cash_note_b"), GetPlayerPed(PlayerId()), true, true, true);
		AttachEntityToEntity(elrope, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 20178), 0.082, 0.0, -0.01, 0.0, 90.0, 0.0, true, false, false, false, 0, true);
		zatenbantli = true
	else
		loadModel("prop_cash_pile_02")
		elrope = CreateObject(GetHashKey("prop_cash_pile_02"), GetPlayerPed(PlayerId()), true, true, true);
		AttachEntityToEntity(elrope, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 20178), 0.020, 0.0, -0.01, 0.0, 0.0, 90.0, true, false, false, false, 0, true);
		zatenbantli = true
	end
end)




AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end
 
	DeleteEntity(ped)
	DeleteObject(rope)
	DeleteObject(elrope)
	DeleteEntity(tped)
		  
	DeleteEntity(cuval)
	Citizen.Wait(0)
end)



RegisterNetEvent("cuff:client:useElectronicCuff")
AddEventHandler("cuff:client:useElectronicCuff", function() 

	local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance > 2.0 then
		QBCore.Functions.Notify("There is no one near you", "error")
		return 
	end
	inputs = {}
                                inputs[#inputs+1]= {
                                    text = 'Zone', 
                                    name = "zone",
                                    type = "checkbox",
                                    options = {
										{ value = "santos", text = "Losantos",checked="true"},
                                        { value = "sandy", text = "Sandy" ,checked="true"}, 
                                        { value = "paleto", text = "Paleto",checked="true"} 
                                    }
                                }

                                local dialog = exports['qb-input']:ShowInput({
                                    header = 'Anclet Config',
                                    submitText = "Install Anklet",
                                    inputs =inputs
                                })
	if closestPlayer ~= -1 and closestDistance <= 2.0 then
		if dialog then
			local checkcount=0
			local zonename={}
			for k,v in pairs(Config.zone) do
				if dialog[k]=='true' then
					zonename[k]=true
					checkcount=checkcount+1
				else
					zonename[k]=false
				end
			 end

			 if checkcount==0 then 	QBCore.Functions.Notify("Select a Zone", "error") return  end
			 ExecuteCommand('e mechanic4')
			 QBCore.Functions.Progressbar('ankletinstall',"Attach Anklet", 6000, false, true, {
				disableMovement = true, 
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function()
				TriggerServerEvent("cuff:server:electroCuffPlayer", GetPlayerServerId(closestPlayer),zonename)
				ExecuteCommand('c')
			end, function()
				ExecuteCommand('c')
			end)

			
			
		end
   	else
		QBCore.Functions.Notify("There is no one near you", "error")
   	end 
end)

RegisterNetEvent("cuff:client:animshok")
AddEventHandler("cuff:client:animshok", function()
	TaskPlayAnim(PlayerPedId(), "mp_arresting", "a_uncuff", 8.0, -8, -1, 49, 0, false, false, false) 
	Wait(2000)
	ClearPedTasks(PlayerPedId()) 
end)


AddEventHandler('onResourceStop', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  DeleteEntity(cuffs)
end)


RegisterNetEvent("cuff:client:showElectronicCuffTrackMenu")
AddEventHandler("cuff:client:showElectronicCuffTrackMenu", function()
	
	QBCore.Functions.TriggerCallback("cuff:server:getElectroCuffedPlayers", function(electroCuffedPlayers) 

		for k,v in ipairs(electroCuffedPlayers) do 
			if trackedPlayers[v.identifier] then
				electroCuffedPlayers[k].gpsEnabled =true
			else
				electroCuffedPlayers[k].gpsEnabled=false
			end
		end
	
	    SendNUIMessage({
	    	action = "OPEN",
	    	ankletlist = electroCuffedPlayers,
	    })
		PlayWatchAnim(PlayerPedId(),true)
	    SetNuiFocus(true, true)
    end)
end)
RegisterNUICallback("close", function() 
    StopWatchAnim(PlayerPedId())
	SetNuiFocus(false, false)
end)
RegisterNetEvent("cuff:client:hideElectronicCuffTrackMenu")
AddEventHandler("cuff:client:hideElectronicCuffTrackMenu", function() 
	SendNUIMessage({
		action = "CLOSE"
	})

end)

RegisterNetEvent("cuff:client:predisableElectroCuff")
AddEventHandler("cuff:client:predisableElectroCuff", function(player,animation) 
	SendNUIMessage({
		action = "CLOSE"
	})
    StopWatchAnim(PlayerPedId())
	SetNuiFocus(false, false)
	Wait(100)
	if animation then
		ExecuteCommand('e mechanic4')
		QBCore.Functions.Progressbar('ankletuninstall',"Deattach Anklet", 6000, false, true, {
			disableMovement = true, 
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}, {}, {}, {}, function()
			TriggerServerEvent("cuff:server:disableElectroCuff", player)
			ExecuteCommand('c')
		end, function()
			ExecuteCommand('c')
		end)
	else
		TriggerServerEvent("cuff:server:disableElectroCuff", player)
	end
	
end)
local pedProps=nil
function PlayWatchAnim(ped,isNet)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local tabletprop = `prop_cs_tablet`
    RequestModel(tabletprop)
    while not HasModelLoaded(tabletprop) do
        Citizen.Wait(10)
    end
    local prop = CreateObject(tabletprop, x, y, z + 0.2, isNet, true, false)
    AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 28422), -0.05, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
    local animDict = 'amb@code_human_in_bus_passenger_idles@female@tablet@idle_a'
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(10)
    end
    TaskPlayAnim(ped, animDict, "idle_a", 3.0, -8.0, -1, 49, 0, false, false, false)
    pedProps = prop
end

function StopWatchAnim(ped)
    local prop = pedProps
    ClearPedTasks(ped)
    if prop and DoesEntityExist(prop) then
        DetachEntity(prop, true, true)
        DeleteEntity(prop)
    else
   
    end
    pedProps = nil
end