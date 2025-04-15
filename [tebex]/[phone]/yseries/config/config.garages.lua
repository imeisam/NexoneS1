Config = Config or {}

Config.Garages = "auto"
--[[
    The garages script you use.
    If yours is not supported you can follow these steps to integrate it.
    1. Rename the `your_garage.lua` file in both `(client/server)\apps\framework\garage` with the name of your garage script. ex: qb-garages.lua.
    2. Check `client\apps\framework\garage\garage.lua` what is the expected garage object. (array of vehicles)
    3. Implement the functions according to your garage. You can use the `qb-garages.lua` as an example.
    4. Change `Config.Garages` to the name of your garage script.
    5. If you want open a ticket and contribute the integration so other people can use it as well.
    Supported:
        * qb-garages - https://github.com/qbcore-framework/qb-houses
        * qbx_garages - https://github.com/Qbox-project/qbx_garages
        * esx_garage - https://github.com/esx-framework/esx_garage
        * jg-advancedgarages - https://jgscripts.com/scripts/advanced-garages
        * vms_garagesv2 - https://www.vames-store.com/category/scripts
    ]]

Config.Valet = {}
Config.Valet.Enabled = false -- Allow players to get their vehicles from the phone
Config.Valet.Price = 100     -- Price to get your vehicle
Config.Valet.VehicleKeys =
"none"            -- or "qb-vehiclekeys", "MrNewbVehicleKeys", "jaksam-vehicles-keys", "qs-vehiclekeys", "mk_vehiclekeys", "wasabi_carlock", "cd_garage", "okokGarage", "t1ger_keys", "Renewed", "qbx_vehiclekeys", "none"
