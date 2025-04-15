config = require 'shared.config'
function loadMap(minimapPosition)
    local minimapData = config.minimapPosition[minimapPosition]
    local defaultAspectRatio = 1920 / 1080
    local resolutionX, resolutionY = GetActiveScreenResolution()
    local aspectRatio = resolutionX / resolutionY
    local minimapOffset = 0
    if aspectRatio > defaultAspectRatio then
        minimapOffset = ((defaultAspectRatio - aspectRatio) / 3.6) - 0.008
    end

    -- The lines commented below are for the square map that doesnt have the blurred edges
    -- PS. if youre using the mask found in ps/qbx hud you would need to adjust the minimap positions
    
    -- lib.requestStreamedTextureDict('squaremap')
    -- AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "squaremap", "radarmasksm")
    -- AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "squaremap", "radarmasksm")
    Wait(100)
    SetMinimapComponentPosition('minimap', minimapData.alignX, minimapData.alignY, minimapData.minimap.posX + minimapOffset, minimapData.minimap.posY, minimapData.minimap.sizeX, minimapData.minimap.sizeY)
    SetMinimapComponentPosition('minimap_mask', minimapData.alignX, minimapData.alignY, minimapData.minimapMask.posX + minimapOffset, minimapData.minimapMask.posY, minimapData.minimapMask.sizeX, minimapData.minimapMask.sizeY)
    SetMinimapComponentPosition('minimap_blur', minimapData.alignX, minimapData.alignY, minimapData.minimapBlur.posX + minimapOffset, minimapData.minimapBlur.posY, minimapData.minimapBlur.sizeX, minimapData.minimapBlur.sizeY)
    SetBlipAlpha(GetNorthRadarBlip(), 0)
    SetMinimapClipType(0)
    SetBigmapActive(true, false)
    Wait(50)
    SetBigmapActive(false, false)
end

CreateThread(function()
    while LocalPlayer.state.isLoggedIn do
        if cache.vehicle then
            SetRadarZoom(1150)
        else
            SetRadarZoom(1000)
        end

        Wait(500)
    end
end)