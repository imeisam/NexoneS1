Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports['qb-core']:GetCoreObject()
    end
end)
Citizen.CreateThread(function() 
    QBCore.Functions.CreateUseableItem("washmachine", function(source)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local model = Config.MachineProp
        if not Player or not Player.Functions.GetItemByName('washmachine') then return end
        if Player.Functions.GetItemByName('washmachine') then
            local id = ""..Player.PlayerData.citizenid..""..math.random(111111,999999)
            TriggerClientEvent("zat-washmoney:client:PlaceTable", src, id, model)
        else
            TriggerClientEvent('QBCore:Notify', "Missing Item...", "error")
        end
    end)
end)