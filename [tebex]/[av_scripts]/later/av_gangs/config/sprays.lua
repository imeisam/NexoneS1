Config = Config or {}
Config.PlaceSprayTime = 30 --in seconds
Config.RemoveSprayTime = 30 -- in seconds
Config.ProgressType = "progressCircle" -- "progressCircle" or "progressBar"
Config.RemoveDistance = 7 -- distance needed to remove a graffiti
Config.ZoneRadius = 109.0 -- Gang zone radius created around the spray, applies for both zone and blip.
Config.MinMembersForRemover = 1 -- Min members online to remove their graffiti
Config.SprayGivesXP = 500 -- Gang receives XP when creating a graffiti or false
Config.RemoveSprayGivesXP = 1000 -- Remove other Gang Spray will give you XP or false
Config.LoseGraffitiXP = 1000 -- If your graffiti is removed, you will lose XP or false
Config.ShopAccount = 'bank' -- Account used to pay for items
Config.SprayTime = 6 -- (hours) Time before the spray item becomes totally unusable
Config.RemoveSprayOnUse = true -- true it will remove spray item on use, player will lose the item even if he decides not to place the graffiti
Config.ItemNames = {
    spray = "spray", -- Used to apply graffiti
    remover = "spray_remover" -- Used to remove graffiti
}
Config.Prices = { ['spray'] = 1000, ['remover'] = 20000 }
Config.ItemCooldown = { -- Cooldown in hours, gangs can buy this item every X hours
    [Config.ItemNames['spray']] = 7,
    [Config.ItemNames['remover']] = 7,
}
Config.SprayMultiplier = 1.25 -- Multiplier for spray price (SprayPrice * SprayMultiplier * Graffitis Count)

SpraySettings = { -- used for graffiti
    acceptKey = 38, -- Key used for confirm, default E
    cancelKey = 74, -- Key used for cancel, default H
    text1 = "[E] Start | [H] Cancel", -- shown when u need to set point 1
    text2 = "[E] End Point | [H] Cancel", -- used for point 2
    confirmText = "[E] Confirm | [H] Cancel", -- Accept/Cancel the preview
    maxPosCancel = 10, -- if the player goes too far from the starting point it will cancel the spray
    cancelled = "Cancelled",
    -- maxPosSphere: sphere render distance, higher number = player will be able to place the graffiti further away... needs to be equal or lower than Config.RemoveDistance
    maxPosSphere = Config.RemoveDistance, 
    minSize = 3.0, --Min size for graffiti
    maxSize = 20.0, -- Max size for graffiti
    tooSmall = "Graffiti is too small",
    tooBig = "Graffiti is too big",
}