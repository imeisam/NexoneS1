fx_version "cerulean"
game "gta5"

dependencies { 'qb-input', 'qb-menu', 'qb-target' }

client_scripts { 'client.lua' }

server_scripts { '@oxmysql/lib/MySQL.lua', 'server.lua', }

shared_scripts { 'config.lua', }

lua54 'yes'

dependency '/assetpacks'