---@param iterations number The amount of iterations to run
---@param config GridConfig
local function mineSweeper(iterations, config)
    local promise = promise:new()

    local result = StartGame(GameTypes.mineSweeper, iterations, config)
    promise:resolve(result)

    return Citizen.Await(promise)
end
exports("MineSweeper", mineSweeper)


RegisterCommand("minesweeper",function(src, args)

    local res=exports["bl_ui"]:MineSweeper(tonumber(args[1]), {
        grid = tonumber(args[2]), -- grid 4x4
        duration = tonumber(args[3]), -- 10sec to fail
        target = tonumber(args[4]), --target you need to remember
        previewDuration = tonumber(args[5]) --preview duration (time for red mines preview to hide)
    })
end)
