lua54 'yes'
fx_version 'cerulean'
game 'gta5'
author 'Pug'
description 'Pug-animals | Discord: Pug#8008'
version '1.0.0'
client_script 'client/*.lua'

server_script {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}

shared_script {
    'config.lua',
}

escrow_ignore {
    'config.lua',
}