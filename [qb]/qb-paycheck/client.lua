local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()

    exports['qb-interact']:AddInteraction({
        coords =vector3(241.56, 225.94, 106.49),
        distance = 4.0,
        interactDst = 1.2, 
        name = 'paycheck_interaction',
        id = 'paycheck_interaction',
        options = {
            {
                label ="Paycheck",
                event="qb-paycheck:client:menu"
            },
            {
                label ="Open Bank",
                event="qb-paycheck:openbank"
            },
            
        }
    })
    exports['qb-interact']:AddInteraction({
        coords =vector3(-1307.79, -820.95, 16.97),
        distance = 4.0,
        interactDst = 1.2, 
        name = 'paycheck_interaction',
        id = 'paycheck_interaction',
        options = {
            {
                label ="Paycheck",
                event="qb-paycheck:client:menu"
            },
            {
                label ="Open Bank",
                event="qb-paycheck:openbank"
            },
            
        }
    })
end)
RegisterNetEvent('qb-paycheck:client:menu', function()
    local amount=QBCore.Functions.GetPlayerData().money['paycheck'] 
    exports['qb-menu']:openMenu({
        {
            header ="Paycheck Menu",
            isMenuHeader = true,
            icon = "",
        },
        {
            header ="Take a Paycheck",
            txt = "Amount: ".. amount,
            icon = "fas fa-usd",
            params = {
                event = "qb-paycheck:client:takepaycheck",
            }
        },
        {
            header = "Close",
            txt = "",
            icon = "fas fa-times-circle",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
    })
end)


RegisterNetEvent('qb-paycheck:client:takepaycheck', function()
    local amount=QBCore.Functions.GetPlayerData().money['paycheck'] 
    if amount<=0 then
        TriggerEvent("QBCore:Notify", "You Are Not Have a Paycheck...", "error")
        return 
    end
    TriggerServerEvent("qb-paycheck:server:takepaycheck",amount)
end)