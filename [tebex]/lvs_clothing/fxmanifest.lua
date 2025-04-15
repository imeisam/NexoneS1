fx_version "cerulean"
game "gta5"

author '@minguez[LVSoft]'
version '1.3.1'
description "A Nopixel 4.0 inspired player customization script for FiveM."

shared_scripts {
  'config/config.lua',
  'config/stores.lua',
  'config/cloakroom.lua',
  'config/target.lua',
  'init.lua',
  'config/peds.lua',
  'config/tattoos.lua',
  'config/blacklist.lua',
  'config/ui.lua',
  'config/wardrobe.lua',

  "locales/locales.lua",
  "locales/en.lua",
  "@ox_lib/init.lua"
}

client_scripts {
  'client/nexone.lua',
  'client/constants.lua',
  'client/global.lua',
  'client/util.lua',
  'client/quick.lua',
  'client/customization.lua',
  'client/nui.lua',

  "client/interact/target.lua",
  "client/interact/radial.lua",
  "client/interact/zones.lua",
  "client/interact/blips.lua",

  "client/bridge/notify/*.lua",
  "client/bridge/textui/*.lua",
  "client/bridge/target/*.lua",
  "client/bridge/radial/*.lua",

  "client/outfits.lua",
  "client/common.lua",
  "client/framework/framework.lua",
  "client/framework/qb/compatibility.lua",
  "client/framework/qb/main.lua",
  "client/framework/qb/migrate.lua",
  "client/framework/esx/compatibility.lua",
  "client/framework/esx/main.lua",

  "client/client.lua",

  '@PolyZone/client.lua',
  '@PolyZone/BoxZone.lua',
}

server_scripts {
  "@oxmysql/lib/MySQL.lua",
  "server/database.lua",
  "server/framework/qb/main.lua",
  "server/framework/qb/migrate.lua",
  "server/framework/esx/main.lua",
  "server/framework/esx/migrate.lua",
  "server/framework/esx/callbacks.lua",
  "server/util.lua",
  "server/server.lua",
  "server/permissions.lua",
  'server/version_check.lua',
}

files {
  'client/web/**/*.*',
  'client/web/*.*',
}

ui_page "client/web/ui.html"

escrow_ignore {
  'config/*.lua',
  'client/bridge/**.lua',
  'locales/*.lua',
  --'client/framework/*.lua',
  --'server/framework/*.lua',
}

lua54 "yes"

provides { "esx_skin", "skinchanger", "illenium-appearance", "qb-clothing" }

dependency '/assetpacks'