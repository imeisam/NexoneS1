local QBCore = exports['qb-core']:GetCoreObject()

local ValidExtensions = {
    [".png"] = true,
    [".gif"] = true,
    [".jpg"] = true,
    ["jpeg"] = true
}

local ValidExtensionsText = '.png, .gif, .jpg, .jpeg'

QBCore.Functions.CreateUseableItem("documents", function(source, item)
    TriggerClientEvent('qb-printer:client:UseDocument', source, item)
end)

QBCore.Commands.Add("spawnprinter", Lang:t('command.spawn_printer'), {}, true, function(source, _)
	TriggerClientEvent('qb-printer:client:SpawnPrinter', source)
end, "admin")

RegisterNetEvent('qb-printer:server:SaveDocument', function(url,price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local pric=0
    if price  then
        pric=price
    end
    if pric>0 then
        if not Player.Functions.RemoveMoney('bank', pric, 'Print Document') then
            TriggerClientEvent('QBCore:Notify', src,"You don't have enough money", "error")
            return
        else
            exports["snipe-banking"]:AddMoneyToAccount("goverment",pric,"Pay From "..Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname.." For Print Document")
        end
    end
    local info = {}
    local extension = string.sub(url, -4)
    local validexts = ValidExtensions
    if url ~= nil then
        -- if validexts[extension] then
            info.url = url
            Player.Functions.AddItem('documents', 1, nil, info)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['documents'], "add")
        -- else
        --     TriggerClientEvent('QBCore:Notify', src, Lang:t('error.invalid_ext')..ValidExtensionsText..Lang:t('error.allowed_ext'), "error")
        -- end
    end
end)