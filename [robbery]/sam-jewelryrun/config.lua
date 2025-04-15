config={}


config.carscoord={
    {coord=vector4(-1001.47, -989.39, 1.89, 209.49),busty=false,},
    {coord=vector4(-513.14, -596.12, 30.04, 0.29),busty=false,},
    {coord=vector4(17.54, -2649.97, 5.74, 178.36),busty=false,},
    {coord=vector4(1130.46, -485.58, 65.34, 75.43),busty=false,},
    {coord=vector4(-1589.5, -1056.49, 12.76, 320.19),busty=false,},
}
config.normal={
    requesttimeout=900000,
    itemneed=200,
    addmoney=2000,
    packagecount=200,
    carmodel="speedo",
    normalcountrob=3,
    deliverynpccoord=vector4(-401.09671020508, 6377.1450195312, 14.023706436157, 32.33712387085),
}

config.highrisklocation={
 {
    npccoord1=vector4(521.11, -2294.56, 5.94, 300.67),
    npccoord2=vector4(514.86, -2290.29, 5.94, 262.95),
    boxcoord={
    vector4(519.23, -2291.4, 5.94, 300.8)
    }
},
{
    npccoord1=vector4(1566.55, -2136.97, 77.6, 68.77),
    npccoord2=vector4(1567.94, -2142.34, 77.65, 173.1),
    boxcoord={
    vector4(1563.97, -2140.5, 77.63, 121.27)
    }
},
{
    npccoord1=vector4(2188.2, 3312.67, 46.3, 75.69),
    npccoord2=vector4(2180.74, 3320.01, 45.98, 186.63),
    boxcoord={
    vector4(2184.19, 3313.36, 46.21, 215.96)
    }
},
{
    npccoord1=vector4(780.5, -1623.65, 31.02, 297.24),
    npccoord2=vector4(786.74, -1626.77, 31.02, 341.05),
    boxcoord={
    vector4(784.16, -1625.25, 31.02, 314.59)
    }
},
{
    npccoord1=vector4(709.59, 4176.53, 40.71, 305.75),
    npccoord2=vector4(711.38, 4171.25, 40.71, 304.42),
    boxcoord={
    vector4(714.44, 4174.47, 40.71, 295.23)
    }
},

{
    npccoord1=vector4(2773.0, 1399.05, 24.5, 79.4),
    npccoord2=vector4(2774.14, 1405.67, 24.51, 23.33),
    boxcoord={
    vector4(2768.87, 1403.03, 24.47, 83.84)
        }
},

}
config.highrisk={--2
    locationcount=5,
    itemneed=1000,
    requesttimeout=900000,
    giveitem=5000,
    finalitemcount=1000,
    rewarditemcount=1000,
    policerequire=8,
    hotrunmaxrob=2,
    hotruncooldown=60,
}

config.hotrun={--3
    itemneed=1500,
    requesttimeout=10000000,
    carmodel='jugular',
    packagecount=1500,
    addmoney=10000,
    blipoff=900000,
    maxrob=1,
    cooldown=60,
    policerequire=8,
}

config.hotruncarcoord={
    {coord=vector4(2579.61, 428.25, 107.83, 178.89),busty=false,},
    {coord=vector4(1663.18, 4951.7, 41.43, 181.11),busty=false,},
    {coord=vector4(320.09, 3407.96, 36.11, 254.57),busty=false,},
    {coord=vector4(178.58, 3091.84, 42.47, 10.34),busty=false,},
    {coord=vector4(1095.05, -790.36, 57.66, 269.83),busty=false,},
}

-- Fuel Function
function config.SetFuel(vehicle, fuel)
    exports['qb-fuel']:SetFuel(vehicle, fuel)
end

-- Key Function
function config.GiveKey(plate)
    TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
end

config.buyitem={
    {itemname="hvaccompressor",count=math.random(10,40)},
    {itemname="hvacblower",count=math.random(10,40)},
    {itemname="gturbinehead",count=math.random(10,40)},
    {itemname="car_wheel",count=math.random(5,20)},
    {itemname="car_door",count=math.random(5,20)},
    {itemname="radiator",count=math.random(5,20)},
    {itemname="trunk",count=math.random(5,20)},
}

config.selltrade={itemname="assortedjewelry",count=math.random(1,1)}
config.sellmoney={itemname="banded_cash",count=math.random(1,1)}