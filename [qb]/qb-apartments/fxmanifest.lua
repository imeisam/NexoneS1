fx_version 'cerulean'
game 'gta5'

author 'theMani_kh'

shared_scripts {
    'shared/config.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

client_scripts {
	'client/main.lua'
}

files {
    'stream/lev_apart_shell.ytyp',
	'stream/tihulu_kafi_motel.ytyp',
    'stream/tpcm_motel_shell.ytyp'
}

data_file 'DLC_ITYP_REQUEST' 'stream/lev_apart_shell.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/tihulu_kafi_motel.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/tpcm_motel_shell.ytyp'

lua54 'yes'