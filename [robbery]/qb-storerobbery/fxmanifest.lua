fx_version 'cerulean'
game 'gta5'

shared_script {'config.lua'}

client_scripts {
    'client/main.lua',
    'client/main_game.lua',
}

ui_page 'html/index.html'
files { 'html/index.html', 'html/style.css', 'html/script.js' }
server_script {'server/main.lua',
'server/main_game.lua',
}

lua54 'yes'