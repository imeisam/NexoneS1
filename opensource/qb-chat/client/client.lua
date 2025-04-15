nuiOpen = false
loaded = false
firstLoad = true

RegisterNetEvent('chatMessage')
RegisterNetEvent('chat:addSuggestions')
RegisterNetEvent('chat:addSuggestion')
RegisterNetEvent('chat:addMessage')
RegisterNetEvent('_chat:messageEntered')
RegisterNetEvent('chat:clear')

AddEventHandler('chatMessage', function(author, ctype, text, typ)
    local args = { text }
    if author ~= "" then
        table.insert(args, 1, author)
    end
    SendNUIMessage({
      type = 'NXO_CHATMESSAGE',
      timeOut = 5000,
      message = {
        color = ctype,
        args = args,
        text = text,
        typ=typ,
      }
    })
end)

AddEventHandler('chat:clear', function(name)
  SendNUIMessage({
    type = 'NXO_CLEAR'
  })
end)


AddEventHandler('chat:addSuggestion', function(name, help, params)
  if string.find(name, '/') then
    addSuggestion(string.gsub(name, '/', ''), help, params)
  end
  addSuggestion(name, help, params)
end)


AddEventHandler('chat:addSuggestions', function(suggestions)
    for _, suggestion in ipairs(suggestions) do
      SendNUIMessage({
        type = 'NXO_ADDSUGGESTION',
        suggestion = suggestion
      })
    end
end)
  

function addSuggestion(name, help, params)
  SendNUIMessage({
    type = 'NXO_SUGGESTION_ADD',
    suggestion = {
      name = name,
      help = help,
      params = params or nil
    }
  })
end
  
CreateThread(function()
  TriggerServerEvent('chat:init');
end)

RegisterNUICallback('load', function(data, cb)
  firstLoad = false
  loaded = true
end)

RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false, false)
    SetTextChatEnabled(true)
    nuiOpen = false
end)


RegisterNUICallback('send', function(data, cb)
    local id = PlayerId()
    local r, g, b = 0, 0x99, 255

    if data.close then
      SetNuiFocus(false, false)
      nuiOpen = false
    end
 
    if string.sub(data.text, 1, 1) ~= "/" then
      data.text = "/" .. data.text
    end

    if data.text:sub(1, 1) == '/' then
      ExecuteCommand(data.text:sub(2))
    else
    TriggerServerEvent('_chat:messageEntered', GetPlayerName(id), { r, g, b }, data.text, "all")
    end

end)

RegisterNUICallback('close', function(data, cb)
  SetNuiFocus(false, false)
  nuiOpen = false
end)

AddEventHandler("onKeyDown", function(key)
  if key=="y" then
    SetTextChatEnabled(false)
  end
  if key == "t" then
    if not nuiOpen then
      nuiOpen = true
      SetNuiFocus(true, true)  
      SetTextChatEnabled(false)
      SendNUIMessage({
          type = 'NXO_OPEN',
          timeOut = 5000
      })
    end
  end
end)