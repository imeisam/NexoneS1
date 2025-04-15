fx_version 'cerulean'
game 'gta5'

client_scripts {
    'client/cl_*.lua',
    'client/cl_*.js',
}

server_scripts {
    'server/sv_*.lua',
}

ui_page "client/nui/index.html"

files {
	"client/nui/index.html",
    "client/nui/app.js",
    "client/nui/main.css",
}

data_file 'DLC_ITYP_REQUEST' 'stream/ps_camera.ytyp'

lua54 'yes'