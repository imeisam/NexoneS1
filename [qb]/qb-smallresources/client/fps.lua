RegisterCommand('fps', function()
    OpenFPSMenu()
end)


function OpenFPSMenu()
    local menu = {
        {
            header = "FPS type",
            isMenuHeader = true,
        },
        {
            header = "Boost",
            params = {
                event = "qb-fpsmenu:client:active",
            }
        },
        {
            header = "Normal",
            params = {
                event = "qb-fpsmenu:client:disable",
            }
        },
        {
            header = "Return",
            icon = "fa-solid fa-angle-left",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    }
    exports['qb-menu']:openMenu(menu)
end

AddEventHandler('qb-fpsmenu:client:active', function()
    SetTimecycleModifier('yell_tunnel_nodirect')
end)

AddEventHandler('qb-fpsmenu:client:disable', function()
    SetTimecycleModifier()
    ClearTimecycleModifier()
    ClearExtraTimecycleModifier()
end)