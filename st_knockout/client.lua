local KO = false
local wait = 15
local count = 60


Citizen.CreateThread(function()
	while true do
		Wait(1)
        local player = PlayerPedId()
        if IsPedInMeleeCombat(player) then
            if (HasPedBeenDamagedByWeapon(player, GetHashKey("WEAPON_UNARMED"), 0) )then
                if GetEntityHealth(player) < 145 then
                    SetPlayerInvincible(PlayerId(), false)
                    AddTextEntry('ALERT', 'You have been knocked out!')
                    BeginTextCommandDisplayHelp('ALERT')
                    EndTextCommandDisplayHelp(0, false, true, 5000)
					SetPedToRagdoll(player, 1000, 1000, 0, 0, 0, 0)
					ShakeGameplayCam('LARGE_EXPLOSION_SHAKE', 2.5)
                    wait = 15
					KO = true
					SetEntityHealth(player, 140)
				end
			end
		end
		
		if KO == true then
			SetPlayerInvincible(PlayerId(), false)
			DisablePlayerFiring(PlayerId(), true)
			SetPedToRagdoll(player, 1000, 1000, 0, 0, 0, 0)
			ResetPedRagdollTimer(player)
			ShakeGameplayCam("VIBRATE_SHAKE", 1.0)
			if wait >= 0 then
				count = count - 1
                if count == 0 then
                    
					count = 60
					wait = wait - 1
                    if GetEntityHealth(player) <= 50 then 
						SetEntityHealth(player, GetEntityHealth(player)+1)
						
					end
				end
            else		
				SetPlayerInvincible(PlayerId(), false)
				KO = false

			end
		end

	end
end)