local standardVolumeOutput = 0.3
local hasPlayerLoaded = false
local ronyPlayed = false

local function PlayVoice(soundFile, soundVolume)
    SendNUIMessage({
        transactionType = 'playSound',
        transactionFile  = soundFile,
        transactionVolume = soundVolume or standardVolumeOutput
    })
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    hasPlayerLoaded = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    hasPlayerLoaded = false
end)

RegisterNetEvent('InteractSound_CL:PlayOnOne', function(soundFile, soundVolume)
    if hasPlayerLoaded then
        PlayVoice(soundFile, soundVolume)
    end
end)

RegisterNetEvent('InteractSound_CL:StopSound', function()
    SendNUIMessage({
        transactionType = 'stopSound'
    })
end)

RegisterNetEvent('InteractSound_CL:PlayWithinDistance', function(otherPlayerCoords, maxDistance, soundFile, soundVolume)
	if hasPlayerLoaded then
		local myCoords = GetEntityCoords(PlayerPedId())
		local distance = #(myCoords - otherPlayerCoords)
		if distance <= maxDistance then
			PlayVoice(soundFile, soundVolume)
		end
	end
end)

RegisterNetEvent('InteractSound_CL:PlayRony', function(otherPlayerCoords, id, soundFile, soundVolume)
	if hasPlayerLoaded then
		local myCoords = GetEntityCoords(PlayerPedId())
		local distance = #(myCoords - otherPlayerCoords)
		if distance <= 3.0 then
            ronyPlayed = true
			PlayVoice(soundFile, soundVolume)
            CreateThread(function()
                while ronyPlayed do
                    local rony = GetPlayerPed(GetPlayerFromServerId(id))
                    if DoesEntityExist(rony) then
                        local myCoords = GetEntityCoords(PlayerPedId())
                        local otherPlayerCoords = GetEntityCoords(rony)
                        local distance = #(myCoords - otherPlayerCoords)
                        if distance > 5.0 then
                            ronyPlayed = false
                            SendNUIMessage({
                                transactionType = 'stopSound'
                            })
                        end
                    else
                        ronyPlayed = false
                        SendNUIMessage({
                            transactionType = 'stopSound'
                        })
                    end
                    Wait(500)
                end
            end)
		end
	end
end)

RegisterNetEvent('InteractSound_CL:StopSoundRony', function()
    if ronyPlayed then
        ronyPlayed = false
        SendNUIMessage({
            transactionType = 'stopSound'
        })
    end
end)