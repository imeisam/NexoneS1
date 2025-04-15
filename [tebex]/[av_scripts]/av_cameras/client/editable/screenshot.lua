function getScreenshot(token)
    local sent = false
    debug("getScreenshot()")
    local p = promise.new()
    if Config.HostingService == "fivemanage" then
        debug("fivemanage...")
        sent = true
        exports['screenshot-basic']:requestScreenshotUpload('https://api.fivemanage.com/api/image?apiKey='..token, 'image', function(data)
            local resp = json.decode(data)
            local image = (resp and resp.url) or false
            p:resolve(image)
        end)
    end
    if Config.HostingService == "fivemerr" then
        debug("fivemerr...")
        sent = true
        exports['screenshot-basic']:requestScreenshotUpload('https://api.fivemerr.com/v1/media/images', 'file', {
            headers = {
                Authorization = token
            },
            encoding = 'png'
        }, function(data)
            local resp = json.decode(data)
            local image = (resp and resp.url) or false
            p:resolve(image)
        end)
    end
    if not sent then
        p:resolve(false)
    end
    debug("getScreenshot() complete...")
    local image = Citizen.Await(p)
    return image
end