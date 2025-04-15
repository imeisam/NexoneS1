if Config.TextUI ~= 'lvs_lib' then return end

TextUI = {}

TextUI.Show = function(text)
    exports.lvs_lib:showTextUI(text, 'E')
end

TextUI.Hide = function()
    lib.hideTextUI()
    exports.lvs_lib:hideTextUI()
end

TextUI.KeyPressed = function()
    exports.lvs_lib:pressedTextUI()
end