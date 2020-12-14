local display = false
local hp

RegisterNetEvent("nic_injury:on")
AddEventHandler(
    "nic_injury:on",
    function()
        SendNUIMessage(
            {
                type = "ui",
                display = true
            }
        )
    end
)

RegisterNetEvent("nic_injury:off")
AddEventHandler(
    "nic_injury:off",
    function()
        SendNUIMessage(
            {
                type = "ui",
                display = false
            }
        )
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            Citizen.InvokeNative(0xF5F6378C4F3419D3, PlayerPedId(), 100)
            local dead = Citizen.InvokeNative(0x3317DEDB88C95038, PlayerPedId(), true)
            local hp = Citizen.InvokeNative(0x82368787EA73C0F7, PlayerPedId())
            if dead then
                TriggerEvent("nic_injury:off")
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            hp = Citizen.InvokeNative(0x82368787EA73C0F7, PlayerPedId())
            local dead = Citizen.InvokeNative(0x3317DEDB88C95038, PlayerPedId(), true)
            local health
            local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
            if (hp == false or hp >= 41) then
                TriggerEvent("nic_injury:off")
            elseif (hp == false or hp <= 40) then
                TriggerEvent("nic_injury:on")
                Citizen.Wait(2000)
                Citizen.InvokeNative(0xF0A4F1BBF4FA7497, PlayerPedId(), 1, 0, 0)
                Citizen.Wait(30000)
            end
            if ragdoll then
                Blackout(x, y, z, hp)
            end
        end
    end
)




---Not part of script
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local Ped = PlayerId()
        local PlayerPed = PlayerPedId()
        Citizen.InvokeNative(0x4CC5F2FC1332577F, 1058184710)
        Citizen.InvokeNative(0x4CC5F2FC1332577F, -66088566)
        if IsPlayerFreeAiming(Ped) and IsPedWeaponReadyToShoot(PlayerPed) then
            --Citizen.InvokeNative(0x90DA5BA5C2635416)
            --firstperson = Citizen.InvokeNative(0x90DA5BA5C2635416)                
            if firstperson ~= true then
                weapon, weponhash = GetCurrentPedWeapon(PlayerPed, true)
                isBow = GetHashKey("WEAPON_BOW")
                if weponhash ~= isBow then                
                    Citizen.InvokeNative(0x4CC5F2FC1332577F, 0xBB47198C)
                 
                end
            end
        else
            Citizen.InvokeNative(0x4CC5F2FC1332577F, 0xBB47198C)
        end
    end
end)