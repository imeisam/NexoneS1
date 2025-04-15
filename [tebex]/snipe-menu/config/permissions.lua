local PerCore = exports[Config.CoreFolderName]:GetCoreObject()
Config.GodRoles = {}
for k,v in ipairs(PerCore.Shared.PermissionsList) do
    Config.GodRoles[v.name] = v.label
end
Config.Permissions = PerCore.Shared.Permissions