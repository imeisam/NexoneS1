fx_version 'cerulean'
description 'AV Laptop'
author 'Avilchiis'
version '3.0.0'
lua54 'yes'
games {
'gta5'
}

ui_page 'web/build/index.html'

shared_scripts {
'@ox_lib/init.lua',
'config/*.lua'
}

client_scripts {
'client/**/*',
}

server_scripts {
'@oxmysql/lib/MySQL.lua',
'server/**/*'
}

files {
'web/build/index.html',
'web/build/**/*',
'icons/*'
}

escrow_ignore { 
'config/*.lua',
'client/editable/*.lua',
'server/editable/*.lua',
}

dependencies {
    "ox_lib"
}
dependency '/assetpacks'