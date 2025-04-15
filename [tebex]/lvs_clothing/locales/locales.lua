Locales = {}

local lang = Config.Lang

function _L(key)
    if not Locales[lang] then
        lang = "en"
    end
    local value = Locales[lang]
    for k in key:gmatch("[^.]+") do
        value = value[k]
        if not value then
            print("Missing locale for: " .. key)
            return ""
        end
    end
    return value
end
