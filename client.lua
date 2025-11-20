CreateThread(function()
    local resourceName = GetCurrentResourceName()
    if resourceName ~= "ox_ammo_sync" then
        print("^1[ammo-sync] Fel resursnamn! Byt tillbaka till 'ox_ammo_sync'^0")
        while true do Wait(1000) end 
    end
end)

RegisterNetEvent('ammoSync:forceUpdate', function(weapon, ammo)
    local ped = PlayerPedId()
    if GetSelectedPedWeapon(ped) == weapon then
        SetPedAmmo(ped, weapon, ammo)
    end
end)

AddEventHandler('gameEventTriggered', function(event, data)
    if event == "CEventGunShot" then
        local ped = PlayerPedId()
        if data[1] == ped then
            local weapon = GetSelectedPedWeapon(ped)
            local ammo = GetAmmoInPedWeapon(ped, weapon)

            TriggerServerEvent('ammoSync:updateAmmo', weapon, ammo)
        end
    end
end)

