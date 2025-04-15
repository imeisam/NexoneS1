fx_version 'adamant'
game 'gta5'

lua54 'yes'

client_scripts {    '@PolyZone/client.lua',
'@PolyZone/BoxZone.lua','config.lua', 'client/*.lua' }

server_scripts { 'config.lua', 'server/*.lua', '@oxmysql/lib/MySQL.lua'}
 
ui_page "html/index.html"
  
files { 
	"html/*",
	"fonts/*",
}