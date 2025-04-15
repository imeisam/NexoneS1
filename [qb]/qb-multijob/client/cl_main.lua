local QBCore = exports['qb-core']:GetCoreObject()

local function GetJobs()
    local p = promise.new()
    QBCore.Functions.TriggerCallback('qb-multijob:getJobs', function(result)
        p:resolve(result)
    end)
    return Citizen.Await(p)
end

local function OpenUI()
    local job = QBCore.Functions.GetPlayerData().job
    SetNuiFocus(true,true)
    SendNUIMessage({
        action = 'sendjobs',
        activeJob = job["name"],
        onDuty = job["onduty"],
        jobs = GetJobs(),
        side = Config.Side,
    })
end

RegisterNUICallback('selectjob', function(data, cb)
    TriggerServerEvent("qb-multijob:changeJob", data["name"], data["grade"])
    cb({onDuty = false})
end)

RegisterNUICallback('closemenu', function(data, cb)
    cb({})
    SetNuiFocus(false,false)
end)

RegisterNUICallback('removejob', function(data, cb)
    TriggerServerEvent("qb-multijob:removeJob", data["name"])
    local jobs = GetJobs()
    jobs[data["name"]] = nil
    cb(jobs)
end)

RegisterNUICallback('toggleduty', function(data, cb)
    cb({})

    TriggerEvent("QBCore:Notify", 'Not allowed to use this station for clock-in.', 'error')
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    SendNUIMessage({
        action = 'updatejob',
        name = JobInfo["name"],
        label = JobInfo["label"],
        onDuty = JobInfo["onduty"],
        gradeLabel = JobInfo["grade"].name,
        grade = JobInfo["grade"].level,
        salary = JobInfo["salary"],
        isWhitelist = false,
        description = "",
        icon = Config.FontAwesomeIcons[JobInfo["name"]] or "",
    })
end)

AddEventHandler('onKeyDown', function(key)
	if key == 'j' then
		OpenUI()
	end
end)