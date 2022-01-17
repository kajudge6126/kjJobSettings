local PlayerData = {}

QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
	PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(vector3(-631.4851684570312, 223.6841278076172, 81.88150787353516))
    SetBlipSprite(blip, 590)
    SetBlipColour(blip, 53)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, 0.7)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Yemek Marketi")
    EndTextCommandSetBlipName(blip) 
end)


-- YEMEK MARKETI #1
Citizen.CreateThread(function()
	while true do
		local time = 5000
		if PlayerData.job and PlayerData.job.name ~= 'unemployed' and PlayerData.job.name == "erismesini-istedigin-perm" then
			time = 1000
			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
		
			local distance = #(coords - vector3(-631.4851684570312, 223.6841278076172, 81.88150787353516))
			if distance < 3 then
				time = 1
				local text = ""
				if distance < 2 then
					text = "[E] "
					if IsControlJustPressed(0, 38) then
						TriggerServerEvent("inventory:server:OpenInventory", "shop", "EatShop", Config.EatShop)
					end
				end
				QBCore.Functions.DrawText3D(-631.4851684570312, 223.6841278076172, 81.88150787353516, text.."Yemek Marketi")
			end
		end
		Citizen.Wait(time)
	end
end)

--- DEPO OLUSTUR #1
Citizen.CreateThread(function()
	while true do
		local time = 5000
		if PlayerData.job and PlayerData.job.name == 'erismesini-istedigin-perm' then 
			time = 1000
			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
		
			local distance = #(coords - vector3(-124.81829833984376, -638.7938842773438, 168.82064819335938))
			if distance < 3 then
				time = 1
				local text = ""
				if distance < 1.5 then
					text = "[E] "
					if IsControlJustPressed(0, 38) then 
						TriggerEvent("inventory:client:SetCurrentStash", "Market_", QBCore.Key)
						TriggerServerEvent("inventory:server:OpenInventory", "stash", "Market_", {
							maxweight = 4000000,
							slots = 504,
						})
					end
				end
				QBCore.Functions.DrawText3D(-124.81829833984376, -638.7938842773438, 168.82064819335938, text.."Market Depo")
			end
			
		end
		Citizen.Wait(time)
	end
end)