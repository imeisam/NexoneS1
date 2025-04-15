local QBCore = exports['qb-core']:GetCoreObject()
local vehspawn=vector4(-532.80871582031, -890.34216308594, 24.536418914795, 177.56028747559)
CreateThread(function()
exports['qb-interact']:AddInteraction({
    coords = vector3(-538.91247558594, -886.24169921875, 25.196620941162),
    distance =3.5,
    interactDst = 3.5,
    id = "weazelcar",
    name ="weazelcar",
    groups = {
        ['lsnews'] =0,
    },
    options ={
        {
            action = function()
                getweazelvan()
            end,
            label = "GET Weazel News Van",
        },
        {
            action = function()
                returnweazelvan()
            end,
            label = "Return Weazel News Van",
        },
    }
})

end)

function getweazelvan()
    if IsAnyVehicleNearPoint(vehspawn.x, vehspawn.y, vehspawn.z, 5.0) then
        QBCore.Functions.Notify("Vehicle Spot is occupied", "error", 4500)
        return
    end
	QBCore.Functions.SpawnVehicle("speedo", function(veh)
        SetVehicleModKit(veh, 0)
        SetVehicleMod(veh, 48,1, false)
        SetVehicleDirtLevel(veh,0)
		NetworkRequestControlOfEntity(veh)
		SetEntityAsMissionEntity(veh, true, true)
		SetEntityHeading(veh, vehspawn.w)
		TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', GetVehicleNumberPlateText(veh))
		Wait(500)
        
	end, vehspawn.xyz, true)

end

function returnweazelvan()
   veh,disc= QBCore.Functions.GetClosestVehicle()
		if GetEntityModel(veh) == GetHashKey("speedo") and disc<=5 then
			QBCore.Functions.DeleteVehicle(veh)
			return
		end
end