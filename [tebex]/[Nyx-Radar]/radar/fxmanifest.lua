fx_version "cerulean"

games { "gta5" }

description "Nyx Development Radar"

version "1.0.0"

ui_page 'nui/dist/index.html'

files {
    "nui/dist/**/*",
}

server_scripts { "server.lua",'@oxmysql/lib/MySQL.lua', }
client_scripts { "build/cl_*.js" }
shared_scripts { "build/config.js" }

escrow_ignore {
    "build/config.js"
}
lua54 'yes'
dependency '/assetpacks'