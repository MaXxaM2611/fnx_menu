
ESX = exports.es_extended:getSharedObject()



ESX.RegisterServerCallback('fnx-controlloitem', function(src, cb,itamname)
    local xPlayer = ESX.GetPlayerData(src)
    if xPlayer then
         local item = xPlayer.getInventoryItem(itamname) 
        if item ~= nil and item.count > 0 then
            cb(true)
        else
            cb(false)
        end
    end
end)