local QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = {}
local onDuty = false
local injob = false
local whichJob = nil

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        onDuty = PlayerJob.onduty
        for k, v in ipairs(Config.BusinessZone) do
            if v.label == PlayerJob.name then
                if (injob and whichJob == PlayerJob.name and not PlayerJob.onduty) or (not injob and PlayerJob.onduty) then
                    TriggerServerEvent("QBCore:ToggleDuty")
                end
                break
            end
        end
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = PlayerJob.onduty
    for k, v in ipairs(Config.BusinessZone) do
        if v.label == PlayerJob.name then
            if not injob and onDuty then
                TriggerServerEvent("QBCore:ToggleDuty")
            end
            break
        end
    end
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

CreateThread(function()
    for k, v in ipairs(Config.BusinessZone) do
        local JobLocation = PolyZone:Create(v.zones, { name = v.label..'FoodSystemDuty', debugPoly = false })
        JobLocation:onPlayerInOut(function(isPointInside)
            if isPointInside then
                injob = true
                whichJob = v.label
                if PlayerJob.name and PlayerJob.name == whichJob then
                    if not onDuty then TriggerServerEvent("QBCore:ToggleDuty") end
                end
            else
                injob = false
                whichJob = nil
                if PlayerJob.name == v.label then
                    if onDuty then TriggerServerEvent("QBCore:ToggleDuty") end
                end
            end
        end)
    end
end)