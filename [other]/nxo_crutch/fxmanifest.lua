fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
  '@ox_lib/init.lua',
  'configuration/*.lua'
}

client_scripts {
  'bridge/**/client.lua',
  'client/*.lua'
}

server_scripts {
  'bridge/**/server.lua',
  'server/*.lua'
}

dependencies {
    'ox_lib'
}

