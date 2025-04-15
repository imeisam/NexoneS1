function DoProgress(isBank)
    if Config.Framework == "qb" and Config.Progress == "qb" then
        TaskStartScenarioInPlace(cache.ped, 'PROP_HUMAN_ATM', 0, true)
        QBCore.Functions.Progressbar("open_atm_bank", isBank and Locales["open_bank"] or Locales["open_atm"], 5000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            if isBank then
                OpenBank()
            else
                OpenAtm()
            end
        end, function()
        end)
    else 
        TaskStartScenarioInPlace(cache.ped, 'PROP_HUMAN_ATM', 0, true)
        if lib.progressCircle({
			duration = 5000,
			label = isBank and Locales["open_bank"] or Locales["open_atm"],
			useWhileDead = false,
			canCancel = true,
			disable = {
				car = true,
			},
			position= 'bottom',
		}) then 
			ClearPedTasksImmediately(PlayerPedId())
            if isBank then
                OpenBank()
            else
                OpenAtm()
            end
		else 
			ClearPedTasksImmediately(PlayerPedId())
		end
    end
end

function DoCloseProgress()
    if Config.Framework == "qb" and Config.Progress == "qb" then
        TaskStartScenarioInPlace(cache.ped, 'PROP_HUMAN_ATM', 0, true)
        QBCore.Functions.Progressbar("open_atm_bank", Locales["signing_off"], 2000, false, false, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            ClearPedTasksImmediately(PlayerPedId())
        end, function()
            ClearPedTasksImmediately(PlayerPedId())
        end)
    else 
        TaskStartScenarioInPlace(cache.ped, 'PROP_HUMAN_ATM', 0, true)
        if lib.progressCircle({
			duration = 2000,
			label = Locales["signing_off"],
			useWhileDead = false,
			canCancel = false,
			disable = {
				car = true,
			},
			position= 'bottom',
		}) then 
			ClearPedTasksImmediately(PlayerPedId())
		else 
			ClearPedTasksImmediately(PlayerPedId())
		end
    end
end

exports('DoProgress', DoProgress)
exports("OpenBank", OpenBank)
exports("OpenAtm", OpenAtm)