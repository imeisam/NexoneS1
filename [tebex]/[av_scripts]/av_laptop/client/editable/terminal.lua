local commands = {
    ['/help'] = function(...)
        return showHelp(...)
    end,
    ['/av'] = function(...)
        return showTebex(...)
    end,
    ['/reply'] = function(...)
        return reply(...)
    end,
    ['/fivem'] = function(...)
        return fivem(...)
    end,
    -- ['/minigame'] = function(...)
    --     return minigame(...)
    -- end,
}

function fivem(...)
    return [[
        <a onclick="window.invokeNative('openUrl', 'https://forum.cfx.re/')">Click here to visit the Fivem Forums!</a>
    ]]
end

RegisterNUICallback("terminal", function(data, cb)
    local resp = "Unknown command"
    local command = data['command']
    local args = data['args']
    if command and commands[command] then
        resp = commands[command](args)
    end
    cb(resp)
end)

function showHelp(args)
    return [[
        <p>Here are some commands you can use:</p>
        <p style="fontWeight:500;">/av: <a> Show info about this laptop script.</a></p>
        <p style="fontWeight:500;">/reply: <a>I'll return all the args you sent but not the command.</a></p>
    ]]
end

function showTebex(args)
    return [[
        <p>You can buy this laptop here:</p>
        <a>https://av-scripts.tebex.io/</a>
    ]]
end

function reply(args)
    return [[
        <p>]] .. args .. [[</p>
    ]]
end

-- function minigame(args)
--     local res = exports['av_alphabet']:start(hand, seconds, blocks)
-- if res then
--     -- do something here:
-- end