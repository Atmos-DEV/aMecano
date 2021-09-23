ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5000)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(5000)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RMenu.Add("atmos", "boss", RageUI.CreateMenu("Mécano","Actions patron"))
RMenu:Get("atmos", "boss").Closed = function()end

Citizen.CreateThread(function()
    while true do 
        RageUI.IsVisible(RMenu:Get('atmos','boss'),true,true,true,function()
            RageUI.Button("Accéder aux actions du patron",nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    actionboss()
                    RageUI.CloseAll()
                end
            end)
        end, function()end, 1)
        Citizen.Wait(0)
    end 
end)

local position = {
    {x = -199.92, y = -1341.27, z = 34.89}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        for k in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' and ESX.PlayerData.job.grade_name == 'boss' then
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
                
                
                
                
                
                

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            
            

        
            if dist <= 1.0 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au Actions Patron")
                if IsControlJustPressed(1,51) then
                    RageUI.Visible(RMenu:Get('atmos', 'boss'), not RageUI.Visible(RMenu:Get('atmos', 'boss')))
                end
            end
        
        end
    end
    end
end)

function actionboss()
    TriggerEvent('esx_society:openBossMenu', 'mechanic', function(data, menu)
        menu.close()
    end, {wash = false})
end