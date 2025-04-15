local QBCore = exports[Config.CoreName]:GetCoreObject()
RegisterNetEvent("Pug:server:FinishTrainingAnimal", function(day, anim)
	-- local src = source
    -- local Player = QBCore.Functions.GetPlayer(src)
	-- local cid = Player.PlayerData.citizenid
	-- local animal = 'horsemissions'
	-- if anim == 'a_c_cow' then
	-- 	animal = 'cowmissions'
	-- end
	-- local result = MySQL.query.await('SELECT '..animal..' FROM pug_animals WHERE citizenid = ?', {cid})
	-- if result[1] ~= nil then
	-- 	MySQL.update('UPDATE pug_animals SET '..animal..' = ? WHERE citizenid = ?', { day,cid })
	-- else
	-- 	MySQL.insert('INSERT INTO pug_animals (citizenid, '..animal..', day) VALUES (?, ?, ?)', {
	-- 		cid,
	-- 		day,
	-- 		os.date("%x"),
	-- 	})
	-- end
end)

RegisterNetEvent("Pug:server:AnimalsPlayerInstence", function(bool)
	local src = source
	if bool then
		SetPlayerRoutingBucket(src, math.random(300, 999))
	else
		SetPlayerRoutingBucket(src, 0)
	end
end)

QBCore.Functions.CreateCallback('Pug:server:GetPlayerAnimals', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local cid = Player.PlayerData.citizenid
	local result = MySQL.query.await('SELECT animal FROM pug_animals WHERE citizenid = ?', {cid})
	if result[1] ~= nil then
		cb(result)
	else
		cb(false)
	end
end)

