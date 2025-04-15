Config = {}

Config.MaxDistance = 25 --max distance that can be placed & viewed, passed to UI for view distance
Config.Log = true --logs the scene creation and deletion with ox_lib logging
Config.MaxScenes = 999 --max scenes that can be placed
Config.MaxDuration = 50 --max duration the scene can be set in hours
Config.NeverExpire = true --set this to true for an option that scenes never expire in the UI and they will not be deleted from db
Config.NeverExpireAdmin = false --if set to true then you have to be an admin to see the NeverExpire option if true
Config.CheckForCollisions = true --enable this to check for collisions
Config.AuditInterval = 15 --How many minutes to wait to query the databse to check for expired scenes