local QBCore = exports['qb-core']:GetCoreObject()

Config.xraygate = {
   ['dojdowngate1']={pz={coord=vector3(331.71, -1659.9, 38.5),w= 1.2,h=1.15, heading=50,minZ=37.5,maxZ=39.9},safestash={coord=vector3(332.3127746582, -1657.7315673828, 38.500297546387)}},
   ['dojdowngate2']={pz={coord=vector3(356.5, -1630.35, 38.5),w= 1.2,h=1.15, heading=50,minZ=37.5,maxZ=39.9},safestash={coord=vector3(357.21453857422, -1628.1695556641, 38.500015258789)}},
   ['dojupgate']={pz={coord=vector3(332.79, -1644.62, 47.24),w= 1.15,h=1.2, heading=320,minZ=46.24,maxZ=48.44},safestash={coord=vector3(332.11016845703, -1646.6928710938, 47.243850708008)}},
   ['govermentgate']={pz={coord=vector3(334.06, -1639.18, 54.59),w= 1.15,h=1.2, heading=320,minZ=54.0,maxZ=55.50},safestash={coord=vector3(334.20367431641, -1640.6857910156, 54.587757110596)}},
}
Config.illigalitemgate={"c4_bomb","weapon_dagger","weapon_bat","weapon_bottle","weapon_crowbar","weapon_flashlight","weapon_golfclub","weapon_hammer","weapon_hatchet","weapon_knuckle","weapon_knife","weapon_machete","weapon_switchblade","weapon_nightstick","weapon_wrench","weapon_battleaxe","weapon_poolcue","weapon_briefcase","weapon_briefcase_02","weapon_garbagebag","weapon_handcuffs","weapon_bread","weapon_stone_hatchet","weapon_candycane","weapon_pistol","weapon_pistol_mk2","weapon_combatpistol","weapon_appistol","weapon_stungun","weapon_pistol50","weapon_snspistol","weapon_heavypistol","weapon_vintagepistol","weapon_flaregun","weapon_marksmanpistol","weapon_revolver","weapon_revolver_mk2","weapon_doubleaction","weapon_snspistol_mk2","weapon_ceramicpistol","weapon_navyrevolver","weapon_gadgetpistol","weapon_pistolxm3","weapon_microsmg","weapon_smg","weapon_smg_mk2","weapon_assaultsmg","weapon_combatpdw","weapon_machinepistol","weapon_minismg","weapon_pumpshotgun","weapon_sawnoffshotgun","weapon_assaultshotgun","weapon_bullpupshotgun","weapon_musket","weapon_heavyshotgun","weapon_dbshotgun","weapon_autoshotgun","weapon_pumpshotgun_mk2","weapon_combatshotgun","weapon_assaultrifle","weapon_assaultrifle_mk2","weapon_carbinerifle","weapon_carbinerifle_mk2","weapon_advancedrifle","weapon_specialcarbine","weapon_bullpuprifle","weapon_compactrifle","weapon_specialcarbine_mk2","weapon_bullpuprifle_mk2","weapon_militaryrifle",
"weapon_tacticalrifle", "weapon_mg", "weapon_combatmg", "weapon_gusenberg", "weapon_combatmg_mk2",  "weapon_sniperrifle", "weapon_heavysniper", "weapon_marksmanrifle", "weapon_remotesniper",
"weapon_heavysniper_mk2", "weapon_marksmanrifle_mk2",
"weapon_grenade", "weapon_bzgas", "weapon_molotov", "weapon_stickybomb", "weapon_proxmine", "weapon_pipebomb", "weapon_smokegrenade", "weapon_flare",}

Config.blacklistjobgate={["police"]=true,["ambulance"]=true,["goverment"]=true,["justice"]=true}
Config.jobcheckerstash={["police"]=true,["goverment"]=true,["justice"]=true}

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    xrayzone={}
    for k, v in pairs(Config.xraygate) do
        xrayzone[#xrayzone+1] = BoxZone:Create(
            v.pz.coord,  v.pz.w,  v.pz.h, {
            name="xraygate",
            heading=v.pz.heading,
            debugPoly = false,
            minZ =  v.pz.minZ,
            maxZ =  v.pz.maxZ,
        })

        
    exports['qb-interact']:AddInteraction({
        coords =v.safestash.coord,
        distance = 3.0, -- optional
        interactDst = 1.0, -- optional
        id = "xraygateinventory-"..k, -- needed for removing interactions
        name = "xraygateinventory-"..k, -- optional
        options = {
             {
                id = "xraygateinventory-"..k,
                label = 'Safe Stash',
                event =  "police:client:xraystash",
                args = {stashid=k,cid=QBCore.Functions.GetPlayerData().citizenid}
            },
            {
                canInteract = function()
                    return Config.jobcheckerstash[QBCore.Functions.GetPlayerData().job.name]
                end,
                label = 'Check Safe Stash',
                event =  "police:client:xraycitizen",
                args = {stashid=k}
            },
        }
    })
    end
    local xraygate = ComboZone:Create(xrayzone, {name = "xrayzone", debugPoly = false})
    xraygate:onPlayerInOut(function(isPointInside)
            if isPointInside then
                backpack=QBCore.Functions.GetPlayerData().metadata.backpack
              if  Config.blacklistjobgate[QBCore.Functions.GetPlayerData().job.name] then return end
                for k, v in pairs(Config.illigalitemgate) do
                    if QBCore.Functions.HasItem(v,nil,true) then
                        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10.0, "Alarm2", 0.30)
                        break
                    end
                end
            
            end
    end)

end)


RegisterNetEvent('police:client:xraystash', function(data)
    local cid=data.args.cid
    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'xraygate_'..data.args.stashid.."_"..cid, {
        maxweight = 100000,
        slots = 10,
    })
    TriggerEvent("inventory:client:SetCurrentStash", 'xraygate_'..data.args.stashid.."_"..cid)
end)


RegisterNetEvent('police:client:xraycitizen', function(data)
    TriggerServerEvent("police:server:getxraycitizen", data.args.stashid)
end)

RegisterNetEvent('police:client:getxraycitizen', function(data,stashid)
    local menu = {}
    menu[#menu+1] = {
          header = "Citizen Safe Stash",
          isMenuHeader = true,
      }
      for k, v in pairs(data) do
          menu[#menu+1] =   {
              header = v.name,
              txt = 'Citizenid: '..v.cid,
              icon = "fas fa-triangle-exclamation",
              params = {
                  event = "police:client:xraystash",
                  args = {
                    args={cid=v.cid,stashid=stashid}
                  },
              },
          }

      end

      menu[#menu+1] = {
      header = "Cancel",
      txt = "",
      icon = "fas fa-times-circle",
  }

  exports['qb-menu']:openMenu(menu)


end)
 
  