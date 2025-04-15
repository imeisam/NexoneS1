local QBCore = exports['qb-core']:GetCoreObject()
local scenes = {}

local function updateAllScenes()
    scenes = {}
    MySQL.Async.fetchAll('SELECT * FROM scenes', {}, function(result)
        if result[1] then
            for _, v in pairs(result) do
                local sceneData = json.decode(v.data)
                sceneData.id = v.id
                sceneData.coords = vector3(sceneData.coords.x, sceneData.coords.y, sceneData.coords.z)
                scenes[#scenes+1] = sceneData
            end
        end
        TriggerClientEvent('qb-scenes:client:updateAllScenes', -1, scenes)
    end)
end

local function deleteExpiredScenes()
    if Config.NeverExpire then
        MySQL.Async.execute('DELETE FROM scenes WHERE deleteAt < NOW() AND `neverExpire` = 0', {}, function(result)
            if result > 0 then
                updateAllScenes()
            end
        end)
    else
        MySQL.Async.execute('DELETE FROM scenes WHERE deleteAt < NOW()', {}, function(result)
            if result > 0 then
                updateAllScenes()
            end
        end)
    end
end

local function countScenes(identifier)
    local count = 0
    for i = 1, #scenes do
        if scenes[i].creator == identifier then
            count = count+1
        end
    end
    return count
end

local function getIdentifier(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        return Player.PlayerData.citizenid
    end
end

RegisterNetEvent('qb-scenes:server:createScene', function(sceneData)
    local src = source
    local identifier = getIdentifier(src)
    local count = countScenes(identifier)
    if count > Config.MaxScenes then
        return TriggerClientEvent('QBCore:Notify', src, "You have exceed the max scene count", "error")
    end
    sceneData.creator = identifier
    MySQL.Async.insert('INSERT INTO scenes (creator, data, createdAt, deleteAt, neverExpire) VALUES (?, ?, NOW(), DATE_ADD(NOW(), INTERVAL ? HOUR), ?)', {
        identifier, json.encode(sceneData), sceneData.duration, sceneData.neverExpire
    }, function(id)
        sceneData.id = id
        if Config.Log then
            local Player = QBCore.Functions.GetPlayer(src)
            TriggerEvent("qb-log:server:CreateLog", "scenes", "New Scene Created", "green", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) created a new scene; scene: **"..sceneData.text.."**, where: **" .. sceneData.coords .. "**, Id: **"..id.."**")
        end
        scenes[#scenes+1] = sceneData
        TriggerClientEvent('qb-scenes:client:addScene', -1, sceneData)
    end) 
end)

RegisterNetEvent('qb-scenes:server:deleteScene', function(sceneId)
    local src = source
    MySQL.Async.execute('DELETE FROM scenes WHERE id = ?', {sceneId}, function()
        if Config.Log then
            local Player = QBCore.Functions.GetPlayer(src)
            TriggerEvent("qb-log:server:CreateLog", "scenes", "Scene Deleted", "red", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) delete scene with ID: **"..sceneId.."**")
        end
        table.remove(scenes, scenePos)
        TriggerClientEvent('qb-scenes:client:removeScene', -1, sceneId)
        TriggerClientEvent('QBCore:Notify', src, "Scene Deleted", "success")
    end)
end)

lib.callback.register('qb-scenes:server:getScenes', function()
    return scenes
end)

CreateThread(function()
    updateAllScenes()
    while true do
        deleteExpiredScenes()
        Wait(Config.AuditInterval * 1000 * 60)
    end
end)