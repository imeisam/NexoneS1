-- Textures
Textures = { -- Do not change
    pin = 'pin',
    interact = 'interact',
    interactRed = 'interactRed',
    bg = 'bg',
    bgRed = 'bgRed'
}
-- local txd = CreateRuntimeTxd('interactions_txd')
-- for _, v in pairs(Textures) do
--     CreateRuntimeTextureFromImage(txd, tostring(v), "assets/" .. v .. ".png")
-- end

Config.Players = {}
function displayTextUI(text, key)
    if  isshow and lasttext==text then
        return
    end
    local key1 = key
    if key==nil or key=="" then
        key1=" "
    end
    
    lasttext=text
    isshow=true
    -- if Config.DefaultKey and key==nil then
    --     key = Config.DefaultKey.Key
    -- end

    SendNUIMessage({action = "textUI", show = true, key = key1, text = text})
end
 isshow=false
 lasttext=""
function changeText(text, key)
   
    -- if Config.DefaultKey then
    --     key = Config.DefaultKey.Key
    -- end
    if isshow and lasttext==text then
        return
    end
    local key1 = key
    if key==nil or key=="" then
        key1=" "
    end
 
    lasttext=text
    isshow=true
    SendNUIMessage({action = "textUIUpdate", key = key1, text = text})
end

function hideTextUI()
    isshow=false
    lasttext=""
    SendNUIMessage({action = "textUI", show = false})
end

-- function create3DTextUIOnPlayers(id, data)
--     if not Config.Players[id] then
--         local targetPlayerId = GetPlayerFromServerId(data.id)
--         local targetPed = GetPlayerPed(targetPlayerId)
--         Config.Players[id] = {
--             data = {
--                 id = id,
--                 ped = targetPed, 
--                 displayDist = data.displayDist,
--                 interactDist = data.interactDist,
--                 enableKeyClick = data.enableKeyClick,
--                 keyNum = data.keyNum, -- Key number
--                 keyNum2 = data.keyNum2,
--                 key = data.key, -- Key name
--                 text = data.text,
--                 theme = data.theme or "red"
--             },
--             onKeyClick = function()
--                 if data.triggerData then
--                     if data.triggerData.isServer then
--                         TriggerServerEvent(data.triggerData.triggerName, data.triggerData.args)
--                     else
--                         TriggerEvent(data.triggerData.triggerName, data.triggerData.args)
--                     end
--                 end
--             end,
--             onKeyClick2 = function()
--                 if data.triggerData2 then
--                     if data.triggerData2.isServer then
--                         TriggerServerEvent(data.triggerData2.triggerName, data.triggerData2.args)
--                     else
--                         TriggerEvent(data.triggerData2.triggerName, data.triggerData2.args)
--                     end
--                 end
--             end
--         }
--     end
-- end

-- function delete3DTextUIOnPlayers(id)
--     if Config.Players[id] then
--         Config.Players[id] = nil
--     end
-- end

-- function create3DTextUI(id, data)
--     if not Config.Areas[id] then
--         if data.canInteract then
--             Config.Areas[id] = {
--                 data = {
--                     id = id,
--                     type = "3dtext", -- 3dtext or textui
--                     coords = data.coords, 
--                     displayDist = data.displayDist,
--                     interactDist = data.interactDist,
--                     enableKeyClick = data.enableKeyClick,
--                     keyNum = data.keyNum, -- Key number
--                     key = data.key, -- Key name
--                     text = data.text,
--                     theme = data.theme or "red",
--                     job = data.job or "all",
--                     canInteract = data.canInteract
--                 },
--                 onKeyClick = function()
--                     if data.triggerData then
--                         if data.triggerData.isServer then
--                             TriggerServerEvent(data.triggerData.triggerName, data.triggerData.args)
--                         else
--                             TriggerEvent(data.triggerData.triggerName, data.triggerData.args)
--                         end
--                     end
--                 end
--             }
--         else
--             Config.Areas[id] = {
--                 data = {
--                     id = id,
--                     type = "3dtext", -- 3dtext or textui
--                     coords = data.coords, 
--                     displayDist = data.displayDist,
--                     interactDist = data.interactDist,
--                     enableKeyClick = data.enableKeyClick,
--                     keyNum = data.keyNum, -- Key number
--                     key = data.key, -- Key name
--                     text = data.text,
--                     theme = data.theme or "red",
--                     job = data.job or "all",
--                     canInteract = function()
--                         return true
--                     end
--                 },
--                 onKeyClick = function()
--                     if data.triggerData then
--                         if data.triggerData.isServer then
--                             TriggerServerEvent(data.triggerData.triggerName, data.triggerData.args)
--                         else
--                             TriggerEvent(data.triggerData.triggerName, data.triggerData.args)
--                         end
--                     end
--                 end
--             }
--         end
--     end
-- end

-- function create3DTextUIOnEntity(id, data)
--     local entity = nil
--     local coords = GetEntityCoords(id)
--     if IsEntityAVehicle(id) then
--         entity = id
--     end
--     if IsEntityAnObject(id) then
--         entity = id
--     end
--     if IsEntityAPed(id) then
--         entity = id
--     end
--     if entity == nil then return print("Wrong entity.") end
--     data.id = entity
--     data.coords = vector3(coords.x, coords.y, coords.z + 1.0)
--     create3DTextUI(entity, data)
-- end

-- function delete3DTextUI(id)
--     if Config.Areas[id] then
--         Config.Areas[id] = nil
--     end
-- end

-- function update3DTextUI(id, text, theme)
--     Config.Areas[id].data.text = text
--     Config.Areas[id].data.theme = theme
-- end

-- local showTextUI = false
-- Citizen.CreateThread(function()
--     while true do
--         local sleep = 1000
--         local playerCoords = GetEntityCoords(PlayerPedId())
--         local ratio = GetAspectRatio(true)
--         for k, v in pairs(Config.Areas) do
--             local dist = #(v.data.coords - playerCoords)
--             if v.data.type == "3dtext" then
--                 if dist <= v.data.displayDist then
--                     sleep = 0
--                     if v.data.canInteract == nil then
--                         v.data.canInteract = function()
--                             return true
--                         end
--                     end
--                     local canInteract = v.data.canInteract()
--                     if canInteract then
--                         if v.data.job == "all" then
--                             if dist <= v.data.interactDist then
--                                 -- Main Text
--                                 local factor = (string.len(v.data.text)) / 370
--                                 local width = 0.03 + factor
--                                 -- Key Text
--                                 local factor2 = (string.len(v.data.key)) / 370
--                                 local width2 = 0.016 + factor2
--                                 local onScreen, _x, _y = World3dToScreen2d(v.data.coords.x, v.data.coords.y, v.data.coords.z)
--                                 if onScreen then
--                                     local interact, bg = 'interact', 'bg'
--                                     if v.data.theme == "red" then
--                                         interact, bg = 'interactRed', 'bgRed'
--                                     end
--                                     -- E
--                                     SetScriptGfxAlignParams(0.0, 0.0, 0.0, 0.0)
--                                     SetTextScale(0, 0.35)
--                                     SetTextFont(2)
--                                     SetTextColour(255, 255, 255, 255)
--                                     BeginTextCommandDisplayText("STRING")
--                                     SetTextCentre(true)
--                                     SetTextJustification(0)
--                                     AddTextComponentSubstringPlayerName(v.data.key)
--                                     SetDrawOrigin(v.data.coords.x, v.data.coords.y, v.data.coords.z)
--                                     EndTextCommandDisplayText(0.0, -0.0115)
--                                     ResetScriptGfxAlign()
--                                     SetScriptGfxAlignParams(0.0, 0.0, 0.0, 0.0)
--                                     DrawSprite('interactions_txd', interact, 0.0, 0.0, width2, 0.03133333333333333, 0.0, 255, 255, 255, 255)
--                                     ResetScriptGfxAlign()
--                                     ClearDrawOrigin()
--                                     -- Bg
--                                     SetScriptGfxAlignParams(0.018 + (width / 2), 0 * 0.03 - 0.0125, 0.0, 0.0)
--                                     SetTextScale(0, 0.3)
--                                     SetTextFont(4)
--                                     SetTextColour(255, 255, 255, 255)
--                                     BeginTextCommandDisplayText("STRING")
--                                     SetTextCentre(1)
--                                     AddTextComponentSubstringPlayerName(v.data.text)
--                                     SetDrawOrigin(v.data.coords.x, v.data.coords.y, v.data.coords.z)
--                                     SetTextJustification(0)
--                                     EndTextCommandDisplayText(-0.01, 0.001)
--                                     ResetScriptGfxAlign()
--                                     SetScriptGfxAlignParams(0.018 + (width / 2), 0 * 0.03 - 0.015, 0.0, 0.0)
--                                     DrawSprite('interactions_txd', bg, 0.0, 0.015, width, 0.025, 0.0, 255, 255, 255, 255)
--                                     ResetScriptGfxAlign()
--                                     ClearDrawOrigin()
--                                     if v.data.enableKeyClick then
--                                         if v.data.keyNum then
--                                             if IsControlJustReleased(0, v.data.keyNum) then
--                                                 v.onKeyClick()
--                                             end
--                                         end
--                                     end
--                                 end
--                             else
--                                 SetScriptGfxAlignParams(0.0, 0.0, 0.0, 0.0)
--                                 SetDrawOrigin(v.data.coords.x, v.data.coords.y, v.data.coords.z)
--                                 DrawSprite('interactions_txd', 'pin', 0, 0, 0.0125, 0.02333333333333333, 0, 255, 255, 255, 255)
--                                 ResetScriptGfxAlign()
--                             end
--                         elseif v.data.job == GetPlayerJob() then
--                             if dist <= v.data.interactDist then
--                                 -- Main Text
--                                 local factor = (string.len(v.data.text)) / 370
--                                 local width = 0.03 + factor
--                                 -- Key Text
--                                 local factor2 = (string.len(v.data.key)) / 370
--                                 local width2 = 0.016 + factor2
--                                 local onScreen, _x, _y = World3dToScreen2d(v.data.coords.x, v.data.coords.y, v.data.coords.z)
--                                 if onScreen then
--                                     local interact, bg = 'interact', 'bg'
--                                     if v.data.theme == "red" then
--                                         interact, bg = 'interactRed', 'bgRed'
--                                     end
--                                     -- E
--                                     SetScriptGfxAlignParams(0.0, 0.0, 0.0, 0.0)
--                                     SetTextScale(0, 0.35)
--                                     SetTextFont(2)
--                                     SetTextColour(255, 255, 255, 255)
--                                     BeginTextCommandDisplayText("STRING")
--                                     SetTextCentre(true)
--                                     SetTextJustification(0)
--                                     AddTextComponentSubstringPlayerName(v.data.key)
--                                     SetDrawOrigin(v.data.coords.x, v.data.coords.y, v.data.coords.z)
--                                     EndTextCommandDisplayText(0.0, -0.0115)
--                                     ResetScriptGfxAlign()
--                                     SetScriptGfxAlignParams(0.0, 0.0, 0.0, 0.0)
--                                     DrawSprite('interactions_txd', interact, 0.0, 0.0, width2, 0.03133333333333333, 0.0, 255, 255, 255, 255)
--                                     ResetScriptGfxAlign()
--                                     ClearDrawOrigin()
--                                     -- Bg
--                                     SetScriptGfxAlignParams(0.018 + (width / 2), 0 * 0.03 - 0.0125, 0.0, 0.0)
--                                     SetTextScale(0, 0.3)
--                                     SetTextFont(4)
--                                     SetTextColour(255, 255, 255, 255)
--                                     BeginTextCommandDisplayText("STRING")
--                                     SetTextCentre(1)
--                                     AddTextComponentSubstringPlayerName(v.data.text)
--                                     SetDrawOrigin(v.data.coords.x, v.data.coords.y, v.data.coords.z)
--                                     SetTextJustification(0)
--                                     EndTextCommandDisplayText(-0.01, 0.001)
--                                     ResetScriptGfxAlign()
--                                     SetScriptGfxAlignParams(0.018 + (width / 2), 0 * 0.03 - 0.015, 0.0, 0.0)
--                                     DrawSprite('interactions_txd', bg, 0.0, 0.015, width, 0.025, 0.0, 255, 255, 255, 255)
--                                     ResetScriptGfxAlign()
--                                     ClearDrawOrigin()
--                                     if v.data.enableKeyClick then
--                                         if v.data.keyNum then
--                                             if IsControlJustReleased(0, v.data.keyNum) then
--                                                 v.onKeyClick()
--                                             end
--                                         end
--                                     end
--                                 end
--                             else
--                                 SetScriptGfxAlignParams(0.0, 0.0, 0.0, 0.0)
--                                 SetDrawOrigin(v.data.coords.x, v.data.coords.y, v.data.coords.z)
--                                 DrawSprite('interactions_txd', 'pin', 0, 0, 0.0125, 0.02333333333333333, 0, 255, 255, 255, 255)
--                                 ResetScriptGfxAlign()
--                             end
--                         end
--                     end
--                 end
--             end
--             if v.data.type == "textui" then
--                 if dist <= v.data.dist then
--                     sleep = 0
--                     if not showTextUI then
--                         showTextUI = true
--                         SendNUIMessage({action = "textUI", show = true, key = v.data.key, text = v.data.text})
--                         if IsControlJustReleased(0, v.data.keyNum) then
--                             v.onKeyClick()
--                         end
--                     end
--                 else
--                     if showTextUI then
--                         showTextUI = false
--                         SendNUIMessage({action = "textUI", show = false})
--                     end
--                 end
--             end
--         end
--         Citizen.Wait(sleep)
--     end
-- end)

-- local showTextUI2 = false
-- Citizen.CreateThread(function()
--     while true do
--         local sleep = 1000
--         local playerCoords = GetEntityCoords(PlayerPedId())
--         for k, v in pairs(Config.Players) do
--             v.data.coords = GetEntityCoords(v.data.ped)
--             local dist = #(v.data.coords - playerCoords)
--             if dist <= v.data.displayDist then
--                 sleep = 0
--                 if dist <= v.data.interactDist then
--                     -- Main Text
--                     local factor = (string.len(v.data.text)) / 370
--                     local width = 0.03 + factor
--                     -- Key Text
--                     local factor2 = (string.len(v.data.key)) / 370
--                     local width2 = 0.016 + factor2
--                     local onScreen, _x, _y = World3dToScreen2d(v.data.coords.x, v.data.coords.y, v.data.coords.z)
--                     if onScreen then
--                         local interact, bg = 'interact', 'bg'
--                         if v.data.theme == "red" then
--                             interact, bg = 'interactRed', 'bgRed'
--                         end
--                         -- E
--                         SetScriptGfxAlignParams(0.0, 0.0, 0.0, 0.0)
--                         SetTextScale(0, 0.35)
--                         SetTextFont(4)
--                         SetTextColour(255, 255, 255, 255)
--                         BeginTextCommandDisplayText("STRING")
--                         SetTextCentre(true)
--                         SetTextJustification(0)
--                         AddTextComponentSubstringPlayerName(v.data.key)
--                         SetDrawOrigin(v.data.coords.x, v.data.coords.y, v.data.coords.z)
--                         EndTextCommandDisplayText(0.0, -0.0115)
--                         ResetScriptGfxAlign()
--                         SetScriptGfxAlignParams(0.0, 0.0, 0.0, 0.0)
--                         DrawSprite('interactions_txd', interact, 0.0, 0.0, width2, 0.03133333333333333, 0.0, 255, 255, 255, 255)
--                         ResetScriptGfxAlign()
--                         ClearDrawOrigin()
--                         -- Bg
--                         SetScriptGfxAlignParams(0.018 + (width / 2), 0 * 0.03 - 0.0125, 0.0, 0.0)
--                         SetTextScale(0, 0.3)
--                         SetTextFont(4)
--                         SetTextColour(255, 255, 255, 255)
--                         BeginTextCommandDisplayText("STRING")
--                         SetTextCentre(1)
--                         AddTextComponentSubstringPlayerName(v.data.text)
--                         SetDrawOrigin(v.data.coords.x, v.data.coords.y, v.data.coords.z)
--                         SetTextJustification(0)
--                         EndTextCommandDisplayText(-0.01, 0.001)
--                         ResetScriptGfxAlign()
--                         SetScriptGfxAlignParams(0.018 + (width / 2), 0 * 0.03 - 0.015, 0.0, 0.0)
--                         DrawSprite('interactions_txd', bg, 0.0, 0.015, width, 0.025, 0.0, 255, 255, 255, 255)
--                         ResetScriptGfxAlign()
--                         ClearDrawOrigin()
--                         if v.data.enableKeyClick then
--                             if v.data.keyNum then
--                                 if IsControlJustReleased(0, v.data.keyNum) then
--                                     v.onKeyClick()
--                                 end
--                             end
--                             if v.data.keyNum2 then
--                                 if IsControlJustReleased(0, v.data.keyNum2) then
--                                     v.onKeyClick2()
--                                 end
--                             end
--                         end
--                     end
--                 else
--                     SetScriptGfxAlignParams(0.0, 0.0, 0.0, 0.0)
--                     SetDrawOrigin(v.data.coords.x, v.data.coords.y, v.data.coords.z)
--                     DrawSprite('interactions_txd', 'pin', 0, 0, 0.0125, 0.02333333333333333, 0, 255, 255, 255, 255)
--                     ResetScriptGfxAlign()
--                 end
--             end
--         end
--         Citizen.Wait(sleep)
--     end
-- end)