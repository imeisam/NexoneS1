local QBCore = exports['qb-core']:GetCoreObject()
local StashLoaded = false
local isAdmin = false

local function CreateStash(id, data)
    exports['qb-target']:AddBoxZone(id..'_stashhidden', data.coords, 1.5, 1.5, {
        name = id..'_stashhidden',
        debugPoly = false,
        heading = 0,
        minZ = data.coords.z - 1.5,
        maxZ = data.coords.z + 1.5,
    }, {
        options = {
            {
                num = 1,
                action = function()
                    local time = data.time
                    if time and tonumber(time) and tonumber(time) > 0 then
                        if data.anim then
                            TriggerEvent('animations:client:EmoteCommandStart', {data.anim})
                        end
                        QBCore.Functions.Progressbar("open_hidenstash", "Opening..", tonumber(time) * 1000, false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {}, {}, {}, function()
                            if data.anim then
                                TriggerEvent('animations:client:EmoteCommandStart', {'c'})
                            end
                            TriggerServerEvent("inventory:server:OpenInventory", "stash", id..'_stashhidden', {maxweight = data.weight * 1000, slots = data.slot})
                        end, function()
                            if data.anim then
                                TriggerEvent('animations:client:EmoteCommandStart', {'c'})
                            end
                        end)
                    else
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", id..'_stashhidden', {maxweight = data.weight * 1000, slots = data.slot})
                    end
                end,
                icon = "fas fa-box-open",
                label = "Open Stash",
                canInteract = function()
                    if data.item then
                        if QBCore.Functions.HasItem('phone') then
                            return true
                        end
                    else
                        return true
                    end
                    return false
                end
            },
            {
                num = 2,
                action = function()
                    TriggerServerEvent("qb-hiddenstash:server:deleteStash", id)
                end,
                icon = "fa fa-clipboard",
                label = "Delete Stash",
                canInteract = function() return isAdmin end
            },
        },
        distance = 1.5
    })
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback("qb-hiddenstash:server:GetStash", function(Data, Admin)
        isAdmin = Admin
        for k,v in pairs(Data) do
            CreateStash(k,v)
        end
    end)
end)

RegisterNetEvent('qb-hiddenstash:client:addStash', function(id, data)
    CreateStash(id, data)
end)

RegisterNetEvent('qb-hiddenstash:client:removeStash', function(id)
    exports['qb-target']:RemoveZone(id..'_stashhidden')
end)

RegisterNetEvent('qb-hiddenstash:client:createStash', function()
    local inputData = {}
    local keyboard = exports['qb-input']:ShowInput({
		header = "Enter Data",
		submitText = "Confirm",
		inputs = {
			{
				type = 'number',
				isRequired = true,
				text = "Slot",
				name = 'slot',
			},
            {
				type = 'number',
				isRequired = true,
				text = "Weight",
				name = 'weight',
			},
            {
				type = "text",
				isRequired = false,
                text = 'Animation',
				name = "anim",
			},
            {
				type = 'number',
				isRequired = false,
				text = "Proggres Time",
				name = 'time',
			},
            {
				text = "",
				name = "checkitem",
				type = "checkbox",
				options = {
					{ value = "pichgooshti", text = "Need Pichgooshti", checked = (inputData.pichgooshti == 'true') },
				}
			}
		}
	})
    if not keyboard then return end
    inputData = keyboard
	local slot = tonumber(keyboard.slot)
    local weight = tonumber(keyboard.weight)
    if not slot or not weight then return end
    local anim = keyboard.anim or false
    local time = tonumber(keyboard.time) or 0
    local item = keyboard.pichgooshti == 'true' and true or false
    local me = GetEntityCoords(PlayerPedId())
    local Data = {slot=slot,weight=weight,coords=vector3(me.x,me.y,me.z),anim=anim,time=time,item=item}
    TriggerServerEvent('qb-hiddenstash:server:createStash', Data)
end)

local Dumpsters = {
    'prop_dumpster_01a',
    'prop_dumpster_02a',
    'prop_dumpster_02b',
    'prop_dumpster_3a',
    'prop_dumpster_4a',
    'prop_dumpster_4b',
    'prop_skip_01a',
    'prop_skip_02a',
    'prop_skip_06a',
    'prop_skip_05a',
    'prop_skip_03',
    'prop_skip_10a',
}

CreateThread(function ()
    exports['qb-target']:AddTargetModel(Dumpsters, {
        options = {
          {
            label = "Open Storage",
            icon = 'fa-solid fa-trash',
            action = function(entity) 
                TriggerEvent("qb-inventory:dumpsterstash", entity)
            end,
          }
        },
        distance = 1.5,
      })

end)
local function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end
RegisterNetEvent('qb-inventory:dumpsterstash', function(entity)
    local DumpsterCoords = GetEntityCoords(entity)
    if DumpsterCoords.x < 0 then DumpsterX = -DumpsterCoords.x else DumpsterX = DumpsterCoords.x end
                if DumpsterCoords.y < 0 then DumpsterY = -DumpsterCoords.y else DumpsterY = DumpsterCoords.y end
                DumpsterX = round(DumpsterX, 2)
                DumpsterY = round(DumpsterY, 2)

    local stashConfig = {
        maxweight = 10000, 
        slots = 5,
    }
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "Dumpsters "..DumpsterX.." | "..DumpsterY, stashConfig)
end)