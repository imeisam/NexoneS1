fx_version 'cerulean'

game 'gta5'

author 'OrigenNetwork'

version '1.0.3'

shared_scripts {
	'@ox_lib/init.lua',
	'@ox_lib/imports/points/client.lua',
	'init.lua',
	'config/_main.lua',
	'config/translations/*.lua',
	'config/*.lua',
}

client_scripts {
	'custom/client/*.lua',
	'client/classes/*.lua',
	'client/*.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'config/logs/*.lua',
	'custom/server/*.lua',
	'server/modules/*.lua',
	'server/classes/*.lua',
	'server/*.lua',
}

files {
	'ui/index.html',
	'ui/css/*.css',
	'ui/js/*.js',
	'ui/img/*.*',
	'ui/img/**/*.*',
	'ui/sounds/*.*',
}

ui_page 'ui/index.html'

dependencies {
	'ox_lib',
	'bob74_ipl',
}

--Escrow

lua54 'yes'

escrow_ignore {
    'config/*.lua',
    'config/**/*.lua',
	'custom/**/*.lua',
}
dependency '/assetpacks'