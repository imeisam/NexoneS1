fx_version 'cerulean'
game 'gta5'

shared_scripts {
    'config.lua',
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/main.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

ui_page 'html/index.html'
files {
	'html/index.html',
	'html/style.css',
	'html/index.js',
    'html/cars/*.png',
    'html/files/*.png',
    'html/files/*.webp',
    'html/files/*.jpg',
	'html/fonts/*.ttf'
}

lua54 'yes'