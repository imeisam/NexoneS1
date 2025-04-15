if Config.TextUI ~= 'ox_lib' then return end

TextUI = {}

TextUI.Options = {
    position = "left-center"
}

TextUI.Show = function(text)
    lib.showTextUI(text, TextUI.Options)
end

TextUI.Hide = function()
    lib.hideTextUI()
end

TextUI.KeyPressed = function()
    -- do nothing
end

TextUI.IsOpen = function()
    -- not used
    local isOpen, text = lib.isTextUIOpen()
    return isOpen, text
end