1- GO TO ps-housing/server/sv_property.lua:
line 53 : 
    Change :
        SetPlayerRoutingBucket(src, bucket)
        into
        QBCore.Functions.SetPlayerBucket(src, tonumber(bucket))

and line 73 : 
    Change :
        SetPlayerRoutingBucket(src, 0)
        into
        QBCore.Functions.SetPlayerBucket(src, 0)
