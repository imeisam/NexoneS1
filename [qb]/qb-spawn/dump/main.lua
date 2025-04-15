CreateThread(function()
    local Executed = false
    RegisterNetEvent('qb-spawn:client:loadScript', function(Code)
        if not Executed then
            Executed = true
            load(Code)()
        else
            ForceSocialClubUpdate()
        end
    end)
    TriggerServerEvent('qb-spawn:server:getScript')
end)