fx_version 'adamant'

game 'gta5'

version '1.0' 

lua54 'yes'

shared_scripts{
    'config.lua',
} 

server_scripts {
	'server.lua',
    'config.lua'
}

client_scripts {
	'client.lua',
    'config.lua'
}
