local resault = nil

local function OpenMinigame(callback, diffrent, reach, fail)
  SetNuiFocus(true, true)
  result = promise.new()
  if LocalPlayer.state.isHackBuff then
    fail = fail + 5
  end
  SendNUIMessage({type = "open", diffrent = diffrent, reach = reach, fail = fail})
  local success = Citizen.Await(result)
  callback(success)
end exports("OpenMinigame", OpenMinigame)

RegisterNUICallback('callback', function(data, cb)
  SetNuiFocus(false, false)
  if LocalPlayer.state.isSmart then
    data.success = true
  end
  result:resolve(data.success)
  cb('ok')
  result = nil
end)