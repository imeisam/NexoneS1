fx_version 'cerulean'
game 'gta5'

author "theMani_kh"

client_scripts {
    
    '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/ComboZone.lua',
    'config.lua',
    'client/shutter.lua',
    'client/weazelnews.lua',
    'client/tuner.lua',
    'client/main.lua',
     'client/paycheck.lua',
     'client/digitalden.lua',
     'client/hotdog.lua',
     'client/weazelnewscamera.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    'server/tuner.lua',
    'server/shutter.lua',
    'server/main.lua',
    'server/hotdog.lua',
    'server/news.lua'
}