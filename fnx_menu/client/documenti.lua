

ESX = exports.es_extended:getSharedObject()


RegisterNetEvent("fnx_menu:open-documenti")
AddEventHandler("fnx_menu:open-documenti", function ()
   ESX.TriggerServerCallback('fnx-controlloitem', function(result)
        if result then
            local player , distance = ESX.Game.GetClosestPlayer()    
            if player ~= -1 and distance < 3 then
                TriggerServerEvent("jsfour-idcard:open",GetPlayerServerId(PlayerPedId()),GetPlayerServerId(player))
            else
                TriggerServerEvent("jsfour-idcard:open",GetPlayerServerId(PlayerPedId()),GetPlayerServerId(PlayerPedId()))
            end
        end
   end, "documenti") 
end)



