RegisterNetEvent('qb-bag:client:getStashs', function(data)
    local Menu = {}
    Menu[#Menu + 1] = { header = "", txt = '❌ Close', params = { event = "qb-menu:closeMenu" } }
    for k,v in ipairs(data) do
        Menu[#Menu + 1] = {
            header = v,
            params = {
                isAction = true,
                event = function(kodom)
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'evidencebag_'..kodom, {maxweight = 200000, slots = 100})
                end,
                args = v
            }
        }
    end
    exports['qb-menu']:openMenu(Menu)
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone('policeevidencebagref', vector3(466.39215087891, -998.23406982422, 30.689279556274), 1.0,1.0, {
        name = 'policeevidencebagref',
        debugPoly = false,
        heading = 0,
        minZ = 29.6,
        maxZ = 31.6,
    }, {
        options = {
            {
                action = function()
                    TriggerServerEvent("qb-bag:server:getStashs")
                end,
                icon = "fas fa-box-open",
                label = "Evidence Bags",
                job = 'police'
            },
        },
        distance = 1.5
    })
end)