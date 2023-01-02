local QBCore = exports['qb-core']:GetCoreObject()
local IsPlayerAbleToVape = false

p_smoke_location = {
	20279,
}
p_smoke_particle = "exp_grd_bzgas_smoke"
p_smoke_particle_asset = "core" 

RegisterNetEvent("Vape:StartVaping")
AddEventHandler("Vape:StartVaping", function(source)
	local ped = PlayerPedId()
	if DoesEntityExist(ped) and not IsEntityDead(ped) then
		if IsPedOnFoot(ped) then
			if IsPlayerAbleToVape == false then
				PlayerIsAbleToVape()
			end
		else
			QBCore.Functions.Notify("You can not do this in a vehicle.", "error", 2000)
		end
	else
		QBCore.Functions.Notify("You can not do this if you are dead.", "error", 2000)
	end
end)

RegisterNetEvent("Vape:VapeAnimFix")
AddEventHandler("Vape:VapeAnimFix", function(source)
	local ped = PlayerPedId()
	local ad = "anim@heists@humane_labs@finale@keycards"
	local anim = "ped_a_enter_loop"
	while (not HasAnimDictLoaded(ad)) do
		RequestAnimDict(ad)
	  Wait(1)
	end
	TaskPlayAnim(ped, ad, anim, 8.00, -8.00, -1, (2 + 16 + 32), 0.00, 0, 0, 0)
end)

RegisterNetEvent("Vape:StopVaping")
AddEventHandler("Vape:StopVaping", function(source)
	if IsPlayerAbleToVape == true then
		PlayerIsUnableToVape()
		QBCore.Functions.Notify("You're stopped using your vape.", "error", 2000)
	end
end)

RegisterNetEvent("Vape:Drag")
AddEventHandler("Vape:Drag", function()
	if IsPlayerAbleToVape then
		local ped = PlayerPedId()
		local PedPos = GetEntityCoords(ped)
		local ad = "mp_player_inteat@burger"
		local anim = "mp_player_int_eat_burger"
		if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
			while (not HasAnimDictLoaded(ad)) do
				RequestAnimDict(ad)
			  Wait(1)
			end
			local VapeFailure = math.random(1,Config.FailureOdds)
			if VapeFailure == 1 then
				TaskPlayAnim(ped, ad, anim, 8.00, -8.00, -1, (2 + 16 + 32), 0.00, 0, 0, 0)
				PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
					Wait(250)
				AddExplosion(PedPos.x, PedPos.y, PedPos.z+1.00, 34, 0.00, true, false, 1.00)
				ApplyDamageToPed(ped, 200, false)
			else
				TaskPlayAnim(ped, ad, anim, 8.00, -8.00, -1, (2 + 16 + 32), 0.00, 0, 0, 0)
				PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
			  		Wait(950)
				TriggerServerEvent("eff_smokes", PedToNet(ped))
			  		Wait(Config.VapeHangTime-1000)
				TriggerEvent("Vape:VapeAnimFix", 0)
			end
		end
	else
		QBCore.Functions.Notify("You must be holding your vape to do this", "error", 2000)
	end
end)

RegisterNetEvent("c_eff_smokes")
AddEventHandler("c_eff_smokes", function(c_ped)
	for _,bones in pairs(p_smoke_location) do
		if DoesEntityExist(NetToPed(c_ped)) and not IsEntityDead(NetToPed(c_ped)) then
			createdSmoke = UseParticleFxAssetNextCall(p_smoke_particle_asset)
			createdPart = StartParticleFxLoopedOnEntityBone(p_smoke_particle, NetToPed(c_ped), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, GetPedBoneIndex(NetToPed(c_ped), bones), Config.SmokeSize, 0.0, 0.0, 0.0)
			Wait(Config.VapeHangTime)
			--Wait(250)
			while DoesParticleFxLoopedExist(createdSmoke) do
				StopParticleFxLooped(createdSmoke, 1)
			  Wait(0)
			end
			while DoesParticleFxLoopedExist(createdPart) do
				StopParticleFxLooped(createdPart, 1)
			  Wait(0)
			end
			while DoesParticleFxLoopedExist(p_smoke_particle) do
				StopParticleFxLooped(p_smoke_particle, 1)
			  Wait(0)
			end
			while DoesParticleFxLoopedExist(p_smoke_particle_asset) do
				StopParticleFxLooped(p_smoke_particle_asset, 1)
			  Wait(0)
			end
			Wait(Config.VapeHangTime*3)
			RemoveParticleFxFromEntity(NetToPed(c_ped))
			break
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped, true) then
			PlayerIsEnteringVehicle()
		end
		if IsPlayerAbleToVape then
			if IsControlPressed(0, Config.DragControl) then
			  Wait(Config.ButtonHoldTime)
				if IsControlPressed(0, Config.DragControl) then
					TriggerEvent("Vape:Drag", 0)
				end
			  Wait(Config.VapeCoolDownTime)
			end
			if IsControlPressed(0, Config.RestingAnim) then
			  Wait(Config.ButtonHoldTime)
				if IsControlPressed(0, Config.RestingAnim) then
					TriggerEvent("Vape:VapeAnimFix", 0)
				end
				Citizen.Wait(sleep)
			end
		end
	  Citizen.Wait(sleep)
	end
end)

function PlayerIsAbleToVape()
	IsPlayerAbleToVape = true
	local ped = PlayerPedId()
	local ad = "anim@heists@humane_labs@finale@keycards"
	local anim = "ped_a_enter_loop"

	while (not HasAnimDictLoaded(ad)) do
		RequestAnimDict(ad)
	  Wait(1)
	end
	
	TaskPlayAnim(ped, ad, anim, 8.00, -8.00, -1, (2 + 16 + 32), 0.00, 0, 0, 0)

	local x,y,z = table.unpack(GetEntityCoords(ped))
	local prop_name = "ba_prop_battle_vape_01"
	VapeMod = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(VapeMod, ped, GetPedBoneIndex(ped, 18905), 0.08, -0.00, 0.03, -150.0, 90.0, -10.0, true, true, false, true, 1, true)
end

function PlayerIsEnteringVehicle()
	IsPlayerAbleToVape = false
	local ped = PlayerPedId()
	local ad = "anim@heists@humane_labs@finale@keycards"
	DeleteObject(VapeMod)
	TaskPlayAnim(ped, ad, "exit", 8.00, -8.00, -1, (2 + 16 + 32), 0.00, 0, 0, 0)
end

function PlayerIsUnableToVape()
	IsPlayerAbleToVape = false
	local ped = PlayerPedId()
	DeleteObject(VapeMod)
	ClearPedSecondaryTask(ped)
end
