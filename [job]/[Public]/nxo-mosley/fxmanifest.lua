fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Kane'
description 'are you okay? cuz...'
version '1.0'

escrow_ignore 'config.lua'

-- What to run
shared_scripts {
    'config.lua',
}

client_scripts {
    'client.lua',
}

server_scripts {
    "server.lua",
}

dependency '/assetpacks'