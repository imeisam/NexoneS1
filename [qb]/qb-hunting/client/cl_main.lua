local cooldown = 0
local used = false
local useBaitCooldown = 3
local QBCore = exports['qb-core']:GetCoreObject()

local HuntingZones =  {
  'CANNY',
  'CMSW',
  'CCREAK',
}

local HuntingAnimals = {
  'a_c_boar',
  'a_c_deer',
  'a_c_coyote',
  'a_c_mtlion',
}

local legalHunts = {
  'a_c_boar',
  'a_c_deer',
  'a_c_coyote',
  'a_c_mtlion',
}

CreateThread(function()
	exports['qb-target']:AddTargetModel(legalHunts, {
    options = {
      {
        event = "qb-hunting:skinAnimal",
        icon = "far fa-hand-paper",
        label = "Skin",
      },
    },
    distance = 1.5
  })
  SetScenarioTypeEnabled('WORLD_DEER_GRAZING',false)
  SetScenarioTypeEnabled('WORLD_COYOTE_WANDER',false)
  SetScenarioTypeEnabled('WORLD_COYOTE_REST',false)
  SetScenarioTypeEnabled('WORLD_BOAR_GRAZING',false)
  SetScenarioTypeEnabled('WORLD_MOUNTAIN_LION_WANDER',false)
  SetScenarioTypeEnabled('WORLD_MOUNTAIN_LION_REST',false)
end)

-- CreateThread(function()
--   local coords = vector3(-973.44, 4424.14, 18.16)
--   local zoneblip = AddBlipForRadius(coords.x,coords.y,coords.z, 4000.0)
--   SetBlipSprite(zoneblip,1)
--   SetBlipColour(zoneblip,62)
--   SetBlipAlpha(zoneblip,75)
--   local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
--   SetBlipSprite(blip, 141)
--   SetBlipScale(blip, 0.7)
--   SetBlipDisplay(blip, 4)
--   SetBlipColour(blip, 3)
--   SetBlipAsShortRange(blip, true)
--   BeginTextCommandSetBlipName("STRING")
--   AddTextComponentString('Hunting Area')
--   EndTextCommandSetBlipName(blip)
-- end)

RegisterNetEvent('qb-hunting:spawnAnimal', function()
  local ped = PlayerPedId()
  local coords = GetEntityCoords(ped)
  local radius = 100.0
  local x = coords.x + math.random(-radius,radius)
  local y = coords.y + math.random(-radius,radius)
  local safeCoord, outPosition = GetSafeCoordForPed(x,y,coords.z,false,16)
  animal = HuntingAnimals[math.random(#HuntingAnimals)]
  local hash = GetHashKey(animal)
  if not HasModelLoaded(hash) then
    RequestModel(hash)
    Wait(10)
  end
  while not HasModelLoaded(hash) do
    Wait(10)
  end
  if outPosition.x > 1 or outPosition.x < -1  then
    Wait(20000)
    baitAnimal = CreatePed(28, hash, outPosition.x, outPosition.y, outPosition.z, 0, true, false)
  else
    print('Debug: Too far to spawn')
  end
  if DoesEntityExist(baitAnimal) then
    TaskGoToCoordAnyMeans(baitAnimal,coords,2.0,0,786603,0)
  end
end)

Citizen.CreateThread(function()
  while true do
    Wait(1000)
    if DoesEntityExist(baitAnimal) then
      local ped = PlayerPedId()
      local coords = GetEntityCoords(PlayerPedId())
      local animalCoords = GetEntityCoords(baitAnimal)
      local dst = #(coords - animalCoords)
      if dst < 2.5 then -- spook animal
        TaskCombatPed(baitAnimal,ped,0,16)
      end
    end
  end
end)

RegisterNetEvent('qb-hunting:skinAnimal', function()
  QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
    if hasItem then
      if DoesEntityExist(baitAnimal) then
        LoadAnimDict('amb@medic@standing@kneel@base')
        LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
        TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
        TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
        QBCore.Functions.Progressbar("get_skin", "Skinning", 15000, false, true, {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        }, {}, {}, {}, function()
          ClearPedTasksImmediately(PlayerPedId())
          DeleteEntity(baitAnimal)
          TriggerServerEvent('qb-hunting:skinReward')
          TriggerServerEvent('hud:server:GainStress', 2)
        end, function()
          ClearPedTasksImmediately(PlayerPedId())
          QBCore.Functions.Notify("Canceled..", "error")
        end)
      end
    else
      QBCore.Functions.Notify("Missing Knife.", "error")
    end
  end, "huntingknife")
end)

RegisterNetEvent('qb-hunting:usedBait', function(slot)
  local inzone = false
  for k,v in pairs (HuntingZones) do
    if IsEntityInZone(PlayerPedId(),v) then
      inzone = true
      if cooldown <= 0 then
        LoadAnimDict('amb@medic@standing@kneel@base')
        TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
        QBCore.Functions.Progressbar("get_bait", "Placing Bait", 10000, false, true, {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        }, {}, {}, {}, function()  --Done
          ClearPedTasksImmediately(PlayerPedId())
          cooldown = useBaitCooldown * 10000
          used = true
          usedBait()
          TriggerEvent('qb-hunting:spawnAnimal')
          TriggerServerEvent("QBCore:Server:RemoveItem", 'huntingbait', 1, slot)
          baitCooldown()
        end, function() -- Cancel
          ClearPedTasksImmediately(PlayerPedId())
          QBCore.Functions.Notify("Canceled..", "error")
        end)
      end
      break
    end
    if not inzone then
      TriggerEvent('QBCore:Notify', "You can't hunt here...", "error")
    end
  end
end)

function baitCooldown()
  Citizen.CreateThread(function()
    while cooldown > 0 do
      Wait(2000)
      cooldown = cooldown - 1000
    end
  end)
end

function usedBait()
  Citizen.CreateThread(function()
    while used do
      Wait(1500)
      TriggerEvent('qb-hunting:spawnAnimal')
      used = false
    end
  end)
end

function playerAnim()
	LoadAnimDict( "mp_safehouselost@" )
  TaskPlayAnim( PlayerPedId(), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
end

function LoadAnimDict(dict)
  while (not HasAnimDictLoaded(dict)) do
    RequestAnimDict(dict)
    Citizen.Wait(10)
  end
end