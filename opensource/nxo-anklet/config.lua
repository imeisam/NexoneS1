Config = {}

Config.CuffItem = 'handcuffs1'
Config.CuffKeysItem = 'handcuffkey1'
Config.RopeItem = 'rope1'
Config.BagToHeadItem = 'headbag1'
Config.ElectronicCuffItem = 'anklet'
Config.ElectronicCuffTrackerItem = 'wheat'

Config.OpenMenuKey = 167  --f6
Config.InventoryOpenKey = 289 -- Disables this input when user is cuffed
Config.DisableWhenUserCuffed = {289, 37, 192, 204, 211, 349} -- Disables these input when user is cuffed

Config.HandcuffIMG = 'https://raw.githubusercontent.com/0resmon/db/main/img/black.png'
Config.HandcuffDefaultIMG = 'https://raw.githubusercontent.com/0resmon/db/main/img/prop_chrome_03.png'
Config.HandcuffSound = 'https://raw.githubusercontent.com/0resmon/db/main/sound/handcuff.mp3'

Config.RealtimeGPS = true -- WARNING: Enabling this option will enable realtime gps isntead of just marking gps location on tablet but it may cause a lot of cps/ram usage on both client and server side.
Config.RealtimeGPSRefreshMS = 5000 -- WARNING: This option directly affect cpu/ram usage, so be carefull when changing it! It controls how fast the gps will refresh itself

Config.TestMode = true

Config.GetClosestPlayer = function()
   return ESX.Game.GetClosestPlayer()
end

Config.Lang = {
["no_one_nearby"] = "Yakınlarda kimse yok",
["no_one_nearby_cuff"] = "Yakınlarda kelepçe takabilecek kimse yok.",
["no_one_nearby_cuff2"] = "O ellerini yukarı kaldırmalı.",
["menu_title"] = "Yardım Menüsü",
["put_bag"] = "Başındaki poşeti çıkar.",
["arac_bin"] = "Oyuncuyu araca koy",
["arac_in"] = "Oyuncuyu araçtan çıkar",
["bacak_coz"] = "Bacağındaki ipi çöz",
["bant_cikar"] = "Ağzındaki bandı tak/çıkar",
["tasi"] = "Oyuncuyu taşı",
["birak"] = "Oyuncuyu bırak",
["tape_type"] = "Bant tipini seç",
["bant"] = "Siyah bant",
["money"] = "Nakit",
}

Config.MenuElements = {
  
    { value = "arac_bin", label = Config.Lang["arac_bin"] },
    { value = "arac_in", label = Config.Lang["arac_in"] },
    { value = "bacak_coz", label = Config.Lang["bacak_coz"] },
    { value = "bant_cikar", label = Config.Lang["bant_cikar"] },
    { value = "tasi", label = Config.Lang["tasi"] },
    { value = "birak", label = Config.Lang["birak"] }
}

Config.zone={
    ["santos"]={
        name="Losantos",
        zone={
            vector2(4561.9931640625, -4065.748046875),
            vector2(4809.1127929688, 1836.2026367188),
            vector2(-789.36505126953, 1994.4796142578),
            vector2(-561.87634277344, 5052.9194335938),
            vector2(-5135.0673828125, 5052.8999023438),
            vector2(-5085.4067382812, -4407.8735351562),
        }
    },
    ["sandy"]={
        name="Losantos",
        zone={
            vector2(4854.4375, 5370.115234375),
            vector2(4809.1127929688, 1836.2026367188),
            vector2(-789.36505126953, 1994.4796142578),
            vector2(-561.87634277344, 5052.9194335938)
        }
    },
    ["paleto"]={
        name="Paleto",
        zone={
            vector2(4854.4375, 5370.115234375),
            vector2(-4252.578125, 5401.4052734375),
            vector2(-4297.3940429688, 8165.4018554688),
            vector2(5974.193359375, 8165.40234375),
        }
    }
}