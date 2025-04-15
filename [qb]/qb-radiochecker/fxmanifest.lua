fx_version 'cerulean'
game 'gta5'

client_script 'client.lua'
server_script 'server.lua'

ui_page('html/index.html')

files {
  'html/index.html',
  'html/script.js',
  'html/style.css',
  'html/*otf',
  'html/*png',
  'images/*.png',
  'images/*.jpg',
  'images/*.webp',
  'images/*.mp4',
  'fonts/*.ttf',
  'fonts/*.otf'
}

lua54 'yes'