CreateThread( function()
	local resetcounter = 0
	local jumpDisabled = false
  	while true do
		local ped = PlayerPedId()
    	Citizen.Wait(10)
		if jumpDisabled and resetcounter > 0 and IsPedJumping(ped) then
			if not LocalPlayer.state.isSmart then
				SetPedToRagdoll(ped, 1000, 1000, 3, 0, 0, 0)
			end
			resetcounter = 0
		end
		if not jumpDisabled and IsPedJumping(ped) then
			if math.random(2) == 2 then
				jumpDisabled = true
			end
			resetcounter = 1000
			Citizen.Wait(1200)
		end
		if resetcounter > 0 then
			resetcounter = resetcounter - 1
		else
			if jumpDisabled then
				resetcounter = 0
				jumpDisabled = false
			end
		end
	end
end)