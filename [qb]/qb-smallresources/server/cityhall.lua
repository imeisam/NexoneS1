local QBCore = exports['qb-core']:GetCoreObject()


RegisterNetEvent('qb-cityhall:server:getIdCard', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.money['bank'] >= CityHall.Prices.idcard then
        Player.Functions.AddItem('id_card', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["id_card"], "add", 1)
        Player.Functions.RemoveMoney('bank', CityHall.Prices.idcard)
    else
        TriggerClientEvent('QBCore:Notify', src, 'You Do Not Have Enough Money in bank!', 'error')
    end
end)

RegisterNetEvent('qb-cityhall:server:DriveLicense', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.money['bank'] >= CityHall.Prices.driver then
        local licenseTable = Player.PlayerData.metadata["licences"]
        if licenseTable['driver'] ~= 'revoked' then
            licenseTable['driver'] = true
            Player.Functions.SetMetaData("licences", licenseTable)
            Player.Functions.RemoveMoney('bank', CityHall.Prices.driver)
            TriggerClientEvent('QBCore:Notify', src, 'You Got Driving License!', 'success')
        else
            TriggerClientEvent('QBCore:Notify', src, 'Your Driver License Has Been Revoked!', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You Do Not Have Enough Money in bank!', 'error')
    end
end)

RegisterNetEvent('qb-cityhall:server:WeaponLicense', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.money['bank'] >= CityHall.Prices.weapon then
        local licenseTable = Player.PlayerData.metadata["licences"]
        if licenseTable['weapon'] ~= 'revoked' then
            licenseTable['weapon'] = true
            Player.Functions.SetMetaData("licences", licenseTable)
            Player.Functions.RemoveMoney('bank', CityHall.Prices.weapon)
            TriggerClientEvent('QBCore:Notify', src, 'You Got Weapon License!', 'success')
        else
            TriggerClientEvent('QBCore:Notify', src, 'Your Weapon License Has Been Revoked!', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You Do Not Have Enough Money in bank!', 'error')
    end
end)

RegisterNetEvent('qb-cityhall:server:HuntingLicense', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.money['bank'] >= CityHall.Prices.hunting then
        local licenseTable = Player.PlayerData.metadata["licences"]
        if licenseTable['hunting'] ~= 'revoked' then
            licenseTable['hunting'] = true
            Player.Functions.SetMetaData("licences", licenseTable)
            Player.Functions.RemoveMoney('bank', CityHall.Prices.hunting)
            TriggerClientEvent('QBCore:Notify', src, 'You Got Hunting License!', 'success')
        else
            TriggerClientEvent('QBCore:Notify', src, 'Your Hunting License Has Been Revoked!', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You Do Not Have Enough Money in bank!', 'error')
    end
end)