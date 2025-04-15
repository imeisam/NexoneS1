local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    for k, v in pairs(Config.job) do
        exports['qb-interact']:AddInteraction({
            coords = v.Managecoord,
            distance = 1.5,
            interactDst = 1.0,
            id = 'managejobfood_'..k,
            name= 'managejobfood_'..k,
            options = {
                {
                    label = 'Manage Food',
                    action = function()
                        TriggerEvent("nxo-foodjob:client:managefood",k)
                    end,
                    canInteract = function(entity, coords, args)
                        local PlayerData = QBCore.Functions.GetPlayerData()
                        return (PlayerData.job.name==k and PlayerData.job.grade.level>=v.managerank) end,
                },
            }
        })
    if v.makefoodcoord then
        for l, m in pairs(v.makefoodcoord) do
            exports['qb-interact']:AddInteraction({
                coords =m,
                distance = 2.5,
                interactDst = 2.0,
                id = 'makejobfood_'..l.."_"..k,
                name= 'makejobfood_'..l.."_"..k,
                options = {
                    {
                        label = 'Making Food',
                        action = function()
                            TriggerEvent("nxo-foodjob:client:makefood",k,"food")
                        end,
                        canInteract = function(entity, coords, args)
                            local PlayerData = QBCore.Functions.GetPlayerData()
                            return (PlayerData.job.name==k and PlayerData.job.grade.level>=v.makerfoodrank) end,
                    },
                }
            })
        end
        
    end
    if v.makedrinkcoord then
        for l, m in pairs(v.makedrinkcoord) do
            exports['qb-interact']:AddInteraction({
                coords = m,
                distance = 2.5,
                interactDst = 2.0,
                id = 'makejobdrink_'..l.."_"..k,
                name = 'makejobdrink_'..l.."_"..k,
                options = {
                    {
                        label = 'Making Drink',
                        action = function()
                            TriggerEvent("nxo-foodjob:client:makefood",k,"drink")
                        end,
                        canInteract = function(entity, coords, args)
                            local PlayerData = QBCore.Functions.GetPlayerData()
                            return (PlayerData.job.name==k and PlayerData.job.grade.level>=v.makedrinkrank) end,
                    },
                }
            })
        end
       
    end
       
    end
  
end)

RegisterNetEvent("nxo-foodjob:client:makefood", function(job,type)
    local menu={}
    menu[#menu+1]=
    {
        header = "Make a "..type,
        txt = "",
        icon = "fa fa-bars",
        isMenuHeader=true
    }
    QBCore.Functions.TriggerCallback('nxo-foodjob:server:getdata', function(res)
        if res and res[1] then
            for k, v in pairs(res) do
                local mat=""
                for l,m in pairs(json.decode(v.material)) do
                   mat=mat..QBCore.Shared.Items[m].label.. " | "
                end

                menu[#menu+1]=
                {
                    header = v.name,
                    txt = mat,
                    icon = "fa fa-caret-right",
                    params = {
                        event = "nxo-foodjob:client:makeit",
                        args = {id=v.id,name=v.name,type=type,job=job,data=v}
                    }
                }
            end
            exports['qb-menu']:openMenu(menu)
    else
        QBCore.Functions.Notify('No Find Item', 'error')
        return
    end
 end,job,type)

end)

RegisterNetEvent("nxo-foodjob:client:makeit", function(data)
local hasitem=true
for l,m in pairs(json.decode(data.data.material)) do
    
   if not QBCore.Functions.HasItem(m,1,true) then
         hasitem=false
   end
end

if not hasitem then
    QBCore.Functions.Notify('No Enough Item Need', 'error')
    return
end

if data.data.makeanimation then
    TriggerEvent('animations:client:EmoteCommandStart', {data.data.makeanimation})
end

QBCore.Functions.Progressbar("makefood", "Making "..data.data.name,8000, false, true, {
    disableMovement = true,
    disableCarMovement = true,
    disableMouse = false,
    disableCombat = true,
}, {}, {}, {}, function() -- Done
    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    TriggerServerEvent("nxo-foodjob:server:makefood",data)
end, function() -- Cancel
    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
end)

end)


RegisterNetEvent("nxo-foodjob:client:managefood", function(job)
    local menu={}
    menu[#menu+1]=
        {
            header = "Manage",
            txt = "",
            icon = "fa fa-bars",
            isMenuHeader=true
        }
        menu[#menu+1]=
        {
            header = "Add Food",
            txt = "",
            icon = "fa fa-cutlery",
            params = {
                event = "nxo-foodjob:client:addfood",
                args = {jobname=job,type="food"}
            }
        }
        menu[#menu+1]=
        {
            header = "Add Drink",
            txt = "",
            icon = "fa fa-coffee",
            params = {
                event = "nxo-foodjob:client:addfood",
                args = {jobname=job,type="drink"}
            }
        }
        menu[#menu+1]=
        {
            header = "Manage Food",
            txt = "",
            icon = "fa fa-cutlery",
            params = {
                event = "nxo-foodjob:client:getdata",
                args = {jobname=job,type="food"}
            }
        }
        menu[#menu+1]=
        {
            header = "Manage Drink",
            txt = "",
            icon = "fa fa-coffee",
            params = {
                event = "nxo-foodjob:client:getdata",
                args = {jobname=job,type="drink"}
            }
        }

    exports['qb-menu']:openMenu(menu)
end)
RegisterNetEvent("nxo-foodjob:client:getdata", function(data)
    local job=data.jobname
    local type=data.type
    local menu={}

    menu[#menu+1]=
        {
            header = "Manage "..type,
            txt = "",
            icon = "fa fa-bars",
            isMenuHeader=true
        }
       
            QBCore.Functions.TriggerCallback('nxo-foodjob:server:getdata', function(res)
                if res and res[1] then
                    for k, v in pairs(res) do
                        local mat=""
                        for l,m in pairs(json.decode(v.material)) do
                           mat=mat..QBCore.Shared.Items[m].label.. " | "
                        end

                        menu[#menu+1]=
                        {
                            header = v.name,
                            txt = mat,
                            icon = "fa fa-caret-right",
                            params = {
                                event = "nxo-foodjob:client:removeitem",
                                args = {id=v.id,name=v.name}
                            }
                        }
                    end
                    exports['qb-menu']:openMenu(menu)
            else
                QBCore.Functions.Notify('No Find Item', 'error')
                return
            end
         end,job,type)
          
        
end)
RegisterNetEvent("nxo-foodjob:client:removeitem", function(data)
    exports['qb-menu']:openMenu({
        {
            header = "Are You Remove?",
            txt =data.name,
            icon = "",
            isMenuHeader=true
        },
        {
            header ="Yes Sure",
            icon = "fa fa-check",
            params = {
                event = "nxo-foodjob:client:sureremoveitem",
                args = {id=data.id}
            }
        },
        {
            header ="No!!!!",
            icon = "fa fa-times",
        }
    }
    )
end)

RegisterNetEvent("nxo-foodjob:client:sureremoveitem", function(data)
    TriggerServerEvent("nxo-foodjob:server:removeitem",data.id)
end)
RegisterNetEvent("nxo-foodjob:client:addfood", function(data)
    local job=data.jobname
    local type=data.type
    local opmatrial={}
    local opanimations={}
    local opmakeanimations={}
    for k, v in pairs(Config.job[job].material[type]) do
        opmatrial[#opmatrial+1] ={ value = k, text =QBCore.Shared.Items[k].label}
    end
    for k, v in pairs(Config.job[job].animations[type]) do
        opanimations[#opanimations+1] = { value = v, text =v}
    end
    for k, v in pairs(Config.job[job].makeanimation[type]) do
        opmakeanimations[#opmakeanimations+1] = { value = v, text =v}
    end
    local input = exports['qb-input']:ShowInput({
        header = "Add "..type,
        submitText = "Add",
        inputs = {
            {
                type = 'text',
                isRequired = true,
                text = "Name",
                name = 'name',
            },
            {
                type = 'text',
                isRequired = true,
                text = "Image Url",
                name = 'image',
            },
            {
                text = 'Material', 
                name = "material",
                type = "checkbox",
                options = opmatrial
            },
            {
                text = 'Animation', 
                name = "animation",
                type = "select",
                options = opanimations
            },
            {
                text = 'Make Animation', 
                name = "makeanimation",
                type = "select",
                options = opmakeanimations
            },
        }
    })

    if input then
        TriggerServerEvent("nxo-foodjob:server:addfood",job,input,type)
    end
end)

RegisterNetEvent("nxo-foodjob:client:useitem", function(data)
    local ped = PlayerPedId()
    TriggerEvent('animations:client:EmoteCommandStart', {data.info.animation})
    QBCore.Functions.Progressbar("use_gause", 'Using '..data.info.name, 7000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		
    }, {}, {}, function() -- Done
        local dataitem=QBCore.Shared.Items['jobfood']
        dataitem.label=data.info.name
       
        TriggerServerEvent("QBCore:Server:RemoveItem", "jobfood", 1, data.slot)
        TriggerEvent("inventory:client:ItemBox",dataitem, "remove", 1,data.info.image)
        if data.info and data.info.thirst then
            TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + data.info.thirst )
        end
        if data.info and data.info.hunger then
            TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + data.info.hunger )
        end
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
       
        if data.info.alcoholdooz and data.info.alcoholdooz>0 then
            print(data.info.alcoholdooz)
            TriggerEvent("consumables:client:runDrinkAlcohol")
            if data.info.alcoholdooz==1 then
                TriggerEvent('consumables:client:callAnimation','beer')
            end
            if data.info.alcoholdooz==2 then
                TriggerEvent('consumables:client:callAnimation','whiskey')
            end
        end
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify('Canceled', "error")
    end)
end)

