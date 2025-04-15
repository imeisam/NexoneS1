local QBCore = exports[Config.CoreName]:GetCoreObject()

QBCore.Functions.CreateCallback('Pug:server:GetAnimalTable', function(source, cb, anim)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cid = Player.PlayerData.citizenid
    if anim == 'a_c_deer' then
        local result = MySQL.query.await('SELECT horsemissions FROM pug_animals WHERE citizenid = ?', {cid})
        if result and result[1] and result[1].horsemissions ~= nil then
            cb(tonumber(result[1].horsemissions))
        else
            cb(0)
        end
    else
        local result = MySQL.query.await('SELECT cowmissions FROM pug_animals WHERE citizenid = ?', {cid})
        if result and result[1] and result[1].cowmissions ~= nil then
            cb(tonumber(result[1].cowmissions))
        else
            cb(0)
        end
    end
end)

QBCore.Commands.Add('removehorse', 'Remove Hourse', {{name='id', help='Player'}}, true, function(source, args)
    local src = source
    local playerId = tonumber(args[1])
    
   TriggerClientEvent("Pug:animals:RemovePlayerFromAnimal",playerId)
   Wait(1000)
   TriggerClientEvent("Pug:client:DespawnAnimal",playerId)
end, 'admin')
QBCore.Commands.Add('addhorse', 'Add Hourse', {{name='id', help='Player'}}, true, function(source, args)
    local src = source
    local playerId = tonumber(args[1])
    
   TriggerClientEvent("Pug:client:SpawnPersonalOwnedAnimal",playerId,"a_c_deer")
end, 'admin')

QBCore.Functions.CreateCallback('Pug:server:CanDoTraining', function(source, cb, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local cid = Player.PlayerData.citizenid
	local result = MySQL.query.await('SELECT day FROM pug_animals WHERE citizenid = ?', {cid})
	if Player.PlayerData.money.bank >= price then
		if result[1] ~= nil then
			if result[1].day == os.date("%x") then
				TriggerClientEvent('QBCore:Notify', src, Config.TransLate.TrainingDayCap, 'error')
				cb(false)
			else
				Player.Functions.RemoveMoney('bank',price)
				cb(true)
			end
		else
			Player.Functions.RemoveMoney('bank',price)
			cb(true)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Config.TransLate.MissingMoney..price - Player.PlayerData.money.bank, 'error')
		cb(false)
	end
end)

RegisterNetEvent("Pug:server:BuyRacingAnimal", function(data)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local cid = Player.PlayerData.citizenid
	local result = MySQL.query.await('SELECT animal FROM pug_animals WHERE citizenid = ?', {cid})
	local price = data.amount
	local Animal = data.animal
	if Player.PlayerData.money.cash >= price then
		if result[1].animal ~= nil then
			if json.decode(result[1].animal).Animal1 == Animal or json.decode(result[1].animal).Animal2 == Animal then
				TriggerClientEvent('QBCore:Notify', src, Config.TransLate.AlreadyownAnimal)
				TriggerClientEvent("Pug:animals:SelectHorseMenu", src)
			else
				Player.Functions.RemoveMoney('cash',price)
				TriggerClientEvent('QBCore:Notify', src, Config.TransLate.PurchasedAnimal, 'success')
				TriggerClientEvent("Pug:animals:SelectHorseMenu", src)
				MySQL.update('UPDATE pug_animals SET animal = ? WHERE citizenid = ?', { json.encode({Animal1 = json.decode(result[1].animal).Animal1,Animal2 = Animal}),cid })
			end
		else
			Player.Functions.RemoveMoney('cash',price)
			TriggerClientEvent('QBCore:Notify', src, Config.TransLate.PurchasedAnimal, 'success')
			TriggerClientEvent("Pug:animals:SelectHorseMenu", src)
			MySQL.update('UPDATE pug_animals SET animal = ? WHERE citizenid = ?', { json.encode({ Animal1 = Animal, Animal2 = nil}),cid })
		end
	else
		TriggerClientEvent("Pug:animals:SelectHorseMenu", src)
		TriggerClientEvent('QBCore:Notify', src, Config.TransLate.MissingMoney..price - Player.PlayerData.money.cash, 'error')
	end
end)