if Config.Version == "new" then
    QBCore = exports['qb-core']:GetCoreObject()
end

RegisterNetEvent('orbit-chopshop:server:getradar')
AddEventHandler('orbit-chopshop:server:getradar', function()
	local src = source
	local radarprice=1000
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.GetMoney('cash') < radarprice then
		if Player.PlayerData.money['bank'] > radarprice then
			Player.Functions.RemoveMoney('bank',radarprice)
		else
			TriggerClientEvent('QBCore:Notify', src, "You don't have enough Money", 'error', 4000)
			return
		end
	else
		Player.Functions.RemoveMoney('cash',radarprice)
	end
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weapon_digiscanner"], "add")
	Player.Functions.AddItem("weapon_digiscanner", 1, false, {})
   
end)

RegisterNetEvent("orbit-chopshop:syncchopcars")
AddEventHandler("orbit-chopshop:syncchopcars", SyncCars)

function GiveReward(data)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if data == "wheel1" or data == "wheel2" or data == "wheel3" or data == "wheel4" then
    		Player.Functions.AddItem("car_wheel", 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['car_wheel'], "add")

	elseif data == "door" then
    	Player.Functions.AddItem("car_door", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['car_door'], "add")
		
	elseif data == "hood" then
    	Player.Functions.AddItem("radiator", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['radiator'], "add")

	elseif data == "trunk" then 
		local randomitem = math.random(1, 3)
		local item = Config.TrunkItems[randomitem]["item"]
		local amount = Config.TrunkItems[randomitem]["amount"]
		Player.Functions.AddItem(item, amount, false, info)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
		TriggerClientEvent('QBCore:Notify', src, "You found "..amount.." "..item.." in the trunk", 'success')
		Citizen.Wait(8500)
		Player.Functions.AddItem("trunk", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['trunk'], "add")
	end
end

RegisterServerEvent('nxo-chopshop:server:log', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	TriggerEvent('qb-log:server:CreateLog', 'chopshop', 'ChopShop Robbery', 'red', Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname..' ('..Player.PlayerData.citizenid..') Starting')
end)



RegisterServerEvent('orbit-chopshop:server:callCops')
AddEventHandler('orbit-chopshop:server:callCops', function(type, bank, streetLabel, coords)
    local msg = ""
    msg = "Possible Vehicle Robbery"
    local alertData = {
        title = "Chopshop",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = msg,
    }
    TriggerClientEvent("orbit-chopshop:client:robberyCall", -1, type, bank, streetLabel, coords)
    TriggerClientEvent("qb-phone:client:addPoliceAlert", -1, alertData)
end)

RegisterNetEvent("orbit-chopshop:server:rewardplayer")
AddEventHandler("orbit-chopshop:server:rewardplayer", GiveReward)

function SyncCars(list) 
	TriggerClientEvent('orbit-chopshop:carlist', -1,list) 
end

RegisterNetEvent("orbit-chopshop:server:chopdoor")
AddEventHandler("orbit-chopshop:server:chopdoor", function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local door = "car_door"
	
	if Player.Functions.GetItemByName(door) ~= nil then
		local randomitem = math.random(1, 5)
		local item = Config.DoorItems[randomitem]["item"]
		local amount = Config.DoorItems[randomitem]["amount"]
		Player.Functions.RemoveItem("car_door", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['car_door'], "remove")
		TriggerClientEvent('orbit-chopshop:doorchopanim', src)
		Citizen.Wait(12500)
		Player.Functions.AddItem(item, amount, false, info)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
	else
		TriggerClientEvent('QBCore:Notify', src, 'You have no doors to scrap..', 'error')
	end
end)

RegisterNetEvent("orbit-chopshop:server:chopwheel")
AddEventHandler("orbit-chopshop:server:chopwheel", function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local wheel = "car_wheel"

	if Player.Functions.GetItemByName(wheel) ~= nil then
		local randomitem = math.random(1, 3)
		local item = Config.WheelItems[randomitem]["item"]
		local amount = Config.WheelItems[randomitem]["amount"]
		Player.Functions.RemoveItem("car_wheel", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['car_wheel'], "remove")
		TriggerClientEvent('orbit-chopshop:wheelchopanim', src)
		Citizen.Wait(14000)
		Player.Functions.AddItem(item, amount, false, info)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
	else
		TriggerClientEvent('QBCore:Notify', src, 'You have no wheels to scrap..', 'error')
	end
end)


RegisterNetEvent("orbit-chopshop:server:chophood")
AddEventHandler("orbit-chopshop:server:chophood", function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local hood = "radiator" 

	if Player.Functions.GetItemByName(hood) ~= nil then
		local randomitem = math.random(1, 5)
		local item = Config.DoorItems[randomitem]["item"]
		local amount = Config.DoorItems[randomitem]["amount"]
		Player.Functions.RemoveItem("radiator", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['radiator'], "remove")
		TriggerClientEvent('orbit-chopshop:hoodchopanim', src)
		Citizen.Wait(12500)
		Player.Functions.AddItem(item, amount, false, info)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
	else
		TriggerClientEvent('QBCore:Notify', src, 'You have no hoods to scrap..', 'error')
	end
end)


RegisterNetEvent("orbit-chopshop:server:choptrunk")
AddEventHandler("orbit-chopshop:server:choptrunk", function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local trunk = "trunk"

	if Player.Functions.GetItemByName(trunk) ~= nil then
		local randomitem = math.random(1, 5)
		local item = Config.DoorItems[randomitem]["item"]
		local amount = Config.DoorItems[randomitem]["amount"]
		Player.Functions.RemoveItem("trunk", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['trunk'], "remove")
		TriggerClientEvent('orbit-chopshop:trunkchopanim', src)
		Citizen.Wait(12500)
		Player.Functions.AddItem(item, amount, false, info)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
	else
		TriggerClientEvent('QBCore:Notify', src, 'You have no trunks to scrap..', 'error')
	end
end)

