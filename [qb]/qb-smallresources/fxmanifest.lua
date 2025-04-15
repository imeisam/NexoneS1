fx_version 'cerulean'
game 'gta5'

shared_script 'config.lua'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
    'stash.lua'
}

client_scripts {
    '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/ComboZone.lua',
    'client/*.lua'
}

lua54 'yes'