local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-whiteboard:changewhiteboard', function(url, room)
    local Player = QBCore.Functions.GetPlayer(source)
    if Config.Locations[room] ~= nil  then
        Config.Locations[room].currentImage = url
        TriggerClientEvent('qb-whiteboard:changewhiteboardcli', -1, url, room)
        if Config.Locations[room].autosave then
            MySQL.query.await('delete from whiteboard where name=?', {room})
            MySQL.query.await('insert whiteboard(image,name)values(?,?)', {url,room})
        end
    end
end)

CreateThread(function()
    MySQL.ready(function()
        local data = MySQL.query.await('SELECT * FROM whiteboard', {})
        if data and data[1] then
            for k,v in pairs(data) do
                if Config.Locations[v.name] then
                    Config.Locations[v.name].currentImage=v.image
                end
            end
        end
    end)
   
end)


QBCore.Functions.CreateCallback('qb-whiteboard:getCurrentImage', function(_, cb)
    local images = {}
    for k,v in pairs(Config.Locations) do
        images[k] = v.currentImage
    end
    cb(images)
end)