local QBCore = exports['qb-core']:GetCoreObject()


QBCore.Functions.CreateUseableItem("laundrymachine", function(source, item)
 
    TriggerClientEvent('sam-laundrymachine:client:uselaundry', source)
end)

RegisterNetEvent("sam-laundrymachine:server:CreateNewObject", function(model, coords, objectid,lastmodel)
    local source = source
    local player = QBCore.Functions.GetPlayer(source)
    cid = player.PlayerData.citizenid
    local rowid=0
    if objectid then
        MySQL.query.await("update laundrywash set model=? where id=?", {model,objectid})
        TriggerClientEvent("sam-laundrymachine:client:RemoveObject", -1, lastmodel,coords)
        rowid=objectid
    else
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        Player.Functions.RemoveItem("laundrymachine", 1) 
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["laundrymachine"], "remove")

        MySQL.query.await("INSERT INTO laundrywash (model, coord, cid) VALUES (?, ?, ?)", { model,json.encode(coords),cid})
        Wait(50)
        local data = MySQL.query.await("SELECT LAST_INSERT_ID() AS id", {})
        rowid=data[1].id
    end
    TriggerClientEvent("sam-laundrymachine:client:AddObject", -1, {id =rowid, model = model, coords = coords,cid=cid})
end)

RegisterNetEvent("sam-laundrymachine:server:removeobject", function( coords, objectid,lastmodel)
    local src = source
        MySQL.query.await("delete from laundrywash where id=?", {objectid})
        TriggerClientEvent("sam-laundrymachine:client:RemoveObject", -1, lastmodel,coords)
        local Player = QBCore.Functions.GetPlayer(src)
        Player.Functions.AddItem('laundrymachine', 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["laundrymachine"], "add")
end)

RegisterNetEvent("sam-laundrymachine:server:startspain", function( coords)
    TriggerClientEvent("sam-laundrymachine:client:spawnspain", -1,coords)
end)
RegisterNetEvent("sam-laundrymachine:server:stopspain", function( coords,data)
    TriggerClientEvent("sam-laundrymachine:client:backspain", -1,coords,data)
   
   
end)

QBCore.Functions.CreateCallback('sam-laundrymachine:server:getobject', function(_, cb)
    local data = MySQL.query.await("select * from laundrywash", {})
    cb(data)
end)

RegisterNetEvent('sam-laundrymachine:server:startwash', function( id,coord,data)
  local src=source
    local items = {}
	local result =MySQL.query.await('SELECT * FROM stashitems WHERE stash = ?', {id})
    local found =0
	if result and result[1] then
		local stashItems =json.decode(result[1].items)
		if stashItems then
			for k, item in pairs(stashItems) do
            
				local itemInfo = QBCore.Shared.Items[item.name:lower()]
                if item.name:lower()==Config.itemneed then
                    found=found+1
                 end
				if itemInfo then
					items[item.slot] = {
						name = itemInfo["name"],
						amount = tonumber(item.amount),
						info = item.info ~= nil and item.info or "",
						label = itemInfo["label"],
						description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
						weight = itemInfo["weight"],
						type = itemInfo["type"],
						unique = itemInfo["unique"],
						useable = itemInfo["useable"],
						image = itemInfo["image"],
						slot = item.slot,
					}
				end
			end
		end
	end

	if found==0 then
        TriggerClientEvent('QBCore:Notify', src,'Not Found Item','error', 1000)
        return
    end

      TriggerClientEvent('sam-laundrymachine:client:startwash', src, id,items,coord,data)
end)

RegisterNetEvent('sam-laundrymachine:server:washfinished', function(id,item)
   local newitem={}
   src=source
   local Player = QBCore.Functions.GetPlayer(src)
    for k, v in pairs(item) do
        if v.name==Config.itemneed then
            local itemInfo = QBCore.Shared.Items[Config.giveitem:lower()]
            newitem[v.slot] = {
                name = itemInfo["name"],
                amount = tonumber(v.amount),
                info =  "",
                label = itemInfo["label"],
                description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
                weight = itemInfo["weight"],
                type = itemInfo["type"],
                unique = itemInfo["unique"],
                useable = itemInfo["useable"],
                image = itemInfo["image"],
                slot = v.slot,
            }
        else
            newitem[v.slot]=v
        end
    end
    MySQL.query.await('update stashitems set items=? WHERE stash = ?', {json.encode(newitem),id})
    TriggerClientEvent('QBCore:Notify', src,'Wash Successfull', 1000)
end)