fx_version 'cerulean'
game 'gta5'

description 'Admin Menu Script'
version '3.0.0'
author 'Snipe'

lua54 'yes'
ui_page 'html/index.html'

shared_scripts { 
	'config/config.lua',
    'config/*.lua',
    'custom/custom_config.lua',
}

files {
	'html/**/*',
}

client_scripts{
    'utils/cl_utils.lua',
    'client/**/*.lua',
    'custom/client.lua'
} 

server_scripts{
    'utils/sv_utils.lua',
    '@oxmysql/lib/MySQL.lua',
    'server/**/*.lua',
    'custom/server.lua'
} 

escrow_ignore {
    'utils/sv_utils.lua',
    'utils/cl_utils.lua',
    'config/config.lua',
    'config/locales.lua',
    'config/permissions.lua',
    'config/config_new.lua',
    'config/config_compatibility.lua',
    'client/open/cl_clothing.lua',
    'client/open/cl_customise.lua',
    'client/open/cl_customise_1.lua',
    'client/open/cl_inventory.lua',
    'client/open/cl_keybinds.lua',
    'client/open/cl_names.lua',
    'client/open/cl_noclip.lua',
    'client/open/cl_noclip2.lua',
    'client/open/cl_troll_customise.lua',
    'client/open/cl_vehicles_customise.lua',
    'client/open/cl_vehdebug.lua',
    'client/open/cl_weather.lua',
    'client/open/pedlist.lua',
    'server/open/sv_clothing.lua',
    'server/open/sv_playermanagement.lua',
    'server/open/sv_ambulance.lua',
    'server/open/sv_customise.lua',
    'server/open/sv_webhooks.lua',
    'server/open/sv_customise_new.lua',
    'server/open/sv_customise_2.lua',
    'server/open/sv_vehicles.lua',
    'server/open/sv_inventory.lua',
    'server/open/sv_chat.lua',
    'custom/server.lua',
    'custom/client.lua',
    'custom/custom_config.lua',
}

dependency '/assetpacks'