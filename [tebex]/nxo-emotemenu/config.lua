-- Play Emote Export: exports['nxo-emotemenu']:playEmote('emotename')
-- Cancel Emote Export: exports['nxo-emotemenu']:playEmote('c')
-- Open Menu Event (For radial menu etc): TriggerEvent('emotes:openMenu')

Config = {
    Debug = false, -- If you want to see the debug prints, set this to true

    -- If you want to change the key, go to https://docs.fivem.net/docs/game-references/controls/
    OpenKey = 'F6', -- Key to open the menu
    Language = 'en', -- en, tr
    MultipleAnim = true, -- If you want to play multiple animations at the same time without cancelling, set this to true
    AnimOnVehicle = true, -- If you want to disable emotes on vehicles, set this to false

    WalkInMenu = true, -- If you want to enable walk in the menu, set this to true

    -- If you want to use custom emotes (AnimationList.json), set this to true ( YOU NEED TO BUY BUNDLE FOR THIS, IF YOU DON'T HAVE BUNDLE, SET THIS TO FALSE)
    CustomEmotes = true, 
    AfterCooldown = 250, -- (Milliseconds) Sets how long after the next animation is available (You can disable with setting 0)

    SpawnEvents = { -- this is for persistent walk and expressions
        'QBCore:Client:OnPlayerLoaded',
        'BSCore:Client:OnPlayerLoaded',
        'esx:playerLoaded',
        'hospital:client:Revive',
        'playerSpawned'
    },

    -- This values only applying on first time login.
    DefaultMenuValues = {
        menuType = 'default', -- default, medium, minimal
        streamer_mode = false, -- Hides erotic animations from the menu and category.
        show_gif = true, -- Shows gifs of animations (for those with performance issues)
    },
    
    PersistentExpressions = true, -- If you want to keep the expressions active when u relog, set this to true
    PersistentWalkStyle = true, -- If you want to keep the walk styles active when u relog, set this to true

    NoCollisionProps = true, -- If you want to disable collision for props, set this to true
    ERPEmotes = true, -- If you want to disable ALL Erotic Animations, set this to false (Don't forget to remove from categories too!)

    -- You can find the list of keys on this website https://docs.fivem.net/docs/game-references/controls/
    -- (Shared Animation Binds)
    AcceptBind = 246, -- Key to accept the emote (Currently: Y) 
    RefuseBind = 244, -- Key to refuse the emote (Currently: M)

    Ragdoll = {
        enabled = false,
        keybind = 'U', -- Get the button string from here https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard
        ragdollAsToggle = true, -- If you want to use ragdoll as toggle, set this to true
    },

    DisableKeys = { -- If you want to disable some keys while open menu, you can add them here
        1, 2, 3, 4, 5, 6, 7, 8, 9, 24, 25, 177, 199, 200, 202, 322
    },

    Crouch = {
        enabled = false,
        keybindEnabled = false, -- If true, crouching will use keybinds otherwise you need to use comand.
        keybind = 'LCONTROL', -- The default crouch keybind, get the button string here: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        crouchOverride = false, -- If true, you won't enter stealth mode even if the crouch key and the "duck" key are the same.
        cooldown = 1000, -- Cooldown for crouching in milliseconds
    },

    Crawl = {
        enabled = false, -- If true, crawling will be enabled, otherwise you need to use comand.
        keybindEnabled = true, -- If true, crawling will use keybinds.
        keybind = 'RCONTROL', -- The default crawl keybind, get the button string here: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
    },

    Handsup = {
        enabled = false,
        command = 'handsup', -- The default handsup command
        keybind = 'X', -- The default handsup keybind, get the button string here: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        controls = { 24, 25, 47, 58, 59, 63, 64, 75, 140, 141, 142, 257, 263, 264 } -- 71, 72, 143
    },

    Pointing = {
        enabled = false,
        command = 'point', -- The default point command
        keybind = 'B', -- The default point keybind, get the button string here: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
    },
  
    AnimPos = {
        EnableAnimPos = true, -- If you want to disable animation position completly, set this to false

        -- When you set this to true, if the character is on emote, it switches to an animpos that scrolls the character not with the clone pad.         
        -- If false, or if the character is not currently on emote, it switches to an animpos with clone pad.
        EnableNormalAnimPos = true, 

        -- if you want to disable alpha, set it false. 
        -- If you want to enable alpha, set the alpha value
        -- 255 is max alpha, 0 is min alpha, 75 is default alpha
        EnableNormalAnimPosAlpha = 75, -- Alpha value when you are on normal animpos


        MaxDistance = 25.0, -- How far they can move away from the starting distance of the anim pos.
        MaxZDistance = 2.0, -- How far they can move up and down Z axis of anim pos.

        FreeModeMaxDistance = 8.0, -- How far they can move away from the starting distance of the anim pos in free mode.
        TeleportBackOnCancel = false, -- If you want to teleport back to the starting position when the emote is canceled ON ANIMATION POSITION, set this to true

        up = 241, -- UP (Currently: Scroll wheel up)
        down = 242, -- DOWN (Currently: Scroll wheel down)

        left = 174, -- LEFT (Currently: ARROW LEFT)
        right = 175, -- RIGHT (Currently: ARROW RIGHT)

        forward = 172, -- FORWARD (Currently: ARROW UP)
        backward = 173, -- BACKWARD (Currently: ARROW DOWN)

        rotateLeft = 52, -- Rotate Left (Currently: Q)
        rotateRight = 51, -- Rotate tRight (Currently: E)

        followMouse = 47, -- Freeze Mouse Follow (Currently: G)
        done = 191, -- Done (Currently: ENTER)
        cancel = 73, -- Done (Currently: ENTER)

        KeyInfos = {
           {label = 'Right', key = 175},
           {label = 'Left', key = 174},
           {label = 'Backward', key = 173},
           {label = 'Forward', key = 172},
           {label = 'Rotate Right', key = 51},
           {label = 'Rotate Left', key = 52},
           {label = 'Up / Down', key = 348},
           {label = 'Enable/Disable Mouse Follow', key = 47},
           {label = 'Cancel', key = 73},
           {label = 'Done', key = 191},
        }
    },
    

    Categories = {
        {
            id = 'all',
            label = 'All',
            icon = 'fas fa-house',
        },
        {
            id = 'favorites',
            label = 'Favorites',
            icon = 'fas fa-star',
        },
        {
            id = 'sequences',
            label = 'Sequences',
            icon = 'fas fa-stopwatch',
        },
        {
            id = 'emotes',
            label = 'General',
            icon = 'fas fa-male',
        },
        {
            id = 'dances',
            label = 'Dances',
            icon = 'fas fa-running',
        },
        {
            id = 'expressions',
            label = 'Expressions',
            icon = 'fas fa-laugh-beam',
        },
        {
            id = 'walks',
            label = 'Walks',
            icon = 'fas fa-running',
        },
        {
            id = 'custom',
            label = 'Custom Emotes',
            icon = 'fas fa-male',
        },
        {
            id = 'erp',
            label = 'Erotic Animations',
            icon = 'fas fa-venus-mars',
        },
        {
            id = 'animals',
            label = 'Animal Emotes',
            icon = 'fa-solid fa-dog',
        },
        {
            id = 'propemotes',
            label = 'Prop Emotes',
            icon = 'fa-solid fa-hands',
        },
        {
            id = 'shared',
            label = 'Shared Emotes',
            icon = 'fa-solid fa-user-group',
        },
    },
}

Notify = function(msg, type)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, true)
    
    -- print('notify', msg)
end

Lang = function(msg)
    return Locales[Config.Language][msg] or 'Translation not found'
end



CreateThread(function()
    RegisterNetEvent('emotes:openMenu', function()
        openMenu()
    end)
    
    RegisterCommand('emotemenu', function()
        openMenu()
    end)
    RegisterKeyMapping('emotemenu', 'Open Emotes Menu', 'keyboard', Config.OpenKey)
    
    RegisterCommand('emotecancel', function()
        onEmoteCancel()
    end)

    RegisterKeyMapping('emotecancel', 'Emote Cancel', 'keyboard', 'X')

    -- Animation commands
    local function setWalk(walkStyle)
        for _, animation in pairs(Config.AllAnimations) do
            if (animation.id == walkStyle or animation.value == walkStyle) and animation.category == 'walks' then
                return onWalk(animation)
            end
        end
    end

    RegisterNetEvent('nxo-emotemenu:client:setWalk', setWalk)
    RegisterCommand('walk', function(_, args)
        local emote = args[1]
        if not emote then return end
        local emote = emote:lower()
    
        if emote == 'c' or emote == 'cancel' then
            return onWalkCancel()
        end
    
        setWalk(emote)
    end)

    TriggerEvent('chat:addSuggestion', '/walk', 'Play a walk.', {
        { name = "walk", help = "Walk name" }
    })

    local function setExpression(expression)
        for _, animation in pairs(Config.AllAnimations) do
            if animation.id == expression and animation.category == 'expressions' then
                return onExpression(animation)
            end
        end
    end
    
    RegisterCommand('expression', function(_, args)
        local emote = args[1]
        if not emote then return end
        local emote = emote:lower()
    
        if emote == 'c' or emote == 'cancel' then
            return onExpressionCancel()
        end
    
        setExpression(emote)
    end)

    RegisterNetEvent('nxo-emotemenu:client:setExpression', setExpression)

    TriggerEvent('chat:addSuggestion', '/expression', 'Play an expression.', {
        { name = "expression", help = "Expression name" }
    })

    ------------------------------------------------------

    local function playEmote(emote)
        if emote then
            local emote = emote:lower()
        
            if emote == 'c' or emote == 'cancel' then
                return onEmoteCancel()
            end
        
            for _, animation in pairs(Config.AllAnimations) do
                if animation.id == emote and animation.category ~= 'walks' and animation.category ~= 'expressions' then
                return onAnimTriggered(animation)
                end
            end
        end
        print('Animation not found: ' .. emote)
        return false
    end
    
    RegisterCommand('e', function(_, args)
        return playEmote(args[1])
    end)

    TriggerEvent('chat:addSuggestion', '/e', 'Play an emote.', {
        { name = "emote", help = "Emote name" }
    })

    exports('playEmote', function(emote)
        return playEmote(emote)
    end)

    ------------------------------------------------------

    local function playSequence(sequenceId)
        sequenceId = tonumber(sequenceId)
        for _, sequence in pairs(sequences) do
            if sequence.id == sequenceId then
               return onSequence(sequence)
            end
        end
    
        print('Sequence not found: ' .. emote)
        return false
    end
    
    RegisterCommand('sequence', function(_, args)
        return playSequence(args[1])
    end)

    TriggerEvent('chat:addSuggestion', '/sequence', 'Play sequence with id.', {
        { name = "id", help = "Sequence ID" }
    })

    exports('playSequence', function(emote)
        return playSequence(emote)
    end)

    ------------------------------------------------------

    local function animPos(emote)
        if isEmotePlaying() then
            return createClonePed()
        end
        if not emote then return end
        local emote = emote:lower()
        for _, animation in pairs(Config.AllAnimations) do
            if animation.id == emote and animation.category ~= 'walks' and animation.category ~= 'expressions' then
               return createClonePed(animation)
            end
        end
    
        print('Animation not found: ' .. emote)
        return false
    end

    RegisterCommand('animpos', function(_, args)
        return animPos(args[1])
    end)

    exports('animpos', function(emote)
        return animPos(emote)
    end)

    -- You can add your exports etc here and prevent them from using animpos in certain situations.
    function canUseAnimPos(anim)
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped, false) then
            return false
        end

        if IsPedSwimmingUnderWater(ped) or IsPedFalling(ped) or IsPedInMeleeCombat(ped) or IsPedShooting(ped) or IsPedGettingUp(ped) then
            return false
        end

        -- you can add your dead check here
        
        return true
    end

    -- You can add your exports etc here and prevent them from using emotes in certain situations.
    function canPlayEmote(anim)
        local ped = PlayerPedId()
        if IsPedSwimming(ped) or IsPedSwimmingUnderWater(ped) or IsPedFalling(ped) or IsPedInMeleeCombat(ped) or IsPedShooting(ped) or IsPedGettingUp(ped) then
            return false
        end

        -- you can add your dead check here
        
        return true
    end

    function isEmotePlaying()
        return playingEmote
    end
end)


-- dpemotes & rpemotes support
RegisterNetEvent('animations:client:EmoteCommandStart', function(args)
    local emote = args[1] -- Assuming the emote is passed as the first argument
    if not emote then return end
    return exports['nxo-emotemenu']:playEmote(emote)
end)

-- if you want to disable completely the idle animation, 
-- remove nxo-emotemenu/stream/[Custom Emotes]/move_m@generic_idles@std

RegisterCommand('idlecam', function()
    local ped = PlayerPedId()
    local idleCamDisabled = GetResourceKvpString("idleCam") == "off"
    if idleCamDisabled then
        DisableIdleCamera(false)
        SetPedCanPlayAmbientAnims(ped, true)
        SetResourceKvp("idleCam", "on")
        Notify('Idle cam is enabled!')
    else
        DisableIdleCamera(true)
        SetPedCanPlayAmbientAnims(ped, false)
        SetResourceKvp("idleCam", "off")
        Notify('Idle cam is disabled!')
    end
end)

Citizen.CreateThread(function()
    TriggerEvent("chat:addSuggestion", "/idlecam", "Enable/disable the idle cam")
    local idleCamDisabled = GetResourceKvpString("idleCam") == "off"
    DisableIdleCamera(idleCamDisabled)
end)

CreateThread(function()
    local shiftPressed = false
    RegisterKeyMapping('+emote_shortcuts', 'Emote Shortcut Bind', 'keyboard', 'LSHIFT')
    RegisterCommand('+emote_shortcuts', function()
        shiftPressed = true
    end)
    RegisterCommand('-emote_shortcuts', function()
        shiftPressed = false
    end)

    for i = 1, 7 do
        RegisterCommand('emote_shortcuts_' .. i, function(source, args)
            if not shiftPressed then
                return print('Shift is not pressed', i)
            end

            local shortcut = shortcuts[i]
            if shortcut and next(shortcut) and shortcut.id then
                for _, animation in pairs(Config.AllAnimations) do
                    if animation.id == shortcuts[i].id then
                        return onAnimTriggered(animation)
                    end
                end
            end
        end)

        RegisterKeyMapping('emote_shortcuts_' .. i, 'Emote Shortcut ' .. i, 'keyboard',  'NUMPAD'..i)
    end
end)


-- With this event you can do what to do when the emote is canceled.
-- RegisterNetEvent('nxo-emotemenu:client:onEmoteCancel', function(lastEmote)
--     print(lastEmote)
-- end)

-- With this event you can do what to do when the expression is changed.
-- RegisterNetEvent('nxo-emotemenu:client:onExpressionSet', function(expression)
--     print(expression)
-- end)

-- With this event you can do what to do when the walk style is changed.
-- RegisterNetEvent('nxo-emotemenu:client:onWalkSet', function(walkStyle)
--     print(walkStyle)
-- end)

-- With this event you can do what to do when the emote is triggered.
-- RegisterNetEvent('nxo-emotemenu:client:onEmoteTriggered', function(emote)
--     print(emote)
-- end)

-- You can check the menu is open with this export
exports('isMenuOpened', function()
    return menuState
end)


-- It's for disabling weapon wheel while in menu.
CreateThread(function()
    while true do 
        if menuState then
            BlockWeaponWheelThisFrame()
            DisableControlAction(0, 37, true)
            DisableControlAction(0, 199, true)
        else
            Wait(500)
        end
        Wait(1)
    end
end)

-- You can get the current emote with this export
exports('getCurrentEmote', function()
    return playingEmote
end)

local ragdoll = Config['Ragdoll']
if ragdoll.enabled then
    RegisterCommand('+ragdoll', function(source, args, raw) Ragdoll() end)
    RegisterCommand('-ragdoll', function(source, args, raw) StopRagdoll() end)
    RegisterKeyMapping("+ragdoll", "Ragdoll your character", "keyboard", ragdoll.keybind)

    local stop = true
    function Ragdoll()
        if IsPedInAnyVehicle(PlayerPedId(), false) then return end
        if ragdoll.ragdollAsToggle then
            stop = not stop
        else
            stop = false
        end

        while not stop do
            local ped = PlayerPedId()
            if IsPedOnFoot(ped) then
                SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
            end
            Wait(10)
        end
    end

    function StopRagdoll()
        if ragdoll.ragdollAsToggle then return end
        stop = true
    end
end


exports('IsPlayerCrouched', IsPlayerCrouched)
exports('IsPlayerProne', IsPlayerProne)
exports('IsPlayerCrawling', IsPlayerCrawling)

local crouch = Config['Crouch']
if crouch.enabled then
    if crouch.keybindEnabled then
        RegisterKeyMapping('+crouch', "Crouch", "keyboard", crouch.keybind)
        RegisterCommand('+crouch', function() CrouchKeyPressed() end, false)
        RegisterCommand('-crouch', function() end, false) -- This needs to be here to prevent errors/warnings
    end
    RegisterCommand('crouch', function()
        if isCrouched then
            isCrouched = false
            return
        end

        AttemptCrouch(PlayerPedId())
    end, false)
    TriggerEvent('chat:addSuggestion', '/crouch', 'Crouch')
end

local crawl = Config['Crawl']

if crawl.enabled then
    if crawl.keybindEnabled then
        RegisterKeyMapping('crawl', "Crawl", "keyboard", Config['Crawl'].keybind)
    end
    RegisterCommand('crawl', function() CrawlKeyPressed() end, false)
end

local handsup = Config['Handsup']
if handsup.enabled then
    RegisterKeyMapping(handsup.command, 'Hands Up', 'keyboard',  handsup.keybind)

    local handsUp = false
    local controls = handsup.controls
    RegisterCommand(handsup.command, function()
        local ped = PlayerPedId()
        local animDict = "missminuteman_1ig_2"
        local animName = 'handsup_base'
        if not HasAnimDictLoaded(animDict) then
            RequestAnimDict(animDict)
            while not HasAnimDictLoaded(animDict) do
                Wait(10)
            end
        end

        if IsPedReloading(ped) or IsPedShooting(ped) then return end
        if LocalPlayer.state.isDead or LocalPlayer.state.isLastStand then return end
        handsUp = not handsUp
        if handsUp then
            TaskPlayAnim(ped, animDict, animName, 8.0, 8.0, -1, 50, 0, false, false, false)
        else
            ClearPedTasks(ped)
        end

        while handsUp do
            Wait(1)
            if not IsEntityPlayingAnim(ped, animDict, animName, 3) or LocalPlayer.state.isDead or LocalPlayer.state.isLastStand then
                handsUp = false
                ClearPedTasks(ped)
            end

            for _, control in pairs(controls) do
                DisableControlAction(0, control, true)
            end
        end
        for _, control in pairs(controls) do
            EnableControlAction(0, control, true)
        end

    end, false)
end

local pointing = Config['Pointing']
if pointing.enabled then
    RegisterKeyMapping(pointing.command, 'Toggles Point', 'keyboard', pointing.keybind)
    local mp_pointing = false

    local function startPointing()
        local ped = PlayerPedId()
        RequestAnimDict("anim@mp_point")
        while not HasAnimDictLoaded("anim@mp_point") do
            Wait(10)
        end
        SetPedCurrentWeaponVisible(ped, 0, true, true, true)
        SetPedConfigFlag(ped, 36, 1)
        TaskMoveNetworkByName(ped, 'task_mp_pointing', 0.5, false, 'anim@mp_point', 24)
        RemoveAnimDict("anim@mp_point")
    end

    local function stopPointing()
        local ped = PlayerPedId()
        if not IsPedInjured(ped) then
            RequestTaskMoveNetworkStateTransition(ped, 'Stop')
            ClearPedSecondaryTask(ped)
            if not IsPedInAnyVehicle(ped, 1) then
                SetPedCurrentWeaponVisible(ped, 1, true, true, true)
            end
            SetPedConfigFlag(ped, 36, false)
        end
    end

    RegisterCommand('point', function()
        local ped = PlayerPedId()
        if not IsPedInAnyVehicle(ped, false) then
            mp_pointing = not mp_pointing
            if mp_pointing then
                startPointing()
            else
                stopPointing()
            end
            while mp_pointing do
                local camPitch = GetGameplayCamRelativePitch()
                local camHeading = GetGameplayCamRelativeHeading()
                local cosCamHeading = Cos(camHeading)
                local sinCamHeading = Sin(camHeading)
                camPitch = math.max(-70.0, math.min(42.0, camPitch))
                camPitch = (camPitch + 70.0) / 112.0
                camHeading = math.max(-180.0, math.min(180.0, camHeading))
                camHeading = (camHeading + 180.0) / 360.0

                local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                local ray = StartShapeTestCapsule(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7)
                local _, blocked = GetRaycastResult(ray)
                SetTaskMoveNetworkSignalFloat(ped, "Pitch", camPitch)
                SetTaskMoveNetworkSignalFloat(ped, "Heading", camHeading * -1.0 + 1.0)
                SetTaskMoveNetworkSignalBool(ped, "isBlocked", blocked)
                SetTaskMoveNetworkSignalBool(ped, "isFirstPerson", GetCamViewModeForContext(GetCamActiveViewModeContext()) == 4)
                Wait(0)
            end
        end
    end, false)
end