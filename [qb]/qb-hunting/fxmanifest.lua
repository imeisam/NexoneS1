fx_version 'bodacious'
game 'gta5'


client_script {
    'client/cl_*.lua',
	'@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'Config.lua',
}

server_scripts {
    "server/sv_*.lua"
}