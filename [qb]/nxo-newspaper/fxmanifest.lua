fx_version 'cerulean'

game 'gta5'

description 'NewsPaper'
author 'sam.sohrabi'
version '1.0.2'

ui_page 'html/index.html'

server_script {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server/server.lua'
}

client_scripts {
    'config.lua',
    'client/client.lua'
} 

files {
    'html/index.html',
    'html/style.css',
    'html/reset.css',
    'html/listener.js',
    'html/newspaper.png'
}