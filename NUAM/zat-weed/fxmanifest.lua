fx_version 'cerulean'

games {"gta5", "rdr3"}

author "Project Error"
version '1.0.0'

lua54 'yes'

ui_page 'web/build/index.html'

client_script "client/**/*"

files {
  'web/build/index.html',
  'web/build/**/*'
}
server_scripts {
  "server/**/*",
  '@oxmysql/lib/MySQL.lua'
}
shared_scripts {
  'locales/locales.lua',
  'config.lua',
  --'@es_extended/imports.lua', -- only for ESX
  --'@es_extended/locale.lua',  -- only for ESX
}

escrow_ignore {
  'config.lua',
  'server/main.lua',
  'server/consumables.lua',
  'server/inventories.lua',
  'client/target.lua',
  'client/progressbars.lua',
  'client/inventories.lua',
  'locales/locales.lua',
}
dependency '/assetpacks'