QBCore = exports['qb-core']:GetCoreObject()
PlayerData = QBCore.Functions.GetPlayerData()
local inRadialMenu = false
local jobIndex = nil
local RepairMenu = nil

local DynamicMenuItems = {}
local FinalMenuItems = {}
-- Functions


RegisterNetEvent("isGarbage")
AddEventHandler("isGarbage", function(bool)
    if bool then
        exports['qb-radialmenu']:AddOption({
            id = 'SanitaireVehicles',
            title = 'Vehicle List',
            icon = '#truckicon',
            functiontype = 'client',
            functionName = 'zat-garbagejob:client:VehicleList',
            shouldClose = true
        }, 'SanitaireVehicles')
        exports['qb-radialmenu']:AddOption({
            id = 'SanitaireOpenMenu',
            title = 'Groups',
            icon = '#persongroup',
            functiontype = 'client',
            functionName = 'zat-groups:client:OpenUi',
            shouldClose = true
        }, 'SanitaireOpenMenu')
        exports['qb-radialmenu']:AddOption({
            id = 'SanitaireGenerate',
            title = 'New Area',
            icon = '#fablip',
            functiontype = 'client',
            functionName = 'zat-garbagejob:client:GenerateNewLocation',
            shouldClose = true
        }, 'SanitaireGenerate')
    else
        exports['qb-radialmenu']:RemoveOption('SanitaireVehicles')
        exports['qb-radialmenu']:RemoveOption('SanitaireOpenMenu')
        exports['qb-radialmenu']:RemoveOption('SanitaireGenerate')
    end
end)

local function deepcopy(orig)
    local orig_functiontype = type(orig)
    local copy
    if orig_functiontype == 'table' then
        if not orig.canOpen or orig.canOpen() then
            local toRemove = {}
            copy = {}
            for orig_key, orig_value in next, orig, nil do
                if type(orig_value) == 'table' then
                    if not orig_value.canOpen or orig_value.canOpen() then
                        copy[deepcopy(orig_key)] = deepcopy(orig_value)
                    else
                        toRemove[orig_key] = true
                    end
                else
                    copy[deepcopy(orig_key)] = deepcopy(orig_value)
                end
            end
            for i=1, #toRemove do table.remove(copy, i) end
            if copy and next(copy) then setmetatable(copy, deepcopy(getmetatable(orig))) end
        end
    elseif orig_type ~= 'function' then
        copy = orig
    end
    return copy
end

local function AddOption(data, id)
    local menuID = id ~= nil and id or (#DynamicMenuItems + 1)
    DynamicMenuItems[menuID] = deepcopy(data)
    return menuID
end

local function RemoveOption(id)
    DynamicMenuItems[id] = nil
end

local function SetupJobMenu()
    local JobMenu = {
        id = 'jobinteractions',
        title = 'Job',
        icon = '#job',
        items = {}
    }
    if Config.JobInteractions[PlayerData.job.name] and next(Config.JobInteractions[PlayerData.job.name]) then
        JobMenu.items = Config.JobInteractions[PlayerData.job.name]
    end
    if Config.JobInteractions[PlayerData.job.name] and not PlayerData.job.onduty then
        if jobIndex then
            RemoveOption(jobIndex)
            jobIndex = nil
        end
        if extraid then
            RemoveOption(extraid)
            extraid = nil
        end
    else
        if #JobMenu.items == 0 then
            if jobIndex   then
                RemoveOption(jobIndex)
                jobIndex = nil
            end
            if extraid   then
                RemoveOption(extraid)
                extraid = nil
            end
        else
            jobIndex = AddOption(JobMenu, jobIndex)
        end
    end
end

local function SetupSubItems()
    TriggerEvent('qb-radialmenu:client:onRadialmenuOpen')
    SetupJobMenu()
end

local function IsPolice()
    return (PlayerData.job.name == "police" or PlayerData.job.name == "justice")
end

local function IsEMS()
    return (PlayerData.job.name == "ambulance")
end

local function IsDowned()
    return Player(GetPlayerServerId(PlayerId())).state['isDead']
end

local function SetupRadialMenu()
    FinalMenuItems = {}
    if IsDowned() then
        if IsPolice() then
            FinalMenuItems = {
                {
                    id = 'emergencybutton',
                    title = Lang:t("options.officerdownA_button"),
                    icon = '#panic',
                    functiontype = 'client',
                    functionName = 'qb-dispatch:client:officerdown',
                    shouldClose = true,
                },
                {
                    id = 'emergencybutton2',
                    title = Lang:t("options.officerdownB_button"),
                    icon = '#panic',
                    functiontype = 'client',
                    functionName = 'qb-dispatch:client:officerdown2',
                    shouldClose = true,
                },
            }
        elseif IsEMS() then
            FinalMenuItems = {
                {
                    id = 'emergencybutton',
                    title = 'EMS Down',
                    icon = '#panic',
                    functiontype = 'client',
                    functionName = 'qb-dispatch:client:emsdown',
                    shouldClose = true,
                },
            }
        end
    else
        SetupSubItems()
        FinalMenuItems = deepcopy(Config.MenuItems)
        for _, v in pairs(DynamicMenuItems) do
            FinalMenuItems[#FinalMenuItems+1] = v
        end
    end
end

local function setRadialState()
    SetupRadialMenu()
    SetNuiFocus(true, true)
    SendNUIMessage({
        state = "show",
        data = FinalMenuItems,
        resourceName = GetCurrentResourceName(),
        menuType = 'default', --(IsPedInAnyVehicle(PlayerPedId(), false) and 'small' or 'default'),
        menuKeyBind = 'F1'
    })
    inRadialMenu = true
end



AddEventHandler('onKeyDown', function(key)
    if key == 'f1' then
        if ((IsDowned() and (IsPolice() or IsEMS())) or not IsDowned()) and not Player(GetPlayerServerId(PlayerId())).state['isCuffed'] and not IsPauseMenuActive() and not inRadialMenu then
            setRadialState()
            SetCursorLocation(0.5, 0.5)
        end
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    QBCore.Functions.TriggerCallback('qb-radialmenu:server:hasadminperm', function(res)
        if res then
            exports['qb-radialmenu']:AddOption({
                id = 'adminmenu',
                title = 'Admin',
                icon = '#usershield',
                items = {
                    {
                        id = 'adminmenu',
                        title = 'Admin Menu',
                        icon = '#usershield',
                        functiontype = 'client',
                        functionName = 'snipe-menu:client:openmenu',
                        shouldClose = true
                    },
                    {
                        id = 'playermenu',
                        title = 'Players Panishment',
                        icon = '#usershield',
                        functiontype = 'client',
                        functionName = 'qb-players:client:showmenu',
                        shouldClose = true
                    },
                }
            }, 'admin')
        end
    end)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)

RegisterNetEvent('qb-radialmenu:client:force:close')
AddEventHandler('qb-radialmenu:client:force:close', function()
    SetNuiFocus(false, false)
    SendNUIMessage({
        state = 'destroy'
    })
    Wait(1000)
    inRadialMenu = false
end)

RegisterNUICallback('closemenu', function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({
        state = 'destroy'
    })
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
    cb('ok')
    inRadialMenu = false
end)

RegisterNUICallback('triggerAction', function(data, cb)
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
    if data.shouldClose then
        TriggerEvent("qb-radialmenu:client:force:close")
    end
    if data.type == 'client' then
        TriggerEvent(data.action, data.parameters)
    elseif data.type == 'server' then
        TriggerServerEvent(data.action, data.parameters)
    elseif data.type == 'command' then
        ExecuteCommand(data.action)
    end
    cb('ok')
end)

exports('AddOption', AddOption)
exports('RemoveOption', RemoveOption)