

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



local isDead = false



RequestSubMenuAzioni = function ()
    if ESX.PlayerData.job.name == "police" and  ESX.PlayerData.job.grade > 0 then
        return {"menu_azioni:mettinelveicolo", "menu_azioni:prendinelveicolo","menu_azioni:drag", "menu_azioni:ammanetta","menu_azioni:smanetta","menu_azioni:perquisci"}
    elseif  ESX.PlayerData.job.name == "ambulance" and  ESX.PlayerData.job.grade > 0  then
        return {"menu_medici:cura"}    
    elseif PlayerJob_2.name ~= "disoccupato"  then
        return {"menu_azioni:ammanetta","menu_azioni:smanetta"}
    else
        return {"menu_azioni:perquisci"}
    end
end

Config = {

    Menu = {

        {
            label = "Info Player",
            request  = function ()
                return not isDead 
            end,
            serverside = false,
            trigger = "fnx_menu:infoPlayer",
            submenu = function ()
                return false
            end
        },
        {
            label = "Documenti",
            request  = function ()
                return not isDead 
            end,
            serverside = false,
            trigger = "fnx_menu:open-documenti",
            submenu = function ()
                return false
            end
        },
        {
            label = "Smonta Armi",
            request  = function ()
                return not isDead 
            end,
            serverside = false,
            trigger = "fnx  ::  ApriMenuSmonta",
            submenu = function ()
                return false
            end
        },
        {
            label = "Menu Polizia",
            request  = function ()
                return not isDead and ESX.PlayerData.job.name == "police"
            end,
            serverside = false,
            trigger = "",
            submenu = function ()
                return {"menu:codici","menu:interazioni"}
            end
        },
        {
            label = "Azioni",
            request  = function ()
                return not isDead
            end,
            serverside = false,
            trigger = "",
            submenu = function ()
                return RequestSubMenuAzioni()
            end
        },
    },

    SubMenu  = {

        ["menu:codici"] ={
            label = "Codici",
            serverside = false,
            trigger = "",
        },
        ["menu:interazioni"] = {
            label = "Interazioni",
            serverside = false,
            trigger = "",
        },
        ["menu_azioni:mettinelveicolo"] = {  
            label = "Metti dal Veicolo",
            serverside = false,
            trigger = "fnx_menu:put_in",
        },
        ["menu_azioni:prendinelveicolo"] = {
            label = "Prendi dal Veicolo",
            serverside = false,
            trigger = "fnx_menu:put_out",
        },
        ["menu_azioni:drag"] = {
            label = "Trascina/Rilascia",
            serverside = false,
            trigger = "fnx_menu:drag_sdrag",
        },
        ["menu_azioni:ammanetta"] = {
            label = "Ammanetta",
            serverside = false,
            trigger = "fnx_menu:ammanetta",
        },
        ["menu_azioni:smanetta"] = {
            label = "Smanetta",
            serverside = false,
            trigger = "fnx_menu:smanetta",
        },
        ["menu_azioni:perquisci"] = {
            label =" Perquisisci",
            serverside = false ,
            trigger  = "fnx_menu:perquisisci"
        },
        ["menu_medici:cura"] = {
            label = "CuraPlayer",
            serverside = false,
            trigger = "fnx_menu",
        }
    },



    JobPermission = {
        ["police"]  = true
    }

}






