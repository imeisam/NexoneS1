local QBCore = exports['qb-core']:GetCoreObject()
local isbankingstart=false

function hasresource(name)
    return GetResourceState(name):find("start") ~= nil
end

function gettax(money)
    return (money*Config.tax)/100 , money+((money*Config.tax)/100)
end
exports('gettax',gettax)

RegisterNetEvent('qb-tax:server:addtogoverment', function(tax,memo)
    exports["snipe-banking"]:AddMoneyToAccount(Config.govermentjob, tax,memo)
end)

local blacklistcartax={
    ['medic']=true,
    ['police']=true,
    ['boat']=true,
}
function getcarcounttax(cid)
    local result = MySQL.Sync.fetchAll('SELECT * FROM player_vehicles WHERE citizenid = ?', {cid})
    local count=#result
    if result then
        for k, v in pairs(result) do
            local resultrent = MySQL.query.await('SELECT plate FROM rentvehs WHERE plate = ?', {v.plate})
                if resultrent and resultrent[1] then
                    count=count-1
                else if QBCore.Shared.Vehicles[v.vehicle] and blacklistcartax[QBCore.Shared.Vehicles[v.vehicle].shop]  then
                     count=count-1
                 end
            end
        end
    end
    print(count)
    return count
end
exports("getcarcounttax",getcarcounttax)

MySQL.ready(function()
	LoadSQL = true
end)
------------veh tax---------------
CreateThread(function()
    while not LoadSQL do
        Wait(1000)
    end
    while not hasresource("snipe-banking") do
        Wait(6000)
    end
    local res = MySQL.query.await('SELECT vehtaxdate FROM taxsettings', {})
    if res and res[1] and res[1].vehtaxdate then 
        local timeTable = os.date('*t',res[1].vehtaxdate)
        if res[1].vehtaxdate>os.time() then return print("New Tax Time: "..timeTable["year"].."/"..timeTable["month"].."/"..timeTable["day"]) end
    end
    print("******************************** [  Vehicle Tax Started  ] ********************************")
    local notax
    local resultrent
    local vehproperties
    local taxamount
    local govermentbankid=0
    local result = MySQL.query.await("SELECT * FROM player_vehicles", {})
    local goverid= MySQL.query.await("select unique_id from banking_users where identifier=?",{"goverment"})
    if goverid and goverid[1] then
        govermentbankid=goverid[1].unique_id
    end
    for k, v in pairs(result) do
        resultrent = MySQL.query.await('SELECT plate FROM rentvehs WHERE plate = ?', {v.plate})
        havetax=true
        if resultrent and resultrent[1] then
            havetax=false
        end

        if QBCore.Shared.Vehicles[v.vehicle] then
            vehproperties=QBCore.Shared.Vehicles[v.vehicle]
            if vehproperties.category=="Cycles" or vehproperties.category=="Emergency" or vehproperties.price<=20000 then
                havetax=false
            end
        end

        if havetax then
            taxamount= math.round(vehproperties.price*0.02,0)
            
           MySQL.update.await("UPDATE players SET money = JSON_SET(`money`, '$.bank', JSON_UNQUOTE(JSON_EXTRACT(`money`, '$.bank')) - ?) WHERE citizenid = ?",{ taxamount, v.citizenid})
           exports["snipe-banking"]:AddMoneyToAccount(Config.govermentjob, taxamount,"Tax For Vehicle: "..vehproperties.name.."("..v.plate..")")

           local useracc= MySQL.query.await("select unique_id from banking_users where identifier=?",{v.citizenid})
           if useracc and useracc[1] then
             MySQL.update.await("insert banking_transactions(unique_id,transaction_type,amount,memo)values(?,?,?,?)",{useracc[1].unique_id,'withdraw',taxamount,"Tax For Vehicle: "..vehproperties.name.."("..v.plate..")"})
           end
        end
    end
    MySQL.query.await('update taxsettings set vehtaxdate= ?', {os.time()+2628000})--1 month
    print("******************************** [  Vehicle Tax Completed  ] ********************************")
end)



-- CreateThread(function()
--     data = MySQL.query.await('SELECT * FROM banking_transactions WHERE id >=69799 and id<=70007', {})
--     for k, v in pairs(data) do
--         MySQL.update.await("UPDATE banking_accounts set amount=amount+? where account=?",{ v.amount, "goverment"})
--         -- MySQL.update.await("insert banking_transactions(unique_id,transaction_type,amount,memo)values(?,?,?,?)",{1013,'deposit',v.amount,v.memo})
--     end


-- end)

