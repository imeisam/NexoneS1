fx_version 'cerulean'
game 'gta5'

shared_script 'config.lua'
client_script 'client.lua'
server_script 'server.lua'

ui_page('html/ui.html')

files {
  'html/ui.html',
  'html/js/script.js',
  'html/css/style.css',
  'html/img/radio.png',
  'html/img/radiooff.png'
}

dependencies {
	'pma-voice',
}

lua54 'yes'