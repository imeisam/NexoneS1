fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

description 'Chess by Prime Developments | Lubes'
version '1.0.9'

data_file 'DLC_ITYP_REQUEST' 'stream/chess_props.ytyp'

ui_page 'html/index.html'

client_scripts {
	'config.lua',
	'locales/*.lua',
	'client/functions.lua',
	'client/NUI.lua',
	'client/client.lua',
	'client/editables.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'locales/*.lua',
	'server/editables.lua',
	'server/server.lua',
	'ESX/item.lua'
}

escrow_ignore {
	'@mysql-async/lib/MySQL.lua',
	'html/*.html',
    'html/*.png',
	'html/*.mp3',
	'html/*.wav',
	'html/*.css',
	'html/.sass',
	'html/*.js',
	'html/seed.js',
	'html/fonts/*.ttf',
	'html/img/*.png',
	'config.lua',
	'locales/*.lua',
	'pd_extra_table.sql',
	'server/editables.lua',
	'stream/*.ydr',
	"stream/*.ytyp",
	'ESX/item.lua',
	'client/editables.lua'

}

dependency {
}

files {
    'html/*.html',
    'html/*.png',
	'html/*.mp3',
	'html/*.wav',
	'html/*.css',
	'html/.sass',
	'html/*.js',
	'html/seed.js',
	'html/fonts/*.ttf',
	'html/img/*.png',
}

exports = {
	"startChess",
	"StartChess"
}
dependency '/assetpacks'