local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("nxo-foodjob:server:addfood", function(job,data,type)
    src=source
    local mat={}
    for k, v in pairs(Config.job[job].material[type]) do
        if data[k]=='true' then
            mat[#mat+1]=k
        end
    end
    MySQL.Sync.fetchAll('Insert jobfood (name,material,image,animations,jobname,type,makeanimation)values(?,?,?,?,?,?,?)', {data.name,json.encode(mat),data.image,data.animation,job,type,data.makeanimation})
    TriggerClientEvent('QBCore:Notify', src, 'Save Successfull', 'success')
end)

QBCore.Functions.CreateCallback('nxo-foodjob:server:getdata', function(source, cb, job,type)
    local sqlresult = MySQL.Sync.fetchAll('SELECT * FROM jobfood where jobname=? and type=?', {job,type})
    cb(sqlresult)
end)


RegisterNetEvent("nxo-foodjob:server:makefood", function(data)
  src=source
  local Player = QBCore.Functions.GetPlayer(src)
    local hasitem=true
    local alcoholdooz=0
  for l,m in pairs(json.decode(data.data.material)) do
    if Player.Functions.GetItemByName(m) == nil  then
          hasitem=false
    end
   end
   if hasitem then
    local hunger=0
    local thirst=0
    for l,m in pairs(json.decode(data.data.material)) do
        if m=="alcohol" then
            alcoholdooz=2
        end
        if Config.job[data.job].material[data.type][m].hunger then
            hunger=hunger+Config.job[data.job].material[data.type][m].hunger
        end
        if Config.job[data.job].material[data.type][m].thirst then
            thirst=thirst+Config.job[data.job].material[data.type][m].thirst
        end
            Player.Functions.RemoveItem(m, 1)
    end
    local info={}
    info.image=data.data.image
    info.name=data.data.name
    info.hunger=hunger
    info.thirst=thirst
    info.job=data.job
    info.type=data.type
    info.animation=data.data.animations
    info.alcoholdooz=alcoholdooz
    Player.Functions.AddItem('jobfood',1,nil,info)
    local dataitem=QBCore.Shared.Items['jobfood']
    dataitem.label=info.name
    TriggerClientEvent("inventory:client:ItemBox", src,dataitem, "add", 1,info.image)
    else
        TriggerClientEvent('QBCore:Notify', src, 'No Enough Item Need', 'error') 
   end
end)
RegisterNetEvent("nxo-foodjob:server:removeitem", function(id)
    src=source
    MySQL.Sync.fetchAll('delete from jobfood where id=?', {id})
    TriggerClientEvent('QBCore:Notify', src, 'Remove Successfull', 'success')
end)

QBCore.Functions.CreateUseableItem("jobfood", function(source, item)
	TriggerClientEvent("nxo-foodjob:client:useitem", source, item)
end)