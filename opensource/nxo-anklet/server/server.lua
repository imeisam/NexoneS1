QBCore = exports['qb-core']:GetCoreObject()
electroCuffedPlayers = {}

QBCore.Functions.CreateUseableItem(Config.BagToHeadItem, function(source, item) 
    local xPlayer = QBCore.Functions.GetPlayer(source)
	TriggerClientEvent('s4-cuff:client:cuval', source)--head bag
end)
QBCore.Commands.Add('halat',"", {}, false, function(source)
    TriggerClientEvent('s4-cuff:client:use', source)
end)

QBCore.Functions.CreateUseableItem(Config.RopeItem, function(source, item) 
    local xPlayer = QBCore.Functions.GetPlayer(source)
	TriggerClientEvent('s4-cuff:client:halat', source)
end)

QBCore.Functions.CreateUseableItem(Config.ElectronicCuffItem, function(source, item) 
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local item = xPlayer.Functions.GetItemByName(Config.ElectronicCuffItem)
    if item and xPlayer then 
        if xPlayer.PlayerData.job.name == 'police' or xPlayer.PlayerData.job.name == 'justice' then 
            TriggerClientEvent('cuff:client:useElectronicCuff', source)
        end
    end
end) 

-- QBCore.Functions.CreateUseableItem(Config.ElectronicCuffTrackerItem, function(source, item) 
--     local xPlayer = QBCore.Functions.GetPlayer(source)
--     local item = xPlayer.Functions.GetItemByName(Config.ElectronicCuffTrackerItem)
--     if item and xPlayer then 
--         if xPlayer.PlayerData.job.name == 'police'  then 
--            TriggerClientEvent('cuff:client:showElectronicCuffTrackMenu', source)
--         end
--     end
-- end) 



RegisterServerEvent('s4-cuff:server:ProcessCuffs')
AddEventHandler('s4-cuff:server:ProcessCuffs', function(p, id)
   TriggerClientEvent('s4-cuff:client:ProcessCuffs', tonumber(id), p)
end)

RegisterServerEvent('s4-cuff:server:RemoveCuffs')
AddEventHandler('s4-cuff:server:RemoveCuffs', function(p, id)
   TriggerClientEvent('s4-cuff:client:RemoveCuffs', tonumber(id), p)
end)

RegisterServerEvent('s4-cuff:drag')
AddEventHandler('s4-cuff:drag', function(target)
    TriggerClientEvent('s4-cuff:drag', target, source)
end)

RegisterServerEvent('s4-cuff:client:halat_baglanan')
AddEventHandler('s4-cuff:client:halat_baglanan', function(target)
    TriggerClientEvent('s4-cuff:client:halat_baglanan', target)
end)

RegisterServerEvent('s4-cuff:client:cuval')
AddEventHandler('s4-cuff:client:cuval', function(target, bag)
    TriggerClientEvent('s4-cuff:client:kafacuval', target, bag)
end)


RegisterServerEvent('s4-cuff:client:putInVehicle')
AddEventHandler('s4-cuff:client:putInVehicle', function(target)
    TriggerClientEvent('s4-cuff:client:putInVehicle', target)
end)

RegisterServerEvent('s4-cuff:client:OutVehicle')
AddEventHandler('s4-cuff:client:OutVehicle', function(target)
    TriggerClientEvent('s4-cuff:client:OutVehicle', target)
end)

RegisterServerEvent('s4-cuff:client:agzapara')
AddEventHandler('s4-cuff:client:agzapara', function(tip, target)
    TriggerClientEvent('s4-cuff:client:agzapara', target, tip)
end)

function SyncElectrocuffedPlayers() 
    MySQL.ready(function() 
        MySQL.Async.fetchAll("SELECT * FROM electrocuffed_players", {}, function(data) 
            local players = {}

            for k,v in ipairs(data) do 
                local xPlayer = QBCore.Functions.GetPlayerByCitizenId(v.id)
                local playerData = {}

                if xPlayer then 
                    playerData = {
                        identifier = xPlayer.PlayerData.citizenid ,
                        id = xPlayer.PlayerData.source,
                        name = xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname,
                        cuffDate = v.date,
                    }
                else
                    playerData = {
                        identifier = v.id,
                        id = nil,
                        name =v.name,
                        cuffDate = v.date,
                        zone=json.decode(v.zone),
                    }
                end

                table.insert(players, playerData)
            end

            electroCuffedPlayers = players
        end)
    end)
end

AddEventHandler("onResourceStart", SyncElectrocuffedPlayers)

RegisterServerEvent("cuff:server:electroCuffPlayer")
AddEventHandler("cuff:server:electroCuffPlayer", function(player,zonename) 
    local source = source
    local xPlayer = QBCore.Functions.GetPlayer(player)
    local userExists = false

    -- for k,v in ipairs(electroCuffedPlayers) do 
    --     if v.id == player then 
    --         userExists = true
    --         break
    --     end
    -- end
    local result = MySQL.query.await('SELECT * FROM electrocuffed_players WHERE id = ?', { xPlayer.PlayerData.citizenid })

    if result and result[1] then 
        TriggerClientEvent('QBCore:Notify', source, "Allready has Anklet","error") 
        return 
    end

    if xPlayer and not userExists then 
        local playerData = {
            identifier = xPlayer.PlayerData.citizenid ,
            id = player,
            cuffDate = os.date(),
            name = xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname,
        }

        MySQL.Async.execute("INSERT INTO electrocuffed_players (id, date,zone,name) VALUES (@identifier, @date,@zonename,@name)", { 
            ["@identifier"] = xPlayer.PlayerData.citizenid,  
            ["@date"] = playerData.cuffDate, 
            ["@zonename"] =json.encode(zonename), 
            ["@name"] = xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname, 
        }, function() 
            playerData.zonename=zonename
            table.insert(electroCuffedPlayers, playerData)
        end)
        local sPlayer = QBCore.Functions.GetPlayer(source)
        sPlayer.Functions.RemoveItem(Config.ElectronicCuffItem, 1)
        TriggerClientEvent('cuff:client:animshok', source)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.ElectronicCuffItem], 'remove')
        TriggerClientEvent("cuff:client:startanklet", xPlayer.PlayerData.source)

        TriggerEvent('qb-log:server:CreateLog', 'anklet', 'Attach Anklet', 'red','Officer:'.. sPlayer.PlayerData.charinfo.firstname..' '..sPlayer.PlayerData.charinfo.lastname ..'\nSuccpect:' .. xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname)

    end
end)

RegisterServerEvent("cuff:server:shockPlayer")
AddEventHandler("cuff:server:shockPlayer", function(player)
    local xPlayer = QBCore.Functions.GetPlayerByCitizenId (player)
    TriggerClientEvent("cuff:client:shock", xPlayer.PlayerData.source)
end)

QBCore.Functions.CreateCallback("cuff:server:getElectroCuffedPlayers", function(source, cb, cid)
    MySQL.ready(function() 
        local cmd=""
        if cid~=nil then
            cmd=" where id="..cid
        end
        MySQL.Async.fetchAll("SELECT * FROM electrocuffed_players"..cmd, {}, function(data) 
            local players = {}
            if data and data[1] then
            for k,v in ipairs(data) do 
                local xPlayer = QBCore.Functions.GetPlayerByCitizenId(v.id)
                local playerData = {}
                if xPlayer then 
                    playerData = {
                        identifier = xPlayer.PlayerData.citizenid ,
                        id = xPlayer.PlayerData.source,
                        name = xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname,
                        cuffDate = v.date,
                        zone=json.decode(v.zone),
                        coords = GetEntityCoords(GetPlayerPed(xPlayer.PlayerData.source))
                    }
                else
                    playerData = {
                        identifier = v.id,
                        id = nil,
                        name =v.name,
                        cuffDate = v.date,
                        zone=json.decode(v.zone),
                        coords = nil
                    }
                end

                table.insert(players, playerData)
            end
        end
            tmpelectroCuffedPlayers = players
            cb(tmpelectroCuffedPlayers or {})
        end)
    end)
end)

RegisterServerEvent("cuff:server:disableElectroCuff")
AddEventHandler("cuff:server:disableElectroCuff", function(player) 
  local src=source
  play=QBCore.Functions.GetPlayer(src)
  MySQL.Sync.execute("DELETE FROM electrocuffed_players WHERE id = @identifier", { ["@identifier"] = player.playerdata.identifier})

  TriggerEvent('qb-log:server:CreateLog', 'anklet', 'Deattach Anklet', 'green','Officer:' ..play.PlayerData.charinfo.firstname..' '..play.PlayerData.charinfo.lastname ..'\nSuccpect:' .. player.playerdata.name)
  
    if player.playerdata.id then
        local xPlayer = QBCore.Functions.GetPlayer(player.playerdata.id)
        if xPlayer then
            local sPlayer = QBCore.Functions.GetPlayer(src)
            sPlayer.Functions.AddItem(Config.ElectronicCuffItem, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.ElectronicCuffItem], 'add')
            TriggerClientEvent("cuff:client:removeanklet", xPlayer.PlayerData.source)
        end
    end
   
   
end)

RegisterServerEvent("cuff:server:predisableElectroCuff")
AddEventHandler("cuff:server:predisableElectroCuff", function(player,playertarget,disct) 
  local src=source
  local animation=true
    if player.playerdata.id then
        local xPlayer = QBCore.Functions.GetPlayer(player.playerdata.id)
        if xPlayer then
            if player.playerdata.id==playertarget and disct<2.0 then
            else
                TriggerClientEvent('QBCore:Notify', source, "Not Found Person...!","error") 
                return
            end
        else
            animation=false
        end
    else
        animation=false 
    end

    TriggerClientEvent('cuff:client:predisableElectroCuff', src, player,animation)
  
end)