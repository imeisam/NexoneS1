Upload = Upload or {}

Upload.ServiceUsed = 'discord'   -- discord | fivemanage | fivemerr
Upload.Token = 'YOUR_TOKEN'      --  fivemanage or fivemerr | [*note - for discord webhook is to be changed below not here]

-- FOR DISCORD LOGS
Upload.DiscordLogs = {
    Enabled = false,
    Username = 'Spy Bodycam Records',     -- Bot Username
    Title = 'Bodycam Records',            -- Message Title
}

-- Upload Hooks if Upload.ServiceUsed = discord
Upload.DefaultUploads = {   -- Default Upload of log if job not mentioned in Upload.JobUploads. 
    webhook = 'YOUR_WEBHOOK',
    author = {
        name = "Spy Bodycam",
        icon_url = "https://i.imgur.com/tMyAdkz.png"
    }
}

Upload.JobUploads = {  -- Job Speific Uploads
    ['police'] = {
        webhook = 'https://discord.com/api/webhooks/1281391996963000441/Lb6ZsVhZMKf4s8wnMDyblPvAJP11LMdNTASO22_zWFuf5rYtd6DTdhi_b4C_dizOPSNo',
        author = {
            name = "Police Department",
            icon_url = "https://i.imgur.com/tMyAdkz.png"
        }
    }, -- Add more here
    ['ambulance'] = {
        webhook = 'https://discord.com/api/webhooks/1281890061746700288/b6cR2TdFrUD50iBFJGDdUGQHR8xMsxKZlT4YReH8DEROSSJZ4ypCoEfKgBR-1bH2t-l1',
        author = {
            name = "Medical Department",
            icon_url = "https://i.imgur.com/tMyAdkz.png"
        }
    }, -- Add more here
    ['justice'] = {
        webhook = 'https://discord.com/api/webhooks/1281890618414465145/QGZYBXuAqw9G9q965KDFdh5hbLSLzuUkcMKDORCnD7vsBTWAJEAvTP5AM2EHtXFPHQot',
        author = {
            name = "Doj",
            icon_url = "https://i.imgur.com/tMyAdkz.png"
        }
    }, -- Add more here
    ['goverment'] = {
        webhook = 'https://discord.com/api/webhooks/1281890912087183484/j4Q0fsM2ORQLBdn6tHXQVARcJLouArRa4-mj6dZJjFL6pKgKPpIrJF51yaiA81GjNEwK',
        author = {
            name = "Goverment",
            icon_url = "https://i.imgur.com/tMyAdkz.png"
        }
    }, -- Add more here
    
}
