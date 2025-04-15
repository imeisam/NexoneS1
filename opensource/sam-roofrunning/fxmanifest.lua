fx_version 'cerulean'
lua54 'yes'

game 'gta5'
server_scripts {

	'server.lua'
}

client_scripts {
	'client.lua',
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/ComboZone.lua'
}

shared_scripts{
	'config.lua'
}

dependencies {
    'PolyZone',
	'qb-target'
}