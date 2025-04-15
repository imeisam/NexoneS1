-- Variables
local QBCore = exports['qb-core']:GetCoreObject()

local function GlobalTax(value)
	local tax = (value / 100 * Config.GlobalTax)
	return tax
end

--- Events ---
RegisterNetEvent("qb-fuel:server:paypetrolcan", function()
		local src = source
		local Player = QBCore.Functions.GetPlayer(src)
		local cashBalance = Player.Functions.GetCash()
		local bankBalance = Player.PlayerData.money["bank"]
	if cashBalance>=Config.petrolcanbye then
		Player.Functions.RemoveMoney("cash",Config.petrolcanbye,"Buy JerryCan")
		Player.Functions.AddItem("jerrycan", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["jerrycan"], 'add')
	elseif  bankBalance>=Config.petrolcanbye then
	Player.Functions.RemoveMoney("bank",Config.petrolcanbye,"Buy JerryCan")
	Player.Functions.AddItem("jerrycan", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["jerrycan"], 'add')
else
	TriggerClientEvent("QBCore:Notify", source, 'Not Enough Money', 'error')
	end
			
end)

RegisterNetEvent("qb-fuel:server:buybattry", function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local cashBalance = Player.Functions.GetCash()
	local bankBalance = Player.PlayerData.money["bank"]
if cashBalance>=Config.vehiclebatterybuy then
	Player.Functions.RemoveMoney("cash",Config.vehiclebatterybuy,"Buy Vehicle Battery")
	Player.Functions.AddItem("vehiclebattery", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["vehiclebattery"], 'add')
elseif  bankBalance>=Config.vehiclebatterybuy then
Player.Functions.RemoveMoney("bank",Config.vehiclebatterybuy,"Buy Vehicle Battery")
Player.Functions.AddItem("vehiclebattery", 1)
TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["vehiclebattery"], 'add')
else
TriggerClientEvent("QBCore:Notify", source, 'Not Enough Money', 'error')
end
		
end)

RegisterNetEvent("qb-fuel:server:PayForFuel", function(amount, purchasetype)
	local src = source
	if not src then return end
	local player = QBCore.Functions.GetPlayer(src)
	if not player then return end
	local tax = GlobalTax(amount)
	local total = math.ceil(amount + tax)
	local moneyremovetype = purchasetype
	if purchasetype == "bank" then
		moneyremovetype = "bank"
	elseif purchasetype == "cash" then
		moneyremovetype = "cash"
	end
	local fuelprice = (Config.CostMultiplier * 1)
	player.Functions.RemoveMoney(moneyremovetype, total, "Gasoline @ " ..fuelprice.." / L")
end)

-- Jerry Can --
if Config.UseJerryCan then
	QBCore.Functions.CreateUseableItem("jerrycan", function(source, item)
		local src = source
		TriggerClientEvent('qb-fuel:jerrycan:refuelmenu', src, item)
	end)
end


QBCore.Functions.CreateUseableItem("vehiclebattery", function(source)
	local src = source
	TriggerClientEvent('qb-fuel:client:battery', src)
end)


RegisterNetEvent('qb-fuel:info', function(type, amount, srcPlayerData, itemdata)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local srcPlayerData = srcPlayerData
	if itemdata.info.name == "jerrycan" then 
		if amount < 1 or amount > Config.JerryCanCap then return end
	end
    if type == "add" then
        srcPlayerData.items[itemdata.slot].info.gasamount = srcPlayerData.items[itemdata.slot].info.gasamount + amount
        Player.Functions.SetInventory(srcPlayerData.items)
    elseif type == "remove" then
        srcPlayerData.items[itemdata.slot].info.gasamount = srcPlayerData.items[itemdata.slot].info.gasamount - amount
        Player.Functions.SetInventory(srcPlayerData.items)
    end
end)

local function GlobalTax(value)
	local tax = (value / 100 * Config.GlobalTax)
	return tax
end

-- Events
RegisterNetEvent("cdn-fuel:server:electric:OpenMenu", function(amount, inGasStation, hasWeapon, purchasetype, FuelPrice)
	local src = source
	if not src then print("SRC is nil!") return end
	local player = QBCore.Functions.GetPlayer(src)
	if not player then print("Player is nil!") return end
	local FuelCost = amount*FuelPrice
	local tax = GlobalTax(FuelCost)
	local total = tonumber(FuelCost + tax)
	if not amount then if Config.FuelDebug then print("Electric Recharge Amount is invalid!") end TriggerClientEvent('QBCore:Notify', src, Lang:t("electric_more_than_zero"), 'error') return end
	Wait(50)
	if inGasStation and not hasWeapon then
		if Config.RenewedPhonePayment and purchasetype == "bank" then
			TriggerClientEvent("cdn-fuel:client:electric:phone:PayForFuel", src, amount)
		else
			
				TriggerClientEvent('qb-menu:client:openMenu', src, {
					{
						header = "Electric Charge",
						isMenuHeader = true,
						icon = "fas fa-bolt",
					},
					{
						header = "",
						icon = "fas fa-info-circle",
						isMenuHeader = true,
						txt = "The total cost is going to be: $"..math.ceil(total).." including taxes.",
					},
					{
						header = "Confirm",
						icon = "fas fa-check-circle",
						txt ="I would like to pay for electricity.",
						params = {
							event = "cdn-fuel:client:electric:ChargeVehicle",
							args = {
								fuelamounttotal = amount,
								purchasetype = purchasetype,
							}
						}
					},
					{
						header ="Cancel",
						txt = "I actually don't want to charge my car anymore.",
						icon = "fas fa-times-circle",
						params = {
							event = "qb-menu:closeMenu",
						}
					},
				})
			
		end
	end
end)

RegisterNetEvent('cdn-fuel:server:phone:givebackmoney', function(amount)
	local src = source
	local player = QBCore.Functions.GetPlayer(src)
	player.Functions.AddMoney("bank", math.ceil(amount),"Refund Gas Station!")
end)

RegisterNetEvent("cdn-fuel:server:PayForFuel", function(amount, purchasetype, FuelPrice, electric)
	local src = source
	if not src then return end
	local Player = QBCore.Functions.GetPlayer(src)
	if not Player then return end
	local total = math.ceil(FuelPrice)
	if FuelPrice < 1 then
		total = 0
	end
	
	local moneyremovetype = purchasetype
	if Config.FuelDebug then print("Player is attempting to purchase fuel with the money type: " ..moneyremovetype) end
	if Config.FuelDebug then print("Attempting to charge client: $"..total.." for Fuel "..FuelPrice.." PER LITER | PER KW") end
	if purchasetype == "bank" then
		moneyremovetype = "bank"
	elseif purchasetype == "cash" then
		moneyremovetype = "cash"
	end
	local payString = ""--Lang:t("menu_pay_label_1") ..FuelPrice..Lang:t("menu_pay_label_2")
	if electric then payString = "Electricity " ..FuelPrice.."/ KW" end
	
	Player.Functions.RemoveMoney(moneyremovetype, FuelPrice, payString)
	
	-- 						args = {
	-- 							fuelamounttotal = amount,
	-- 							purchasetype = purchasetype,
	-- 							payString=payString,
	-- 						}

	-- TriggerClientEvent('cdn-fuel:client:electric:ChargeVehicle',src,args)

end)

-- Add new event handler for updating vehicle fuel
RegisterNetEvent("qb-fuel:server:UpdateVehicleFuel", function(netId, fuelLevel)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if not vehicle then return end
    
    -- Set the fuel level decorator on the vehicle
    DecorSetFloat(vehicle, Config.FuelDecor, fuelLevel)
end)