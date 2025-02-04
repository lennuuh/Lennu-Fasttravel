RegisterNetEvent('money')
AddEventHandler('money', function(itemName, count)
    local playerId = source
    local Player

    if Config.Framework == 'qbx' then
        Player = exports.qbx_core:GetPlayer(playerId)
    elseif Config.Framework == 'qbcore' then
        Player = QBCore.Functions.GetPlayer(playerId)
    elseif Config.Framework == 'esx' then
        Player = ESX.GetPlayerFromId(playerId)
    else
        return
    end

    if Player then
        local success, response = exports.ox_inventory:RemoveItem(playerId, itemName, count)
    end
end)

RegisterServerEvent('getmoney')
AddEventHandler('getmoney', function()
    local src = source
    local money = 0

    local items = exports.ox_inventory:GetItem(src, 'money', nil, true)

    if items then
        money = items
    end

    TriggerClientEvent('getmoney', src, money)
end)
