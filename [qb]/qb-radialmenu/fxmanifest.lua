fx_version 'cerulean'
game 'gta5'

shared_scripts {
    'config.lua',
    '@qb-core/shared/locale.lua',
    'locales/en.lua'
}

client_script {
    "client/*.lua",
}

server_script {
    "server/*.lua",
}

ui_page "nui/dist/index.html"
files {
  "nui/dist/*",
  "nui/dist/index.html",
	"nui/dist/assets/*",
}