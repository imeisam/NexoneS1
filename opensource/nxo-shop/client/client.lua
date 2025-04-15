AC = {}
local selectshopname=""
local eventshoploaded={}
local QBCore = exports['qb-core']:GetCoreObject()
local str=""
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
	load()
    jobload()
end)
RegisterNetEvent('QBCore:Client:OnJobUpdate', function()
    jobload()
end)
function jobload()
    eventshoploaded={}
    eventshoploaded=json.decode(json.encode(eventshop))
   
   grade= QBCore.Functions.GetPlayerData().job.grade.level 
 
    for m,n in pairs(eventshoploaded) do
        
        for k,v in pairs(n.itemList) do
            for j,i in pairs(v) do
                local hidden=false
                if eventshoploaded[m].itemList[k][j].rank or eventshoploaded[m].itemList[k][j].div then
                    hidden=true
                end

                if eventshoploaded[m].itemList[k][j].rank then
                    if grade>=eventshoploaded[m].itemList[k][j].rank then
                        hidden=false
                    end
                end
                
                if eventshoploaded[m].itemList[k][j].div then
                    if QBCore.Functions.HasDivision(eventshoploaded[m].itemList[k][j].div) then
                        hidden=false
                    end
                end
                eventshoploaded[m].itemList[k][j].name=QBCore.Shared.Items[eventshoploaded[m].itemList[k][j].itemname].label
                eventshoploaded[m].itemList[k][j].image=QBCore.Shared.Items[eventshoploaded[m].itemList[k][j].itemname].image

                if hidden then
                  eventshoploaded[m].itemList[k][j]=nil
                end
             end
        end
        
    end

end
function load()
 
    eventshoploaded={}
    eventshoploaded=json.decode(json.encode(eventshop))
   
   grade= QBCore.Functions.GetPlayerData().job.grade.level 
 
    for m,n in pairs(eventshoploaded) do
        
        for k,v in pairs(n.itemList) do
            for j,i in pairs(v) do
                local hidden=false
                if eventshoploaded[m].itemList[k][j].rank or eventshoploaded[m].itemList[k][j].div then
                    hidden=true
                end

                if eventshoploaded[m].itemList[k][j].rank then
                    if grade>=eventshoploaded[m].itemList[k][j].rank then
                        hidden=false
                    end
                end
                
                if eventshoploaded[m].itemList[k][j].div then
                    if QBCore.Functions.HasDivision(eventshoploaded[m].itemList[k][j].div) then
                        hidden=false
                    end
                end

                if hidden then
                  eventshoploaded[m].itemList[k][j]=nil
                end
             end
        end
        
    end

    for m,n in pairs(propshop) do
         
    for k,v in pairs(n.itemList) do
        for j,i in pairs(v) do
            propshop[m].itemList[k][j].name=QBCore.Shared.Items[propshop[m].itemList[k][j].itemname].label
            propshop[m].itemList[k][j].image=QBCore.Shared.Items[propshop[m].itemList[k][j].itemname].image
         end
    end
        for k,v in pairs(n.prop) do
            exports["qb-interact"]:AddModelInteraction({
                model  =v,
                name = 'acshop_'..m, 
                id ='acshop_'..m, 
                distance = 1.2, 
                interactDst = 1.2,
                offset =n.coord, 
                options = {
                    {
                        label = "Open Shop",
                        event="nxo-shop:client:openshop",
                        args={typeshop="prop",  shopid=m,}
                    },
                }
            })
        end
        
        
    end

for m,n in pairs(AC) do
   
    for k,v in pairs(n.itemList) do
        for j,i in pairs(v) do
                AC[m].itemList[k][j].name=QBCore.Shared.Items[AC[m].itemList[k][j].itemname].label
                AC[m].itemList[k][j].image=QBCore.Shared.Items[AC[m].itemList[k][j].itemname].image
         end
    end
    if n.npc then
    for k,v in pairs(n.npc.coord) do
        local model = GetHashKey(n.npc.model)
         RequestModel(model)
        while not HasModelLoaded(model) do
             Wait(1)
        end
        local npc = CreatePed(4, model,v.x,v.y,v.z-1,v.w, false, true)
         FreezeEntityPosition(npc, true)
         TaskStartScenarioInPlace(npc, n.npc.scenarios, 0, true)
         SetEntityInvincible(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
       
        exports['qb-interact']:AddInteraction({
            coords =v.xyz,
            distance = 4.0, -- optional
            interactDst = 2.5, -- optional
            name = 'acshop_'..k, 
            id = 'acshop_'..k, 
            options = {
                {
                    label = n.npc.label,
                    event="nxo-shop:client:openshop",
                    args={   typeshop="shop",  shopid=m,}
                },
            }
        })


        end
        if n.blip and n.blip.blip then
            if n.blip.bliponnpc then
                for j,m in pairs(n.npc.coord) do
                    local shopblip = AddBlipForCoord(m.xyz)
                    SetBlipSprite(shopblip, n.blip.BlipId)
                    SetBlipColour(shopblip, n.blip.BlipColor)
                    SetBlipScale(shopblip, n.blip.BlipSize)
                    SetBlipAsShortRange(shopblip, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(n.blip.BlipText)
                    EndTextCommandSetBlipName(shopblip)
                end
            else
                local shopblip = AddBlipForCoord(n.blip.coords)
                SetBlipSprite(shopblip, n.blip.BlipId)
                SetBlipColour(shopblip, n.blip.BlipColor)
                SetBlipScale(shopblip, n.blip.BlipSize)
                SetBlipAsShortRange(shopblip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(n.blip.BlipText)
                EndTextCommandSetBlipName(shopblip)
            end
        end
        
    end
end
end

RegisterNetEvent('nxo-shop:client:resultpay', function(res,message)
    SendNUIMessage({
        action = "payresult",
         data = {
          res=res,
          message=message,
          }
         })
end)
RegisterNetEvent('nxo-shop:client:openshop', function(data)
    selectshopname=data.shopid
   data=data.args
    QBCore.Functions.TriggerCallback('nxo-shop:server:licences', function(licences)
        local lisc=false
        local huntlisc=false
        if licences then
            if licences.weapon then
                lisc=true
            end
            if licences.hunting then
                huntlisc=true
            end
        end
        if data.typeshop=="shop" then
            SendNUIMessage({
                action = "OPEN",
                 data = {
                    licences=lisc,
                    hunting=huntlisc,
                    itemhuntinglicenses=itemhuntinglicenses,
                    itemlicenses=itemlicenses,
                  marketName = AC[data.shopid].name,
                  marketCategory = AC[data.shopid].category,
                 marketItemList = AC[data.shopid].itemList,
                 marketCategoryList =AC[data.shopid].categoryList,
                 marketJob=  AC[data.shopid].job,
                  }
                 })
            elseif data.typeshop=="prop" then
                SendNUIMessage({
                    action = "OPEN",
                     data = {
                        licences=lisc,
                        hunting=huntlisc,
                        itemlicenses=itemlicenses,
                        itemhuntinglicenses=itemhuntinglicenses,
                      marketName = propshop[data.shopid].name,
                      marketCategory = propshop[data.shopid].category,
                     marketItemList =propshop[data.shopid].itemList,
                     marketCategoryList =propshop[data.shopid].categoryList,
                     marketJob=  "",
                    
                      }
                     })
            end
                  SetNuiFocus(true, true)

    end)
   
end)

RegisterNetEvent('nxo-shop:client:openshopname', function(shopname)
    selectshopname=shopname
             SendNUIMessage({
                 action = "OPEN",
                  data = {
                     licences=true,
                     hunting=true,
                     itemlicenses={},
                     itemhuntinglicenses={},
                   marketName = eventshoploaded[shopname].name,
                   marketCategory = eventshoploaded[shopname].category,
                  marketItemList = eventshoploaded[shopname].itemList,
                  marketCategoryList =eventshoploaded[shopname].categoryList,
                  marketJob=eventshoploaded[shopname].job,
                  buytext="free",
                   }
                  })
                   SetNuiFocus(true, true)
 end)

    -- while true do
    --     sleep = 1000
    --     for i, pos in ipairs(Pos) do
    --         local playerPed = GetPlayerPed(-1)
    --         local playerCoords = GetEntityCoords(playerPed)
    --         local distance = GetDistanceBetweenCoords(playerCoords, pos.x, pos.y, pos.z, true)
    --         if distance < 3.0 then
    --             sleep = 5
                
            

    --             if AC[i].job == "" or AC[i].job == " " then 
    --                 DrawText3D(pos.x, pos.y, pos.z, "" .. AC[i].name .. " Press [E]")
    --                     if IsControlJustReleased(0, 38) then
    --                         SendNUIMessage({
    --                             action = "OPEN",
    --                             data = {
    --                                 marketName = AC[i].name,
    --                                 marketCategory = AC[i].category,
    --                                 marketItemList = AC[i].itemList,
    --                                 marketCategoryList = AC[i].categoryList,
    --                                 marketJob = AC[i].job,
    --                             }
    --                         })
    --                         SetNuiFocus(true, true)
    --                         sleep = 1000
    --                     end
    --                 else
    --                     if AC[i].job ~= nil then
    --                         local playerJob = QBCore.Functions.GetPlayerData().job.name
    --                         if playerJob == AC[i].job then
    --                             DrawText3D(pos.x, pos.y, pos.z, "" .. AC[i].name .. " Press [E]")
    --                             if IsControlJustReleased(0, 38) then
    --                                 SendNUIMessage({
    --                                     action = "OPEN",
    --                                     data = {
    --                                         marketName = AC[i].name,
    --                                         marketCategory = AC[i].category,
    --                                         marketItemList = AC[i].itemList,
    --                                         marketCategoryList = AC[i].categoryList,
    --                                         marketJob = AC[i].job,
    --                                     }
    --                                 })
    --                                 SetNuiFocus(true, true)
    --                                 sleep = 1000
    --                             end
    --                         end
    --                     end
    --                 end
    --             end      
    --         end
    --     Citizen.Wait(sleep)
    -- end



RegisterNUICallback("close",function()
    SetNuiFocus(false, false)
end)
RegisterNUICallback("notify",function(data)
   TriggerEvent('QBCore:Notify', src, data.message, 'error', 4000)
end)
RegisterNUICallback("pay",function(data)
    TriggerServerEvent("nxo-shop:pay", data,selectshopname)
end)


function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)

    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end
