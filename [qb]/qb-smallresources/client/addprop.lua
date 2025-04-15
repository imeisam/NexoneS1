local interiors = {
    {
        ipl = '3dp_snrbuns_milo', -- snrbuns
        coords = { x=-515.792969, y=-706.0899, z=38.7752 },
        entitySets = {
            { name = 'shutter01', enable = true },
            { name = 'shutter02', enable = true },
            { name = 'shutter03', enable = true },
            { name = 'shutter04', enable = true },
            { name = 'shutter05', enable = true },
            { name = 'shutter06', enable = true },
            { name = 'shutter07', enable = true },
            { name = 'shutter08', enable = true },
            { name = 'shutter09', enable = true },
            { name = 'shutter10', enable = true },
            { name = 'pizza', enable = true },
            { name = 'coffee', enable = true },
            { name = 'hotdog', enable = true },
            { name = 'sushi', enable = true },
            { name = 'smoothie', enable = true },
            { name = 'burger', enable = true },
            { name = 'sandwich', enable = true },
            { name = 'kebab', enable = true },
            { name = 'taco', enable = true },
            { name = 'noodle', enable = true },
        }
    },
   
}
local lastradar=false
function removeDisableHudComponents()
    -- TriggerEvent("hud:client:status",false)
    lastradar=true
    if IsRadarHidden() then lastradar=false end
    DisplayRadar(true)
end
exports("removeDisableHudComponents",removeDisableHudComponents)

function addDisableHudComponents()
    -- TriggerEvent("hud:client:status",true)
    DisplayRadar(lastradar)
end
exports("addDisableHudComponents",addDisableHudComponents)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    Wait(1000)
    loadsnripl()
end)

function loadsnripl()
    interiors[1].entitySets[1].enable=false --fresh fruit
    -- interiors[1].entitySets[2].enable=false  --burger
    -- interiors[1].entitySets[3].enable=false  --sandwitch
    -- interiors[1].entitySets[4].enable=false --taco
    interiors[1].entitySets[5].enable=false  --pitzza
    -- interiors[1].entitySets[6].enable=false --sushi
    -- interiors[1].entitySets[7].enable=false --coffe
    -- interiors[1].entitySets[8].enable=false  --chini
    -- interiors[1].entitySets[9].enable=false  --donner
    -- interiors[1].entitySets[10].enable=false  --hotdog
    for _, interior in ipairs(interiors) do
        if not interior.ipl or not interior.coords or not interior.entitySets then
            return
        end
        RequestIpl(interior.ipl)
        local interiorID = GetInteriorAtCoords(interior.coords.x, interior.coords.y, interior.coords.z)
        if IsValidInterior(interiorID) then
            for __, entitySet in ipairs(interior.entitySets) do
                if entitySet.enable then
                    EnableInteriorProp(interiorID, entitySet.name)
                else
                    DisableInteriorProp(interiorID, entitySet.name)
                end
            end
            RefreshInterior(interiorID)
        end
    end
end

CreateThread(function()
      interiors[1].entitySets[1].enable=false --fresh fruit
    -- interiors[1].entitySets[2].enable=false  --burger
    -- interiors[1].entitySets[3].enable=false  --sandwitch
    -- interiors[1].entitySets[4].enable=false --taco
    interiors[1].entitySets[5].enable=false  --pitzza
    -- interiors[1].entitySets[6].enable=false --sushi
    -- interiors[1].entitySets[7].enable=false --coffe
    -- interiors[1].entitySets[8].enable=false  --chini
    -- interiors[1].entitySets[9].enable=false  --donner
    -- interiors[1].entitySets[10].enable=false  --hotdog
    for _, interior in ipairs(interiors) do
        if not interior.ipl or not interior.coords or not interior.entitySets then
            return
        end
        RequestIpl(interior.ipl)
        local interiorID = GetInteriorAtCoords(interior.coords.x, interior.coords.y, interior.coords.z)
        if IsValidInterior(interiorID) then
            for __, entitySet in ipairs(interior.entitySets) do
                if entitySet.enable then
                    EnableInteriorProp(interiorID, entitySet.name)
                else
                    DisableInteriorProp(interiorID, entitySet.name)
                end
            end
            RefreshInterior(interiorID)
        end
    end
end)
