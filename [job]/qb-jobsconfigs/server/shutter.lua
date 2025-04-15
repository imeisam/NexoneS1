local shutterobject={}
CreateThread(function()
    -- for k, v in ipairs(Config.shutter) do
    --     shutterobject[k] = CreateObjectNoOffset(`3dp_snrbuns_shutter`, v.startcoord.x,v.startcoord.y,v.startcoord.z, true, true, false)
    --     Wait(1000)
    --     SetEntityHeading(shutterobject[k],v.startcoord.w)
    --     FreezeEntityPosition(shutterobject[k], true)
       
    -- end
end)
AddEventHandler("onResourceStop", function(resource)
    if resource==GetCurrentResourceName() then
        for k, v in ipairs(shutterobject) do
            DeleteEntity(v)
        end
      
    end
end)
