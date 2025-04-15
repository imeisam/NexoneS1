local QBCore = exports['qb-core']:GetCoreObject()
local z=nil
local p=nil

CreateThread(function()
    if Config.SaleAvailableForJob then
        local PlayerData = QBCore.Functions.GetPlayerData()
        if Config.jobName[PlayerData.job.name] and PlayerData.job.grade.level>=Config.jobName[PlayerData.job.name] then
            for k, v in pairs(Config.location) do
                exports['qb-target']:AddBoxZone('pstorage'..k, v.coords, v.length, v.width, {
                    name = 'pstorage'..k,
                    heading = v.heading,
                    debugPoly = v.debug,
                    minZ = v.minz,
                    maxZ = v.maxz,
                }, {
                    options = {
                        {
                          type = "client",
                          action = function(entity) 
                            TriggerEvent('re2-vault:viewStorages', k)
                          end,
                          icon = "fas fa-box-open",
                          label = "View Storage",
                        },
                        {
                            type = "client",
                            action = function(entity) 
                              TriggerEvent('re2-vault:createStorageFor', k)
                            end,
                            icon = "fas fa-boxes",
                            label = "Create A Storage For",
                            canInteract = function()
                                print(k)
                                local data={storagelocation=k}
                                local fetchStoragePromise = function(data)
                                    if p then return end
                                    p = promise.new()
                                    QBCore.Functions.TriggerCallback('re2-vault:server:fetchStorageinlocation', function(result)
                                        p:resolve(result)
                                    end, data)
                                    return Citizen.Await(p)
                                end
                                local result = fetchStoragePromise(data)
                                p = nil
                                if not result then
                                    return true
                                end
                                return false
                            end,
                        },
                        {
                            type = "client",
                            action = function(entity) 
                              TriggerEvent('re2-vault:getcitizenId', k)
                            end,
                            icon = "fas fa-key",
                            label = "Change Storage Password For",
                        },
                    },
                    distance = v.distance
                })
            end
        else
            for k, v in pairs(Config.location) do
                exports['qb-target']:AddBoxZone('pstorage'..k, v.coords, v.length, v.width, {
                    name ='pstorage'..k,
                    heading = v.heading,
                    debugPoly = v.debug,
                    minZ = v.minz,
                    maxZ = v.maxz,
                }, {
                    options = {
                        {
                          type = "client",
                          action = function(entity) 
                            TriggerEvent('re2-vault:viewStorages', k)
                          end,
                          icon = "fas fa-box-open",
                          label = "View Storage",
                        },
                        
                    },
                    distance = v.distance
                })
            end
        end
    else
        for k, v in pairs(Config.location) do
            exports['qb-target']:AddBoxZone('pstorages_'..k, v.coords, v.length, v.width, {
                name = 'pstorages_'..k,
                heading = v.heading,
                debugPoly = v.debug,
                minZ = v.minz,
                maxZ = v.maxz,
            }, {
                options = {
                    {
                      type = "client",
                      action = function(entity) 
                        TriggerEvent('re2-vault:viewStorages', k)
                      end,
                      icon = "fas fa-box-open",
                      label = "View Storage",
                      canInteract = function()
                        local player=QBCore.Functions.GetPlayerData()
                        local data={storagelocation=k,cid=player.citizenid}
                        local fetchStoragePromise = function(data)
                            if z then return false end
                            z = promise.new()
                            QBCore.Functions.TriggerCallback('re2-vault:server:fetchStorageinlocationbycid', function(result)
                                z:resolve(result)
                            end, data)
                            return Citizen.Await(z)
                        end
                        local result = fetchStoragePromise(data)
                        z = nil
                        if result or (Config.jobName[player.job.name]~=nil and player.job.grade.level>=Config.jobName[player.job.name]) or (Config.allowjob[player.job.name]~=nil and player.job.grade.level>=Config.allowjob[player.job.name]) then
                            return true
                        end
                        return false
                    end,

                    },
                    {
                        type = "client",
                        action = function(entity) 
                          TriggerEvent('re2-vault:createStorage', k)
                        end,
                        icon = "fas fa-boxes",
                        label = "Rent Storage ($"..Config.StorageCreationAmount..' Per Day)',

                        canInteract = function()
                            local data={storagelocation=k}
                            local fetchStoragePromise = function(data)
                                if p then return false end
                                p = promise.new()
                                QBCore.Functions.TriggerCallback('re2-vault:server:fetchStorageinlocation', function(result)
                                    p:resolve(result)
                                end, data)
                                return Citizen.Await(p)
                            end
                            local result = fetchStoragePromise(data)
                            p = nil
                            if not result then
                                return true
                            end
                            return false
                        end,
                        
                      },
                },
                distance = v.distance
            })
        end
    end
    
    
  end)

AddEventHandler('re2-vault:viewStorages', function(location)
    local player=QBCore.Functions.GetPlayerData()
    local citizenid=player.citizenid
    local p = nil
    local data ={
        cid = citizenid,
        storagelocation = location,
    }
    

    local fetchStoragePromise = function(data)
        if p then return end
        p = promise.new()
        QBCore.Functions.TriggerCallback('re2-vault:server:fetchStorage', function(result)
            p:resolve(result)
        end, data)
        return Citizen.Await(p)
    end

    local fetchStoragePromisejobs = function(data)
        if p then return end
        p = promise.new()
        QBCore.Functions.TriggerCallback('re2-vault:server:fetchStoragejob', function(result)
            p:resolve(result)
        end, data)
        return Citizen.Await(p)
    end
    local result ={}
    if  (Config.jobName[player.job.name]~=nil and player.job.grade.level>=Config.jobName[player.job.name]) or (Config.allowjob[player.job.name]~=nil and player.job.grade.level>=Config.allowjob[player.job.name]) then
        result = fetchStoragePromisejobs(data)
    else
        result = fetchStoragePromise(data)
    end

    
    p = nil
    if result then
        local storagesMenu = {}
        --     {
        --         header = "Your Storages in "..Config.location[location].name,
        --         isMenuHeader = true
        --     }
        -- }

        for k, v in pairs(result) do
            storagesMenu[#storagesMenu+1] = {
                header ="CitizenID : "..v.citizenid,-- v.storagename,
                txt = "Expire: ".. v.expire .." <br/>Capacity : "..(v.storage_size/1000),
                params = {
                    event = "re2-vault:openStorageMenu",
                    args = {
                        storageid = v.id
                    }
                }

            }
        end

        storagesMenu[#storagesMenu+1] = {
            header = "Close Menu",
            txt = "",
            params = {
                event = "qb-menu:client:closeMenu"
            }

        }
        exports['qb-menu']:openMenu(storagesMenu)
    else
        QBCore.Functions.Notify("There is No Storage in this Location", "error")
    end
end)


AddEventHandler('re2-vault:openStorageMenu', function(data)
    local player=QBCore.Functions.GetPlayerData()
    local citizenid=player.citizenid
    -- local storagename=location.."_"..citizenid
    local dialog={}
    if (Config.jobName[player.job.name]~=nil and player.job.grade.level>=Config.jobName[player.job.name]) or (Config.allowjob[player.job.name]~=nil and player.job.grade.level>=Config.allowjob[player.job.name]) then
        dialog={password=""}
    else
        dialog = exports['qb-input']:ShowInput({
            header = "Storage Password",
            submitText = "Submit",
            inputs = {
                {
                    text = "Password", -- text you want to be displayed as a place holder
                    name = "password", -- name of the input should be unique otherwise it might override
                    type = "password", -- type of the input
                    isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
                }
            },
        })
    end
    

    if dialog ~= nil then
        local p = nil
        local data ={
            password = dialog.password,
            id = data.storageid
        }
        local openStoragePromise = function(data)
            if p then return end
            p = promise.new()
            QBCore.Functions.TriggerCallback('re2-vault:server:checkThePassword', function(result)
                p:resolve(result)
            end, data)
            return Citizen.Await(p)
        end
        local openStoragePromisejob = function(data)
            if p then return end
            p = promise.new()
            QBCore.Functions.TriggerCallback('re2-vault:server:checkThePasswordjob', function(result)
                p:resolve(result)
            end, data)
            return Citizen.Await(p)
        end
        local result ={} 
        if (Config.jobName[player.job.name] and player.job.grade.level>=Config.jobName[player.job.name]) or (Config.allowjob[player.job.name] and player.job.grade.level>=Config.allowjob[player.job.name]) then
            result= openStoragePromisejob(data)
        else
            result= openStoragePromise(data)
        end
        
        p = nil
        if result then
            local v = result[1]
            local storageMenu = {
                {
                    isHeader = true,
                    header = 'Storage '--..v.storagename
                },
            }
               if not (Config.jobName[player.job.name] and player.job.grade.level>=Config.jobName[player.job.name])  then
                local addstorageMenu=  {
                    header = '📦 | Open Storage',
                    txt = 'Open Storage',
                    params = {
                        event = 're2-vault:openInventory',
                        args = {
                            storagename = v.storage_location,
                            storagesize = v.storage_size
                        }
                    }
                }
                table.insert(storageMenu,addstorageMenu) 
            end
           
            if (Config.jobName[player.job.name] and player.job.grade.level>=Config.jobName[player.job.name])  then
                local addstorageMenu={
                    header = '🛒 | Add Storage',
                    txt = 'Add 200lbs to the Storage',
                    params = {
                        event = 're2-vault:addCapacity',
                        args = {
                            storageid = v.id
                        }
                    }
                }
                table.insert(storageMenu,addstorageMenu) 
            end
            if citizenid == v.citizenid then
                local addmembermenu={
                    header = '➕ | Add Memeber',
                    txt = 'Add Member to the Storage',
                    params = {
                        event = 're2-vault:addMemberToStorage',
                        args = {
                            storageid = v.id,
                        }
                    }
                }
                table.insert(storageMenu,addmembermenu)
                local removememberMenu={
                    header = '✍ | Manage Member',
                    txt = 'Remove Member to the Storage',
                    params = {
                        event = 're2-vault:manageMemberFromStorage',
                        args = {
                            storageid = v.id
                        }
                    }
                }
                table.insert(storageMenu,removememberMenu)
              
                local addstorageMenu={
                    header = '⏱ | Add Days',
                    txt = 'add rent day',
                    params = {
                        event = 're2-vault:addday',
                        args = {
                            storageid = v.id
                        }
                    }
                }
                table.insert(storageMenu,addstorageMenu) 
               
                local addstorageMenu={
                    header = '🔑 | Change Password',
                    txt = 'Change Storage Password',
                    params = {
                        event = 're2-vault:changePassword',
                        args = {
                            storageid = v.id
                        }
                    }
                }
                table.insert(storageMenu,addstorageMenu) 
            end
            local closeMenu={
                header = "Close Menu",
                txt = "",
                params = {
                    event = "qb-menu:client:closeMenu"
                }
            }
            table.insert(storageMenu,closeMenu) 
              exports['qb-menu']:openMenu(storageMenu)
            QBCore.Functions.Notify("Correct Password", "success")
        else
            QBCore.Functions.Notify("Wrong Password", "error")
        end
    end
end)

AddEventHandler('re2-vault:addday', function(location)
    local player=QBCore.Functions.GetPlayerData()
    local citizenid=player.citizenid
    local cpdialog = exports['qb-input']:ShowInput({
        header = "Add Day Rent ($ "..Config.StorageCreationAmount.." For Per Day)",
        submitText = "Submit",
        inputs = {
            -- {
            --     text = "Name", -- text you want to be displayed as a place holder
            --     name = "name", -- name of the input should be unique otherwise it might override
            --     type = "text", -- type of the input
            --     isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            -- },
              {
                text = "Days", -- text you want to be displayed as a place holder
                name = "days", -- name of the input should be unique otherwise it might override
                type = "number", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            },
        },
    })
    if cpdialog ~= nil then
        if player.money['bank'] >= tonumber(Config.StorageCreationAmount)*tonumber(cpdialog.days) then
        local p = nil
        local data ={
            storagelocation = location.storageid,
            days=cpdialog.days,
        }
        local createStoragePromise = function(data)
            if p then return end
            p = promise.new()
            QBCore.Functions.TriggerCallback('re2-vault:server:addday', function(result)
                p:resolve(result)
            end, data)
            return Citizen.Await(p)
        end
    
        local result = createStoragePromise(data)
        p = nil
        if result then
            TriggerServerEvent('re2-vault:server:removeMoney', tonumber(Config.StorageCreationAmount)*tonumber(cpdialog.days))
            QBCore.Functions.Notify("Storage Rent For "..cpdialog.days.." Day", "success")
        end
        -- return cb(result)
    else
        QBCore.Functions.Notify("You can not Afort that", "error")
    end
    end


end)
AddEventHandler('re2-vault:createStorage', function(location)
    local player=QBCore.Functions.GetPlayerData()
    local citizenid=player.citizenid
    local cpdialog = exports['qb-input']:ShowInput({
        header = "Rent Storage ($ "..Config.StorageCreationAmount.." For Per Day)",
        submitText = "Submit",
        inputs = {
            -- {
            --     text = "Name", -- text you want to be displayed as a place holder
            --     name = "name", -- name of the input should be unique otherwise it might override
            --     type = "text", -- type of the input
            --     isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            -- },
              {
                text = "Days", -- text you want to be displayed as a place holder
                name = "days", -- name of the input should be unique otherwise it might override
                type = "number", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            },
            {
                text = "Password", -- text you want to be displayed as a place holder
                name = "password", -- name of the input should be unique otherwise it might override
                type = "password", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            }
        },
    })
    if cpdialog ~= nil then
        if player.money['bank'] >= tonumber(Config.StorageCreationAmount)*tonumber(cpdialog.days) then
        local p = nil
        local data ={
            cid = citizenid,
            password = cpdialog.password,
            storagename = '',--cpdialog.name,
            storagelocation = location,
            storagesize = Config.StorageDefaultWeight,
            days=cpdialog.days,
        }
        local createStoragePromise = function(data)
            if p then return end
            p = promise.new()
            QBCore.Functions.TriggerCallback('re2-vault:server:createStorage', function(result)
                p:resolve(result)
            end, data)
            return Citizen.Await(p)
        end
    
        local result = createStoragePromise(data)
        p = nil
        if result then
            TriggerServerEvent('re2-vault:server:removeMoney',tonumber(Config.StorageCreationAmount)*tonumber(cpdialog.days))
            QBCore.Functions.Notify("Storage Rent For "..cpdialog.days.." Day", "success")
        else
            QBCore.Functions.Notify("Dublicate Name For storage", "error")
        end
        -- return cb(result)
    else
        QBCore.Functions.Notify("You can not Afort that", "error")
    end
    end


end)

AddEventHandler('re2-vault:createStorageFor', function(location)
    local data={}
    data.storagelocation=location
    data.cid=location

    local p = nil
    if p then return end
    p = promise.new()
    QBCore.Functions.TriggerCallback('re2-vault:server:fetchStorageinlocation', function(result)
        p:resolve(result)
      
    end, data)
    local result = fetchStoragePromise(data)
    p = nil
   
    if (result) then  QBCore.Functions.Notify("Storage Has a Owner", "error") return end
    local player=QBCore.Functions.GetPlayerData()
    -- local citizenid=player.citizenid
    local cpdialog = exports['qb-input']:ShowInput({
        header = "Create Storage For",
        submitText = "Submit",
        inputs = {
            -- {
            --     text = "Name", -- text you want to be displayed as a place holder
            --     name = "name", -- name of the input should be unique otherwise it might override
            --     type = "text", -- type of the input
            --     isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            -- },
            {
                text = "CitizenID", -- text you want to be displayed as a place holder
                name = "citizenid", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            },
            {
                text = "Password", -- text you want to be displayed as a place holder
                name = "password", -- name of the input should be unique otherwise it might override
                type = "password", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            }
        },
    })
    if cpdialog ~= nil then
        if player.money['bank'] >= tonumber(Config.StorageCreationAmount) then
        local p = nil
        local data ={
            cid = cpdialog.citizenid,
            password = cpdialog.password,
            storagename ='',-- cpdialog.name,
            storagelocation = location,
            storagesize = Config.StorageDefaultWeight
        }
        local createStoragePromise = function(data)
            if p then return end
            p = promise.new()
            QBCore.Functions.TriggerCallback('re2-vault:server:createStorage', function(result)
                p:resolve(result)
            end, data)
            return Citizen.Await(p)
        end
    
        local result = createStoragePromise(data)
        p = nil
        if result then
            TriggerServerEvent('re2-vault:server:removeMoney',Config.StorageCreationAmount)
            QBCore.Functions.Notify("Storage Created", "success")
        else
            QBCore.Functions.Notify("Dublicate Name For storage", "error")
        end
        -- return cb(result)
    else
        QBCore.Functions.Notify("You can not Afort that", "error")
    end
    end


end)


AddEventHandler('re2-vault:addMemberToStorage', function(data)
    local player=QBCore.Functions.GetPlayerData()
    local citizenid=player.citizenid
    -- local storagename=location.."_"..citizenid
    local mdialog = exports['qb-input']:ShowInput({
        header = "Add Member",
        submitText = "Submit",
        inputs = {
            {
                text = "Member CitizenID", -- text you want to be displayed as a place holder
                name = "citizenid", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            }
        },
    })

    if mdialog ~= nil then
        local p = nil
        local data ={
            citizenid = mdialog.citizenid,
            id = data.storageid
        }
        local addMemberPromise = function(data)
            if p then return end
            p = promise.new()
            QBCore.Functions.TriggerCallback('re2-vault:server:addMember', function(result)
                p:resolve(result)
            end, data)
            return Citizen.Await(p)
        end
    
        local result = addMemberPromise(data)
        p = nil
        if result then
            QBCore.Functions.Notify("Member Add Sucessfuly", "success")
        else
            QBCore.Functions.Notify("Something Went Wrong", "error")
        end
    end
end)

AddEventHandler('re2-vault:manageMemberFromStorage', function(data)
    local p = nil
    local data ={
        id = data.storageid
    }
    local addMemberPromise = function(data)
        if p then return end
        p = promise.new()
        QBCore.Functions.TriggerCallback('re2-vault:server:getstoragemember', function(result)
            p:resolve(result)
        end, data)
        return Citizen.Await(p)
    end

    local result = addMemberPromise(data)
    p = nil
    
    if result then
        local storageMenu = {
            {
                isHeader = true,
                header = 'Storage Members'
            },
        }
            for k, v in pairs(result.members) do
                storageMenu[#storageMenu+1]={
                    header = v.name..'[ '..v.cid..' ]',
                    txt = 'Click For Remove',
                    params = {
                        event = 're2-vault:removeMember',
                        args = {
                            cid = v.cid,
                            storageid =  data.id,
                        }
                    }
                }
            end
           
            exports['qb-menu']:openMenu(storageMenu)
    end
end)

AddEventHandler('re2-vault:removeMember', function(data)
    local p = nil
    local data ={
        citizenid = data.cid,
        id = data.storageid
    }
    local removeMemberPromise = function(data)
        if p then return end
        p = promise.new()
        QBCore.Functions.TriggerCallback('re2-vault:server:removeMember', function(result)
            p:resolve(result)
        end, data)
        return Citizen.Await(p)
    end
    
    local result = removeMemberPromise(data)
    p = nil
    if result then
        QBCore.Functions.Notify("Member Removed Sucessfuly", "success")
    else
        QBCore.Functions.Notify("Something Went Wrong", "error")
    end
end)



AddEventHandler('re2-vault:removeMemberFromStorage', function(data)
    local player=QBCore.Functions.GetPlayerData()
    local citizenid=player.citizenid
    -- local storagename=location.."_"..citizenid
    local mdialog = exports['qb-input']:ShowInput({
        header = "Remove Member",
        submitText = "Submit",
        inputs = {
            {
                text = "Member CitizenID", -- text you want to be displayed as a place holder
                name = "citizenid", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            }
        },
    })

    if mdialog ~= nil then
        local p = nil
        local data ={
            citizenid = mdialog.citizenid,
            id = data.storageid
        }
        local removeMemberPromise = function(data)
            if p then return end
            p = promise.new()
            QBCore.Functions.TriggerCallback('re2-vault:server:removeMember', function(result)
                p:resolve(result)
            end, data)
            return Citizen.Await(p)
        end
    
        local result = removeMemberPromise(data)
        p = nil
        if result then
            QBCore.Functions.Notify("Member Removed Sucessfuly", "success")
        else
            QBCore.Functions.Notify("Something Went Wrong", "error")
        end
    end
end)

AddEventHandler('re2-vault:openInventory', function(data)
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "PStorage_"..data.storagename,{
            maxweight = data.storagesize,
            slots = Config.StorageSlots,
        })
        TriggerEvent("inventory:client:SetCurrentStash", "PStorage_"..data.storagename)
        QBCore.Functions.Notify("Vault is Opening...", "success")

    
end)


AddEventHandler('re2-vault:addCapacity', function(data)
    local player=QBCore.Functions.GetPlayerData()
    if player.money['bank'] >= tonumber(Config.StorageAddPrice) then
        local p = nil
        local data ={
            id = data.storageid
        }
        local addCapacityPromise = function(data)
            if p then return end
            p = promise.new()
            QBCore.Functions.TriggerCallback('re2-vault:server:addCapacity', function(result)
                p:resolve(result)
            end, data)
            return Citizen.Await(p)
        end
        
        local result = addCapacityPromise(data)
        p = nil
        if result then
            TriggerServerEvent('re2-vault:server:removeMoney',Config.StorageAddPrice)
            QBCore.Functions.Notify("You Add Capacity to Your Storage", "success")
        else
            QBCore.Functions.Notify("Something Went Wrong", "error")
        end
    else
        QBCore.Functions.Notify("You Can not Afort that", "error")
    end
end)

AddEventHandler('re2-vault:changePassword', function(data)
    local player=QBCore.Functions.GetPlayerData()
    local citizenid=player.citizenid
    -- local storagename=location.."_"..citizenid
    local mdialog = exports['qb-input']:ShowInput({
        header = "NewPassword",
        submitText = "Submit",
        inputs = {
            {
                text = "New Password", -- text you want to be displayed as a place holder
                name = "password", -- name of the input should be unique otherwise it might override
                type = "password", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            }
        },
    })

    if mdialog ~= nil then
        local p = nil
        local data ={
            password = mdialog.password,
            id = data.storageid
        }
        local addMemberPromise = function(data)
            if p then return end
            p = promise.new()
            QBCore.Functions.TriggerCallback('re2-vault:server:changePassword', function(result)
                p:resolve(result)
            end, data)
            return Citizen.Await(p)
        end
    
        local result = addMemberPromise(data)
        p = nil
        if result then
            QBCore.Functions.Notify("PassWord Change Sucessfuly", "success")
        else
            QBCore.Functions.Notify("Something Went Wrong", "error")
        end
    end
end)

AddEventHandler('re2-vault:getcitizenId', function(location)
    local player=QBCore.Functions.GetPlayerData()
    
    local mdialog = exports['qb-input']:ShowInput({
        header = "Player Citizen ID",
        submitText = "Submit",
        inputs = {
            {
                text = "CitizenID", -- text you want to be displayed as a place holder
                name = "citizenid", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            }
        },
    })

    if mdialog ~= nil then
        local p = nil
        local data ={
            cid = mdialog.citizenid,
            storagelocation = location,
        }
        local fetchStoragePromise = function(data)
            if p then return end
            p = promise.new()
            QBCore.Functions.TriggerCallback('re2-vault:server:fetchStorage', function(result)
                p:resolve(result)
            end, data)
            return Citizen.Await(p)
        end
        
        local result = fetchStoragePromise(data)
            p = nil
            if result then
                local storagesMenu = {
                    {
                        header = mdialog.citizenid.." Storages in "..Config.location[location].name,
                        isMenuHeader = true
                    }
                }
        
                for k, v in pairs(result) do
                    storagesMenu[#storagesMenu+1] = {
                        header = Config.location[location].name,
                        txt = "Owner : "..v.citizenid,
                        params = {
                            event = "re2-vault:changePassword",
                            args = {
                                storageid = v.id
                            }
                        }
        
                    }
                end
        
                storagesMenu[#storagesMenu+1] = {
                    header = "Close Menu",
                    txt = "",
                    params = {
                        event = "qb-menu:client:closeMenu"
                    }
        
                }
                exports['qb-menu']:openMenu(storagesMenu)
            else
                QBCore.Functions.Notify("Something Went Wrong", "error")
            end
        end
end)




