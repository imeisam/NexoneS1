fx_version 'cerulean'
game 'gta5'

author 'discord : parsabg1'
description 'QB-Core Snakes and Ladders Create By ParsaBG'
version '1.0.1'

shared_script '@qb-core/shared/locale.lua'

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}


files {
    'html/index.html'
}

dependencies { 
    'interact-sound',
}
lua54 'yes'