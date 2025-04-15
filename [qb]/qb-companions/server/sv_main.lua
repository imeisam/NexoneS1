local QBCore = exports['qb-core']:GetCoreObject()

local k9types = {
    [1] = {
      key = "chop",
      type = "rott",
      image = "https://s8.uupload.ir/files/rwkgt2b_uixt.png",
    },
    [2] = {
      key = "husky",
      type = "shep",
      image = "https://s8.uupload.ir/files/kc51atn_4url.png",
    },
    [3] = {
      key = "retriever",
      type = "retriever",
      image = "https://s8.uupload.ir/files/u2ejwou_191.png",
    },
    [4] = {
      key = "shepherd",
      type = "shepherd",
      image = "https://s8.uupload.ir/files/zk58r7w_xxy.png",
    },
    [5] = {
      key = "pit",
      type = "pit",
      image = "https://s8.uupload.ir/files/id7q0rc_6gx2.png",
    },
}

local k9Depts = {
    ['police'] = {
      key = "lspd",
    },
    ['sheriff'] = {
      key = "bcso",
    },
    ['state'] = {
      key = "troopers",
    },
    ['ranger'] = {
      key = "rangers",
    },
}

local petInfo = {
    ["coyote"] = {
      key = "coyote",
      type = "coyote",
      image = "https://s8.uupload.ir/files/dsliliw_3p0d.png",
    },
    ["panther"] = {
      key = "panther",
      type = "panther",
      image = "https://s8.uupload.ir/files/xyeeplc_ztzj.png",
    },
    ["pit"] = {
      key = "pit",
      type = "pit",
      image = "https://s8.uupload.ir/files/id7q0rc_6gx2.png",
    },
    ["cat"] = {
      key = "cat",
      type = "cat",
      image = "https://s8.uupload.ir/files/pordqnc_6p0r.png",
    },
    ["pug"] = {
      key = "pug",
      type = "pug",
      image = "https://s8.uupload.ir/files/polvhoo_b1he.png",
    },
    ["poodle"] = {
      key = "poodle",
      type = "poodle",
      image = "https://s8.uupload.ir/files/ftgozfw_r2bp.png",
    },
    ["westy"] = {
      key = "westy",
      type = "westy",
      image = "https://s8.uupload.ir/files/ieclsno_y1u1.png",
    },
    ["cow"] = {
      key = "cow",
      type = "cow",
      image = "https://s8.uupload.ir/files/tdsko7h_oc.png",
    },
    ["hen"] = {
      key = "hen",
      type = "hen",
      image = "https://s8.uupload.ir/files/igym4mi_14xv.png",
    },
    ["rabbit"] = {
      key = "rabbit",
      type = "rabbit",
      image = "https://s8.uupload.ir/files/prt9vi4_b59f.png",
    },
    ["pig"] = {
      key = "pig",
      type = "pig",
      image = "https://s8.uupload.ir/files/wf5jpe0_ji1d.png",
    },
}

local IllegalItems = {
  ['weedbud'] = true,
  ['weedpackage'] = true,
  ['package'] = true,
  ['sealedpackage'] = true,
  ['cocaleaf'] = true,
  ['shakedcoca'] = true,
  ['coca'] = true,
  ['rawcoke'] = true,
  ['powdercoke'] = true,
  ['rawmeth'] = true,
  ['drymeth'] = true
}

local function IsVehicleOwned(plate)
    local result = MySQL.Sync.fetchScalar('SELECT 1 from player_vehicles WHERE plate = ?', {plate})
    if result then return true else return false end
end

QBCore.Functions.CreateCallback("qb-pets:sniffTarget", function(src, cb, pType, pId)
    local hasContraband = false
    if pType == "ped" then
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        for k,v in pairs(Player.PlayerData.items) do
            if IllegalItems[v.name] then
                hasContraband = true
                break
            end
        end
    else
        if IsVehicleOwned(pId) then
            local trunk = exports['qb-inventory']:GetOwnedVehicleItems(pId)
            if trunk then
                for k,v in pairs(trunk) do
                    if IllegalItems[v.name] then
                        hasContraband = true
                        break
                    end
                end
            end
            if not hasContraband then
                local glovebox = exports['qb-inventory']:GetOwnedVehicleGloveboxItems(pId)
                if glovebox then
                    for k,v in pairs(glovebox) do
                        if IllegalItems[v.name] then
                            hasContraband = true
                            break
                        end
                    end
                end
            end
        else
            local trunk = exports['qb-inventory']:GetVehicleItems(pId)
            if trunk and trunk.items then
                for k,v in pairs(trunk.items) do
                    if IllegalItems[v.name] then
                        hasContraband = true
                        break
                    end
                end
            end
            if not hasContraband then
                local glovebox = exports['qb-inventory']:GetVehicleGloveboxItems(pId)
                if glovebox and glovebox.items then
                    for k,v in pairs(glovebox.items) do
                        if IllegalItems[v.name] then
                            hasContraband = true
                            break
                        end
                    end
                end
            end
        end
    end
    cb(hasContraband)
end)

QBCore.Functions.CreateUseableItem("summonablepet", function(source, item)
    local src = source
    TriggerClientEvent('qb-pets:usePet', src, item.info)
end)

RegisterNetEvent("qb-pets:purchasePet", function(params, name)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if Player.Functions.RemoveMoney("bank", params.price, "buy-pet") then
        local Variant = math.random(0, params.variants)
        if params.type == "k9" then
            local typeConfig = k9types[params.model] or k9types[1]
            local deptConfig = k9Depts[Player.PlayerData.job.dep] or k9Depts['police']
            Player.Functions.AddItem('summonablepet', 1, nil, {
                Owner = Player.PlayerData.citizenid,
                Name = name,
                type = typeConfig.type,
                key = typeConfig.key .. "_" .. deptConfig.key,
                k9 = true,
                id = Player.PlayerData.citizenid..tostring(math.random(1000000, 9999999)),
                cVariation = Variant and tonumber(Variant) or -1,
                image = typeConfig.image
            })
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['summonablepet'], "add", 1, typeConfig.image)
        else
            local info = petInfo[params.model]
            Player.Functions.AddItem('summonablepet', 1, nil, {
                Owner = Player.PlayerData.citizenid,
                Name = name,
                type = info.type,
                key = info.key,
                k9 = false,
                id = Player.PlayerData.citizenid..tostring(math.random(1000000, 9999999)),
                cVariation = Variant and tonumber(Variant) or -1,
                image = info.image
            })
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['summonablepet'], "add", 1, info.image)
        end
    else
        TriggerClientEvent("QBCore:Notify", src, "You need $" .. params.price, 'error')
    end
end)