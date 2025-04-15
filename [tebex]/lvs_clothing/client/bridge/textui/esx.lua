if Config.TextUI ~= 'esx' then return end

TextUI = {}


TextUI.Show = function(text)
    Framework.TextUI(text)
end

TextUI.Hide = function()
    Framework.HideUI()
end

TextUI.KeyPressed = function()
    -- do nothing
end