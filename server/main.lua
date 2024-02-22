RegisterServerEvent("mh-exhaustflame:server:SyncFlames")
AddEventHandler("mh-exhaustflame:server:SyncFlames", function(netId)
    TriggerClientEvent('mh-exhaustflame:client:SyncFlames', -1, netId)
end)

RegisterServerEvent("mh-exhaustflame:server:StopSync")
AddEventHandler("mh-exhaustflame:server:StopSync", function(netId)
    TriggerClientEvent('mh-exhaustflame:client:StopSync', -1, netId)
end)