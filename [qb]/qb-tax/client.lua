local QBCore = exports['qb-core']:GetCoreObject()

function gettax(money,taxamount)
    local txtamount=0
    if taxamount then
        txtamount= taxamount
    else
        txtamount= Config.tax
    end
    return (money*txtamount)/100 , money+((money*txtamount)/100)
end
exports('gettax',gettax)

function notificationtax(money,tax)
    TriggerEvent('qb-phone:client:CustomNotification',
    'Goverment',
    'You Pay '..money..' $ +'..tax..' $ '..' Tax',
    'fas fa-briefcase',
    '#2496f2',
    5000
)
end
exports('notificationtax',notificationtax)

function addtaxtogoverment(tax,memo)
    TriggerServerEvent("qb-tax:server:addtogoverment", tax,memo)
end
exports('addtaxtogoverment',addtaxtogoverment)

function getandpaytax(money,memo,taxamount)
   local tax,moneyaddtax= gettax(money,taxamount)
   notificationtax(money,tax)
   addtaxtogoverment(tax,memo)
end
exports('getandpaytax',getandpaytax)

RegisterNetEvent('qb-tax:client:getandpaytax', function(money,memo,taxamount)
    getandpaytax(money,memo,taxamount)
end)

