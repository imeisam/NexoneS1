fx_version 'cerulean'
game 'gta5'

description 'NexOne S1 Qbcore'

shared_scripts {
	'config.lua',
    'shared/locale.lua',
	'locale/en.lua',
	'shared/main.lua',
	'shared/permissions.lua',
	'shared/items.lua',
	'shared/jobs.lua',
	'shared/vehicles.lua',
	'shared/gangs.lua'
}

client_scripts {
	'client/main.lua',
	'client/functions.lua',
	'client/loops.lua',
	'client/events.lua',
	'client/drawtext.lua',
	'client/key.lua',
	'client/vehicle.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua',
	'server/functions.lua',
	'server/player.lua',
	'server/events.lua',
	'server/commands.lua',
	'server/ban.lua',
	'server/debug.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/css/style.css',
    'html/js/app.js'
}

dependency 'oxmysql'

lua54 'yes'