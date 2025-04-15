fx_version 'cerulean'
game 'gta5'

client_scripts {
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}

-- server_exports {
--     'AddMoney',
--     'AddGangMoney',
--     'RemoveMoney',
--     'RemoveGangMoney',
--     'GetAccount',
--     'GetGangAccount',
-- }

lua54 'yes'
