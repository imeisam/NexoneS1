if not Config.UseRadialMenu or Config.Radial ~= 'qb-radialmenu'  then return end

function Radial.Add(title, event)
    exports['qb-radialmenu']:AddOption({
        id = Radial.MenuID,
        title = title,
        icon = "shirt",
        type = "client",
        event = event,
        shouldClose = true
    }, Radial.MenuID)
end

function Radial.Remove()
    exports['qb-radialmenu']:RemoveOption(Radial.MenuID)
end
