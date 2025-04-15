local QBCore = exports['qb-core']:GetCoreObject()
local emsbag1 = nil
local bagsid=nil
local bag={}

CreateThread(function()
    exports['qb-interact']:AddModelInteraction({
        model ='prop_cs_shopping_bag',
        offset = vec3(0.0, 0.0, 0.0),
        name = 'medicbag', 
        id = 'medicbag',
        distance = 5.0,
        interactDst = 2.0,
        -- groups = {
        --     ['ambulance'] =0,
        -- },
        options = {
            {
                label ="Ems Bag",
                event   = "Ranjit-EmsBag:Client:StorageAmbulanceBag",
                canInteract = function(entity)
                  return not IsEntityAttached(entity)
                end
            },
            {
                label ="Take Back Ems Bag",
                event   = "Ranjit-EmsBag:Client:GuardarAmbulanceBag",
                canInteract = function(entity)
                    return not IsEntityAttached(entity)
                  end
            },
        }
    })
end)

local function dropemsbag()
    if bagsid then
        TriggerServerEvent("Ranjit-EmsBag:Server:bagcoord",bagsid, GetEntityCoords(emsbag1))
        bagsid=nil
    end
    DetachEntity(emsbag1)
    PlaceObjectOnGroundProperly(emsbag1)
end
local function spawnemsbag()
    local hasBag = true
    CreateThread(function()
        while hasBag do
            Wait(0)
            if IsControlJustReleased(0, 38) then -- If E is pressed it drop the  bag
                hasBag = false
                dropemsbag()
                Wait(1000)
            end
        end
    end)
end
local ObjectList = {}


RegisterNetEvent('Ranjit-EmsBag:Client:getbags', function(data)
    bags=data
end)

RegisterNetEvent('Ranjit-EmsBag:Client:SpawnAmbulanceBag', function(item)
    local hash = GetHashKey('prop_cs_shopping_bag')
    local ped = PlayerPedId()

    if item and item.info and item.info.id then
        bagsid=item.info.id
    end
  
    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(ped, 0.0, 3.0, 0.5))
    QBCore.Functions.LoadModel(hash)
    emsbag1 = CreateObjectNoOffset(hash, x, y, z, true, false)
    SetModelAsNoLongerNeeded(hash)
    AttachEntityToEntity(emsbag1, ped, GetPedBoneIndex(ped, 57005), 0.42, 0, -0.05, 0.10, 270.0, 60.0, true, true, false, true, 1, true)
        spawnemsbag()
    TriggerServerEvent("Ranjit-EmsBag:Server:RemoveItem","emsbag",1)
end)

RegisterNetEvent('Ranjit-EmsBag:Client:spawnLight', function(item)

    TriggerServerEvent("Ranjit-EmsBag:Server:SpawnAmbulanceBag", "emsbag",item)
end)

RegisterNetEvent('Ranjit-EmsBag:Client:GuardarAmbulanceBag')
AddEventHandler("Ranjit-EmsBag:Client:GuardarAmbulanceBag", function()
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    local playerPedPos = GetEntityCoords(PlayerPedId(), true)
    local AmbulanceBag = GetClosestObjectOfType(playerPedPos, 2.0, GetHashKey("prop_cs_shopping_bag"), false, false, false)
    local playerPed = PlayerPedId()
    local AmbulanceBagcoord = GetEntityCoords(AmbulanceBag, true)
    local mdbagid=nil
    for k,v in pairs(bags) do
       if #(v-AmbulanceBagcoord)<2 then
            mdbagid=k
       end
    end

    if not mdbagid then return end
    TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD")
    progressBar("Taking Back the Ems Bag...")
    Wait(2500)
    Notify("Ems Bag Taken Back with success.")
    SetEntityAsMissionEntity(AmbulanceBag, 1, 1)
    DeleteObject(AmbulanceBag)
    if mdbagid then
      TriggerServerEvent("Ranjit-EmsBag:Server:AddItem","emsbag",1,mdbagid)
        TriggerServerEvent("Ranjit-EmsBag:Server:bagcoord",mdbagid,nil)
    end

end)

local citizenid = nil
AddEventHandler("Ranjit-EmsBag:Client:StorageAmbulanceBag", function()
    local mdbagid=nil
    local playerPedPos = GetEntityCoords(PlayerPedId(), true)
    local AmbulanceBag = GetClosestObjectOfType(playerPedPos, 10.0, GetHashKey("prop_cs_shopping_bag"), false, false, false)
    local AmbulanceBagcoord = GetEntityCoords(AmbulanceBag, true)
    for k,v in pairs(bags) do
        if #(v-AmbulanceBagcoord)<1 then
         mdbagid=k
        end
     end
 
     if mdbagid>0 then
        TriggerEvent("inventory:client:SetCurrentStash", "medicbag"..mdbagid)
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "medicbag"..mdbagid, {
            maxweight = Config.Stash.MaxWeighStash,
            slots = Config.Stash.MaxSlotsStash,
        })
     end
   
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback("Ranjit-EmsBag:Server:getbascallback", function(data)
        bag=data
    end)
end)


