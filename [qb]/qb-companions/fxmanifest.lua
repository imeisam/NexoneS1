fx_version "cerulean"
game "gta5"

shared_scripts {
    "shared/*",
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    "server/*",
}

client_scripts {
    "client/*",
}