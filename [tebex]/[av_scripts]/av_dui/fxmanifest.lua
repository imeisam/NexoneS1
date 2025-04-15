fx_version 'cerulean'
description 'AV DUI'
author 'Avilchiis'
version '1.0.0'
lua54 'yes'
games {
    'gta5'
}

ui_page 'web/dist/index.html'

shared_scripts {
    '@ox_lib/init.lua',
    'config/*.lua'
}

client_scripts {
    'client/**/*',
}

files {
    'web/dist/index.html',
    'web/dist/**/*',
}

escrow_ignore {
    'client/editable/*',
    'config/*',
}

dependencies {
    "ox_lib",
}

dependency '/assetpacks'