fx_version "cerulean"

description "YBoomer Phone"
author "TeamsGG Development"
version '1.0.2'

lua54 "yes"

games {
  "gta5",
}

ui_page "ui/build/index.html"
nui_callback_strict_mode 'true'

shared_scripts {
  "@ox_lib/init.lua",
  "config/*.lua",
  "shared/**/*.lua",
}

client_script "client/**/*.lua"

server_scripts {
  "@oxmysql/lib/MySQL.lua",

  "server/**/*.lua"
}

files {
  "ui/build/**/*",
  "config/*.json"
}

escrow_ignore {
  "config/**/*",

  "shared/*.lua",

  "client/custom/**/*.lua",
  "server/custom/**/*.lua"
}

dependencies {
  '/server:9549',
  '/onesync',
  'oxmysql',
  'ox_lib',
}

dependency '/assetpacks'