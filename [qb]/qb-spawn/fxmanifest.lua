fx_version "cerulean"
game "gta5"
lua54 "yes"
author "LeaReXx & theMani_kh"

client_scripts {
    '@PolyZone/client.lua',
    "dump/main.lua",
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    "@qb-apartments/shared/config.lua",
    "server/main.lua",
}

ui_page "build/index.html"

files {
    "build/index.html",
    "build/image/*",
    "build/**"
}