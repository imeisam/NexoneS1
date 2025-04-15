fx_version 'cerulean'
game 'gta5'
author 'Izzy <izzy.tebex.io>'
lua54 'yes'

client_script 'client.lua'
server_script 'server.lua'

shared_scripts {
    'shared/cfg.lua',
    'shared/utils.lua',
    'shared/shared.lua',
}

ui_page 'web/index.html'
files {
    'web/*',
    'web/**/*',
}

escrow_ignore {
    'client.lua',
    'server.lua',
    'shared/cfg.lua',
    'shared/utils.lua',
    'shared/shared.lua',
}

dependency '/assetpacks'