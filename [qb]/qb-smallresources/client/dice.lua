RegisterCommand('roll', function(source, args)
    if args[1] and args[2] then
        local numAmount = tonumber(args[1])
        local maxAmount = tonumber(args[2])
        if numAmount and numAmount > 0 and maxAmount and maxAmount >= 2 then
            ExecuteCommand('e salsa')
            local message = ''
            if numAmount == 1 then
                message = math.random(1, maxAmount)..'/'..maxAmount
            else
                local getRandom = ""
                for i=1, numAmount, 1 do
                    getRandom = getRandom..' '..math.random(1, maxAmount)..'/'..maxAmount
                end
                message = getRandom
            end
            ExecuteCommand('me Dice rolled '..message)
            Wait(400)
            ExecuteCommand('e c')
        end
    else
        QBCore.Functions.Notify('Enter  All Arguments', 'error')
    end
end)
TriggerEvent('chat:addSuggestion', '/roll', 'Roll Dice', {{name = "amount", help = "Dice Number Amount"}, {name = "max", help = "Max Number of Dice"}})