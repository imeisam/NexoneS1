-- Door menu, just in case u don't use ox_lib context menu, make sure to send all required args
function gangDoor(identifier, type, gang, isOpen, isExit)
    local options = {}
    if isExit then
        options[#options+1] = {
            title = Lang['exit_property'],
            event = 'av_gangs:exit',
            args = {}
        }
    else
        options[#options+1] = {
            title = Lang['enter_property'],
            event = 'av_gangs:enter',
            args = {
                identifier = identifier, type = type, gang = gang
            }
        }
    end
    local description = Lang['locked']
    if isOpen then
        description = Lang['unlocked']
    end
    options[#options+1] = {
        title = Lang['door_state'],
        event = 'av_gangs:toggleDoor',
        description = description,
        args = {
            identifier = identifier, type = type, gang = gang, isExit = isExit
        }
    }
    lib.registerContext({
        id = 'gang_door',
        title = Lang['door_options'],
        options = options
    })
    lib.showContext('gang_door')
end

RegisterNetEvent('av_gangs:enter', function(data)
    enter(data['identifier'], data['type'], data['gang'])
end)

RegisterNetEvent('av_gangs:toggleDoor', function(data)
    local isOpen = lib.callback.await('av_gangs:toggleDoor', false, data)
    if type(isOpen) == "string" then
        print("^3[WARNING]^7 Something went wrong with this function, report it to your server admin.")
        return
    end
    gangDoor(data['identifier'], data['type'], data['gang'], isOpen, data['isExit'])
end)