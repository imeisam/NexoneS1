local function CustomAlert(data)
    local coords = data.coords or vec3(0.0, 0.0, 0.0)
    if data.job then job = data.job end
    local gender = GetPlayerGender()
    if not data.gender then gender = nil end


    local dispatchData = {
        message = data.message or "", -- Title of the alert
        codeName = data.dispatchCode or "NONE", -- Unique name for each alert
        code = data.code or '10-80', -- Code that is displayed before the title
        icon = data.icon or 'fas fa-question', -- Icon that is displaed after the title
        priority = data.priority or 2, -- Changes color of the alert ( 1 = red, 2 = default )
        coords = coords, -- Coords of the player
        gender = gender, -- Gender of the player
        street = GetStreetAndZone(coords), -- Street of the player
        camId = data.camId or nil, -- Cam ID ( for heists )
        color = data.firstColor or nil, -- Color of the vehicle
        callsign = data.callsign or nil, -- Callsigns
        name = data.name or nil, -- Name of either officer/ems or a player
        vehicle = data.model or nil, -- Vehicle name
        plate = data.plate or nil, -- Vehicle plate
        alertTime = data.alertTime or nil, -- How long it stays on the screen in seconds
        doorCount = data.doorCount or nil, -- How many doors on vehicle
        automaticGunfire = data.automaticGunfire or false, -- Automatic Gun or not
        alert = {
            radius = data.radius or 0, -- Radius around the blip
            recipientList = job, -- job
            sprite = data.sprite or 1, -- Sprite of the blip
            color = data.color or 1, -- Color of the blip
            scale = data.scale or 0.5, -- Scale of the blip
            length = data.length or 2, -- How long it stays on the map
            sound = data.sound or "Lose_1st", -- Alert sound
            sound2 = data.sound2 or "GTAO_FM_Events_Soundset", -- Alert sound
            offset = data.offset or "false", -- Blip / radius offset
            flash = data.flash or "false" -- Blip flash
        },
        jobs = { 'leo' },
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('CustomAlert', CustomAlert)


local function hotrun(vehicles)
    local coords = GetEntityCoords(cache.ped)
    local vehicle = GetVehicleData(vehicles)

    local dispatchData = {
        message = locale('hotrun'),
        codeName = 'hotrun',
        code = '10-34',
        icon = 'fas fa-car-burst',
        priority = 2,
        coords = coords,
        street = GetStreetAndZone(coords),
        heading = GetPlayerHeading(),
        vehicle = vehicle.name,
        plate = vehicle.plate,
        color = vehicle.color,
        class = vehicle.class,
        doors = vehicle.doors,
        alertTime = nil,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('hotrun', hotrun)

local function VehicleTheft(vehicle)
    local coords = GetEntityCoords(cache.ped)
    -- local vehicle = GetVehicleData(cache.vehicle)

    local dispatchData = {
        message = locale('vehicletheft'),
        codeName = 'vehicletheft',
        code = '10-34',
        icon = 'fas fa-car-burst',
        priority = 2,
        coords = coords,
        street = GetStreetAndZone(coords),
        heading = GetPlayerHeading(),
        vehicle = vehicle.name,
        plate = vehicle.plate,
        color = vehicle.color,
        class = vehicle.class,
        doors = vehicle.doors,
        alertTime = nil,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('VehicleTheft', VehicleTheft)

local function vehpakage()
    local coords = GetEntityCoords(cache.ped)
    local vehicle = GetVehicleData(cache.vehicle)

    local dispatchData = {
        message = locale('vehpakage'),
        codeName = 'vehpakage',
        code = '10-34',
        icon = 'fas fa-car-burst',
        priority = 2,
        coords = coords,
        street = GetStreetAndZone(coords),
        heading = GetPlayerHeading(),
        vehicle = vehicle.name,
        plate = vehicle.plate,
        color = vehicle.color,
        class = vehicle.class,
        doors = vehicle.doors,
        alertTime = nil,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('vehpakage', vehpakage)

local function Shooting()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('shooting'),
        codeName = 'shooting',
        code = '10-71',
        icon = 'fas fa-gun',
        priority = 2,
        coords = coords,
        street = GetStreetAndZone(coords),
        gender = GetPlayerGender(),
        weapon = GetWeaponName(),
        alertTime = nil,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('Shooting', Shooting)


local function roofruning()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = "Roof Runing",
        codeName = 'laundromat',
        code = '10-71',
        icon = 'fas fa-fan',
        priority = 2,
        coords = coords,
        street = GetStreetAndZone(coords),
        gender = GetPlayerGender(),
        weapon = nil,
        alertTime = nil,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('roofruning', roofruning)

local function accountflag()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = "Flagged Account Accessed",
        codeName = 'accountflag',
        code = '10-715',
        icon = 'fas fa-vault',
        priority = 2,
        coords = coords,
        street = GetStreetAndZone(coords),
        gender = GetPlayerGender(),
        weapon = nil,
        alertTime = nil,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('accountflag', accountflag)

local function VehicleShooting()
    local coords = GetEntityCoords(cache.ped)
    local vehicle = GetVehicleData(cache.vehicle)

    local dispatchData = {
        message = locale('vehicleshots'),
        codeName = 'vehicleshots',
        code = '10-72',
        icon = 'fas fa-gun',
        priority = 2,
        coords = coords,
        weapon = GetWeaponName(),
        street = GetStreetAndZone(coords),
        heading = GetPlayerHeading(),
        vehicle = vehicle.name,
        plate = vehicle.plate,
        color = vehicle.color,
        class = vehicle.class,
        doors = vehicle.doors,
        alertTime = nil,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('VehicleShooting', VehicleShooting)

local function SpeedingVehicle()
    local coords = GetEntityCoords(cache.ped)
    local vehicle = GetVehicleData(cache.vehicle)

    local dispatchData = {
        message = locale('speeding'),
        codeName = 'speeding',
        code = '10-11',
        icon = 'fas fa-car',
        priority = 2,
        coords = coords,
        street = GetStreetAndZone(coords),
        heading = GetPlayerHeading(),
        vehicle = vehicle.name,
        plate = vehicle.plate,
        color = vehicle.color,
        class = vehicle.class,
        doors = vehicle.doors,
        alertTime = nil,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('SpeedingVehicle', SpeedingVehicle)

local function Fight()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('melee'),
        codeName = 'fight',
        code = '10-10',
        icon = 'fas fa-hand-fist',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        alertTime = nil,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('Fight', Fight)

local function PrisonBreak()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('prisonbreak'),
        codeName = 'prisonbreak',
        code = '10-31',
        icon = 'fas fa-vault',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        alertTime = nil,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('PrisonBreak', PrisonBreak)

local function StoreRobbery(camId)
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('storerobbery'),
        codeName = 'storerobbery',
        code = '10-90',
        icon = 'fas fa-store',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        camId = camId,
        alertTime = nil,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('StoreRobbery', StoreRobbery)

local function Safecracker(camId)
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('safecracker'),
        codeName = 'safecracker',
        code = '10-90',
        icon = 'fas fa-store',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        camId = camId,
        alertTime = nil,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('Safecracker', Safecracker)

local function BobcatRobbery()
    local coords = GetEntityCoords(cache.ped)
    local dispatchData = {
        message = locale('bobcat'),
        codeName = 'bobcatrobbery',
        code = '10-90',
        icon = 'fas fa-vault',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        alertTime = nil,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('BobcatRobbery', BobcatRobbery)

local function TruckRobbery()
    local coords = GetEntityCoords(cache.ped)
    local dispatchData = {
        message = locale('truckescort'),
        codeName = 'truckescort',
        code = '10-90',
        icon = 'fas fa-truck-field',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        alertTime = nil,
        jobs = { 'leo' }
    }
    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('TruckRobbery', TruckRobbery)


local function atmrobery()
    local coords = GetEntityCoords(cache.ped)
    local dispatchData = {
        message = locale('atmrobery'),
        codeName = 'atmrobery',
        code = '10-90',
        icon = 'fas fa-vault',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        alertTime = nil,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('atmrobery', atmrobery)


local function FleecaBankRobbery(camId)
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('fleecabank'),
        codeName = 'bankrobbery',
        code = '10-90',
        icon = 'fas fa-vault',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        camId = camId,
        alertTime = nil,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('FleecaBankRobbery', FleecaBankRobbery)

local function PaletoBankRobbery(camId)
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('paletobank'),
        codeName = 'paletobankrobbery',
        code = '10-90',
        icon = 'fas fa-vault',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        camId = camId,
        alertTime = nil,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('PaletoBankRobbery', PaletoBankRobbery)

local function PacificBankRobbery(camId)
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('pacificbank'),
        codeName = 'pacificbankrobbery',
        code = '10-90',
        icon = 'fas fa-vault',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        camId = camId,
        alertTime = nil,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('PacificBankRobbery', PacificBankRobbery)

local function VangelicoRobbery(camId)
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('vangelico'),
        codeName = 'vangelicorobbery',
        code = '10-90',
        icon = 'fas fa-gem',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        camId = camId,
        alertTime = nil,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('VangelicoRobbery', VangelicoRobbery)

local function HouseRobbery(coords)
    local dispatchData = {
        message = locale('houserobbery'),
        codeName = 'houserobbery',
        code = '10-90',
        icon = 'fas fa-house',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        alertTime = nil,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('HouseRobbery', HouseRobbery)

local function YachtHeist()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('yachtheist'),
        codeName = 'yachtheist',
        code = '10-65',
        icon = 'fas fa-house',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        alertTime = nil,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('YachtHeist', YachtHeist)

local function DrugSale()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('drugsell'),
        codeName = 'suspicioushandoff',
        code = '10-13',
        icon = 'fas fa-tablets',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        alertTime = nil,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('DrugSale', DrugSale)

local function SuspiciousActivity()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('susactivity'),
        codeName = 'susactivity',
        code = '10-66',
        icon = 'fas fa-tablets',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        alertTime = nil,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('SuspiciousActivity', SuspiciousActivity)

local function CarJacking(vehicle)
    local coords = GetEntityCoords(cache.ped)
    local vehicle = GetVehicleData(vehicle)

    local dispatchData = {
        message = locale('carjacking'),
        codeName = 'carjack',
        code = '10-35',
        icon = 'fas fa-car',
        priority = 2,
        coords = coords,
        street = GetStreetAndZone(coords),
        heading = GetPlayerHeading(),
        vehicle = vehicle.name,
        plate = vehicle.plate,
        color = vehicle.color,
        class = vehicle.class,
        doors = vehicle.doors,
        alertTime = nil,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('CarJacking', CarJacking)

local function InjuriedPerson()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('persondown'),
        codeName = 'civdown',
        code = '10-69',
        icon = 'fas fa-face-dizzy',
        priority = 1,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        alertTime = 10,
        jobs = { 'ems' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('InjuriedPerson', InjuriedPerson)

local function DeceasedPerson()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('civbled'),
        codeName = 'civdead',
        code = '10-69',
        icon = 'fas fa-skull',
        priority = 1,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        alertTime = 10,
        jobs = { 'ems' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('DeceasedPerson', DeceasedPerson)

local function OfficerDown()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('officerdown'),
        codeName = 'officerdown',
        code = '10-13B',
        icon = 'fas fa-skull',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        name = PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname,
        callsign = PlayerData.metadata["callsign"],
        alertTime = 10,
        jobs = { 'ems', 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('OfficerDown', OfficerDown)

RegisterNetEvent("qb-dispatch:client:officerdown", function() OfficerDown() end)

local function OfficerBackup()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('officerbackup'),
        codeName = 'officerbackup',
        code = '10-35',
        icon = 'fas fa-skull',
        priority = 1,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        name = PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname,
        callsign = PlayerData.metadata["callsign"],
        alertTime = 10,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('OfficerBackup', OfficerBackup)

RegisterNetEvent("qb-dispatch:client:officerbackup", function() OfficerBackup() end)

local function OfficerInDistress()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('officerdistress'),
        codeName = 'officerdistress',
        code = '10-13A',
        icon = 'fas fa-skull',
        priority = 1,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        name = PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname,
        callsign = PlayerData.metadata["callsign"],
        alertTime = 10,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('OfficerInDistress', OfficerInDistress)

local function EmsDown()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('emsdown'),
        codeName = 'emsdown',
        code = '10-12B',
        icon = 'fas fa-skull',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        name = PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname,
        callsign = PlayerData.metadata["callsign"],
        alertTime = 10,
        jobs = { 'ems', 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('EmsDown', EmsDown)

local function Explosion()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('explosion'),
        codeName = 'explosion',
        code = '10-80',
        icon = 'fas fa-fire',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        alertTime = nil,
        jobs = { 'leo', 'ems' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('Explosion', Explosion)

local function PhoneCall(message, anonymous, job, type,noanim)
    local coords = GetEntityCoords(cache.ped)

    if IsCallAllowed(message) then
        if noanim then
            PhoneAnimation()
        end

        local dispatchData = {
            message = anonymous and locale('anon_call') or locale('call'),
            codeName = type == '311' and '311call' or '911call',
            code = type,
            icon = 'fas fa-phone',
            priority = 2,
            coords = coords,
            name = anonymous and locale('anon') or (PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname),
            number = anonymous and locale('hidden_number') or PlayerData.charinfo.phone,
            information = message,
            street = GetStreetAndZone(coords),
            alertTime = nil,
            jobs = job
        }

        TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
        -- TriggerServerEvent('qb-dispatch:server:log', type, message)
    end
end

--- @param data string -- Message
--- @param type string -- What type of emergency
--- @param anonymous boolean -- Is the call anonymous
local emsmsg=false
RegisterNetEvent('qb-dispatch:client:sendEmergencyMsg', function(data, type, anonymous,noanim)
    local jobs = { ['911'] = { 'leo' }, ['311'] = { 'ems', 'leo' } }
    if emsmsg then return end
    emsmsg=true
    SetTimeout(20000, function()
        emsmsg = false
    end)
    TriggerServerEvent('qb-log:server:CreateLog', type, 'Dispatch Call', 'red', PlayerData.charinfo.firstname..' '..PlayerData.charinfo.lastname..' ('..PlayerData.citizenid..')\n'..data)
 
    PhoneCall(data, anonymous, jobs[type], type,noanim)
end)


local function ArtGalleryRobbery()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('artgalleryrobbery'),
        codeName = 'artgalleryrobbery',
        code = '10-90',
        icon = 'fas fa-brush',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        alertTime = nil,
        jobs = { 'leo' }
    }
    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('ArtGalleryRobbery', ArtGalleryRobbery)

local function HumaneRobbery()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('humanelabsrobbery'),
        codeName = 'humanelabsrobbery',
        code = '10-90',
        icon = 'fas fa-flask-vial',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        alertTime = nil,
        jobs = { 'leo' }
    }
    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)

end
exports('HumaneRobbery', HumaneRobbery)

local function TrainRobbery()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('trainrobbery'),
        codeName = 'trainrobbery',
        code = '10-90',
        icon = 'fas fa-train',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        alertTime = nil,
        jobs = { 'leo' }
    }
    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)

end
exports('TrainRobbery', TrainRobbery)

local function VanRobbery()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('vanrobbery'),
        codeName = 'vanrobbery',
        code = '10-90',
        icon = 'fas fa-van-shuttle',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        alertTime = nil,
        jobs = { 'leo' }
    }
    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)

end
exports('VanRobbery', VanRobbery)

local function UndergroundRobbery()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('undergroundrobbery'),
        codeName = 'undergroundrobbery',
        code = '10-90',
        icon = 'fas fa-person-rays',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        alertTime = nil,
        jobs = { 'leo' }
    }
    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('UndergroundRobbery', UndergroundRobbery)

local function DrugBoatRobbery()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('drugboatrobbery'),
        codeName = 'drugboatrobbery',
        code = '10-65',
        icon = 'fas fa-ship',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        alertTime = nil,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('DrugBoatRobbery', DrugBoatRobbery)

local function UnionRobbery()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('unionrobbery'),
        codeName = 'unionrobbery',
        code = '10-90',
        icon = 'fas fa-truck-field',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        alertTime = nil,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('UnionRobbery', UnionRobbery)

local function CarBoosting(vehicle)
    local coords = GetEntityCoords(cache.ped)
    local vehicle = GetVehicleData(vehicle or cache.vehicle)

    local dispatchData = {
        message = locale('carboosting'),
        codeName = 'carboosting',
        code = '10-50',
        icon = 'fas fa-car',
        priority = 2,
        coords = coords,
        street = GetStreetAndZone(coords),
        heading = GetPlayerHeading(),
        vehicle = vehicle.name,
        plate = vehicle.plate,
        color = vehicle.color,
        class = vehicle.class,
        doors = vehicle.doors,
        alertTime = nil,
        jobs = { 'leo' }
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('CarBoosting', CarBoosting)

local function SignRobbery()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('signrobbery'),
        codeName = 'signrobbery',
        code = '10-10',
        icon = 'fab fa-artstation',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        alertTime = nil,
        jobs = { 'leo'}
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('SignRobbery', SignRobbery)


local function LaundroMat()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('laundromat'),
        codeName = 'laundromat',
        code = '10-90',
        icon = 'fas fa-theater-masks',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        jobs = { 'leo', 'police'}
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('LaundroMat', LaundroMat)

local function Exchange()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('exchange'),
        codeName = 'Exchange',
        code = '10-90',
        icon = 'fas fa-theater-masks',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        jobs = { 'leo', 'police'}
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('Exchange', Exchange)

local function anklet()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('anklet'),
        codeName = 'anklet',
        code = '10-90',
        icon = 'fas fa-theater-masks',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        jobs = { 'leo', 'police'}
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('anklet', anklet)


local function ammunation()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('ammunation'),
        codeName = 'ammunation',
        code = '10-90',
        icon = 'fas fa-theater-masks',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        jobs = { 'leo', 'police'}
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('ammunation', ammunation)

local function chopshop(vehicle)
   
    local coords = GetEntityCoords(cache.ped)
    local vehicles = GetVehicleData(vehicle)
    local dispatchData = {
        message = locale('chopshop'),
        codeName = 'chopshop',
        code = '10-90',
        icon = 'fas fa-theater-masks',
        priority = 2,
        vehicle = vehicles.name,
        plate = vehicles.plate,
        coords = coords,
        gender = nil,
        street = nil,
        jobs = { 'leo', 'police'}
    }

    TriggerServerEvent('qb-dispatch:server:notify', dispatchData)
end
exports('chopshop', chopshop)