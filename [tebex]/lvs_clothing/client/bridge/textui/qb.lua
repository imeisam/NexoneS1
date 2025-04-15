if Config.TextUI ~= 'qb' then return end

TextUI = {}

TextUI.Options = {
    position = "left"
}

TextUI.Show = function(text)
    exports['qb-core']:DrawText(text, TextUI.Options.position)
end

TextUI.Hide = function()
    exports['qb-core']:HideText()
end

TextUI.KeyPressed = function()
    exports['qb-core']:keyPressed()
end
