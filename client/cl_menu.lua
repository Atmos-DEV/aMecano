ESX = nil

local function sendNotiifcation(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(true, false)
  
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5000)
	end
end)


RMenu.Add("atmos", "principal", RageUI.CreateMenu("Mécano","Menu Intéraction :"))
RMenu:Get("atmos", "principal").Closed = function()end

RMenu.Add("atmos", "annonce", RageUI.CreateSubMenu(RMenu:Get("atmos", "principal"), "Annonces", "Menu des annonces :"))
RMenu:Get("atmos", "annonce").Closed = function()end

RMenu.Add("atmos", "facture", RageUI.CreateSubMenu(RMenu:Get("atmos", "principal"), "Factures et prix", "Menu des factures ainsi que des prix :"))
RMenu:Get("atmos", "facture").Closed = function()end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0) 
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then 
            if IsControlJustPressed(0, 167) then
                RageUI.Visible(RMenu:Get('atmos', 'principal'), not RageUI.Visible(RMenu:Get('atmos', 'principal')))
            end  
        end
    end 
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        RageUI.IsVisible(RMenu:Get("atmos","principal"),true,true,true,function()

            RageUI.Separator("↓ ~h~~b~Divers~b~~w~ ↓")

            RageUI.Button("[📢] Annonces",nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
			end, RMenu:Get('atmos', 'annonce'))

            RageUI.Button("[📑] Facture et prix",nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
			end, RMenu:Get('atmos', 'facture'))

            RageUI.Separator("↓ ~h~~b~Véhicule~b~~w~ ↓")

            RageUI.Button("[🧼] Néttoyer véhicule",nil, {RightBadge = RageUI.BadgeStyle.Car}, true, function(Hovered, Active, Selected)
                if Selected then
                    local playerPed = PlayerPedId()
                    local vehicle   = ESX.Game.GetVehicleInDirection()
                    local coords    = GetEntityCoords(playerPed)
        
                    if IsPedSittingInAnyVehicle(playerPed) then
                        ESX.ShowNotification(_U('inside_vehicle'))
                        return
                    end
        
                    if DoesEntityExist(vehicle) then
                        isBusy = true
                        RageUI.CloseAll()
                        exports['progressBars']:startUI(10000, "Néttoyage en cours ...")
                        TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
                        Citizen.CreateThread(function()
                            Citizen.Wait(10000)
        
                            SetVehicleDirtLevel(vehicle, 0)
                            ClearPedTasksImmediately(playerPed)
        
                            sendNotiifcation("Le véhicule est propre")
                            isBusy = false
                        end)
                    else
                        sendNotiifcation("Aucun véhicule")
                    end
    
                end
                
			end)

            RageUI.Button("[🔧] Réparer véhicule",nil, {RightBadge = RageUI.BadgeStyle.Car}, true, function(Hovered, Active, Selected)
                if Selected then
                    local playerPed = PlayerPedId()
                    local vehicle   = ESX.Game.GetVehicleInDirection()
                    local coords    = GetEntityCoords(playerPed)
        
                    if IsPedSittingInAnyVehicle(playerPed) then
                        sendNotiifcation("Sortir du véhicule")
                        return
                    end
        
                    if DoesEntityExist(vehicle) then
                        isBusy = true
                        RageUI.CloseAll()
                        exports['progressBars']:startUI(20000, "Réparation en cours ...")
                        TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                        Citizen.CreateThread(function()
                            Citizen.Wait(20000)
        
                            SetVehicleFixed(vehicle)
                            SetVehicleDeformationFixed(vehicle)
                            SetVehicleUndriveable(vehicle, false)
                            SetVehicleEngineOn(vehicle, true, true)
                            ClearPedTasksImmediately(playerPed)
        
                            sendNotiifcation('Le véhicule est réparé')
                            isBusy = false
                        end)
                    else
                        sendNotiifcation("Aucun véhicule")
                    end
                end
            end)

            RageUI.Button("[🔑] Crocheter le véhicule", nil, {RightBadge = RageUI.BadgeStyle.Car}, true, function(Hovered, Active, Selected)
                if Selected then
                    local playerPed = PlayerPedId()
                    local vehicle = ESX.Game.GetVehicleInDirection()
                    local coords = GetEntityCoords(playerPed)
        
                    if IsPedSittingInAnyVehicle(playerPed) then
                        sendNotiifcation("Sortir du véhicule")
                        return
                    end
        
                    if DoesEntityExist(vehicle) then
                        isBusy = true
                        RageUI.CloseAll()
                        exports['progressBars']:startUI(10000, "Crochetage en cours ...")
                        TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
                        Citizen.CreateThread(function()
                            Citizen.Wait(10000)
        
                            SetVehicleDoorsLocked(vehicle, 1)
                            SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                            ClearPedTasksImmediately(playerPed)
        
                            sendNotiifcation("Le véhicule est ouvert")
                            isBusy = false
                        end)
                    else
                        sendNotiifcation("Aucun véhicule")
                    end
                end
            end)

            RageUI.Button("[🚔] Mettre en fourrière", nil, {RightLabel = ">>>"},true, function(Hovered, Active, Selected)
                if Selected then
                    four() 
                end 
            end)

    

			



        end, function()end, 1)

        RageUI.IsVisible(RMenu:Get("atmos","annonce"),true,true,true,function()
            RageUI.Separator("↓ ~h~~b~Status~b~~w~ ↓")
            
            RageUI.Button("[✅] Ouverture",nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then 
                    TriggerServerEvent('ouverture')
                end
			end)

            RageUI.Button("[⚠️] Pause",nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('pause')
                end
			end)

            RageUI.Button("[❌] Fermeture",nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("fermeture")
                end
			end)
            
            RageUI.Separator("↓ ~h~~b~Déplacements~b~~w~ ↓")

            RageUI.Button("[✅] Déplacements possible",nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("possible")
                end
			end)

            RageUI.Button("[❌] Déplacements impossibles",nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("impossible")
                end
			end)

        end, function()end, 1)

        RageUI.IsVisible(RMenu:Get("atmos","facture"),true,true,true,function()
            RageUI.Separator("↓ ~h~~b~Facture~b~~w~ ↓")

            RageUI.Button("Donner une facture",nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    OpenBillingMenu()
                end
			end)

            RageUI.Separator("↓ ~h~~b~Prix~b~~w~ ↓")

            RageUI.Button("Prix : ~r~Réparations",nil, {RightLabel = "~g~750$"}, true, function(Hovered, Active, Selected)
               
			end)

            RageUI.Button("Prix : ~r~Néttoyage",nil, {RightLabel = "~g~500$"}, true, function(Hovered, Active, Selected)
               
			end)

            RageUI.Separator("↓ ~h~~b~Customisation~b~~w~ ↓")

            RageUI.Button("Prix : ~g~Taxe de customisation esthetique",nil, {RightLabel = "~r~15%"}, true, function(Hovered, Active, Selected)
               
			end)

            RageUI.Button("Prix : ~g~Taxe de customisation performance",nil, {RightLabel = "~r~20%"}, true, function(Hovered, Active, Selected)
               
			end)
        end, function()end, 1)

    end



Citizen.Wait(0)
end)


function OpenBillingMenu()
    ESX.UI.Menu.Open(
      'dialog', GetCurrentResourceName(), 'billing',
      {
        title = "Gestion Facture"
      },

      function(data, menu)

        local amount = tonumber(data.value)
        local player, distance = ESX.Game.GetClosestPlayer()
        local playerPed = PlayerPedId()

  
        if player ~= -1 and distance <= 3.0 then

  

          menu.close()



          if amount == nil then
              ESX.ShowNotification("~r~Problèmes~s~: Montant invalide")
          else
              TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
              Citizen.Wait(10000)
              TriggerServerEvent('esx_billing:sendBill1', GetPlayerServerId(player), 'society_mechanic', ('mechanic'), amount)
              Citizen.Wait(1000)
              ESX.ShowNotification("~r~Vous avez bien envoyer la facture")
              ClearPedTasksImmediately(playerPed)
          end

        else
          ESX.ShowNotification("~r~Problèmes~s~: Aucun joueur à proximitée")
        end

  

      end,
      function(data, menu)
          menu.close()
      end
    )
end

function four()
    local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
    local playerPed = PlayerPedId()
    if dist4 < 5 then
        TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
        Citizen.Wait(7500)
        DeleteEntity(veh)
        ClearPedTasksImmediately(playerPed)
        sendNotiifcation("Véhicule en fourrière ")
    end
end

RegisterNetEvent('esx_bennysjob:onCarokit')
AddEventHandler('esx_bennysjob:onCarokit', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_HAMMERING', 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(10000)
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				ClearPedTasksImmediately(playerPed)
				sendNotiifcation("Carrosserie réparé")
			end)
		end
	end
end)

RegisterNetEvent('esx_bennysjob:onFixkit')
AddEventHandler('esx_bennysjob:onFixkit', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(20000)
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				SetVehicleUndriveable(vehicle, false)
				ClearPedTasksImmediately(playerPed)
				sendNotiifcation("Véhicule réparé")
			end)
		end
	end
end)


