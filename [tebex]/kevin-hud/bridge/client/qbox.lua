if GetResourceState('qbx_core') ~= 'started' then return end

function showNotify(text, type)
    exports.qbx_core:Notify(text, type)
end

function getPlayerMetadata()
    hud.hunger =  exports.qbx_core:GetPlayerData().metadata.hunger
    hud.thirst = exports.qbx_core:GetPlayerData().metadata.thirst
    hud.stress = exports.qbx_core:GetPlayerData().metadata.stress
end

function getPlayerRadio()
    return LocalPlayer.state.radioChannel or 0
end

function getSeatBeltState()
    return LocalPlayer.state?.seatbelt
end

function getVehicleNitrosLevel(vehicle)
    return Entity(vehicle).state.nitro or 0
end

function getVehicleFuelLevel(vehicle)
    return Entity(vehicle).state.fuel
end

function getPlayerJob()
    return exports.qbx_core:GetPlayerData().job.name
end

function getPlayerMoney()
    local money = lib.callback.await('kevin-hud:server:getPlayerMoney', false)
    return money
end


AddStateBagChangeHandler('stress', ('player:%s'):format(cache.serverId), function(_, _, value)
    hud.stress = value
end)

AddEventHandler("pma-voice:radioActive", function(radioTalking)
    hud.usingRadio = radioTalking
end)

RegisterNetEvent('hud:client:UpdateNeeds', function(newHunger, newThirst)
    hud.hunger = newHunger
    hud.thirst = newThirst
end)