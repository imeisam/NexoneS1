local VehicleNitrous = {}
local isdrop={}
function getdevelopermode()
    return developermode
   end
   exports("getdevelopermode",getdevelopermode)
   
RegisterNetEvent('qb-smallresources:server:isdrop', function()
    local src = source
    isdrop[src]=true
    local Player = QBCore.Functions.GetPlayer(src)
    SetTimeout(5000, function()
        isdrop[src]=false
    end)
end)

RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
    local src = source
    if isdrop[src] then
        local Player = QBCore.Functions.GetPlayer(src)
        TriggerEvent("qb-log:server:CreateLog", "quitinventory", "Inventory Duplicate", "red", "**".. Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*)")
    end
end)

RegisterNetEvent('qb-smallresources:server:addcigar', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.AddItem('cigarette', 1)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['cigarette'], "add")
end)

RegisterNetEvent('tackle:server:TacklePlayer', function(playerId)
    if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(playerId))) >= 5 then return end
    TriggerClientEvent("tackle:client:GetTackled", playerId)
end)

QBCore.Functions.CreateCallback('nos:GetNosLoadedVehs', function(_, cb)
    cb(VehicleNitrous)
end)

QBCore.Commands.Add("id", "Check Your ID #", {}, false, function(source)
    local src = source
    TriggerClientEvent('QBCore:Notify', src,  "ID: "..src)
end)

QBCore.Functions.CreateUseableItem("harness", function(source, item)
    TriggerClientEvent('seatbelt:client:UseHarness', source, item)
end)

RegisterNetEvent('equip:harness', function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.items[item.slot].info.uses == 1 then
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['harness'], "remove")
        Player.Functions.RemoveItem('harness', 1)
    else
        Player.PlayerData.items[item.slot].info.uses = Player.PlayerData.items[item.slot].info.uses - 1
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)

RegisterNetEvent('seatbelt:DoHarnessDamage', function(hp, data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if hp == 0 then
        Player.Functions.RemoveItem('harness', 1, data.slot)
    else
        Player.PlayerData.items[data.slot].info.uses = Player.PlayerData.items[data.slot].info.uses - 1
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)

AddEventHandler("entityCreating", function(handle)
    local entityModel = GetEntityModel(handle)
    if (BlacklistedVehs[entityModel])  then
        CancelEvent()
    else
        if GetEntityPopulationType(handle) == 2 and GetEntityType(handle) == 2  then
            if (nospawnVehs[entityModel])  then
                CancelEvent()
            else
                  -- if  math.random(1,100) <80 then
                      SetVehicleDoorsLocked(handle, 2)
                  -- end
            end
        end
    end
end)

function blacklistvehicle()
return BlacklistedVehs,nospawnVehs
end
exports("blacklistvehicle",blacklistvehicle)