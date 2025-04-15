fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
	'shared/cores.lua',
	'shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua',
    'shared/config.lua',
    'shared/vehicles.lua',
}

client_scripts {
	'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}

ui_page 'html/index.html'
files {
	'html/index.html',
	'html/style.css',
	'html/index.js',
    'html/image/noimage.png',
    'html/files/*.png',
    'html/files/*.webp',
    'html/files/*.jpg',
	'html/fonts/*.ttf'
}

dependency '/assetpacks'
dependency '/assetpacks'