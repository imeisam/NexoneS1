local PlayerJob = {}
local onDuty = false
local onLoaded = false

-- Functions

 function GetClosestPlayer()
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())
    for i=1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = #(pos - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
	end
	return closestPlayer, closestDistance
end

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    if PlayerJob.name == 'ambulance' then
        onDuty = PlayerJob.onduty
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    local ped = PlayerPedId()
    local player = PlayerId()
    CreateThread(function()
        SetEntityMaxHealth(ped, 200)
        SetPlayerHealthRechargeMultiplier(player, 0.0)
        SetPlayerHealthRechargeLimit(player, 0.0)
    end)
    CreateThread(function()
        Wait(7000)
        local PlayerData = QBCore.Functions.GetPlayerData()
        PlayerJob = PlayerData.job
        onDuty = PlayerData.job.onduty
        onLoaded = true
        SetPedArmour(PlayerPedId(), PlayerData.metadata["armor"])
        SetEntityHealth(PlayerPedId(), PlayerData.metadata["health"] + 100)
        CreateThread(function()
            while onLoaded do
                Wait(10000)
                TriggerServerEvent('hospital:server:updateHpArmor', GetEntityHealth(PlayerPedId()) - 100, GetPedArmour(PlayerPedId()))
            end
        end)
        if PlayerData.metadata["isdead"] then
            TriggerEvent('hospital:client:doKillStand', false)
        elseif PlayerData.metadata["inlaststand"] then
            TriggerEvent('hospital:client:doKillStand', true)
        end
    end)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    onLoaded = false
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

RegisterNetEvent('qb-ambulancejob:stashShared', function()
    if onDuty then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "ambulancestash", {maxweight = 5000000, slots = 1000})
    else
        QBCore.Functions.Notify("You are Not On Duty...", "error")
    end
end)


RegisterNetEvent('qb-ambulancejob:stash', function()
    if onDuty then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "ambulancestash_"..QBCore.Functions.GetPlayerData().citizenid, {maxweight = 500000, slots = 100})
    else
        QBCore.Functions.Notify("You are Not On Duty...", "error")
    end
end)

RegisterNetEvent('qb-ambulancejob:armory', function()
    if onDuty then
        TriggerEvent("nxo-shop:client:openshopname","mdarmory")
    else
        QBCore.Functions.Notify("You are Not On Duty...", "error")
    end
end)

RegisterNetEvent('EMSToggle:Duty', function()
    TriggerServerEvent("QBCore:ToggleDuty")
end)

RegisterNetEvent('qb-ambulancejob:shop', function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "pharmacy", Config.Shop)
end)


RegisterNetEvent('qb-ambulancejob:client:activecheckin', function(data)
   local typemd= data.args.type
   if  QBCore.Functions.GetPlayerData().job.grade.level >=2 then
    TriggerServerEvent("qb-ambulancejob:server:activecheckin",typemd)
   else
    QBCore.Functions.Notify("You are Not Allow...", "error")
   end
   
end)
AddEventHandler("hospital:target:getDNA", function()
   
        local player, distance = GetClosestPlayer()
        if player ~= -1 and distance < 2.5 then
            local playerId = GetPlayerServerId(player)
            ExecuteCommand('e mechanic2')
            QBCore.Functions.Progressbar("get_dna", "Geting DNA test", 20000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function()  --Done
                ExecuteCommand('e c')
                TriggerServerEvent("ambulance:target:getDNA", playerId)
            end, function() -- Cancel
                ExecuteCommand('e c')
                QBCore.Functions.Notify("Canceled..", "error")
            end)
        else
            QBCore.Functions.Notify('No One Nearby!', "error")
        end
   
end)

CreateThread(function()

    for k, v in pairs(Config.Locations["armory"]) do
        exports['qb-interact']:AddInteraction({
            coords =vector3(v.x, v.y, v.z),
            distance = 5.0,
            interactDst = 1.2, 
            id = "armoryMD_"..k,
            name ="armoryMD_"..k,
            groups = {
                ['ambulance'] =0,
            },
            options = {
                 {
                    id ="armoryMD_"..k,
                    label = "Armory",
                    event = "qb-ambulancejob:armory",
                    args = {}
                },
            }
        })
    end

    for k, v in pairs(Config.Locations["duty"]) do
        local op={}

        op[#op+1]= {
                id ="dutyMD_"..k,
                label = "Sign In/Off duty",
                event = "EMSToggle:Duty",
                args = {}
            }

            op[#op+1]= {
                id = "activechecking"..k,
                label = "Active/Deactive Auto Checkin ("..v.type..") Station",
                event ="qb-ambulancejob:client:activecheckin",
                args = {type=v.type},
              
            }
       
        if v.activeother then
            for l,m in pairs(v.activeother) do
                op[#op+1]= {
                        id = "activeotherchecking"..k..m,
                        label = "Active/Deactive Auto Checkin ("..m..") Station",
                        event ="qb-ambulancejob:client:activecheckin",
                        args = {type=m},
                    }
            end
        end

        exports['qb-interact']:AddInteraction({
            coords =vector3(v.coord.x, v.coord.y, v.coord.z),
            distance = 5.0,
            interactDst = 1.2, 
            id = "dutyMD_"..k,
            name ="dutyMD_"..k,
            groups = {
                ['ambulance'] =0,
            },
            options =op
        })
    end
    for k, v in pairs(Config.Locations["stash"]) do
        exports['qb-interact']:AddInteraction({
            coords =vector3(v.x, v.y, v.z),
            distance = 5.0,
            interactDst = 1.2,
            groups = {
                ['ambulance'] = 0, 
            },
            id ="ambulancestash"..k,
            name ="ambulancestash"..k,
            options = {
                {
                    id ="ambulancestash"..k,
                    label =  "Personal Stash",
                    event = "qb-ambulancejob:stash",
                    args = {}
                },
                 {
                    id ="ambulancestashshare"..k,
                    label ="Shared Stash",
                    event =  "qb-ambulancejob:stashShared",
                    args = {}
                },
            }
        })
    end
    for k, v in pairs(Config.Locations["clothes"]) do

        exports['qb-interact']:AddInteraction({
            coords =vector3(v.x, v.y, v.z),
            distance = 1.2, -- optional
            interactDst = 1.2, -- optional
            groups = {
                ['ambulance'] = 0, -- Jobname | Job grade
            },
            id = "MDClothes_"..k,
            name = "MDClothes_"..k,
            options = {
                {
                    id = "MDClothes_"..k,
                    label = "Outfit",
                    event = "lvs_clothing:client:openOutfit",
                    args = {}
                },
                 {
                    id = "MDClothes_"..k,
                    label = "EMS Outfit",
                    event = "qb-smallresources:client:joboutfits",
                    args = {}
                },
                {
                    id = "MDClothes_"..k,
                    label = "Change Clothes",
                    event = "lvs_clothing:client:OpenClothingShop",
                    args = {}
                },
            }
        })

       
    end

    for k, v in pairs(Config.Locations["dna"]) do

        exports['qb-interact']:AddInteraction({
            coords =vector3(v.x, v.y, v.z),
            distance = 3.0,
            interactDst = 1.2,
            groups = {
                ['ambulance'] = 0, 
            },
            id ="HospitalDNA_"..k,
            name ="HospitalDNA_"..k,
            options = {
                 {
                    id ="HospitalDNA_"..k,
                    label = "Get DNA Test",
                    event ="hospital:target:getDNA",
                    args = {}
                },
            }
        })

    end
end)
