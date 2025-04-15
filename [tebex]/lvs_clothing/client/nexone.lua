
local QBCore = exports['qb-core']:GetCoreObject()
local firstChar=false
RegisterNetEvent('qb-clothes:client:CreateFirstCharacter', function()
    firstChar=true
end)
RegisterNUICallback('SAVE', function(_, cb)
    if firstChar then
        firstChar = false
        TriggerServerEvent("qb-apartments:server:EnterHouse")
        FreezeEntityPosition(PlayerPedId(), false)
    end

end)


local ShowBlips = false
local Blips = {}
local doAction = false
RegisterNetEvent('lvs_clothing:client:toggleBlips', function()
    if doAction then return end
    ShowBlips = not ShowBlips
    if ShowBlips then
        doAction = true
        for k,v in ipairs(Config.Stores) do
            local blip = AddBlipForCoord(v.coords.xyz)
            SetBlipSprite(blip, Config.Blips[v.type].Sprite)
            SetBlipScale(blip,Config.Blips[v.type].Scale)
            SetBlipColour(blip, Config.Blips[v.type].Color)
            SetBlipDisplay(blip, 4)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Config.Blips[v.type].Name)
            EndTextCommandSetBlipName(blip)
            Blips[#Blips+1] = blip
        end
       
        doAction = false
    else
        doAction = true
        for k,v in ipairs(Blips) do
            RemoveBlip(v)
        end
        Blips = {}
        doAction = false
    end
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    TriggerEvent('lvs_clothing:client:toggleBlips')
end)

local Subs = {
    [2] = "basic", -- Basic
    [3] = "standard", -- Standard
    [4] = "premium", -- Premium
    [5] = "elite", -- Elite
}

RegisterNetEvent('lvs_clothing:Client:blacklist', function(subname)
   if not Subs[subname] then
        return
    end
    local sub =Subs[subname]
    local citizenid= QBCore.Functions.GetPlayerData().citizenid
    for k,v in pairs(Config.Blacklist.male.hair) do
       if v.type and v.type[sub] then
        Config.Blacklist.male.hair[k].citizenids={citizenid}
       end
    end

    for k,v in pairs(Config.Blacklist.male.components.masks) do
        if v.type and v.type[sub]  then
         Config.Blacklist.male.components.masks[k].citizenids={citizenid}
        end
     end
   
     for k,v in pairs(Config.Blacklist.male.components.upperBody) do
        if v.type and v.type[sub] then
         Config.Blacklist.male.components.upperBody[k].citizenids={citizenid}
        end
     end

     for k,v in pairs(Config.Blacklist.male.components.lowerBody) do
      if v.type and v.type[sub] then
       Config.Blacklist.male.components.lowerBody[k].citizenids={citizenid}
      end
   end
   
     for k,v in pairs(Config.Blacklist.male.components.bags) do
        if v.type and v.type[sub] then
         Config.Blacklist.male.components.bags[k].citizenids={citizenid}
        end
     end

     for k,v in pairs(Config.Blacklist.male.components.shoes) do
        if v.type and v.type[sub] then
         Config.Blacklist.male.components.shoes[k].citizenids={citizenid}
        end
     end

     for k,v in pairs(Config.Blacklist.male.components.scarfAndChains) do
        if v.type and v.type[sub] then
         Config.Blacklist.male.components.scarfAndChains[k].citizenids={citizenid}
        end
     end

     for k,v in pairs(Config.Blacklist.male.components.shirts) do
        if v.type and v.type[sub] then
         Config.Blacklist.male.components.shirts[k].citizenids={citizenid}
        end
     end

     for k,v in pairs(Config.Blacklist.male.components.bodyArmor) do
        if v.type and v.type[sub] then
         Config.Blacklist.male.components.bodyArmor[k].citizenids={citizenid}
        end
     end

     for k,v in pairs(Config.Blacklist.male.components.decals) do
        if v.type and v.type[sub] then
         Config.Blacklist.male.components.decals[k].citizenids={citizenid}
        end
     end

     for k,v in pairs(Config.Blacklist.male.components.jackets) do
        if v.type and v.type[sub] then
         Config.Blacklist.male.components.jackets[k].citizenids={citizenid}
        end
     end

     for k,v in pairs(Config.Blacklist.male.props.hats) do
        if v.type and v.type[sub] then
         Config.Blacklist.male.props.hats[k].citizenids={citizenid}
        end
     end

     for k,v in pairs(Config.Blacklist.male.props.glasses) do
        if v.type and v.type[sub] then
         Config.Blacklist.male.props.glasses[k].citizenids={citizenid}
        end
     end

     for k,v in pairs(Config.Blacklist.male.props.ear) do
        if v.type and v.type[sub] then
         Config.Blacklist.male.props.ear[k].citizenids={citizenid}
        end
     end

     for k,v in pairs(Config.Blacklist.male.props.watches) do
        if v.type and v.type[sub] then
         Config.Blacklist.male.props.watches[k].citizenids={citizenid}
        end
     end

     for k,v in pairs(Config.Blacklist.male.props.bracelets) do
        if v.type and v.type[sub] then
         Config.Blacklist.male.props.bracelets[k].citizenids={citizenid}
        end
     end


     ------female

     for k,v in pairs(Config.Blacklist.female.hair) do
        if v.type and v.type[sub] then
         Config.Blacklist.female.hair[k].citizenids={citizenid}
        end
     end
 
     for k,v in pairs(Config.Blacklist.female.components.masks) do
         if v.type and v.type[sub]  then
          Config.Blacklist.female.components.masks[k].citizenids={citizenid}
         end
      end
    
      for k,v in pairs(Config.Blacklist.female.components.upperBody) do
         if v.type and v.type[sub] then
          Config.Blacklist.female.components.upperBody[k].citizenids={citizenid}
         end
      end

      for k,v in pairs(Config.Blacklist.female.components.lowerBody) do
         if v.type and v.type[sub] then
          Config.Blacklist.female.components.lowerBody[k].citizenids={citizenid}
         end
      end

      for k,v in pairs(Config.Blacklist.female.components.bags) do
         if v.type and v.type[sub] then
          Config.Blacklist.female.components.bags[k].citizenids={citizenid}
         end
      end
 
      for k,v in pairs(Config.Blacklist.female.components.shoes) do
         if v.type and v.type[sub] then
          Config.Blacklist.female.components.shoes[k].citizenids={citizenid}
         end
      end
 
      for k,v in pairs(Config.Blacklist.female.components.scarfAndChains) do
         if v.type and v.type[sub] then
          Config.Blacklist.female.components.scarfAndChains[k].citizenids={citizenid}
         end
      end
 
      for k,v in pairs(Config.Blacklist.female.components.shirts) do
         if v.type and v.type[sub] then
          Config.Blacklist.female.components.shirts[k].citizenids={citizenid}
         end
      end
 
      for k,v in pairs(Config.Blacklist.female.components.bodyArmor) do
         if v.type and v.type[sub] then
          Config.Blacklist.female.components.bodyArmor[k].citizenids={citizenid}
         end
      end
 
      for k,v in pairs(Config.Blacklist.female.components.decals) do
         if v.type and v.type[sub] then
          Config.Blacklist.female.components.decals[k].citizenids={citizenid}
         end
      end
 
      for k,v in pairs(Config.Blacklist.female.components.jackets) do
         if v.type and v.type[sub] then
          Config.Blacklist.female.components.jackets[k].citizenids={citizenid}
         end
      end
 
      for k,v in pairs(Config.Blacklist.female.props.hats) do
         if v.type and v.type[sub] then
          Config.Blacklist.female.props.hats[k].citizenids={citizenid}
         end
      end
 
      for k,v in pairs(Config.Blacklist.female.props.glasses) do
         if v.type and v.type[sub] then
          Config.Blacklist.female.props.glasses[k].citizenids={citizenid}
         end
      end
 
      for k,v in pairs(Config.Blacklist.female.props.ear) do
         if v.type and v.type[sub] then
          Config.Blacklist.female.props.ear[k].citizenids={citizenid}
         end
      end
 
      for k,v in pairs(Config.Blacklist.female.props.watches) do
         if v.type and v.type[sub] then
          Config.Blacklist.female.props.watches[k].citizenids={citizenid}
         end
      end
 
      for k,v in pairs(Config.Blacklist.female.props.bracelets) do
         if v.type and v.type[sub] then
          Config.Blacklist.female.props.bracelets[k].citizenids={citizenid}
         end
      end
end)

CreateThread(function()
   local scriptzone={}
   local outfit=nil
   for k,v in pairs(Config.Stores) do
      if v.type=="clothing" then
         scriptzone[#scriptzone+1] = PolyZone:Create(v.points, {
            name = 'clothingzone_'..k,
            debugPoly = false
        })
        scriptzone[#scriptzone]:onPlayerInOut(function(isPointInside, point)
                if isPointInside then
                  outfit = exports['qb-radialmenu']:AddOption({
                     id = 'clothoutfit',
                     title = 'Outfit',
                     icon = '#blips-clothing',
                     functiontype = 'client',
                     functionName = 'lvs_clothing:client:openOutfit',
                     shouldClose = true
                 }, outfit)
               else
                  exports['qb-radialmenu']:RemoveOption(outfit)
                  outfit = nil
                end
        end)
      end
    
     
  end

end)