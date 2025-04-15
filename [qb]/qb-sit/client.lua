local QBCore = exports['qb-core']:GetCoreObject()

local anim = "back"
CreateThread(function()
		Citizen.Wait(100)
		for k,v in pairs(Config.objects.locations) do
			local distance = 1.0
			if v.bed then
				distance = 2.0
			end
			local objssss = GetHashKey(v.object)
			if v.ishash then
				objssss = v.object
			end
			local obj = {objssss}
			local label="Sit"
			if v.bed then
				label="Bed"
			end
			exports["qb-target"]:AddTargetModel(obj, {
				options = {
					{
						event = "qb-sit:client:sitchair",
						icon = "fa fa-circle",
						label = label,
						job = false,
					},
					{
						event = "qb-sit:client:sitchairplayer",
						icon = "fa fa-circle",
						label = "Patient bed",
						job = false,
						canInteract = function(entity)
							local res=false
							local player, distance = QBCore.Functions.GetClosestPlayer()
							if player ~= -1 and distance < 2.0 then
								res=true
							end
							local gethash=GetEntityModel(entity)
							 if (gethash == -2077615177 or gethash == 225399863 or gethash == -1732159477 or gethash ==-421052012) and res then return true else return false end end
					},
					{
						type = 'client',
						event = "sit:TakeChair",
						icon = "fa fa-circle",
						label = "Take Chair",
						job = false,
						canInteract = function(entity) if GetEntityModel(entity) == `prop_skid_chair_02` then return true else return false end end
					},
				},
				distance = distance
			})
		end
end)
RegisterNetEvent('qb-sit:client:sitchairplayer', function()
	local player, distance = QBCore.Functions.GetClosestPlayer()
	if player ~= -1 and distance < 2.0 then
		local players = PlayerPedId()
		local pedPos = GetEntityCoords(players)
		local playerId = GetPlayerServerId(player)
		TriggerServerEvent('qb-sit:server:sitchairplayer',playerId,pedPos)
	end
end)
RegisterNetEvent('qb-sit:client:sitchair', function(data,coord)
    local player = PlayerPedId()
    local pedPos = GetEntityCoords(player)
	if coord then
		pedPos=coord
	end
    for k,v in pairs(Config.objects.locations) do
        local oSelectedObject = GetClosestObjectOfType(pedPos.x, pedPos.y, pedPos.z, 0.8, v.ishash and v.object or GetHashKey(v.object), 0, 0, 0)
        local oEntityCoords = GetEntityCoords(oSelectedObject)
        local objectexits = DoesEntityExist(oSelectedObject)
        if objectexits then
            if GetDistanceBetweenCoords(oEntityCoords.x, oEntityCoords.y, oEntityCoords.z,pedPos) < 15.0 then
                if oSelectedObject ~= 0 then
                    local objects = Config.objects
                    if oSelectedObject ~= objects.object then
                        objects.object = oSelectedObject
                        objects.ObjectVertX = v.verticalOffsetX
                        objects.ObjectVertY = v.verticalOffsetY
                        objects.ObjectVertZ = v.verticalOffsetZ
                        objects.OjbectDir = v.direction
                        objects.isBed = v.bed
                    end
                end
            end
        end
    end
    local objects = Config.objects
		if objects.object ~= nil and objects.ObjectVertX ~= nil and objects.ObjectVertY ~= nil and objects.ObjectVertZ ~= nil and objects.OjbectDir ~= nil and objects.isBed ~= nil then
			local getPlayerCoords = GetEntityCoords(player)
			local objectcoords = GetEntityCoords(objects.object)
			if GetDistanceBetweenCoords(objectcoords.x, objectcoords.y, objectcoords.z,getPlayerCoords) < 1.8 and not using then
				PlayAnimOnPlayer(objects.object,objects.ObjectVertX,objects.ObjectVertY,objects.ObjectVertZ,objects.OjbectDir, objects.isBed, player, objectcoords)
			end
		end
end)


function PlayAnimOnPlayer(object,vertx,verty,vertz,dir, isBed, ped, objectcoords)
	lastPos = GetEntityCoords(ped)
	FreezeEntityPosition(object, true)
	SetEntityCoords(ped, objectcoords.x, objectcoords.y, objectcoords.z+-1.4)
	FreezeEntityPosition(ped, true)
	using = true
	if isBed == false then
		TaskStartScenarioAtPosition(ped, Config.objects.SitAnimation, objectcoords.x+vertx, objectcoords.y-verty, objectcoords.z-vertz, GetEntityHeading(object)+dir, 0, true, true)
	else
		if anim == "back" then
			TaskStartScenarioAtPosition(ped, Config.objects.LayBackAnimation, objectcoords.x+vertx, objectcoords.y+verty, objectcoords.z-vertz, GetEntityHeading(object)+dir, 0, true, true)
		elseif anim == "stomach" then
			TaskStartScenarioAtPosition(ped, Config.objects.LayStomachAnimation, objectcoords.x+vertx, objectcoords.y+verty, objectcoords.z-vertz, GetEntityHeading(object)+dir, 0, true, true)
		end
	end
end

CreateThread(function()
	while true do
		Wait(1)
        if using then
            local player = PlayerPedId()
            local getPlayerCoords = GetEntityCoords(player)
            exports["qb-core"]:DrawText("Stand Up", "#2d79af", "F")
            if IsControlJustPressed(0, 23) then
                ClearPedTasks(player)
                using = false
                local x,y,z = table.unpack(lastPos)
                if GetDistanceBetweenCoords(x, y, z,getPlayerCoords) < 10 then
                    SetEntityCoords(player, lastPos)
                end
                FreezeEntityPosition(player, false)
                exports['qb-core']:HideText()
            end
        else
            Wait(1123)
        end
	end
end)

RegisterNetEvent("qb-sit:client:AddChair", function()
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["chair"], "remove")
	TriggerEvent('animations:client:EmoteCommandStart', {"mechanic3"})
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	local head = GetEntityHeading(ped)
	local radhead = math.rad(head)
	local newpos = {x = pos.x-math.sin(radhead), y = pos.y+math.cos(radhead), z = pos.z}
	Wait(500)
	local Adambarfi = CreateObject(`prop_skid_chair_02`, newpos.x, newpos.y, newpos.z - 0.9, 1, 1 ,0)
	SetEntityHeading(Adambarfi, head)
	FreezeEntityPosition(Adambarfi, true)
	Wait(1000)
	ClearPedTasks(ped)

end)

RegisterNetEvent("sit:TakeChair", function()
	local ped = PlayerPedId()
	TriggerEvent('animations:client:EmoteCommandStart', {"mechanic3"})
	local pos = GetEntityCoords(ped)
	local hast = GetClosestObjectOfType(pos.x, pos.y, pos.z, 2.5, `prop_skid_chair_02`, 0, 0, 0)
	NetworkRequestControlOfEntity(hast)
	SetEntityAsMissionEntity(hast)
	Wait(1000)
	ClearPedTasks(ped)
	DeleteObject(hast)
	if not DoesEntityExist(hast) then
		TriggerServerEvent('qb-sit:server:AddChair')
		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["chair"], "add")
	end
end)