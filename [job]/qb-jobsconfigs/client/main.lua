local QBCore = exports['qb-core']:GetCoreObject()
local configLoaded = false

RegisterNetEvent('qb-jobs:client:loadConfig', function(Code)
    load(Code)()
    configLoaded = true
end)

RegisterNetEvent('qb-jobs:client:changebanner', function(bannername)
    local dialog = exports['qb-input']:ShowInput({
        header = "Enter quantity to trade",
        submitText = "Change Banner",
        inputs = {
            {
                type = 'text',
                isRequired = true,
                name = 'url',
                text = 'Image URL'
            },
            {
                type = 'number',
                isRequired = true,
                name = 'width',
                text = 'Width'
            },
            {
                type = 'text',
                isRequired = true,
                name = 'hight',
                text = 'Hight'
            },
        }
    })
    if dialog then
        TriggerServerEvent("qb-jobs:server:changebanner",bannername,dialog.url, dialog.hight, dialog.width)
    end
end)

RegisterNetEvent('qb-jobs:client:setbanner', function(bannername,url,h,w)
    local rand=math.random(9999999)
    local txd = CreateRuntimeTxd(bannername..rand)
    local duiObj = CreateDui(url, w,h)

    local dui = GetDuiHandle(duiObj)
    local tx = CreateRuntimeTextureFromDuiHandle(txd, bannername..rand..'txt', dui)
    AddReplaceTexture('3dp_snrbuns_shops_editable_txd',bannername, bannername..rand, bannername..rand..'txt')
end)

-- CreateThread(function()
--     while not configLoaded do
--         Wait(500)
--     end
--     for k, v in pairs(Config.Jobs.banner) do
--         exports['qb-interact']:AddInteraction({
--             coords = v.interactioncoords,
--             distance =2.5,
--             interactDst = 1.2,
--             id = "bannerjob_"..k,
--             name ="bannerjob_"..k,
--             options ={
--                 {
--                     canInteract = function()
--                         if (QBCore.Functions.GetPlayerData().job.name== v.jobname and QBCore.Functions.GetPlayerData().job.grade.level >=v.rank) or (QBCore.Functions.GetPlayerData().job.name== "goverment" and QBCore.Functions.GetPlayerData().job.grade.level >=2)  then
--                             return true
--                         end
--                         return false
--                     end,
--                     action = function()
--                         TriggerEvent("qb-jobs:client:changebanner",v.bannername)
--                     end,
--                     label = "Change Banner",
--                 },
--             }
--         })
--     end
-- end)

CreateThread(function()
    while not configLoaded do
        Wait(500)
    end
    for k,v in ipairs(Config.Jobs.Blip) do
        local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
        SetBlipSprite(blip, v.sprite)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 0.69)
        SetBlipColour(blip, v.color)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.label)
        EndTextCommandSetBlipName(blip)
    end
end)

CreateThread(function()
    while not configLoaded do
        Wait(500)
    end
    for k, v in pairs(Config.Jobs.Stash) do
        exports['qb-target']:AddBoxZone(k..'_stashjobs', v.coords, 1.5, 1.5, {
            name = k..'_stashjobs',
            debugPoly = false,
            heading = 0,
            minZ = v.coords.z - 2,
            maxZ = v.coords.z + 2,
        }, {
            options = v.options,
            distance = 1.5
        })
    end
end)

CreateThread(function()
    while not configLoaded do
        Wait(500)
    end
    for k, v in pairs(Config.Gang.Stash) do
        exports['qb-target']:AddBoxZone(k..'_stashgangs', v.coords, 1.5, 1.5, {
            name = k..'_stashgangs',
            debugPoly = false,
            heading = 0,
            minZ = v.coords.z - 2,
            maxZ = v.coords.z + 2,
        }, {
            options = v.options,
            distance = 1.5
        })
    end
end)

CreateThread(function()
    while not configLoaded do
        Wait(500)
    end
    for k, v in ipairs(Config.Jobs.Counter) do
        exports['qb-target']:AddBoxZone(k..'_counter', v.coords, 0.5,0.5, {
            name = k..'_counter',
            debugPoly = false,
            heading = 0,
            minZ = v.coords.z - 0.5,
            maxZ = v.coords.z + 0.5,
        }, {
            options = {
                {
                    action = function()
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", v.name, {maxweight = v.weight, slots = v.slot})
                    end,
                    icon = "fas fa-box-open",
                    label = "Counter"
                },
            },
            distance = 1.5
        })
    end

end)

CreateThread(function()
    -- while not configLoaded do
    --     Wait(500)
    -- end
    for k, v in pairs(Config.Jobs.duty) do
        exports['qb-interact']:AddInteraction({
                        coords = v,
                        distance =2.5,
                        interactDst = 1.5,
                        id = "duty"..k,
                        name ="duty"..k,
                        options ={
                            {
                                canInteract = function()
                                    if (QBCore.Functions.GetPlayerData().job.name== k)  then
                                        return true
                                    end
                                    return false
                                end,
                                action = function()
                                    TriggerServerEvent("QBCore:ToggleDuty")
                                end,
                                label = "On/Off Duty",
                            },
                        }
                    })
    end
end)

CreateThread(function()
    while not configLoaded do
        Wait(500)
    end
    for k, v in pairs(Config.Jobs.bill) do
        exports['qb-target']:AddBoxZone(k..'_jobbill', v.coords, 0.5, 0.5, {
            name = k..'_jobbill',
            debugPoly = false,
            heading = 0,
            minZ = v.coords.z - 0.5,
            maxZ = v.coords.z + 0.5,
        }, {
            options = {
                {
                    action = function()
                        TriggerEvent("nxo:client:openbill")
                    end,
                    icon = "fas fa-usd",
                    label = "Bill",
                    job = v.jobname
                },
            },
            distance = 2.0
        })
    end
end)

CreateThread(function()
    while not configLoaded do
        Wait(500)
    end
    for k, v in pairs(Config.Jobs.Craft) do
        exports['qb-target']:AddBoxZone(k..'_craftjobs', v.coords, 1.5, 1.5, {
            name = k..'_craftjobs',
            debugPoly = false,
            heading = 0,
            minZ = v.coords.z - 2,
            maxZ = v.coords.z + 2,
        }, {
            options = {
                {
                    action = function()
                        local Menu = {}
                        Menu[#Menu + 1] = { header = "", txt = '❌ Close', params = { event = "qb-menu:closeMenu" } }
                        for i,j in pairs(v.items) do
                            local text = ""
                            local header = "<img src=nui://qb-inventory/html/images/"..QBCore.Shared.Items[i].image.." width=30px> "..QBCore.Shared.Items[i].label
                            for l, b in pairs(j) do
                                text = text.."- "..QBCore.Shared.Items[l].label.." x"..b.."<br>"
                            end
                            Menu[#Menu + 1] = {
                                header = header,
                                txt = text,
                                params = {
                                    isAction = true,
                                    event = function(kodom)
                                        local table = kodom.table
                                        local cItem = kodom.item
                                        if not table or not cItem then return end
                                        local itemsTable = Config.Jobs.Craft[table]
                                        if not itemsTable then return end
                                        local itemData = itemsTable.items[cItem]
                                        if not itemData then return end
                                        local keyboard = exports['qb-input']:ShowInput({
                                            header = "Item Amount",
                                            submitText = "Confirm",
                                            inputs = {
                                                {
                                                    type = 'text',
                                                    isRequired = true,
                                                    text = "Amount",
                                                    name = 'input',
                                                }
                                            }
                                        })
                                        if not keyboard then return end
                                        local amount = tonumber(keyboard.input)
                                        if not amount then return end
                                        amount = math.ceil(amount)
                                        if amount <= 0 then return end
                                        local requiredItems = {}
                                        local hasItem = true
                                        for m,n in pairs(itemData) do
                                            requiredItems[m] = n * amount
                                            if not QBCore.Functions.HasItem(m, n * amount, true) then
                                                hasItem = false
                                                break
                                            end
                                        end
                                        if hasItem then
                                            QBCore.Functions.Progressbar("crafting_jobs", "Crafting.. ", 2000 * amount, false, true, {
                                                disableMovement = true,
                                                disableCarMovement = true,
                                                disableMouse = false,
                                                disableCombat = true,
                                            }, {}, {}, {}, function()
                                                TriggerServerEvent('qb-jobs:server:craftItem', table, cItem, amount)
                                            end)
                                        else
                                            QBCore.Functions.Notify("You do not have the required items", "error")
                                        end
                                    end,
                                    args = {table = k, item = i}
                                }
                            }
                        end
                        exports['qb-menu']:openMenu(Menu)
                    end,
                    icon = "fa fa-circle",
                    label = "Craft Item",
                    job = v.jobname,
                    canInteract = function()
                        if v.rank then
                            if QBCore.Functions.GetPlayerData().job.grade.level < v.rank then
                                return false
                            end
                        end
                        return true
                    end,
                },
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    while not configLoaded do
        Wait(500)
    end
    for k, v in pairs(Config.Jobs.Repair) do
        exports['qb-target']:AddBoxZone(k..'_repairjobs', v.coords, 1.5, 1.5, {
            name = k..'_repairjobs',
            debugPoly = false,
            heading = 0,
            minZ = v.coords.z - 2,
            maxZ = v.coords.z + 2,
        }, {
            options = {
                {
                    action = function()
                        local Menu = {}
                        Menu[#Menu + 1] = { header = "", txt = '❌ Close', params = { event = "qb-menu:closeMenu" } }
                        for i,j in pairs(v.items) do
                            local text = ""
                            local header = "<img src=nui://qb-inventory/html/images/"..QBCore.Shared.Items[i].image.." width=30px> "..QBCore.Shared.Items[i].label
                            for l, b in pairs(j) do
                                text = text.."- "..QBCore.Shared.Items[l].label.." x"..b.."<br>"
                            end
                            Menu[#Menu + 1] = {
                                header = header,
                                txt = text,
                                params = {
                                    isAction = true,
                                    event = function(kodom)
                                        local table = kodom.table
                                        local cItem = kodom.item
                                        if not table or not cItem then return end
                                        local itemsTable = Config.Jobs.Repair[table]
                                        if not itemsTable then return end
                                        local itemData = itemsTable.items[cItem]
                                        if not itemData then return end
                                        local requiredItems = {}
                                        local hasItem = true
                                        for m,n in pairs(itemData) do
                                            requiredItems[m] = n
                                            if not QBCore.Functions.HasItem(m, n, true) then
                                                hasItem = false
                                                break
                                            end
                                        end
                                        if hasItem then
                                            QBCore.Functions.Progressbar("repair_jobs", "Repairing.. ", 5000, false, true, {
                                                disableMovement = true,
                                                disableCarMovement = true,
                                                disableMouse = false,
                                                disableCombat = true,
                                            }, {}, {}, {}, function()
                                                TriggerServerEvent('qb-jobs:server:repairItem', table, cItem)
                                            end)
                                        else
                                            QBCore.Functions.Notify("You do not have the required items", "error")
                                        end
                                    end,
                                    args = {table = k, item = i}
                                }
                            }
                        end
                        exports['qb-menu']:openMenu(Menu)
                    end,
                    icon = "fa fa-circle",
                    label = "Repair Item",
                    job = v.jobname,
                    canInteract = function()
                        if v.rank then
                            if QBCore.Functions.GetPlayerData().job.grade.level < v.rank then
                                return false
                            end
                        end
                        return true
                    end,
                },
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    while not configLoaded do
        Wait(500)
    end
    for k, v in pairs(Config.Jobs.Sell) do
        exports['qb-target']:AddBoxZone(k..'_selljobs', v.coords, 1.5, 1.5, {
            name = k..'_selljobs',
            debugPoly = false,
            heading = 0,
            minZ = v.coords.z - 2,
            maxZ = v.coords.z + 2,
        }, {
            options = {
                {
                    action = function()
                        local Menu = {}
                        Menu[#Menu + 1] = { header = "", txt = '❌ Close', params = { event = "qb-menu:closeMenu" } }
                        for i,j in pairs(v.items) do
                            local header = "<img src=nui://qb-inventory/html/images/"..QBCore.Shared.Items[i].image.." width=30px> "..QBCore.Shared.Items[i].label
                            Menu[#Menu + 1] = {
                                header = header,
                                txt = j..'$',
                                params = {
                                    isAction = true,
                                    event = function(kodom)
                                        local keyboard = exports['qb-input']:ShowInput({
                                            header = "Enter Sell Amount",
                                            submitText = "Sell",
                                            inputs = {
                                                {
                                                    type = 'text',
                                                    isRequired = true,
                                                    text = "Amount",
                                                    name = 'input',
                                                }
                                            }
                                        })
                                        if keyboard and keyboard.input then
                                            local amount = tonumber(keyboard.input)
                                            if not amount then QBCore.Functions.Notify('Just Number..', 'error') return end
                                            if amount <= 0 then QBCore.Functions.Notify('Bigger than 0', 'error') return end
                                            local gholam = (amount * 1000)
                                            if gholam > 30000 then
                                                gholam = 30000
                                            end
                                            QBCore.Functions.Progressbar("Selling_Item", "Selling Item", gholam, false, true, {
                                                disableMovement = true,
                                                disableCarMovement = true,
                                                disableMouse = false,
                                                disableCombat = true,
                                            }, {}, {}, {}, function()
                                                TriggerServerEvent('qb-jobs:server:sellItem', kodom, amount)
                                            end)
                                        end
                                    end,
                                    args = i
                                }
                            }
                        end
                        exports['qb-menu']:openMenu(Menu)
                    end,
                    icon = "fa fa-circle",
                    label = "Sell Menu",
                    job = k,
                    canInteract = function()
                        if QBCore.Functions.GetPlayerData().job.grade.level >= v.grade then
                            return true
                        end
                        return false
                    end,
                },
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    while not configLoaded do
        Wait(500)
    end
    for k, v in pairs(Config.Jobs.Separate) do
        exports['qb-target']:AddBoxZone(k..'_separatejobs', v.coords, 1.5, 1.5, {
            name = k..'_separatejobs',
            debugPoly = false,
            heading = 0,
            minZ = v.coords.z - 2,
            maxZ = v.coords.z + 2,
        }, {
            options = {
                {
                    action = function()
                        local Menu = {}
                        Menu[#Menu + 1] = { header = "", txt = '❌ Close', params = { event = "qb-menu:closeMenu" } }
                        for i,j in pairs(v.items) do
                            local text = ""
                            local header = "<img src=nui://qb-inventory/html/images/"..QBCore.Shared.Items[i].image.." width=30px> "..QBCore.Shared.Items[i].label
                            for l, b in pairs(j) do
                                text = text.."- "..QBCore.Shared.Items[l].label.." x"..b.."<br>"
                            end
                            Menu[#Menu + 1] = {
                                header = header,
                                txt = text,
                                params = {
                                    isAction = true,
                                    event = function(kodom)
                                        if not QBCore.Functions.HasItem(kodom,nil,true) then
                                            TriggerEvent('QBCore:Notify', 'You Dont Have '..QBCore.Shared.Items[kodom].label, 'error')
                                            return
                                        end
                                        QBCore.Functions.Progressbar('separate_item', "Separate... ", 10000, false, true, {
                                            disableMovement = true,
                                            disableCarMovement = true,
                                            disableMouse = false,
                                            disableCombat = true
                                        },  {
                                            animDict = "mini@repair",
                                            anim = "fixing_a_ped",
                                            flags = 8
                                        },  {}, {}, function()

                                            TriggerServerEvent('qb-jobs:server:SeparateGetItem', kodom)
                                            ClearPedTasks(PlayerPedId())
                                        end, function()
                                            ClearPedTasks(PlayerPedId())
                                        end)
                                    end,
                                    args = i
                                }
                            }
                        end
                        exports['qb-menu']:openMenu(Menu)
                    end,
                    icon = "fa fa-circle",
                    label = "Separate Item",
                    job = k,
                    canInteract = function()
                        if QBCore.Functions.GetPlayerData().job.grade.level >= v.grade then
                            return true
                        end
                        return false
                    end,
                },
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    while not configLoaded do
        Wait(500)
    end
    for k, v in pairs(Config.Jobs.Clothes) do
        local opt={}
        if v.outfit then
            opt[#opt+1]=  {
                label = "Outfit",
                groups = {
                    [k] = 0, 
                },
                action = function()
                    TriggerEvent('lvs_clothing:client:openOutfit')
                end,
                args = {}
            }
        end
        if v.clothing then
            opt[#opt+1]=  {
                label = "Change Clothing",
                groups = {
                    [k] = 0, 
                },
                action = function()
                    TriggerEvent("lvs_clothing:client:OpenClothingShop")
                end,
                args = {}
            }
        end
        exports['qb-interact']:AddInteraction({
            coords =v.coord,
            distance = 2.5,
            groups = {
                [k] = 0, 
            },
            interactDst = 1.5, 
            id = k..'_clothesjobs',
            name =k..'_clothesjobs',
            options =opt
        })
    end
end)

CreateThread(function()
    while not configLoaded do
        Wait(500)
    end
    for k, v in pairs(Config.Gang.Clothes) do
        exports['qb-target']:AddBoxZone(k..'_clothesgangs', v, 1.5, 1.5, {
            name = k..'_clothesgangs',
            debugPoly = false,
            heading = 0,
            minZ = v.z - 2,
            maxZ = v.z + 2,
        }, {
            options = {
                {
                    action = function()
                        TriggerEvent('lvs_clothing:client:openOutfit')
                    end,
                    icon = "fas fa-tshirt",
                    label = "Change Outfit",
                },
            },
            distance = 1.5
        })

        
    end
end)

TriggerServerEvent('qb-jobs:server:getConfig')