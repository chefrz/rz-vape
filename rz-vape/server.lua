local QBCore = exports['qb-core']:GetCoreObject()
local use = false

QBCore.Functions.CreateUseableItem('vape', function(source) 
	if not use then
		TriggerClientEvent("Vape:StartVaping", source, 0)
		use = true
	else
		TriggerClientEvent("Vape:StopVaping", source, 0)
		use = false
	end
end) 

RegisterServerEvent("eff_smokes")
AddEventHandler("eff_smokes", function(entity)
	TriggerClientEvent("c_eff_smokes", -1, entity)
end)
