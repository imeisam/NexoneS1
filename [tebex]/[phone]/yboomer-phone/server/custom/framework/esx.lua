CreateThread(function()
    if Config.Framework ~= 'esx' then return end

    debugPrint("YBoomer:ESX:Loading Framework")

    local export, ESX = pcall(function() return exports.es_extended:getSharedObject() end)

    if not export then
        while not ESX do
            TriggerEvent("esx:getSharedObject", function(obj)
                ESX = obj
            end)

            Wait(500)
        end
    end

    Framework = ESX

    -- * Send a notification to a player.
    function Notify(messageData)
        lib.notify(messageData)
    end
end)
