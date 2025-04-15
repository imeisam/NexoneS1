local currentItemSlot = 0
RegisterNetEvent('sam-notebook:showNotebook:client', function(metadata, slot)
    local mainData = {}
    local main = metadata.main
    if main and next(main) ~= nil then
        mainData = {title = main.title, description = main.description}
    else
        mainData = {title = "My Notebook", description = "Description"}
    end
    local notebookData = {}
    local content = json.decode(metadata.content)
    if content and next(content) ~= nil then
        for k, v in pairs(content) do
            notebookData[k] = {
                title = v.title,
                content = v.content
            }
        end
    else
        for i = 1, 15 do
            notebookData[i] = {
                title = "Title",
                content = "Write Something"
            }
        end
    end
    SendNUIMessage({action = "openNotebook", data = notebookData, mdata = mainData})
    SetNuiFocus(true, true)
    currentItemSlot = slot
    TriggerEvent('sam-notepad:note')
end)

RegisterNUICallback('callback', function(data)
    if data.action == "nuiFocus" then
        SetNuiFocus(false, false)
        TriggerServerEvent('sam-notebook:updateMetadata:server', json.encode(data.metadata), currentItemSlot, data.nheader, data.ndesc)
        TriggerEvent('sam-notepad:note')
    end
end)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

RegisterNetEvent('sam-notepad:note')
AddEventHandler('sam-notepad:note', function()
    local player = PlayerPedId()
    local ad = "missheistdockssetup1clipboard@base"
                
    local prop_name = prop_name or 'prop_notepad_01'
    local secondaryprop_name = secondaryprop_name or 'prop_pencil_01'
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
            Citizen.Wait(100)
            ClearPedSecondaryTask(PlayerPedId())
            DetachEntity(prop, 1, 1)
            DeleteObject(prop)
            DetachEntity(secondaryprop, 1, 1)
            DeleteObject(secondaryprop)
        else
            local x,y,z = table.unpack(GetEntityCoords(player))
            prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
            secondaryprop = CreateObject(GetHashKey(secondaryprop_name), x, y, z+0.2,  true,  true, true)
            AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 18905), 0.1, 0.02, 0.05, 10.0, 0.0, 0.0, true, true, false, true, 1, true) -- lkrp_notepadpad
            AttachEntityToEntity(secondaryprop, player, GetPedBoneIndex(player, 58866), 0.12, 0.0, 0.001, -150.0, 0.0, 0.0, true, true, false, true, 1, true) -- pencil
            TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
        end     
    end
end)