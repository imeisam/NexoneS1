-- Spectator Registering (checking if player is in range of the board to spawn it)
games_in_range = {}

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(1002)
      local player_coords = GetEntityCoords(GetPlayerPed(-1))
      for k, game in pairs(games) do
          -- check if already game in range
          local already_registered = false
          for i, game_in_range in ipairs(games_in_range) do
              if game_in_range == k then
                  already_registered = true
                  break
              end
          end
          if not game.finished and GetDistanceBetweenCoords(game.x, game.y, game.z, player_coords) < Config.loadPiecesDistance and not already_registered then
              TriggerServerEvent("pd_chess:registerSpectator", k)
              table.insert(games_in_range, k)
          end
      end
      for i, game_in_range in ipairs(games_in_range) do
          if GetDistanceBetweenCoords(games[game_in_range].x, games[game_in_range].y, games[game_in_range].z, player_coords) > Config.loadPiecesDistance then
              TriggerServerEvent('pd_chess:removeSpectator', game_in_range)
              table.remove(games_in_range, i)
          end
      end       
  end
end)


function startChess()
  SetCurrentPedWeapon(PlayerPedId(), -1569615261, true)
  SendNUIMessage({
      event="setTimeChoices",
      choice1=Config.timeChoices["choice1"],
      choice2=Config.timeChoices["choice2"],
      choice3=Config.timeChoices["choice3"],
      choice4=Config.timeChoices["choice4"],
      minTranslation=_L("mins"),
      headerTranslation = _L("Select Time Control")
  })
  Citizen.Wait(200)
  SendNUIMessage({event="timeChoiceDisplay"})
  SetNuiFocus(true, true)
  while timeChoice == nil do
      Citizen.Wait(1000)
  end
  local time = timeChoice
  timeChoice = nil
  FreezeEntityPosition(ped, false)
  local ped = PlayerPedId(-1)
  local coords = GetEntityCoords(ped)

  if placing_board or in_play then
      return
  end
  placing_board = true

  if not IsPedStopped(ped) then
      Citizen.Wait(1000)
      if not IsPedStopped(ped) then
          placing_board = false
          return
      end
  end

  if Config.usePlayZone  then
      local inside_radius = false
      for i, area in ipairs(Config.playZones) do
          if GetDistanceBetweenCoords(coords, area.x, area.y, area.z) < area.s then
              inside_radius = true
              placing_board = false
              break
          end
      end
      if not inside_radius then
          Citizen.CreateThread(function()
              placing_board = false
              drawSubtitles(_L("Cannot start Chess game outside of the ~r~Play Zones~w~."), 4000)
              Citizen.Wait(4000)
              drawSubtitles(string.format(_L("To view the ~r~Play Zones~w~ on your map, type ~b~/%s~w~ in chat."), Config.togglePlayZonesCommand ), 5000)
          end)
          return
      end
  end

  if IsPointOnRoad(coords) then
      drawSubtitles(_L("Cannot start Chess game on a road."), 4000)
      placing_board = false
      return
  end
  if IsPedInAnyVehicle(ped) then
      drawSubtitles(_L("Cannot start Chess game from inside a vehicle."), 4000)
      placing_board = false
      return
  end

  for k, game in pairs(games) do
      if not game.finished and GetDistanceBetweenCoords(game.board_coords, coords) < 2 then
          drawSubtitles(_L("In too close proximity of another Chess game."), 4000)
          placing_board = false
          return
      end 
  end
  FreezeEntityPosition(ped, true)

  Citizen.CreateThread(function()
      playAnim("anim@mp_fireworks", "place_firework_1_rocket", 16, 2.0, 1.0)
      Citizen.Wait(2000)
      ClearPedTasks(ped)
  end)
  Citizen.Wait(1800)
  if IsPedFalling(ped) then
      placing_board = false
      return
  end

  local x, y, z = table.unpack(coords)
  local ox, oy, oz = table.unpack(coords)
  
  local heading = GetEntityHeading(PlayerPedId())
  local heading = math.floor((heading / 360 * 4) + 0.5)
  local board_offset = 0.8
  
  if heading == 0 or heading == 4 then
      y = y + board_offset
      oy = oy +(board_offset * 2)
  elseif heading == 2 then
      y = y - board_offset
      oy = oy - (board_offset * 2)
  elseif heading == 1 then
      x = x - board_offset
      ox = ox -(board_offset * 2)
  elseif heading == 3 then
      x = x + board_offset
      ox = ox + (board_offset * 2)
  end

  local data = {
      x = x,
      y = y,
      z = z,
      heading=heading,
      opponent_coords={ox,oy,oz},
      host_ped = NetworkGetNetworkIdFromEntity(PlayerPedId()),
      time = time
  }

  waiting_for_opponent.waiting = true
  waiting_for_opponent.coords = {x,y,z}
  in_play = true
  placing_board = false
  TriggerServerEvent('pd_chess:storeBoardData', data)
end

RegisterNetEvent("pd_chess:placeBoard")
AddEventHandler("pd_chess:placeBoard", function(game_key)
    local data = games[game_key]
    local x, y, z = data.x, data.y, data.z
    local ped_coords = GetEntityCoords(PlayerPedId())
    if GetDistanceBetweenCoords(x,y,z, ped_coords) > Config.loadPiecesDistance then
        return
    end
    local z_offset_table = 0.7
    local hash = GetHashKey("prop_kq_checkers")
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(1)
    end
    local hash = GetHashKey("prop_proxy_chateau_table")
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(1)
    end

    local chess_table = CreateObjectNoOffset("prop_proxy_chateau_table", x, y, z-z_offset_table, false, false)
    FreezeEntityPosition(chess_table, true)

    local chess_table_upper = CreateObjectNoOffset("prop_proxy_chateau_table", x, y, z-z_offset_table + 0.7, false, false)
    FreezeEntityPosition(chess_table_upper, true)
    SetEntityVisible(chess_table_upper, 0, 0)

    

    local table_x, table_y, table_z = table.unpack(GetEntityCoords(chess_table))

    local board = CreateObjectNoOffset("prop_kq_checkers", x, y, table_z + 0.42, false, false)
    while not DoesEntityExist(board) do 
        Citizen.Wait(100)
    end
    SetEntityRotation(board, 0.0, 180.0, 90.0, 3, true)
    FreezeEntityPosition(board, true)
    if games[game_key].heading == 0 or games[game_key].heading == 4 or games[game_key].heading == 2 then
        SetEntityRotation(board, 0.0, 180.0, 0.0, 2, true)
    end 
    

    if items_to_delete[game_key] == nil then
        items_to_delete[game_key] = {}
    end
    table.insert(items_to_delete[game_key], chess_table)
    table.insert(items_to_delete[game_key], chess_table_upper)
    table.insert(items_to_delete[game_key], board)

    if Config.debug then
        table.insert(items_to_deletes, chess_table)
        table.insert(items_to_deletes, chess_table_upper)
        table.insert(items_to_deletes, board)
    end

    
    games[game_key].board_id = board
    games[game_key].table_id = chess_table
    games[game_key].upper_table_id = chess_table_upper
    games[game_key].board_coords = GetEntityCoords(board)

    if not games[game_key].in_play then
        if games[game_key].host_ped == NetworkGetNetworkIdFromEntity(PlayerPedId()) then
            AddEntityToTargeting2("pd_chess:cancelGame", chess_table, {"prop_kq_chess", "prop_proxy_chateau_table"}, _L("Cancel Game"), Config.target.pickupIcon, game_key)
        else
            AddEntityToTargeting('pd_chess:qtarget_send', chess_table, {"prop_kq_chess", "prop_proxy_chateau_table"}, _L("Join Game | ELO: {ELO} | Time: {TIME} mins"):gsub("{ELO}", games[game_key].join_game_text):gsub("{TIME}", games[game_key].time), Config.target.joinGameIcon, game_key)
        end
    end
end)

function cleanupPieces(game_key)
    for i, item in ipairs(items_to_delete[game_key]) do
        DeleteObject(item)
    end
    pieces_spawned_in[game_key] = false
end


function drawSubtitles(text, time)
  ClearPrints()
  SetTextEntry_2("STRING")
  AddTextComponentString(text)
  DrawSubtitleTimed(time, 1)
end

function playAnim(dict, anim, type, speed, duration)
  local player = GetPlayerPed(-1)
  if not IsPedInAnyVehicle(player, true) then
      RequestAnimDict(dict)
      while not HasAnimDictLoaded(dict) do
          Citizen.Wait(100)
      end
      TaskPlayAnim(player, dict, anim, speed, speed, duration, type, 0, false, false, false)
      RemoveAnimDict(dict)
  end
end

function drawBlip(coords, label, icon, size, color)
  local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
  SetBlipSprite (blip, icon)
  SetBlipDisplay(blip, 4)
  SetBlipScale  (blip, size)
  SetBlipColour (blip, color)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(label)
  EndTextCommandSetBlipName(blip)
  return blip
end

function Draw3DText(x, y, z, textInput, fontId, scaleX, scaleY)
  local px, py, pz = table.unpack(GetGameplayCamCoords())
  local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, true)
  local scale = (1 / dist) * 20
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov
  SetTextScale(scaleX * scale, scaleY * scale)
  SetTextFont(fontId)
  SetTextProportional(1)
  SetTextColour(250, 250, 250, 255)
  SetTextDropshadow(1, 1, 1, 1, 255)
  SetTextEdge(2, 0, 0, 0, 150)
  SetTextDropShadow()
  SetTextOutline()
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(textInput)
  SetDrawOrigin(x, y, z, 0)
  DrawText(0.0, 0.0)
  ClearDrawOrigin()
end

function displayJoinGameText()
    local games_in_range = false
    for k, game in pairs(games) do
        local player_ped = PlayerPedId(-1)
        local coords = GetEntityCoords(player_ped)
        if (not in_play and not game.in_play and not game.finished) and GetDistanceBetweenCoords(coords, game.opponent_coords[1], game.opponent_coords[2], game.opponent_coords[3]) < 30 then
            games_in_range = true
            DrawMarker(1, game.opponent_coords[1], game.opponent_coords[2], game.opponent_coords[3] - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.7, 0, 40, 180, 90, 0, 1, 0, 0)
            if GetDistanceBetweenCoords(coords, game.opponent_coords[1], game.opponent_coords[2], game.opponent_coords[3]) < 0.7 then
                local b_coords = GetEntityCoords(game.board_id)
                Draw3DText(b_coords.x, b_coords.y, b_coords.z, _L("Press [~b~{KEYBIND}~w~] to join chess match - ~b~ELO~w~ {ELO} - ~b~TIME~w~ {TIME} mins"):gsub("{KEYBIND}", Config.interactKeybind):gsub("{ELO}", game.join_game_text):gsub("{TIME}", game.time), 4, 0.08, 0.05)
                if IsControlJustPressed(0, Keys[Config.interactKeybind])then
                    Citizen.CreateThread(function()
                        SetCurrentPedWeapon(PlayerPedId(), -1569615261, true)
                        FreezeEntityPosition(PlayerPedId(), true)
                        in_play = true
                        TriggerServerEvent("pd_chess:pickPlayers", k)
                    end)
                end
            end
        end
    end

    if not games_in_range then
        return 2000
    end
    return 0
end
