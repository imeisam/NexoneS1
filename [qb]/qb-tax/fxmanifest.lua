fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'sam.sohrabi'

client_scripts {
	'client.lua',
}

server_script {'@oxmysql/lib/MySQL.lua','server.lua',}

shared_script{'config.lua'}
