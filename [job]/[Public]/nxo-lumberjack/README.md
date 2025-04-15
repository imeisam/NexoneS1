Thank you for your purchase <3 I hope you have fun with this script and that it brings jobs and RP to your server

If you need support I now have a discord available, it helps me keep track of issues and give better support.

https://discord.gg/xKgQZ6wZvS

# jim-lumberjack
FiveM Custom QBCORE lumberjack script by me from scratch

- Built in Locale System
- Several trees around the lumberyard replaced with "cuttable" trees
- Several handmade prop animations which are server synced, just for the real
- Built in advanced and customisable crafting
- "Illegal Crafting" - with a few rp based items included
- Built in qb-menu and qb-target making these the only dependencies
- Support for other free scripts from me such as, jim-chairs and ElectricSkateboard
- Fun couple of extra character props added, "cardhat" (a cardbord box hat) and "walkstick" is made usable
- This script can be used as a go between for other scripts, like crafting Beehives, crafting Camping gear etc.
  - Feel free to share your crafting recipe snippets in my discord

## Video Previews

- Tree/Log Cutting: https://streamable.com/3ypnwe
- Debarking/Pulp: https://streamable.com/priox7
- Wood Crafting: https://streamable.com/3zzm09
- Possibility of Illegal Crafting: https://streamable.com/s4x7th
- Selling materials: https://streamable.com/1afduj

## Custom Items & Images
  ![](https://i.imgur.com/xaGKJcn.png)

## Dependencies
- qb-menu - for the menus
- qb-target - for the third eye selection

# How to install
## Minimal

- Place in your `resources` folder
- Add the following line to your `server.cfg` or `resources.cfg` below `[qb]`

ensure jim-lumberjack

If you want to use my items then:
- Add the images to your inventory folder
- Put these lines in your items.lua

--Jim-Lumberjack
  ["powersaw"] 		= {["name"] = "powersaw",       	["label"] = "Power Saw", 		["weight"] = 1000,  ["type"] = "item",  ["image"] = "powersaw.png",	["unique"] = 1, ["description"] = ""},

  ["log"] 	    	= {["name"] = "log",				["label"] = "Log",	 			["weight"] = 2000,  ["type"] = "item",  ["image"] = "log.png",			["description"] = ""},
  ["bark"] 			= {["name"] = "bark",       		["label"] = "Tree Bark", 		["weight"] = 100,   ["type"] = "item",  ["image"] = "bark.png",			["description"] = ""},
  ["debarkedlog"]		= {["name"] = "debarkedlog",		["label"] = "Debarked Log", 	["weight"] = 100,   ["type"] = "item",  ["image"] = "debarkedlog.png",	["description"] = ""},
  ["wood"]        	= {["name"] = "wood", 				["label"] = "Wood Planks", 		["weight"] = 100,   ["type"] = "item",  ["image"] = "woodplank.png",	["description"] = ""},

  ["paper"]       	= {["name"] = "paper",      		["label"] = "Roll of Paper",	["weight"] = 100,   ["type"] = "item",  ["image"] = "paperroll.png",	["description"] = ""},
  ["cardhat"]    	 	= {["name"] = "cardhat",    		["label"] = "Cardboard Box",	["weight"] = 100,   ["type"] = "item",  ["image"] = "cardhat.png",		["unique"] = 1,	["useable"] = 1,            ["description"] = ""},

  ["fakecash"]    	= {["name"] = "fakecash",   		["label"] = "Fake Cash",		["weight"] = 100,   ["type"] = "item",  ["image"] = "fakecash.png",		["description"] = ""},
  ["fakecert"]    	= {["name"] = "fakecert",   		["label"] = "Fake Certificate",	["weight"] = 100,	["type"] = "item",  ["image"] = "fakecert.png",		["description"] = ""},
  ["fakeweaplicence"]	= {["name"] = "fakeweaplicence",   	["label"] = "Fake Weapon Licence",["weight"] = 100, ["type"] = "item",  ["image"] = "fakeweap.png",		["description"] = ""},
  ["fakedrivelicence"]= {["name"] = "fakedrivelicence",   ["label"] = "Fake Drivers Licence",["weight"] = 100,["type"] = "item",  ["image"] = "fakedriver.png",	["description"] = ""},
  ["fakelawyer"]		= {["name"] = "fakelawyer",   		["label"] = "Fake Laywer Pass",	["weight"] = 100,	["type"] = "item",  ["image"] = "fakelawyer.png",	["description"] = ""},

  ["charcoal"] 	    = {["name"] = "charcoal",			["label"] = "Charcoal",	 		["weight"] = 100,  ["type"] = "item",  ["image"] = "charcoal.png",		["description"] = ""},
  ["hammerhandle"] 	= {["name"] = "hammerhandle",		["label"] = "Hammer Handle",	["weight"] = 100,  ["type"] = "item",  ["image"] = "hammerhandle.png",	["description"] = ""},
  ["axehandle"] 		= {["name"] = "axehandle",			["label"] = "Axe Handle",		["weight"] = 100,  ["type"] = "item",  ["image"] = "axehandle.png",		["description"] = ""},
  ["batbase"] 		= {["name"] = "batbase",			["label"] = "Bat Base",			["weight"] = 100,  ["type"] = "item",  ["image"] = "batbase.png",		["description"] = ""},

  ["origami1"]    	= {["name"] = "origami1",    		["label"] = "Origami Scorpion",	["weight"] = 100,  ["type"] = "item",  ["image"] = "origami1.png",		["unique"] = 1, 	["useable"] = 1,     ["shouldClose"] = 1,       ["description"] = ""},
  ["origami2"]    	= {["name"] = "origami2",    		["label"] = "Origami Spider",	["weight"] = 100,  ["type"] = "item",  ["image"] = "origami2.png",		["unique"] = 1, 	["useable"] = 1,     ["shouldClose"] = 1,       ["description"] = ""},
  ["origami3"]    	= {["name"] = "origami3",    		["label"] = "Origami Poop",		["weight"] = 100,  ["type"] = "item",  ["image"] = "origami3.png",		["unique"] = 1, 	["useable"] = 1,     ["shouldClose"] = 1,       ["description"] = ""},
  ["origami4"]    	= {["name"] = "origami4",    		["label"] = "Origami Dragon",	["weight"] = 100,  ["type"] = "item",  ["image"] = "origami4.png",		["unique"] = 1, 	["useable"] = 1,     ["shouldClose"] = 1,       ["description"] = ""},
  ["origami5"]    	= {["name"] = "origami5",    		["label"] = "Origami Unicorn",	["weight"] = 100,  ["type"] = "item",  ["image"] = "origami5.png",		["unique"] = 1, 	["useable"] = 1,     ["shouldClose"] = 1,       ["description"] = ""},
  ["origami6"]    	= {["name"] = "origami6",    		["label"] = "Origami Pig",		["weight"] = 100,  ["type"] = "item",  ["image"] = "origami6.png",		["unique"] = 1, 	["useable"] = 1,     ["shouldClose"] = 1,       ["description"] = ""},
  ["origami7"]    	= {["name"] = "origami7",    		["label"] = "Origami Phoenix",	["weight"] = 100,  ["type"] = "item",  ["image"] = "origami7.png",		["unique"] = 1, 	["useable"] = 1,     ["shouldClose"] = 1,       ["description"] = ""},
  ["origami8"]    	= {["name"] = "origami8",    		["label"] = "Origami Plane",	["weight"] = 100,  ["type"] = "item",  ["image"] = "origami8.png",		["unique"] = 1, 	["useable"] = 1,     ["shouldClose"] = 1,       ["description"] = ""},
  ["origami9"]    	= {["name"] = "origami9",    		["label"] = "Origami Whale",	["weight"] = 100,  ["type"] = "item",  ["image"] = "origami9.png",		["unique"] = 1, 	["useable"] = 1,     ["shouldClose"] = 1,       ["description"] = ""},
  ["origami10"]    	= {["name"] = "origami10",    		["label"] = "Origami Dolphin",	["weight"] = 100,  ["type"] = "item",  ["image"] = "origami10.png",		["unique"] = 1, 	["useable"] = 1,     ["shouldClose"] = 1,       ["description"] = ""},
  ["origami11"]    	= {["name"] = "origami11",    		["label"] = "Origami Bunny",	["weight"] = 100,  ["type"] = "item",  ["image"] = "origami11.png",		["unique"] = 1, 	["useable"] = 1,     ["shouldClose"] = 1,       ["description"] = ""},
  ["origami12"]    	= {["name"] = "origami12",    		["label"] = "Origami Lion",		["weight"] = 100,  ["type"] = "item",  ["image"] = "origami12.png",		["unique"] = 1, 	["useable"] = 1,     ["shouldClose"] = 1,       ["description"] = ""},
  ["origami13"]    	= {["name"] = "origami13",    		["label"] = "Origami Turkey",	["weight"] = 100,  ["type"] = "item",  ["image"] = "origami13.png",		["unique"] = 1, 	["useable"] = 1,     ["shouldClose"] = 1,       ["description"] = ""},
  ["origami14"]    	= {["name"] = "origami14",    		["label"] = "Origami Eagle",	["weight"] = 100,  ["type"] = "item",  ["image"] = "origami14.png",		["unique"] = 1, 	["useable"] = 1,     ["shouldClose"] = 1,       ["description"] = ""},
  ["origami15"]    	= {["name"] = "origami15",    		["label"] = "Origami Dinosaur",	["weight"] = 100,  ["type"] = "item",  ["image"] = "origami15.png",		["unique"] = 1, 	["useable"] = 1,     ["shouldClose"] = 1,       ["description"] = ""},
  ["origami16"]    	= {["name"] = "origami16",    		["label"] = "Origami Butterfly",["weight"] = 100,  ["type"] = "item",  ["image"] = "origami16.png",		["unique"] = 1, 	["useable"] = 1,     ["shouldClose"] = 1,       ["description"] = ""},
  ["origami17"]    	= {["name"] = "origami17",    		["label"] = "Origami Monkey",	["weight"] = 100,  ["type"] = "item",  ["image"] = "origami17.png",		["unique"] = 1, 	["useable"] = 1,     ["shouldClose"] = 1,       ["description"] = ""},
  ["origami18"]    	= {["name"] = "origami18",    		["label"] = "Origami Mouse",	["weight"] = 100,  ["type"] = "item",  ["image"] = "origami18.png",		["unique"] = 1, 	["useable"] = 1,     ["shouldClose"] = 1,       ["description"] = ""},
  ["origami19"]    	= {["name"] = "origami19",    		["label"] = "Origami Cockatiel",["weight"] = 100,  ["type"] = "item",  ["image"] = "origami19.png",		["unique"] = 1, 	["useable"] = 1,     ["shouldClose"] = 1,       ["description"] = ""},
  ["origami20"]    	= {["name"] = "origami20",    		["label"] = "Origami Squirrel",	["weight"] = 100,  ["type"] = "item",  ["image"] = "origami20.png",		["unique"] = 1, 	["useable"] = 1,     ["shouldClose"] = 1,       ["description"] = ""},
  ["origami21"]    	= {["name"] = "origami21",    		["label"] = "Origami Wolf",		["weight"] = 100,  ["type"] = "item",  ["image"] = "origami21.png",		["unique"] = 1, 	["useable"] = 1,     ["shouldClose"] = 1,       ["description"] = ""},

## ChangeLog

v1.1.4
  - Workaround for the `HasItem()` allowing crafting when items aren't there

v1.1.3
  - Fix the tree respawn not being linked to the timing in config.lua
  - Fix fxmanifest not loading the server file

v1.1.2
  - Change HasItem to built in event and optimize events
  - Add check to when too close to the tree, so the play does try to run towards it
  - Add Config option to toggle wether the saw can break or not
  - Spawned trees now have randomly adjusted rotations so they aren't all perfectly vertical

v1.1.1
  - Change HasItem callback to `QBCore.Functions.HasItem`
  - Made use of lookEnt() more when interacting with peds

v1.1
  - Added powersaw as an item, players need this in their inventory to cut trees now
    - This item has a 10% chance of breaking when cutting trees/logs
  - Simple store added to purchase saw + provisions
  - Added ability to job lock the entire job
    - Change Config.Job to the required job name
  - Added Origiami items to be crafted
    - Use them for an animation
  - Crafting bench now, if an item isn't found in items.lua, skips showing the recipe instead of breaking the script

v1.0.1
  - Removed Testing prints
  - Added timeout to model loading event to help prevent script hangs
  - Added PowerSaw prop to load when entering polyzone
  - Changed PowerSaw Prop and adjusted attach locations
  - Better removal of qb-target of fallen logs to prevent targets being carried over to other entities
  - Added missing locales to client.lua