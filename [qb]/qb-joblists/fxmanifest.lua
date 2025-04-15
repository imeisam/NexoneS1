fx_version 'cerulean'
game 'gta5'

ui_page 'html/index.html'
files {
    'html/index.html',
    'html/script.js',
    'html/style.css',
    'html/*otf',
    'html/*png',
    'fonts/*.ttf',
    'fonts/*.otf'
}  
shared_scripts {
    'config.lua',
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
}

lua54 'yes'
