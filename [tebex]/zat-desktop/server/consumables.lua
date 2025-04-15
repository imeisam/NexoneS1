Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports[Config.FrameworkPseudo]:GetCoreObject()
    end
end)

Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        if Config.Inventory == "qb" or Config.Inventory == "ps" or Config.Inventory == "codem"  or Config.Inventory == "origen" then
            QBCore.Functions.CreateUseableItem("zatpc", function(source, item)
                local src = source
                itemInfo= {}
                TriggerClientEvent("zat-desktop:client:UseItem", src, "zatpc", Config.Items["zatpc"].model, itemInfo)
                local Player = QBCore.Functions.GetPlayer(src)
                Player.Functions.RemoveItem('zatpc', 1)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['zatpc'], 'remove')
            end)

            QBCore.Functions.CreateUseableItem("zatminingrack", function(source, item)
                local src = source
                itemInfo= {}
                TriggerClientEvent("zat-desktop:client:UseItem", src, "zatminingrack", Config.Items["zatminingrack"].model, itemInfo)
                local Player = QBCore.Functions.GetPlayer(src)
                Player.Functions.RemoveItem('zatminingrack', 1)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['zatminingrack'], 'remove')
            end)

            QBCore.Functions.CreateUseableItem("zatminingfan", function(source, item)
                local src = source
                itemInfo= {}
                TriggerClientEvent("zat-desktop:client:UseItem", src, "zatminingfan", Config.Items["zatminingfan"].model, itemInfo)
                local Player = QBCore.Functions.GetPlayer(src)
                Player.Functions.RemoveItem('zatminingfan', 1)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['zatminingfan'], 'remove')
            end)

            QBCore.Functions.CreateUseableItem("zatbaskets", function(source, item)
                local src = source
                itemInfo= {}
                TriggerClientEvent("zat-desktop:client:UseItem", src, "zatbaskets", Config.Items["zatbaskets"].model, itemInfo)
                local Player = QBCore.Functions.GetPlayer(src)
                Player.Functions.RemoveItem('zatbaskets', 1)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['zatbaskets'], 'remove')
            end)

            QBCore.Functions.CreateUseableItem("zatbasketm", function(source, item)
                local src = source
                itemInfo= {}
                TriggerClientEvent("zat-desktop:client:UseItem", src, "zatbasketm", Config.Items["zatbasketm"].model, itemInfo)
                local Player = QBCore.Functions.GetPlayer(src)
                Player.Functions.RemoveItem('zatbasketm', 1)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['zatbasketm'], 'remove')
            end)
        end
    end
end)