ESX = exports.es_extended:getSharedObject()
local PlayerJob_2 = exports["mxm_doublejob"]:getJob()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent("mxm_doublejob:updateJob")
AddEventHandler("mxm_doublejob:updateJob",function (job)
    PlayerJob_2 = job
end)


RegisterKeyMapping('open_menu', 'Opne Menu Principale', 'keyboard', 'u')

RegisterCommand("open_menu",function ()
    OpenMenu()
end)


OpenMenu = function ()
    local Menu_ = {}
    for a, b in pairs(Config.Menu) do
        if b:request() then
            table.insert(Menu_,{
                label = b.label,
                submenu = (b:submenu() or false),
                trigger = b.trigger,
                server = b.server
            })
        end
    end
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), '--menu', {
        title = 'Menu Principale',
        align = 'top-left',
        elements = Menu_
    }, function(data, menu)
        if data.current.submenu then
            local SubMenu_ = {}
            for c, d in pairs(data.current.submenu) do
                if Config.SubMenu[d] then
                    table.insert(SubMenu_,{
                        label = Config.SubMenu[d].label,
                        trigger = Config.SubMenu[d].trigger,
                        server = Config.SubMenu[d].server
                    })
                end
            end
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), '--submenu', {
                title = 'Sub Menu',
                align = 'top-left',
                elements = SubMenu_
            }, function(sub_data, sub_menu)
                if  sub_data.current.server then
                    TriggerServerEvent(sub_data.current.trigger)
                else
                    TriggerEvent(sub_data.current.trigger)
                end
            end, function(sub_data, sub_menu)
                sub_menu.close()
            end)
        else
            if data.current.server then
                TriggerServerEvent(data.current.trigger)
            else
                TriggerEvent(data.current.trigger)
            end
            menu.close()
        end
    end, function(data, menu)
          menu.close()
    end)
end



RegisterNetEvent("fnx_menu:infoPlayer")
AddEventHandler("fnx_menu:infoPlayer",function ()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), '--info_personali', {
        title = 'Informazioni Personali',
        align = 'top-left',
        elements = {
            {label = "ID: "..GetPlayerServerId(NetworkGetEntityOwner(PlayerPedId()))},
            {label = "Job: "..ESX.PlayerData.job.label},
            {label = "Grado: "..ESX.PlayerData.job.grade_label},
            {label = "Fazione: "..PlayerJob_2.name},
            {label = "Contanti: "..ESX.PlayerData.money},
        }
    }, function(data, menu)
        menu.close()
    end, function(data, menu)
        menu.close()
    end)
end)


