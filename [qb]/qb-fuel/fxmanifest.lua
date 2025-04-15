fx_version 'cerulean'
game 'gta5'

shared_scripts {
	'shared/config.lua',
}

client_scripts {
    '@PolyZone/client.lua',
	'client/client.lua',
	'client/electric.lua',
	'client/utils.lua',
	'client/blips.lua'
}

server_scripts {
	'server/server.lua'
}

exports {
	'GetFuel',
	'SetFuel'
}

lua54 'yes'

data_file 'DLC_ITYP_REQUEST' 'stream/[electric_nozzle]/electric_nozzle_typ.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[electric_charger]/electric_charger_typ.ytyp'


dependencies {
	'qb-target',
	'PolyZone', 
	'qb-input',
	'qb-menu',
	'interact-sound',
}