ESX = exports.es_extended:getSharedObject()



ESX.RegisterServerCallback("fnx-menu:put-in/put-out",function (src,cb,type,TableArgs)
    local xPlayer = ESX.GetPlayerFromId(src)
    local TPlayer = ESX.GetPlayerFromId(TableArgs.target_id)
    if Config.JobPermission[xPlayer.job.name] then
        if type == "put_in" then
            if TPlayer then
                TriggerClientEvent("fnx-menu:put_in",TableArgs.target_id)
                cb(true)
            else
                cb(false)
            end
        elseif type == "put_out" then
            if TPlayer then
                TriggerClientEvent("fnx-menu:put_out",TableArgs.target_id)
                cb(true)
            else
                cb(false)
            end
        end
    end
end)





ESX.RegisterServerCallback("fnx-menu:ammanetta/smanetta",function (src,cb,type,TableArgs)
    local xPlayer = ESX.GetPlayerFromId(src)
    local TPlayer = ESX.GetPlayerFromId(TableArgs.target_id)
    if Config.JobPermission[xPlayer.job.name] then
        if type == "smanetta" then
            if TPlayer then
                TriggerClientEvent("fnx-menu:smanetta-my",src)
                TriggerClientEvent("fnx-menu:smanetta-player",TableArgs.target_id,TableArgs)
                cb(true)
            else
                cb(false)
            end
        elseif type == "ammanetta" then
            if TPlayer then
                TriggerClientEvent("fnx-menu:arrest-my",src)
                TriggerClientEvent("fnx-menu:arrest-player",TableArgs.target_id,TableArgs)
                cb(true)
            else
                cb(false)
            end
        end
    end
end)



ESX.RegisterServerCallback('fnx-menu:lootta', function(src, cb, target)
    local x = ESX.GetPlayerFromId(target)
    if x ~= nil then
        x.showNotification("Ti stanno perquisendo...","inform")
        cb(x.identifier)
    end
end)


RegisterServerEvent("drag")
AddEventHandler("drag",function (target)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if Config.JobPermission[xPlayer.job.name] then
        TriggerClientEvent("fnx-menu:drag",target,src)
    end
end)
