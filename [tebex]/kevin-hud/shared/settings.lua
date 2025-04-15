return {
    -- Default Hud Settings
    dynamicMinimap = true, -- if true minimap will only show when in a vehicle
    dynamicHealthBar = false, -- if true health will only show when under 100
    dynamicArmorBar = false, -- if true armor will only show when above 0
    dynamicStaminaBar = true, -- if true stamina will only show when below 100
    dynamicHungerBar = true, -- if true hunger will only show when below 100
    dynamicThirstBar = true, -- if true thirst will only show when below 100
    dynamicStressBar = true, -- if true stress will only show when above 0
    dynamicNitrousBar = false, -- if true nitrous will only show when above 0
    dynamicFuelBar = false, -- if true fuel will only show when below 50
    dynamicEngineBar = false, -- if true engine will only show when below 50
    usePercentages = false, -- if true the bars will show percentages
    isServerInfoVisible = false, -- if true server info will be visible
    isJobInfoVisible = false, -- if true job info will be visible
    isPlayerMoneyVisible = false, -- if true player money component will be visible
    isEditingPositions = true, -- if true you can move the hud elements
    minimapPosition = 'bottom-left', -- bottom-left, bottom-right, top-left, top-right
    waypointColor = '#f01a1a', -- hex color for waypoint
    pauseMenuColor = '#f01a1a', -- hex color for pause menu
    
    -- Dont touch this
    playerStatusBarsPosition = { bottom = '1.2vh', left = '0.6vw', right = 'auto', top = 'auto' },
    vehicleHudPosition = { bottom = '2.6vh', right = '5vw', left = 'auto', top = 'auto' },
    compassPosition = { bottom = '14vh', right = '1.8vh', left = 'auto', top = 'auto' },
    serverInfoPosition = { bottom = 'auto', right = '1vh', left = 'auto', top = '1vh' },
    jobPosition = { bottom = 'auto', right = '1vh', left = 'auto', top = '7.6vh' },
    bankPosition = { bottom = 'auto', right = '1vh', left = 'auto', top = '11.2vh' },
    cashPosition = { bottom = 'auto', right = '1vh', left = 'auto', top = '14.8vh' },
    notificationPosition = { bottom = 'auto', right = '1vh', left = 'auto', top = '1vh' },

    crosshair = {
        color = '#06D7A0',
        outline = true,
        outlineColor = '#ffffff',
        outlineThickness = 1,
        centerDotSize = 1,
        centerDotRadius = 1,
        centerDotOpacity = 1,
    }
}