local QBCore = exports['qb-core']:GetCoreObject()

local function GetJobs(citizenid)
    local p = promise.new()
    MySQL.Async.fetchAll("SELECT jobdata FROM multijobs WHERE citizenid = @citizenid",{
        ["@citizenid"] = citizenid
    }, function(jobs)
        if jobs[1] and jobs ~= "[]" then
            jobs = json.decode(jobs[1].jobdata)
            local changed = false
            for k,v in pairs(jobs) do
                if not QBCore.Shared.Jobs[k] or not QBCore.Shared.Jobs[k].grades[tostring(v.grade)] then
                    jobs[k] = nil
                    changed = true
                end
            end
            if changed then
                MySQL.insert('INSERT INTO multijobs (citizenid, jobdata) VALUES (:citizenid, :jobdata) ON DUPLICATE KEY UPDATE jobdata = :jobdata', {
                    citizenid = citizenid,
                    jobdata = json.encode(jobs),
                })
            end
        else
            local Player = QBCore.Functions.GetPlayerByCitizenId(citizenid)
            if not Config.IgnoredJobs[Player.PlayerData.job.name] then
                jobs[Player.PlayerData.job.name] = {grade = Player.PlayerData.job.grade.level, divisions = Player.PlayerData.job.divs}
                MySQL.insert('INSERT INTO multijobs (citizenid, jobdata) VALUES (:citizenid, :jobdata) ON DUPLICATE KEY UPDATE jobdata = :jobdata', {
                    citizenid = citizenid,
                    jobdata = json.encode(jobs),
                })
            end
        end
        p:resolve(jobs)
    end)
    return Citizen.Await(p)
end
    
local function AddJob(citizenid, job, grade, divisions)
    local jobs = GetJobs(citizenid)
    for ignored in pairs(Config.IgnoredJobs) do
        if jobs[ignored] then
            jobs[ignored] = nil
        end
    end
    jobs[job] = {grade = grade, divisions = divisions}
    MySQL.insert('INSERT INTO multijobs (citizenid, jobdata) VALUES (:citizenid, :jobdata) ON DUPLICATE KEY UPDATE jobdata = :jobdata', {
        citizenid = citizenid,
        jobdata = json.encode(jobs),
    })
end

local function RemoveJob(citizenid, job)
    local jobs = GetJobs(citizenid)
    jobs[job] = nil
    local Player = QBCore.Functions.GetPlayerByCitizenId(citizenid)
    if Player then
        Player.Functions.SetJob("unemployed", 0, nil, true)
    else
        local job = {
            name = "unemployed",
            grade = {
                level = 0
            }
        }
        MySQL.update('UPDATE players SET job = ? WHERE citizenid = ?', {json.encode(job), citizenid})
    end
    MySQL.insert('INSERT INTO multijobs (citizenid, jobdata) VALUES (:citizenid, :jobdata) ON DUPLICATE KEY UPDATE jobdata = :jobdata', {
        citizenid = citizenid,
        jobdata = json.encode(jobs),
    })
end

QBCore.Functions.CreateCallback("qb-multijob:getJobs",function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local jobs = GetJobs(Player.PlayerData.citizenid)
    local multijobs = {}
    local whitelistedjobs = {}
    local civjobs = {}
    local active = {}
    local getjobs = {}
    local Players = QBCore.Functions.GetPlayers()
    for i = 1, #Players, 1 do
        local xPlayer = QBCore.Functions.GetPlayer(Players[i])
        active[xPlayer.PlayerData.job.name] = 0
        if active[xPlayer.PlayerData.job.name] and xPlayer.PlayerData.job.onduty then
            active[xPlayer.PlayerData.job.name] = active[xPlayer.PlayerData.job.name] + 1
        end
    end
    for job, data in pairs(jobs) do
        local online = active[job]
        if online == nil then
            online = 0
        end
        getjobs = {
            name = job,
            grade = data.grade,
            icon = Config.FontAwesomeIcons[job],
            label = QBCore.Shared.Jobs[job].label,
            gradeLabel = QBCore.Shared.Jobs[job].grades[tostring(data.grade)].name,
            salary = QBCore.Shared.Jobs[job].grades[tostring(data.grade)].salary or 0,
            active = online,
        }
        civjobs[#civjobs+1] = getjobs
    end
    multijobs = {
        whitelist = whitelistedjobs,
        civilian = civjobs,
    }
    cb(multijobs)
end)

RegisterNetEvent("qb-multijob:changeJob",function(cjob, cgrade)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    if cjob == "unemployed" and cgrade == 0 then
        Player.Functions.SetJob(cjob, cgrade)
        return
    end
    local jobs = GetJobs(Player.PlayerData.citizenid)
    for job, data in pairs(jobs) do
        if cjob == job and cgrade == data.grade then
            Player.Functions.SetJob(job, data.grade, data.divisions)
        end
    end
end)

RegisterNetEvent("qb-multijob:removeJob",function(job)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    RemoveJob(Player.PlayerData.citizenid, job)
end)

-- QBCORE EVENTS

AddEventHandler('qb-multijob:server:removeJob', function(targetCitizenId, name)
    RemoveJob(targetCitizenId, name)
end)

AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
    GetJobs(Player.PlayerData.citizenid)
end)

RegisterNetEvent('QBCore:Server:OnJobUpdate', function(source, setjob, dontUpdate)
    if dontUpdate then return end
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    local jobs = GetJobs(Player.PlayerData.citizenid)
    local amount = 0
    for k,v in pairs(jobs) do
        if not Config.NoMax[k] then
            amount = amount + 1
        end
    end
    local maxJobs = Config.MaxJobs
    if QBCore.Functions.HasPermission(source, "admin") then
        maxJobs = math.huge
    end
    local foundOldJob = jobs[setjob.name]
    if amount < maxJobs or foundOldJob or Config.NoMax[setjob.name] then
        if not foundOldJob or foundOldJob ~= setjob.grade.level then
            AddJob(Player.PlayerData.citizenid, setjob.name, setjob.grade.level, setjob.divs)
        end
    end
end)