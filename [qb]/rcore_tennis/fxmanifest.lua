fx_version 'bodacious'
game 'gta5'

description 'TEB tennis'

version '1.2.0'

client_scripts {
    'config.lua',
    'client/warmenu.lua',
    'client/run.lua',
    -- '@qb-lib/client/cl_interface.lua',
}
-- client_script "@qb-lib/client/cl_interface.lua"
-- client_script "@qb-lib/client/cl_polyhooks.lua"
-- client_script "@qb-locales/client/lib.lua"

server_scripts { 
    'server/crack.lua',
    'config.lua',
    'server/code.lua',
    'server/run.lua',
}

ui_page('client/html/sound.html')

files {
    'client/html/sound.html',
    'client/html/*.ogg',
}