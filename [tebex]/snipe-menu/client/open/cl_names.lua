local players = {}
local Tags = {}

function DrawText3D(x, y, z, text)
	SetTextScale(0.8, 0.8)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 0, 0, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    ClearDrawOrigin()
end

local function StartNamesThread()
    CreateThread(function()
        while toggleNameThread do
            local myCoords = GetEntityCoords(PlayerPedId())
            for k, v in pairs(players) do
                if v.id ~= GetPlayerServerId(PlayerId()) then
                    local id = GetPlayerFromServerId(v.id)
                    if NetworkIsPlayerActive(id) then
                        coords = GetEntityCoords(GetPlayerPed(id))
                    else
                        coords = v.coords
                    end
                    if coords == nil then
                        coords = v.coords
                    end
                    if #(myCoords - v.coords) <= 500.0 then
                        DrawText3D(coords.x, coords.y, coords.z + 1.0, "["..v.id.."] "..v.name)
                        DrawLine(myCoords.x, myCoords.y, myCoords.z + 0.7, coords.x, coords.y, coords.z , Config.LineColor["r"], Config.LineColor["g"], Config.LineColor["b"] , 255)
                    end
                end
            end
            Wait(3)
        end
    end)
end

local function DeleteTags()
    for k,v in pairs(Tags) do
        SetMpGamerTagVisibility(Tags[k], 0, false)
        SetMpGamerTagVisibility(Tags[k], 2, false)
        SetMpGamerTagVisibility(Tags[k], 4, false)
        SetMpGamerTagVisibility(Tags[k], 6, false)
        RemoveMpGamerTag(Tags[k])
        Tags[k] = nil
    end
end

local function UpdateTags()
    for k, v in pairs(GetActivePlayers()) do
        local ped = GetPlayerPed(v)
        local id = GetPlayerServerId(v)
        if toggleNameThread and DoesEntityExist(ped) and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(ped)) < 30.0 then
            Tags[v] = CreateMpGamerTag(ped, "", false, false, '', 0)
            local pname = Player(id).state['icname'] or 'None'
            local name = id.." | "..pname.." ("..GetPlayerName(v)..")"
            SetMpGamerTagName(Tags[v], name)
            SetMpGamerTagAlpha(Tags[v], 0, 255)
            SetMpGamerTagAlpha(Tags[v], 2, 255)
            SetMpGamerTagAlpha(Tags[v], 4, 255)
            SetMpGamerTagAlpha(Tags[v], 6, 255)
            SetMpGamerTagHealthBarColour(Tags[v], 25)
            SetMpGamerTagVisibility(Tags[v], 0, true)
            SetMpGamerTagVisibility(Tags[v], 2, true)
            if NetworkIsPlayerTalking(v) then
                SetMpGamerTagVisibility(Tags[v], 4, true)
            else
                SetMpGamerTagVisibility(Tags[v], 4, false)
            end
            if GetPlayerInvincible(v) then
                SetMpGamerTagVisibility(Tags[v], 6, true)
            else
                SetMpGamerTagVisibility(Tags[v], 6, false)
            end
        end
    end
end

function ToggleNames()
    if Config.NewNamesLogic then
        if not toggleNameThread then
            toggleNameThread = true
            StartNamesThread()
            while toggleNameThread do
                local p = promise.new()
                TriggerCallback("snipe-menu:server:getBlipsInfo", function(result)
                    p:resolve(result)
                end)
                players = Citizen.Await(p)
                Wait(2000)
            end
        else
            toggleNameThread = false
        end
    else
        if toggleNameThread then
            toggleNameThread = false
            DeleteTags()
        else
            toggleNameThread = true
            CreateThread(function()
                while toggleNameThread do
                    UpdateTags()
                    Wait(750)
                end
            end)
        end
    end
end

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == "snipe-menu" then
        toggleNameThread = false
        DeleteTags()
    end
end)