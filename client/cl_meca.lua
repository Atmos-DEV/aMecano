ESX = nil

local function sendNotiifcation(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(true, false)
  
end

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

local blips = {
    
     {title="Garage Benny", colour=5, id=446, x = -205.79, y = -1307.08, z = 31.27},
  }
  
  Citizen.CreateThread(function()    
    Citizen.Wait(0)    
  local bool = true     
  if bool then    
         for _, info in pairs(blips) do      
             info.blip = AddBlipForCoord(info.x, info.y, info.z)
                         SetBlipSprite(info.blip, info.id)
                         SetBlipDisplay(info.blip, 2)
                         SetBlipScale(info.blip, 0.5)
                         SetBlipColour(info.blip, info.colour)
                         SetBlipAsShortRange(info.blip, true)
                         BeginTextCommandSetBlipName("STRING")
                         AddTextComponentString(info.title)
                         EndTextCommandSetBlipName(info.blip)
         end        
     bool = false     
   end
  end)

RMenu.Add("atmos", "fabrication", RageUI.CreateMenu("Fabrication","Action fabrication :"))
RMenu:Get("atmos", "fabrication").Closed = function()end

Citizen.CreateThread(function()
    while true do 
        RageUI.IsVisible(RMenu:Get('atmos','fabrication'),true,true,true,function()
            RageUI.Button("Kit : ~r~Carrosserie",nil, {RightLabel = "~r~50$"}, true, function(Hovered, Active, Selected)
                if Selected then
                    cfabrication()
                    RageUI.CloseAll()
                end
            end)
            RageUI.Button("Kit : ~r~Réparations",nil, {RightLabel = "~r~75$"}, true, function(Hovered, Active, Selected)
                if Selected then
                    rfabrication()
                    RageUI.CloseAll()
                end
            end)
            
        end, function()end, 1)
        Citizen.Wait(0)
    end 
end)

local position = {
    {x = -242.07191467285, y = -1338.3278808594, z = 30.902784347534}      
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        
        for k in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
                
                
                
                
                
                
                

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            
            

        
            if dist <= 1.0 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au menu de fabrication")
                if IsControlJustPressed(1,51) then
                    RageUI.Visible(RMenu:Get('atmos', 'fabrication'), not RageUI.Visible(RMenu:Get('atmos', 'fabrication')))
                end
            end
        
        end
    end
    end
end)

function cfabrication()
    local playerPed = PlayerPedId()
    exports['progressBars']:startUI(15000, "Fabrication du kit en cours ...")
    TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
    Citizen.Wait(15000)
    TriggerServerEvent('carrosserie')
    ClearPedTasksImmediately(playerPed)
    
    
end


function rfabrication()
    local playerPed = PlayerPedId()
    exports['progressBars']:startUI(20000, "Fabrication du kit en cours ...")
    TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
    Citizen.Wait(20000)
    TriggerServerEvent('reparation')
    ClearPedTasksImmediately(playerPed)
    
    
end

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(500)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(500)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RMenu.Add('atmos', 'vestiaire', RageUI.CreateMenu("Vestaire", "Mécano"))

Citizen.CreateThread(function()
    while true do

        RageUI.IsVisible(RMenu:Get('atmos', 'vestiaire'), true, true, true, function()

            RageUI.Button("Prendre la tenu ~b~Civile",nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, function(Hovered, Active, Selected)
                if Selected then
                    vcivil()
                    RageUI.CloseAll()
                end
            end)

            RageUI.Button("Prendre la tenue de ~y~Travaille",nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, function(Hovered, Active, Selected)
                if Selected then
                    vmechanic()
                    RageUI.CloseAll()
                end
            end)

            RageUI.Button("Faire spawn une dépanneuse",nil, {RightBadge = RageUI.BadgeStyle.Car}, true, function(Hovered, Active, Selected)
                if Selected then
                    RageUI.CloseAll()
                    local model = GetHashKey("towtruck")
                    RequestModel(model)
                    while not HasModelLoaded(model) do Citizen.Wait(10) end
                    local vehicle = CreateVehicle(model, -181.4529876709, -1322.1691894531, 31.285270690918, 2.83, true, false)
                    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                end
            end)


        end, function()
        end, 1)
                        Citizen.Wait(0)
                                end
                            end)




local position = {
    {x = -224.09, y = -1320.69, z = 30.89}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(position) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then 
             
            
            

            

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
        
            if dist <= 1.0 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au vestiaire")
                if IsControlJustPressed(1,51) then
                    RageUI.Visible(RMenu:Get('atmos', 'vestiaire'), not RageUI.Visible(RMenu:Get('atmos', 'vestiaire')))
                end
            end
        end
    end
    end
end)

function vmechanic()
                local model = GetEntityModel(GetPlayerPed(-1))
                TriggerEvent('skinchanger:getSkin', function(skin)
                    if model == GetHashKey("mp_m_freemode_01") then
                        clothesSkin = {
                            ['bags_1'] = 0, ['bags_2'] = 0,
                            ['tshirt_1'] = 15, ['tshirt_2'] = 2,
                            ['torso_1'] = 65, ['torso_2'] = 2,
                            ['arms'] = 31,
                            ['pants_1'] = 38, ['pants_2'] = 2,
                            ['shoes_1'] = 12, ['shoes_2'] = 6,
                            ['mask_1'] = 0, ['mask_2'] = 0,
                            ['bproof_1'] = 0,
                            ['chain_1'] = 0,
                            ['helmet_1'] = -1, ['helmet_2'] = 0,
                        }
                    else
                        clothesSkin = {
                            ['bags_1'] = 0, ['bags_2'] = 0,
                            ['tshirt_1'] = 15,['tshirt_2'] = 2,
                            ['torso_1'] = 65, ['torso_2'] = 2,
                            ['arms'] = 36, ['arms_2'] = 0,
                            ['pants_1'] = 38, ['pants_2'] = 2,
                            ['shoes_1'] = 12, ['shoes_2'] = 6,
                            ['mask_1'] = 0, ['mask_2'] = 0,
                            ['bproof_1'] = 0,
                            ['chain_1'] = 0,
                            ['helmet_1'] = -1, ['helmet_2'] = 0,
                        }
                    end
                    TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                end)
            end

function vcivil()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        TriggerEvent('skinchanger:loadSkin', skin)
       end)
    end





