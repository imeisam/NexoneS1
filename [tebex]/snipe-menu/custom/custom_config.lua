CustomPanels = {
    {
        
        panelTitle =  'Clear All Chat',
        submitUrl = 'clearall-chat',
        components =  {}
        
    },
    {
        panelTitle = "Kill",
        submitUrl = "killplayer",
        components = {
            {
                type = "searchable-dropdown",
                placeholder = "",
                fetchDataUrl = "customgetplayers",
                label = "Player List",
                fillCompulsory = true,
                keyName = "searchableDropDownkey"
            },
        }
    },
    {
        panelTitle = "Set Waypoint",
        submitUrl = "setwaypoint",
        components = {
            {
                type = "searchable-dropdown",
                placeholder = "",
                fetchDataUrl = "customgetplayers",
                label = "Player List",
                fillCompulsory = true,
                keyName = "searchableDropDownkey"
            },
        }
    },
    {
        panelTitle = "Screenshot",
        submitUrl = "scrennshot",
        components = {
            {
                type = "searchable-dropdown",
                placeholder = "",
                fetchDataUrl = "customgetplayers",
                label = "Player List",
                fillCompulsory = true,
                keyName = "searchableDropDownkey"
            },
        }
    },
    {
        panelTitle =  'Put Player In Vehicle',
        submitUrl = 'putinvehicle',
        components =  {}
    },
    {
        panelTitle =  'Dead Style',
        submitUrl = 'deadstyle',
        components =  {}
    }
}