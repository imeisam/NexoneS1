local QBCore = exports["qb-core"]:GetCoreObject()

QBCore.Functions.CreateCallback('nxo-shop:server:licences', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    cb(Player.PlayerData.metadata.licences)
end)


RegisterNetEvent('nxo-shop:pay', function(data,selectshopname)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if data.payType == "cash" then
        
        if xPlayer.Functions.GetMoney('cash') >= data.price then
            if  data.price>0 then
                xPlayer.Functions.RemoveMoney('cash', data.price)
            end
                for k,v in pairs(data.cartArr) do
                    local iteminfo={}
                    if weaponlist[v.itemname] then
                        local serial  = math.random(11111111, 99999999)
                        iteminfo={serie=serial, quality = 100,  clip = false,  ammo = 0}
                            exports["nxo_mdt"]:CreateWeapon(serial, { source = source }, v.itemname, QBCore.Shared.Items[v.itemname].label)
                    end
                    
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v.itemname], "add",tonumber(v.count))
                    xPlayer.Functions.AddItem(v.itemname, tonumber(v.count),nil,iteminfo,nil,true)
                    if selectshopname and selectshopname=="policearmory" then
                        TriggerEvent('qb-log:server:CreateLog', 'pdarmory', 'Police Armory', 'green', xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname ..'('..xPlayer.PlayerData.citizenid..')'..v.count..'x '..QBCore.Shared.Items[v.itemname].label,false)
                    elseif selectshopname and selectshopname=="mdarmory" then
                         TriggerEvent('qb-log:server:CreateLog', 'mdarmory', 'Medic Armory', 'green', xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname ..'('..xPlayer.PlayerData.citizenid..')'..v.count..'x '..QBCore.Shared.Items[v.itemname].label,false)
                    elseif selectshopname and selectshopname=="dojarmory" then
                        TriggerEvent('qb-log:server:CreateLog', 'dojarmory', 'Doj Armory', 'green', xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname ..'('..xPlayer.PlayerData.citizenid..')'..v.count..'x '..QBCore.Shared.Items[v.itemname].label,false)
                    else
                        TriggerEvent('qb-log:server:CreateLog', 'shops', 'Shop Item Bought', 'green', xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname ..'('..xPlayer.PlayerData.citizenid..')'..v.count..'x '..QBCore.Shared.Items[v.itemname].label,false)
                    end
                end
                
                TriggerClientEvent('nxo-shop:client:resultpay', src,true,"")
            else
                -- TriggerClientEvent('QBCore:Notify', src, "You don't have enough cash", 'error', 4000)
                TriggerClientEvent('nxo-shop:client:resultpay', src,false,"You don't have enough cash")
            end
        else      
            local tax,moneywithtax=exports['qb-tax']:gettax(data.price)  
           
            if xPlayer.PlayerData.money['bank'] >= moneywithtax then
                if  data.price>0 then
                    xPlayer.Functions.RemoveMoney('bank', moneywithtax,'buy from 24/7 with TAX')
                    TriggerClientEvent('qb-tax:client:getandpaytax', src, data.price,'buy from 24/7')
                end
                for k,v in pairs(data.cartArr) do
                    local iteminfo={}
                    if weaponlist[v.itemname] then
                        local serial = math.random(11111111, 99999999)
                        iteminfo={serie=serial, quality = 100,  clip = false,  ammo = 0}
                            exports["nxo_mdt"]:CreateWeapon(serial, { source = source }, v.itemname, QBCore.Shared.Items[v.itemname].label)
                    end
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v.itemname], "add",tonumber(v.count))
                    xPlayer.Functions.AddItem(v.itemname, tonumber(v.count),nil,iteminfo,nil,true)
                    if selectshopname and selectshopname=="policearmory" then
                        TriggerEvent('qb-log:server:CreateLog', 'pdarmory', 'Police Armory', 'green', xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname ..'('..xPlayer.PlayerData.citizenid..')'..v.count..'x '..QBCore.Shared.Items[v.itemname].label,false)
                    elseif selectshopname and selectshopname=="mdarmory" then
                         TriggerEvent('qb-log:server:CreateLog', 'mdarmory', 'Medic Armory', 'green', xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname ..'('..xPlayer.PlayerData.citizenid..')'..v.count..'x '..QBCore.Shared.Items[v.itemname].label,false)
                    elseif selectshopname and selectshopname=="dojarmory" then
                            TriggerEvent('qb-log:server:CreateLog', 'dojarmory', 'Doj Armory', 'green', xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname ..'('..xPlayer.PlayerData.citizenid..')'..v.count..'x '..QBCore.Shared.Items[v.itemname].label,false)
                    else
                        TriggerEvent('qb-log:server:CreateLog', 'shops', 'Shop Item Bought', 'green', xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname ..'('..xPlayer.PlayerData.citizenid..')'..v.count..'x '..QBCore.Shared.Items[v.itemname].label,false)
                    end
                end
                TriggerClientEvent('nxo-shop:client:resultpay', src,true,"")
            else
                -- TriggerClientEvent('QBCore:Notify', src, "You don't have enought bank", 'error', 4000)
                TriggerClientEvent('nxo-shop:client:resultpay', src,false,"You don't have enought bank")
            end
        end

end)