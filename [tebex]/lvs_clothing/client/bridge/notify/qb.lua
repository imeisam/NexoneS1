if Config.Notify ~= 'qb' then return end

local QBCore = exports["qb-core"]:GetCoreObject()

--[[
notify= {
    title: string
    description: string
    type: string [info | warning | error]
}
--]]

Notify = {}

Notify.Options = {
    time = 6000
}

Notify.Send = function(notify)
    QBCore.Functions.Notify(notify.description, notify.type, Notify.Options.time)
end