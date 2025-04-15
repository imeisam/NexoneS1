if Config.Notify ~= 'ox_lib' then return end

--[[
notify= {
    title: string
    description: string
    type: string [info | warning | error]
}
--]]

Notify = {}

Notify.Options = {
    position = "top-right"
}

Notify.Send = function(notify)
    if notify.type == 'info' then notify.type = 'inform' end

    lib.notify({
        title = notify.title,
        description = notify.description,
        type = notify.type,
        position = Notify.Options.position
    })
end
