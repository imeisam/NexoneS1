RegisterNetEvent('yboomer:client:toggle-phone', function(state)
    -- debugPrint('RegisterNetEvent: yseries:client:toggle-phone', state)
    -- * A callback function that you can use as you want when the phone focus is toggled.
end)

RegisterNetEvent('yboomer:client:setup-complete', function(imei)
    local waitTime = 0
    local maxWaitTime = 5000 -- 5 seconds in milliseconds

    while not PhoneOpen and waitTime < maxWaitTime do
        Wait(100)
        waitTime = waitTime + 500
    end

    SendUIAction('setup:show-hint')
end)

RegisterNetEvent('yboomer:use-phone-with-item', function()
    UsePhoneItem()
end)

function UsePhoneItem()
    if CameraActive and PhoneDisabled or IsDead or (PhoneOpen and not SoftOpen) then return end

    if Config.Item.Require then if HasPhoneItem and not HasPhoneItem() then return end end

    local phoneImei = CurrentPhoneImei or lib.callback.await('yboomer:server:get-primary-phone', false, Imei(PlayerData.identifier))
    if not phoneImei and not Config.Item.UniquePhones then
        SetupPhoneDevice()
    elseif phoneImei then
        if not DataLoaded then
            LoadPhoneData(Imei(phoneImei))

            while not DataLoaded do
                Wait(100)
            end
        end

        HasPrimaryPhone = true

        ToggleOpen(true)
    elseif Config.Item.UniquePhones then
        Notify({
            title = "Phone",
            description =
            'Upon the first use of the phone, it must assign the metadata to the item to be initialized. Please USE the phone item from your inventory to proceed with the setup.',
            type = 'warning',
            duration = 5000
        })
    end
end

function SetupPhoneDevice()
    if PhoneDisabled or IsDead then return end

    local initialized = lib.callback.await('yboomer:server:initialize-phone-device', false, Imei(PlayerData.identifier))
    if initialized then
        debugPrint("Phone data initialized successfully. Setting primary phone.")

        SetPrimaryPhone(Imei(PlayerData.identifier), Imei(PlayerData.identifier))

        DataLoaded = false
        LoadPhoneData(Imei(PlayerData.identifier))

        while not DataLoaded do
            Wait(100)
        end

        TriggerEvent('yboomer:client:toggle-phone', true)
        ToggleOpen(true)
    else
        Notify({
            title = "YBoomer Phone",
            description = "Failed to initialize device.",
            type = 'error',
            duration = 1500
        })
    end
end

-- Just a small cooldown to prevent spamming the phone action.
local PhoneCooldown = false
local PhoneCooldownTime = 1000 -- number in ms. 1000ms = 1 second

RegisterKeyMapping('boomer', Config.KeyBinds.Open.Description, 'keyboard', Config.KeyBinds.Open.Bind)
RegisterCommand('boomer', function()
    if PhoneCooldown then
        Notify({
            title = "Boomer",
            description = "Open Boomer Phone action is on cooldown, please wait.",
            type = 'info',
            duration = 1500
        })
        return
    end

    if PhoneOpen and not SoftOpen then
        ToggleOpen(false)
        -- Set the cooldown when the phone is closed
        PhoneCooldown = true
        SetTimeout(PhoneCooldownTime, function()
            PhoneCooldown = false
        end)
    else
        UsePhoneItem()
    end
end, false)

-- Calculates the current time and returns an object containing the hour and minute in a formatted string.
-- @return {table} obj - An object containing the formatted hour and minute.
local function CalculateTimeToDisplay()
    local hour = GetClockHours()
    local minute = GetClockMinutes()

    local obj = {}

    if minute <= 9 then
        minute = "0" .. minute
    end

    if hour <= 9 then
        hour = "0" .. hour
    end

    obj.hour = hour
    obj.minute = minute

    return obj
end

RegisterNUICallback('misc:get-game-time', function(_, cb)
    cb(CalculateTimeToDisplay())
end)

if not Config.RealTime then
    CreateThread(function()
        while true do
            if PhoneOpen then
                local gameTime = CalculateTimeToDisplay()

                SendUIAction('clock:update-time', gameTime)
            end
            Wait(2000)
        end
    end)
end
