local QBCore = exports['qb-core']:GetCoreObject()

local function getlastnewsid()
	local result = MySQL.query.await('SELECT * FROM newspaper ORDER BY id DESC LIMIT 1', {})
	if result and result[1] then
		return result[1].ID
	else
		return 0
	end
end


function addmoneybossaccount(jobname,price)
    exports["snipe-banking"]:AddMoneyToAccount(jobname, price,"Buy Newspaper")
end

RegisterNetEvent('qb-samnewspaper:server:buy', function()
	local src=source
	
	local Player = QBCore.Functions.GetPlayer(src)
	if not Player then return false end

	if not Player.Functions.RemoveMoney("bank", Config.newspaperprice) then return TriggerClientEvent('QBCore:Notify', src, ('You don\'t have enough money on you, you need %s bank'):format(5), 'error') end
	addmoneybossaccount('lsnews',Config.newspaperprice)
	local newsid=getlastnewsid()
	local info = {}
	info.newsid=newsid
	if not Player.Functions.AddItem('newspaper', 1, nil,info) then return end
	  TriggerClientEvent('inventory:client:ItemBox',src, QBCore.Shared.Items["newspaper"],"add")
end)

RegisterNetEvent('qb-samnewspaper:server:savenewspaper', function(imageaddress,addtitle,addRightarticle,addleftarticle)
	local src=source
	local Player = QBCore.Functions.GetPlayer(src)
	
	if not Player then return false end
	MySQL.Async.execute("insert newspaper (reporter,articleTitle1,articleTitle2,articleDesc1,articleDesc2,arrest1,arrest2,arrest3)values(?,?,?,?,?,?,?,?)", {GetPlayerIdentifiers(src)[1],imageaddress,addtitle,addleftarticle,addRightarticle,'','',''})
	TriggerClientEvent("QBCore:Notify", src, "News Saved", "success")
end)

QBCore.Functions.CreateUseableItem("newspaper", function(source, item,data)
		local src = source
	
		local Player = QBCore.Functions.GetPlayer(src)
		local result = MySQL.query.await('SELECT * FROM newspaper WHERE id = ?', {Player.PlayerData.items[item.slot].info.newsid})
		if result and result[1] then
		   TriggerClientEvent("qb-samnewspaper:client:newspaperon",source,result[1])
		end
end)

RegisterCommand('newsclose', function(source)
	TriggerClientEvent("qb-samnewspaper:client:close",source)
end)

RegisterCommand(Config.NewsCommand, function(source)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.PlayerData.job.name ~= "lsnews" then return false end
	TriggerClientEvent("qb-samnewspaper:client:addnews",source)
end)

local function checkjail()
	local res={}
	local result = MySQL.query.await('SELECT * FROM newspaper ORDER BY id DESC LIMIT 1', {})
	if result and result[1] then
		res.articleTitle1=result[1].articleTitle1 
		res.articleTitle2=result[1].articleTitle2
		res.articleDesc1=result[1].articleDesc1
		res.articleDesc2=result[1].articleDesc2
		res.arrest1=result[1].arrest1
		res.arrest2=result[1].arrest2 
		res.arrest3=result[1].arrest3 
		if res.arrest1 =='' then
			res.result=true
		elseif  res.arrest2 =='' then
			res.arrest2=res.arrest1
			res.arrest1=''
			res.result=true
		elseif  res.arrest3 =='' then
			res.arrest3=res.arrest2
			res.arrest2=res.arrest1
			res.arrest1=''
			res.result=true
		else
			res.arrest3=res.arrest2
			res.arrest2=res.arrest1
			res.result=true
			res.arrest1=''
		end
	else
		res.result=false
		res.articleTitle1=""
		res.articleTitle2=""
		res.articleDesc1=""
		res.articleDesc2=""
		res.arrest1=""
		res.arrest2=""
		res.arrest3=""
	end
	return res
end
RegisterNetEvent("newspaper:jail")
AddEventHandler("newspaper:jail", function(firstname,lastname,jailTime)
local personname = firstname.." "..lastname
local args = personname .. " was sent to Prison for " .. jailTime .. " Months."
local reschech=checkjail()
if reschech.result then
	MySQL.Async.execute("insert newspaper(reporter,articleTitle1,articleTitle2,articleDesc1,articleDesc2,arrest1,arrest2,arrest3)values(?,?,?,?,?,?,?,?)", {"",reschech.articleTitle1,reschech.articleTitle2,reschech.articleDesc1,reschech.articleDesc2,args,reschech.arrest2,reschech.arrest3})
else
	MySQL.Async.execute("insert newspaper(reporter,articleTitle1,articleTitle2,articleDesc1,articleDesc2,arrest1,arrest2,arrest3)values(?,?,?,?,?,?,?,?)", {"",reschech.articleTitle1,reschech.articleTitle2,reschech.articleDesc1,reschech.articleDesc2,args,"",""})
end
	

end)