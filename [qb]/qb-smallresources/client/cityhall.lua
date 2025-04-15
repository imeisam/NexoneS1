local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    local model = CityHall.NpcModel
    RequestModel(GetHashKey(model))
    while not HasModelLoaded(GetHashKey(model)) do
        Wait(1)
    end
    local npc = CreatePed(4, GetHashKey(model), CityHall.Coord.x, CityHall.Coord.y, CityHall.Coord.z -1,  CityHall.Heading, false, true)
    SetEntityHeading(npc,  CityHall.Heading)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    exports['qb-target']:AddTargetEntity(npc, {
        options = {
            {
                event = 'qb-cityhall:client:openMenu',
                type = 'client',
                icon = "fa fa-globe",
                label = "City Hall",
            },
        },
        distance = 4.5,
    })
end)

CreateThread(function()
    local blip = AddBlipForCoord(326.90432739258, -1632.7281494141, 32.53653717041)
    SetBlipSprite(blip, 419)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 0)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('City Hall')
    EndTextCommandSetBlipName(blip)
end)

RegisterNetEvent('qb-cityhall:client:openMenu', function()
    local headerMenu = {}
    headerMenu[#headerMenu+1] = {
        header = 'City Hall',
        isMenuHeader = true
    }
    headerMenu[#headerMenu+1] = {
        header = 'ID Card',
        txt = "Price: "..CityHall.Prices.idcard.."$",
        params = {
            event = 'qb-cityhall:client:getIdCard',
            args = {}
        }
    }
    headerMenu[#headerMenu+1] = {
        header = 'Driving License',
        txt = "Price: "..CityHall.Prices.driver.."$",
        params = {
            event = 'qb-cityhall:client:DriveLicense',
            args = {}
        }
    }
    headerMenu[#headerMenu+1] = {
        header = 'Weapon License',
        txt = "Price: "..CityHall.Prices.weapon.."$",
        params = {
            event = 'qb-cityhall:client:WeaponLicense',
            args = {}
        }
    }
    headerMenu[#headerMenu+1] = {
        header = 'Hunting License',
        txt = "Price: "..CityHall.Prices.hunting.."$",
        params = {
            event = 'qb-cityhall:client:HuntingLicense',
            args = {}
        }
    }
    headerMenu[#headerMenu+1] = {
        header = 'Close Menu',
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }
    }
    exports['qb-menu']:openMenu(headerMenu)
end)

RegisterNetEvent('qb-cityhall:client:getIdCard', function()
    TriggerServerEvent('qb-cityhall:server:getIdCard')
end)

RegisterNetEvent('qb-cityhall:client:DriveLicense', function()
    TriggerServerEvent('qb-cityhall:server:DriveLicense')
end)

RegisterNetEvent('qb-cityhall:client:WeaponLicense', function()
    TriggerServerEvent('qb-cityhall:server:WeaponLicense')
end)

RegisterNetEvent('qb-cityhall:client:HuntingLicense', function()
    TriggerServerEvent('qb-cityhall:server:HuntingLicense')
end)