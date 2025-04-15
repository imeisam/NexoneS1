-- MAKE SURE TO IMPORT THE "pd_extra_table.sql" FILE

-- The script is completely standalone, only requiring mysql to store the elo.

--EXPORTED FUNCTION NAME:
--startChess
--StartChess

Config                                          = {}
Config.debug                                    = false
Config.Locale                                   = 'en'
Config.SQLDriver                                = 'mysql' -- options: oxmysql, mysql
Config.useItemFramework                         = "QBCore" -- options: false, "ESX", "QBCore"

-- IF USING ESX or QBCORE ITEM --
Config.itemName                                 = "pd_chess_board"
-----------------------

-- requires either qtarget or qb-target
Config.target = {
    enabled                                     = true,
    system                                      = 'qb-target',
    pickupIcon                                  = "fa-solid fa-x",
    joinGameIcon                                = "fa-solid fa-chess-board"
}

Config.useELORating                             = true -- Enable/ disables the use of the ELO system
Config.startingELO                              = 1000 -- Base ELO for players
Config.playerIdentifierType                     = "license" -- OPTIONS: license, xbl, live, discord, fivem, license2

Config.useChessCommand                          = true -- If set to false, make sure you call the exported chess function
Config.chessCommand                             = "chess" -- Start the chess game
Config.showELOCommand                           = "chessELO" -- Display Player ELO

Config.delayPieceMoveToMatchAnimation           = true --Delay the moving of the piece so it syncs up with the player. true = more cinamatic, false = more competative

Config.loadPiecesDistance                       = 50 -- Distance to load in the pieces of the games
Config.interactKeybind                          = "E" -- If used

Config.usePlayZone                              = false -- Players are only allowed to start chess matches in the designated play zones
Config.togglePlayZonesCommand                   = "togglePlayZones" -- shows play zones on the map
Config.playZones = {
    {
        x=195.8,
        y=-932.0,
        z=30.7,
        s=50.0
    },
    {
        x=-306.6,
        y=6116.9,
        z=31.7,
        s=20.0
    },
    {
        x=1828.8,
        y=3834.0,
        z=33.4,
        s=20.0
    },
    {
        x=1079.7,
        y=-691.2,
        z=57.6,
        s=15.0
    },
    {
        x=-1456.4,
        y=-1015.4,
        z=5.3,
        s=20.0
    },
}

Config.timeChoices = {
    ["choice1"] = 5, --in minutes
    ["choice2"] = 10, 
    ["choice3"] = 15,
    ["choice4"] = 20
}