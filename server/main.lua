RegisterNetEvent('mh-exhaustflames:server:SyncFlames', function(data)
    if DoesEntityExist(NetworkGetEntityFromNetworkId(data.netid)) then
        if data.handle == "on" then
            Entity(NetworkGetEntityFromNetworkId(data.netid)).state.flames = true
        elseif data.handle == "off" then
            Entity(NetworkGetEntityFromNetworkId(data.netid)).state.flames = false
        end
    else
        print("vehicle entity not found....")
    end
end)
