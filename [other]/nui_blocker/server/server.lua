
local kick_msg = "Hmm, what you wanna do in this inspector?"
function ExtractIdentifiers(src)
    
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)
        
        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end

function sendToDiscord (source,message,identifier)
    local name = GetPlayerName(source)
    TriggerEvent('qb-log:server:CreateLog', 'nuiblocker', 'Nui Blocker', 'red', "`Player`: **"..name.."**\nSteam: **"..identifier.steam.."** \nIP: **"..identifier.ip.."**\nDiscord: **"..identifier.discord.."**\nFivem: **"..identifier.license.."**",true)
end

RegisterServerEvent(GetCurrentResourceName())
AddEventHandler(GetCurrentResourceName(), function()
    local src = source
    local identifier = ExtractIdentifiers(src)
	if not allowlist[identifier.discord] then
	   sendToDiscord (src,identifier)
       DropPlayer(src, kick_msg)		
	end
end)
