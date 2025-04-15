local currentResourceName = GetCurrentResourceName()

if not IsDuplicityVersion() then
    local lastInteraction = 0

    function CanInteract()
        if lastInteraction + 500 > GetGameTimer() then
            return false
        end

        lastInteraction = GetGameTimer()
        return true
    end
end

Config.ExtendedDebugPrint = false

function debugPrint(...)
    if not Config?.DebugPrint then
        return
    end

    local args = { ... }
    local appendStr = ''
    for _, v in ipairs(args) do
        appendStr = appendStr .. ' ' .. tostring(v or 'nil')
    end

    -- If the first argument is a table, print it as a table.
    if type(args[1]) == "table" then
        debugTable(args[1])
        return
    end

    -- Only get file and line info if extended debug is enabled
    if Config.ExtendedDebugPrint then
        local info = debug.getinfo(2, "Sl")
        local fileName = "unknown"

        if info and info.source then
            fileName = info.source:match("@?([^/\\]-)$") or "unknown"
            fileName = fileName:gsub(".lua", "")
        end

        local lineNumber = info.currentline
        local finalMsg = string.format("^2[%s:%d]^0%s", fileName, lineNumber, appendStr)
        print(finalMsg)
    else
        -- Simple debug print without file and line info
        print(appendStr)
    end
end

--- This will print the table in JSON like format to the console.
---@param tbl any The table to print.
function debugTable(tbl)
    if not Config.DebugPrint then
        return
    end

    if type(tbl) ~= "table" then
        debugPrint("Invalid input. Expected a table.")
        return
    end

    local function printTableHelper(tbl, indent)
        indent = indent or 0
        local indentStr = string.rep("  ", indent)

        for key, value in pairs(tbl) do
            if type(value) == "table" then
                print(indentStr .. key .. " = {")
                printTableHelper(value, indent + 1)
                print(indentStr .. "}")
            else
                print(indentStr .. key .. " = " .. tostring(value))
            end
        end
    end

    printTableHelper(tbl)
end

function IntToBool(value)
    return value == 1
end

-- Utility function to check if a table contains a specific element
function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end

    return false
end

function trimString(s, maxLength, addEllipsis)
    if addEllipsis == nil then
        addEllipsis = true
    end

    local ellipsis = "..."

    if #s > maxLength then
        if addEllipsis then
            return s:sub(1, maxLength - #ellipsis) .. ellipsis
        else
            return s:sub(1, maxLength)
        end
    else
        return s
    end
end

function cl_Imei(imei)
    if not imei then return nil end

    local cleanImei = string.gsub(imei, ':boomer', '')
    return cleanImei
end

function Imei(imei)
    if not imei then return nil end
    local cleanImei = string.gsub(imei, ':boomer', '')
    return cleanImei .. ':boomer'
end
