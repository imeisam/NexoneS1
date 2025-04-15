if GetResourceState('qb-core') ~= 'started' then return end

QBCore = exports['qb-core']:GetCoreObject()

function ServerCallback(name, cb, ...)
    QBCore.Functions.TriggerCallback(name, cb,  ...)
end

function ShowNotification(text)
	QBCore.Functions.Notify(text)
end

function ShowHelpNotification(text)
    AddTextEntry('qbHelpNotification', text)
    BeginTextCommandDisplayHelp('qbHelpNotification')
    EndTextCommandDisplayHelp(0, false, false, -1)
end

function GetPlayersInArea(coords, maxDistance)
    return QBCore.Functions.GetPlayersFromCoords(coords, maxDistance)
end

function CanAccessGroup(data)
    if not data then return true end
    local pdata = QBCore.Functions.GetPlayerData()
    for k,v in pairs(data) do 
        if (pdata.job.name == k and pdata.job.grade.level >= v) then return true end
    end
    return false
end 

RegisterNetEvent(GetCurrentResourceName()..":showNotification", function(text)
    ShowNotification(text)
end)

-- Interact
exports['qb-interact']:AddInteraction({
    coords = vector3(612.71893310547, -5.9660043716431, 82.759971618652),
    distance = 3.0, -- optional
    interactDst = 1.5, -- optional
    id = 'policedoc1', -- needed for removing interactions
    name = 'policedoc1', -- optional
    options = {
        {
            label = 'Create Document',
            event = "",
        },
        
    }
})