ESX = exports.es_extended:getSharedObject()


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)



RegisterNetEvent("fnx_menu:put_in")
AddEventHandler("fnx_menu:put_in",function (type)
    local Player, PlayerDistance = ESX.Game.GetClosestPlayer()
    local PlayerPedId   = PlayerPedId()
    local Target_id     = GetPlayerServerId(Player)
    if Player ~= -1 and PlayerDistance <= 3.0 then
        local coords        = GetEntityCoords(PlayerPedId)
        local vehicle       = GetClosestVehicle(coords, 5.0, 0, 71)
        if vehicle then
            ESX.TriggerServerCallback("fnx-menu:put-in/put-out",function (result)
            end,"put_in",{
                target_id = Target_id
            })
        end
    else
        ESX.ShowNotification("Nessun Player Vicino")
    end
end)


RegisterNetEvent("fnx_menu:put_out")
AddEventHandler("fnx_menu:put_out",function (type)
    local Player, PlayerDistance = ESX.Game.GetClosestPlayer()
    local PlayerPedId   = PlayerPedId()
    local Target_id     = GetPlayerServerId(Player)
    if Player ~= -1 and PlayerDistance <= 3.0 then
        local coords        = GetEntityCoords(PlayerPedId)
        local vehicle       = GetClosestVehicle(coords, 5.0, 0, 71)
        if vehicle then
            ESX.TriggerServerCallback("fnx-menu:put-in/put-out",function (result)
            end,"put_out",{
                target_id = Target_id
            })
        end
    else
        ESX.ShowNotification("Nessun Player Vicino")
    end
end)




RegisterNetEvent("fnx_menu:ammanetta")
AddEventHandler("fnx_menu:ammanetta",function (type)
    local Player, PlayerDistance = ESX.Game.GetClosestPlayer()
    local PlayerPedId = PlayerPedId()
    if Player ~= -1 and PlayerDistance <= 3.0 then
        local Myheading         = GetEntityHeading(PlayerPedId)
        local Myheadinglocation = GetEntityForwardVector(PlayerPedId)
        local MyheadingCoords   = GetEntityCoords(PlayerPedId)
        local Target_id         = GetPlayerServerId(Player)
        ESX.TriggerServerCallback("fnx-menu:ammanetta/smanetta",function (result)
        end,"ammanetta",{
            myheading = Myheading,
            myheadinglocation = Myheadinglocation,
            myheadingcoords = MyheadingCoords,
            target_id = Target_id
        })
    else
        ESX.ShowNotification("Nessun Player Vicino")
    end
end)



RegisterNetEvent("fnx_menu:smanetta")
AddEventHandler("fnx_menu:smanetta",function (type)
    local Player, PlayerDistance = ESX.Game.GetClosestPlayer()
    local PlayerPedId = PlayerPedId()
    if Player ~= -1 and PlayerDistance <= 3.0 then
        local Myheading         = GetEntityHeading(PlayerPedId)
        local Myheadinglocation = GetEntityForwardVector(PlayerPedId)
        local MyheadingCoords   = GetEntityCoords(PlayerPedId)
        local Target_id         = GetPlayerServerId(Player)
        ESX.TriggerServerCallback("fnx-menu:ammanetta/smanetta",function (result)
        end,"smanetta",{
            myheading = Myheading,
            myheadinglocation = Myheadinglocation,
            myheadingcoords = MyheadingCoords,
            target_id = Target_id
        })
    else
        ESX.ShowNotification("Nessun Player Vicino")
    end
end)



RegisterNetEvent("fnx_menu:drag_sdrag")
AddEventHandler("fnx_menu:drag_sdrag",function (type)
    local Player, PlayerDistance = ESX.Game.GetClosestPlayer()
    if Player ~= -1 and PlayerDistance <= 3.0 then
        TriggerServerEvent("drag",GetPlayerServerId(Player))
    else
        ESX.ShowNotification("Nessun Player Vicino")
    end
end)


local isOpened = false
local animazioni = false

Open = function ()
	Citizen.CreateThread(function()
		while isOpened do
			Citizen.Wait(7)
			if IsControlJustReleased(0, 177) and isOpened or IsControlJustReleased(0, 289) and isOpened then
				local ped = PlayerPedId()
				ClearPedTasks(ped)
				animazioni = false
				isOpened = false
				return
			end
		end
	end)
end



local function StartSearchAnimation()
	ESX.Streaming.RequestAnimDict('amb@medic@standing@kneel@base')
	ESX.Streaming.RequestAnimDict('anim@gangops@facility@servers@bodysearch@')

	Citizen.CreateThread(function()
		 isOpened = true
		local ped = PlayerPedId()
		Open()
		while isOpened do
			if isOpened  then
				if not animazioni then
					animazioni = true
					TaskPlayAnim(ped, "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
					TaskPlayAnim(ped, "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
				end
			else
				ClearPedTasks(ped)
				animazioni = false
				isOpened = false
				return
			end
			Citizen.Wait(0)
		end

	end)    
end

RegisterNetEvent("fnx_menu:perquisisci")
AddEventHandler("fnx_menu:perquisisci",function ()
	local c_player, distance = ESX.Game.GetClosestPlayer()
	if c_player ~= -1 and distance <= 1  then
        if IsPedArmed(PlayerPedId(), 4) then
            StartSearchAnimation()
            ESX.TriggerServerCallback('fnx-menu:lootta', function(Licenza)
                exports["mf-inventory"]:openOtherInventory(Licenza)
            end, GetPlayerServerId(c_player))
        else
            ESX.ShowNotification("Devi Essere Armato per perquisire")
        end
	else
		ESX.ShowNotification("Non sei vicino a nessun cittadino")
	end
end)






local Drag = {}
Drag.isDragged = false
local Ammanettato = false



StartBlock = function()
    Citizen.CreateThread(function()
        while Ammanettato do
            Citizen.Wait(0)
                local playerPed = PlayerPedId()
                DisableControlAction(0,21,true)
                DisableControlAction(0, 24, true) 
                DisableControlAction(0, 257, true) 
                DisableControlAction(0, 25, true) 
                DisableControlAction(0, 263, true) 
                DisableControlAction(0, 45, true) 
                DisableControlAction(0, 22, true) 
                DisableControlAction(0, 44, true) 
                DisableControlAction(0, 37, true) 
                DisableControlAction(0, 23, true) 
                DisableControlAction(0, 288,true) 
                DisableControlAction(0, 289, true) 
                DisableControlAction(0, 170, true) 
                DisableControlAction(0, 167, true) 
                DisableControlAction(0, 0, true) 
                DisableControlAction(0, 26, true) 
                DisableControlAction(0, 73, true) 
                DisableControlAction(2, 199, true) 
                DisableControlAction(0, 59, true)
                DisableControlAction(0, 71, true) 
                DisableControlAction(0, 72, true) 
                DisableControlAction(2, 36, true) 
                DisableControlAction(0, 47, true) 
                DisableControlAction(0, 264, true)
                DisableControlAction(0, 257, true) 
                DisableControlAction(0, 140, true)
                DisableControlAction(0, 141, true) 
                DisableControlAction(0, 142, true) 
                DisableControlAction(0, 143, true)
                DisableControlAction(0, 75, true) 
                DisableControlAction(27, 75, true) 
            if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
                ESX.Streaming.RequestAnimDict('mp_arresting', function()
                    TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
                end)
            end
        end
    end)
    if not Ammanettato then
        return
    end
end




RegisterNetEvent('fnx-menu:put_in')
AddEventHandler('fnx-menu:put_in', function()
	if Ammanettato then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		if IsAnyVehicleNearPoint(coords, 5.0) then
			local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)
			if DoesEntityExist(vehicle) then
                local destra,sinistra = #vector3(GetOffsetFromEntityInWorldCoords(vehicle,1.0,0.0,0.0) - coords) ,#vector3(GetOffsetFromEntityInWorldCoords(vehicle,-1.0,0.0,0.0) - coords)
                if destra < sinistra then  -- a
                    if IsVehicleSeatFree(vehicle, 2) then
                        SetVehicleDoorOpen(vehicle, 3, false, false)
                        SetPedIntoVehicle(playerPed, vehicle, 2)
                        Drag.isDragged = false
                        Wait(3000)
                        SetVehicleDoorShut(vehicle, 3, false)
                    end
                else
                    if IsVehicleSeatFree(vehicle, 1) then
                        SetVehicleDoorOpen(vehicle,2, false, true)
                        SetPedIntoVehicle(playerPed, vehicle, 1)
                        Drag.isDragged = false
                        Wait(3000)
                        SetVehicleDoorShut(vehicle,2, false)
                    end
                end
			end
		end
	end
end)

RegisterNetEvent('fnx-menu:put_out')
AddEventHandler('fnx-menu:put_out', function()
	local playerPed = PlayerPedId()
	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		TaskLeaveVehicle(playerPed, vehicle, 64)
	end
end)


RegisterNetEvent("fnx-menu:arrest-my")
AddEventHandler("fnx-menu:arrest-my", function()
    local PlayerPedId = PlayerPedId()
    SetCurrentPedWeapon(PlayerPedId, `WEAPON_UNARMED`, true)
	Citizen.Wait(250)
    ESX.Streaming.RequestAnimDict('mp_arrest_paired', function()
        TaskPlayAnim(PlayerPedId, 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)    
    end)
	Citizen.Wait(3000)
    ClearPedTasks(PlayerPedId)
end) 


RegisterNetEvent("fnx-menu:arrest-player")
AddEventHandler("fnx-menu:arrest-player", function(Table) 
    local PlayerPedId = PlayerPedId()
	SetCurrentPedWeapon(PlayerPedId, `WEAPON_UNARMED`, true)
	local x, y, z   = table.unpack(Table.myheadinglocation + Table.myheadingcoords * 1.0)
	SetEntityCoords(PlayerPedId, x, y, z)
	SetEntityHeading(PlayerPedId, Table.myheading)
	Citizen.Wait(250)
    ESX.Streaming.RequestAnimDict('mp_arrest_paired', function()
        TaskPlayAnim(PlayerPedId, 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
    end)
	Citizen.Wait(3760)
    Ammanettato = true
    StartBlock()
    ESX.Streaming.RequestAnimDict('mp_arresting', function()
        TaskPlayAnim(PlayerPedId, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
    end)
end)


RegisterNetEvent("fnx-menu:smanetta-player") 
AddEventHandler("fnx-menu:smanetta-player", function(Table)
    local PlayerPedId = PlayerPedId()
	local x, y, z = table.unpack(Table.myheadinglocation + Table.myheadingcoords * 1.0)
	z = z - 1.0
	SetEntityCoords(PlayerPedId, x, y, z)
	SetEntityHeading(PlayerPedId, Table.myheading)
	Citizen.Wait(250)
    ESX.Streaming.RequestAnimDict('mp_arresting', function()
        TaskPlayAnim(PlayerPedId, 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)    
    end)
	Citizen.Wait(3500)
    Ammanettato = false
    Citizen.Wait(250)
	ClearPedTasks(PlayerPedId)
end)


RegisterNetEvent("fnx-menu:smanetta-my") 
AddEventHandler("fnx-menu:smanetta-my", function()

    local PlayerPedId = PlayerPedId()
	Citizen.Wait(250)
    ESX.Streaming.RequestAnimDict('mp_arresting', function()
        TaskPlayAnim(PlayerPedId, 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
    end)
	Citizen.Wait(3500)
	ClearPedTasks(PlayerPedId)
end)




RegisterNetEvent('fnx-menu:drag')
AddEventHandler('fnx-menu:drag', function(Id_p)
	if Ammanettato then
		Drag.isDragged = not Drag.isDragged
		Drag.Id_p = Id_p
	end
    StartDrag()
end)



StartDrag = function ()
    local wasDragged
    while Drag.isDragged do
        Citizen.Wait(0)
		local playerPed = PlayerPedId()
		if Ammanettato and Drag.isDragged then
			local targetPed = GetPlayerPed(GetPlayerFromServerId(Drag.Id_p))
			if DoesEntityExist(targetPed) and IsPedOnFoot(targetPed) and not IsPedDeadOrDying(targetPed, true) then
				if not wasDragged then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
					wasDragged = true
				else
					Citizen.Wait(1000)
				end
			else
				wasDragged = false
				Drag.isDragged = false
				DetachEntity(playerPed, true, false)
			end
		elseif wasDragged then
			wasDragged = false
			DetachEntity(playerPed, true, false)
		end
    end
    DetachEntity(PlayerPedId(), true, false)
    return
end
