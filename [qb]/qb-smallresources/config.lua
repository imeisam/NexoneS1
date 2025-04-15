developermode=true

ConsumeablesEat = {
    ["sandwich"] = math.random(25, 30),
    ["hotdog"] = math.random(30, 35),
    ["twerks_candy"] = math.random(10, 15),
    ["zatburger"] = math.random(30, 35),
    ["zatfries"] = math.random(10, 15),
}
ConsumeablesDrink = {
    ["water"] = math.random(30, 35),
    ["energy_drink"] = math.random(35, 40), 
    ["kurkakola"] = math.random(15, 20),
    ["coffee"] = math.random(20, 20),
    ["beer_pib"] = math.random(20, 25),
    ["beer_log"] = math.random(20, 25),
    ["beer_am"] = math.random(20, 25),
    ["beer_bar"] = math.random(20, 25),
    ["beer_stz"] = math.random(20, 25),
    ["liquor_vodka"] = math.random(20, 25),
    ["liquor_whiskey"] = math.random(20, 25),
    ["liquor_rum"] = math.random(20, 25),
    --snrbuns
    ["zatsprunk"] = math.random(30, 35),
    ["zatecola"] = math.random(30, 35),
    ["zatecolalight"] = math.random(30, 35),
    ["zatorangotang"] = math.random(30, 35),
}

Density = {
    ['parked'] =0.5,
    ['vehicle'] =0.5,
    ['multiplier'] = 0.01,
    ['peds'] =0.5,
    ['scenario'] = 0.5,
}

BlacklistedScenarios = {
    ['TYPES'] = {
        "WORLD_VEHICLE_MILITARY_PLANES_SMALL",
        "WORLD_VEHICLE_MILITARY_PLANES_BIG",
        "WORLD_VEHICLE_AMBULANCE",
        "WORLD_VEHICLE_POLICE_NEXT_TO_CAR",
        "WORLD_VEHICLE_POLICE_CAR",
        "WORLD_VEHICLE_POLICE_BIKE",
    },
    ['GROUPS'] = {
        2017590552,
        2141866469,
        1409640232,
        `ng_planes`,
    }
}
nospawnVehs = {
    [`ambulance`] =true, 
}
BlacklistedVehs = {
    -- [`ambulance`] =true,
    [-1448658708] =true,
    -- [`taco`] =true,
    [`SAVAGE`] = true,
    [`buzzard`] = true,
    [`lazer`] = true,
    -- [`TITAN`] = true,
    [`Stromberg`] = true,
    [`Nokota`] = true,
    [`Molotok`] = true,
    [`Mogul`] = true,
    [`RHINO`] = true,
    -- [`POLICE`] = true,
    -- [`POLICEB`] = true,
    -- [`PBUS`] = true,
    [`FIRETRUK`] = true,
    -- [`MULE`] = true,
    [`BLIMP`] = true,
    [`AIRTUG`] = true,
    -- [`CAMPER`] = true,
    [`OPPRESSOR`] = true,
    [`technical3`] = true,
    [`insurgent3`] = true,
    [`apc`] = true,
    [`tampa3`] = true,
    [`trailersmall2`] = true,
    [`halftrack`] = true,
    [`hunter`] = true,
    [`vigilante`] = true,
    [`akula`] = true,
    [`barrage`] = true,
    [`khanjali`] = true,
    [`p_spinning_anus_s`] = true,
    [`caracara`] = true,
    [`blimp3`] = true,
    [`menacer`] = true,
    [`oppressor2`] = true,
    [`scramjet`] = true,
    [`strikeforce`] = true,
    [`cerberus`] = true,
    [`cerberus2`] = true,
    [`cerberus3`] = true,
    [`scarab`] = true,
    [`scarab2`] = true,
    [`scarab3`] = true,
    [`rrocket`] = true,
    [`ruiner2`] = true,
    [`deluxo`] = true,
    [`docktrailer`] = true,
    [`trailers`] = true,
    [`trailers2`] = true,
    [`trailers3`] = true,
    [`trflat`] = true,
    [`trailersmall`] = true,
    [`prop_tanktrailer_01a`] = true,
    [`FROGGER`] = true,
    [`CARGOBOB`] = true,
    [`KHANJALI`] = true,
    [`tula`] = true,
    [`starling`] = true,
    -- [`polmav`] = true,
    [`kosatka`] = true,
    [`dinghy5`] = true,
    [`patrolboat`] = true,
    [`minitank`] = true,
    [`thruster`] = true,
    [`volatol`] = true,
    [`alkonost`] = true,
    [`cargoplane`] = true,
    [`toreador`] = true,
    [`duster`] = true,
    [`rumpo3`] = true,
}

CityHall = {}
CityHall.Coord = vector3(318.59, -1640.61, 32.54)
CityHall.Heading = 319.88
CityHall.NpcModel = 'cs_molly'
CityHall.Prices = {
    ['idcard'] = 50,
    ['driver'] = 250,
    ['weapon'] = 5000,
    ['hunting'] = 1000,
}
afk={}
afk.settings = {
    kick_timer = 1800,
    update_interval = 60,
    notifications = {
         600, 300, 150, 60, 30, 20, 10, 4
    }
}