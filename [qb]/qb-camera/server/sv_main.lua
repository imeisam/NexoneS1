local QBCore = exports['qb-core']:GetCoreObject()
local webhook = "https://discord.com/api/webhooks/1226982589009494130/Lb6xY1TywKAJOg_eo2CwtNxIH2hNJgjmM-YbsMjkrrpmN7bQ0BwPxpr_Tw6vo7zS6T1T"

url="https://nxone.ir/camera/image"
photoviewurl="https://cam.nxone.ir/"

AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
    TriggerClientEvent('qb-camera:getHook', Player.PlayerData.source, url)
end)

RegisterNetEvent("qb-camera:savePhoto", function(url, streetName)
    local source = source
    local player = QBCore.Functions.GetPlayer(source)
    if not player then return end
    player.Functions.AddItem("photo", 1, nil, {image =photoviewurl..url,location = streetName})
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['photo'], "add", 1, photoviewurl..url)
end)

QBCore.Functions.CreateUseableItem("camera", function(source, item)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName(item.name) then
        TriggerClientEvent("qb-camera:useCamera", source)
    end
end)

QBCore.Functions.CreateUseableItem("photo", function(source, item)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName(item.name) then
        TriggerClientEvent("qb-camera:usePhoto", source, item.info.image, item.info.location)
    end
end)