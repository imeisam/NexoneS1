local QBCore = exports['qb-core']:GetCoreObject()
local HasDeal = false

CreateThread(function()
    for k,v in ipairs(Config.Shop) do
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
        TaskStartScenarioInPlace(npc, "WORLD_HUMAN_GUARD_STAND", 0, true)
        SetPedKeepTask(npc, true)
        exports['qb-target']:AddTargetEntity(npc, {
            options = {
                {
                    action = function()
                        local Menu = {}
                        for i,j in pairs(v.items) do
                            Menu[#Menu + 1] = {
                                header = "<img src=nui://qb-inventory/html/images/"..QBCore.Shared.Items[i].image.." width=50px> "..QBCore.Shared.Items[i].label,
                                txt = "Cost per item: "..j.."$",
                                params = {
                                    event = "qb-illegalshop:client:buyItem",
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
                        return not HasDeal
                    end,
                    icon = "fas fa-shopping-basket",
                    label = 'Open Shop',
                },
            },
            distance = 1.5
        })
    end
end)

RegisterNetEvent('qb-illegalshop:client:buyItem', function(data)
	local img = "nui://qb-inventory/html/images/"..QBCore.Shared.Items[data.i].image
	local dialog = exports['qb-input']:ShowInput(
        {
            header = "<center><p><img src="..img.." width=100px onerror='this.onerror=null; this.remove();'></p><br>"..QBCore.Shared.Items[data.i].label.."<br>Cost per item: "..Config.Shop[data.k].items[data.i].."$",
            submitText = "Buy",
            inputs = {{type = 'number', isRequired = true, name = 'amount', text = 'Amount to buy'}}
        }
    )
	if dialog and dialog.amount then
        data.amount = dialog.amount
        QBCore.Functions.TriggerCallback('qb-illegalshop:server:HasMoney', function(Has)
            if Has then
                if HasDeal then return QBCore.Functions.Notify('You have open deal now!', 'error') end
                QBCore.Functions.Notify('Wait!')
                Wait(math.random(20000, 30000))
                PlaySound(-1, "Click_Fail", "WEB_NAVIGATION_SOUNDS_PHONE", 0, 0, 1)
                local success = exports['qb-phone']:PhoneNotification("Illegal Shop", 'Contract Location', 'fas fa-map-pin', '#b3e0f2', "NONE", 'fas fa-check-circle', 'fas fa-times-circle')
                if success then
                    HasDeal = true
                    local random = math.random(1, #Config.Shop[data.k].locations)
                    local coords = Config.Shop[data.k].locations[random]
                    SetNewWaypoint(coords.x, coords.y)
                    local notifed = false
                    CreateThread(function()
                        while HasDeal do
                            Wait(10)
                            local PedCoords = GetEntityCoords(PlayerPedId())
                            local distance = #(PedCoords - coords)
                            if distance < 3 then
                                if not notifed then
                                    notifed = true
                                    exports['qb-core']:DrawText('Deal', 'left','E')
                                end
                                if IsControlJustPressed(0, 38) then
                                    HasDeal = false
                                    exports['qb-core']:HideText()
                                    RequestAnimDict('amb@prop_human_atm@male@enter')
                                    while not HasAnimDictLoaded('amb@prop_human_atm@male@enter') do Wait(1) end
                                    if HasAnimDictLoaded('amb@prop_human_atm@male@enter') then
                                    TaskPlayAnim(PlayerPedId(), 'amb@prop_human_atm@male@enter', "enter", 1.0,-1.0, 1500, 1, 1, true, true, true) end
                                    TriggerServerEvent('qb-illegalshop:server:buyItem', data)
                                end
                            else
                                if notifed then
                                    notifed = false
                                    exports['qb-core']:HideText()
                                end
                                Wait(1500)
                            end
                        end
                    end)
                end
            else
                QBCore.Functions.Notify('You donnot have enough Cash!', 'error')
            end
        end, data)
	end
end)