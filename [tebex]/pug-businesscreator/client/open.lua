print'Pug Business Creator 2.3.7'

---------- [Functions] ----------
-- Change this to your notification script if needed
function BusinessNotify(msg, type, length)
	if Framework == "ESX" then
		FWork.ShowNotification(tostring(msg))
	elseif Framework == "QBCore" then
    	FWork.Functions.Notify(tostring(msg), type, length)
	end
end

function GetItemsInformation(I, Bool)
	if Config.InventoryType == "ox_inventory" then
		for item, data in pairs(exports.ox_inventory:Items()) do
			if item ~= nil then
				if I ~= nil then
					if tostring(item) == tostring(I) then
						if Bool then
							return tostring(tostring(item..".png"))
						else
							print(data.label,"data.label")
							if data.label ~= nil then
								return tostring(data.label)
							end
						end
					end
				end
			end
		end
		return I
	elseif Framework == "QBCore" then
		if FWork.Shared.Items[I] then
			if Bool then
				if FWork.Shared.Items[I].image ~= nil then
					return FWork.Shared.Items[I].image
				else
					return I
				end
			else
				return FWork.Shared.Items[I].label
			end
		else
			return I
		end
	else
		if Config.InventoryType == "qs-inventory" then
			for item, data in pairs(exports['qs-inventory']:GetItemList()) do
				if tostring(item) == tostring(I) then
					if Bool then
						if data.image then
							return tostring(tostring(data.image))
						end
					else
						if data.label then
							return tostring(data.label)
						end
					end
				end
			end
		end
		return I
	end
end

function HasItem(items, amount)
	local Player = nil
	if Framework == "QBCore" then
		local DoesHasItem = "nothing"
		Config.FrameworkFunctions.TriggerCallback("Pug:serverESX:GetItemQBCoreBusinessCreator", function(HasItem)
			if HasItem then
				DoesHasItem = true
			else
				DoesHasItem = false
			end
		end, items, amount)
		while DoesHasItem == "nothing" do Wait(1) end
		return DoesHasItem
	else
		local DoesHasItem = "nothing"
		Config.FrameworkFunctions.TriggerCallback("Pug:serverESX:GetItemESXBusinessCreator", function(HasItem)
			if HasItem then
				DoesHasItem = true
			else
				DoesHasItem = false
			end
		end, items, amount)
		while DoesHasItem == "nothing" do Wait(1) end
		return DoesHasItem
	end
end

RegisterNetEvent('Pug:client:ConsumeItem', function(ItemInfo)
	local BarText = "Using "
	local AnimDict, AnimAction

	if Config.ItemconsumerAnimation[ItemInfo.Animation] then
		AnimDict = Config.ItemconsumerAnimation[ItemInfo.Animation].AnimDict
		AnimAction = Config.ItemconsumerAnimation[ItemInfo.Animation].AnimAction

		loadAnimDict(AnimDict)
		PlayAnimation(AnimDict, AnimAction)

	end

	BusinessToggleItem(false, ItemInfo.Item, 1)

	FWork.Functions.Progressbar("consume_item", BarText..ItemInfo.Label.."..", 5000, false, true, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = false,
	}, {}, {}, {}, function() -- Done
		StopAnimTask(PlayerPedId(), AnimDict, AnimAction, 1.0)

		-- Update player metadata for each type based on the item properties
		if ItemInfo.Increase then
			TriggerServerEvent("Pug:Server:SetUpdateMetaDataBusiness", "hunger", FWork.Functions.GetPlayerData().metadata["hunger"] + ItemInfo.Increase)
		end
		if ItemInfo.IncreaseWater then
			TriggerServerEvent("Pug:Server:SetUpdateMetaDataBusiness", "thirst", FWork.Functions.GetPlayerData().metadata["thirst"] + ItemInfo.IncreaseWater)
		end
		if ItemInfo.IncreaseStress then
			TriggerServerEvent('hud:server:RelieveStress', ItemInfo.IncreaseStress)
		end
		if ItemInfo.IncreaseHealth then
			SetEntityHealth(GetEntityHealth(PlayerPedId()) + tonumber(ItemInfo.IncreaseHealth))
		end
		if ItemInfo.IncreaseArmor then
			SetPedArmour(PlayerPedId(), GetPedArmour(PlayerPedId()) + tonumber(ItemInfo.IncreaseArmor))
			TriggerServerEvent("Pug:Server:SetUpdateMetaDataBusiness", "armor", FWork.Functions.GetPlayerData().metadata["armor"] + ItemInfo.IncreaseArmor)
		end

		ReloadSkin()
	end, function()
		BusinessToggleItem(true, ItemInfo.Item, 1)
		StopAnimTask(PlayerPedId(), AnimDict, AnimAction, 1.0)
		ReloadSkin()
		BusinessNotify(Config.LangT["Canceled"], 'error')
	end)
end)




---------- [ESX SOCIETY COMPATIBILITY] ----------
RegisterNetEvent("Pug:esx_society:depositMoney", function(BillerJob, BusinessCommission)
	TriggerServerEvent('esx_society:depositMoney', BillerJob, BusinessCommission)
end)
--------------------------------------------------