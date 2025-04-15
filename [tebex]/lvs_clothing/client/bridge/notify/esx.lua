if Config.Notify ~= 'esx' then return end

--[[
notify= {
    title: string
    description: string
    type: string [info | warning | error]
}
--]]

Notify = {}

Notify.Send = function(notify)
    --SetNotificationTextEntry('STRING')
    --AddTextComponentString(description)
    --DrawNotification(0, 1)

    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(notify.description)
    EndTextCommandThefeedPostTicker(0, 1)
end