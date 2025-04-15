fx_version 'cerulean'
game 'gta5'

description 'Banking Script'
version '1.1.6'
author 'Snipe'

lua54 'yes'
ui_page 'html/index.html'

shared_scripts { 
    '@ox_lib/init.lua',
    'shared/*.lua',
}

files {
	'html/**/*',
    'locations/**/*'
}

client_scripts{
    'init.lua',
    'client/**/*.lua',
} 

server_scripts{
    '@oxmysql/lib/MySQL.lua',
    'server/open/sv_framework.lua',
    'server/encrypted/*.lua',
    'server/open/*.lua',
} 

escrow_ignore {
    'shared/**/*.lua',
    'locations/**/*',
    'client/open/*.lua',
    'server/open/*.lua',
}

dependency '/assetpacks'