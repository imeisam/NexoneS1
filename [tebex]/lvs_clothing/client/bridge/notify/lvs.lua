if Config.Notify ~= 'lvs_lib' then return end

--[[
notify= {
    title: string
    description: string
    type: string [info | warning | error]
}
--]]

Notify = {}

Notify.Options = { -- can by set as default in lvs_lib
    time = 6000,
    position = 'top-left'
}

Notify.Send = function(notify)
    exports.lvs_lib:notify(notify.description, notify.type, Notify.Options)
end