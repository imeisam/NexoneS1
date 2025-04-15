
fx_version 'cerulean'

author 'Nyx Development'

game 'gta5'

shared_script {
	'config.lua',
    '@ox_lib/init.lua',
}

client_scripts {
	'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
	'server/*.lua'
}

lua54 'yes'