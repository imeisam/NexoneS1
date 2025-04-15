fx_version 'cerulean'
game 'gta5'

author 'theMani_kh'

shared_script 'config.lua'

client_scripts {
    '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/ComboZone.lua',
    "client/main.lua"
}

server_script {
     '@oxmysql/lib/MySQL.lua',
'server/main.lua',}
