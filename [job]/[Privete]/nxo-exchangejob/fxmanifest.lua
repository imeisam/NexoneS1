
fx_version "cerulean"
game "gta5"
lua54 "yes"

author "SAM.Sohrabi"
description ""
version "1.0.1"

--[[ Manifest ]]
shared_scripts {
	"@ox_lib/init.lua",
}

client_scripts {
	"client.lua",
	}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	"server.lua",
}
