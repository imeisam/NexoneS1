name "jim-lumberjack"
author "Jimathy"
version "v1.1.4"
description "LumberJack Script By Jimathy"
fx_version "cerulean"
game "gta5"

dependencies {
	'qb-menu',
    'qb-target',
}

shared_scripts { 'config.lua', 'locales/*.lua', 'shared/*.lua' }
server_scripts { 'server/*.lua' }
client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
	'client/*.lua',
}

lua54 'yes'

escrow_ignore {
	'*.lua*',
	'client/*.lua*',
	'server/*.lua*',
    'locales/*.lua',
    'shared/*.lua'
}
dependency '/assetpacks'