local Stashes = {}

MySQL.ready(function()
	MySQL.Async.fetchAll('SELECT * FROM stashitems', {}, function(result)
        if result[1] then
            for k,v in pairs(result) do
                if v.stash and string.find(v.stash, 'evidencebag_') then
                    Stashes[#Stashes + 1] = string.gsub(v.stash, 'evidencebag_', '')
                end
            end
        end
    end)
end)

RegisterNetEvent('qb-bag:server:getStashs', function()
    local src = source
    TriggerClientEvent('qb-bag:client:getStashs', src, Stashes)
end)