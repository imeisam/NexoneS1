
local QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent('police:server:getxraycitizen', function(stashid)
    src=source
    local data = MySQL.query.await("SELECT  REPLACE(stash, 'xraygate_"..stashid.."_', '') AS cid,items  FROM stashitems WHERE items<>'[]' and stash LIKE 'xraygate_"..stashid.."_%'", {})
    for k, v in pairs(data) do
        local tmp = MySQL.query.await("SELECT charinfo FROM players WHERE citizenid=?", {v.cid})
        if tmp and tmp[1] then
          local info=json.decode(tmp[1].charinfo)
            data[k].name=info.firstname..' '..info.lastname
        end
    end
    TriggerClientEvent('police:client:getxraycitizen',src,data,stashid)
end)

