if not Config.Enable then return end

local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-voting:client:openVoteMenu', function()
    if QBCore.Functions.GetPlayerData().metadata[Config.VoteMetaData] then
        QBCore.Functions.Notify('Aya to siroosi?', 'error')
        return
    end
    local Menu = {}
    for k,v in ipairs(Config.Candidates) do
        Menu[#Menu + 1] = {
            header = v,
            params = {
                isServer = true,
                event = "qb-voting:server:vote",
                args = k
            }
        }
    end
    exports['qb-menu']:openMenu(Menu)
end)

CreateThread(function()
    for k, v in ipairs(Config.Locs) do
        exports['qb-target']:AddBoxZone(k..'_voting', v, 0.5,0.5, {
            name = k..'_voting',
            debugPoly = false,
            heading = 0,
            minZ = v.z - 1.0,
            maxZ = v.z + 1.0,
        }, {
            options = {
                {
                    action = function()
                        TriggerEvent('qb-voting:client:openVoteMenu')
                    end,
                    icon = "fa fa-flag",
                    label = "Vote"
                },
            },
            distance = 1.5
        })
    end
end)