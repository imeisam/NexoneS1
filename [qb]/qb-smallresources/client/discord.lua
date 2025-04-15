local QBCore = exports['qb-core']:GetCoreObject()

local select = 'Selecting Character..'

local smallText = select

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    local player = QBCore.Functions.GetPlayerData()
    smallText = 'Role Playing As '..player.charinfo.firstname.." "..player.charinfo.lastname
    SetRichPresence(smallText)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    smallText = select
    SetRichPresence(smallText)
end)

CreateThread(function()
    if LocalPlayer.state.isLoggedIn then
        local player = QBCore.Functions.GetPlayerData()
        smallText = 'Role Playing As '..player.charinfo.firstname.." "..player.charinfo.lastname
    end
    SetDiscordAppId(1241079087083163790)
    SetDiscordRichPresenceAsset("n22")
    SetDiscordRichPresenceAssetText('NexOne Community')
    SetRichPresence(smallText)
    SetDiscordRichPresenceAction(0, "Join US", "https://discord.gg/MeMV2cRVWP")
    SetDiscordRichPresenceAction(1, "Website", "https://nxone.ir")
end)