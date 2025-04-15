local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("headbag", function(source, item)
    TriggerClientEvent("qb-headbag:client:useBag", source)
end)

QBCore.Commands.Add("removeheadbag", 'Remove Headbag', {{name = "id", help = 'target Id'}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local playerId = tonumber(args[1])
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if OtherPlayer and playerId ~= source then
        if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(playerId))) >= 5 then return end
        if not Player.PlayerData.metadata["ishandcuffed"] and not Player.PlayerData.metadata["isdead"] and not Player.PlayerData.metadata["inlaststand"] then
            if OtherPlayer.PlayerData.metadata["gooni"] then
                OtherPlayer.Functions.SetMetaData("gooni", false)
                Player.Functions.AddItem('headbag', 1)
                TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["headbag"], "add")
                TriggerClientEvent("qb-headbag:client:removeBag", playerId)
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'Player ID is wrong', 'error')
    end
end)

RegisterNetEvent('qb-headbag:server:useBag', function(playerId)
    local src = source
    if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(playerId))) >= 10 then return end
    local Player = QBCore.Functions.GetPlayer(src)
    local Target = QBCore.Functions.GetPlayer(playerId)
    if Target then
        if not Target.PlayerData.metadata["gooni"] and (Target.PlayerData.metadata["ishandcuffed"] or Target.PlayerData.metadata["isdead"] or Target.PlayerData.metadata["inlaststand"]) then
            if Player.Functions.RemoveItem('headbag', 1) then
                Target.Functions.SetMetaData("gooni", true)
                TriggerClientEvent("qb-headbag:client:getBag", Target.PlayerData.source)
            end
        end
    end
end)