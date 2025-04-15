

RegisterNUICallback("shockPlayer", function(player) 
	TriggerServerEvent("cuff:server:shockPlayer", player.playerdata.identifier)
end)

RegisterNUICallback("toggleGPS", function(player, cb) 
    for k,v in pairs(player.playerdata) do 
        if v.gpsEnabled then 
            trackedPlayers[v.identifier]=nil
        else
            trackedPlayers[v.identifier]=true
        end
    end
end)

RegisterNUICallback("markGPS", function(player)
    SetNewWaypoint(player.coords.x, player.coords.y)
end)

RegisterNUICallback("unlockPlayer", function(player) 
    local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
	TriggerServerEvent("cuff:server:predisableElectroCuff", player, GetPlayerServerId(closestPlayer),closestDistance)
end)

