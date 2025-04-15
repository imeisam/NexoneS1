fx_version 'cerulean'
description 'sam-jewelryrun'
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
    'main.lua',
    'client_normal.lua',
'client_highrisk.lua',
'client_hotrun.lua',
}

server_scripts {
'@oxmysql/lib/MySQL.lua',
'server.lua'
}
