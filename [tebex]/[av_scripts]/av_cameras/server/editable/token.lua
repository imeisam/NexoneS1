-- Add your Fivemanage or Fivemerr API token(s) here:
photoToken = "4f1b1f760da70369c785fa462a2fbd7e" -- used for photos
videoToken = "d9db0a06df2ee891c951d49df3a2d2aa" -- used for videos

lib.callback.register('av_cameras:getConfig', function(source)
    return {
      token = videoToken,
      service = Config.HostingService
    }
end)