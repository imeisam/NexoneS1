fx_version 'cerulean'
game 'gta5'

description 'qb-Weapons'
version '1.0.0'

shared_scripts {
	'@qb-core/shared/locale.lua',
	'locales/en.lua',
	'config.lua',
}

server_script 'server/main.lua'
client_script 'client/main.lua'

lua54 'yes'