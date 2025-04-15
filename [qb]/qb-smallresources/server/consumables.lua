QBCore = exports['qb-core']:GetCoreObject()

----------- / Starter

QBCore.Functions.CreateUseableItem("starterpack", function(source, item)
	local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('starterpack', 1, item.slot)
    Player.Functions.AddItem('lockpick', 3)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["lockpick"], "add")
    Player.Functions.AddItem('phone', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["phone"], "add")
    Player.Functions.AddItem('sandwich', 5)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["sandwich"], "add")
    Player.Functions.AddItem('water', 5)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["water"], "add")
end)

----------- / store 24/7
QBCore.Functions.CreateUseableItem("hotdog", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, 35, nil, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'hotdog')
end)

QBCore.Functions.CreateUseableItem("foodcontainer", function(source, item)
    TriggerClientEvent("consumables:client:foodcontainer", source, item.info.id)
end)

QBCore.Functions.CreateUseableItem("water", function(source, item)
    TriggerClientEvent("consumables:client:Drink", source, item.name, item.slot, nil, 35, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'water')
end)

QBCore.Functions.CreateUseableItem("energy_drink", function(source, item)
    TriggerClientEvent("consumables:client:Drink", source, item.name, item.slot, nil, 45, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'soda')
end)

QBCore.Functions.CreateUseableItem("beer_pib", function(source, item)
    TriggerClientEvent("consumables:client:Drink", source, item.name, item.slot, nil, 40, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'beer')
end)

QBCore.Functions.CreateUseableItem("beer_log", function(source, item)
    TriggerClientEvent("consumables:client:DrinkAlcohol", source, item.name, item.slot, nil, 25, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'beer')
end)

QBCore.Functions.CreateUseableItem("beer_am", function(source, item)
    TriggerClientEvent("consumables:client:DrinkAlcohol", source, item.name, item.slot, nil, 25, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'beer')
end)

QBCore.Functions.CreateUseableItem("beer_bar", function(source, item)
    TriggerClientEvent("consumables:client:DrinkAlcohol", source, item.name, item.slot, nil, 25, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'beer')
end)

QBCore.Functions.CreateUseableItem("beer_stz", function(source, item)
    TriggerClientEvent("consumables:client:DrinkAlcohol", source, item.name, item.slot, nil, 25, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'beer')
end)

QBCore.Functions.CreateUseableItem("liquor_vodka", function(source, item)
    TriggerClientEvent("consumables:client:DrinkAlcohol", source, item.name, item.slot, nil, 30, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'whiskey')
end)

QBCore.Functions.CreateUseableItem("liquor_whiskey", function(source, item)
    TriggerClientEvent("consumables:client:DrinkAlcohol", source, item.name, item.slot, nil, 30, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'whiskey')
end)

QBCore.Functions.CreateUseableItem("liquor_rum", function(source, item)
    TriggerClientEvent("consumables:client:DrinkAlcohol", source, item.name, item.slot, nil, 30, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'whiskey')
end)

QBCore.Functions.CreateUseableItem("liquor_tequila", function(source, item)
    TriggerClientEvent("consumables:client:DrinkAlcohol", source, item.name, item.slot, nil, 30, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'whiskey')
end)
----------- / Snrbuns
QBCore.Functions.CreateUseableItem("zatburger", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, 35, nil, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'burger')
end)
QBCore.Functions.CreateUseableItem("zatfries", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, 15, nil, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'taco')
end)

QBCore.Functions.CreateUseableItem("zatsprunk", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, nil, 35, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'soda')
end)

QBCore.Functions.CreateUseableItem("zatecola", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, nil, 35, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'soda')
end)

QBCore.Functions.CreateUseableItem("zatecolalight", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, nil, 35, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'soda')
end)

QBCore.Functions.CreateUseableItem("zatorangotang", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, nil, 35, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'soda')
end)

----------- / alcohol

QBCore.Functions.CreateUseableItem("orangemar", function(source, item)
    TriggerClientEvent("consumables:client:DrinkAlcohol", source, item.name, item.slot)
    TriggerClientEvent('consumables:client:callAnimation', source, 'whiskey')
end)

QBCore.Functions.CreateUseableItem("applemar", function(source, item)
    TriggerClientEvent("consumables:client:DrinkAlcohol", source, item.name, item.slot)
    TriggerClientEvent('consumables:client:callAnimation', source, 'whiskey')
end)

QBCore.Functions.CreateUseableItem("bluemf", function(source, item)
    TriggerClientEvent("consumables:client:DrinkAlcohol", source, item.name, item.slot)
    TriggerClientEvent('consumables:client:callAnimation', source, 'whiskey')
end)

----------- / Eat

QBCore.Functions.CreateUseableItem("sandwich", function(source, item)
    TriggerClientEvent("consumables:client:Eat", source, item.name, item.slot)
    TriggerClientEvent('consumables:client:callAnimation', source, 'sandwich')
end)

QBCore.Functions.CreateUseableItem("twerks_candy", function(source, item)
    TriggerClientEvent("consumables:client:Eat", source, item.name, item.slot)
    TriggerClientEvent('consumables:client:callAnimation', source, 'egobar')
end)

QBCore.Functions.CreateUseableItem("snikkel_candy", function(source, item)
    TriggerClientEvent("consumables:client:Eat", source, item.name, item.slot)
    TriggerClientEvent('consumables:client:callAnimation', source, 'egobar')
end)

QBCore.Functions.CreateUseableItem("tosti", function(source, item)
    TriggerClientEvent("consumables:client:Eat", source, item.name, item.slot)
    TriggerClientEvent('consumables:client:callAnimation', source, 'egobar')
end)

----------- / Drink


QBCore.Functions.CreateUseableItem("coffee", function(source, item)
    TriggerClientEvent("consumables:client:Drink", source, item.name, item.slot)
    TriggerClientEvent('consumables:client:callAnimation', source, 'coffee')
end)


----------- / UwU

QBCore.Functions.CreateUseableItem("matcha", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, nil, 70, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'xmasmug')
end)

QBCore.Functions.CreateUseableItem("bobam", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, nil, 50, 15)
    TriggerClientEvent('consumables:client:callAnimation', source, 'frappe')
end)

QBCore.Functions.CreateUseableItem("milksh", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, 20, 60, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'sipshaked')
end)

QBCore.Functions.CreateUseableItem("katsu", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, 60, nil, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'sandwich')
end)

QBCore.Functions.CreateUseableItem("omurice", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, 70, nil, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'dinner')
end)

QBCore.Functions.CreateUseableItem("hamburg", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, 90, nil, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'dinner')
end)

QBCore.Functions.CreateUseableItem("noodles", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, 80, nil, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'beans')
end)

QBCore.Functions.CreateUseableItem("ktburger", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, 90, nil, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'eat')
end)

QBCore.Functions.CreateUseableItem("ktpizza", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, 90, nil, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'pizzas5')
end)

QBCore.Functions.CreateUseableItem("mochi", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, 60, nil, 10)
    TriggerClientEvent('consumables:client:callAnimation', source, 'macaroon')
end)

QBCore.Functions.CreateUseableItem("ndonut", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, 60, nil, 10)
    TriggerClientEvent('consumables:client:callAnimation', source, 'donut2')
end)

QBCore.Functions.CreateUseableItem("ncookie", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, 50, nil, 10)
    TriggerClientEvent('consumables:client:callAnimation', source, 'gingerbread')
end)

QBCore.Functions.CreateUseableItem("ktccake", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, 50, nil, 10)
    TriggerClientEvent('consumables:client:callAnimation', source, 'xmascc')
end)

QBCore.Functions.CreateUseableItem("iccream", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, 50, nil, 10)
    TriggerClientEvent('consumables:client:callAnimation', source, 'desert')
end)

----------- / Pizza

QBCore.Functions.CreateUseableItem("vegas", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, nil, 80, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'wine')
end)

QBCore.Functions.CreateUseableItem("martini", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, nil, 80, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'wine')
end)

QBCore.Functions.CreateUseableItem("redbull", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, nil, 75, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'sipsoda')
end)

QBCore.Functions.CreateUseableItem("mojito", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, nil, 80, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'whiskey')
end)

QBCore.Functions.CreateUseableItem("campari", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, nil, 80, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'whiskey')
end)

QBCore.Functions.CreateUseableItem("bellini", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, nil, 80, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'whiskey')
end)

QBCore.Functions.CreateUseableItem("pepperoni", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, 75, nil, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'pizzas2')
end)

QBCore.Functions.CreateUseableItem("mixpizza", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, 80, nil, 25)
    TriggerClientEvent('consumables:client:callAnimation', source, 'pizzas2')
end)

QBCore.Functions.CreateUseableItem("chizpizza", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, 70, nil, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'pizzas2')
end)

QBCore.Functions.CreateUseableItem("veggiepz", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, 90, nil, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'pizzaslice')
end)

QBCore.Functions.CreateUseableItem("neapolitanpz", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, 80, nil, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'pizzas2')
end)

QBCore.Functions.CreateUseableItem("sicilianpz", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, 80, nil, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'pizzas2')
end)

QBCore.Functions.CreateUseableItem("capricciosapz", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, 80, nil, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'pizzas2')
end)



----------- / Burger

QBCore.Functions.CreateUseableItem("coca", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, nil, 50, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'soda4')
end)

QBCore.Functions.CreateUseableItem("sprite", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, nil, 60, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'sipsoda')
end)

QBCore.Functions.CreateUseableItem("monster", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, nil, 80, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'beer')
end)

QBCore.Functions.CreateUseableItem("ultrarose", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, nil, 80, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'beer')
end)


QBCore.Functions.CreateUseableItem("chizbgr", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, 85, nil, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'burger')
end)

QBCore.Functions.CreateUseableItem("spclbgr", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, 95, nil, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'burger')
end)

QBCore.Functions.CreateUseableItem("frnchfris", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, 65, nil, 5)
    TriggerClientEvent('consumables:client:callAnimation', source, 'taco')
end)

QBCore.Functions.CreateUseableItem("corndog", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, 60, nil, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'taco')
end)

QBCore.Functions.CreateUseableItem("kfcbgrs", function(source, item)
    TriggerClientEvent("consumables:client:Job", source, item.name, item.slot, 60, nil, nil)
    TriggerClientEvent('consumables:client:callAnimation', source, 'taco')
end)

----------- / Drug

QBCore.Functions.CreateUseableItem("cigarette_pack", function(source, item)
    TriggerClientEvent("consumables:client:UseCigarBox", source, item.slot)
end)

QBCore.Functions.CreateUseableItem("cigarette", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName("lighter") ~= nil then
        TriggerClientEvent("consumables:client:UseCigaret", source)
    else
        TriggerClientEvent("QBCore:Notify", source, 'You Do Not have Lighter', 'error')
    end
end)

QBCore.Functions.CreateUseableItem("cigar", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName("lighter") ~= nil then
        TriggerClientEvent("consumables:client:UseCigar", source)
    else
        TriggerClientEvent("QBCore:Notify", source, 'You Do Not have Lighter', 'error')
    end
end)

QBCore.Functions.CreateUseableItem("adrenalin", function(source, item)
    TriggerClientEvent("consumables:client:UseAdrenalin", source)
end)

QBCore.Functions.CreateUseableItem("cokebaggy", function(source)
    TriggerClientEvent("consumables:client:Cokebaggy", source)
end)

QBCore.Functions.CreateUseableItem("crack_baggy", function(source)
    TriggerClientEvent("consumables:client:Crackbaggy", source)
end)

QBCore.Functions.CreateUseableItem("xtcbaggy", function(source, _)
    TriggerClientEvent("consumables:client:EcstasyBaggy", source)
end)

QBCore.Functions.CreateUseableItem("oxy", function(source)
    TriggerClientEvent("consumables:client:oxy", source)
end)

QBCore.Functions.CreateUseableItem("meth", function(source)
    TriggerClientEvent("consumables:client:meth", source)
end)

----------- / Tools

QBCore.Functions.CreateUseableItem("armor", function(source)
    TriggerClientEvent("consumables:client:UseArmor", source)
end)

QBCore.Functions.CreateUseableItem("heavyarmor", function(source)
    TriggerClientEvent("consumables:client:UseHeavyArmor", source)
end)

QBCore.Functions.CreateUseableItem("binoculars", function(source)
    TriggerClientEvent("binoculars:Toggle", source)
end)

QBCore.Functions.CreateUseableItem("parachute", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:UseParachute", source)
    end
end)

QBCore.Commands.Add("resetparachute", "Resets Parachute", {}, false, function(source)
	TriggerClientEvent("consumables:client:ResetParachute", source)
end)

RegisterNetEvent('qb-smallpenis:server:AddParachute', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem("parachute", 1)
end)

----------- / Illegal Tools

QBCore.Functions.CreateUseableItem("lockpick", function(source, item)
    TriggerClientEvent("lockpicks:UseLockpick", source, false, item.slot)
end)

QBCore.Functions.CreateUseableItem("advancedlockpick", function(source, item)
    TriggerClientEvent("lockpicks:UseLockpick", source, true, item.slot)
end)

QBCore.Functions.CreateUseableItem("hacking_device", function(source, item)
    TriggerClientEvent("hack:UseHackingDevice", source, item.slot)
end)

QBCore.Functions.CreateUseableItem("thermite", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('lighter') ~= nil then
        TriggerClientEvent("thermite:UseThermite", source, item)
    else
        TriggerClientEvent('QBCore:Notify', source, "You are missing something to light the thermite..", "error")
    end
end)

--------- / Nightvision

QBCore.Functions.CreateUseableItem("nightvision", function(source)
    TriggerClientEvent("qb-nightvision:client:use", source)
end)

-------- / Weed

QBCore.Functions.CreateUseableItem("widow_weed", function(source, item)
    TriggerClientEvent("weed:client:useWidow", source, item.slot)
end)

QBCore.Functions.CreateUseableItem("purple_weed", function(source, item)
    TriggerClientEvent("weed:client:usePurple", source, item.slot)
end)

QBCore.Functions.CreateUseableItem("skunk_weed", function(source, item)
    TriggerClientEvent("weed:client:useSkunk", source, item.slot)
end)

QBCore.Functions.CreateUseableItem("kush_weed", function(source, item)
    TriggerClientEvent("weed:client:useKush", source, item.slot)
end)

QBCore.Functions.CreateUseableItem("amnesia_weed", function(source, item)
    TriggerClientEvent("weed:client:useAmnesia", source, item.slot)
end)

-------- / Ring

QBCore.Functions.CreateUseableItem("citrine", function(source, item)
    TriggerClientEvent("ring:client:useCitrine", source, item.slot)
end)

QBCore.Functions.CreateUseableItem("sapphire-ring", function(source, item)
    TriggerClientEvent("ring:client:useSapphire", source, item.slot)
end)

QBCore.Functions.CreateUseableItem("ruby-ring", function(source, item)
    TriggerClientEvent("ring:client:useRuby", source, item.slot)
end)