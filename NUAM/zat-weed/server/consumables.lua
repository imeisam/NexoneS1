
local QBCore = nil

Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports[Config.FrameworkPseudo]:GetCoreObject()
    end
end)

Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
		if Config.Inventory ~= "ox" and Config.Inventory ~= "qs" then
			QBCore.Functions.CreateUseableItem("zatfan01", function(source, item)
				local src = source
				local Player = QBCore.Functions.GetPlayer(src)
				if Player.Functions.GetItemByName(item.name) ~= nil then
					TriggerClientEvent("zat-weed:client:UseItem", src, item.name, Config.FanProps[1])
					Player.Functions.RemoveItem(item.name, 1)
					TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove")
				end
			end)

			QBCore.Functions.CreateUseableItem("zatresfan", function(source, item)
				local src = source
				local Player = QBCore.Functions.GetPlayer(src)
				if Player.Functions.GetItemByName(item.name) ~= nil then
					TriggerClientEvent("zat-weed:client:UseItem", src, item.name, Config.FanProps[2])
					Player.Functions.RemoveItem(item.name, 1)
					TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove")
				end
			end)

			QBCore.Functions.CreateUseableItem("zatwallfan", function(source, item)
				local src = source
				local Player = QBCore.Functions.GetPlayer(src)
				if Player.Functions.GetItemByName(item.name) ~= nil then
					TriggerClientEvent("zat-weed:client:UseItem", src, item.name, Config.FanProps[3])
					Player.Functions.RemoveItem(item.name, 1)
					TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove")
				end
			end)

			QBCore.Functions.CreateUseableItem("zatheater", function(source, item)
				local src = source
				local Player = QBCore.Functions.GetPlayer(src)
				if Player.Functions.GetItemByName(item.name) ~= nil then
					TriggerClientEvent("zat-weed:client:UseItem", src, item.name, Config.HeaterProps[1])
					Player.Functions.RemoveItem(item.name, 1)
					TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove")
				end
			end)

			QBCore.Functions.CreateUseableItem("zatpatioheater", function(source, item)
				local src = source
				local Player = QBCore.Functions.GetPlayer(src)
				if Player.Functions.GetItemByName(item.name) ~= nil then
					TriggerClientEvent("zat-weed:client:UseItem", src, item.name, Config.HeaterProps[2])
					Player.Functions.RemoveItem(item.name, 1)
					TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove")
				end
			end)


			QBCore.Functions.CreateUseableItem("zatwalllight", function(source, item)
				local src = source
				local Player = QBCore.Functions.GetPlayer(src)
				if Player.Functions.GetItemByName(item.name) ~= nil then
					TriggerClientEvent("zat-weed:client:UseItem", src, item.name, Config.LightProps[1])
					Player.Functions.RemoveItem(item.name, 1)
					TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove")
				end
			end)

			QBCore.Functions.CreateUseableItem("zatceilinglight", function(source, item)
				local src = source
				local Player = QBCore.Functions.GetPlayer(src)
				if Player.Functions.GetItemByName(item.name) ~= nil then
					TriggerClientEvent("zat-weed:client:UseItem", src, item.name, Config.LightProps[2])
					Player.Functions.RemoveItem(item.name, 1)
					TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove")
				end
			end)

			QBCore.Functions.CreateUseableItem("zatbluelight", function(source, item)
				local src = source
				local Player = QBCore.Functions.GetPlayer(src)
				if Player.Functions.GetItemByName(item.name) ~= nil then
					TriggerClientEvent("zat-weed:client:UseItem", src, item.name, Config.LightProps[3])
					Player.Functions.RemoveItem(item.name, 1)
					TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove")
				end
			end)

			QBCore.Functions.CreateUseableItem("zatplanter", function(source, item)
				local src = source
				local Player = QBCore.Functions.GetPlayer(src)
				if Player.PlayerData.metadata['inapartment'] then return end
				if Player.Functions.GetItemByName(item.name) ~= nil then
					TriggerClientEvent("zat-weed:client:UseItem", src, item.name, Config.PlanterProps[1])
					Player.Functions.RemoveItem(item.name, 1)
					TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove")
				end
			end)

			QBCore.Functions.CreateUseableItem("zatweedrackxs", function(source, item)
				local src = source
				local Player = QBCore.Functions.GetPlayer(src)
				if Player.Functions.GetItemByName(item.name) ~= nil then
					TriggerClientEvent("zat-weed:client:UseItem", src, item.name, Config.PlanterProps[2])
					Player.Functions.RemoveItem(item.name, 1)
					TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove")
				end
			end)

			QBCore.Functions.CreateUseableItem("zatweedracks", function(source, item)
				local src = source
				local Player = QBCore.Functions.GetPlayer(src)
				if Player.Functions.GetItemByName(item.name) ~= nil then
					TriggerClientEvent("zat-weed:client:UseItem", src, item.name, Config.PlanterProps[3])
					Player.Functions.RemoveItem(item.name, 1)
					TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove")
				end
			end)

			QBCore.Functions.CreateUseableItem("zatweedtable", function(source, item)
				local src = source
				local Player = QBCore.Functions.GetPlayer(src)
				if Player.Functions.GetItemByName(item.name) ~= nil then
					TriggerClientEvent("zat-weed:client:UseItem", src, item.name, Config.PlanterProps[4])
					Player.Functions.RemoveItem(item.name, 1)
					TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove")
				end
			end)

			QBCore.Functions.CreateUseableItem("zatwatersetup", function(source, item)
				local src = source
				local Player = QBCore.Functions.GetPlayer(src)
				if Player.Functions.GetItemByName(item.name) ~= nil then
					TriggerClientEvent("zat-weed:client:UseItemStrict", src, item.name, Config.PlanterProps[5])
					Player.Functions.RemoveItem(item.name, 1)
					TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove")
				end
			end)

			QBCore.Functions.CreateUseableItem("zatwaterbottleempty", function(source, item)
				local src = source
				local Player = QBCore.Functions.GetPlayer(src)
				if Player.Functions.GetItemByName(item.name) ~= nil then
					TriggerClientEvent("zat-weed:client:fillWater", src)
				end
			end)

			QBCore.Functions.CreateUseableItem("zatweedseed", function(source, item)
				local src = source
				local Player = QBCore.Functions.GetPlayer(src)
				if Player.Functions.GetItemByName(item.name) ~= nil then
					TriggerClientEvent("zat-weed:client:UseItem", src, item.name, Config.WeedProps[1], item.info)
					Player.Functions.RemoveItem(item.name, 1, item.slot)
					TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove")
				end
			end)
			QBCore.Functions.CreateUseableItem("zatpackedweed", function(source, item)
				local src = source
				local Player = QBCore.Functions.GetPlayer(src)
				if Player.Functions.GetItemByName(item.name) ~= nil then
					local rp =  Player.Functions.GetItemByName("zatrollingpaper")
					if rp.amount >= 5 then
						TriggerClientEvent("zat-weed:client:rollIt", src, item.info)
						Player.Functions.RemoveItem(item.name, 1, item.slot)
						TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove")
						Player.Functions.RemoveItem("zatrollingpaper", 5)
						TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["zatrollingpaper"], "remove")
					else
						TriggerClientEvent('QBCore:Notify', src, _U("no_erol"), 'error')
					end
				end
			end)
			QBCore.Functions.CreateUseableItem("zatjoint", function(source, item)
				local Player = QBCore.Functions.GetPlayer(source)
				if not Player.Functions.RemoveItem(item.name, 1, item.slot) then return end
				TriggerClientEvent("zat-weed:client:UseJoint", source, item.info.purity)
			end)
		end
	end
end)