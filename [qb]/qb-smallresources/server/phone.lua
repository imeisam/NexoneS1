
local QBCore = exports['qb-core']:GetCoreObject()
QBCore.Commands.Add("recoversimcard", "Recover Sim Card", {{name="phoneimei", help="Phone IMEI"},{name="simnumber", help="Sim Number"}}, true, function(source, args)
    local src = source
    print("tes")
    exports['yseries']:ChangePhoneNumber(args[1], args[2])
end,'admin')

-- 0890421
-- ZSpFvLYARWq5bgs