local QBCore = exports['qb-core']:GetCoreObject()


function CreateTradePed(pedConfig)
    -- local model = GetHashKey(pedConfig.model)

    -- RequestModel(model)
    -- while not HasModelLoaded(model) do
    --     Wait(1)
    -- end

    -- local ped = CreatePed(4, model, pedConfig.coords.x, pedConfig.coords.y, pedConfig.coords.z - 1.0, pedConfig.coords.w, false, true)
    -- FreezeEntityPosition(ped, true)
    -- SetEntityInvincible(ped, true)
    -- SetBlockingOfNonTemporaryEvents(ped, true)

    -- exports['qb-target']:AddTargetEntity(ped, {
    --     options = {
    --         {
    --             type = "client",
    --             event = "nyx-exchange:openMenu",
    --             icon = "fas fa-exchange-alt",
    --             label = "Open Trade Menu"
    --         }
    --     },
    --     distance = 2.5
    -- })
    exports['qb-interact']:AddInteraction({
        coords =vector3(425.05194091797, -1897.5450439453, 26.461709976196),
        distance = 5.5,
        interactDst = 1.0,
        options = {
            {
                label = 'Open Trade Menu',
                action = function(entity, coords, args)
                    TriggerEvent("nyx-exchange:openMenu")
                end,

                canInteract = function(entity, coords, args)
                    return true
                end,
            },
        }
    })
end

CreateThread(function()
    for _, pedConfig in ipairs(Config.Peds) do
        CreateTradePed(pedConfig)
    end
end)

function OpenTradeMenu()
    local tradeOptions = {}

    table.insert(tradeOptions, {
        header = "Trade Menu",
        isMenuHeader = true 
    })

    for _, trade in ipairs(Config.TradeItems) do
        table.insert(tradeOptions, {
            header = "Trade " .. trade.item,
            txt = "Get " .. trade.reward,
            params = {
                event = "nyx-exchange:openTradeInput",
                args = trade
            }
        })
    end

    exports['qb-menu']:openMenu(tradeOptions)
end

RegisterNetEvent('nyx-exchange:openTradeInput', function(trade)
    local dialog = exports['qb-input']:ShowInput({
        header = "Enter quantity to trade",
        submitText = "Trade",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'quantity',
                text = 'Quantity'
            }
        }
    })

    if dialog then
        local quantity = tonumber(dialog.quantity)
        if quantity and quantity > 0 then
            TriggerServerEvent('nyx-exchange:processTrade', trade, quantity)
        end
    end
end)

RegisterNetEvent('nyx-exchange:openMenu', function()
    OpenTradeMenu()
end)

-- RegisterCommand('trade', function()
--     OpenTradeMenu()
-- end, false)