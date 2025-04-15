fx_version 'cerulean'
description 'sam-laundrymachine'
author 'Sam.Sohrabi'
version '1.0.0'
lua54 'yes'
games {
'gta5'
}

shared_scripts {
'config.lua'
}

client_scripts {
'client.lua',
'c_miss.lua',
}

server_scripts {
'@oxmysql/lib/MySQL.lua',
'server.lua',
's_miss.lua',
}
