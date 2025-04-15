Config = {
    ServerCallbacks = {}, -- Don't edit or change
    AutoDatabaseCreator = true,
    InvoiceJobs = {
        ["police"] = {commision =100},
        ["ambulance"] = {commision =100},
        ["goverment"] = {commision = 100},
        ["justice"] = {commision = 100},
        ["realestate"] = {commision = 100},
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
