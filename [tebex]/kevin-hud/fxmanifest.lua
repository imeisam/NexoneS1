
fx_version 'cerulean'
author 'KevinGirardx'
description 'Player Hud System'
lua54 'yes'
game 'gta5'

files {
    'shared/*.lua',
    'ui/build/**/*',
    'ui/**',
}

shared_script {
    '@ox_lib/init.lua',
    '@qbx_core/modules/lib.lua',
}

client_scripts {
	'client/**.lua',
    'bridge/client/**.lua',
    -- '@qbx_core/modules/playerdata.lua' -- comment if not using qbox
}

server_scripts {
	'server/*.lua',
    'bridge/server/**.lua',
    '@oxmysql/lib/MySQL.lua',
}

ui_page 'ui/build/index.html'
ox_lib 'math'

escrow_ignore {
    'shared/*.lua',
    'bridge/client/**.lua',
    'bridge/server/**.lua',
    'client/minimap.lua',
}
dependency '/assetpacks'