local QBCore = exports['qb-core']:GetCoreObject()

local Objects = {}
local bags={}
local function CreateObjectId()
    if Objects then
        local objectId = math.random(10000, 99999)
        while Objects[objectId] do
            objectId = math.random(10000, 99999)
        end
        return objectId
    else
        local objectId = math.random(10000, 99999)
        return objectId
    end
end

QBCore.Functions.CreateUseableItem('emsbag', function(source, item)TriggerClientEvent("Ranjit-EmsBag:Client:spawnLight", source,item)end)

RegisterNetEvent('Ranjit-EmsBag:Server:SpawnAmbulanceBag', function(type,item)
    local src = source
    local objectId = CreateObjectId()
    Objects[objectId] = type
    TriggerClientEvent("Ranjit-EmsBag:Client:SpawnAmbulanceBag", src,item)
end)

RegisterNetEvent('Ranjit-EmsBag:Server:RemoveItem', function(item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(item, amount)
end)

RegisterNetEvent('Ranjit-EmsBag:Server:AddItem', function(item, amount,bagid)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(item, amount,nil,{id=bagid})
end)

RegisterNetEvent('Ranjit-EmsBag:Server:bagcoord', function( bagid,coord)
    bags[bagid]=coord
    TriggerClientEvent("Ranjit-EmsBag:Client:getbags", -1, bags)
end)

RegisterNetEvent('Ranjit-EmsBag:Server:getbas', function()
    local src = source
    TriggerClientEvent("Ranjit-EmsBag:Client:getbags", src, bags)
end)

QBCore.Functions.CreateCallback('Ranjit-EmsBag:Server:getbascallback', function(source, cb)
    cb(bags)
end)
