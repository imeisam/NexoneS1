Config = Config or {}

Config.KeepInput = true -- Keep input when nui is focused (meaning you can walk around while the phone is open)

Config.MouseLook = { 1, 2, 3, 4, 5, 6 }

Config.MainControlActions = { 263, 264, 257, 140, 141, 142, 143, 177, 200, 202, 322, 245, 37, 192, 204, 211, 349, 14, 15, 16, 17, 81, 82, 24, 47, 58 }

Config.KeyBinds = {
    Open = {
        Bind = "F2",
        Description = "Open boomer phone"
    },
    Focus = {
        Bind = 19,                 -- Left alt - https://docs.fivem.net/docs/game-references/controls/#controls -- use control index
        DisplayValue = "Left ALT", -- Used in the phone app info popup
        Description = "Toggle cursor focus"
    },
    AnswerCall = {
        Bind = "RETURN", -- Enter - https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        Description = "Answer call"
    },
    CancelCall = {
        Bind = "BACK", -- Backspace - https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        Description = "Cancel call"
    },
    TakePhoto = {
        Bind = "RETURN",        -- Enter - https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        DisplayValue = "Enter", -- Used in the camera app info popup
        Description = "Take a photo"
    },
    MoveCamera = {
        -- This is not used as a keybind after version 0.99.0.
        -- Use the `Focus` keybind above to toggle camera focus instead.
        Bind = "",
        DisplayValue = "Left Alt",          -- Used in the camera app info popup
        Description = "Toggle camera focus" -- Used in the camera app info popup
    },
    CloseCamera = {
        Bind = "BACK",              -- Backspace - https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        DisplayValue = "Backspace", -- Used in the camera app info popup
        Description = "Close camera"
    },
}
