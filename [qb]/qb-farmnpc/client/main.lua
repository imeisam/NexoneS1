local QBCore = exports['qb-core']:GetCoreObject()

local function HasAccess()
    local job = QBCore.Functions.GetPlayerData().job
    if QBCore.Shared.Jobs[job.name].category and QBCore.Shared.Jobs[job.name].category == 'food' and (job.isboss or job.ismanager) then
        return true
    end
    return false
end

CreateThread(function()
    for k,v in ipairs(Config.Shop) do
        local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
        SetBlipSprite(blip, 792)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 0.75)
        SetBlipColour(blip, 8)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Food Market')
        EndTextCommandSetBlipName(blip)
        local model = GetHashKey(v.model)
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(1)
        end
        local npc = CreatePed(4, model, v.coords.x, v.coords.y, v.coords.z -1, v.coords.w, false, true)
        SetEntityHeading(npc,  v.coords.w)
        FreezeEntityPosition(npc, true)
        SetEntityInvincible(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        TaskStartScenarioInPlace(npc, "WORLD_HUMAN_CLIPBOARD", 0, true)
        SetPedKeepTask(npc, true)
        exports['qb-target']:AddTargetEntity(npc, {
            options = {
                {
                    action = function()
                        local Menu = {}
                        for i,j in pairs(v.items) do
                            local limit = Config.Limit
                            if Config.Shop[k].items[i].limit[QBCore.Functions.GetPlayerData().job.name] then
                                limit = Config.Shop[k].items[i].limit[QBCore.Functions.GetPlayerData().job.name]
                            end
                            Menu[#Menu + 1] = {
                                header = "<img src=nui://qb-inventory/html/images/"..QBCore.Shared.Items[i].image.." width=50px> "..QBCore.Shared.Items[i].label,
                                txt = "$"..j.price.." - x"..limit,
                                params = {
                                    event = "qb-farmnpc:client:buyItem",
                                    args = {k = k, i = i}
                                }
                            }
                        end
                        Menu[#Menu + 1] = {
                            header = 'Close',
                            icon = "fa-solid fa-angle-left",
                            params = {
                                event = "qb-menu:closeMenu",
                            }
                        }
                        exports['qb-menu']:openMenu(Menu)
                    end,
                    canInteract = function()
                        return HasAccess()
                    end,
                    icon = "fas fa-shopping-basket",
                    label = 'Open Shop',
                },
            },
            distance = 1.5
        })
    end
end)

RegisterNetEvent('qb-farmnpc:client:setConfig', function(config)
    Config = config
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('qb-farmnpc:server:GetConfig', function(config)
        Config = config
    end)
end)

RegisterNetEvent('qb-farmnpc:client:buyItem', function(data)
	local img = "nui://qb-inventory/html/images/"..QBCore.Shared.Items[data.i].image
	local dialog = exports['qb-input']:ShowInput(
        {
            header = "<center><p><img src="..img.." width=100px onerror='this.onerror=null; this.remove();'></p><br>"..QBCore.Shared.Items[data.i].label,
            submitText = "Buy",
            inputs = {{type = 'number', isRequired = true, name = 'amount', text = 'Amount to buy'}}
        }
    )
	if dialog and dialog.amount then
        local amount = tonumber(dialog.amount)
        if amount and amount > 0 then
            data.amount = amount
            RequestAnimDict('amb@prop_human_atm@male@enter')
            while not HasAnimDictLoaded('amb@prop_human_atm@male@enter') do Wait(1) end
            if HasAnimDictLoaded('amb@prop_human_atm@male@enter') then
                TaskPlayAnim(PlayerPedId(), 'amb@prop_human_atm@male@enter', "enter", 1.0,-1.0, 1500, 1, 1, true, true, true)
            end
            TriggerServerEvent('qb-farmnpc:server:buyItem', data)
        end
	end
end)