lua54 'yes'
fx_version 'cerulean'
game 'gta5'
author 'SAM'
description 'Advanced Food Job'
version '1.7.0'
client_script {
    'client.lua',
}
server_script {
    '@oxmysql/lib/MySQL.lua',
    'server.lua',
}
shared_script {
    'config.lua',
}