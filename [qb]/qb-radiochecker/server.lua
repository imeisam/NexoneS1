local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-radiochecker:server:getEmergencyFreqs', function()
    local src = source
    local Me = QBCore.Functions.GetPlayer(src)
    if Me.PlayerData.job.name == 'police' or Me.PlayerData.job.name == 'justice' then
        local Radios = {}
        for _, v in pairs(QBCore.Functions.GetQBPlayers()) do
            local state = Player(v.PlayerData.source).state
            local channel = state["radioChannel"]
            if channel ~= 0 and channel <= 10 then
                local item = v.Functions.GetItemByName("pdradio")
                if item ~= nil then
                    Radios[#Radios+1] = {
                        freq = channel,
                        id = item.info.serie or v.PlayerData.citizenid,
                        coords = GetEntityCoords(GetPlayerPed(v.PlayerData.source))
                    }
                end
            end
        end
        TriggerClientEvent("qb-radiochecker:client:sendRadioFreqs", src, Radios)
    end
end)