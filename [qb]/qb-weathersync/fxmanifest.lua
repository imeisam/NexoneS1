fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Kakarot'
description 'Syncs the time & weather for all players on the server and allows editing by command'
version '2.1.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua'
}
server_script 'server/server.lua'
client_script {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    'client/client.lua',
}
