local display, toggleDisplay, paperon, param = false, true, true, ""
local PlayerProps = {}
exports['qb-target']:AddTargetModel(Config.targetobject, {
    options = {
        {
            type = "client",
            event = "qb-samnewspaper:buy",
            icon = Config.targeticon,
            label = Config.targettext,
        },
    },
    distance = 1.2
})

local function SharedRequestAnimDict(animDict, cb)
	if not HasAnimDictLoaded(animDict) then
		RequestAnimDict(animDict)

		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(1)
		end
	end
	if cb ~= nil then
		cb()
	end
end
local function AnimationActions(type)
    if type == "start" then
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        if DoesEntityExist(ped) and not IsEntityDead(ped) then 
            local x,y,z = table.unpack(pedCoords)
            local one = CreateObject(GetHashKey('ng_proc_paper_news_rag'), x, y, z+0.2,  true,  true, true)
            PlayerProps[#PlayerProps+1] = one
            AttachEntityToEntity(one, ped, GetPedBoneIndex(ped, 60309),  0.1760, -0.00070,0.0200,   99.8306,  3.2841, -4.7185, true, true, false, true, 1, true)
            SharedRequestAnimDict("amb@world_human_clipboard@male@idle_a", function()
                TaskPlayAnim(ped, "amb@world_human_clipboard@male@idle_a", "idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )  
            end)
        end
    elseif type == "end" then
        for k,v in pairs(PlayerProps) do
            DeleteEntity(v)
        end
        Wait(100)
        PlayerProps = {}
        ClearPedTasks(PlayerPedId())
    end
end

RegisterNetEvent('qb-samnewspaper:buy')
AddEventHandler('qb-samnewspaper:buy',function(source,data)
    TriggerServerEvent("qb-samnewspaper:server:buy", source)
end)


    RegisterNUICallback("close", function()
        TriggerScreenblurFadeOut(1000)
        SetNuiFocus(false, false)
        AnimationActions("end")
    end)

local function close ()
    TriggerScreenblurFadeOut(1000)
    SetNuiFocus(false, false)
    AnimationActions("end")
    SendNUIMessage({
        type = 'close',
        display = false
    })

end  
RegisterNetEvent("qb-samnewspaper:client:addnews", function( result)
    local res=result
    AnimationActions("start")
    TriggerScreenblurFadeIn(1000)
    SendNUIMessage({
        type = 'addnews',
    })
  SetNuiFocus(true, true)
end)

RegisterNetEvent("qb-samnewspaper:client:newspaperon", function( result)
    local res=result
    AnimationActions("start")
    TriggerScreenblurFadeIn(1000)
    SendNUIMessage({
        type = 'ui',
        headlineTitle1=res.articleTitle1,
        headlineTitle2=res.articleTitle2,
        headline1=res.articleDesc1,
        headline2=res.articleDesc2,
        arrest1=res.arrest1,
        arrest2=res.arrest2,
        arrest3=res.arrest3,
        display = true,
    })
  SetNuiFocus(true, true)
end)

RegisterNetEvent("qb-samnewspaper:client:close", function()
   close()
end)


RegisterNUICallback("savenewspaper", function(data)
        TriggerServerEvent("qb-samnewspaper:server:savenewspaper", tostring(data.imageaddress), tostring(data.addtitle), tostring(data.addRightarticle), tostring(data.addleftarticle))
          close()
end)