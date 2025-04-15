Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports[Config.FrameworkPseudo]:GetCoreObject()
    end
end)

function NotifyFramework(text, type)
    if Config.Framework == "qb" then
        QBCore.Functions.Notify(text, type)
    elseif Config.Framework == "esx" then
        ESX.ShowNotification(text, type)
    end
end

function TriggerServerCallback(name, cb, ...)
    if Config.Framework == "qb" then
        QBCore.Functions.TriggerCallback(name, cb, ...)
    else
        ESX.TriggerServerCallback(name, cb, ...)
    end
end

function SendPhoneNotification(coords)
    if Config.phone == 'qb-phone' then
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = 'Drone App',
            subject = 'Delivery Ready',
            message = 'The drone will be in position in the next few minutes. Please hurry up before someone else steals the package.',
            button = {
                enabled = true,
                buttonEvent = "zat-desktop:client:setLocation",
                buttonData = coords
            }
        })
    end
end
