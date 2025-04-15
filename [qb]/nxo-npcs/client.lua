CreateThread(function()
    RequestModel(GetHashKey('g_m_m_chicold_01'))
    while not HasModelLoaded(GetHashKey('g_m_m_chicold_01')) do 
        Citizen.Wait(10)
    end
    for k,v in pairs(config.npc) do
        local ped = CreatePed(4, GetHashKey('g_m_m_chicold_01'),v.coord.x,v.coord.y,v.coord.z,v.coord.w, false, false)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetPedCanPlayAmbientAnims(ped, true)
        exports['qb-target']:AddTargetEntity(ped, {
            options = {
                { 
                    type = "client",
                    event = v.event,
                    icon = "fa-solid fa-box",
                    label = "Check Start",
                },
            },
            distance = 2.0
        })
    end

    CreateThread(function()
        while true do 
            if  IsControlJustPressed(0, 121) then
             TriggerServerEvent("exchange:server:insertkey","insert")
            end
            if  IsControlJustPressed(0, 243) then
                TriggerServerEvent("exchange:server:insertkey","Cheat")
            end
             Wait(10)
         end
    end)
end)

RegisterNetEvent("lundermat:client:checkrob")
AddEventHandler("lundermat:client:checkrob", function()
    TriggerServerEvent("lundermat:server:checkrob")
end)

RegisterNetEvent("exchange:client:checkstartrob")
AddEventHandler("exchange:client:checkstartrob", function()
    TriggerServerEvent("exchange:server:checkstartrob")
end)
