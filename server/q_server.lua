print("^0======================================================================^7")
print("^0[^4Author^0] ^7:^0 ^0Atmos-DEV^7")
print("^0======================================================================^7")


ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_society:registerSociety', 'mechanic', 'mechanic', 'society_mechanic', 'society_mechanic', 'society_mechanic', {type = 'public'})

RegisterServerEvent('ouverture')
AddEventHandler('ouverture', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Benny\'s', '~p~Annonce', 'Le Benny\'s est désormais ~g~OUVERT~s~ | Custom & Réparation disponible !', 'CHAR_CARSITE3', 8)
	end
end)

RegisterServerEvent('fermeture')
AddEventHandler('fermeture', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Benny\'s', '~p~Annonce', 'Le Benny\'s est désormais ~r~FERMER~s~ | Passe plus tard !', 'CHAR_CARSITE3', 8)
	end
end)

RegisterServerEvent('pause')
AddEventHandler('pause', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Benny\'s', '~p~Annonce', 'Le Benny\'s est désormais en ~o~PAUSE~s~', 'CHAR_CARSITE3', 8)
	end
end)

RegisterServerEvent('possible')
AddEventHandler('possible', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Benny\'s', '~p~Annonce', 'Un mécanicien du Benny\'s ~g~est désormais disponible en déplacement~s~ , Contactez nous par téléphone !', 'CHAR_CARSITE3', 8)
	end
end)

RegisterServerEvent('impossible')
AddEventHandler('impossible', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Benny\'s', '~p~Annonce', 'Les mécanos du Benny\'s ~r~ne sont plus disponible en déplacement~s~ pour le moment !', 'CHAR_CARSITE3', 8)
	end
end)

RegisterNetEvent('carrosserie')
AddEventHandler('carrosserie', function()

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = 50
	local xMoney = xPlayer.getMoney()

	if xMoney >= price then

		xPlayer.removeMoney(price)
		xPlayer.addInventoryItem('carokit', 1)
		TriggerClientEvent('esx:showNotification', source, "~g~Achats~w~ effectué !")
	else
		TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
	end
end)




RegisterNetEvent('reparation')
AddEventHandler('reparation', function()

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = 75
	local xMoney = xPlayer.getMoney()

	if xMoney >= price then

		xPlayer.removeMoney(price)
		xPlayer.addInventoryItem('fixkit', 1)
		TriggerClientEvent('esx:showNotification', source, "~g~Fabrication~w~ effectué !")
	else
		TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
	end
end)

ESX.RegisterUsableItem('carokit', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('carokit', 1)

	TriggerClientEvent('esx_bennysjob:onCarokit', _source)
	sendNotiifcation("Carrosserie réparé")
end)

ESX.RegisterUsableItem('fixkit', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('fixkit', 1)

	TriggerClientEvent('esx_bennysjob:onFixkit', _source)
	sendNotiifcation("Véhicule réparé")
end)






