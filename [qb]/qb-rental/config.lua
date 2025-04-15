Config = {}
Config.limitday=7
Config.Rent = {
    Category = {
        {name = "Compacts"},
        {name = "Sedans"},
        {name = "SUVs"},
        -- {name = "Muscle"},
        {name = "Sports"},
        {name = "Motorcycles"},
    },

    Cars = {
   
        ["Compacts"]  = {
            {name = "Issi", price = 50 , model = "issi2" , img = "https://assets.nopixel.net/dev/images/showroom/issi2.webp"},
            {name = "Prairie", price = 50 , model = "prairie" , img = "https://assets.nopixel.net/dev/images/showroom/prairie.webp"},
        },
        ["Sedans"] = {

            {name = "Glendale", price = 70 , model = "glendale" , img = "https://assets.nopixel.net/dev/images/showroom/glendale.webp"},
            {name = "Ingot", price = 70 , model = "ingot" , img = "https://assets.nopixel.net/dev/images/showroom/ingot.webp"},
        },
        ["SUVs"] = {
            {name = "Seminole", price = 100 , model = "seminole" , img = "https://assets.nopixel.net/dev/images/showroom/seminole.webp"},
            {name = "Gresley", price = 100 , model = "gresley" , img = "https://assets.nopixel.net/dev/images/showroom/gresley.webp"},
        },
        -- ["Muscle"] = {

        -- },
        ["Sports"] = {
            {name = "Blista Compact", price = 150 , model = "blista2" , img = "https://assets.nopixel.net/dev/images/showroom/blista2.webp"},
        },
        ["Motorcycles"] = {
            {name = "Faggio Sport", price = 70 , model = "faggio" , img = "https://assets.nopixel.net/dev/images/showroom/faggio.webp"},
            {name = "Faggio", price = 75 , model = "faggio2" , img = "https://assets.nopixel.net/dev/images/showroom/faggio2.webp"},
        },
    },
}

Config.dojrental = {
    Category = {
        {name = "DOJ"},
    },

    Cars = {
        ["DOJ"]  = {
            {name = "Cavalcade", price = 100 , model = "cavalcade3" , img = "https://assets.nopixel.net/dev/images/showroom/cavalcade.webp"},
            {name = "Aleutian", price = 100 , model = "aleutian" , img = "https://assets.nopixel.net/dev/images/showroom/aleutian.webp"},
            {name = "Baller", price = 100 , model = "baller7" , img = "https://assets.nopixel.net/dev/images/showroom/baller.webp"},
            {name = "Dorado ", price = 100 , model = "dorado" , img = "https://assets.nopixel.net/dev/images/showroom/dorado.webp"},
            
        },
       
    },
}

Config.taxi = {
    Category = {
        {name = "TAXI"},
    },

    Cars = {
        ["TAXI"]  = {
            {name = "TAXI", price = 100 , model = "taxi" , img = "https://assets.nopixel.net/dev/images/showroom/taxi.webp"},
        },
       
    },
}

Config.Boat = {
    Category = {
        {name = "Boats"}
    },

    Cars = {
        ["Boats"]  = {
            {name = "Sea Shark", price = 350 , model = "seashark" , img = "https://r2.fivemanage.com/ZrUYLRK1lGQX9xgdwjNb3/seaashark.png"},
            {name = "Dinghy", price = 450 , model = "dinghy" , img = "https://r2.fivemanage.com/ZrUYLRK1lGQX9xgdwjNb3/dinghyy.png"},
            {name = "Jetmax", price = 250 , model = "jetmax" , img = "https://r2.fivemanage.com/ZrUYLRK1lGQX9xgdwjNb3/jetmaxx.png"},
            {name = "Marquis", price = 150 , model = "marquis" , img = "https://r2.fivemanage.com/ZrUYLRK1lGQX9xgdwjNb3/marquiis.png"},
            {name = "Speeder", price = 750 , model = "speeder" , img = "https://r2.fivemanage.com/ZrUYLRK1lGQX9xgdwjNb3/speederr.png"},
            {name = "Toro", price = 630 , model = "toro" , img = "https://r2.fivemanage.com/ZrUYLRK1lGQX9xgdwjNb3/toroo.png"},
            {name = "Long fin", price = 420 , model = "longfin" , img = "https://r2.fivemanage.com/ZrUYLRK1lGQX9xgdwjNb3/longfin.png"},
        }
    },
}

Config.Locations = {
    
    -- {
    --     ['label'] = 'Car Rental',
    --     ['coords'] =vector4(4435.1762695312, -4484.1396484375, 4.3017706871033, 198.65101623535),
    --     ['carspawn'] = vector4(4428.1694335938, -4487.779296875, 3.6183967590332, 204.2184753418),
    --     ['categorie'] = Config.Rent,
    --     ['ped'] = 'a_m_y_business_02',
    --     ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
    --     ['radius'] = 1.5,
    --     ['targetIcon'] = 'fas fa-car',
    --     ['targetLabel'] = 'Rent Vehicle',
    --     ['showblip'] = false,
    --     ['blipsprite'] = 739,
    --     ['blipscale'] = 0.4,
    --     ['blipcolor'] = 25,
    --     ['jobs']=nil,
    -- },
    
    {
        ['label'] = 'Car Rental',
        ['coords'] =vector4(-1316.54, -905.88, 11.31, 208.53),
        ['carspawn'] =vector4(-1317.52, -913.17, 10.71, 197.39),
        ['categorie'] = Config.Rent,
        ['ped'] = 'a_m_y_business_02',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-car',
        ['targetLabel'] = 'Rent Vehicle',
        ['showblip'] = true,
        ['blipsprite'] = 739,
        ['blipscale'] = 0.4,
        ['blipcolor'] = 25,
        ['jobs']=nil,
    },
    {
        ['label'] = 'Car Rental',
        ['coords'] = vector4(-291.89, -985.96, 31.08, 340.31),
        ['carspawn'] = vector4(-297.76, -989.99, 30.49, 339.02),
        ['categorie'] = Config.Rent,
        ['ped'] = 'a_m_y_business_02',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-car',
        ['targetLabel'] = 'Rent Vehicle',
        ['showblip'] = true,
        ['blipsprite'] = 739,
        ['blipscale'] = 0.4,
        ['blipcolor'] = 25,
        ['jobs']=nil,
    },
    {
        ['label'] = 'Car Rental',
        ['coords'] = vector4(1224.76, 2727.92, 38.01, 180.16),
        ['carspawn'] = vector4(1229.08, 2722.48, 38.4, 179.21),
        ['categorie'] = Config.Rent,
        ['ped'] = 'a_m_y_business_02',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-car',
        ['targetLabel'] = 'Rent Vehicle',
        ['showblip'] = true,
        ['blipsprite'] = 739,
        ['blipscale'] = 0.4,
        ['blipcolor'] = 25,
        ['jobs']=nil,
    },
    {
        ['label'] = 'Car Rental',
        ['coords'] = vector4(-51.65, 6360.16, 31.46, 229.77),
        ['carspawn'] = vector4(-45.52, 6361.35, 31.74, 228.32),
        ['categorie'] = Config.Rent,
        ['ped'] = 'a_m_y_business_02',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-car',
        ['targetLabel'] = 'Rent Vehicle',
        ['showblip'] = true,
        ['blipsprite'] = 739,
        ['blipscale'] = 0.4,
        ['blipcolor'] = 25,
        ['jobs']=nil,
    },
    {
        ['label'] = 'Car Rental',
        ['coords'] = vector4(1852.37, 2582.12, 45.67, 270.72),
        ['carspawn'] = vector4(1854.9515380859, 2586.4011230469, 45.069332122803, 272.86849975586),
        ['categorie'] = Config.Rent,
        ['ped'] = 'a_m_y_business_02',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-car',
        ['targetLabel'] = 'Rent Vehicle',
        ['showblip'] = true,
        ['blipsprite'] = 739,
        ['blipscale'] = 0.4,
        ['blipcolor'] = 25,
        ['jobs']=nil,
    },
    {
        ['label'] = 'Car Rental',
        ['coords'] = vector4(-1040.52, -2731.86, 20.17, 240.51),
        ['carspawn'] = vector4(-1034.91, -2729.3, 19.48, 241.36),
        ['categorie'] = Config.Rent,
        ['ped'] = 'a_m_y_business_02',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-car',
        ['targetLabel'] = 'Rent Vehicle',
        ['showblip'] = true,
        ['blipsprite'] = 739,
        ['blipscale'] = 0.4,
        ['blipcolor'] = 25,
        ['jobs']=nil,
    },
    {
        ['label'] = 'Car Rental',
        ['coords'] =vector4(9.6545400619507, -1672.2794189453, 29.268161773682, 246.50122070312),
        ['carspawn'] = vector4(2.9136230945587, -1678.9705810547, 29.218774795532, 195.07118225098),
        ['categorie'] = Config.Rent,
        ['ped'] = 'a_m_y_business_02',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-car',
        ['targetLabel'] = 'Rent Vehicle',
        ['showblip'] = true,
        ['blipsprite'] = 739,
        ['blipscale'] = 0.4,
        ['blipcolor'] = 25,
        ['jobs']=nil,
    },
    {
        ['label'] = 'Car Rental',
        ['coords'] =vector4(213.27, -1463.49, 29.18, 44.41),
        ['carspawn'] = vector4(205.64, -1467.6, 28.55, 315.05),
        ['categorie'] = Config.Rent,
        ['ped'] = 'a_m_y_business_02',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-car',
        ['targetLabel'] = 'Rent Vehicle',
        ['showblip'] = true,
        ['blipsprite'] = 739,
        ['blipscale'] = 0.4,
        ['blipcolor'] = 25,
        ['jobs']=nil,
    },
    {
        ['label'] = 'Car Rental',
        ['coords'] =vector4(-1473.6, -655.34, 29.25, 218.98),
        ['carspawn'] = vector4(-1471.38, -653.22, 28.9, 218.03),
        ['categorie'] = Config.Rent,
        ['ped'] = 'a_m_y_business_02',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-car',
        ['targetLabel'] = 'Rent Vehicle',
        ['showblip'] = true,
        ['blipsprite'] = 739,
        ['blipscale'] = 0.4,
        ['blipcolor'] = 25,
        ['jobs']=nil,
    },
    {
        ['label'] = 'Car Rental',
        ['coords'] =vector4(324.16, -231.41, 54.22, 65.68),
        ['carspawn'] = vector4(321.76, -229.33, 53.44, 159.54),
        ['categorie'] = Config.Rent,
        ['ped'] = 'a_m_y_business_02',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-car',
        ['targetLabel'] = 'Rent Vehicle',
        ['showblip'] = true,
        ['blipsprite'] = 739,
        ['blipscale'] = 0.4,
        ['blipcolor'] = 25,
        ['jobs']=nil,
    },
    
    {
        ['label'] = 'Boat Rental',
        ['coords'] = vector4(-717.65, -1327.24, 1.6, 52.61),
        ['carspawn'] = vector4(-723.71, -1328.94, -0.11, 232.96),
        ['categorie'] = Config.Boat,
        ['ped'] = 'a_m_y_business_02',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-ship',
        ['targetLabel'] = 'Rent Boat',
        ['showblip'] = true,
        ['blipsprite'] = 739,
        ['blipscale'] = 0.4,
        ['blipcolor'] = 25,
        ['jobs']=nil,
    },

    {
        ['label'] = 'Doj Rental',
        ['coords'] =  vector4(393.8225402832, -1633.0245361328, 29.292718887329, 43.59937286377),
        ['carspawn'] = vector4(393.91998291016, -1625.0728759766, 29.292718887329, 49.512336730957),
        ['categorie'] = Config.dojrental,
        ['ped'] = 'csb_vincent',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-ship',
        ['targetLabel'] = 'Rental Car',
        ['showblip'] = false,
        ['blipsprite'] = 739,
        ['blipscale'] = 0.4,
        ['blipcolor'] = 25,
        ['jobs']={['justice']=0},

    },

    {
        ['label'] = 'TAXI Rental',
        ['coords'] =  vector4(903.03509521484, -172.79989624023, 74.075492858887, 237.5867767334),
        ['carspawn'] = vector4(907.42, -168.51, 73.78, 236.48),
        ['categorie'] = Config.taxi,
        ['ped'] = 'a_m_m_indian_01',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-ship',
        ['targetLabel'] = 'Rental Car',
        ['showblip'] = false,
        ['blipsprite'] = 739,
        ['blipscale'] = 0.4,
        ['blipcolor'] = 25,
        ['jobs']={['taxi']=0},

    },
}

Config.Fuel = 'qb-fuel'