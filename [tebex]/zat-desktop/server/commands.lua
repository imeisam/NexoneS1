Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports[Config.FrameworkPseudo]:GetCoreObject()
    end
end)

Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        -- set reputation for specified pc using username (example /setmrep zat_1ec57fbb 50)
        QBCore.Commands.Add("setmrep", "set reputation for specified pc using username", {{name = "username", help = "User Name"}, {name = "Reputation", help = "Reputation Points to set"}}, false, function(source, args)
            local src = source
            if args[1] ~= nil and args[2] ~= nil then
                SetRep(args[1], tonumber(args[2]))
                NotifyServerFramework(src, "successfully set "..args[2].." rep points to PC with username : "..args[1])
            end
        end, "god")
        -- set reputation for specified pc using username (example /setbutcoin zat_1ec57fbb 50)
        QBCore.Commands.Add("setbutcoin", "set butcoins wallet for specified pc using username", {{name = "username", help = "User Name"}, {name = "butcoins", help = "BUTC wallet"}}, false, function(source, args)
            local src = source
            if args[1] ~= nil and args[2] ~= nil then
                SetWallet(args[1], tonumber(args[2]))
                NotifyServerFramework(src, "successfully set "..args[2].." BUTCOINS points to PC with username : "..args[1])
            end
        end, "god")
    end
end)

