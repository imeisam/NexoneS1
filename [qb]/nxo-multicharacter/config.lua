Config = {
    Framework = nil, -- dont touch auto framework selector has been activated.
    MaxCharacters = 4,
    LockedSlots = { },
    UseApartment = false,
    CanDeleteCharacters = true,
    Prefix = "char",-- for esx
    LockedSlotsIsPaid = false,
    LockedSlotsAllowedPlayers = {
        ["license:1234567890"] = true
    },
    RandomPeds = {
        'mp_m_freemode_01',
        'mp_f_freemode_01',
    },
    useQBSpawn = false,
    SkipSelection = false,
    -- SKIN MENUS


    
    SkinMenus = {
        ['skinchanger'] = {
            ['esx_skin'] = {event = 'esx_skin:openSaveableMenu', use = true},
            ['VexCreator'] = {event = 'VexCreator:loadCreator', use = false},
            ['cui_character'] = {event = 'cui_character:open', use = false},
            ['example_resource'] = {exports = 'exports.example:Creator', event = nil, use = false}, -- example support exports
        },
        ['illeniumappearance'] = {},
        ['fivemappearance'] = {},
        ['qb-clothing'] = {
            ['qb-clothing'] = { event = 'qb-clothing:client:openMenu', use = true},
        },
    },
    -- compatibility with IlleniumStudios version of fivemappearance for qbcore
    fivemappearanceConfig = {
        ped = true, headBlend = true, faceFeatures = true, headOverlays = true, components = true, componentConfig = { masks = true, upperBody = true, lowerBody = true, bags = true, shoes = true, scarfAndChains = true, bodyArmor = true, shirts = true, decals = true, jackets = true }, props = true, propConfig = { hats = true, glasses = true, ear = true, watches = true, bracelets = true }, tattoos = true, enableExit = true,
    },

    skinsupport = {
        ['fivem-appearance'] = true,
        ['skinchanger'] = true,
        ['qb-clothing'] = true,
        ['illenium-appearance'] = true
    },



    pedcoord={
        {
        ped=vector4(-1680.7514648438, -1104.5277099609, 12.1522397995, 216.05328369141),
        hidden=vector4(-1675.46875, -1110.7803955078, 12.752143478394, 45.264789581299),
        },
        {
            ped=vector4(376.22689819336, -336.00970458984, 47.161407470703, 261.83880615234),
            hidden=vector4(383.49649047852, -333.48336791992, 47.823852539062, 101.57260131836),
        },
        {
            ped=vector4(-2066.0234375, -1020.3186645508, 10.909463882446, 126.3770980835),
            hidden=vector4(-2072.6010742188, -1022.3516845703, 11.908979415894, 284.99963378906),
        },
    },
    -- PedCoords = {}----
    -- HiddenCoords =---- 
    DefaultSpawn = vector4(-1035.7698974609, -2738.8845214844, 20.169267654419, 334.97),
    randomPedAnimations = {
        [1] = {
            type = "sceneario",
            anim = "WORLD_HUMAN_AA_COFFEE",
        },
        [2] = {
            type = "sceneario",
            anim = "WORLD_HUMAN_AA_SMOKE",
        },
        [3] = {
            type = "anim",
            anim = "anim@amb@nightclub@peds@",
            dict = "rcmme_amanda1_stand_loop_cop",
        },
        [4] = {
            type = "anim",
            anim = "anim@amb@nightclub@peds@",
            dict = "rcmme_amanda1_stand_loop_cop",
        },
        -- [4] = {
        --     type = "anim",
        --     anim = "anim@mp_player_intselfiethe_bird",
        --     dict = "idle_a"
        -- },
        -- [5] = {
        --     --move_m@joggern
        --     type = "anim",
        --     anim = "move_m@jogger",
        --     dict = "idle"
        -- }
        
    },
    SpawnLocations = {
        -- [1] = {
        --     title = "Last location",
        --     description = "City of Los Santos.",
        --     coords = nil,
        -- },
        [1] = {
            title = "Motel",
            description = "A cozy and affordable lodging option for travelers and locals alike, offering a comfortable stay and convenient amenities.",
            coords = vector4(324.48, -209.84, 54.09, 221.52),
        },
        [2] = {
            title = "LSPD Department",
            description = "The central headquarters of the Los Santos Police Department, committed to maintaining law and order with dedication and integrity.",
            coords = vector4(412.285, -976.30, 29.41, 90.0),
        },
        
        [3] = {

            title = "Hospital",
            description = "A state-of-the-art medical facility providing 24/7 emergency services, advanced treatments, and compassionate care.",
            coords = vector4(277.9, -578.51, 43.12, 129.61),
        },
        [4] = {
            title = "Paleto Bay",
            description = "A charming and peaceful coastal town known for its beautiful beaches, scenic views, and friendly community.",
            coords = vector4(-177.94, 6212.09, 31.22, 298.54),
        },
    },
}

Config.skin = 'none' -- do not replace this. this resource automatically detect your skin resourc if its supported.
local skincount = {}
local lowpriority = 'skinchanger' -- for people who started 2 skin resource :facepalm
for skin,_ in pairs(Config.skinsupport) do
	if GetResourceState(skin) == 'started' or GetResourceState(skin) == 'starting' then -- autodetect skin resource
		Config.skin = skin
		table.insert(skincount,skin)
	end
end
if Config.skin == 'none' then
	warn('YOU DONT HAVE ANY SUPPORTED SKIN RESOURCE')
end
if #skincount > 1 then
	warn('you have multiple skin resource started. start only 1 supported skin resource. ex. fivem-appearance, skinchanger cannot be started at the same time!')
	for k,skin in pairs(skincount) do
		if lowpriority ~= skin then
			Config.skin = skin
		end
	end
	warn('USING '..Config.skin..' Anyway')
end

--- do not edit
Config.SkinMenu = {}
for resource,v in pairs(Config.SkinMenus) do
	if resource == Config.skin then
		for k,v in pairs(v) do
			if v.use then
				Config.SkinMenu[resource] = {event = v.event or false, exports = v.exports or false}
			end
		end
	end
end


OpenSkinMenu = function(data)
    TriggerEvent("esx_skin:openSaveableMenu", data) -- for ESX skin
end

DefaultSkin = {
    [0] = {
        mom = 43,
        dad = 29,
        face_md_weight = 61,
        skin_md_weight = 27,
        nose_1 = -5,
        nose_2 = 6,
        nose_3 = 5,
        nose_4 = 8,
        nose_5 = 10,
        nose_6 = 0,
        cheeks_1 = 2,
        cheeks_2 = -10,
        cheeks_3 = 6,
        lip_thickness = -2,
        jaw_1 = 0,
        jaw_2 = 0,
        chin_1 = 0,
        chin_2 = 0,
        chin_13 = 0,
        chin_4 = 0,
        neck_thickness = 0,
        hair_1 = 76,
        hair_2 = 0,
        hair_color_1 = 61,
        hair_color_2 = 29,
        tshirt_1 = 4,
        tshirt_2 = 2,
        torso_1 = 23,
        torso_2 = 2,
        decals_1 = 0,
        decals_2 = 0,
        arms = 1,
        arms_2 = 0,
        pants_1 = 28,
        pants_2 = 3,
        shoes_1 = 70,
        shoes_2 = 2,
        mask_1 = 0,
        mask_2 = 0,
        bproof_1 = 0,
        bproof_2 = 0,
        chain_1 = 22,
        chain_2 = 2,
        helmet_1 = -1,
        helmet_2 = 0,
        glasses_1 = 0,
        glasses_2 = 0,
        watches_1 = -1,
        watches_2 = 0,
        bracelets_1 = -1,
        bracelets_2 = 0,
        bags_1 = 0,
        bags_2 = 0,
        eye_color = 0,
        eye_squint = 0,
        eyebrows_2 = 0,
        eyebrows_1 = 0,
        eyebrows_3 = 0,
        eyebrows_4 = 0,
        eyebrows_5 = 0,
        eyebrows_6 = 0,
        makeup_1 = 0,
        makeup_2 = 0,
        makeup_3 = 0,
        makeup_4 = 0,
        lipstick_1 = 0,
        lipstick_2 = 0,
        lipstick_3 = 0,
        lipstick_4 = 0,
        ears_1 = -1,
        ears_2 = 0,
        chest_1 = 0,
        chest_2 = 0,
        chest_3 = 0,
        bodyb_1 = -1,
        bodyb_2 = 0,
        bodyb_3 = -1,
        bodyb_4 = 0,
        age_1 = 0,
        age_2 = 0,
        blemishes_1 = 0,
        blemishes_2 = 0,
        blush_1 = 0,
        blush_2 = 0,
        blush_3 = 0,
        complexion_1 = 0,
        complexion_2 = 0,
        sun_1 = 0,
        sun_2 = 0,
        moles_1 = 0,
        moles_2 = 0,
        beard_1 = 11,
        beard_2 = 10,
        beard_3 = 0,
        beard_4 = 0,
    },
    [1] = {
        mom = 28,
        dad = 6,
        face_md_weight = 63,
        skin_md_weight = 60,
        nose_1 = -10,
        nose_2 = 4,
        nose_3 = 5,
        nose_4 = 0,
        nose_5 = 0,
        nose_6 = 0,
        cheeks_1 = 0,
        cheeks_2 = 0,
        cheeks_3 = 0,
        lip_thickness = 0,
        jaw_1 = 0,
        jaw_2 = 0,
        chin_1 = -10,
        chin_2 = 10,
        chin_13 = -10,
        chin_4 = 0,
        neck_thickness = -5,
        hair_1 = 43,
        hair_2 = 0,
        hair_color_1 = 29,
        hair_color_2 = 35,
        tshirt_1 = 111,
        tshirt_2 = 5,
        torso_1 = 25,
        torso_2 = 2,
        decals_1 = 0,
        decals_2 = 0,
        arms = 3,
        arms_2 = 0,
        pants_1 = 12,
        pants_2 = 2,
        shoes_1 = 20,
        shoes_2 = 10,
        mask_1 = 0,
        mask_2 = 0,
        bproof_1 = 0,
        bproof_2 = 0,
        chain_1 = 85,
        chain_2 = 0,
        helmet_1 = -1,
        helmet_2 = 0,
        glasses_1 = 33,
        glasses_2 = 12,
        watches_1 = -1,
        watches_2 = 0,
        bracelets_1 = -1,
        bracelets_2 = 0,
        bags_1 = 0,
        bags_2 = 0,
        eye_color = 8,
        eye_squint = -6,
        eyebrows_2 = 7,
        eyebrows_1 = 32,
        eyebrows_3 = 52,
        eyebrows_4 = 9,
        eyebrows_5 = -5,
        eyebrows_6 = -8,
        makeup_1 = 0,
        makeup_2 = 0,
        makeup_3 = 0,
        makeup_4 = 0,
        lipstick_1 = 0,
        lipstick_2 = 0,
        lipstick_3 = 0,
        lipstick_4 = 0,
        ears_1 = -1,
        ears_2 = 0,
        chest_1 = 0,
        chest_2 = 0,
        chest_3 = 0,
        bodyb_1 = -1,
        bodyb_2 = 0,
        bodyb_3 = -1,
        bodyb_4 = 0,
        age_1 = 0,
        age_2 = 0,
        blemishes_1 = 0,
        blemishes_2 = 0,
        blush_1 = 0,
        blush_2 = 0,
        blush_3 = 0,
        complexion_1 = 0,
        complexion_2 = 0,
        sun_1 = 0,
        sun_2 = 0,
        moles_1 = 12,
        moles_2 = 8,
        beard_1 = 0,
        beard_2 = 0,
        beard_3 = 0,
        beard_4 = 0,
    },
}