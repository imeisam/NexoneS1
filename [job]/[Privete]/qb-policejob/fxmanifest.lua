fx_version 'cerulean'
game 'gta5'

shared_scripts {
    'config.lua',
    '@qb-core/shared/locale.lua',
    'locales/en.lua'
}

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/ComboZone.lua',
	'client/main.lua',
	'client/interactions.lua',
	'client/job.lua',
	'client/evidence.lua',
	'client/objects.lua',
	'client/doj.lua',
	'client/marshal.lua',
	'client/goverment.lua',
	'client/xraygate.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua',
	'server/xraygate.lua',
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/vue.min.js',
	'html/script.js',
	'html/fingerprint.png',
	'html/main.css',
	'html/vcr-ocd.ttf',
	'html/assets/css/*.css',
	'html/assets/js/*.js',
	'html/assets/fonts/roboto/*.woff',
	'html/assets/fonts/roboto/*.woff2',
	'html/assets/fonts/justsignature/JustSignature.woff',
	'html/assets/images/*.png'
}

lua54 'yes'