local resault = nil

local function OpenUntangleGame(callback, points)
  SetNuiFocus(true, true)
  result = promise.new()
  if LocalPlayer.state.isHackBuff then
    points = points - 2
  end
  SendNUIMessage({
    action = 'uiMessage',
    data = {
      show = true,
      points = points,
      app = 'minigame-untangle'
    }
  })
  local success = Citizen.Await(result)
  callback(success)
end exports("OpenUntangleGame", OpenUntangleGame)

RegisterNUICallback('minigame-untangle', function(data, cb)
	SetNuiFocus(false, false)
  if data.action == 'failed' then
    if LocalPlayer.state.isSmart then
      result:resolve(true)
    else
      result:resolve(false)
    end
  else
    result:resolve(true)
  end
  result = nil
end)