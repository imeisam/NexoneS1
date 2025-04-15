Config = {
	Debug = false, -- enable debug mode
	Blips = true, -- Enable Blips?
	CheckMarks = true, -- shows checkmarks if user has the materials to craft an item, set false if causing lag.
	Lan = "en", -- Pick your language here
	Notify = "qb", -- Set the notification system, the available are listed in shared.lua
	Job = nil, -- leave this as nil to have no job restriction
	JimShops = false, -- Set this to true if using jim-shops

	SawBreak = false, -- If true, chance to break powersaw on use

	Timings = { -- Time it takes to do things
		["TreeCutting"] = math.random(9000, 11500),
		["TreeSpawn"] = 300000, -- 5 minutes
		["LogCutting"] = math.random(9000, 11500),
		["Debark"] = math.random(7000, 8000),
		["Processing"] = math.random(7000, 9000),
		["PulpLog"] = math.random(6000, 8000),
		["Crafting"] = 8000,
	},

	Locations =  {
		['Lumberyard'] = {	 -- The location of the Lumberyard
			{ name = "[~b~Area~s~] Forest", coords = vector4(1217.7974853516, -1269.7292480469, 35.368957519531, 251.69190979004), sprite = 285, col = 2, blipTrue = true, model = `G_M_M_ChemWork_01`, scenario = "WORLD_HUMAN_CLIPBOARD", },
		},
		-- ['Seller'] = {
		-- 	{ name = "Store", coords = vector4(-469.31, 5365.69, 80.79, 88.27), sprite = 527, col = 81, blipTrue = false, model = `G_M_M_ChemWork_01`, scenario = "WORLD_HUMAN_CLIPBOARD",  },		-- The location where you enter the mine
		-- },
		['Buyer'] = {
			{ name = "Lumber Supply", coords = vector4(37.48, 6544.54, 31.61, 235.08), sprite = 478, col = 81, blipTrue = true, model = `G_M_M_ChemWork_01`, scenario = "WORLD_HUMAN_CLIPBOARD", },		-- The location where you enter the mine
		},
		['Saws'] = { -- The location of the smelter
			{ name = "Saw machine", coords = vector4(-523.46, 5283.61, 74.28, 70.0), sprite = 11, col = 24, blipTrue = false, prop = `prop_tablesaw_01` },
			{ name = "Saw machine", coords = vector4(-522.32, 5286.87, 74.25, 70.0), sprite = 11, col = 24, blipTrue = false, prop = `prop_tablesaw_01` },
			{ name = "Saw machine", coords = vector4(-525.02, 5279.09, 74.29, 70.0), sprite = 11, col = 24, blipTrue = false, prop = `prop_tablesaw_01` },
		},
		-- ['WoodCut'] = {
		-- 	{ name = "Wood Cutting", coords = vector4(-468.93, 5352.4, 80.72, 62.41), sprite = 514, col = 0, blipTrue = true, prop = `gr_prop_gr_speeddrill_01b` },
		-- 	{ name = "Wood Cutting", coords = vector4(-483.9, 5321.86, 80.61, 338.15), sprite = 514, col = 0, blipTrue = false, prop = `gr_prop_gr_speeddrill_01b` },
		-- },
		--['Illegal'] = {
		--	{ name = "Illegal Shit", coords = vector4(1744.18, 3298.76, 41.22, 13.32), sprite = 514, col = 0, blipTrue = false, prop = `gr_prop_gr_speeddrill_01b` },
		--},
		["Debark"] = {
			{ name = "Wood shavings", coords = vector4(-477.1, 5303.64, 86.05, 70.0), sprite = 12, col = 36, blipTrue = false },
			{ name = "Wood shavings", coords = vector4(-475.82, 5305.81, 86.15, 70.0), sprite = 12, col = 36, blipTrue = false },
		},
		["Pulper"] = {
			{ name = "Crusher", coords = vector4(-523.85, 5298.43, 78.79, 69), sprite = 85, col = 0, blipTrue = false },
		},
	},

	Trees = {
		`prop_snow_tree_03_h`,
		`prop_snow_tree_03_i`,
		`prop_snow_tree_04_d`,
		`prop_snow_tree_04_f`,
		`prop_tree_cedar_s_04`,
		`prop_tree_cedar_s_05`,
		`prop_tree_cedar_s_06`,
		`prop_tree_cypress_01`,
		`prop_tree_log_01`,
		`prop_tree_log_02`,
		`prop_tree_stump_01`,
		`prop_tree_birch_01`,
		`prop_tree_birch_02`,
		`prop_tree_birch_03`,
		`prop_tree_birch_03b`,
		`prop_tree_birch_04`,
		--`prop_tree_cedar_02`,
		`prop_tree_cedar_03`,
		`prop_tree_cedar_04`,
		`prop_tree_cedar_s_01`,
		`prop_tree_cedar_s_02`,
		`prop_tree_eng_oak_01`,
		`prop_tree_eng_oak_creator`,
		`prop_tree_eucalip_01`,
		`prop_tree_jacada_01`,
		`prop_tree_jacada_02`,
		`prop_tree_lficus_02`,
		`prop_tree_lficus_03`,
		`prop_tree_lficus_05`,
		`prop_tree_lficus_06`,
		`prop_tree_maple_02`,
		`prop_tree_maple_03`,
		`prop_tree_mquite_01`,
		`prop_tree_oak_01`,
		`prop_tree_olive_creator`,
		`prop_tree_pine_01`,
		`prop_tree_pine_01`,
		`prop_w_r_cedar_01`,
		`prop_w_r_cedar_dead`,
		`prop_tree_olive_cr2`,
		`test_tree_cedar_trunk_001`,
		`z_tree_pine3`,
		1827343468
	},

------------------------------------------------------------
--Ores and Props
	TreePositions = {
		vector4(-456.6101, 5408.726, 75.69884, 0.0),
		vector4(-457.2242, 5398.11, 74.54485, 0.0),

		vector4(-447.163, 5396.568, 75.69884, 0.0),
		vector4(-492.041, 5395.633, 75.48617, 0.0),
		vector4(-500.736, 5401.574, 73.01296, 0.0),
		vector4(-510.5032, 5389.506, 68.95892, 0.0),
		vector4(-504.5997, 5391.875, 73.36236, 0.0),
		vector4(-558.7664, 5419.209, 60.34554, 0.0),
		vector4(-561.658, 5420.319, 60.52522, 0.0),
		vector4(-476.1692, 5468.564, 84.10078, 0.0),
		vector4(-419.854, 5437.376, 74.01779, 0.0),
		vector4(-422.3033, 5447.007, 73.73431, 0.0),
		vector4(-421.3751, 5454.29, 76.03955, 0.0),
		vector4(-578.8257, 5427.048, 56.92018, 0.0),
		vector4(-586.3552, 5447.37, 58.59866, 0.0),
		vector4(-595.0001, 5451.043, 57.29848, 0.0),
		vector4(-591.8429, 5448.774, 58.37492, 0.0),
		vector4(-615.4167, 5432.851, 51.75421, 0.0),
		vector4(-616.3025, 5424.165, 48.93402, 0.0),
		vector4(-620.4484, 5428.12, 51.35571, 0.0),
		vector4(-600.2048, 5397.276, 51.69012, 0.0),
		vector4(-614.0487, 5399.306, 50.0063, 0.0),
		vector4(-616.1387, 5403.191, 48.84934, 0.0),
		vector4(-655.0473, 5424.245, 43.85096, 0.0),
		vector4(-661.5078, 5425.615, 42.43542, 0.0),
		vector4(-511.442, 5449.702, 72.19167, 0.0),

		vector4(-538.4689, 5483.756, 62.94209, 0.0),
		vector4(-536.7098, 5491.182, 62.65248, 0.0),
		vector4(-540.4973, 5492.681, 62.20742, 0.0),
		vector4(-552.7703, 5445.886, 61.35304, 0.0),
		vector4(-564.2682, 5457.453, 60.69264, 0.0),
		vector4(-561.064, 5460.615, 62.28295, 0.0),
		vector4(-555.3481, 5512.125, 58.89552, 0.0),
		vector4(-566.592, 5503.159, 55.64363, 0.0),
		vector4(-572.1949, 5508.771, 53.54555, 0.0),
		vector4(-584.2518, 5491.535, 53.57881, 0.0),
		vector4(-589.8323, 5495.062, 51.84096, 0.0),
		vector4(-637.686, 5440.282, 51.57382, 0.0),
		vector4(-573.543, 5468.081, 60.17022, 0.0),
		vector4(-577.7396, 5468.46, 59.38726, 0.0),
		vector4(-580.8271, 5470.375, 57.61452, 0.0),
		vector4(-597.7041, 5473.891, 54.61196, 0.0),
		vector4(-631.4138, 5466.643, 52.36712, 0.0),
		vector4(-628.6407, 5470.813, 52.38274, 0.0),
		vector4(-626.4395, 5473.436, 51.64229, 0.0),
		vector4(-618.9368, 5489.076, 50.18398, 0.0),
		vector4(-619.901, 5497.533, 50.37961, 0.0),
		vector4(-490.49, 5451.4, 79.96, 0.0),
	},

	SellItems = { -- Selling Prices
		['wood'] = 30,
		['paperlumber'] = 20,
	},

	Items = {
		label = "Lumberyard Store",  slots = 5,
		items = {
			{ name = "powersaw", price = 5000, amount = 100, info = {}, type = "item", slot = 1, },
			{ name = "water", price = 50, amount = 100, info = {}, type = "item", slot = 2, },
			{ name = "sandwich", price = 50, amount = 250, info = {}, type = "item", slot = 3, },
			{ name = "bandage", price = 50, amount = 100, info = {}, type = "item", slot = 4, },
			{ name = "weapon_flashlight", price = 1000, amount = 100, info = {}, type = "item", slot = 5, },
		},
	},
}

------------------------------------------------------------

Crafting = {}
Loc = {}