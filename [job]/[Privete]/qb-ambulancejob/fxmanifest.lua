fx_version 'cerulean'
game 'gta5'

shared_scripts {
	'@qb-core/shared/locale.lua',
	'locales/en.lua',
	'config.lua'
}

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/ComboZone.lua',
	'client/main.lua',
	'client/wounding.lua',
	'client/job.lua',
	'client/dead.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

lua54 'yes'