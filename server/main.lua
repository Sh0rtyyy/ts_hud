local resetStress = false
local Config = lib.load('config')
ESX = exports["es_extended"]:getSharedObject()

AddEventHandler('ox_inventory:openedInventory', function(source)
    TriggerClientEvent('ts_hud:client:hideHUD', source)
end)

AddEventHandler('ox_inventory:closedInventory', function(source)
    TriggerClientEvent('ts_hud:client:showHud', source)
end)

RegisterNetEvent('hud:server:GainStress', function(amount)
    if not Config.stress.enableStress then return end

    local src = source
    local player = ESX.GetPlayerFromId(src)
    local newStress
    if not player then return end
    if not resetStress then
        if not Player.get('stress') then
            Player.set('stress', 0)
        end
        newStress = Player.get('stress') + amount
        if newStress <= 0 then newStress = 0 end
    else
        newStress = 0
    end
    if newStress > 100 then
        newStress = 100
    end
    Player.set('stress', newStress)
    TriggerClientEvent('hud:client:UpdateStress', src, newStress)
    TriggerClientEvent('ox_lib:notify', src, {
        description = 'Feeling More Stressed!',
        type = 'error',
    })
end)

RegisterNetEvent('hud:server:RelieveStress', function(amount)
    if not Config.stress.enableStress then return end

    local src = source
    local player = ESX.GetPlayerFromId(src)
    local newStress
    if not player then return end
    if not resetStress then
        if not Player.get('stress') then
            Player.set('stress', 0)
        end
        newStress = Player.get('stress') - amount
        if newStress <= 0 then newStress = 0 end
    else
        newStress = 0
    end
    if newStress > 100 then
        newStress = 100
    end
    Player.set('stress', newStress)
    TriggerClientEvent('hud:client:UpdateStress', src, newStress)
    TriggerClientEvent('ox_lib:notify', src, {
        description = 'Feeling Less Stressed!',
        type = 'success',
    })
end)