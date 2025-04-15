Config = {
    ServerCallbacks = {}, -- Don't edit or change
    AutoDatabaseCreator = true,
    InvoiceJobs = {
        ["police"] = {commision = 0},
        ["ambulance"] = {commision = 0},
        ["mechanic"] = {commision = 40},
        ["goverment"] = {commision = 0},
        ["justics"] = {commision = 100},
    },
    MaxInvoiceValue = 999999,
    BillsMenu = {
        Command = "mybills",
        Keybinding = {
            Enable = true,
            Key = "F5",
            Description = "See bills/taxes"
        }
    },
    InvoiceMenu = {
        Command = "invoice",
        Keybinding = {
            Enable = true,
            Key = "F7",
            Description = "Open invoice menu"
        }
    },

}
