RegisterNetEvent('orbit-chopshop:StartMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = 'Chop Parts',
            -- icon = 'fas fa-code',
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },
        {
            header = 'Door',
            icon = 'fas fa-code-merge',
            txt = 'Print a message!',
            params = {
                event = "orbit-chopshop:chopdoor",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },  
        {
            header = 'Wheel',
            icon = 'fas fa-code-merge',
            txt = 'Print a message!',
            params = {
                event = "orbit-chopshop:chopwheel",
                args = {
                    number = 1,
                    id = 2
                }
            }
        }, 
        {
            header = 'Hood',
            icon = 'fas fa-code-merge',
            params = {
                event = "orbit-chopshop:chophood",
                args = {
                    number = 1,
                    id = 2
                }
            }
        }, 
        {
            header = 'Trunk',
            icon = 'fas fa-code-merge',
            params = {
                event = "orbit-chopshop:choptrunk",
                args = {
                    number = 1,
                    id = 2
                }
            }
        }, 

    })
end)

RegisterNetEvent('orbit-chopshop:chopdoor')
AddEventHandler('orbit-chopshop:chopdoor', function()
    TriggerServerEvent("orbit-chopshop:server:chopdoor")
end)

RegisterNetEvent('orbit-chopshop:chopwheel')
AddEventHandler('orbit-chopshop:chopwheel', function()
    TriggerServerEvent("orbit-chopshop:server:chopwheel")
end)

RegisterNetEvent('orbit-chopshop:chophood')
AddEventHandler('orbit-chopshop:chophood', function()
    TriggerServerEvent("orbit-chopshop:server:chophood")
end)

RegisterNetEvent('orbit-chopshop:choptrunk')
AddEventHandler('orbit-chopshop:choptrunk', function()
    TriggerServerEvent("orbit-chopshop:server:choptrunk")
end)