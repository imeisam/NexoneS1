RegisterCommand("gps", function()
    local keyboard = exports['qb-input']:ShowInput({
		header = "Fill Coords",
		submitText = "Confirm",
		inputs = {
			{
				type = 'text',
				isRequired = true,
				text = "X",
				name = 'x',
			},
			{
				type = 'text',
				isRequired = true,
				text = "Y",
				name = 'y',
			},
		}
	})
    if keyboard and keyboard.x and keyboard.y then
        local x = tonumber(keyboard.x)
        local y = tonumber(keyboard.y)
        if x and y then
            SetNewWaypoint(x, y)
        end
    end
end) TriggerEvent('chat:addSuggestion', '/gps', 'Check GPS Location')