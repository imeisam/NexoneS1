local QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = QBCore.Functions.GetPlayerData().job

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        PlayerJob = QBCore.Functions.GetPlayerData().job
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

RegisterNetEvent('qb-bossmenu:client:OpenMenu', function()
    if not PlayerJob.name or (not PlayerJob.isboss and not PlayerJob.ismanager and not QBCore.Functions.HasDivision('hc') and not QBCore.Functions.HasDivision('hr')) then return end
    local bossMenu = {
        {
            header = "Boss Menu - " .. string.upper(PlayerJob.label),
            icon = "fa-solid fa-circle-info",
            isMenuHeader = true,
        },
        {
            header = "Manage Employees",
            txt = "Check your Employees List",
            icon = "fa-solid fa-list",
            params = {
                event = "qb-bossmenu:client:employeelist",
            }
        },
        {
            header = "Hire Employees",
            txt = "Hire Nearby Civilians",
            icon = "fa-solid fa-hand-holding",
            params = {
                event = "qb-bossmenu:client:HireMenu",
            }
        },
    }
    if PlayerJob.isboss or QBCore.Functions.HasDivision('hc') then
        bossMenu[#bossMenu+1] = {
            header = "Storage Access",
            txt = "Open Storage",
            icon = "fa-solid fa-box-open",
            params = {
                event = "qb-bossmenu:client:Stash",
            }
        }
    end
    bossMenu[#bossMenu+1] = {
        header = "Exit",
        icon = "fa-solid fa-angle-left",
        params = {
            event = "qb-menu:closeMenu",
        }
    }
    exports['qb-menu']:openMenu(bossMenu)
end)

RegisterNetEvent('qb-bossmenu:client:employeelist', function()
    local EmployeesMenu = {
        {
            header = "Manage Employees - " .. string.upper(PlayerJob.label),
            isMenuHeader = true,
            icon = "fa-solid fa-circle-info",
        },
    }
    QBCore.Functions.TriggerCallback('qb-bossmenu:server:GetEmployees', function(cb)
        for _, v in pairs(cb) do
            local onText = '🔴'
            if v.online then
                onText = '🟢'
            end
            local ActiveText = QBCore.Shared.Jobs[v.activeJob] and QBCore.Shared.Jobs[v.activeJob].label or 'Civilian'
            EmployeesMenu[#EmployeesMenu + 1] = {
                header = '['..v.grade.name..'] '..v.name,
                txt = onText..' - '..ActiveText,
                icon = "fa-solid fa-circle-user",
                params = {
                    event = "qb-bossmenu:client:ManageEmployee",
                    args = v
                }
            }
        end
        EmployeesMenu[#EmployeesMenu + 1] = {
            header = "Return",
            icon = "fa-solid fa-angle-left",
            params = {
                event = "qb-bossmenu:client:OpenMenu",
            }
        }
        exports['qb-menu']:openMenu(EmployeesMenu)
    end)
end)

RegisterNetEvent('qb-bossmenu:client:ManageEmployee', function(player)
    local EmployeeMenu = {
        {
            header = "Manage " .. player.name .. " - " .. string.upper(PlayerJob.label),
            isMenuHeader = true,
            icon = "fa-solid fa-circle-info"
        },
    }
    EmployeeMenu[#EmployeeMenu + 1] = {
        header = "Fire Employee",
        icon = "fa-solid fa-user-large-slash",
        params = {
            isServer = true,
            event = "qb-bossmenu:server:FireEmployee",
            args = player.empSource
        }
    }
    if player.online and player.activeJob == PlayerJob.name then
        if QBCore.Shared.Jobs[PlayerJob.name].division then
            EmployeeMenu[#EmployeeMenu + 1] = {
                header = "Divisions",
                icon = "fa-solid fa-circle-user",
                params = {
                    event = "qb-bossmenu:client:OpenDivision",
                    args = player.empSource
                }
            }
        end
        local Grades = QBCore.Shared.Jobs[PlayerJob.name].grades
        local SortGrades = {}
        for k,v in pairs(Grades) do
            SortGrades[tonumber(k) + 1] = v
        end
        for k, v in pairs(SortGrades) do
            EmployeeMenu[#EmployeeMenu + 1] = {
                header = v.name,
                txt = "Grade: " .. tostring(k-1),
                params = {
                    isServer = true,
                    event = "qb-bossmenu:server:GradeUpdate",
                    icon = "fa-solid fa-file-pen",
                    args = {
                        cid = player.empSource,
                        grade = k-1,
                        gradename = v.name
                    }
                }
            }
        end
    end
    EmployeeMenu[#EmployeeMenu + 1] = {
        header = "Return",
        icon = "fa-solid fa-angle-left",
        params = {
            event = "qb-bossmenu:client:OpenMenu",
        }
    }
    exports['qb-menu']:openMenu(EmployeeMenu)
end)

RegisterNetEvent('qb-bossmenu:client:OpenDivision', function(cid)
    local EmployeesMenu = {
        {
            header = "Manage Employee Divisions",
            isMenuHeader = true,
            icon = "fa-solid fa-circle-info",
        },
    }
    QBCore.Functions.TriggerCallback('qb-bossmenu:server:GetDivision', function(cb)
        if cb == nil then
            cb = {}
        end
        for k, v in pairs(cb) do
            local txt = '❌'
            if v.state == true then
                txt = '🟢'
            end
            EmployeesMenu[#EmployeesMenu + 1] = {
                header = v.name,
                txt = txt,
                icon = "fa-solid fa-circle-user",
                params = {
                    isServer = true,
                    event = "qb-bossmenu:server:ManageEmployeeDivision",
                    args = {
                        cid = cid,
                        state = not v.state,
                        name = v.name
                    }
                }
            }
        end
        EmployeesMenu[#EmployeesMenu + 1] = {
            header = "Return",
            icon = "fa-solid fa-angle-left",
            params = {
                event = "qb-bossmenu:client:OpenMenu",
            }
        }
        exports['qb-menu']:openMenu(EmployeesMenu)
    end, cid)
end)

RegisterNetEvent('qb-bossmenu:client:HireMenu', function()
    local HireMenu = {
        {
            header = "Hire Employees - " .. string.upper(PlayerJob.label),
            isMenuHeader = true,
            icon = "fa-solid fa-circle-info",
        },
    }
    QBCore.Functions.TriggerCallback('qb-bossmenu:getplayers', function(players)
        for _, v in pairs(players) do
            if v and v ~= PlayerId() then
                HireMenu[#HireMenu + 1] = {
                    header = v.name,
                    txt = "Citizen ID: " .. v.citizenid .. " - ID: " .. v.sourceplayer,
                    icon = "fa-solid fa-user-check",
                    params = {
                        isServer = true,
                        event = "qb-bossmenu:server:HireEmployee",
                        args = v.sourceplayer
                    }
                }
            end
        end
        HireMenu[#HireMenu + 1] = {
            header = "Exit",
            icon = "fa-solid fa-angle-left",
            params = {
                event = "qb-menu:closeMenu",
            }
        }
        exports['qb-menu']:openMenu(HireMenu)
    end)
end)

RegisterNetEvent('qb-bossmenu:client:Stash', function()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "boss_" .. PlayerJob.name, {
        maxweight = 200000,
        slots = 28,
    })
end)

-- MAIN THREAD
CreateThread(function()
    for job, zones in pairs(Config.BossMenuZones) do
        for index, data in ipairs(zones) do
            exports['qb-target']:AddBoxZone(job.."-BossMenu-"..index, data.coords, 1.0, 1.0, {
                name = job.."-BossMenu-"..index,
                heading = 0,
                debugPoly = false,
                minZ = data.coords.z - 1,
                maxZ = data.coords.z + 1,
            }, {
                options = {
                    {
                        type = "client",
                        event = "qb-bossmenu:client:OpenMenu",
                        icon = "fas fa-sign-in-alt",
                        label = "Boss Menu",
                        job = job,
                        canInteract = function() return PlayerJob.isboss or PlayerJob.ismanager or QBCore.Functions.HasDivision('hc') or QBCore.Functions.HasDivision('hr') end,
                    },
                },
                distance = 2.5
            })
        end
    end
end)
