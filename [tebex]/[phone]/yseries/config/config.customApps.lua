Config = Config or {}

Config.CustomApps = { -- This is not an actual app, it's just an example of how to add a custom app as an *iframe* to the phone.
    {                 -- An example app. Refer to docs for more on information how to use it.
        key = "Tetris",
        name = "Tetris",
        defaultApp = false,
        game = true,
        ui = "https://www.lumpty.com/amusements/Games/Tetris/tetris.html",
        icon = {
            yos = "https://cdn-icons-png.flaticon.com/512/2314/2314912.png", -- YPhone OS icon.
            humanoid = "https://cdn-icons-png.flaticon.com/512/566/566312.png", -- YFlip OS icon.
        },
    },
    {                 -- An example app. Refer to docs for more on information how to use it.
    key = "OnlyFans",
    name = "Only Fans",
    defaultApp = false,
    game = false,
    ui = "https://www.lumpty.com/amusements/Games/Tetris/tetris.html",
    icon = {
        yos = "https://cdn.discordapp.com/attachments/1310938800444407871/1358191358422024455/image.png?ex=67f2f1c5&is=67f1a045&hm=26a771cab9c4730835337ff5914635c8b4591e96abc60379970b5caea14b050f&", -- YPhone OS icon.
        humanoid = "https://cdn.discordapp.com/attachments/1310938800444407871/1358191358422024455/image.png?ex=67f2f1c5&is=67f1a045&hm=26a771cab9c4730835337ff5914635c8b4591e96abc60379970b5caea14b050f&", -- YFlip OS icon.
    },
},
}
