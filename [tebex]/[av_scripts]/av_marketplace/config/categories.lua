Config = Config or {}
Config.Categories = {
    ['items'] = {
        label = "Items",
        canAccess = function()
            -- add your own check here, return true/false
            return true
        end,
        canPost = function()
            -- add your own check here, return true/false to allow specific players from posting items using this category
            return true
        end,
    },
    ['properties'] = {
        label = "Properties",
        canAccess = function()
            -- add your own check here, return true/false
            return true
        end,
        canPost = function()
            -- add your own check here, return true/false to allow specific players/jobs from posting items using this category
            return true
        end,
    },
    ['illegal'] = {
        label = "BlackMarket",
        canAccess = function()
            -- add your own check here, return true/false
            if exports['av_laptop']:hasJob({"police", "ambulance", "judge"}) then return false end -- block specific jobs from accessing
            if GetResourceState("av_gangs") == "started" then
                local isGang = exports['av_gangs']:getGang() -- maybe just gang members can access?
                if isGang then return true end
            end
            return true
        end,
        canPost = function()
            -- add your own check here, return true/false to allow specific players/jobs from posting items using this category
            if exports['av_laptop']:hasJob({"police", "ambulance", "judge"}) then return false end -- block specific jobs from accessing
            if GetResourceState("av_gangs") == "started" then
                local isGang = exports['av_gangs']:getGang() -- maybe just gang members can access?
                if isGang then return true end
            end
            return true
        end,
    },
}