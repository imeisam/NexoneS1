fx_version "cerulean"
game { "gta5" }

author 'sam'
description 'payphone.'
version '1.1.0'

client_scripts {
  'client.lua',
  'Config.lua',
}

server_scripts {
  'server.lua',
}

files {
  'web/index.html',
  'web/asset-manifest.json',
  'web/static/media/*.ttf',
  'web/static/media/*.otf',
  'web/static/js/*.js',
  'web/static/css/*.css',
}

ui_page 'web/index.html'
