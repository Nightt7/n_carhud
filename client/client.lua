local isUsed = false

RegisterNetEvent("interface:carhud:show")
RegisterNetEvent("interface:carhud:hide")

AddEventHandler("interface:carhud:show", function(interface)
    SendNUIMessage({
        type = "carhud:show",
        velocity = interface.velocity,
        fuel = interface.fuel,
    })
end)

AddEventHandler("interface:carhud:hide", function()
    SendNUIMessage({
        type = "carhud:hide",
    })
end)

CreateThread(function()
    while true do
        isUsed = false
        if (IsPedInAnyVehicle(PlayerPedId())) then
            isUsed = true
            TriggerEvent("interface:carhud:show", {
                velocity = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId()))*3.6,
                fuel     = GetVehicleFuelLevel(GetVehiclePedIsIn(PlayerPedId())),
            })
        else
            TriggerEvent("interface:carhud:hide")
            SetTimeout(1000, function()
                isUsed = false
            end)
        end
        if isUsed then
            Wait(150)
        else
            Wait(1000)
        end
    end
end)