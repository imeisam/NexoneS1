AddEventHandler("qb-companions:showPetshop", function(Args)
    local data = {}
    local pArgs = Args.parameters
    for _, pet in ipairs(pArgs["Pets"]) do
        pet.type = pArgs["Type"]
        table.insert(data, {
            header = pet.name,
            txt = "$" .. pet.price,
			params = {
                event = "qb-pets:purchasePet",
                args = pet
            }
        })
    end
    exports['qb-menu']:openMenu(data)
end)

AddEventHandler("qb-pets:purchasePet", function(params)
    local keyboard = exports['qb-input']:ShowInput({
        header = "Animal name",
        submitText = "Confirm",
        inputs = {
            {
                type = 'text',
                isRequired = true,
                text = "name",
                name = 'input',
            }
        }
    })
    if keyboard and keyboard.input then
        TriggerServerEvent("qb-pets:purchasePet", params, keyboard.input)
    end
end)

Citizen.CreateThread(function()
    for i, v in ipairs(ShopConfig) do
        if v.Blip then
            local blip = AddBlipForCoord(v.Blip.coords)
            SetBlipSprite(blip, v.Blip.type)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, v.Blip.color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v["Label"])
            EndTextCommandSetBlipName(blip)
        end
        RequestModel(v["NPC"].model)
        while not HasModelLoaded(v["NPC"].model) do
            Wait(1)
        end
        local ped = CreatePed(v["NPC"].pedType, v["NPC"].model, v["NPC"].position.coords.x, v["NPC"].position.coords.y, v["NPC"].position.coords.z -1, v["NPC"].position.heading, false, false)
        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskStartScenarioInPlace(ped, v["NPC"].scenario, 0, true)
        exports['qb-target']:AddCircleZone('petshop'..i, vector3(v["NPC"].position.coords.x, v["NPC"].position.coords.y, v["NPC"].position.coords.z), 2.0,{
            name = 'petshop'..i, debugPoly = false, useZ=true }, {
            options = {
                {
                    label = v["Label"],
                    icon = 'fas fa-paw',
                    event = "qb-companions:showPetshop",
                    job = v["Job"],
                    canInteract = function()
                        if not v["Division"] then
                            return true
                        end
                        if QBCore.Functions.GetPlayerData().job.isboss or QBCore.Functions.HasDivision('hc') then
                            return true
                        end
                        for k,v in ipairs(v["Division"]) do
                            if QBCore.Functions.HasDivision(v) then
                                return true
                            end
                        end
                        return false
                    end,
                    parameters = v
                }
            },
            distance = 2.0
        })
    end
end)