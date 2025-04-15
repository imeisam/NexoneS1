local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-hunting:client:sell', function()
    local src = source
    local carcasses = Config.Carcasses
    TriggerServerEvent('qb-hunting:server:sell', carcasses)
  end)

CreateThread(function()
    local coords = vector4(-679.14508056641, 5834.5336914062, 17.331295013428, 136.43064880371)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 141)
    SetBlipScale(blip, 0.6)
    SetBlipDisplay(blip, 4)
    SetBlipColour(blip, 2)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Hunting Store')
    EndTextCommandSetBlipName(blip)
    --[[local model = GetHashKey("mp_m_weed_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    local ped = CreatePed(0, model, coords.x, coords.y, coords.z-1, coords.w, false, false)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
    exports['qb-target']:AddTargetEntity(ped, {
        options = {
            {
                event = "qb-hunting:client:sell",
                icon = "fas fa-paw",
                label = "Sell Carcasses"
            },
            {
                icon = "fa-solid fa-store",
                label = "Store",
                action = function()
                    TriggerEvent('qb-shops:open', 'hunting')
                end,
                canInteract = function()
                    if LocalPlayer.state.isLoggedIn then
                        local statelic = QBCore.Functions.GetPlayerData().metadata.licences.hunting
                        if statelic and statelic ~= 'revoked' then
                            return true
                        end
                    end
                    return false 
                end
            },
        },
        distance = 1.5
    })]]
end)