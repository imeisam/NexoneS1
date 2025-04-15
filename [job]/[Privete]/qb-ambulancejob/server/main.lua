local QBCore = exports['qb-core']:GetCoreObject()
-- Events
local Manualcheckin={}
-- Compatibility with txAdmin Menu's heal options.
-- This is an admin only server side event that will pass the target player id or -1.
AddEventHandler('txAdmin:events:healedPlayer', function(eventData)
	if GetInvokingResource() ~= "monitor" or type(eventData) ~= "table" or type(eventData.id) ~= "number" then
		return
	end
	TriggerClientEvent('hospital:client:Revive', eventData.id)
end)

RegisterNetEvent('hospital:server:SendToBed', function(bedId)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	TriggerClientEvent('hospital:client:SendToBed', src, bedId, Config.Locations["beds"][bedId])
	TriggerClientEvent('hospital:client:SetBed', -1, bedId, true)
	Player.Functions.RemoveMoney("bank", Config.BillCost , "Respawned at Hospital")
	exports["snipe-banking"]:AddMoneyToAccount("ambulance",  Config.BillCost,"Respawn: "..Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname )
	TriggerClientEvent('hospital:client:SendBillEmail', src, Config.BillCost)
end)
local function DnaHash(s)
    local h = string.gsub(s, ".", function(c)
        return string.format("%02x", string.byte(c))
    end)
    return h
end
RegisterNetEvent('ambulance:target:getDNA', function(playerid)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(playerid))
    if ((Player.PlayerData.job.name == "ambulance") and Player.PlayerData.job.onduty) and OtherPlayer then
        if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
            local info = {
                label = "DNA",
                type = "dna",
                dnalabel = DnaHash(OtherPlayer.PlayerData.citizenid),
				dnaname=OtherPlayer.PlayerData.charinfo.firstname..' '..OtherPlayer.PlayerData.charinfo.lastname,
            }
            if Player.Functions.AddItem("filled_evidence_bag", 1, false, info) then
                TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            end
        else
            TriggerClientEvent('QBCore:Notify', src,"No have a Empty EvidenceBag", "error")
        end
    end
end)

RegisterNetEvent('hospital:server:RespawnAtHospital', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	for k, v in pairs(Config.Locations["beds"]) do
		if not v.taken then
			TriggerClientEvent('hospital:client:SendToBed', src, k, v)
			TriggerClientEvent('hospital:client:SetBed', -1, k, true)
			if Config.WipeInventoryOnRespawn then
				Player.Functions.ClearInventory()
				TriggerClientEvent('QBCore:Notify', src, Lang:t('error.possessions_taken'), 'error')
			end
			Player.Functions.RemoveMoney("bank", Config.BillCost, "Respawned at hospital")
			exports["snipe-banking"]:AddMoneyToAccount("ambulance",  Config.BillCost,"Respawn: "..Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname )
			TriggerClientEvent('hospital:client:SendBillEmail', src, Config.BillCost)
			return
		end
	end

	TriggerClientEvent('hospital:client:SendToBed', src, 1, Config.Locations["beds"][1])
	TriggerClientEvent('hospital:client:SetBed', -1, 1, true)
	if Config.WipeInventoryOnRespawn then
		Player.Functions.ClearInventory()
		TriggerClientEvent('QBCore:Notify', src, Lang:t('error.possessions_taken'), 'error')
	end

	Player.Functions.RemoveMoney("bank", Config.BillCost, "Respawned at hospital")
	exports["snipe-banking"]:AddMoneyToAccount("ambulance",  Config.BillCost,"Respawn: "..Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname )
	TriggerClientEvent('hospital:client:SendBillEmail', src, Config.BillCost)
end)

RegisterNetEvent('hospital:server:LeaveBed', function(id)
    TriggerClientEvent('hospital:client:SetBed', -1, id, false)
end)

RegisterNetEvent('hospital:server:updateHpArmor', function(health, armor)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        Player.Functions.SetMetaData('health', health)
        Player.Functions.SetMetaData('armor', armor)
    end
end)

RegisterNetEvent('hospital:server:SetDeathStatus', function(isDead)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player then
		Player.Functions.SetMetaData("isdead", isDead)
	end
end)

RegisterNetEvent('hospital:server:SetLaststandStatus', function(bool)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player then
		Player.Functions.SetMetaData("inlaststand", bool)
	end
end)

RegisterNetEvent('hospital:server:RevivePlayer', function(playerId)
	local Patient = QBCore.Functions.GetPlayer(playerId)
	if Patient then
		TriggerClientEvent('hospital:client:Revive', Patient.PlayerData.source)
	end
end)

-- Callbacks

CreateThread(function()
	Manualcheckin["davis"]=false
	Manualcheckin["sandy"]=false
end)
QBCore.Functions.CreateCallback('hospital:GetOnlineDoctors', function(source, cb)
	local xPlayers = QBCore.Functions.GetPlayers()
	local doctor = 0
	for i=1, #xPlayers, 1 do
		local xPlayer = QBCore.Functions.GetPlayer(xPlayers[i])
		if xPlayer.PlayerData.job.name == 'ambulance' and xPlayer.PlayerData.job.onduty then
			doctor = doctor + 1
		end
	end
	cb(doctor,Manualcheckin)
end)

RegisterNetEvent('qb-ambulancejob:server:checkinpatient', function(data,playerid)
	TriggerClientEvent('qb-ambulancejob:checkin',playerid,data)
end)
RegisterNetEvent('qb-ambulancejob:server:activecheckin', function(typemd)
	if Manualcheckin[typemd] then
		TriggerClientEvent('QBCore:Notify', source, "Now Deactive Auto Checkin", 'error')
		Manualcheckin[typemd]=false
	else
		Manualcheckin[typemd]=true
		TriggerClientEvent('QBCore:Notify', source, "Now Active Auto Checkin", 'success')
	end
	
end)


-- Items

QBCore.Functions.CreateUseableItem("ifaks", function(source, item)
	TriggerClientEvent("hospital:client:UseIfaks", source, item.slot)
end)

QBCore.Functions.CreateUseableItem("medkit", function(source, item)
	TriggerClientEvent("hospital:client:UseMedkit", source, item.slot)
end)

QBCore.Functions.CreateUseableItem("oxy", function(source, item)
	TriggerClientEvent("hospital:client:UseOxy", source, item.slot)
end)

QBCore.Functions.CreateUseableItem("gauze", function(source, item)
	TriggerClientEvent("hospital:client:UseGause", source, item.slot)
end)

QBCore.Functions.CreateUseableItem("bandage", function(source, item)
	TriggerClientEvent("hospital:client:UseBandage", source, item.slot)
end)

QBCore.Functions.CreateUseableItem("bandage", function(source, item)
	TriggerClientEvent("hospital:client:UseBandage", source, item.slot)
end)