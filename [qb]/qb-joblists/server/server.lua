QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add("joblists", "", {}, true, function(source, args)
    src=source
    listcount(src)
end,'admin')

RegisterNetEvent('qb-joblist:server:showmenu', function()
    src=source
    listcount(src)
end)

function listcount(src)
  local players=  QBCore.Functions.GetPlayer(src)
    local playes={}
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local tPlayer = QBCore.Functions.GetPlayer(v)
       
        if tPlayer and config.jobs[tPlayer.PlayerData.job.name] then
            local callsign="No CallSign"
            if tPlayer.PlayerData.metadata["callsign"] then
                callsign=tPlayer.PlayerData.metadata["callsign"]
            end
            playes[#playes+1]={playername=tPlayer.PlayerData.charinfo.firstname..' '..tPlayer.PlayerData.charinfo.lastname,callsign=callsign,duty=tPlayer.PlayerData.job.onduty,jobname=tPlayer.PlayerData.job.name}
        end
    end

    local jobnames={}
    for k, v in pairs(config.jobs) do
        jobnames[k]={jobname=k,jname=QBCore.Shared.Jobs[k].label}
    end
   
    TriggerClientEvent('qb-joblist:client:show', src,playes,jobnames,players.PlayerData.job.name)   
end


