local Translations = {
    categories = {
        openwheel = "Open Wheels",
        sedans = "Sedans",
        SportsClassics = "Sports Classics",
        commercial = "Commercial",
        ["Off-Road"] = "Off-Road",
        Cycles = "Cycles",
        boats = "Boats",
        military = "Military",
        Motorcycles = "Motorcycles",
        industrial = "Industrial",
        helicopters = "Helicopters",
        Vans = "Vans",
        super = "Super Sports",
        Sports = "Sports",
        coupes = "Coupes",
        Emergency = "Emergency",
        muscle = "Muscles",
        compacts = "Compacts",
        utility = "Utility",
        suvs = "SUV",
        service = "Services",
        planes = "Planes",
        medic = "Medic",
        doj = "doj",
        police = "Police",
    },
    commands = {
        add_vehicle_stock = "Add Stock To Vehicle"
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})